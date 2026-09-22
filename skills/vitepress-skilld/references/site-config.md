# Site config

`UserConfig` fields from `dist/node/index.d.ts:2218-2339`. Passed to
`defineConfig` (default theme) or `defineConfigWithTheme` (custom theme).

## Top-level options

| Option | Type / default | Notes |
| --- | --- | --- |
| `extends` | `RawConfigExports<ThemeConfig>` | Inherit another config file |
| `base` | `string` | Public base path, e.g. `/repo/` |
| `srcDir` | `string` | Source dir, default project root |
| `srcExclude` | `string[]` | Glob patterns to skip |
| `outDir` | `string` | Default `<root>/.vitepress/dist` |
| `assetsDir` | `string` | Assets dir inside `outDir` |
| `cacheDir` | `string` | Default `<root>/.vitepress/cache` |
| `shouldPreload` | `(link, page) => boolean` | Control link preloading |
| `locales` | `LocaleConfig<ThemeConfig>` | Per-locale overrides |
| `router.prefetchLinks` | `boolean` | Hover prefetching |
| `appearance` | `boolean \| 'dark' \| 'force-dark' \| 'force-auto' \| UseDarkOptions & { initialValue?: 'dark' }` | `'force-auto'` added in 1.3.0 (`dist/node/index.d.ts:2231-2233`) |
| `lastUpdated` | `boolean` | Requires git; updates on commit time |
| `contentProps` | `Record<string, any>` | Props passed to `<Content>` |
| `markdown` | `MarkdownOptions` | See [markdown.md](./markdown.md) |
| `vue` | `Options` from `@vitejs/plugin-vue` | |
| `vite` | `Vite UserConfig & { configFile?: string \| false }` | Vite passthrough |
| `scrollOffset` | `number \| string \| string[] \| { selector, padding }` | Sticky header offset |
| `mpa` | `boolean`, experimental | Zero-JS mode |
| `metaChunk` | `boolean`, experimental | Split page metadata into its own chunk |
| `ignoreDeadLinks` | `boolean \| 'localhostLinks' \| (string \| RegExp \| ((link) => boolean))[]` | Default `false` |
| `cleanUrls` | `boolean`, default `false` | Drop `.html`; needs server support |
| `useWebFonts` | `boolean` | Default `true` in webcontainers, else `false` |
| `buildConcurrency` | `number`, default `64`, experimental | Lower to trade speed for memory |
| `rewrites` | `Record<string, string> \| ((id) => string)`, experimental | Source → destination mapping |
| `sitemap` | `SitemapStreamOptions & { hostname: string; transformItems? }`, experimental | `hostname` required |

Locale-specific fields (`title`, `titleTemplate`, `description`, `head`,
`lang`, `dir`, `themeConfig`) can sit at top level or inside `locales`
(`types/shared.d.ts:154-167`).

## Build hooks

All optional, all awaited (`dist/node/index.d.ts:2315-2338`):

| Hook | Context | Runs |
| --- | --- | --- |
| `buildEnd(siteConfig)` | `SiteConfig` | After SSG finishes |
| `postRender(context)` | `SSGContext` | After SSR rendering |
| `transformHead(context)` | `TransformContext` | Before writing HTML to dist; return `HeadConfig[]` to append |
| `transformHtml(code, id, ctx)` | code, id, context | Before writing HTML to dist |
| `transformPageData(pageData, ctx)` | `PageData`, `TransformPageContext` | While rendering markdown to Vue |

`TransformContext` (`dist/node/index.d.ts:2186-2196`): `page`, `siteConfig`,
`siteData`, `pageData`, `title`, `description`, `head`, `content`, `assets`.

Generate files at build time (for example an RSS feed):

```ts
import { createContentLoader, defineConfig } from 'vitepress'

export default defineConfig({
  async buildEnd() {
    const posts = await createContentLoader('posts/*.md').load()
  }
})
```

## Resolved config

`resolveConfig()` returns `SiteConfig`
(`dist/node/index.d.ts:2340-2363`): resolved `root`, `srcDir`, `site`,
`configPath`, `configDeps`, `themeDir`, `outDir`, `assetsDir`, `cacheDir`,
`tempDir`, `pages`, `dynamicRoutes`, `rewrites { map, inv }`, `logger`,
`userConfig`, `buildConcurrency`.

## Merging configs

```ts
import { mergeConfig, defineConfig } from 'vitepress'
```

`mergeConfig(a, b, isRoot?)` deep-merges two `UserConfig` objects
(`dist/node/index.d.ts:2389`). Use it in `extends` chains when a function
form needs the base config.

Official reference: https://vitepress.dev/reference/site-config
