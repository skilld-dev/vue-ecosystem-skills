# Routes and route options

## Creation

- Code-based: `createRoute({ getParentRoute: () => parentRoute, path, ...options })`, then compose with `rootRoute.addChildren([...])`. `path` is relative to the parent; use `path: '/posts'` only at the top level.
- Root: `createRootRoute(options)`; with injected context: `createRootRouteWithContext<TRouterContext>()(options)` — the context type is then enforced by `createRouter({ context })` (`src/route.ts:376-411`).
- File-based: `createFileRoute('/posts/$postId')(options)` — the path argument is validated against the generated `FileRoutesByPath` (`src/fileRoute.ts:38-54`).
- Lazy: `createLazyRoute(id)` / `createLazyFileRoute(path)` return route option subsets loaded on demand.

Components in options accept `.vue` SFC imports, `defineComponent` results, or `(props) => VNode` functions (`src/route.ts:54-66`).

## Frequently used options

| Option | Purpose |
|---|---|
| `component`, `pendingComponent`, `errorComponent`, `notFoundComponent` | render pipeline; router-level fallbacks via `defaultComponent`, `defaultPendingComponent`, `defaultErrorComponent`, `defaultNotFoundComponent` (`src/router.ts:18-75`) |
| `validateSearch` | schema or `(search) => search` producing typed search (`references/search-params.md`) |
| `params.parse` / `params.stringify` | custom path param codecs (replace deprecated `parseParams`/`stringifyParams`) |
| `loaderDeps`, `loader` | data loading (`references/data-loading.md`) |
| `beforeLoad` | guard; may `throw redirect()` / `notFound()`; returns route context |
| `head`, `headers`, `scripts` | server-side document management (meta/link/style tags, HTTP headers, script tags) — https://tanstack.com/router/latest/docs/framework/vue/guide/document-head-management |
| `search.middlewares` | composable search transform pipeline; helpers `retainSearchParams`, `stripSearchParams` |
| `preloader` | custom preloading per route |
| `staleTime`, `preloadStaleTime`, `gcTime` | caching windows |
| `remountDeps` | `(opts) => boolean | 'after' | 'before'`; re-mount the component when deps change |
| `context` (partial), `select`, `shouldThrow` | consumed by route hooks |
| `ssr: false` or `'data-only'` | skip or data-only SSR for the route (`src/Match.tsx:67`) |
| `codeSplitGroupings` | chunk grouping for split assets: `Array<Array<'loader'\|'component'\|'pendingComponent'\|'notFoundComponent'\|'errorComponent'>>` |
| `caseSensitive`, `enableRouteMasking` (with `createRouteMask`) | matching and URL masking |

Full option docs: https://tanstack.com/router/latest/docs/framework/vue/api/router/RouteOptionsType

## Property order matters for inference

`validateSearch` and `params` must precede `loaderDeps`; `beforeLoad` must precede `loader`; otherwise `context` and deps do not flow through. The `@tanstack/eslint-plugin-router` rule `create-route-property-order` is auto-fixable — https://tanstack.com/router/latest/docs/framework/vue/eslint/create-route-property-order

## Router options highlights

- `routeTree` (required), `context`, `basepath`, `defaultPreload` (`'intent' | 'viewport' | 'render' | false`), `defaultPreloadMaxAge` (default 30 000 ms), `defaultPreloadDelay`
- `defaultStaleTime`, `defaultGcTime`, `defaultStructuralSharing` (enables structural sharing for `select` results), `defaultRemountDeps`
- `scrollRestoration: true`, `scrollToTopSelectors`
- `notFoundMode`, `defaultNotFoundComponent`, `disableGlobalCatchBoundary` (removes the root `CatchBoundary`, `src/Matches.tsx:104`)
- `trailingSlash`, `stringifySearch`/`parseSearch`, `search.strict`
- `defaultViewTransition: boolean | ViewTransitionOptions` (View Transitions API)
- `protocolAllowlist` + exported `DEFAULT_PROTOCOL_ALLOWLIST` (XSS guard for absolute URLs)
- `rewrite: { input?, output? }` and `composeRewrites(...)` for bidirectional URL transformation
- `Wrap` / `InnerWrap` components wrap the whole tree or inner content (`src/router.ts:57-65`)
- `history: createBrowserHistory() | createHashHistory() | createMemoryHistory()`

Full list: https://tanstack.com/router/latest/docs/framework/vue/api/router/RouterOptionsType

## Router instance methods

`router.navigate(options)`, `router.buildLocation(options)`, `router.invalidate()`, `router.matchRoute(...)`, `router.preloadRoute(...)`, `router.subscribe('onBeforeNavigate', listener)`, `router.dispose()`. Events: `onBeforeLoad`, `onLoad`, `onBeforeNavigate`, `onNavigation`, `onResolved`, `onRendered` — https://tanstack.com/router/latest/docs/framework/vue/api/router/RouterEventsType
