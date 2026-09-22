# Migration

Applies to `@unhead/vue` 3.4.1. Sources: dist type definitions, https://unhead.unjs.io/docs/vue/head/guides/get-started/migration, https://unhead.unjs.io/docs/migration-guide/v3, https://unhead.unjs.io/docs/releases/v3.

## v3 status of v2 deprecations

The v3 docs describe several exports as removed. In the shipped 3.4.1 types they are still present but deprecated; plan for removal in v4:

| Export | 3.4.1 status | Evidence | Replace with |
|---|---|---|---|
| `useServerHead`, `useServerHeadSafe`, `useServerSeoMeta` | deprecated aliases of the plain composables | dist/index.d.ts:26-30 | `useHead` / `useHeadSafe` / `useSeoMeta` + `if (import.meta.server)` |
| `@unhead/vue/legacy` `createHead`, `createServerHead`, `legacyPlugins` | deprecated, removal in v4 | dist/legacy.d.ts:14-30 | `@unhead/vue/client` / `@unhead/vue/server` |
| `resolveUnrefHeadInput` | deprecated | dist/utils.d.ts:9 | `resolveTags(head)` from `unhead/utils` |
| `unheadVuePlugin` (`@unhead/vue/stream/vite`) | deprecated | dist/stream/vite.d.ts:8 | `Unhead({ streaming: true }).vite()` from `@unhead/vue/bundler` |
| `MergeHead` type | deprecated | dist/types.d.ts:66 | `VueHeadClient` generics |

## Removed in v3 (compile errors if used)

- `DeprecationsPlugin`: no auto-conversion of `children`/`hid`/`vmid`/`body: true`; rename props directly (`innerHTML`, `key`, `key`, `tagPosition: 'bodyClose'`).
- `setHeadInjectionHandler`: head injection is automatic via Vue provide/inject.
- `createHeadCore` (both `unhead` and `@unhead/vue`): use `createUnhead()` or `createHead()` from `/client`//`/server`.
- `{ mode: 'server' }` entry option: silently ignored; use `import.meta.server` conditionals.
- Hooks `init`, `dom:renderTag`, `dom:rendered` (use the `onRendered` option on `useHead()`); `dom:beforeRender` and all `ssr:*` hooks are synchronous; `renderDOMHead` and `renderSSRHead` no longer return Promises.
- `head.headEntries()`: use `[...head.entries.values()]`.
- Types `Head`, `MetaFlatInput`, `RuntimeMode`, `ResolvedHead`, `ResolvedMetaFlat`: use `HeadTag`, `MetaFlat`, etc.
- `@unhead/addons` package: renamed `@unhead/bundler`; default export replaced by named `Unhead`.

## Strict tag types (v3)

`Link` and `Script` inputs are discriminated unions:

- Font preloads require `crossorigin`: `{ rel: 'preload', as: 'font', href: '/f.woff2', crossorigin: 'anonymous' }`.
- Inline scripts need `textContent`/`innerHTML` and cannot carry `src`/`async`/`defer`.
- Meta with `name`, `property`, or `http-equiv` requires `content`; use `content: null` to remove the tag.
- Non-literal `rel`/`type` strings break narrowing: wrap with `defineLink()` / `defineScript()` or use `as const`.

## v2 -> v3 quick diffs

```diff
- import { createHead } from '@unhead/vue/legacy'
+ import { createHead } from '@unhead/vue/client'   // SPA
+ import { createHead } from '@unhead/vue/server'   // SSR

- import { useServerHead } from '@unhead/vue'
+ if (import.meta.server) { useHead({ title: 'Server Only' }) }

- const tags = await renderSSRHead(head)
+ const tags = renderSSRHead(head)

- import type { Head, MetaFlatInput } from '@unhead/vue'
+ import type { HeadTag, MetaFlat } from '@unhead/vue'

- import unhead from '@unhead/addons/vite'
+ import { Unhead } from '@unhead/vue/vite'          // or '@unhead/vue/bundler'
```

## v1 -> v2 (still relevant)

- `createHead`/`createServerHead` moved off the package root to `/client` and `/server` subpaths.
- `vmid`, `hid`, `children`, `body: true` removed in favor of `key`, `innerHTML`, `tagPosition`.
- `useScript()` no longer thenable; use `onLoaded()`. API access via `.proxy` only. `stub()` and the `script:instance-fn` hook removed.
- Promise inputs not resolved by default: await first, or register `PromisePlugin` from `@unhead/vue/plugins`.
- `TemplateParamsPlugin` and `AliasSortingPlugin` are opt-in at `createHead({ plugins: [...] })`.
- Capo.js tag sorting is default (`disableCapoSorting: true` to opt out); default SSR tags are auto-inserted (`disableDefaults: true` to opt out).
- Vue 2 support and CJS exports removed.
