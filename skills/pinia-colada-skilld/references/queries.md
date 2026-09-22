# Queries

`@pinia/colada` 1.4.5 query API. Types: `dist/index.d.mts` in the prepared source.

Docs: https://pinia-colada.esm.dev/guide/queries.md

## `useQuery(options | getter)`

Signature (`dist/index.d.mts:733`):

```ts
useQuery<TData, TError, TDataInitial>(options:
  | UseQueryOptions<TData, TError, TDataInitial>
  | (() => DefineQueryOptions<TData, TError, TDataInitial>)
): UseQueryReturn<TData, TError, TDataInitial>
```

Since 1.0.0 the only function form is the single getter: `useQuery(() => opts(params))`.
The removed form is `useQuery(opts, () => params)`.

### Options

| Option | Type | Default | Notes |
| --- | --- | --- | --- |
| `key` | `MaybeRefOrGetter<EntryKey>` | required | JSON-serializable array (`dist/index.d.mts:552`) |
| `query` | `(ctx: { signal, entry }) => Promise<TData>` | required | receives an `AbortSignal`; abort the fetch with it (`dist/index.d.mts:492-503`) |
| `enabled` | `MaybeRefOrGetter<boolean>` | `true` | pause/resume the query (`dist/index.d.mts:444`) |
| `staleTime` | `number` (ms) | `5000` | fresh data is not refetched on read |
| `gcTime` | `number \| false` (ms) | `300_000` | unused entries are garbage collected; `false` disables |
| `refetchOnMount` | `boolean \| 'always'` | `true` | `'always'` refetches even if fresh (`dist/index.d.mts:434`) |
| `refetchOnWindowFocus` | `boolean \| 'always'` | `true` | |
| `refetchOnReconnect` | `boolean \| 'always'` | `true` | |
| `initialData` | `() => TDataInitial` | | sets state to `success`; combine with `initialDataUpdatedAt` to control staleness (`dist/index.d.mts:564-591`) |
| `initialDataUpdatedAt` | `number \| (() => number)` | `Date.now()` | added for correct staleness of `initialData` |
| `placeholderData` | value or `(prevData, prevEntry) => value` | | shown while the first load runs; `status` reports `success`; cache state unchanged (`dist/index.d.mts:600`) |
| `meta` | `MaybeRefOrGetter<QueryMeta>` | | resolved at entry creation; must stay serializable for SSR (`dist/index.d.mts:637`) |
| `ssrCatchError` | `boolean` | `false` | catch errors during `onServerPrefetch` |

### Return values

`state`, `data`, `error`, `status`, `asyncStatus`, `isPending`
(`status === 'pending'`), `isPlaceholderData`, `isLoading`
(`asyncStatus === 'loading'`), `refresh(throwOnError?)`, `refetch(throwOnError?)`
(`dist/index.d.mts:665-719`).

- Prefer `refresh()`: it deduplicates in-flight requests and respects `staleTime`.
  Use `refetch()` only to force a network call.
- Both promises resolve to the `state` object and do not reject unless you pass
  `true`.

### Type narrowing in templates

Use `state` (a computed of the discriminated union `DataState`). Checking
`state.status === 'success'` narrows `state.data`; `state.error` narrows to
non-null on `'error'`. Separate `data`/`error` refs cannot be narrowed through
`status` in Vue templates.

## `useQueryState(key)`

Reactive read-only access to a query entry without fetching. Values are
`undefined` while the entry does not exist (`dist/index.d.mts:877-926`):

```ts
const { data, status } = useQueryState(() => contactOptions(id.value).key)
```

Since 1.0.0 the only argument is the key (or getter of key). The removed form is
`useQueryState(opts, () => params)`.

## `defineQuery`

Creates a shared, store-like query. Two forms (`dist/index.d.mts:812-835`):

```ts
// options form: static options only
const useTodoList = defineQuery({
  key: ['todos'],
  query: () => fetch('/api/todos').then(r => r.json()),
})

// setup form: runs once, must be synchronous, return anything
const useFilteredTodos = defineQuery(() => {
  const search = ref('')
  const { data, ...rest } = useQuery({
    key: () => ['todos', { search: search.value }],
    query: () => fetchTodos(search.value),
  })
  return { ...rest, todoList: data, search }
})
```

Use `defineQuery` whenever query state is shared across components; plain
composables create a new entry per component instance and only the first
instance wins key-driven reactivity
(https://pinia-colada.esm.dev/advanced/reusable-queries.md).

## `defineQueryOptions`

Returns options whose `key` is tagged with `TData`/`TError`, so
`queryCache.getQueryData(key)` / `setQueryData(key, ...)` infer types
(`dist/index.d.mts:853-869`). Three forms: static object, params function,
optional-params function.

```ts
export const DOCUMENT_KEYS = {
  root: ['documents'] as const,
  byId: (id: string) => [...DOCUMENT_KEYS.root, id] as const,
}

export const documentQuery = defineQueryOptions(
  ({ id, withComments = false }: { id: string, withComments?: boolean }) => ({
    key: DOCUMENT_KEYS.byId(id),
    query: () => getDocumentById(id, { withComments }),
  }),
)

// component usage
useQuery(() => documentQuery({ id: route.params.docId as string }))

// per-call override
useQuery(() => ({ ...documentQuery({ id }), enabled: enabled.value }))
```

Combine with key factories (arrays built from a root constant) so keys stay
consistent and invalidation by prefix works
(https://pinia-colada.esm.dev/guide/query-keys.md).

## Query fn cancellation

Pass `context.signal` into `fetch` so outdated requests abort automatically:

```ts
useQuery({
  key: ['contacts', id],
  query: ({ signal }) => fetch(`/api/contacts/${id}`, { signal }).then(r => r.json()),
})
```

External aborts surface as errors (since 0.18.0).
Docs: https://pinia-colada.esm.dev/guide/cancelling-queries.md

## Pausing queries in stores

Stores are never unmounted; a query in a store stays active forever. Guard with
`enabled`, or read the cache with `useQueryCache()` / `useQueryState()` instead
(https://pinia-colada.esm.dev/guide/queries.md).
