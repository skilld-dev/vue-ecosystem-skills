# Composables

All composables are imported from `@tanstack/vue-router`. The #1 difference from the React bindings: subscription hooks return `Vue.Ref<T>`.

## Returns `Ref<T>`

- `useSearch(opts)` — `Ref<search>`; opts: `{ from, strict?, shouldThrow?, select? }` (`src/useSearch.tsx:49-74`)
- `useParams(opts)` — `Ref<params>`; same option shape
- `useMatch(opts)` — `Ref<match>`; `select` receives the whole match (`src/useMatch.tsx:60-76`)
- `useLoaderData(opts)` / `useLoaderDeps(opts)` — `Ref<loaderData>` / `Ref<deps>`
- `useRouteContext(opts)` — `Ref<context>` produced by `beforeLoad`
- `useLocation()` — `Ref<ParsedLocation>`
- `useRouterState({ select? })` — `Ref<RouterState>` or selected slice. Always pass `select` for the field you need; subscribing to the whole state re-renders on any router change (`src/useRouterState.tsx:21-59`)
- `useMatches({ select? })` — `Ref<Array<RouteMatch>>`; `useParentMatches`/`useChildMatches` slice relative to the calling route (`src/Matches.tsx:272-321`)
- `useCanGoBack()` — `Ref<boolean>`, true when `location.state.__TSR_index !== 0` (`src/useCanGoBack.ts:4-10`)
- `useBlocker({ shouldBlockFn, withResolver: true })` — `Ref<BlockerResolver>`:

```ts
const blocker = useBlocker({
  shouldBlockFn: ({ current, next }) => !saved.value,
  withResolver: true,
})
// blocker.value.status === 'blocked' → blocker.value.proceed() | .reset()
```

(`src/useBlocker.tsx:131-266`; without `withResolver` the hook returns `void`.)

## Does NOT return a ref

- `useRouter()` — the router instance: `router.navigate(...)`, `router.invalidate()`, `router.buildLocation(...)`, `router.options`
- `useNavigate({ from? })` — a typed navigate function (`src/useNavigate.tsx:11-22`)
- `useLinkProps(options)` — computed link props (`href`, event handlers, `data-status`) to spread on an anchor; unref before spreading in JSX (`src/link.tsx:92-102`)
- `useMatchRoute()` — returns a matcher function; calling it with `{ to, params?, fuzzy?, caseSensitive?, pending?, includeSearch? }` returns `Ref<false | params>` (`src/Matches.tsx:138-173`)
- `useAwaited({ promise })` — returns `[data, promise]`; throws the deferred promise while pending, so it pairs with `<Suspense>` (`src/awaited.tsx:10-24`)
- `useElementScrollRestoration({ id, getElement })` — scroll restoration entry for a specific element (`src/ScrollRestoration.tsx:32-49`)
- `useTags()` — current head tags (SSR shell internals)

## `strict` and `from`

Hooks that take `{ from }` (`useMatch`, `useSearch`, `useParams`, `useLoaderData`, `useLoaderDeps`, `useRouteContext`):

- `from` is the route id (file-based: full path like `/posts/$postId`). Omit it only inside the route's own component.
- `strict: false` reads from the nearest matching parent instead; required when the hook runs in a component not owned by that route.
- `shouldThrow: false` downgrades a missing match from a thrown error to `undefined`.

## Pre-scoped hooks on routes

`Route.useSearch()`, `Route.useMatch()`, `Route.useParams()`, `Route.useLoaderDeps()`, `Route.useLoaderData()`, `Route.useRouteContext()`, `Route.useNavigate()`, `Route.Link` are bound to the route (`src/route.ts:245-279`). `getRouteApi(id)` returns the same surface for arbitrary components (`src/route.ts:83-148`); its `useLoaderData`/`useLoaderDeps` default to `strict: false` (`src/route.ts:117-123`).
