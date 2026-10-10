import assert from 'node:assert/strict'
import { mkdtemp, rm, writeFile } from 'node:fs/promises'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import { test } from 'node:test'
import { checkSkill } from './validate.mjs'

async function check(extra: string): Promise<string[]> {
  const dir = await mkdtemp(join(tmpdir(), 'skill-metadata-'))
  await writeFile(join(dir, 'SKILL.md'), `---\nname: example\ndescription: Use example for its public API.\n${extra}---\n\n# Example\n`)
  const problems = await checkSkill(dir, 'example')
  await rm(dir, { recursive: true })
  return problems
}

test('accepts license and environment requirements', async () => {
  assert.deepEqual(await check('license: MIT\ncompatibility: Requires Vue 3.\n'), [])
})

test('accepts compatibility at the 500 character limit', async () => {
  assert.deepEqual(await check(`compatibility: ${'x'.repeat(500)}\n`), [])
  assert.deepEqual(await check(`compatibility: "${'x'.repeat(500)}"\n`), [])
})

test('rejects unsupported fields', async () => {
  assert.deepEqual(await check('unsupported: true\n'), ['example: frontmatter carries unsupported. Only name, description, license, and compatibility are allowed.'])
})

test('rejects empty optional fields', async () => {
  assert.deepEqual(await check('license:\ncompatibility:\n'), [
    'example: license must not be empty.',
    'example: compatibility must contain 1 to 500 characters.',
  ])
  assert.deepEqual(await check('license: " "\ncompatibility: " "\n'), [
    'example: license must not be empty.',
    'example: compatibility must contain 1 to 500 characters.',
  ])
})

test('rejects oversized compatibility', async () => {
  assert.deepEqual(await check(`compatibility: ${'x'.repeat(501)}\n`), ['example: compatibility must contain 1 to 500 characters.'])
})
