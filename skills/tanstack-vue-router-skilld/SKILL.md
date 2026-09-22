---
name: tanstack-vue-router-skilld
description: Use when writing, debugging, or refactoring code that imports @tanstack/vue-router (TanStack Router for Vue). Covers setup, file-based and code-based routes, composables returning Ref, Link, loaders, search params, SSR, and v1.170.x deprecations.
---

# @tanstack/vue-router

Type-safe router for Vue. Prepared source: version **1.170.35** (`package.json:3`).

- Requires `vue >= 3.3.0` (peer), Node `>= 20.19` (`package.json:59-88`)
- Runtime deps: `@tanstack/router-core@1.171.32`, `@tanstack/history@1.162.4`, `@tanstack/vue-store@^0.11.0`
- ESM-only (`"type": "module"`), no `main`/CJS entry
- Entry points: `@tanstack/vue-router`, `@tanstack/vue-router/ssr/server`, `@tanstack/vue-router/ssr/client` (`package.json:29-50`)

Docs: https://tanstack.com/router (framework pages verified at `/router/latest/docs/framework/vue/...`)

## Hard rules

1. **Most composables return `Ref<T>`** — use `.value` in script; templates auto-unwrap. `useRouter()`, `useNavigate()`, `useLinkProps()`, `useAwaited()` do NOT return refs. Full table in [references/composables.md](./references/composables.md).
2. **Never cast or annotate inferred route/router types.** Types come from the route tree and the `Register` declaration.
3. **Register the router for type safety** — without this, `Link`/`useNavigate`/`useSearch` accept any string:

```ts
declare module '@tanstack/vue-router' {
  interface Register {
    router: typeof router
  }
}
```

4. **Not `vue-router`.** Never import `useRoute`/`useRouter` from `vue-router`, never use `<router-view>`/`<router-link>`.
5. **`beforeLoad`/`loader` are plain async functions.** Vue composables (`ref`, `computed`, lifecycle hooks) cannot run inside them. Pass state through router `context`.
6. Route options accept Vue SFCs: `component`, `errorComponent`, `notFoundComponent`, `pendingComponent` and the `default*Component` router options take `.vue` files or `h()`-style function components (`src/route.ts:54-58`, `src/router.ts:26-65`).

## Setup with Vite (file-based routing)

```bash
npm install @tanstack/vue-router
npm install -D @tanstack/router-plugin @vitejs/plugin-vue @vitejs/plugin-vue-jsx
```

```ts
// vite.config.ts
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx'
import { tanstackRouter } from '@tanstack/router-plugin/vite'

export default defineConfig({
  plugins: [
    tanstackRouter({ target: 'vue', autoCodeSplitting: true }), // before vue()
    vue(),
    vueJsx(), // needed for .tsx route files
  ],
})
```

Source: official Vue example, https://github.com/TanStack/router/blob/main/examples/vue/basic-file-based-sfc/vite.config.ts

```ts
// src/main.ts
import { createApp, h } from 'vue'
import { RouterProvider, createRouter } from '@tanstack/vue-router'
import { routeTree } from './routeTree.gen'

const router = createRouter({
  routeTree,
  defaultPreload: 'intent',
  scrollRestoration: true,
})

declare module '@tanstack/vue-router' {
  interface Register {
    router: typeof router
  }
}

createApp({ setup: () => () => h(RouterProvider, { router }) }).mount('#app')
```

File naming, split-file conventions (`.route.ts`, `.component.vue`, `.lazy.ts`), and the generated `routeTree.gen.ts`: [references/file-based-routing.md](./references/file-based-routing.md).

## Code-based routing

```ts
import { h } from 'vue'
import { createRootRouteWithContext, createRoute, createRouter, Outlet } from '@tanstack/vue-router'

interface RouterContext { auth: { isAuthenticated: boolean } }

const rootRoute = createRootRouteWithContext<RouterContext>()({ component: () => h(Outlet) })

const postsRoute = createRoute({
  getParentRoute: () => rootRoute,
  path: 'posts',
  loader: ({ context }) => fetchPosts(context.auth),
})

const routeTree = rootRoute.addChildren([postsRoute])
const router = createRouter({
  routeTree,
  context: { auth: { isAuthenticated: false } },
})
```

