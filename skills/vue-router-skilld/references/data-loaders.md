# Data loaders (experimental, vue-router@5.3.1)

Data loaders attach async data fetching to the navigation itself: the navigation waits for the data before the component renders. All exports live on `vue-router/experimental` (ESM-only since v5.1.0).

## Setup

```ts
import { createApp } from 'vue'
import { DataLoaderPlugin } from 'vue-router/experimental'

const app = createApp(App)
app.use(DataLoaderPlugin, { router }) // BEFORE app.use(router)
app.use(router)
```

## defineBasicLoader

```ts
// src/pages/users/[id].vue (or a separate file imported and re-exported)
import { defineBasicLoader, reroute } from 'vue-router/experimental'

export const useUserData = defineBasicLoader('user' /* optional route name */, async (to) => {
  if (!isAuthenticated()) reroute({ name: 'login' }) // reroute throws: stops the loader
  return fetchUser(to.params.id)                     // params typed with param parsers
})

// in setup:
const { data, isLoading, error, reload, refetch } = useUserData()
```

- The loader receives `(to, context)`; `to` is the target `RouteLocationNormalizedLoaded`.
- Navigation blocks until non-lazy loaders resolve; errors abort the navigation and reach `router.onError`.
- Returned composable: `data`, `isLoading`, `error`, `reload()` (keep data, refetch), `refetch()` (refetch and block), plus internals (dist/index-D7ja2BKs.d.ts:1819-1841).
- `key` option identifies the loader for SSR state transfer.

## Navigation control

- `reroute(to)` — redirect from anywhere in a loader; throws internally so no code after it runs (dist/experimental/index.js:1106+). Replaces `new NavigationResult(to)`, which is deprecated and warns at runtime (v5.0.3, https://github.com/vuejs/router/releases/tag/v5.0.3).
- Only non-lazy loaders can control navigation.

## Lazy (non-blocking) loaders

```ts
export const useTweets = defineBasicLoader(async () => fetchTweets(), { lazy: true })
```

- Page renders immediately; show spinners via `isLoading`.
- Errors land in `error`; they do not abort navigation and do not appear in `router.onError`.
- `reroute()` cannot be used.
- Common Vite idiom: `lazy: !import.meta.env.SSR`.

## Global state

- `useIsDataLoading()` — reactive boolean, true while any non-lazy loader of the current navigation is pending.
- Nested loaders: a loader can call other loaders; they compose into one navigation-aware unit. Loaders defined in parent layouts run for child routes too.

## Auto-exporting loaders from pages

Either export the loader directly from the page component, or keep loaders in separate files and let the plugin re-export them:

```ts
VueRouter({ experimental: { autoExportsDataLoaders: 'src/loaders/**/*' } })
```

(Vite only; dist/unplugin/index.d.mts:24-45)

## defineColadaLoader (Pinia Colada)

```ts
import { defineColadaLoader } from 'vue-router/experimental/pinia-colada'

export const useUserData = defineColadaLoader({
  key: (to) => ['user', to.params.id],
  query: async ({ route }) => fetchUser(route.params.id),
  // staleTime, gcTime, eagerRefresh, ... Pinia Colada options
})
```

Requires `pinia` and `@pinia/colada` (optional peers, package.json:173-179; pinia 4 allowed since v5.2.0). Gives caching, dedup, and background refresh on top of navigation-aware loading.

## SSR

- Loaders run on the server during the initial navigation; state transfers via the `key` option.
- Mark non-critical loaders `lazy: !import.meta.env.SSR` to avoid blocking server render.
