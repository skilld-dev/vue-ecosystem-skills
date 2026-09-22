# Data loading

Loaders run on the client by default (client-first). For SSR data, see [references/ssr.md](./ssr.md).

## Pipeline

1. `beforeLoad({ context, params, search, location, matches })` — runs before match commit. Return value becomes route context (readable via `useRouteContext`). Throw `redirect()` or `notFound()` to short-circuit.
2. `loaderDeps({ search })` — object keyed by deps; change triggers loader re-run.
3. `loader({ context, params, deps, abortController, cause, preload })` — fetch and return serializable data; read via `useLoaderData`.

`loader` may return a promise; the route suspends behind `pendingComponent` (client renders inside Vue `<Suspense>`, `src/Matches.tsx:53-64`).

## Context

```ts
import { createRootRouteWithContext, createRouter } from '@tanstack/vue-router'

interface RouterContext { queryClient: QueryClient }

const rootRoute = createRootRouteWithContext<RouterContext>()({ component: Root })

const router = createRouter({
  routeTree: rootRoute.addChildren([/* ... */]),
  context: { queryClient }, // type-checked against RouterContext
})
```

Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/router-context

## Redirects

```ts
beforeLoad: async ({ context }) => {
  if (!context.auth.isAuthenticated) {
    throw redirect({ to: '/login', search: { redirect: location.href } })
  }
}
```

- `redirect()` options: `to`, `params`, `search`, `hash`, `replace`, `resetScroll`, `ignoreBlocker`, `headers` (SSR).
- In error handlers, re-check before converting: `if (isRedirect(error)) throw error`.
- `notFound()` (or `RouteApi.notFound()`, `src/route.ts:132-134`) renders `notFoundComponent`; `notFoundMode` (default `'fuzzy'`; `'root'` sends all 404s to the root) picks where.
- API: https://tanstack.com/router/latest/docs/framework/vue/api/router/redirectFunction

## Deps hygiene

```ts
loaderDeps: ({ search: { page, filter } }) => ({ page, filter }),
```

Returning the whole `search` object re-runs the loader on any unrelated search change. Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/data-loading#using-loaderdeps-to-access-search-params

## Deferred streaming

```ts
import { defer } from '@tanstack/vue-router'

loader: () => ({ critical: await fetchPost(), slow: defer(fetchComments()) })
```

Consume in a component:

```vue
<Suspense>
  <template #default><Comments :promise="data.value.slow" /></template>
  <template #fallback><Spinner /></template>
</Suspense>
```

`<Await :promise="p">` resolves it via async setup and passes data to its children function (`src/awaited.tsx:26-43`); `useAwaited({ promise })` is the hook form. Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/deferred-data-loading

## Consumption

- In the route's own component: `const data = useLoaderData({ from: '/posts/$postId' })`.
- In unrelated components: `const api = getRouteApi('/posts/$postId')` then `api.useLoaderData()` (avoids importing the `Route` object, which creates cycles).
- External caches (TanStack Query, stores): use the router only for orchestration; loaders can return `undefined` — https://tanstack.com/router/latest/docs/framework/vue/guide/external-data-loading
- Mutations: `router.invalidate()` re-runs active loaders — https://tanstack.com/router/latest/docs/framework/vue/guide/data-mutations

## Caching windows

Per-route `staleTime`, `preloadStaleTime`, `gcTime`; router defaults `defaultStaleTime` (default 0), `defaultPreloadStaleTime`, `defaultGsTime`. Preloaded routes within `defaultPreloadMaxAge` (30 s) are cached.

## Errors

`errorComponent: ({ error, reset }) => VNode`; `onCatch` logs; `defaultErrorComponent`/`defaultOnCatch` set router-wide. Uncaught errors hit the global boundary unless `disableGlobalCatchBoundary` (`src/Matches.tsx:104-121`). Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/data-loading#handling-errors-with-routeoptionserrorcomponent
