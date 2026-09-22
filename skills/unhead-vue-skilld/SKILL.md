---
name: unhead-vue-skilld
description: Full-stack <head> manager for Vue (@unhead/vue 3.x). Use when writing, reviewing, or debugging code that imports @unhead/vue, calls useHead, useSeoMeta, useHeadSafe, useScript, injectHead, createHead, or sets up Unhead SSR / streaming SSR / build plugins in a Vue app.
---

# @unhead/vue 3.4.1

Full-stack `<head>` management for Vue 3. ESM only (`"type": "module"`), no CJS.
Peer deps: `vue >= 3.5.18`; optional `vite >= 6.4.2`, `webpack >= 5.0.0` (source: `package.json:138-150`).
Vue 2: not supported; use `@unhead/vue@^1`.
Nuxt: Unhead is integrated already; do not install or set it up manually.

## Setup (mandatory)

Install `@unhead/vue`, create the head instance, and register it as a Vue plugin. `createHead` comes from a subpath export, not the package root.

```ts
// entry-client.ts (SPA or hydration)
import { createHead } from '@unhead/vue/client'
import { createApp } from './main'

const { app } = createApp()
const head = createHead()
app.use(head)
app.mount('#app')
```

```ts
// entry-server.ts (SSR)
import { createHead } from '@unhead/vue/server'
import { renderToString } from 'vue/server-renderer'
import { createApp } from './main'

export async function render(url: string) {
  const { app } = createApp()
  const head = createHead()
  app.use(head)
  const html = await renderToString(app)
  return { html, head } // render tags later with transformHtmlTemplate(head, template)
}
```

Full SSR template wiring, streaming SSR, Options API, and auto-imports: [references/setup.md](references/setup.md).

## Composables

All imported from `@unhead/vue` root and used inside `setup()`:

```vue
<script setup lang="ts">
import { useHead, useSeoMeta } from '@unhead/vue'

useHead({
  title: () => `${user.value.name} - Profile`, // getters, refs, computed all reactive
  titleTemplate: '%s | My Site',
  meta: [{ name: 'description', content: () => description.value }],
})

useSeoMeta({ // flat, type-safe keys; og/twitter handled automatically
  ogTitle: 'My Page',
  ogImage: 'https://example.com/image.jpg',
})
</script>
```

```ts
// Third-party scripts
import { useScript } from '@unhead/vue'

const { proxy, onLoaded, status } = useScript(
  { src: 'https://example.com/analytics.js' },
  { use: () => window.analytics, trigger: 'client' },
)
proxy.track('pageview') // queued until the script loads
```

Details, options tables, and recipes: [references/composables.md](references/composables.md).

## Critical rules

1. **Async context**: calling `useHead()` after an `await` inside `onMounted()`/watchers throws `useHead() was called without provide context`. Fix, in order of preference: top-level `await` in `<script setup>`; declare `useHead()` once with refs/computed and update the ref later; capture `const head = injectHead()` at setup time and pass `useHead(input, { head })`. Source: https://unhead.unjs.io/docs/vue/head/guides/core-concepts/reactivity-and-context
2. **Never call `useHead()` inside a watcher callback**: each call pushes a new entry and duplicates tags. Pass the reactive value into one `useHead()` call instead.
3. **Deduplication key is `key`**, not `hid`/`vmid`: `meta: [{ key: 'description', name: 'description', content: '...' }]`.
4. **Inline content**: `innerHTML` (was `children` in v1); body scripts use `tagPosition: 'bodyClose'` (was `body: true`).
5. **Untrusted input**: use `useHeadSafe()`; it whitelists attributes and strips scripts/handlers.
6. **Head instance access in Vue**: use `injectHead()` from `@unhead/vue`, not `getActiveHead()` from `unhead`; only the former binds to component context (e.g. `onServerPrefetch`).

## Deprecated in 3.4.1 (present but slated for removal)

