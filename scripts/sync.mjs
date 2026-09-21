// Keep every maintained Skill current with the package it describes.
//
// One Skill is regenerated when its package publishes a new version, or when
// the lockfile has no record of it. Everything else is left alone.
import { readFile, writeFile } from 'node:fs/promises'
import { homedir } from 'node:os'
import { dirname, join, resolve } from 'node:path'
import { argv, env, exit, stdout } from 'node:process'
import { fileURLToPath, pathToFileURL } from 'node:url'
import { createOpenCode } from '@ai-sdk/harness-opencode'
import { createSkillHarness } from 'skilld-harness'
import { createLocalSandbox } from 'skilld-harness/sandbox-local'

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const packagesFile = join(repoRoot, 'packages.json')
const lockFile = join(repoRoot, 'skills-lock.json')
const skillsDir = join(repoRoot, 'skills')

const DEFAULT_MODEL = 'opencode-go/glm-5.3-flash'
const DEFAULT_CONCURRENCY = 3

// The Harness defaults suit a first draft. A Skill here carries a reference
// tree of scraped docs and release notes, so it needs a wider allowance.
const OUTPUT_POLICY = {
  maxOutputFiles: 512,
  maxOutputBytes: 32 * 1024 * 1024,
}

function ok(value) {
  return { _tag: 'Ok', value }
}

function err(error) {
  return { _tag: 'Err', error }
}

/**
 * Split a package specifier into its name and its npm dist-tag.
 * `vue@beta` names the `beta` tag. `@vueuse/core` names the `latest` tag.
 */
export function parseSpec(spec) {
  const match = /^(@[^/]+\/[^@]+|[^@]+)(?:@(.+))?$/.exec(spec)
  if (match === null)
    return err({ _tag: 'InvalidSpec', spec })
  return ok({ name: match[1], tag: match[2] ?? 'latest' })
}

/**
 * Derive the Skill directory name for a package.
 * It matches the names the Repository already uses.
 */
export function skillName(packageName) {
  const slug = packageName
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+/, '')
    .replace(/-+$/, '')
  return `${slug}-skilld`
}

async function readJson(path, fallback) {
  const source = await readFile(path, 'utf8').catch((cause) => {
    if (cause.code === 'ENOENT')
      return null
    throw cause
  })
  return source === null ? fallback : JSON.parse(source)
}

async function writeJson(path, value) {
  await writeFile(path, `${JSON.stringify(value, null, 2)}\n`)
}

/** Read the published version of one dist-tag from the npm registry. */
async function publishedVersion(fetchClient, name, tag) {
  const url = `https://registry.npmjs.org/${name.replace('/', '%2F')}`
  const response = await fetchClient(url, { headers: { accept: 'application/json' } })
  if (!response.ok)
    return err({ _tag: 'RegistryUnavailable', name, status: response.status })
  const packument = await response.json()
  const version = packument['dist-tags']?.[tag]
  if (typeof version !== 'string')
    return err({ _tag: 'TagMissing', name, tag })
  return ok(version)
}

/** Decide what the sync must do for one package. */
export function planEntry({ spec, name, tag, published, locked, force }) {
  if (force)
    return { _tag: 'Regenerate', spec, name, tag, published, reason: 'forced' }
  if (locked === undefined)
    return { _tag: 'Regenerate', spec, name, tag, published, reason: 'no lockfile record' }
  if (locked.version !== published)
    return { _tag: 'Regenerate', spec, name, tag, published, reason: `${locked.version} to ${published}` }
  return { _tag: 'Current', spec, name, tag, published }
}

function openCodeHarness(model) {
  return createOpenCode({
    provider: 'opencode-go',
    openCodeConfig: { agent: { general: { model } } },
  })
}

async function resolveApiKey() {
  if (typeof env.OPENCODE_API_KEY === 'string' && env.OPENCODE_API_KEY.length > 0)
    return ok(env.OPENCODE_API_KEY)
  const auth = await readJson(join(homedir(), '.local/share/opencode/auth.json'), null)
  const key = auth?.['opencode-go']?.key
  if (typeof key !== 'string')
    return err({ _tag: 'NoCredential' })
  return ok(key)
}

async function runOne(skillHarness, entry) {
  const started = Date.now()
  const result = await skillHarness.run({
    _tag: 'PackageSkill',
    source: { _tag: 'NpmPackage', spec: `${entry.name}@${entry.published}` },
    destination: { rootDir: skillsDir, name: skillName(entry.name) },
  })
  const seconds = Math.round((Date.now() - started) / 1000)
  if (result._tag === 'Err')
    return err({ _tag: 'RunFailed', entry, seconds, cause: result.error })
  return ok({ entry, seconds, files: result.value.files.length })
}

