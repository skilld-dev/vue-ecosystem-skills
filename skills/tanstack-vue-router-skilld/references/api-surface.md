# API surface

Every public export of `@tanstack/vue-router` 1.170.35, from `src/index.tsx`. Re-exported router-core and history APIs are marked.

## Router and route factories

- `createRouter(options)` → router instance (`src/router.ts:77-79`)
- `createRoute(options)`, `createRootRoute(options)`, `createRootRouteWithContext<TContext>()` (`src/route.ts:282`, `src/route.ts:601`, `src/route.ts:376`)
- `createFileRoute(path)`, `createLazyRoute(id)`, `createLazyFileRoute(path)` (`src/fileRoute.ts:38-54`, `src/index.tsx:128-134`)
- `createRouteMask(opts)`, `getRouteApi(id)` (`src/route.ts:511`, `src/route.ts:83`)
- Deprecated classes still exported: `Router`, `Route`, `RootRoute`, `RouteApi`, `NotFoundRoute`, `FileRoute`, `LazyRoute`, `FileRouteLoader`

## Components

`RouterProvider`, `RouterContextProvider`, `Link`, `MatchRoute`, `Match`, `Outlet`, `Navigate`, `Await`, `Block`, `CatchBoundary`, `ErrorComponent`, `CatchNotFound`, `DefaultGlobalNotFound`, `ScrollRestoration` (deprecated), `HeadContent`, `Scripts`, `ScriptOnce`, `Body`, `Html`, `Asset`, `ClientOnly`, `Matches` (internal render tree root).

## Composables

`useRouter`, `useRouterState`, `useNavigate`, `useMatchRoute`, `useMatches`, `useParentMatches`, `useChildMatches`, `useMatch`, `useSearch`, `useParams`, `useLoaderData`, `useLoaderDeps`, `useRouteContext`, `useLocation`, `useLinkProps`, `useBlocker`, `useCanGoBack`, `useAwaited`, `useElementScrollRestoration`, `useTags`.

## Link utilities

- `createLink(Comp)` — wraps a Vue component so it renders like `Link` (`src/link.tsx:846-856`)
- `linkOptions(options)` — identity function that validates link option objects at definition time (`src/link.tsx:967-969`)
- `lazyRouteComponent(importer, exportName?, ssr?)` — lazy component with preload and one-shot reload on stale module errors after deploy (`src/lazyRouteComponent.tsx:23-156`)

## Router-core re-exports

`defer`, `redirect`, `isRedirect`, `notFound`, `isNotFound`, `isMatch`, `retainSearchParams`, `stripSearchParams`, `createSerializationAdapter`, `defaultParseSearch`, `defaultStringifySearch`, `parseSearchWith`, `stringifySearchWith`, `functionalUpdate`, `replaceEqualDeep`, `deepEqual`, `createControlledPromise`, `lazyFn`, `SearchParamError`, `createRouterConfig`, `composeRewrites`, `DEFAULT_PROTOCOL_ALLOWLIST`, path utilities (`joinPaths`, `cleanPath`, `trimPath*`, `resolvePath`, `interpolatePath`).

## History re-exports (from @tanstack/history)

`createHistory`, `createBrowserHistory`, `createHashHistory`, `createMemoryHistory`; types `RouterHistory`, `HistoryLocation`, `ParsedPath`, `HistoryState`, `BlockerFn`.

## Key types

`Register`, `RegisteredRouter`, `RouterOptions`, `RouterState`, `RouteOptions`, `FileBaseRouteOptions`, `UpdatableRouteOptions`, `RouteConstraints`, `AnyRoute`, `AnyRouter`, `RouteMatch`, `MakeRouteMatch`, `LinkOptions`, `LinkProps`, `ActiveLinkOptions`, `NavigateOptions`, `ToOptions`, `Redirect`, `NotFoundError`, `ErrorComponentProps`, `NotFoundRouteProps`, `ParsedLocation`, `SearchSchemaInput`, `ValidatorAdapter`, `FileRoutesByPath`, `RouteById`, `CreateFileRoute`, `ViewTransitionOptions` (via `RouterOptions`), `VueNode`, `SyncRouteComponent`, `AsyncRouteComponent`, `RouteComponent`, `ErrorRouteComponent`, `NotFoundRouteComponent`, `LocationRewrite`, `LocationRewriteFunction`.

Framework-shared type docs: https://tanstack.com/router/latest/docs/framework/vue/api/router/RouterOptionsType

## Subpath exports

- `@tanstack/vue-router/ssr/server`: `RouterServer`, `defaultRenderHandler`, `defaultStreamHandler`, `renderRouterToStream`, `renderRouterToString` (`src/ssr/server.ts:1-6`)
- `@tanstack/vue-router/ssr/client`: `RouterClient` (`src/ssr/client.ts:1`)
- `@tanstack/vue-router/package.json`

A `development` export condition serves `dist/esm/index.dev.js` for dev bundles (`package.json:29-36`).
