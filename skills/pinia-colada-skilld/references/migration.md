# Migration notes

Target: `@pinia/colada` 1.4.5. Verify details against the official changelog:
https://github.com/posva/pinia-colada/blob/main/CHANGELOG.md

## v1.0.0 (2026-03-06): breaking

Removed the deprecated two-parameter forms
(https://github.com/posva/pinia-colada/compare/v0.21.7...v1.0.0):

```ts
// before
useQuery(opts, () => id.value)
useQueryState(opts, () => id.value)

// after
useQuery(() => opts(id.value))
useQueryState(() => opts(id.value).key)
```

Automated codemod, shipped in the package:

```sh
ast-grep scan -r node_modules/@pinia/colada/codemods/rules/migration-0-21-to-1-0.yaml -i src
```

## Later 1.x additions (non-breaking)

| Version | Change | Source |
| --- | --- | --- |
| 1.1.0 | `meta` support on mutations | https://github.com/posva/pinia-colada/compare/v1.0.0...v1.1.0 |
| 1.2.0 | `defineMutationOptions`; `setInfiniteQueryData`; `defineInfiniteQueryOptions` and getter support in `useInfiniteQuery`; `entry` in `UseMutationGlobalContext` | https://github.com/posva/pinia-colada/compare/v1.1.0...v1.2.0 |
| 1.3.0 | `PiniaColadaSSRNoGc` plugin | https://github.com/posva/pinia-colada/compare/v1.2.1...v1.3.0 |
| 1.4.0 | dev reporter via `nostics` dependency | https://github.com/posva/pinia-colada/compare/v1.3.1...v1.4.0 |
| 1.4.1 | pinia 4 added to peer dependencies | `package.json:92` |

## Older 0.x renames still seen in codebases

These predate 1.0 but appear in older code. Codemods for 0.13 to 0.14 ship in
the package (`codemods/rules/migration-0-13-to-0-14.yaml`).

| Old | Current |
| --- | --- |
| `QueryPlugin` | `PiniaColada` |
| `isFetching` | `isLoading` |
| `setQueryState` | `setEntryState` |
| `queryCache.cancelQuery` | `queryCache.cancel` (plus `cancelQueries`) |
| `useInfiniteQuery` `loadMore` / `initialPage` | `loadNextPage` / `initialPageParam` |
| global options at plugin root | `app.use(PiniaColada, { queryOptions: {...} })` |

The plugin options grouping codemod ships in
`codemods/rules/migration-0-13-to-0-14.yaml`: it wraps root options in
`queryOptions` and adds the required options object to bare `app.use(PiniaColada)`.

## Migrating from TanStack Query

Official guide with a compatibility plugin:
https://pinia-colada.esm.dev/cookbook/migration-tvq.md

Devtools v1 to v2: https://pinia-colada.esm.dev/cookbook/migration-devtools-v2.md
