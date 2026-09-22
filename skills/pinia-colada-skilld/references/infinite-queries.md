# Infinite queries

`@pinia/colada` 1.4.5 infinite query API. Types: `dist/index.d.mts:928-1089`.

Docs: https://pinia-colada.esm.dev/guide/infinite-queries.md

`useInfiniteQuery` merges pages into a single cache entry. Data shape is
`{ pages: TData[], pageParams: TPageParam[] }`
(`dist/index.d.mts:932-941`). Use plain `useQuery` with the page in the key
when you want each page as a separate entry
(https://pinia-colada.esm.dev/guide/paginated-queries.md).

## Basic usage

```ts
import { useInfiniteQuery } from '@pinia/colada'

const { data, hasNextPage, loadNextPage, asyncStatus } = useInfiniteQuery({
  key: () => ['feed', { search: search.value }],
  initialPageParam: 1,
  query: ({ pageParam, signal }) =>
    fetch(`/api/feed?page=${pageParam}`, { signal }).then(r => r.json()),
  getNextPageParam: (lastPage) => lastPage.nextPage ?? null,
})
```

## Options beyond `useQuery`

| Option | Notes |
| --- | --- |
| `initialPageParam` | required; value or function (`dist/index.d.mts:961`) |
| `getNextPageParam` | required; `(lastPage, allPages, lastPageParam, allPageParams)`. Return `null`/`undefined` to signal no more pages (`dist/index.d.mts:973`) |
| `getPreviousPageParam` | optional; enables `hasPreviousPage` / `loadPreviousPage` (`dist/index.d.mts:979`) |
| `maxPages` | keep only the N most recent pages; oldest pages are dropped (`dist/index.d.mts:967`) |

## Return values

Everything from `useQuery` plus `hasNextPage`, `loadNextPage(options?)`,
`hasPreviousPage`, `loadPreviousPage(options?)` (`dist/index.d.mts:1006-1026`).
Load options: `throwOnError` (default false), `cancelRefetch` (default true).

## Key design

Put filters in the key, never the `pageParam`. A changed key creates a new
cache entry, which resets pagination.

## Cursor-based pagination

```ts
useInfiniteQuery({
  key: ['notifications'],
  initialPageParam: null as string | null,
  query: ({ pageParam }) => api.listNotifications({ cursor: pageParam }),
  getNextPageParam: (lastPage) => lastPage.nextCursor ?? null,
})
```

## `defineInfiniteQueryOptions` (1.2.0) and getter form

Same pattern as `defineQueryOptions`: returns tagged options for type-safe
cache access; `useInfiniteQuery` accepts a getter of the result
(`dist/index.d.mts:1046-1089`):

```ts
const feedOptions = defineInfiniteQueryOptions((search: string) => ({
  key: ['feed', { search }],
  initialPageParam: 1,
  query: ({ pageParam }) => fetchFeed(search, pageParam),
  getNextPageParam: (lastPage) => lastPage.nextPage ?? null,
}))

useInfiniteQuery(() => feedOptions(search.value))
```

## `setInfiniteQueryData` (1.2.0)

Use instead of `queryCache.setQueryData` when priming an infinite entry (for
example from a mutation elsewhere). It marks the entry as infinite and
initializes `hasNextPage` extensions (`dist/index.d.mts:1028-1039`):

```ts
import { setInfiniteQueryData } from '@pinia/colada'

setInfiniteQueryData(queryCache, ['feed'], (old) =>
  old ? { ...old, pages: [...old.pages, newPage] } : {
    pages: [newPage], pageParams: [1],
  },
)
```
