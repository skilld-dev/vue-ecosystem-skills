import assert from 'node:assert/strict'
import { mkdir, mkdtemp, readFile, rm, writeFile } from 'node:fs/promises'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import { test } from 'node:test'
import { parseDocument } from 'yaml'
import { applyCollectionLicense } from './collection-metadata.ts'
import { runOne } from './sync.mjs'

const body = '\n\n# Example\n\n```yaml\nlicense: Apache-2.0\n```\n'

test('adds the collection license when generation omits it', () => {
  const source = `---\nname: example\ndescription: Use example.\n---${body}`
  const result = applyCollectionLicense(source, 'MIT')
  assert.equal(result._tag, 'Ok')
  if (result._tag !== 'Ok')
    throw new Error(result.message)
  const fields = parseDocument(result.content.match(/^---\n([\s\S]*?)\n---/)![1]).toJS()
  assert.equal(fields.license, 'MIT')
  assert.equal(result.content.slice(result.content.indexOf('\n---') + 4), body)
})

test('replaces an upstream package license without changing other Skill values', () => {
  const source = `---\nname: example\ndescription: 'Use example: public API.'\nlicense: Apache-2.0\nmetadata:\n  version: "1.2"\ncompatibility: Requires Node.js.\nallowed-tools: Read\n---${body}`
  const result = applyCollectionLicense(source, 'MIT')
  assert.equal(result._tag, 'Ok')
  if (result._tag !== 'Ok')
    throw new Error(result.message)
  const fields = parseDocument(result.content.match(/^---\n([\s\S]*?)\n---/)![1]).toJS()
  assert.deepEqual(fields, {
    name: 'example',
    description: 'Use example: public API.',
    license: 'MIT',
    metadata: { version: '1.2' },
    compatibility: 'Requires Node.js.',
    'allowed-tools': 'Read',
  })
  assert.equal(result.content.slice(result.content.indexOf('\n---') + 4), body)
})

test('rejects invalid generated frontmatter instead of reporting a successful sync', () => {
  for (const source of ['# Missing frontmatter', '---\nlicense: MIT\nlicense: Apache-2.0\n---\nBody', '---\n- example\n---\nBody'])
    assert.equal(applyCollectionLicense(source, 'MIT')._tag, 'Err')
})

test('sync writes the collection license onto generated Skill output', async () => {
  const rootDir = await mkdtemp(join(tmpdir(), 'skill-collection-sync-'))
  const generated = `---\nname: example-skilld\ndescription: Use example.\n---${body}`
  const harness = {
    async run({ destination }: { destination: { rootDir: string, name: string } }) {
      await mkdir(join(destination.rootDir, destination.name))
      await writeFile(join(destination.rootDir, destination.name, 'SKILL.md'), generated)
      return { _tag: 'Ok', value: { files: ['SKILL.md'] } }
    },
  }
  try {
    const result = await runOne(harness, { name: 'example', published: '1.0.0' }, { rootDir, license: 'MIT' })
    assert.equal(result._tag, 'Ok')
    const written = await readFile(join(rootDir, 'example-skilld', 'SKILL.md'), 'utf8')
    const fields = parseDocument(written.match(/^---\n([\s\S]*?)\n---/)![1]).toJS()
    assert.equal(fields.license, 'MIT')
    assert.equal(written.slice(written.indexOf('\n---') + 4), body)
  }
  finally {
    await rm(rootDir, { recursive: true })
  }
})
