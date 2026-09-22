# API surface

Every public export of vitepress@1.6.4, from the package type entry points.
Line citations are relative to the prepared package source.

## `vitepress` (root, `types/index.d.ts`)

Re-exports everything below plus the shared types in `types/shared.d.ts`
(`types/index.d.ts:1-3`).

### Node API (`dist/node/index.d.ts:2616`)

Functions:

| Export | Signature | Notes |
| --- | --- | --- |
| `defineConfig` | `(config: UserConfig<DefaultTheme.Config>) => UserConfig<DefaultTheme.Config>` | Default-theme typing (`dist/node/index.d.ts:2382`) |
| `defineConfigWithTheme<ThemeConfig>` | `(config: UserConfig<ThemeConfig>) => UserConfig<ThemeConfig>` | Custom-theme typing (`dist/node/index.d.ts:2386`) |
| `build` | `(root?, buildOptions?) => Promise<void>` | SSG build; accepts `base`, `mpa`, `onAfterConfigResolve` (`dist/node/index.d.ts:2392-2396`) |
| `createServer` | `(root?, serverOptions?, recreateServer?) => Promise<ViteDevServer>` | Dev server (`dist/node/index.d.ts:2612-2614`) |
| `serve` | `(options?: { base?, root?, port? }) => Promise<Polka>` | Preview server (`dist/node/index.d.ts:2605-2610`) |
| `init` | `(root?: string) => Promise<void>` | Setup wizard (`dist/node/index.d.ts:2488`) |
| `scaffold` | `(options: ScaffoldOptions) => string` | Programmatic scaffolding (`dist/node/index.d.ts:2489`) |
| `createContentLoader` | see below | Data loader for Markdown globs (`dist/node/index.d.ts:2466-2473`) |
| `defineLoader` | `(loader: LoaderModule) => LoaderModule` | Typed data loader helper (`dist/node/index.d.ts:2491-2498`) |
| `mergeConfig` | `(a: UserConfig, b: UserConfig, isRoot?) => Record<string, any>` | Merge VitePress configs (`dist/node/index.d.ts:2389`) |
| `createMarkdownRenderer` | `(srcDir, options?, base?, logger?) => Promise<MarkdownIt>` | Experimental (`dist/node/index.d.ts:2183`) |
| `resolveConfig` | `(root?, command?, mode?) => Promise<SiteConfig>` | (`dist/node/index.d.ts:2387`) |
| `resolveSiteData` | `(root, userConfig?, command?, mode?) => Promise<SiteData>` | (`dist/node/index.d.ts:2390`) |
| `postcssIsolateStyles` | `(options?) => plugin` | Scope CSS for nested components (`dist/node/index.d.ts:2517`) |

Re-exported from Vite: `Plugin`, `loadEnv`
(`dist/node/index.d.ts:4`).

Types: `UserConfig`, `SiteConfig`, `RawConfigExports`, `UserConfigExport`,
`UserConfigFn`, `TransformContext`, `TransformPageContext`, `ContentData`,
`ContentOptions`, `LoaderModule`, `MarkdownOptions`, `MarkdownRenderer`,
`ThemeOptions`, `ServeOptions`, `ScaffoldOptions`, `ScaffoldThemeType`,
`ResolvedRouteConfig`.

### Client API (`vitepress/client`, `dist/client/index.d.ts:137`)

| Export | Notes |
| --- | --- |
| `useData<T>()` | Returns `VitePressData<T>`: `site`, `theme`, `page`, `frontmatter`, `params`, `title`, `description`, `lang`, `dir`, `localeIndex`, `isDark`, `hash`; all `Ref` (`dist/client/index.d.ts:52-84`) |
| `useRouter()` | `Router`: `route`, `go(to?)`, hooks `onBeforeRouteChange`, `onBeforePageLoad`, `onAfterPageLoad`, `onAfterRouteChange`. Hook callbacks may return `false` to cancel; `onAfterRouteChanged` is deprecated (`dist/client/index.d.ts:17-47`) |
| `useRoute()` | `Route`: `path`, `data: PageData`, `component` (`dist/client/index.d.ts:12-16`) |
| `withBase(path)` | Prepends site `base` to internal URLs (`dist/client/index.d.ts:108`) |
| `onContentUpdated(fn)` | Runs after markdown content updates in the DOM (`dist/client/index.d.ts:113`) |
| `defineClientComponent(loader, args?, cb?)` | Component rendered only on the client (`dist/client/index.d.ts:114-118`) |
| `Content` | Renders page markdown; `as` prop accepts tag or component (`dist/client/index.d.ts:121-135`) |
| `inBrowser`, `getScrollOffset()`, `dataSymbol`, `_escapeHtml` | Utilities (`dist/client/index.d.ts:6,119,51,10`) |

