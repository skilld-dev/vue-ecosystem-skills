# Migration reference

Most recent first. Release links: [releases](https://github.com/TanStack/store/releases).

## 0.11.0 -> 0.11.1

Patch only. Core `@tanstack/store@0.11.1` inlines reactive flag constants for tree-shaking ([#350](https://github.com/TanStack/store/pull/350)). No adapter API changes. [Release](https://github.com/TanStack/store/releases/tag/%40tanstack%2Fvue-store%400.11.1)

## 0.10.x -> 0.11.x

[Release 0.11.0](https://github.com/TanStack/store/releases/tag/%40tanstack%2Fvue-store%400.11.0), hooks added in [#306](https://github.com/TanStack/store/pull/306).

1. Replace `useStore(store, selector)` with `useSelector(store, selector)`. `useStore` remains as a deprecated alias.
2. Compare changes:
   - Pre-0.11 `useStore` defaulted to `shallow` equality and accepted an `{ equal }` options object. In 0.11.x the default is strict `===` (`src/useSelector.ts:15-17`) and the option is `{ compare }` inside `UseSelectorOptions`.
   - If the deprecated `useStore` is kept, its third argument is a bare `compare` function, not an options object (`src/useStore.ts:14-23`).
   - Selectors that build objects or arrays must add `{ compare: shallow }` explicitly, or the ref updates on every notification.
3. New hooks: `useAtom(atom, options?)` returns `[readonly Ref, atom.set]`; experimental `_useStore(store, selector, options?)` returns `[selected, actions or setState]`.
4. `createStoreContext` appears in the release notes but is not exported by the published 0.11.1 source. Do not import it.

## 0.9.x -> 0.10.0

Build system only: build switched to tsdown ([#304](https://github.com/TanStack/store/pull/304)). No public API changes. [Release](https://github.com/TanStack/store/releases/tag/%40tanstack%2Fvue-store%400.10.0)

## <=0.8.x -> 0.9.0

[Release 0.9.0](https://github.com/TanStack/store/releases/tag/%40tanstack%2Fvue-store%400.9.0), breaking changes in [#265](https://github.com/TanStack/store/pull/265).

- `new Store()` -> `createStore()`.
- `new Derived()` -> a derived `createStore(() => ...)` returning `ReadonlyStore`.
- `new Effect()` removed -> `store.subscribe(() => { ... })`, which returns `{ unsubscribe }`.
- Internals switched to alien-signals for reactivity.

```ts
// before
const store = new Store({ count: 0 })
const derived = new Derived(() => store.state.count * 2)
const effect = new Effect(() => console.log(store.state.count))

// after
const store = createStore({ count: 0 })
const derived = createStore(() => store.state.count * 2)
const { unsubscribe } = store.subscribe((s) => console.log(s.count))
```
