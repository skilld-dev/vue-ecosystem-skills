# QueryClient in Vue

The Vue `QueryClient` subclasses core's to accept reactive arguments (`src/queryClient.ts:44-622`). Docs: https://tanstack.com/query/latest/docs/reference/QueryClient

## Reactive arguments

Every method taking a query key, filters, or an options object accepts `MaybeRefDeep` versions: refs nested anywhere are unwrapped at call time (`src/queryClient.ts:60-77` example pattern).

```ts
const postId = ref(1)
queryClient.invalidateQueries({ queryKey: ['post', postId] })   // no .value
queryClient.getQueryData<Post>(['post', postId])
queryClient.setQueryData<Post>(['post', postId], (old) => old && { ...old, seen: true })
```

`invalidateQueries` additionally accepts a getter for filters and options, so the filters re-read current values when the call happens (`src/queryClient.ts:197-207`).

## Imperative fetching: `query()` and `infiniteQuery()`

`queryClient.query(options)` resolves to `Promise<TData>`; `queryClient.infiniteQuery(options)` to `Promise<InfiniteData<TData, TPageParam>>` (`src/queryClient.ts:253-309, 400-462`). These are the v5 replacements for five deprecated methods, all marked "removed in the next major version":

| Deprecated | Replacement |
| --- | --- |
| `fetchQuery(options)` | `queryClient.query(options)` (`src/queryClient.ts:311-313`) |
| `prefetchQuery(options)` | `queryClient.query(options).catch(noop)` (`src/queryClient.ts:363-364`) |
| `fetchInfiniteQuery(options)` | `queryClient.infiniteQuery(options)` (`src/queryClient.ts:464-465`) |
| `prefetchInfiniteQuery(options)` | `queryClient.infiniteQuery(options).then(noop).catch(noop)` (`src/queryClient.ts:520-521`) |
| `ensureQueryData(options)` | `queryClient.query({ ...options, staleTime: 'static' })` (`src/queryClient.ts:80-82`) |

Unlike the composables, `query()` and `infiniteQuery()` do not resolve a top-level options getter; call it yourself: `queryClient.query(options())` (`src/queryClient.ts:251-252, 398-399`).

## Invalidation timing

`invalidateQueries` marks queries stale, then delays the refetch half-step to `nextTick()` so reactive values (including `queryFn` context) settle first (`src/queryClient.ts:216-235`). `refetchType: 'none'` skips refetching entirely.

## Cache access and events

- `getQueryCache()` / `getMutationCache()` return the Vue subclasses whose `find`/`findAll` take `MaybeRefDeep` filters (`src/queryCache.ts:16-25`, `src/mutationCache.ts:15-29`).
- Pass custom caches via `new QueryClient({ queryCache, mutationCache })` (`src/types.ts:105-109`, `src/queryClient.ts:45-52`), then `cache.subscribe(callback)` for event-driven logic.
- Defaults: `setDefaultOptions`, `setQueryDefaults`, `setMutationDefaults` all take `MaybeRefDeep` inputs (`src/queryClient.ts:576-621`). `setMutationDefaults` keyed by `mutationKey` is what lets persisted paused mutations resume after reload (https://tanstack.com/query/latest/docs/framework/vue/guides/mutations).

## Persistence and `isRestoring`

`isRestoring: Ref<boolean>` is `true` while a `clientPersister` restores a cache; composables hold subscriptions and set `_optimisticResults: 'isRestoring'` until it flips (`src/queryClient.ts:54-58`, `src/useBaseQuery.ts:111-141`). Build the persister with `@tanstack/query-persist-client-core` (`src/vueQueryPlugin.ts:20-23`).

## Multiple clients

Install twice with different `queryClientKey`s; retrieve each with `useQueryClient(key)`. Keys map to injection strings `VUE_QUERY_CLIENT:<key>` (`src/vueQueryPlugin.ts:15-18`, `src/utils.ts:8-11`).

## SSR

One fresh `QueryClient` per request, passed as `queryClient` to the plugin; the plugin skips mounting on the server (`src/vueQueryPlugin.ts:54-62, 87-89`). Use `dehydrate`/`hydrate` from the core re-export, and consider `gcTime: Infinity` in server defaults. Guide: https://tanstack.com/query/latest/docs/framework/vue/guides/ssr

## Suspense

Query returns expose `suspense(): Promise<QueryObserverResult>` for use in `<Suspense>` async setup — it fetches when stale, resolves from cache otherwise, and rejects per `throwOnError` (`src/useBaseQuery.ts:160-201`). Guide: https://tanstack.com/query/latest/docs/framework/vue/guides/suspense
