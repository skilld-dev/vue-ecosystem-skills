# API surface

Every export from `@tanstack/vue-query` 5.103.2 (`src/index.ts`). All paths are relative to the prepared package source. Framework docs: https://tanstack.com/query/latest/docs/framework/vue/overview

`@tanstack/query-core` is re-exported in full (`src/index.ts:1`): `keepPreviousData`, `skipToken`, `QueryObserver`, `InfiniteQueryObserver`, `QueriesObserver`, `focusManager`, `onlineManager`, `notifyManager`, `environmentManager`, `dehydrate`/`hydrate`, and the rest of core.

## Plugin and client access

### `VueQueryPlugin`

`app.use(VueQueryPlugin, options?)` (`src/vueQueryPlugin.ts:74-154`). Options (`src/vueQueryPlugin.ts:11-38`):

| Option | Purpose |
| --- | --- |
| `queryClient` | Your own `QueryClient`; skips plugin construction |
| `queryClientConfig` | Config for the client the plugin constructs; ignored if `queryClient` is set |
| `queryClientKey` | Names this client; pass the same key to `useQueryClient(key)` |
| `clientPersister` | `() => [unmount, Promise]`; restores a persisted cache before mount |
| `clientPersisterOnSuccess` | Callback after restore finishes |
| `enableDevtoolsV6Plugin` | Legacy Vue Devtools v6 panel; dev only |

On install: client is mounted unless `environmentManager.isServer()`; provides the client under `VUE_QUERY_CLIENT` (+ `:key` suffix); app unmount calls `client.unmount()` and persister cleanup.

### `useQueryClient(id = '')`

Injects the installed client. Throws if no injection context or no plugin (`src/useQueryClient.ts:27-44`). Injection key constant: `VUE_QUERY_CLIENT` (`src/utils.ts:5`).

## Query composables

All accept an optional second `queryClient` argument to bypass injection. All warn in dev when called outside a scope.

### `useQuery(options, queryClient?)`

`options: MaybeRefOrGetter<UseQueryOptions>`; returns `UseQueryReturnType` — each result field a `Ref`, `refetch` a plain function, plus `suspense(): Promise<QueryObserverResult>` (`src/useQuery.ts:282-307`, `src/useBaseQuery.ts:27-40`). Overloads split on `initialData`: set means `data` is never `undefined` (`src/useQuery.ts:65-73`).

### `useInfiniteQuery(options, queryClient?)`

Same as `useQuery` plus `initialPageParam`, `getNextPageParam`, `getPreviousPageParam`, `maxPages`; result adds `fetchNextPage`, `fetchPreviousPage`, `hasNextPage`, `hasPreviousPage`, `isFetchingNextPage`, `isFetchingPreviousPage`; `data.value.pages` / `data.value.pageParams` (`src/useInfiniteQuery.ts:63-67,117-134`).

### `useQueries({ queries, combine?, shallow? }, queryClient?)`

`queries` is a plain array, `ref`/reactive array (tracked per entry), or a getter for when the array length itself changes. Returns `Readonly<Ref<TCombinedResult>>` — the array of results in input order, or the `combine` output (`src/useQueries.ts:357-376`). Duplicate query keys in the array can share data; de-duplicate and map back (`src/useQueries.ts:241-243`). `placeholderData` gets no previous-result argument here (`src/useQueries.ts:248-249`).

### `usePrefetchQuery(options, queryClient?)` / `usePrefetchInfiniteQuery(options, queryClient?)`

Return `void`. Fire `client.query(...)` / `client.infiniteQuery(...)` in a `watchEffect`, skipped when the query already has any cached state (including a leftover `pending`/`error`). `queryFn` may not be `skipToken` here (`src/usePrefetchQuery.ts:50-57,116-129`, `src/usePrefetchInfiniteQuery.ts:48-64,124-138`). Docs: https://tanstack.com/query/latest/docs/framework/vue/reference/usePrefetchQuery

