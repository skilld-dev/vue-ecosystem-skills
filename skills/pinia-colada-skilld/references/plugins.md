# Plugins and type augmentation

`@pinia/colada` 1.4.5. Types: `dist/index.d.mts:50-85`, `1571-1702`.

Docs: https://pinia-colada.esm.dev/plugins.md

## Installation and global options

`PiniaColada` is a Vue plugin installed after pinia
(`dist/index.d.mts:1627`). Options (`PiniaColadaOptions`,
`dist/index.d.mts:1601-1618`):

```ts
import { createPinia } from 'pinia'
import { PiniaColada } from '@pinia/colada'

app.use(createPinia())
app.use(PiniaColada, {
  pinia, // only if installing before the pinia plugin
  queryOptions: {
    staleTime: 60_000,
    refetchOnWindowFocus: false,
    // enabled, gcTime, refetchOnMount, refetchOnReconnect,
    // placeholderData, ssrCatchError
  },
  mutationOptions: {
    gcTime: 120_000,
    // global onMutate/onSuccess/onError/onSettled for all mutations
    // (UseMutationOptionsGlobal, dist/index.d.mts:1305-1382)
  },
  plugins: [],
})
```

Since 0.14.0 the options object is required for correct typing; query-level
defaults live under `queryOptions`, not at the root.

## Writing a plugin

```ts
import type { PiniaColadaPlugin } from '@pinia/colada'

const myPlugin: PiniaColadaPlugin = ({ queryCache, mutationCache, pinia, scope }) => {
  // use `scope` for any ref/watch/computed effects
}
app.use(PiniaColada, { plugins: [myPlugin] })
```

Plugins can extend `UseQueryOptions` and entry extensions through module
augmentation (`dist/index.d.mts:519-531`, `219`):

```ts
// pinia-colada-plugin.d.ts
export {}
declare module '@pinia/colada' {
  interface UseQueryOptions {
    refreshOnMount?: boolean
  }
}
```

Guide: https://pinia-colada.esm.dev/plugins/writing-plugins.md

## `PiniaColadaQueryHooksPlugin` (bundled)

Global `onSuccess` / `onError` / `onSettled` for all queries
(`dist/index.d.mts:1629-1679`). Queries deliberately have no per-instance
success/error hooks; use this plugin, `watch`, or `meta`:

```ts
import { PiniaColada, PiniaColadaQueryHooksPlugin } from '@pinia/colada'

app.use(PiniaColada, {
  plugins: [
    PiniaColadaQueryHooksPlugin({
      onError(error, entry) {
        toast.error(entry.meta.errorMessage ?? 'Request failed')
      },
      onSettled(data, error, entry) {},
    }),
  ],
})
```

Docs: https://pinia-colada.esm.dev/plugins/official/query-hooks.md

## `PiniaColadaSSRNoGc` (bundled, 1.3.0)

Forces `gcTime: false` on every entry so garbage collection timers do not keep
a Node process alive during SSR / SSG builds. Apply on the server only
(`dist/index.d.mts:1681-1700`):

```ts
app.use(PiniaColada, {
  plugins: import.meta.env.SSR ? [PiniaColadaSSRNoGc()] : [],
})
```

## `TypesConfig` module augmentation

Set a default error type and typed `meta` for all queries and mutations
(`dist/index.d.mts:50-84`):

```ts
// types-extension.d.ts
import '@pinia/colada'
export {}
declare module '@pinia/colada' {
  interface TypesConfig {
    defaultError: MyCustomError
    queryMeta: { onErrorMessage?: string }
    mutationMeta: { track?: boolean }
  }
}
```

## Ecosystem packages

Core has one runtime dependency (`nostics`, the dev reporter added in 1.4.0).
Everything else ships separately:

- `@pinia/colada-nuxt`: Nuxt module; auto-imports and SSR serialization
  (https://pinia-colada.esm.dev/nuxt.md)
- `@pinia/colada-devtools`: devtools panel (v2 uses devframe;
  https://pinia-colada.esm.dev/cookbook/migration-devtools-v2.md)
- `@pinia/colada-plugin-*`: official plugins such as retry, delay,
  auto-refetch, and cache-persister
  (https://pinia-colada.esm.dev/plugins/official.md)
- Community plugins: https://pinia-colada.esm.dev/plugins/community.md
- TanStack Query compatibility plugin:
  https://pinia-colada.esm.dev/cookbook/tanstack-compat.md
