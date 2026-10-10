import assert from 'node:assert/strict'
import { mkdtemp, rm, writeFile } from 'node:fs/promises'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import { test } from 'node:test'
import { checkSkill } from './validate.mjs'

async function check(extra: string, name = 'example', description = 'Use example for its public API.'): Promise<string[]> {
  const dir = await mkdtemp(join(tmpdir(), 'skill-metadata-'))
  await writeFile(join(dir, 'SKILL.md'), `---\nname: ${name}\ndescription: ${description}\n${extra}---\n\n# Example\n`)
  const problems = await checkSkill(dir, name)
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
  assert.deepEqual(await check('unsupported: true\n'), ['example: frontmatter carries unsupported. Only Agent Skills specification fields are allowed.'])
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

test('accepts metadata, tool requirements, and multiline YAML strings', async () => {
  assert.deepEqual(await check('metadata:\n  author: example\n  version: "1.0"\nallowed-tools: Read Bash(git:*)\ncompatibility: >-\n  Requires Node.js\n  and shell access.\n'), [])
})

test('rejects malformed YAML, duplicate keys, and invalid value types', async () => {
  for (const extra of ['compatibility: [broken\n', 'license: MIT\nlicense: Apache-2.0\n']) {
    const problems = await check(extra)
    assert.equal(problems.some(problem => problem.startsWith('example: invalid YAML:')), true)
  }
  for (const extra of ['metadata: []\n', 'metadata:\n  version: 1\n', 'metadata:\n  1: example\n'])
    assert.deepEqual(await check(extra), ['example: metadata must map string keys to string values.'])
  assert.deepEqual(await check('allowed-tools: [Read]\n'), ['example: allowed-tools must be a string.'])
  assert.deepEqual(await check('license: 42\n'), ['example: license must not be empty.'])
  assert.deepEqual(await check('compatibility: true\n'), ['example: compatibility must contain 1 to 500 characters.'])
})

test('counts decoded Unicode characters and the complete multiline value', async () => {
  assert.deepEqual(await check(`compatibility: "${'😀'.repeat(500)}"\n`), [])
  assert.deepEqual(await check(`compatibility: >-\n  ${'x'.repeat(250)}\n  ${'x'.repeat(250)}\n`), ['example: compatibility must contain 1 to 500 characters.'])
})

test('enforces name and decoded description limits', async () => {
  const name = 'x'.repeat(65)
  assert.deepEqual(await check('', name), [`${name}: name is longer than 64 characters.`])
  assert.deepEqual(await check('', 'example', JSON.stringify('x'.repeat(1024))), [])
  assert.deepEqual(await check('', 'example', JSON.stringify('x'.repeat(1025))), ['example: description is longer than 1024 characters.'])
  assert.deepEqual(await check('', 'example', '42'), ['example: frontmatter has no description.'])
})
