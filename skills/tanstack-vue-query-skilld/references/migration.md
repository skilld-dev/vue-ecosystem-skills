# Version notes and v5 migration

Prepared source is `@tanstack/vue-query` 5.103.2. Migration guide: https://tanstack.com/query/latest/docs/framework/vue/guides/migrating-to-v5. Releases: https://github.com/TanStack/query/releases (monorepo tags like `v5.103.2`, changelog at https://github.com/TanStack/query/blob/main/packages/vue-query/CHANGELOG.md).

## v5 breaking changes (Vue-specific)

- `useQueries` returns a `Ref` of the results array instead of a `reactive` array. Destructuring the old way loses reactivity; use `postQueries.value[i]` or `combine` (source: `src/useQueries.ts:357-376`; guide section "useQueries composable returns ref instead of reactive").
- Vue 3.3 is the minimum for Vue 3; Vue 2.6/2.7 support unchanged (guide section "Vue v3.3 is now required"; prepared `package.json:58`).
- Composables may run in any function with an injection context (router navigation guards included), not just component `setup()`. Run them inside an `effectScope` or they leak; dev builds warn (source: `src/useBaseQuery.ts:82-88`; guide section "Ability to run vue-query composables in injectionContext").
- `suspense()` is a method on query returns, not a Vue Suspense integration you configure (source: `src/useBaseQuery.ts:160-201`).

## v5 renames shared with core

From the migration guide (core changes apply to the Vue package via the full core re-export, `src/index.ts:1`): `cacheTime` -> `gcTime`, `isError`/error semantics per `useErrorBoundary` -> `throwOnError`, `useQueries` results shape, `initialData.updatedAt` removal. See https://tanstack.com/query/latest/docs/framework/react/guides/migrating-to-v5 for the full core list.

## Version-specific additions (5.90 -> 5.103)

- 5.91.0: reactive getter support for `queryKey` and `enabled` in `useQuery` (release: https://github.com/TanStack/query/releases/tag/v5.91.0).
- 5.92.0: reactive getters extended to `useInfiniteQuery`, `useMutation`, `usePrefetchQuery`, `usePrefetchInfiniteQuery` (release: https://github.com/TanStack/query/releases/tag/v5.92.0). Verified in prepared source: whole-options getters at `src/useQuery.ts:282-292`, `src/useInfiniteQuery.ts:347-358`, `src/useMutation.ts:231-239`, `src/usePrefetchQuery.ts:116-117`, `src/usePrefetchInfiniteQuery.ts:124-125`.
- Prepared 5.103.2 state: `queryClient.query()` / `queryClient.infiniteQuery()` are the imperative API; `fetchQuery`, `prefetchQuery`, `fetchInfiniteQuery`, `prefetchInfiniteQuery`, `ensureQueryData` are deprecated with removal announced for the next major (`src/queryClient.ts:80-82, 311-313, 363-364, 464-465, 520-521`).
- `VueQueryPlugin` supports `clientPersister` / `clientPersisterOnSuccess` and `queryClientKey` for multiple clients (`src/vueQueryPlugin.ts:11-38`); `QueryClient.isRestoring` coordinates restore with composables (`src/queryClient.ts:54-58`).

## TypeScript

Vue generics behave as in v5 core (`TQueryFnData`, `TError`, `TData`, `TQueryKey`), plus Vue-only wrappers (`UseQueryOptions` with `MaybeRef` fields, `src/queryOptions.ts:91-134`). The package type-tests against TypeScript 5.6 through 7.0 (`package.json:70-75`). `queryOptions()` tagged keys drive `getQueryData` inference (`src/queryClient.ts:68-78`).

## Devtools

`enableDevtoolsV6Plugin` wires the legacy Vue Devtools v6 panel in development only (`src/vueQueryPlugin.ts:12-13, 138-152`); for Vue 3 apps prefer the separate `@tanstack/vue-query-devtools` package. Docs: https://tanstack.com/query/latest/docs/framework/vue/devtools
