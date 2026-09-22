# Core API (vue-router@5.3.1)

Source of truth: `dist/index-D7ja2BKs.d.ts` and `dist/vue-router.d.ts` in the prepared package.

## Creating the router

```ts
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(), // or createWebHashHistory(), createMemoryHistory()
  routes: [...],
  scrollBehavior(to, from, savedPosition) {
    return savedPosition ?? { top: 0, left: 0 } // v4+: left/top, not x/y
  },
  strict: false,          // trailing slash matters?
  sensitive: false,       // case-sensitive matching?
  end: true,              // should the path match to the end
  linkActiveClass: '...',
  linkExactActiveClass: '...',
  parseQuery, stringifyQuery, // custom query (de)serialization
})
```

`createWebHistory(base?)` needs server rewrite rules; `createWebHashHistory()` works without server config but hurts SEO; `createMemoryHistory()` for SSR tests and no URL at all.

## Programmatic navigation

```ts
router.push('/users/1')
router.push({ name: 'user', params: { id: '1' }, query: { tab: 'info' }, hash: '#bio' })
router.replace({ path: '/login' })
router.go(-1); router.back(); router.forward()

const failure = await router.push('/admin')
if (isNavigationFailure(failure, NavigationFailureType.aborted)) { /* ... */ }
```

- `push`/`replace` resolve to `NavigationFailure | void | undefined`; a caught redirect rejection carries `NavigationRedirectError` with `.to` (dist/index-D7ja2BKs.d.ts:325-338).
- Duplicated navigation resolves with `NavigationFailureType.duplicated`, it does not throw.
- `router.resolve(to)` returns a resolved location with `href`, `name`, `params`, `matched`.
- `router.hasRoute(name)`, `router.getRoutes()`, `router.addRoute(...)` (returns a remove callback), `router.removeRoute(name)` — dynamic routing.

## Navigation guards

Order: `beforeEach` → per-route `beforeEnter` → in-component `beforeRouteUpdate`/`beforeRouteLeave` → async components resolved → `beforeResolve` → `afterEach`.

```ts
router.beforeEach(async (to, from) => {
  if (to.meta.requiresAuth) {
    const store = useAuth() // via inject(): allowed since Vue 3.3
    return store.user ? true : { name: 'login', query: { redirect: to.fullPath } }
  }
})

router.beforeResolve(to => {
  // async components are resolved here; good spot for final checks
  if (to.meta.requiresCamera && !(await askCamera())) return false
})

router.afterEach((to, from, failure) => {
  if (isNavigationFailure(failure)) logFailure(failure)
})

router.onError((error, to, from) => { /* uncaught errors during navigation */ })
```

- Return values instead of `next()`; `next` is deprecated (type docs mark it deprecated at dist/index-D7ja2BKs.d.ts:362-393, runtime warning since v5.0.3).
- Return `false` to cancel, a `RouteLocationRaw` to redirect, throw/reject to abort with error.
- Per-record: `beforeEnter` on the route record (array supported).
- In-component (Options API): `beforeRouteEnter` (no `this`; use `next(vm => ...)` legacy or none), `beforeRouteUpdate`, `beforeRouteLeave`.
- Composition API: `onBeforeRouteLeave` / `onBeforeRouteUpdate` (exported from `vue-router`).

## Route records

```ts
const routes = [
  { path: '/users/:id', name: 'user', component: User, props: true },
  { path: '/users/:id+', component: User, props: true },          // repeatable: string[]
  { path: '/users/:id?', component: User },                       // optional
  { path: '/:pathMatch(.*)*', name: 'not-found', component: NF }, // catch-all
  { path: '/old', redirect: { name: 'home' } },                    // redirect: string | obj | fn
  { path: '/home', alias: '/', component: Home },                  // aliases
  { path: '/admin', component: AdminLayout, children: [
    { path: 'settings', components: { default: Settings, aux: Aux } }, // named views
  ] },
]
```

- Params are `string | string[]` by default; encode with `params: { id: String(user.id) }`.
- `props: true` passes `route.params` as props; object mode passes constants; function mode `props: route => ({ q: route.query.q })` maps anything.
- `meta` fields are merged (non-recursively) from parent to child; `to.meta.requiresAuth` already includes parent values.
- Type `meta`:

```ts
declare module 'vue-router' {
  interface RouteMeta {
    requiresAuth?: boolean
    title?: string
  }
}
```

## RouterLink / RouterView

```vue
<RouterLink :to="{ name: 'user', params: { id: 42 } }" active-class="on" replace custom>
  <a :href="href" @click="navigate">{{ route.fullPath }}</a>
</RouterLink>
<RouterView v-slot="{ Component, route }">
  <component :is="Component" :key="route.params.id" />
</RouterView>
```

- `useLink()` exposes `route`, `href`, `isActive`, `isExactActive`, `navigate` for custom link components (dist/vue-router.d.ts:6).
- `<RouterView name="aux">` renders a named view; `route.matched` holds the resolved record chain.

## Composition API

```ts
const route = useRouter().currentRoute.value // outside setup
// inside setup:
const route = useRoute()      // reactive, current location
const router = useRouter()   // router instance
```

- Watch narrow slices: `watch(() => route.params.id, load)`.
- `route.query` values are `string | null | (string | null)[]`; `null` means `?flag` without `=`.
- `route.fullPath` = path + query + hash; `route.hash` includes the leading `#`.

## SSR

- Use `createMemoryHistory()` on the server (or `createRouter` with the right history per environment), push the initial location server-side, `await router.isReady()`.
- `router.isReady()` resolves after the initial navigation (dist/index-D7ja2BKs.d.ts:1544-1554).

## Troubleshooting

- "No match found for location with path": add a catch-all `/:pathMatch(.*)*`; check `router.getRoutes()`.
- Params discarded on navigation: push by `name` with exact `params`; the matcher warns and hints at the `params: {}` workaround (v5.0.7, https://github.com/vuejs/router/releases/tag/v5.0.7).
- Navigation cancelled/aborted without error: inspect the resolved failure from `await push()`.
