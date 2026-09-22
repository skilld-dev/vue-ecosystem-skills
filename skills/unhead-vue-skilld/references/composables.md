# Composables

All composables are exported from `@unhead/vue` root (dist/index.d.ts:17-19) and require an active Vue component context (or an explicit `{ head }` option).

## useHead(input, options?)

```ts
useHead({ title: 'Home', meta: [{ name: 'description', content: '...' }] })
```

Input keys: `title`, `titleTemplate`, `templateParams`, `base`, `link`, `meta`, `style`, `script`, `noscript`, `htmlAttrs`, `bodyAttrs` (dist/shared/vue.B8YcFbNO.d.ts:64-133).

### Reactivity

Every value accepts plain values, getters, `ref`, and `computed`:

```ts
const title = ref('My Site')
useHead({
  title,                                              // direct ref
  meta: [{ name: 'description', content: () => desc.value }], // getter
  link: [computed(() => ({ rel: 'canonical', href: url.value }))], // computed entry
})
```

Lifecycle: entries are removed on unmount, deactivated/reactivated with `<KeepAlive>`.

### Async context

`useHead()` throws `useHead() was called without provide context` after an `await` in `onMounted()`, watchers, or nested callbacks. Solutions, best first:

1. Top-level `await` in `<script setup>` (compiler preserves context).
2. Declare `useHead()` once with computed values; update the ref asynchronously.
3. `effectScope()` captured at setup, `scope.run(() => useHead(...))` after the await.
4. `const head = injectHead()` at setup, then `useHead(input, { head })`.

### Entry options (`UseHeadOptions`)

`Omit<HeadEntryOptions, 'head'> & { head?: VueHeadClient }` (dist/shared/vue.B8YcFbNO.d.ts:134-136). Common keys: `tagPriority` (`'critical' | 'high' | 'low' | number | 'before:x' | 'after:x'`), `tagPosition` (`'head' | 'bodyOpen' | 'bodyClose'`), `processTemplateParams`. The v2 `{ mode: 'server' }` option is removed; guard with `if (import.meta.server)` instead.

Source: https://unhead.unjs.io/docs/head/api/composables/use-head

## useSeoMeta(input)

Flat, fully typed keys for 100+ meta tags; `name`/`property` and `og:`/`twitter:` prefixes are derived automatically:

```ts
useSeoMeta({
  title: 'About Us',
  description: 'Learn more',
  ogTitle: 'About Us',
  ogImage: 'https://example.com/image.jpg',
})
```

`UseSeoMetaInput = ResolvableProperties<MetaFlat> & { title?, titleTemplate? }` (dist/shared/vue.B8YcFbNO.d.ts:138-141). The `Unhead()` build plugin rewrites `useSeoMeta()` calls to `useHead()` at build time, saving ~3kb.
Source: https://unhead.unjs.io/docs/head/api/composables/use-seo-meta

## useHeadSafe(input)

Same shape as `useHead` but restricted to a whitelist (`HeadSafe`, dist/types.d.ts:34-80): `title`, `titleTemplate`, `templateParams`, `link`, `meta`, `style`, `script` (only `id`, `type`, `nonce`, `blocking`, `textContent`), `noscript`, `htmlAttrs` (`id`, `class`, `style`, `lang`, `dir`), `bodyAttrs` (`id`, `class`, `style`). Event handlers and arbitrary attributes are stripped. Use it whenever input originates from users or third parties.
Source: https://unhead.unjs.io/docs/head/api/composables/use-head-safe

## useScript(input, options?)

From `@unhead/vue` root (dist/scripts.d.ts:28-45). Defaults: loads after hydration, `defer`, `fetchpriority="low"`, `crossorigin="anonymous"`, `referrerpolicy="no-referrer"`. Same `src`/`key` loads once globally.

```ts
const { proxy, onLoaded, onError, load, status } = useScript(
  { src: 'https://maps.googleapis.com/maps/api/js' },
  {
    use: () => window.google.maps, // API the proxy wraps
    trigger: 'client',             // see below
    warmupStrategy: 'preload',     // 'preload' | 'prefetch' | 'preconnect' | 'dns-prefetch'
  },
)
proxy.Map(el, { zoom: 10 }) // calls queue until load, then replay
```

Vue-specific (dist/scripts.d.ts:7-52):
- `trigger` also accepts `Ref<boolean>` and `() => boolean`; other values: `'client'` (default), `'manual'` + `load()`, `'server'`, `Promise`, or `(load) => void`.
- `status` is a Vue `Ref<'awaitingLoad' | 'loading' | 'loaded' | 'error' | 'removed'>`.
- `{ scope: true }` returns a `VueScriptScope` bound to the component's effect scope for automatic cleanup.
- The return is not a Promise; use `onLoaded(fn)`. Call script APIs via `proxy`, never off the instance root.

The loader variant accepts a `resolve` function instead of `use` for typed third-party wrappers.
Source: https://unhead.unjs.io/docs/head/api/composables/use-script

## injectHead()

`injectHead(): VueHeadClient` (dist/index.d.ts:12). Returns the instance from Vue's provide/inject (`headSymbol`). Call it at setup time; use the result for `{ head }` options, `useScript(..., { head })`, or direct `head.push()` outside components. Prefer it over `getActiveHead()` from `unhead`, which can return a cross-request instance under SSR.

## Tag deduplication and positions

- Same tag with identical dedupe props (`name`, `property`, `charset`, ...) renders once; use `key` to force a distinct entry.
- `tagPosition: 'bodyClose'` for analytics/chat widgets; `tagPriority: 'critical' | 'high' | 'low'` keeps Capo.js ordering weights (Capo sorting is default; opt out with `createHead({ disableCapoSorting: true })`).
- `titleTemplate` as a function receives the title and can return a string or `null` to use the title as-is.
- Inline scripts/styles: prefer `textContent` over `innerHTML` (escaped vs raw); `innerHTML` requires trusted content.

Sources: https://unhead.unjs.io/docs/head/guides/core-concepts/positions, https://unhead.unjs.io/docs/head/guides/core-concepts/inner-content