Route options, hooks on route objects, and property-order rules: [references/routes.md](./references/routes.md).

## Composables

| Composable | Returns | Notes |
|---|---|---|
| `useRouter()` | router instance | not a ref |
| `useRouterState({ select })` | `Ref<T>` | pass `select` to avoid re-renders |
| `useNavigate({ from? })` | function | not a ref |
| `useSearch({ from })` | `Ref<T>` | throws unless `from` matches |
| `useParams({ from })` | `Ref<T>` | |
| `useMatch({ from })` | `Ref<T>` | |
| `useLoaderData({ from })` | `Ref<T>` | |
| `useLoaderDeps({ from })` | `Ref<T>` | |
| `useRouteContext({ from })` | `Ref<T>` | |
| `useLocation()` | `Ref<ParsedLocation>` | |
| `useMatches()` / `useParentMatches()` / `useChildMatches()` | `Ref<Array<Match>>` | accepts `select` |
| `useMatchRoute()` | function | calling it returns `Ref<false \| params>` (`src/Matches.tsx:148-172`) |
| `useLinkProps(options)` | link props object | for custom anchors |
| `useBlocker({ shouldBlockFn })` | `void` or `Ref<BlockerResolver>` | resolver only with `withResolver: true` |
| `useCanGoBack()` | `Ref<boolean>` | `location.state.__TSR_index !== 0` (`src/useCanGoBack.ts:4-10`) |
| `useAwaited({ promise })` | `[data, promise]` tuple | for deferred data |

Route objects and `getRouteApi('/path')` expose the same hooks pre-scoped: `Route.useSearch()`, `Route.useLoaderData()`, `Route.useNavigate()`, `Route.Link` (`src/route.ts:72-80`).

Details and `select`/`strict` semantics: [references/composables.md](./references/composables.md).

## Components

| Component | Purpose |
|---|---|
| `<RouterProvider :router="router" />` | mounts the router; extra attrs update router options (`src/RouterProvider.tsx:60-95`) |
| `<Link to="..." :params="..." :search="...">` | type-safe anchor; active state sets `data-status="active"` + `aria-current="page"` (`src/link.tsx:522-525`); default slot receives `{ isActive }` (`src/link.tsx:918`) |
| `<Outlet />` | renders matched child route (`src/Match.tsx:275`) |
| `<Navigate to="..." />` | declarative redirect, fires in `onMounted` (`src/useNavigate.tsx:24-40`) |
| `<MatchRoute to="..." :fuzzy="true">` | renders slot when matched; scoped slot receives params |
| `<Await :promise="p">` | deferred data with `<Suspense>` (`src/awaited.tsx:26-43`) |
| `<Block :should-block-fn="fn">` | navigation blocking; scoped slot receives resolver (`src/useBlocker.tsx:470-491`) |
| `<CatchBoundary>` / `<ErrorComponent>` | error boundary via `onErrorCaptured` |
| `<ClientOnly>` | renders children only after mount |
| `<HeadContent>`, `<Scripts>`, `<Html>`, `<Body>`, `<Asset>`, `<ScriptOnce>` | SSR document shell |

Link options, `activeProps` (defaults to `{ class: 'active' }`, `src/link.tsx:477`), preloading (`intent`/`viewport`/`render`), `linkOptions()`, and `createLink()`: [references/navigation-links.md](./references/navigation-links.md).

## Data loading and redirects

```ts
const route = createFileRoute('/posts/$postId')({
  beforeLoad: async ({ context, params }) => {
    if (!context.auth.isAuthenticated) {
      throw redirect({ to: '/login', search: { from: params.postId } })
    }
  },
  loaderDeps: ({ search: { page } }) => ({ page }),
  loader: ({ deps, params }) => fetchPost(params.postId, deps.page),
  pendingComponent: PendingSpinner, // .vue file works too
})
```

`throw redirect()`, `isRedirect()`, deferred streaming with `defer()`, and context typing: [references/data-loading.md](./references/data-loading.md).

## Search params