### `useIsFetching(filters?, queryClient?)`

Returns `Ref<number>` of queries currently fetching; filters are `MaybeRefDeep<QueryFilters>` or a getter (`src/useIsFetching.ts:54-87`).

## Mutation composables

### `useMutation(options, queryClient?)`

`options: MaybeRefDeep<MutationOptions> | (() => ...)`; returns `ToRefs` of the result plus `mutate`, `mutateAsync`, `reset` (`src/useMutation.ts:31-68`). Signature has four generics including `TOnMutateResult` — what `onMutate` returns is handed to `onError`/`onSettled`.

### `useMutationState(options?, queryClient?)`

`Readonly<Ref<Array<TResult>>>` of all `MutationCache` entries matching `filters`, transformed by `select` (`src/useMutationState.ts:196-227`).

### `useIsMutating(filters?, queryClient?)`

`Ref<number>` of pending mutations; implemented over `useMutationState` (`src/useMutationState.ts:53-79`).

## Options helpers

### `queryOptions(options)`

Identity function typing the `queryKey` with the inferred data type. Plain-object and getter overloads for both `initialData` variants (`src/queryOptions.ts:244-411`). Getter form returns a function: pass it as-is to `useQuery` (stays reactive), call it once for one-shot `queryClient` calls (`src/queryOptions.ts:359-369`).

### `infiniteQueryOptions(options)`

Same pattern for infinite queries; tags the key with `InfiniteData<TQueryFnData>` (`src/infiniteQueryOptions.ts:99-178`).

### `mutationOptions(options)`

Same pattern for mutations. Overloads with a required `mutationKey` (for `useMutationState` lookup) and without (`src/mutationOptions.ts:34-182`).

## Classes

### `QueryClient extends QC` (`src/queryClient.ts:44-622`)

Vue-aware core subclass. Adds `isRestoring: Ref<boolean>` (persister state; queries do not fetch while `true`). Every method that takes keys, filters, or options also takes them `MaybeRefDeep` (refs deep, unwrapped for you). See [query-client.md](./query-client.md).

### `QueryCache extends QC`, `MutationCache extends MC`

`find`/`findAll` accept `MaybeRefDeep` filters (`src/queryCache.ts:16-25`, `src/mutationCache.ts:15-29`). Reached via `queryClient.getQueryCache()` / `getMutationCache()`; pass instances into `new QueryClient({ queryCache, mutationCache })` to subscribe to cache events (`src/types.ts:105-109`).

## Vue-specific types

From `src/types.ts` and the option modules:

- `MaybeRef<T>`, `MaybeRefOrGetter<T>`, `MaybeGetter<T>` (`src/types.ts:25-39`)
- `MaybeRefDeep<T>` — recursively ref-able properties (`src/types.ts:46-54`)
- `DeepUnwrapRef<T>` (`src/types.ts:68-76`)
- `ShallowOption.shallow?: boolean` — `shallowReactive`/`shallowReadonly` state for large data (`src/types.ts:78-83`, `src/useBaseQuery.ts:120-122`)
- `UseQueryOptions`, `DefinedInitialQueryOptions`, `UndefinedInitialQueryOptions` (`src/queryOptions.ts:91-195`)
- `UseInfiniteQueryOptions`, `DefinedInitialDataInfiniteOptions`, `UndefinedInitialDataInfiniteOptions` (`src/useInfiniteQuery.ts:27-61`, `src/infiniteQueryOptions.ts:21-71`)
- `UseMutationOptions`, `MutationOptions` (`src/useMutation.ts:31-41`, `src/types.ts:85-94`)
- `UseQueriesOptions`, `UseQueriesResults` (`src/useQueries.ts:170-228`)
- `VueQueryPluginOptions` (`src/vueQueryPlugin.ts:38`)
- `DefaultOptions`, `QueryClientConfig` (`src/types.ts:96-109`)
