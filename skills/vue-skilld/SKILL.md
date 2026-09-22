---
name: vue-skilld
description: Build, debug, and modernize UI with Vue 3.6. Use when editing *.vue files, writing components or composables, or working with code that imports "vue". Covers script setup, reactivity, Vapor Mode, SSR, and version-specific API changes from 3.4 through 3.6.0-beta.17.
---

# vue 3.6.0-beta.17 (vuejs/core)

Pre-release beta of the 3.6 line. Two headline changes vs 3.5:

- **Vapor Mode**, an opt-in compilation strategy for SFCs that skips the Virtual DOM; see [Vapor Mode](./references/vapor-mode.md).
- **alien-signals reactivity refactor**: `@vue/reactivity` was rebuilt on [alien-signals](https://github.com/stackblitz/alien-signals) for lower memory use and faster updates. No public API changes.

Package facts (from the prepared source):

- Version: `package.json:3`.
- The main entry re-exports `@vue/runtime-dom` AND `@vue/runtime-vapor`, so all Vapor APIs (`createVaporApp`, `vaporInteropPlugin`, `defineVaporComponent`) import from plain `vue`: `dist/vue.d.ts:4-5`.
- Named exports added by the `vue` package itself: `compile`, `defineVaporAsyncComponent`, `withAsyncContext`: `dist/vue.runtime.esm-bundler.js:12`.
- Subpath exports: `vue/server-renderer`, `vue/compiler-sfc`, `vue/jsx-runtime`, `vue/jsx`: `package.json:36-68`.
- TypeScript is an optional peer dependency (`*`): `package.json:107-113`.

## Common tasks

Component with `<script setup>`, reactive props destructure, and `defineModel`:

```vue
<script setup lang="ts">
const { count = 0 } = defineProps<{ count?: number }>()
const model = defineModel<string>({ default: '' })
</script>

<template>
  <input v-model="model" />
  <p>{{ count }}</p>
</template>
```

Template refs (3.5+ pattern):

```ts
import { useTemplateRef } from 'vue'
const input = useTemplateRef('my-input') // matches ref="my-input" in template
```

Watch with cleanup (3.5+):

```ts
import { watch, onWatcherCleanup } from 'vue'
watch(id, () => {
  const controller = new AbortController()
  load(id.value, controller)
  onWatcherCleanup(() => controller.abort())
})
```

Composable that accepts a value, ref, or getter:

```ts
import { toValue, type MaybeRefOrGetter } from 'vue'
function useDouble(source: MaybeRefOrGetter<number>) {
  return computed(() => toValue(source) * 2)
}
```

Lazy hydration for SSR (3.5+):

```ts
import { defineAsyncComponent, hydrateOnVisible } from 'vue'
const Heavy = defineAsyncComponent({
  loader: () => import('./Heavy.vue'),
  hydrate: hydrateOnVisible(),
})
```

## Version rules that change what you write

Full list with citations in [API changes](./references/api-changes.md). The ones that break old code:

- Reactivity Transform (`$ref`, `$computed`) was removed in 3.4. Use plain `ref`/`computed`, or the Vue Macros plugin.
- `@vnodeXXX` listeners are a compiler error since 3.4. Use `@vue:mounted` style listeners.
- Global `JSX` namespace is no longer registered since 3.4. Set `jsxImportSource: "vue"` in tsconfig, or import `vue/jsx`.
- In Vapor components (3.6), Options API, `app.config.globalProperties`, `getCurrentInstance()`, `v-memo`, and `@vue:xxx` element lifecycle events do not work.
- Vapor event delegation is on by default in beta.17: `stopPropagation()` in an ancestor can cancel delegated handlers. Disable per build with `compilerOptions.eventDelegation` (added in beta.15, [#14924](https://github.com/vuejs/core/pull/14924)). Note: rc.2 replaced this with an opt-in `.delegate` modifier ([release notes](https://github.com/vuejs/core/releases/tag/v3.6.0-rc.2)).

## Bundler and dist notes

- Bundlers resolve the runtime-only build; templates in `.vue` files are pre-compiled. For runtime template compilation (in-DOM templates or template strings), alias `vue` to `vue/dist/vue.esm-bundler.js`.
- Replace `__VUE_OPTIONS_API__`, `__VUE_PROD_DEVTOOLS__`, `__VUE_PROD_HYDRATION_MISMATCH_DETAILS__` at build time for correct tree-shaking ([compile-time flags](https://vuejs.org/api/compile-time-flags.html)).
- In Node CJS, importing `vue/compiler-sfc` auto-registers TypeScript via `registerTS(() => require('typescript'))` when resolvable: `compiler-sfc/register-ts.js:1-3`.

Details, dist-file selection, and the export catalog: [API surface](./references/api-surface.md).

## References

- [API surface](./references/api-surface.md): entry points, dist builds, feature flags, export catalog.
- [Vapor Mode](./references/vapor-mode.md): opt-in, interop, constraints, directives, event delegation.
- [API changes 3.4 to 3.6](./references/api-changes.md): new, stable, and removed APIs per version, with citations.
- [Best practices](./references/best-practices.md): composable and performance patterns proven against the official docs.
