---
tag: @tanstack/vue-store@0.11.0
version: 0.11.0
published: 2026-04-17
---

# @tanstack/vue-store@0.11.0

### Minor Changes

-   Hooks included in this release: ([#306](https://github.com/TanStack/store/pull/306))
    -   useAtom
    -   useSelector
    -   useStore (deprecated, replaced by useSelector)
    -   createStoreContext (provides StoreProvider and useStoreContext for context-based consumption)

### Patch Changes

-   Updated dependencies \[[`4d87a83`](https://github.com/TanStack/store/commit/4d87a83158d0966cbbaf38cd51419693641f57fa)\]:
    -   @tanstack/store@0.11.0

## Verified against 0.11.1 prepared source

The release notes above list `createStoreContext` for this package, but the published `@tanstack/vue-store@0.11.1` source does not export it. `src/index.ts` exports only `useSelector`, `useAtom`, `useStore` (deprecated alias), `_useStore`, and the `@tanstack/store` re-export. Do not use `createStoreContext` from this package.

Behavior notes confirmed in source:

-   `useSelector` is the primary read hook; default compare is strict `===` (`src/useSelector.ts` `defaultCompare`), with optional `{ compare }` in `UseSelectorOptions`.
-   `useStore` remains as a deprecated alias whose third argument is a bare `compare` function, not an options object. The pre-0.11 `{ equal }` options object and `shallow` default equality are gone.
-   Cleanup uses `onScopeDispose`, so the Vue hooks must run inside a component setup or other effect scope.
