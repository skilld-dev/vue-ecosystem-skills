---
total: 79
---

# Docs Index

- ['zodios',](./community-resources.md)

## eslint (9)

- [ESLint Plugin Query](./eslint/eslint-plugin-query.md): TanStack Query comes with its own ESLint plugin. This plugin is used to enforce best practices and to help you avoid common mistakes.
- [Exhaustive dependencies for query keys](./eslint/exhaustive-deps.md): Query keys should be seen like a dependency array to your query function: Every variable that is used inside the queryFn should be added to the que...
- [Ensure correct order of inference sensitive properties for infinite queries](./eslint/infinite-query-property-order.md): For the following functions, the property order of the passed in object matters due to type inference:
- [Ensure correct order of inference-sensitive properties in useMutation()](./eslint/mutation-property-order.md): For the following functions, the property order of the passed in object matters due to type inference:
- [Disallow object rest destructuring on query results](./eslint/no-rest-destructuring.md): Use object rest destructuring on query results automatically subscribes to every field of the query result, which may cause unnecessary re-renders....
- [Disallow putting the result of query hooks directly in a React hook dependency array](./eslint/no-unstable-deps.md): The object returned from the following query hooks is not referentially stable:
- [Disallow returning void from query functions](./eslint/no-void-query-fn.md): Query functions must return a value that will be cached by TanStack Query. Functions that don't return a value (void functions) can lead to unexpec...
- [Prefer the use of queryOptions](./eslint/prefer-query-options.md): Separating queryKey and queryFn can cause unexpected runtime issues when the same query key is accidentally used with more than one queryFn. Wrappi...
- [Stable Query Client](./eslint/stable-query-client.md): The QueryClient contains the QueryCache, so you'd only want to create one instance of the QueryClient for the lifecycle of your application - not a...

## framework/vue (7)

- [Devtools](./framework/vue/devtools.md): Wave your hands in the air and shout hooray because Vue Query comes with dedicated devtools! 
- [GraphQL](./framework/vue/graphql.md)
- [Installation](./framework/vue/installation.md): You can install Vue Query via NPM.
- [Overview](./framework/vue/overview.md)
- [Quick Start](./framework/vue/quick-start.md): If you're looking for a fully functioning example, please have a look at our basic codesandbox example
- [Reactivity](./framework/vue/reactivity.md): Vue uses the the signals paradigm to handle and track reactivity. A key feature of
this system is the reactive system only triggers updates on spec...
- [TypeScript](./framework/vue/typescript.md): typescript playground

## framework/vue/guides (34)

- [Background Fetching Indicators](./framework/vue/guides/background-fetching-indicators.md)
- [Caching Examples](./framework/vue/guides/caching.md)
- [Custom Client](./framework/vue/guides/custom-client.md): Vue Query allows providing custom QueryClient for Vue context.
- [Default Query Function](./framework/vue/guides/default-query-function.md)
- [Dependent Queries](./framework/vue/guides/dependent-queries.md)
- [Disabling/Pausing Queries](./framework/vue/guides/disabling-queries.md)
- [Does Vue Query replace Vuex, Pinia or other global state managers?](./framework/vue/guides/does-this-replace-client-state.md)
- [Filters](./framework/vue/guides/filters.md)
- [Important Defaults](./framework/vue/guides/important-defaults.md)
- [Infinite Queries](./framework/vue/guides/infinite-queries.md)
- [Initial Query Data](./framework/vue/guides/initial-query-data.md)
- [Invalidations from Mutations](./framework/vue/guides/invalidations-from-mutations.md)
- [Migrating to TanStack Query v5](./framework/vue/guides/migrating-to-v5.md): To fix compatibility with Vue 2, useQueries composable now returns queries array wrapped in ref.
Previously reactive was returned which led to mult...
- [Mutations](./framework/vue/guides/mutations.md)
- [Network Mode](./framework/vue/guides/network-mode.md)
- [Optimistic Updates](./framework/vue/guides/optimistic-updates.md)
- [Paginated / Lagged Queries](./framework/vue/guides/paginated-queries.md)
- [Parallel Queries](./framework/vue/guides/parallel-queries.md)
- [Placeholder Query Data](./framework/vue/guides/placeholder-query-data.md)
- [Polling](./framework/vue/guides/polling.md)
- [Prefetching](./framework/vue/guides/prefetching.md): If you're lucky enough, you may know enough about what your users will do to be able to prefetch the data they need before it's needed! If this is ...
- [Queries](./framework/vue/guides/queries.md)
- [Query Cancellation](./framework/vue/guides/query-cancellation.md)
- [Query Functions](./framework/vue/guides/query-functions.md)
- [Query Invalidation](./framework/vue/guides/query-invalidation.md)
- [Query Keys](./framework/vue/guides/query-keys.md)
- [Query Options](./framework/vue/guides/query-options.md)
- [Query Retries](./framework/vue/guides/query-retries.md)
- [Scroll Restoration](./framework/vue/guides/scroll-restoration.md)
- [SSR](./framework/vue/guides/ssr.md): Vue Query supports prefetching multiple queries on the server and then dehydrating those queries to the queryClient. This means the server can prer...
- [Suspense (experimental)](./framework/vue/guides/suspense.md): Vue Query can also be used with Vue's new Suspense API's.
- [Testing](./framework/vue/guides/testing.md)
- [Updates from Mutation Responses](./framework/vue/guides/updates-from-mutation-responses.md)
- [Window Focus Refetching](./framework/vue/guides/window-focus-refetching.md)