/** Run tasks with a fixed number of workers, preserving input order. */
async function pool(items, limit, worker) {
  const results = Array.from({ length: items.length })
  let next = 0
  const runners = Array.from({ length: Math.min(limit, items.length) }, async () => {
    while (next < items.length) {
      const index = next++
      results[index] = await worker(items[index])
    }
  })
  await Promise.all(runners)
  return results
}

function parseArguments(values) {
  const flags = new Set(values.filter(value => value.startsWith('--')))
  const named = values.filter(value => !value.startsWith('--'))
  const model = values.find(value => value.startsWith('--model='))?.slice('--model='.length)
  const concurrency = values.find(value => value.startsWith('--concurrency='))?.slice('--concurrency='.length)
  return {
    check: flags.has('--check'),
    force: flags.has('--force'),
    only: named,
    model: model ?? env.SKILLD_MODEL ?? DEFAULT_MODEL,
    concurrency: Number(concurrency ?? env.SKILLD_CONCURRENCY ?? DEFAULT_CONCURRENCY),
  }
}

async function main() {
  const options = parseArguments(argv.slice(2))
  const specs = await readJson(packagesFile, null)
  if (!Array.isArray(specs)) {
    stdout.write(`Read ${packagesFile} first. It must hold an array of package specifiers.\n`)
    return 1
  }

  const lock = await readJson(lockFile, {})
  const selected = options.only.length > 0 ? options.only : specs
  const fetchClient = globalThis.fetch.bind(globalThis)

  stdout.write(`Checking ${selected.length} packages against the npm registry.\n`)

  const plans = []
  const failures = []
  for (const spec of selected) {
    const parsed = parseSpec(spec)
    if (parsed._tag === 'Err') {
      failures.push(parsed.error)
      continue
    }
    const { name, tag } = parsed.value
    const published = await publishedVersion(fetchClient, name, tag)
    if (published._tag === 'Err') {
      failures.push(published.error)
      continue
    }
    plans.push(planEntry({
      spec,
      name,
      tag,
      published: published.value,
      locked: lock[spec],
      force: options.force || options.only.length > 0,
    }))
  }

  const stale = plans.filter(plan => plan._tag === 'Regenerate')
  for (const plan of stale)
    stdout.write(`  ${plan.spec} ${plan.published} (${plan.reason})\n`)
  stdout.write(`${stale.length} of ${plans.length} need a rebuild.\n`)

  if (options.check)
    return failures.length > 0 ? 1 : 0
  if (stale.length === 0)
    return failures.length > 0 ? 1 : 0

  const apiKey = await resolveApiKey()
  if (apiKey._tag === 'Err') {
    stdout.write('Set OPENCODE_API_KEY, or sign in with `opencode auth login`.\n')
    return 1
  }
  env.OPENCODE_API_KEY = apiKey.value

  stdout.write(`Rebuilding with ${options.model}, ${options.concurrency} at a time.\n`)

  const skillHarness = createSkillHarness({
    harness: openCodeHarness(options.model),
    sandbox: createLocalSandbox(),
    outputPolicy: OUTPUT_POLICY,
  })

  const results = await pool(stale, options.concurrency, async (entry) => {
    const result = await runOne(skillHarness, entry)
    if (result._tag === 'Err')
      stdout.write(`  failed ${entry.spec} after ${result.error.seconds}s: ${result.error.cause.message}\n`)
    else
      stdout.write(`  built ${entry.spec} in ${result.value.seconds}s, ${result.value.files} files\n`)
    return result
  })

  const built = results.filter(result => result._tag === 'Ok')
  for (const result of built)
    lock[result.value.entry.spec] = { version: result.value.entry.published, generatedAt: new Date().toISOString().slice(0, 10) }
  await writeJson(lockFile, Object.fromEntries(Object.entries(lock).sort(([a], [b]) => a.localeCompare(b))))

  stdout.write(`Built ${built.length} of ${stale.length}.\n`)
  return built.length === stale.length && failures.length === 0 ? 0 : 1
}

// Importing this file exposes its helpers without starting a sync.
if (argv[1] !== undefined && import.meta.url === pathToFileURL(argv[1]).href)
  exit(await main())
