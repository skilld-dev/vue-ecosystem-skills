---
name: tanstack-vue-router-skilld
description: "Modern and scalable routing for Vue applications. ALWAYS use when writing code importing \"@tanstack/vue-router\". Consult for debugging, best practices, or modifying @tanstack/vue-router, tanstack/vue-router, tanstack vue-router, tanstack vue router, router."
metadata:
  version: 1.166.7
  generated_at: 2026-03-11
  references_synced_at: 2026-03-27
---

# TanStack/router `@tanstack/vue-router`

> Modern and scalable routing for Vue applications

**Version:** 1.166.7 (Mar 2026)
**Deps:** @tanstack/vue-store@^0.9.1, @vue/runtime-dom@^3.5.25, isbot@^5.1.22, jsesc@^3.0.2, tiny-invariant@^1.3.3, tiny-warning@^1.0.3, @tanstack/history@1.161.4, @tanstack/router-core@1.166.7
**Tags:** latest: 1.166.7 (Mar 2026)

**References:** [Docs](./references/docs/_INDEX.md) — API reference, guides
## API Changes

This section documents version-specific API changes — prioritize recent major/minor releases.

- BREAKING: `NotFoundRoute` & `routerOptions.notFoundRoute` — deprecated in v1.x; use `notFoundComponent` in route options or `defaultNotFoundComponent` in `createRouter` instead [source](./references/docs/router/guide/not-found-errors.md:L5)

- DEPRECATED: Router Classes (`Router`, `Route`, `RootRoute`, `FileRoute`) — all class-based APIs are deprecated; use factory functions `createRouter`, `createRoute`, `createRootRoute`, and `createFileRoute` instead [source](./references/docs/router/api/router/RouterClass.md:L7)

- DEPRECATED: `opts.navigate` — the `navigate` argument inside `beforeLoad` and `loader` is deprecated; use `throw redirect({ to: '...' })` for navigation-triggered redirects instead [source](./references/docs/router/api/router/RouteOptionsType.md:L118)

- DEPRECATED: `parseParams` & `stringifyParams` — top-level route properties deprecated in favor of the nested `params.parse` and `params.stringify` objects [source](./references/docs/router/api/router/RouteOptionsType.md:L68)

- DEPRECATED: `preSearchFilters` & `postSearchFilters` — deprecated in favor of `search.middlewares` array which provides a composable middleware pipeline for transforming search params [source](./references/docs/router/api/router/RouteOptionsType.md:L225)

- DEPRECATED: `<ScrollRestoration />` component — deprecated; configure scroll restoration via `scrollRestoration: true` in `createRouter` options instead [source](./references/docs/router/guide/scroll-restoration.md:L64)

- NEW: `protocolAllowlist` — `createRouter` option accepting `Array<string>` of allowed URL protocols (e.g. `'https:'`, `'mailto:'`); absolute URLs with unlisted protocols are blocked to prevent XSS; also exports `DEFAULT_PROTOCOL_ALLOWLIST` constant [source](./references/docs/router/api/router/RouterOptionsType.md:L147)

- NEW: `search.middlewares` — route option accepting an array of middleware functions `({search, next}) => search` for composable search param transformation when generating links; use with `retainSearchParams` and `stripSearchParams` helpers [source](./references/docs/router/api/router/RouteOptionsType.md:L61)

- NEW: `head`, `headers`, `scripts` — route option methods for server-side document management; `head()` injects `<meta>`, `<link>`, `<style>` into `<head>`; `headers()` sets HTTP response headers; `scripts()` injects `<script>` tags [source](./references/docs/router/api/router/RouteOptionsType.md:L304)

