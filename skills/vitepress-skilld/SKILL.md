---
name: vitepress-skilld
description: "Vite & Vue powered static site generator. ALWAYS use when writing code importing \"vitepress\". Consult for debugging, best practices, or modifying vitepress."
metadata:
  version: 1.6.4
  generated_at: 2026-04-20
  references_synced_at: 2026-04-20
---

# vuejs/vitepress `vitepress@1.6.4`
**Tags:** latest: 1.6.4, next: 2.0.0-alpha.17

**References:** [Docs](./references/docs/_INDEX.md)
## API Changes

This section documents version-specific API changes — prioritize recent major/minor releases.

- BREAKING: `pathname://` — protocol dropped in v1.0.0-rc.9, use `target="_self"` or `target="_blank"` instead [source](./references/releases/CHANGELOG.md)

- BREAKING: `shikiSetup` — renamed from `shikijiSetup` in v1.0.0-rc.41 following the migration from `shikiji` back to `shiki` [source](./references/releases/CHANGELOG.md)

- BREAKING: `sidebar` items — `children` key was renamed to `items` in v1.0.0, and top-level items no longer support `link` [source](./references/docs/en/guide/migration-from-vitepress-0.md)

- BREAKING: `collapsed` — replaced `collapsible` sidebar option in v1.0.0-alpha.44; `collapsed: true` implies collapsible [source](./references/releases/CHANGELOG.md)

- BREAKING: `markdown.headers` — disabled by default since v1.0.0-alpha.57; `PageData` no longer includes headers unless explicitly enabled [source](./references/releases/CHANGELOG.md)

- NEW: `onAfterPageLoad` — router hook added in v1.4.0, triggered after the page is loaded and before it is rendered [source](./references/releases/CHANGELOG.md)

- NEW: `onBeforePageLoad` — router hook added in v1.0.0-beta.4, allows executing logic before a page load starts [source](./references/releases/CHANGELOG.md)

- NEW: `useData().hash` — new property in v1.1.0 that provides a reactive reference to the current URL hash [source](./references/releases/CHANGELOG.md)

- NEW: `useSidebar()` — exposed in v1.0.0-beta.4, provides access to sidebar state and logic in custom themes [source](./references/releases/CHANGELOG.md)

- NEW: `defineClientComponent()` — helper added in v1.0.0-alpha.59 for creating components that only render on the client [source](./references/releases/CHANGELOG.md)

- NEW: `onContentUpdated` — hook now triggers on frontmatter-only changes as of v1.4.0 [source](./references/releases/CHANGELOG.md)

- NEW: `createContentLoader()` — helper added in v1.0.0-alpha.53 to load content from markdown files with glob support [source](./references/releases/CHANGELOG.md)

- NEW: `mergeConfig()` — utility exported in v1.0.0-rc.25 to assist in merging VitePress configurations [source](./references/releases/CHANGELOG.md)

- NEW: `appearance: 'force-auto'` — new option added in v1.3.0 to force color scheme based on user system preference [source](./references/releases/CHANGELOG.md)

**Also changed:** `PageData.filePath` new alpha.75 · `Theme.extends` new alpha.50 · `Theme.setup` deprecated alpha.50 · `Theme.NotFound` deprecated alpha.50 · `on-demand social icons` experimental v1.5.0 · `externalLinkIcon` option new beta.4 · `cleanUrls` stable alpha.41 · `metaChunk` experimental beta.6 · `rewrites` experimental alpha.41 · `sitemap` experimental beta.7

## Best Practices

- Use `createContentLoader` for archives and indexes over manual data loading — automatically handles caching and minimizes client-side JSON weight [source](./references/docs/en/guide/data-loading.md)

```ts
import { createContentLoader } from 'vitepress'
export default createContentLoader('posts/*.md', { excerpt: true })
```

- Wrap browser-only components with `defineClientComponent` — prevents SSR/SSG build failures when libraries access `window` or `document` on import [source](./references/docs/en/guide/ssr-compat.md)

```vue
<script setup>
import { defineClientComponent } from 'vitepress'
const ClientOnlyComp = defineClientComponent(() => import('./BrowserComponent.vue'))
</script>
```

- Prefer relative URLs for images and assets in Markdown — enables Vite's hashing pipeline and automatic base64 inlining for small files [source](./references/docs/en/guide/asset-handling.md)

- Use the `withBase()` helper for dynamic paths in theme components — ensures assets resolve correctly regardless of the site's deployment `base` URL [source](./references/docs/en/guide/asset-handling.md)

- Enable `cleanUrls: true` only when server-side support is confirmed — prevents broken direct links on platforms that do not automatically map `/foo` to `/foo.html` [source](./references/docs/en/guide/routing.md)

- Target rewritten paths for relative links when using `rewrites` — links must resolve against the final URL structure, not the source directory structure [source](./references/docs/en/guide/routing.md)

- Pass large Markdown or HTML blocks via the `content` property in dynamic route loaders — prevents bloating the client-side JavaScript payload with serialized params [source](./references/docs/en/guide/routing.md)

```js
// [pkg].paths.js
export default {
  async paths() {
    return [{ params: { id: '1' }, content: '## Large Content' }]
  }
}
```

- Use `<script client>` for minimal interactivity in MPA mode — standard `<script setup>` in MPA mode is used for server-side templating only and lacks reactivity [source](./references/docs/en/guide/mpa-mode.md)

- Programmatically exclude pages from search via the `_render` hook — allows complex filtering logic based on file path or frontmatter during the indexing phase [source](./references/docs/en/reference/default-theme-search.md)

```ts
// .vitepress/config.ts
themeConfig: {
  search: {
    provider: 'local',
    options: {
      _render(src, env, md) {
        if (env.frontmatter?.search === false) return ''
        return md.render(src, env)
      }
    }
  }
}
```

- Employ `defineConfigWithTheme<DefaultTheme.Config>` for site configuration — provides full TypeScript inference and validation for both core and default theme settings [source](./references/releases/CHANGELOG.md)
