export type CollectionSkillResult
  = | { readonly _tag: 'Ok', readonly content: string }
    | { readonly _tag: 'Err', readonly message: string }

export function applyCollectionLicense(content: string, license: string): CollectionSkillResult {
  const match = content.match(/^---\r?\n([\s\S]*?)\r?\n---(?=\r?\n|$)/)
  if (!match)
    return { _tag: 'Err', message: 'Generated Skill must start with YAML frontmatter.' }
  if (license.trim().length === 0)
    return { _tag: 'Err', message: 'The collection must declare a license.' }
  const document = parseDocument(match[1], { uniqueKeys: true })
  const issue = [...document.errors, ...document.warnings][0]
  if (issue)
    return { _tag: 'Err', message: `Generated Skill has invalid YAML: ${issue.message}` }
  if (!isMap(document.contents))
    return { _tag: 'Err', message: 'Generated Skill frontmatter must be a mapping.' }
  document.set('license', license)
  return { _tag: 'Ok', content: `---\n${document.toString()}---${content.slice(match[0].length)}` }
}
import { isMap, parseDocument } from 'yaml'

