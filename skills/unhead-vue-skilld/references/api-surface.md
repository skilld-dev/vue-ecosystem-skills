# API surface

Complete public surface of `@unhead/vue` 3.4.1, from `package.json:23-84` and `dist/*.d.ts`.

## Export map

| Import | Key exports |
|---|---|
| `@unhead/vue` | `useHead`, `useHeadSafe`, `useSeoMeta`, `useScript`, `injectHead`, `headSymbol`, `VueHeadMixin`, `unheadVueComposablesImports`, `resolveUnrefHeadInput` (deprecated), `createUnhead`, `defineLink`, `defineScript`, deprecated `useServerHead*` aliases, plus types re-exported from `unhead/types` and `unhead/scripts` |
| `@unhead/vue/client` | `createHead(options?: CreateClientHeadOptions): VueHeadClient`, `renderDOMHead`, `VueHeadMixin` |
| `@unhead/vue/server` | `createHead(options?: Omit<CreateServerHeadOptions, 'propResolvers'>>): VueHeadClient`, `renderSSRHead`, `transformHtmlTemplate`, `prepareTemplate`, `propsToString`, `VueHeadMixin` |
| `@unhead/vue/components` | `Head: DefineComponent` |
| `@unhead/vue/plugins` | `export * from 'unhead/plugins'`: `TemplateParamsPlugin`, `AliasSortingPlugin`, `PromisePlugin`, `InferSeoMetaPlugin`, `ValidatePlugin`, and the rest |
| `@unhead/vue/utils` | `export * from 'unhead/utils'` plus `VueResolver`; `resolveUnrefHeadInput` (deprecated) |
| `@unhead/vue/types` | `unhead/types` re-exports (`HeadTag`, `MetaFlat`, `HeadEntryOptions`, ...) plus `HeadSafe` and `Safe*` tag types, `MergeHead` (deprecated) |
| `@unhead/vue/scripts` | script types: `UseScriptOptions`, `VueScriptInstance`, `VueScriptScope`, `UseScriptReturn`, `WarmupStrategy`, ... |
| `@unhead/vue/bundler` | `Unhead(options?): UnheadBundlerFactory` with `.vite()`, `.webpack()`, `.rspack()`, `.rollup()` (dist/bundler.d.ts:15-19) |
| `@unhead/vue/vite` | `Unhead(options?): Plugin[]`; kept for compatibility, prefer `/bundler` (dist/vite.d.ts:8-14) |
| `@unhead/vue/stream/server` | `createStreamableHead(options?): VueStreamableHeadContext` = `{ head, wrapStream }` (dist/stream/server.d.ts:36-38) |
| `@unhead/vue/stream/client` | `createStreamableHead(options?): VueHeadClient | undefined` |
| `@unhead/vue/stream/vite` | `unheadVuePlugin` (deprecated, default export) |
| `@unhead/vue/stream/iife` | `streamingIifeCode`, `streamingIifeSize` |
| `@unhead/vue/legacy` | `createHead`, `createServerHead`, `legacyPlugins`; deprecated, removed in v4 (dist/legacy.d.ts) |

## Core Vue types (dist/shared/vue.B8YcFbNO.d.ts)

```ts
type ResolvableValue<T> = MaybeFalsy<T> | (() => MaybeFalsy<T>) | ComputedRef<MaybeFalsy<T>> | Ref<MaybeFalsy<T>>
type UseHeadInput<_Deprecated = never> = ResolvableValue<ReactiveHead>
type UseSeoMetaInput = ResolvableProperties<MetaFlat> & { title?: ReactiveHead['title']; titleTemplate?: ReactiveHead['titleTemplate'] }
type UseHeadOptions = Omit<HeadEntryOptions, 'head'> & { head?: VueHeadClient<any> }
type VueHeadClient<I = UseHeadInput, R = unknown> = Unhead<I, R> & Plugin // Vue plugin, so app.use(head) works
```

`ReactiveHead` keys: `title`, `titleTemplate`, `templateParams`, `base`, `link`, `meta`, `style`, `script`, `noscript`, `htmlAttrs`, `bodyAttrs`. Array entries accept `computed(() => entry)`; `htmlAttrs.class`/`bodyAttrs.class` accept object syntax (`{ 'dark-mode': true }`) and `style` accepts CSSProperties objects.

The root entry's generic legacy parameter `UseHeadInput<_Deprecated>` exists only to keep old arities compiling.

## Instance API

`VueHeadClient` extends the core `Unhead` instance (`head.push`, `head.hooks`, `head.entries`, ...) and is itself a Vue plugin. Notable v3 changes:

- `head.headEntries()` removed: use `[...head.entries.values()]`.
- `createUnhead()` from the root export replaces the removed `createHeadCore()`.
- Hooks `init`, `dom:renderTag`, `dom:rendered` removed; `dom:beforeRender`, `ssr:*` hooks are synchronous.
- `defineLink()` / `defineScript()` (re-exported from `unhead`) keep strict discriminated-union types working when `rel`/`type` come from non-literal strings.

## Auto-import preset

```ts
const unheadVueComposablesImports = { '@unhead/vue': ['injectHead', 'useHead', 'useSeoMeta', 'useHeadSafe'] }
```

(dist/index.d.ts:15)
