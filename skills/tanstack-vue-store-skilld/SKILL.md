---
name: tanstack-vue-store-skilld
description: "Vue adapter for TanStack Store, a framework agnostic type-safe store. ALWAYS use when writing code importing \"@tanstack/vue-store\" in a Vue app. Covers the useSelector, useAtom, useStore (deprecated), and _useStore hooks, the re-exported @tanstack/store core API (createStore, createAtom, createAsyncAtom, batch, flush, shallow), debugging, best practices, and migration between @tanstack/vue-store versions."
---

# @tanstack/vue-store@0.11.1

Vue adapter for TanStack Store. Exact core dependency: `@tanstack/store@0.11.1` (package.json:41). `src/index.ts:1` re-exports the whole core, so Vue apps import everything from `@tanstack/vue-store` alone.

## Quick start

```ts
import { createStore, createAtom, shallow, useAtom, useSelector } from '@tanstack/vue-store'

// Module scope: create once, import anywhere
const counter = createStore({ count: 0 })
const countAtom = createAtom(0)

// Inside <script setup>
const count = useSelector(counter, (s) => s.count)                             // slice
const pair = useSelector(counter, (s) => ({ n: s.count }), { compare: shallow }) // object slice
const [n, setN] = useAtom(countAtom)                                           // read + write
setN((prev) => prev + 1)
```

Read refs in templates as `{{ count }}`, in script as `count.value`.

## Hooks (this package's own exports)

| Hook | Signature | Use |
|---|---|---|
| `useSelector` | `(source, selector?, options?) => Readonly<Ref<TSelected>>` | Primary read hook. Store, atom, or any `{ get, subscribe }` source. Omit the selector to subscribe to the whole value. |
| `useAtom` | `(atom, options?) => [Readonly<Ref<TValue>>, atom.set]` | Read plus write for one writable atom. The setter takes a value or an updater function (`src/useAtom.ts:20-27`). |
| `_useStore` | `(store, selector, options?) => [selected, actions or setState]` | Experimental read+write tuple. The selector argument is required (`src/_useStore.ts:30`). Returns `store.actions` when the store has an actions factory, else `store.setState` (`src/_useStore.ts:37-38`). |
| `useStore` | deprecated | Alias for `useSelector`. Third argument is a bare `compare` function, not an options object (`src/useStore.ts:14-23`). Prefer `useSelector`. |

`options` is `UseSelectorOptions`: `{ compare?: (a, b) => boolean }` (`src/useSelector.ts:4-6`).

Details, behavior notes, and pitfalls: [Vue hooks reference](./references/vue-hooks.md)

## Rules that prevent bugs

- Default compare is strict `===` (`src/useSelector.ts:15-17`). When the selector builds a fresh object or array, pass `{ compare: shallow }` or the ref updates on every notification. Primitive selectors need no custom compare.
- Call the hooks inside component setup or another effect scope. `useSelector` unsubscribes via `onScopeDispose` (`src/useSelector.ts:54-56`); outside a scope, cleanup never runs.
- Returned refs are `readonly`. Write through `store.setState`, `atom.set`, store `actions`, or the second tuple element of `useAtom`/`_useStore`.
- Keep selectors cheap. The selector runs on every notification of the source (`src/useSelector.ts:46-52`); move expensive computation into a derived `createStore`.
- Do not import `createStoreContext` from this package. The 0.11.0 release notes list it, but the 0.11.1 source exports only `useSelector`, `useAtom`, `useStore`, `_useStore` plus the core re-export (`src/index.ts`, `dist/index.d.ts`). See [release 0.11.0](https://github.com/TanStack/store/releases/tag/%40tanstack%2Fvue-store%400.11.0).

## Core re-exports from `@tanstack/store`

- `createStore(initialValue)` -> `Store<T>`; `createStore((prev?) => T)` -> `ReadonlyStore<T>` (derived); `createStore(initialValue, actionsFactory)` -> `Store<T, TActions>` with typed `store.actions`.
- `Store`: `state` getter, `get()`, `setState(updater)`, `subscribe(observerOrFn)` returning `{ unsubscribe }`, bound `actions`. `ReadonlyStore` omits `setState` and `actions`.
- `createAtom(initialValue)` -> writable `Atom<T>`; `createAtom(fn)` -> computed `ReadonlyAtom<T>`. `AtomOptions.compare` controls change detection.
- `createAsyncAtom(() => Promise<T>)` -> `ReadonlyAtom` of a `{ status }` discriminated union: `'pending' | 'done' | 'error'`.
- `batch(fn)` groups updates into one notification cycle; `flush()` drains pending effects. `shallow(a, b)` compares `Object.is`, then Map and Set contents, Date timestamps, and own keys including symbols.
- `toObserver()` normalizes callbacks or RxJS-style observers for `subscribe`.
- Types: `Observer`, `Subscription`, `Subscribable`, `Readable`, `Atom`, `ReadonlyAtom`, `AtomOptions`, `StoreActionMap`, `StoreActionsFactory`, and others.

Full surface with cautions: [core API reference](./references/core-api.md)

## Best practices

- Use `useSelector`, never the deprecated `useStore`, for new code (`src/useSelector.ts:39`).
- Define stores in plain modules outside components. This is the documented sharing pattern ([Vue quick start](https://tanstack.com/store/latest/docs/framework/vue/quick-start)).
- Select fine-grained slices. The component re-renders only when the selected value changes.
- Write state through `store.setState((prev) => next)` updater functions; updates are immutable.
- Group multiple updates in `batch(() => { ... })` so subscribers notify once with the final state.
- Derive with `createStore(() => ...)`; derived stores recompute when dependencies change, and `prev` accumulates values.
- Co-locate writes with an actions factory so `_useStore` returns typed actions (`src/_useStore.ts:37-38`).
- Use `createAsyncAtom` for async data instead of hand-rolled pending and error flags.
- Observe state outside components with `store.subscribe(() => ...)`; it returns `{ unsubscribe }`.

Recipes and full examples: [patterns reference](./references/patterns.md)

## Migration

Version-specific changes and upgrade steps, most recent first: [migration reference](./references/migration.md)

Highlights:

- 0.11.x: `useSelector` introduced as primary hook; `useStore` deprecated; default compare is `===`, replacing the pre-0.11 `shallow` default and `{ equal }` option.
- 0.9.0 breaking: `new Store()` -> `createStore()`; `new Derived()` -> derived `createStore(fn)`; `new Effect()` removed in favor of `store.subscribe()`.

## Environment

- Vue `^3.0.0` or `^2.5.0` through `vue-demi`. Vue 2 needs the optional peer `@vue/composition-api@^1.2.1` (package.json:50-58).
- Exact core pin `@tanstack/store@0.11.1`; core APIs are re-exported, so no separate core install is needed in Vue apps.
- Dual format: ESM via the `import` condition (`dist/index.js`), CJS via `require` (`dist/index.cjs`); types at `dist/index.d.cts`; `sideEffects: false`.
- TypeScript 5.6 through 5.9 are tested (package.json:62-66).
