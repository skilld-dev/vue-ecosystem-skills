// Check every Skill against the rules the generator is told to follow.
//
// It reads the repository only. Run it in CI on every change to a Skill.
import { readdir, readFile, stat } from 'node:fs/promises'
import { dirname, join, relative, resolve } from 'node:path'
import { argv, exit, stdout } from 'node:process'
import { fileURLToPath, pathToFileURL } from 'node:url'
import { parseSpec, skillName } from './naming.mjs'

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), '..')
const skillsDir = join(repoRoot, 'skills')

/** The generator caps references at eight, one topic each. */
const MAX_REFERENCE_FILES = 8
const MAX_SKILL_LINES = 500
const SKILL_NAME = /^[a-z0-9]+(?:-[a-z0-9]+)*$/

function parseFrontmatter(source) {
  const match = /^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/.exec(source)
  if (match === null)
    return null
  const keys = [...match[1].matchAll(/^([A-Z_][\w-]*):/gim)].map(entry => entry[1])
  const name = /^name:[^\S\n]*(\S.*)$/m.exec(match[1])?.[1].trim()
  const description = /^description:[^\S\n]*(\S.*)$/m.exec(match[1])?.[1].trim()
  return { keys, name, description, body: match[2] }
}

async function listFiles(dir) {
  const entries = await readdir(dir, { withFileTypes: true, recursive: true })
  return entries
    .filter(entry => entry.isFile())
    .map(entry => relative(dir, join(entry.parentPath, entry.name)))
}

/** Check one Skill directory. Returns a list of problems, empty when it passes. */
export async function checkSkill(dir, name) {
  const problems = []
  const skillPath = join(dir, 'SKILL.md')
  const source = await readFile(skillPath, 'utf8').catch(() => null)
  if (source === null)
    return [`${name}: SKILL.md is missing.`]

  const frontmatter = parseFrontmatter(source)
  if (frontmatter === null)
    return [`${name}: SKILL.md has no frontmatter.`]

  if (frontmatter.name !== name)
    problems.push(`${name}: frontmatter name is "${frontmatter.name}".`)
  if (!SKILL_NAME.test(name))
    problems.push(`${name}: directory name is not lowercase words joined by single hyphens.`)
  if (frontmatter.description === undefined || frontmatter.description.length === 0)
    problems.push(`${name}: frontmatter has no description.`)
  if (frontmatter.description !== undefined && frontmatter.description.length > 1024)
    problems.push(`${name}: description is longer than 1024 characters.`)

  const extraKeys = frontmatter.keys.filter(key => key !== 'name' && key !== 'description')
  if (extraKeys.length > 0)
    problems.push(`${name}: frontmatter carries ${extraKeys.join(', ')}. Only name and description are allowed.`)

  const lines = source.split('\n').length
  if (lines > MAX_SKILL_LINES)
    problems.push(`${name}: SKILL.md is ${lines} lines. The limit is ${MAX_SKILL_LINES}.`)

  const referenceDir = join(dir, 'references')
  const hasReferences = await stat(referenceDir).then(entry => entry.isDirectory(), () => false)
  if (!hasReferences)
    return problems

  const references = await listFiles(referenceDir)
  if (references.length > MAX_REFERENCE_FILES)
    problems.push(`${name}: ${references.length} reference files. The limit is ${MAX_REFERENCE_FILES}.`)
  for (const reference of references) {
    if (!source.includes(`references/${reference}`))
      problems.push(`${name}: references/${reference} is not linked from SKILL.md.`)
  }
  return problems
}

/** Check that the package list, the lockfile, and the Skill directories agree. */
export function checkCoverage(specs, lock, directories, skillName) {
  const problems = []
  for (const spec of specs) {
    const name = skillName(spec)
    if (!directories.includes(name))
      problems.push(`${spec}: no Skill directory named ${name}.`)
    if (lock[spec] === undefined)
      problems.push(`${spec}: no lockfile record.`)
  }
  for (const spec of Object.keys(lock)) {
    if (!specs.includes(spec))
      problems.push(`${spec}: in the lockfile but not in packages.json.`)
  }
  return problems
}

async function main() {
  const specs = JSON.parse(await readFile(join(repoRoot, 'packages.json'), 'utf8'))
  const lock = JSON.parse(await readFile(join(repoRoot, 'skills-lock.json'), 'utf8'))
  const directories = (await readdir(skillsDir, { withFileTypes: true }))
    .filter(entry => entry.isDirectory())
    .map(entry => entry.name)

  const problems = checkCoverage(
    specs,
    lock,
    directories,
    spec => skillName(parseSpec(spec).value.name),
  )
  for (const name of directories)
    problems.push(...await checkSkill(join(skillsDir, name), name))

  for (const problem of problems)
    stdout.write(`${problem}\n`)

  if (problems.length > 0) {
    stdout.write(`\n${problems.length} problems in ${directories.length} Skills.\n`)
    return 1
  }
  stdout.write(`${directories.length} Skills pass.\n`)
  return 0
}

if (argv[1] !== undefined && import.meta.url === pathToFileURL(argv[1]).href)
  exit(await main())
