# @tanstack/vue-store

## 0.11.1

### Patch Changes

- Updated dependencies [`1d7c87e`]:
  - @tanstack/store@0.11.1

Core @tanstack/store@0.11.1: inline reactive flag constants in generated builds to improve tree-shaking (#350). No Vue adapter API changes.

## 0.11.0

### Minor Changes

- Hooks included in this release (#306):
  - useAtom
  - useSelector
  - useStore (deprecated, replaced by useSelector)
  - createStoreContext (provides StoreProvider and useStoreContext for context-based consumption)

Note: the published 0.11.1 source does not export `createStoreContext` from this package. Verified exports are `useSelector`, `useAtom`, `useStore` (deprecated), `_useStore`, plus the `@tanstack/store` re-export.

### Patch Changes

- Updated dependencies [`4d87a83`]:
  - @tanstack/store@0.11.0

## 0.10.0

### Minor Changes

- chore: update deps and change build process to tsdown (#304)

### Patch Changes

- Updated dependencies [`66e3010`]:
  - @tanstack/store@0.10.0

## 0.9.1

### Patch Changes

- Updated dependencies [`77c872f`]:
  - @tanstack/store@0.9.1

## 0.9.0

### Minor Changes

- ## Breaking changes (#265)
  - `new Store()` is now `createStore()`
  - `new Derived()` is now a derived `createStore()`:
    ```ts
    const derived = createStore(() => store.state * 2)
    ```
  - `new Effect()` removed in favor of `store.subscribe()`:
    ```ts
    const { unsubscribe } = store.subscribe(() => {
      console.log(store.state)
    })
    ```
  - Uses alien-signals under the hood for efficient reactivity

### Patch Changes

- Updated dependencies [`dace25f`]:
  - @tanstack/store@0.9.0

## 0.8.1

### Patch Changes

- Updated dependencies [`3096bf2`]:
  - @tanstack/store@0.8.1
