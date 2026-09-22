// Names shared by the sync and the validator. No dependencies, so the
// validator runs without an install.

/**
 * Split a package specifier into its name and its npm dist-tag.
 * `vue@beta` names the `beta` tag. `@vueuse/core` names the `latest` tag.
 */
export function parseSpec(spec) {
  const match = /^(@[^/]+\/[^@]+|[^@]+)(?:@(.+))?$/.exec(spec)
  if (match === null)
    return { _tag: 'Err', error: { _tag: 'InvalidSpec', spec } }
  return { _tag: 'Ok', value: { name: match[1], tag: match[2] ?? 'latest' } }
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