- NEW: Validation Adapters — `@tanstack/zod-adapter`, `@tanstack/valibot-adapter`, and `@tanstack/arktype-adapter` provide schema-based validation for search params and route params with distinct input/output type inference [source](./references/docs/router/guide/search-params.md#zod)

- NEW: `defaultViewTransition` — `createRouter` option accepting `boolean | ViewTransitionOptions` to enable native View Transitions API (`document.startViewTransition()`) during navigation; supports `types` array via `ViewTransitionOptions` [source](./references/docs/router/api/router/RouterOptionsType.md:L182)

- NEW: `rewrite` — `createRouter` option accepting `{ input?, output? }` for bidirectional URL transformation between browser URL and router's internal URL; `input` transforms before matching, `output` transforms before writing to history [source](./references/docs/router/api/router/RouterOptionsType.md:L217)

- NEW: `Wrap` & `InnerWrap` — `createRouter` options for injecting global providers; `Wrap` surrounds the entire router, `InnerWrap` wraps inner content and has access to router context and hooks [source](./references/docs/router/api/router/RouterOptionsType.md:L295)

- NEW: `codeSplitGroupings` — route option `Array<Array<'loader' | 'component' | 'pendingComponent' | 'notFoundComponent' | 'errorComponent'>>` for fine-grained control over how lazy-loaded route assets are bundled into chunks [source](./references/docs/router/api/router/RouteOptionsType.md:L364)

**Also changed:** `rootRouteWithContext` deprecated → use `createRootRouteWithContext` · `useCanGoBack()` new experimental hook · `defaultRemountDeps` new router option · `defaultStructuralSharing` new router option · `search.strict` new router option · `disableGlobalCatchBoundary` new router option · `scrollToTopSelectors` new router option · `composeRewrites` new export · `ClientOnly` / `ScriptOnce` / `HeadContent` / `Asset` new components · `SearchSchemaInput` tag for optional search params · `state.__TSR_key` replaces deprecated `state.key`

## Best Practices

- Use `zodValidator()` adapter with `fallback()` instead of Zod's `.catch()` for search param validation — `.catch()` widens types to `unknown`, losing type inference, while `fallback(z.number(), 1).default(1)` retains correct types and makes `search` optional in `<Link>` props [source](./references/docs/router/guide/search-params.md#zod)

- In `loaderDeps`, extract only the search params actually used in the loader — returning the entire `search` object causes the loader to re-run on any search param change, even unrelated ones like `viewMode` or `sortDirection` [source](./references/docs/router/guide/data-loading.md#using-loaderdeps-to-access-search-params)

- Use `getRouteApi('/your/path')` to access route hooks (`useLoaderData`, `useSearch`, `useParams`) in deeply nested components instead of importing the `Route` object — direct `Route` imports from child components create circular dependencies [source](./references/docs/router/guide/data-loading.md#consuming-data-from-loaders)

- Enable `defaultStructuralSharing: true` on the router when using `select` in hooks like `useSearch` — without it, `select` returning a new object on every call triggers unnecessary re-renders even when values are unchanged [source](./references/docs/router/guide/render-optimizations.md#structural-sharing-with-fine-grained-selectors)

- Use `createRootRouteWithContext<YourContextType>()` instead of `createRootRoute` when injecting shared dependencies (auth, query client, etc.) — this enforces the context type at router creation time and makes `context` available with full type inference in all descendant `beforeLoad` and `loader` functions [source](./references/docs/router/guide/router-context.md#typed-router-context)

- Property order inside `createFileRoute`, `createRoute`, and `createRootRoute` objects is inference-sensitive: `params`/`validateSearch` must come before `loaderDeps`, `beforeLoad` before `loader`, etc. — wrong order causes type errors where `context` from `beforeLoad` isn't visible in `loader`. Install `@tanstack/eslint-plugin-router` and enable the `create-route-property-order` rule (it's fixable) [source](./references/docs/router/eslint/create-route-property-order.md#rule-details)

- Use `retainSearchParams(['key'])` and `stripSearchParams(defaultValues)` as `search.middlewares` on a route rather than manually forwarding params in every `<Link>` — middlewares run automatically on all descendant links and on navigation, keeping the URL clean without repetitive spread patterns [source](./references/docs/router/guide/search-params.md#transforming-search-with-search-middlewares)

- When throwing `redirect()` inside `beforeLoad` error handlers, always re-throw errors identified by `isRedirect()` before converting other errors — otherwise intentional redirects are swallowed as route errors [source](./references/docs/router/guide/authenticated-routes.md#handling-auth-check-failures)

- Use `linkOptions({ to, search, ... })` to define reusable navigation targets instead of plain object literals — bare object literals infer `to` as `string` (matching every route) and defer type errors until the object is spread into `<Link>`. `linkOptions` validates the destination at definition time and the same value works in `<Link>`, `navigate()`, and `redirect()` [source](./references/docs/router/guide/link-options.md#using-linkoptions-function-to-create-re-usable-options)

- Set `defaultPreload: 'intent'` on the router to preload route data and code-split chunks on link hover — preloaded data is cached for 30 seconds (configurable via `defaultPreloadMaxAge`) and prevents loader waterfalls on navigation without any per-link configuration [source](./references/docs/router/guide/preloading.md#supported-preloading-strategies)
