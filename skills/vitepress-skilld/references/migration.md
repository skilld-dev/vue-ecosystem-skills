# Migration and version notes

Version-specific changes affecting vitepress@1.6.4. Sources: the official
changelog at https://github.com/vuejs/vitepress/blob/main/CHANGELOG.md and
the migration guide at https://vitepress.dev/guide/migration-from-vitepress-0.

## Breaking changes in v1.0.0 (from 0.x)

- `pathname://` link protocol dropped (1.0.0-rc.9). Use `target="_self"` or
  `target="_blank"` on the link instead.
- Sidebar items: `children` renamed to `items`; top-level sidebar items no
  longer accept `link`.
- `collapsible` replaced by `collapsed` (1.0.0-alpha.44). `collapsed: true`
  implies collapsible and starts collapsed; `false` implies collapsible and
  starts expanded.
- `markdown.headers` disabled by default (1.0.0-alpha.57); `PageData.headers`
  stays empty unless enabled.
- `shikijiSetup` renamed to `shikiSetup` (1.0.0-rc.41) after the move from
  shikiji back to shiki. In 1.6.4 the option is `shikiSetup`
  (`dist/node/index.d.ts:2101`).
- VuePress migrations: https://vitepress.dev/guide/migration-from-vuepress.

## Additions after 1.0.0 visible in 1.6.4

| Feature | Version | Evidence |
| --- | --- | --- |
| `useData().hash` reactive URL hash | 1.1.0 | `dist/client/index.d.ts:79-83` |
| `appearance: 'force-auto'` | 1.3.0 | `types/shared.d.ts:119-124` |
| `onAfterPageLoad` router hook | 1.4.0 | `dist/client/index.d.ts:36-38` |
| `onBeforePageLoad` router hook | 1.0.0-beta.4 | `dist/client/index.d.ts:31-34` |
| `onContentUpdated` fires on frontmatter-only changes | 1.4.0 | CHANGELOG |
| `mergeConfig` exported | 1.0.0-rc.25 | `dist/node/index.d.ts:2389` |
| `createContentLoader` | 1.0.0-alpha.53 | `dist/node/index.d.ts:2466` |
| `defineClientComponent` | 1.0.0-alpha.59 | `dist/client/index.d.ts:114` |
| `useSidebar` / `useLocalNav` | 1.0.0-beta.4 | `theme.d.ts:15-16` |
| On-demand social icons (experimental) | 1.5.0 | `types/shared.d.ts:148-152` (`SSGContext.vpSocialIcons`) |
| `metaChunk` (experimental) | 1.0.0-beta.6 | `dist/node/index.d.ts:2268-2271` |
| `rewrites` (experimental) | 1.0.0-alpha.41 | `dist/node/index.d.ts:2303-2306` |
| `sitemap` (experimental) | 1.0.0-beta.7 | `dist/node/index.d.ts:2308-2313` |
| `cleanUrls` stabilized | 1.0.0-alpha.41 | `dist/node/index.d.ts:2279-2283` |
| `PageData.filePath` | 1.0.0-alpha.75 | `types/shared.d.ts:10-14` |

## Deprecations to avoid in new code

| Deprecated | Replacement |
| --- | --- |
| `Theme.setup` | Wrap the layout component (`dist/client/index.d.ts:96-98`) |
| `Theme.NotFound` | Check `useData().page.value.isNotFound` in Layout (`dist/client/index.d.ts:100-102`) |
| `Router.onAfterRouteChanged` | `onAfterRouteChange` (`dist/client/index.d.ts:44-46`) |
| `themeConfig.outlineTitle` | `outline.label` (`types/default-theme.d.ts:36-43`) |
| `themeConfig.algolia` | `search: { provider: 'algolia', options }` (`types/default-theme.d.ts:139-141`) |
| `themeConfig.lastUpdatedText` | `lastUpdated.text` (`types/default-theme.d.ts:71-79`) |
| `LocalSearchOptions.disableDetailedView` | `detailedView: false` (`types/default-theme.d.ts:392-406`) |

## VitePress v2

The 1.6.4 CLI refuses to run with `rolldown-vite` and names VitePress v2 as
the replacement for that stack (`dist/node/cli.js:438-444`). Do not mix
vitepress v1 with rolldown-based Vite; either stay on Vite 5 with v1 or move
the project to vitepress v2. Track v2 via the
[releases page](https://github.com/vuejs/vitepress/releases); do not assume
v1 guidance transfers to v2 without checking its changelog.