`Theme` interface: `{ Layout?, enhanceApp?, extends?, setup? (deprecated), NotFound? (deprecated) }`
(`dist/client/index.d.ts:91-103`). `EnhanceAppContext`:
`{ app, router, siteData }` (`dist/client/index.d.ts:86-90`).

## `vitepress/theme` (`theme.d.ts`)

```ts
import DefaultTheme from 'vitepress/theme'

DefaultTheme.Layout
DefaultTheme.enhanceApp
```

- Default export: `{ Layout, enhanceApp }` (`theme.d.ts:9-14`).
- `useSidebar(): DefaultTheme.DocSidebar`,
  `useLocalNav(): DefaultTheme.DocLocalNav` (`theme.d.ts:15-16`).
- Unstyled building blocks: `VPBadge`, `VPButton`, `VPDocAsideSponsors`,
  `VPFeatures`, `VPHomeContent`, `VPHomeFeatures`, `VPHomeHero`,
  `VPHomeSponsors`, `VPImage`, `VPLink`, `VPNavBarSearch`, `VPSocialLink`,
  `VPSocialLinks`, `VPSponsors`, `VPTeamMembers`, `VPTeamPage`,
  `VPTeamPageSection`, `VPTeamPageTitle` (`theme.d.ts:19-36`).
- `vitepress/theme-without-fonts` re-exports the same API without bundling
  Inter fonts; load your own fonts instead
  (`theme-without-fonts.d.ts:1-2`).

Custom theme entry (`.vitepress/theme/index.ts`):

```ts
import DefaultTheme from 'vitepress/theme'
import type { Theme } from 'vitepress'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('MyComponent', () => import('./MyComponent.vue'))
  }
} satisfies Theme
```

`extends` composes an existing theme; `enhanceApp` registers app-level
plugins and components (https://vitepress.dev/guide/custom-theme,
https://vitepress.dev/guide/extending-default-theme).

## Data loaders

`.data.js` / `.data.ts` files export `{ watch?, load() }`; VitePress calls
`load()` at build time and exposes the result as the named export `data`
(https://vitepress.dev/guide/data-loading).

`createContentLoader(pattern | patterns, options?)` returns
`{ watch, load }` (`dist/node/index.d.ts:2466-2473`). Patterns are relative to
`srcDir`. Only Markdown files are matched.

`ContentOptions` (`dist/node/index.d.ts:2412-2454`):

- `includeSrc?: boolean` (default `false`): raw markdown source.
- `render?: boolean` (default `false`): rendered full-page HTML.
- `excerpt?: boolean | ((file, options?) => void) | string` (default
  `false`): rendered excerpt; separator defaults to `---`.
- `transform?: (data: ContentData[]) => T | Promise<T>`: final shipped shape.
- `globOptions?: GlobOptions`: passed to tinyglobby; overriding `ignore`
  must re-list `node_modules` and `dist`.

`ContentData`: `{ url, src?, html?, excerpt?, frontmatter }`
(`dist/node/index.d.ts:2455-2461`). `url` excludes `base`.

Typed loader pattern:

```ts
import { defineLoader } from 'vitepress'

export interface Data { posts: string[] }
declare const data: Data
export { data }

export default defineLoader({
  watch: ['posts/*.md'],
  async load(): Promise<Data> {
    return { posts: [] }
  }
})
```

Inside a loader, the resolved config is available as
`(globalThis as any).VITEPRESS_CONFIG` typed `SiteConfig`
(https://vitepress.dev/guide/data-loading#configuration).

## Shared types (`types/shared.d.ts`)

`PageData` (`types/shared.d.ts:8-23`): `relativePath`, `filePath` (differs
under `rewrites`; empty for virtual pages), `title`, `titleTemplate`,
`description`, `headers`, `frontmatter`, `params?`, `isNotFound?`,
`lastUpdated?`.

`SiteData` (`types/shared.d.ts:110-137`): `base`, `cleanUrls?`, `lang`,
`dir`, `title`, `titleTemplate?`, `description`, `head`, `appearance`,
`themeConfig`, `scrollOffset`, `locales`, `localeIndex?`, `contentProps?`,
`router.prefetchLinks`.

Also: `Header`, `HeadConfig`, `SfcBlock`, `MarkdownSfcBlocks`,
`MarkdownEnv`, `SSGContext`, `LocaleConfig`, `LocaleSpecificConfig`.
