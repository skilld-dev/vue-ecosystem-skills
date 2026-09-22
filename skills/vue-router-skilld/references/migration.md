# Migration (vue-router v5.3.1)

## v4 → v5

Full guide: https://router.vuejs.org/guide/migration/v4-to-v5.html

- Install `vue-router@5`; drop `unplugin-vue-router` if present. The plugin moved into the core package (package.json:104-114):
  - `unplugin-vue-router/vite` → `vue-router/vite`
  - other bundlers → `vue-router/unplugin/{webpack,rollup,esbuild,rolldown}`
  - utilities (`VueRouterAutoImports`, `EditableTreeNode`, `createRoutesContext`, ...) → `vue-router/unplugin`
  - Volar plugins → `vue-router/volar/sfc-typed-router`, `vue-router/volar/sfc-route-blocks`
- Virtual module `virtual:generated-pages` → `vue-router/auto-routes`.
- Data loaders moved from `unplugin-vue-router/data-loaders` to `vue-router/experimental`; Pinia Colada loader to `vue-router/experimental/pinia-colada`.
- IIFE build no longer bundles `@vue/devtools-api` v8 (no IIFE exists for it); affects CDN/script-tag setups (https://github.com/vuejs/router/releases/tag/v5.0.0).
- Query params in typed routes are optional by default.

## v3 → v4 (still relevant when porting old apps)

Full guide: https://router.vuejs.org/guide/migration/v3-to-v4.html (release notes: https://github.com/vuejs/router/releases/tag/v4.0.0)

- `new VueRouter()` → `createRouter({...})`; history is explicit: `createWebHistory` / `createWebHashHistory` / `createMemoryHistory`; `mode: 'history'` is gone.
- Catch-all changed: `path: '*'` → `path: '/:pathMatch(.*)*'`.
- `router.onReady()` removed → `router.isReady()` returns a Promise.
- `router.app` removed → pass the app where needed.
- `scrollBehavior` returns `{ left, top }` (was `{ x, y }`).
- `router.currentRoute` is a ref: use `router.currentRoute.value`.
- `next` in guards became optional; v5.0.3 added a runtime deprecation warning for it — return a value instead.
- Dynamic route matching (`addRoute`/`removeRoute`) replaced `addRoutes`.

## Deprecations active in v5.3.1

| Deprecated | Replacement | Evidence |
|---|---|---|
| `vue-router/auto` | `vue-router/auto-routes` (+ `vue-router/auto-resolver`) | vue-router-auto.d.ts:1 |
| `new NavigationResult(to)` in loaders | `reroute(to)` | dist/experimental/index.js:1106-1111 |
| `next()` callback in guards | return values | dist/index-D7ja2BKs.d.ts:362-393 |
| `selectNavigationResult` (experimental) | removed in v5.0.3 | https://github.com/vuejs/router/releases/tag/v5.0.3 |

## In-line changes worth knowing (5.0.3 → 5.3.1)

Cited by release URL; do not trust file copies of changelogs.

- 5.0.3 — `miss()` returns `never`; `reroute()` added; `_parent` folder convention; `next()` deprecation warning. https://github.com/vuejs/router/releases/tag/v5.0.3
- 5.0.5 — Standard Schema validators usable as param parsers. https://github.com/vuejs/router/releases/tag/v5.0.5
- 5.0.7 — `RouteNamedMap` wired through the generated dts (PR #2700); `params: {}` hint in discarded-params warning; query object uses `Object.create(null)` (prototype pollution fix). https://github.com/vuejs/router/releases/tag/v5.0.7
- 5.1.0 — `defineParamParserRaw`; typed `definePage` path params; strict default typing; `TypesConfig` `Router` override; experimental export is ESM-only. https://github.com/vuejs/router/releases/tag/v5.1.0
- 5.2.0 — diagnostics for common mistakes; pinia 4 allowed. https://github.com/vuejs/router/releases/tag/v5.2.0
- 5.3.0 — scroll skipped per `history.scrollRestoration`; duplicate `definePage()` reported; `EditableTreeNode.name` unsettable→`false`. https://github.com/vuejs/router/releases/tag/v5.3.0
- 5.3.1 — `isActive` fixed for non-string params. https://github.com/vuejs/router/releases/tag/v5.3.1