| Export | Status | Replacement |
|---|---|---|
| `useServerHead`, `useServerHeadSafe`, `useServerSeoMeta` | deprecated (`dist/index.d.ts:26-30`) | `useHead` / `useHeadSafe` / `useSeoMeta` |
| `@unhead/vue/legacy` (`createHead`, `createServerHead`, `legacyPlugins`) | deprecated, removed in v4 (`dist/legacy.d.ts:14-30`) | `@unhead/vue/client` / `@unhead/vue/server` |
| `resolveUnrefHeadInput` | deprecated (`dist/utils.d.ts:9`) | `resolveTags(head)` from `unhead/utils` |
| `unheadVuePlugin` from `@unhead/vue/stream/vite` | deprecated (`dist/stream/vite.d.ts:8`) | `Unhead({ streaming: true }).vite()` from `@unhead/vue/bundler` |
| `MergeHead` type | deprecated (`dist/types.d.ts:66`) | generics on `VueHeadClient` |

Removed in v3 (will not compile): `DeprecationsPlugin`, `setHeadInjectionHandler`, `createHeadCore`, `{ mode: 'server' | 'client' }` entry option, `init`/`dom:renderTag`/`dom:rendered` hooks, `headEntries()` (use `[...head.entries.values()]`).
Migration details: [references/migration.md](references/migration.md).

## Export map

| Subpath | Purpose |
|---|---|
| `@unhead/vue` | composables: `useHead`, `useSeoMeta`, `useHeadSafe`, `useScript`, `injectHead`, `VueHeadMixin`, `unheadVueComposablesImports`, `createUnhead`, `defineLink`, `defineScript` |
| `@unhead/vue/client` | `createHead()` (SPA/hydration), `renderDOMHead`, `VueHeadMixin` |
| `@unhead/vue/server` | `createHead()` (SSR), `renderSSRHead`, `transformHtmlTemplate`, `propsToString` |
| `@unhead/vue/components` | `<Head>` component |
| `@unhead/vue/plugins` | re-exports `unhead/plugins` (`TemplateParamsPlugin`, `AliasSortingPlugin`, `PromisePlugin`, `InferSeoMetaPlugin`, `ValidatePlugin`, ...) |
| `@unhead/vue/bundler` | unified build plugin `Unhead()` for vite/webpack/rspack/rollup |
| `@unhead/vue/vite` | Vite-only `Unhead()`; prefer `/bundler` |
| `@unhead/vue/stream/server`, `/stream/client` | `createStreamableHead()` for streaming SSR |
| `@unhead/vue/types`, `/utils`, `/scripts`, `/legacy` | types, utilities, script types, legacy shims |

Signatures and full type surface: [references/api-surface.md](references/api-surface.md).

## Optional plugins at creation

Template params (`%s`, `%separator`), alias sorting (`before:`/`after:`), and Promise inputs are opt-in since v2:

```ts
import { createHead } from '@unhead/vue/client'
import { AliasSortingPlugin, TemplateParamsPlugin } from '@unhead/vue/plugins'

const head = createHead({ plugins: [TemplateParamsPlugin, AliasSortingPlugin] })
```

Without `TemplateParamsPlugin`, `%siteName` placeholders render literally.

## Build plugin (recommended for standalone Vue apps)

```ts
// vite.config.ts
import { Unhead } from '@unhead/vue/bundler'

export default defineConfig({
  plugins: [vue(), Unhead()], // add { streaming: true } for streaming SSR
})
```

Tree-shakes server-only composables from the client bundle, converts `useSeoMeta()` to `useHead()` (~3kb), injects `ValidatePlugin` in dev. Options table and webpack notes: [references/build-plugins.md](references/build-plugins.md).

## Common mistakes

- Importing `createHead` from `@unhead/vue` root (removed in v2): use `/client` or `/server`.
- Awaiting `renderSSRHead` / `renderDOMHead`: both are synchronous in v3.
- `useScript()` return is not a Promise: use `onLoaded(() => ...)`; call APIs through `.proxy`.
- Meta tags require `content`: `{ name: 'description', content: null }` removes the tag.
- Font preloads require `crossorigin`: `{ rel: 'preload', as: 'font', href: '/f.woff2', crossorigin: 'anonymous' }`.

## References

- [references/setup.md](references/setup.md) — SPA, SSR, streaming SSR, Options API, `<Head>` component, auto-imports, defaults
- [references/composables.md](references/composables.md) — `useHead`, `useSeoMeta`, `useHeadSafe`, `useScript` usage and options
- [references/api-surface.md](references/api-surface.md) — export map, types, instance API
- [references/build-plugins.md](references/build-plugins.md) — `Unhead()` bundler plugin and streaming
- [references/migration.md](references/migration.md) — v2 and v3 breaking changes