## framework/vue/plugins (2)

- [broadcastQueryClient (Experimental)](./framework/vue/plugins/broadcastQueryClient.md)
- [experimental_createQueryPersister](./framework/vue/plugins/createPersister.md): This utility comes as a separate package and is available under the '@tanstack/query-persist-client-core' import.

## framework/vue/reference (14)

- [hydration](./framework/vue/reference/hydration.md)
- [infiniteQueryOptions](./framework/vue/reference/infiniteQueryOptions.md)
- [mutationOptions](./framework/vue/reference/mutationOptions.md)
- [queryOptions](./framework/vue/reference/queryOptions.md)
- [useInfiniteQuery](./framework/vue/reference/useInfiniteQuery.md)
- [useIsFetching](./framework/vue/reference/useIsFetching.md)
- [useIsMutating](./framework/vue/reference/useIsMutating.md)
- [useMutation](./framework/vue/reference/useMutation.md)
- [useMutationState](./framework/vue/reference/useMutationState.md)
- [usePrefetchInfiniteQuery](./framework/vue/reference/usePrefetchInfiniteQuery.md)
- [usePrefetchQuery](./framework/vue/reference/usePrefetchQuery.md)
- [useQueries](./framework/vue/reference/useQueries.md)
- [useQuery](./framework/vue/reference/useQuery.md)
- [useQueryClient](./framework/vue/reference/useQueryClient.md)

## reference (12)

- [environmentManager](./reference/environmentManager.md): The environmentManager manages how TanStack Query detects whether the current runtime should be treated as server-side.
- [FocusManager](./reference/focusManager.md): The FocusManager manages the focus state within TanStack Query.
- [InfiniteQueryObserver](./reference/InfiniteQueryObserver.md): The InfiniteQueryObserver can be used to observe and switch between infinite queries.
- [MutationCache](./reference/MutationCache.md): The MutationCache is the storage for mutations.
- [NotifyManager](./reference/notifyManager.md): The notifyManager handles scheduling and batching callbacks in TanStack Query.
- [OnlineManager](./reference/onlineManager.md): The OnlineManager manages the online state within TanStack Query. It can be used to change the default event listeners or to manually change the on...
- [QueriesObserver](./reference/QueriesObserver.md): The QueriesObserver can be used to observe multiple queries.
- [QueryCache](./reference/QueryCache.md): The QueryCache is the storage mechanism for TanStack Query. It stores all the data, meta information and state of queries it contains.
- [QueryClient](./reference/QueryClient.md): The QueryClient can be used to interact with a cache:
- [QueryObserver](./reference/QueryObserver.md): The QueryObserver can be used to observe and switch between queries.
- [streamedQuery](./reference/streamedQuery.md): streamedQuery is a helper function to create a query function that streams data from an AsyncIterable. Data will be an Array of all the chunks rece...
- [TimeoutManager](./reference/timeoutManager.md): The TimeoutManager handles setTimeout and setInterval timers in TanStack Query.