```ts
import { z } from 'zod' // or plain validators
const route = createFileRoute('/posts')({
  validateSearch: z.object({ page: z.number().default(1) }),
  search: {
    middlewares: [stripSearchParams({ page: 1 })],
  },
})
```

Validators, input/output schemas, `retainSearchParams`/`stripSearchParams`, and custom serialization: [references/search-params.md](./references/search-params.md).

## Deprecations in 1.170.x (use instead)

| Deprecated | Replacement | Proof |
|---|---|---|
| `Route`, `RootRoute`, `FileRoute`, `RouteApi` classes | `createRoute`, `createRootRoute`, `createFileRoute`, `getRouteApi` | `src/route.ts:95`, `src/route.ts:220`, `src/route.ts:460`, `src/fileRoute.ts:57` |
| `rootRouteWithContext` | `createRootRouteWithContext` | `src/route.ts:414` |
| `NotFoundRoute` / `routerOptions.notFoundRoute` | `notFoundComponent` route option / `defaultNotFoundComponent` router option | https://tanstack.com/router/latest/docs/framework/vue/guide/not-found-errors |
| `<ScrollRestoration />` | `scrollRestoration: true` in `createRouter` | `src/ScrollRestoration.tsx:18` |
| `opts.navigate` in `beforeLoad`/`loader` | `throw redirect({ to })` | https://tanstack.com/router/latest/docs/framework/vue/api/router/RouteOptionsType |
| `parseParams`/`stringifyParams` | `params.parse`/`params.stringify` | same RouteOptionsType doc |
| `preSearchFilters`/`postSearchFilters` | `search.middlewares` | same RouteOptionsType doc |
| `FileRouteLoader` / separate `.lazy.ts` loader files | keep the loader in the route file | `src/fileRoute.ts:153` |
| `useBlocker(fn, condition)` legacy signatures | `{ shouldBlockFn }` object | `src/useBlocker.tsx:139-151` |

## Best practices

- Set `defaultPreload: 'intent'` on the router; preloaded data is cached (default 30 s, `defaultPreloadMaxAge`) — https://tanstack.com/router/latest/docs/framework/vue/guide/preloading
- In `loaderDeps`, select only the search params the loader uses; spreading all of `search` re-runs the loader on every unrelated param change — https://tanstack.com/router/latest/docs/framework/vue/guide/data-loading
- Use `getRouteApi('/posts/$postId')` in deep components instead of importing the `Route` object (avoids circular imports) — https://tanstack.com/router/latest/docs/framework/vue/guide/data-loading
- When re-throwing from `beforeLoad` error handlers, check `isRedirect(error)` first so redirects are not swallowed — https://tanstack.com/router/latest/docs/framework/vue/guide/authenticated-routes
- Route option order is inference-sensitive (`validateSearch`/`params` before `loaderDeps`, `beforeLoad` before `loader`); the `create-route-property-order` ESLint rule is auto-fixable — https://tanstack.com/router/latest/docs/framework/vue/eslint/create-route-property-order
- Prefer `linkOptions({ to, ... })` over bare object literals for reusable navigation targets; works in `<Link>`, `navigate()`, `redirect()` — https://tanstack.com/router/latest/docs/framework/vue/guide/link-options
- With `select` returning new objects in hooks, enable `defaultStructuralSharing: true` on the router — https://tanstack.com/router/latest/docs/framework/vue/guide/render-optimizations
- External links with protocols outside `protocolAllowlist` (default `DEFAULT_PROTOCOL_ALLOWLIST`) are blocked to prevent XSS (`src/link.tsx:543-550`)

## References

- [references/api-surface.md](./references/api-surface.md) — every public export, grouped
- [references/composables.md](./references/composables.md) — hook signatures and `Ref` semantics
- [references/routes.md](./references/routes.md) — route creation, options, route hooks
- [references/navigation-links.md](./references/navigation-links.md) — `Link`, navigation, blocking, preloading
- [references/data-loading.md](./references/data-loading.md) — loaders, context, redirects, deferred data
- [references/search-params.md](./references/search-params.md) — validation and middlewares
- [references/file-based-routing.md](./references/file-based-routing.md) — Vite plugin, naming, code splitting
- [references/ssr.md](./references/ssr.md) — server entry points and document shell components
