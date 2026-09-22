---
name: vitepress-skilld
description: Use when writing, configuring, or debugging code that imports "vitepress", when running vitepress CLI commands, editing .vitepress/config or theme files, tuning markdown or default theme options, or migrating a VitePress site. Provides the vitepress@1.6.4 API surface, config reference, theme reference, CLI usage, and v1 migration notes.
---

# vitepress@1.6.4

Vite & Vue powered static site generator (vuejs/vitepress). Source of truth in
this Skill is the prepared package source; line citations are relative to the
package root (for example `dist/node/index.d.ts:2382`).

## Version facts

- Version 1.6.4, MIT (`package.json:3`).
- Bundles Vue `^3.5.13`, Vite `^5.4.14`, shiki `^2.1.0`, minisearch `^7` (`package.json:59-78`).
- Requires Node.js 18+ (https://vitepress.dev/guide/getting-started).
- VitePress v1 is not compatible with `rolldown-vite`; the dev server prints an
  error and directs to VitePress v2 (`dist/node/cli.js:438-444`).
- Optional peers: `markdown-it-mathjax3` (for `markdown.math`), `postcss` (`package.json:155-166`).

## Entry points

Defined by the export map in `package.json:18-37`:

| Import                       | Types entry              | Use for                                        |
| ---------------------------- | ------------------------ | ---------------------------------------------- |
| `vitepress`                  | `types/index.d.ts`       | Node + client + shared API, config helpers     |
| `vitepress/client`           | `client.d.ts`            | Client composables (`useData`, `useRouter`, …) |
| `vitepress/theme`            | `theme.d.ts`             | Default theme, `useSidebar`, `useLocalNav`     |
| `vitepress/theme-without-fonts` | `theme-without-fonts.d.ts` | Default theme without bundled font files    |

CLI binary: `vitepress` → `bin/vitepress.js`.

## Setup and commands

```sh
npm add -D vitepress
npx vitepress init
npx vitepress dev
npx vitepress build
npx vitepress preview
```

`dev` may be omitted when using the current directory (`vitepress` alone).
`serve` is an alias of `preview`. Full flags and dev shortcuts:
[cli.md](./references/cli.md)

## Common tasks

### Site config (`.vitepress/config.ts`)

```ts
import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'My App',
  description: 'A VitePress site',
  themeConfig: {
    nav: [{ text: 'Guide', link: '/guide/' }],
    sidebar: [{ text: 'Guide', items: [{ text: 'Intro', link: '/guide/intro' }] }]
  }
})
```

`defineConfig` is typed for the default theme; use
`defineConfigWithTheme<CustomThemeConfig>` for a custom theme
(`dist/node/index.d.ts:2382-2386`). Every option:
[site-config.md](./references/site-config.md)

### Client runtime API

```vue
<script setup>
import { useData, useRouter, withBase } from 'vitepress'
const { page, frontmatter, isDark, hash } = useData()
const router = useRouter()
</script>
```

Full export list and signatures: [api.md](./references/api.md)

### Build-time data loading

```ts
// posts.data.js
import { createContentLoader } from 'vitepress'
export default createContentLoader('posts/*.md', { excerpt: true })
```

Import as `import { data } from './posts.data.js'`. Runs in Node only; the
result ships as JSON in the client bundle.

### Browser-only components

```vue
<script setup>
import { defineClientComponent } from 'vitepress'
const Chart = defineClientComponent(() => import('./Chart.vue'))
</script>
```

Prevents SSG build failures when a library touches `window`/`document` on
import (https://vitepress.dev/guide/ssr-compat).

## Best practices

- Use `createContentLoader` for archive and index pages instead of hand-rolled
  loaders; it caches by file mtime and keeps the client JSON small
  (`dist/node/index.d.ts:2466-2473`, https://vitepress.dev/guide/data-loading).
- Wrap browser-only components with `defineClientComponent`
  (https://vitepress.dev/guide/ssr-compat).
- Keep image and asset URLs relative in Markdown so Vite hashes and inlines
  them; use `withBase()` for dynamic paths in theme components
  (https://vitepress.dev/guide/asset-handling).
- Enable `cleanUrls: true` only when the host can map `/foo` to `/foo.html`
  (https://vitepress.dev/guide/routing#clean-urls).
- With `rewrites`, relative links must target the rewritten URL structure, not
  the source file structure
  (https://vitepress.dev/guide/routing#route-rewrites).
- In dynamic route `paths.js` loaders, pass large payloads via `content`, not
  `params`, to keep client JS small
  (https://vitepress.dev/guide/routing#dynamic-routes).
- In MPA mode (`mpa: true`), use `<script client>` for interactivity; plain
  `<script setup>` is server-side templating only
  (https://vitepress.dev/guide/mpa-mode).
- Exclude pages from local search with the `_render` hook
  (`types/default-theme.d.ts:451-455`).

## Deeper references

- [api.md](./references/api.md): every export from `vitepress`,
  `vitepress/client`, `vitepress/theme`, data loader types, theme interface.
- [site-config.md](./references/site-config.md): `UserConfig` fields, build
  hooks, `SiteConfig`, `mergeConfig`.
- [default-theme.md](./references/default-theme.md): `DefaultTheme.Config`,
  nav, sidebar, search (local and algolia), theme extension.
- [markdown.md](./references/markdown.md): `markdown` options, shiki setup,
  containers, math, `createMarkdownRenderer`.
- [cli.md](./references/cli.md): commands, flags, dev shortcuts, scaffolding.
- [migration.md](./references/migration.md): v0 → v1 breaking changes and
  deprecations still visible in 1.6.4.

## Version-specific changes

Prioritize these when touching old configs; details and citations in
[migration.md](./references/migration.md):

- BREAKING (v1.0.0-rc.9): `pathname://` protocol removed; use
  `target="_self"` or `target="_blank"`
  (https://github.com/vuejs/vitepress/blob/main/CHANGELOG.md).
- BREAKING (v1.0.0): sidebar `children` renamed to `items`; top-level items no
  longer accept `link`
  (https://vitepress.dev/guide/migration-from-vitepress-0).
- BREAKING (v1.0.0-alpha.44): `collapsible` replaced by `collapsed: boolean`
  (CHANGELOG).
- BREAKING (v1.0.0-alpha.57): `markdown.headers` disabled by default;
  `PageData.headers` is empty unless enabled (CHANGELOG).
- When `markdown.headers` is enabled, extraction levels default to `[2, 3]`
  (`dist/node/index.d.ts:1769-1786`).
- NEW (v1.1.0): `useData().hash` reactive URL hash
  (`dist/client/index.d.ts:79-83`).
- NEW (v1.4.0): `onAfterPageLoad` router hook
  (`dist/client/index.d.ts:36-38`).
- NEW (v1.3.0): `appearance: 'force-auto'`
  (`types/shared.d.ts:119-124`).
- Deprecated in 1.6.4: `Theme.setup`, `Theme.NotFound`
  (`dist/client/index.d.ts:96-103`), `outlineTitle`, `lastUpdatedText`,
  `algolia` theme options (`types/default-theme.d.ts:36-77,139-141`).
