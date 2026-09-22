# Query and mutation caches

`@pinia/colada` 1.4.5 cache APIs. `useQueryCache` and `useMutationCache` are
Pinia setup stores; use them in components, composables, stores, and navigation
guards (`dist/index.d.mts:351-377`, `dist/index.d.mts:1157-1174`).

Docs: https://pinia-colada.esm.dev/advanced/query-cache.md

## `useQueryCache()` actions

| Action | Notes |
| --- | --- |
| `getQueryData(key)` | typed if the key comes from `defineQueryOptions` (`dist/index.d.mts:361`) |
| `setQueryData(key, dataOrUpdater)` | updater receives old data (`dist/index.d.mts:359`) |
| `setQueriesData(filters, updater)` | bulk update matching entries (`dist/index.d.mts:360`) |
| `invalidateQueries(filters?, refetchActive?)` | marks stale; refetches active queries; returns a promise (`dist/index.d.mts:362`) |
| `cancelQueries(filters?, reason?)` | aborts matching in-flight requests (`dist/index.d.mts:363`) |
| `getEntries(filters?)` | list matching entries |
| `get(key)` | the raw `UseQueryEntry` |
| `setEntryState(entry, state)` | manual state sync; preferred way to reset state (`dist/index.d.mts:375`) |
| `ensure(opts, previousEntry?)`, `fetch`, `refresh`, `create`, `remove`, `invalidate`, `cancel` | lower-level entry operations |

`setQueryData` cannot reset state by writing `undefined`; use `setEntryState`.

## Filters

Filters match by key prefix by default (`dist/index.d.mts:148-213`):

```ts
queryCache.invalidateQueries()                             // everything
queryCache.invalidateQueries({ key: ['contacts'] })        // prefix match
queryCache.invalidateQueries({ key: ['contacts'], exact: true })
queryCache.invalidateQueries({ key: ['todos'], stale: true, active: null })
queryCache.invalidateQueries({ status: 'error', predicate: e => e.key.length > 2 })
```

- `exact: true` requires `key` and skips children.
- `stale`, `active`, `status` narrow by entry state; `predicate` receives the entry.

Invalidation marks entries stale and refetches active ones. Pass
`refetchActive: 'all'` to also refetch inactive entries.
Docs: https://pinia-colada.esm.dev/guide/query-invalidation.md

## Entries

A `UseQueryEntry` exposes `state` (shallow ref of `DataState`), `asyncStatus`,
`key`, `keyHash`, `when` (last data timestamp, 0 after invalidation), `stale`,
`active`, `meta`, and `pending` (abort controller plus refresh promise)
(`dist/index.d.mts:227-325`). Do not replace `entry.ext`; only add properties.

## `useMutationCache()` actions

`get(id)` (mutation ids are incremented numbers since 0.19.0), `getEntries(filters?)`,
`create`, `ensure`, `mutate`, `remove`, `setEntryState`
(`dist/index.d.mts:1157-1174`). To observe a mutation from another component,
give the mutation a `key` and use `getEntries({ key })`.

## Prefetching

In guards or plugins, create options with `defineQueryOptions` and prime the
cache before navigation:

```ts
const entry = queryCache.ensure(todoOptions(id))
queryCache.refresh(entry)
```

Docs: https://pinia-colada.esm.dev/cookbook/prefetching.md

## SSR helpers

`serializeQueryCache(cache)` / `hydrateQueryCache(cache, data)` /
`isQueryCache(obj)` / `isMutationCache(obj)` (`dist/index.d.mts:390-427`).
See [ssr.md](./ssr.md).

## Testing

Create a fresh pinia per test, install `PiniaColada`, and drive assertions via
`useQueryCache`. Docs: https://pinia-colada.esm.dev/cookbook/testing.md

## Runtime error and warning codes

Current codes with full explanations:
https://pinia-colada.esm.dev/errors/

| Code | Meaning |
| --- | --- |
| `PINIA_COLADA_C0001` | root pinia plugin not detected |
| `PINIA_COLADA_R0001` | cache composable called outside of an injection context |
| `PINIA_COLADA_R0002` | the cache cannot be directly set |
| `PINIA_COLADA_R0003` | `useQuery()` was called with an empty key |
| `PINIA_COLADA_R0004` | entry has no options |
| `PINIA_COLADA_R0005` | mutation entry mutated before being ensured |
| `PINIA_COLADA_R0006` | mutation entry reused |
| `PINIA_COLADA_R0007` | `defineMutation()` called outside of a component or effect scope |
| `PINIA_COLADA_R0008` | missing `getPreviousPageParam` (called `loadPreviousPage` without it) |
| `PINIA_COLADA_R0009` | query entry not found in cache |
