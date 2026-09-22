# Server-side rendering

`@pinia/colada` 1.4.5. SSR builds on Pinia's SSR story plus custom cache
serialization.

Docs: https://pinia-colada.esm.dev/guide/ssr.md

## Nuxt

The `@pinia/colada-nuxt` module handles serialization automatically.
Install and configure it in `nuxt.config.ts`
(https://pinia-colada.esm.dev/nuxt.md). In Nuxt, import `useRoute` from
`vue-router` explicitly inside `defineQuery` files that use it; relying on
auto-imports inside module context can trigger unnecessary fetches.

## Custom SSR: serialize and hydrate

The query cache needs its own serialization. With `devalue`:

```ts
import devalue from 'devalue'
import { isQueryCache, serializeQueryCache, hydrateQueryCache, useQueryCache } from '@pinia/colada'

// server
const stringified = devalue.stringify(useQueryCache(pinia), {
  PiniaColada_TreeMapNode: (data: unknown) =>
    isQueryCache(data) && serializeQueryCache(data),
})

// client: install pinia and PiniaColada first, then
const revived = devalue.parse(stringified, {
  PiniaColada_TreeMapNode: data => data,
})
hydrateQueryCache(useQueryCache(pinia), revived)
```

Exports involved (`dist/index.d.mts:390-427`): `isQueryCache`,
`serializeQueryCache`, `hydrateQueryCache`, `isMutationCache`.

Errors need their own serialization if you SSR them (see the devalue custom
types guide and https://pinia-colada.esm.dev/guide/ssr.md).

## Skipping queries on the server

```ts
useQuery({
  key: ['restaurants', { search: true }],
  query: () => findRestaurants(),
  enabled: typeof document !== 'undefined', // or !import.meta.env.SSR in Vite
})
```

To let a query fail softly during `onServerPrefetch` instead of failing the
render, set `ssrCatchError: true` (`dist/index.d.mts:482-487`).

## Avoid GC timers on the server

Use the bundled `PiniaColadaSSRNoGc` plugin (1.3.0) so pending `setTimeout`
calls do not keep the Node process alive between requests:

```ts
app.use(PiniaColada, {
  plugins: import.meta.env.SSR ? [PiniaColadaSSRNoGc()] : [],
})
```

## SSR-safe `meta`

`meta` is serialized during SSR. Keep it plain serializable data, or skip
non-serializable values:

```ts
useQuery({
  key: ['user', id],
  query: () => fetchUser(id),
  meta: { errorMessage: 'Could not load user' },
})
```
