---
name: tanstack-vue-store-skilld
description: "Vue adapter for TanStack Store, a framework agnostic type-safe store. ALWAYS use when writing code importing \"@tanstack/vue-store\" in a Vue app. Covers the useSelector, useAtom, useStore (deprecated), and _useStore hooks, the re-exported @tanstack/store core API (createStore, createAtom, createAsyncAtom, batch, flush, shallow), debugging, best practices, and migration between @tanstack/vue-store versions."
---

# TanStack/store `@tanstack/vue-store@0.11.1`
**Tags:** latest: 0.11.1 · core dep: `@tanstack/store@0.11.1` (exact pin)

**References:** [Docs](./references/docs/_INDEX.md) · [Releases](./references/releases/_INDEX.md) · [Issues](./references/issues/_INDEX.md) · [Discussions](./references/discussions/_INDEX.md)

## Vue hooks (this package's own exports)

`src/index.ts` re-exports all of `@tanstack/store` and adds four Vue hooks:

| Hook | Signature | Use |
|---|---|---|
| `useSelector` | `(source, selector?, options?) => Readonly<Ref<TSelected>>` | Primary read hook. Accepts a store, atom, or any `{ get, subscribe }` source. Default compare is strict `===` (`src/useSelector.ts:15-17`). [docs](./references/docs/framework/vue/reference/functions/useSelector.md) |
| `useAtom` | `(atom, options?) => [Readonly<Ref<TValue>>, atom.set]` | Read plus write for one writable atom. The setter takes a value or updater function (`src/useAtom.ts:20-27`). [docs](./references/docs/framework/vue/reference/functions/useAtom.md) |
| `_useStore` | `(store, selector, options?) => [selected, actions or setState]` | Experimental combined read+write tuple. Returns store `actions` when a actions factory exists, else `setState` (`src/_useStore.ts:24-41`). [docs](./references/docs/framework/vue/reference/functions/useStore.md) |
| `useStore` | deprecated | Alias for `useSelector`. Third argument is a bare `compare` function, not an options object (`src/useStore.ts:14-23`). [docs](./references/docs/framework/vue/reference/functions/useStore-1.md) |

`options` is `UseSelectorOptions`: `{ compare?: (a, b) => boolean }` (`src/useSelector.ts:4-6`). [docs](./references/docs/framework/vue/reference/interfaces/UseSelectorOptions.md)

```ts
import { createStore, createAtom, shallow, useAtom, useSelector } from '@tanstack/vue-store'

const counter = createStore({ count: 0 })
const countAtom = createAtom(0)

// inside <script setup>
const count = useSelector(counter, (s) => s.count)                          // slice
const pair = useSelector(counter, (s) => ({ n: s.count }), { compare: shallow }) // object slice
const [n, setN] = useAtom(countAtom)                                        // read + write
setN((prev) => prev + 1)
```

Read the returned refs in templates as `{{ count }}` and in script as `count.value`. Refs are `readonly`; write through `store.setState`, `atom.set`, store `actions`, or the second tuple element of `useAtom`/`_useStore`.

## API Changes

This section documents version-specific API changes, most recent first.

- CHANGED: default compare is strict `===` in 0.11.x — `useSelector` compares selected values with `a === b` by default (`src/useSelector.ts:15-17`). In 0.10 and earlier, `useStore` defaulted to `shallow` and accepted `{ equal }`. Code upgrading from <=0.10 that selects objects or arrays must pass `{ compare: shallow }` explicitly, or the ref updates on every notification. [release 0.11.0](./references/releases/@tanstack/vue-store@0.11.0.md)

- DEPRECATED: `useStore` replaced by `useSelector` — v0.11.0 introduced `useSelector` as the primary read hook; `useStore` remains as a deprecated alias (`src/useStore.ts:12`). There is no `{ equal }` options object in 0.11.x. [release 0.11.0](./references/releases/@tanstack/vue-store@0.11.0.md)

- NEW: `useAtom(atom, options?)` — v0.11.0 added the read+write tuple `[readonly Ref, atom.set]` (`src/useAtom.ts:20`). [release 0.11.0](./references/releases/@tanstack/vue-store@0.11.0.md)

- NEW: `_useStore(store, selector, options?)` — experimental combined hook mirroring `useAtom`'s tuple. Returns `[selected, actions]` when the store has an actions factory, else `[selected, setState]` (`src/_useStore.ts:24`). Underscore prefix marks it experimental; expect churn. [docs](./references/docs/framework/vue/reference/functions/useStore.md)

- CAUTION: `createStoreContext` is not exported — the v0.11.0 release notes list it for this package, but the 0.11.1 source exports only `useSelector`, `useAtom`, `useStore`, `_useStore` plus the core re-export (`src/index.ts`). Do not import `createStoreContext` from `@tanstack/vue-store`. [release 0.11.0](./references/releases/@tanstack/vue-store@0.11.0.md)

- 0.11.1: patch only — core `@tanstack/store@0.11.1` inlines reactive flag constants for tree-shaking (#350). No adapter API changes. [release 0.11.1](./references/releases/@tanstack/vue-store@0.11.1.md)

- 0.10.0: build system only — switched the build to tsdown (#304). No public API changes. [release 0.10.0](./references/releases/@tanstack/vue-store@0.10.0.md)

- BREAKING: `new Store()` -> `createStore()` — v0.9.0 replaced the class constructor with a factory function for all store instantiations. [release 0.9.0](./references/releases/@tanstack/vue-store@0.9.0.md)

- BREAKING: `new Derived()` -> `createStore(fn)` — v0.9.0 unified derived and simple state creation into the single `createStore` API. Passing a function returns a `ReadonlyStore` (core `store.ts`). [release 0.9.0](./references/releases/@tanstack/vue-store@0.9.0.md)

- BREAKING: `new Effect()` removed -> `store.subscribe()` — side effects run through subscriptions that return `{ unsubscribe }`. [release 0.9.0](./references/releases/@tanstack/vue-store@0.9.0.md)

- CHANGED: alien-signals core — v0.9.0 switched internal reactivity to alien-signals. [release 0.9.0](./references/releases/@tanstack/vue-store@0.9.0.md)

## Core re-exports from `@tanstack/store`

Everything below is importable from `@tanstack/vue-store` in Vue apps (`src/index.ts:1`):

- `createStore(initialValue)` -> `Store<T>`; `createStore((prev?) => T)` -> `ReadonlyStore<T>` (derived); `createStore(initialValue, actionsFactory)` -> `Store<T, TActions>`. [docs](./references/docs/reference/functions/createStore.md)
- `Store`: `state` getter, `get()`, `setState(updater)`, `subscribe(observerOrFn)`, bound `actions`. [docs](./references/docs/reference/classes/Store.md)
- `createAtom(initialValue)` -> writable `Atom<T>`; `createAtom(fn)` -> computed `ReadonlyAtom<T>`; `AtomOptions.compare` controls change detection (defaults to `Object.is`). [docs](./references/docs/reference/functions/createAtom.md)
- `createAsyncAtom(() => Promise<T>)` -> `ReadonlyAtom` of `{ status: 'pending' } | { status: 'done'; data } | { status: 'error'; error }`. The `AsyncAtomState` type itself is not exported. [docs](./references/docs/reference/functions/createAsyncAtom.md)
- `batch(fn)` groups updates into one notification cycle; `flush()` drains pending effects (no-op inside `batch`). [batch](./references/docs/reference/functions/batch.md) · [flush](./references/docs/reference/functions/flush.md)
- `shallow(a, b)` — `Object.is`, then Map and Set contents, Date timestamps, and own keys including symbols. [docs](./references/docs/reference/functions/shallow.md)
- `toObserver()` normalizes callbacks or RxJS-style observers for `subscribe`. [docs](./references/docs/reference/functions/toObserver.md)
- Types: `Observer`, `Subscription`, `Subscribable`, `Readable`, `Atom`, `ReadonlyAtom`, `AtomOptions`, `StoreActionMap`, `StoreActionsFactory`, and others. [index](./references/docs/reference/index.md)

## Best Practices

- Use `useSelector` as the read hook, not the deprecated `useStore` — `useSelector` is the primary API since v0.11.0 (`src/useSelector.ts:39`). [vue quick-start](./references/docs/framework/vue/quick-start.md)

- Pass `{ compare: shallow }` when the selector builds a fresh object or array — the default `===` compare sees a new reference on every notification and updates the ref each time (`src/useSelector.ts:15-17`, `src/useSelector.ts:44-52`). Primitive selectors need no custom compare.

- Call the hooks inside a component setup or other effect scope — `useSelector` unsubscribes via `onScopeDispose` (`src/useSelector.ts:54-56`). Outside a scope, cleanup never runs.

- Define stores in plain modules, outside components — instantiate once, import anywhere; this is the documented pattern for sharing state across components. [vue quick-start](./references/docs/framework/vue/quick-start.md)

- Use a selector for fine-grained slices — the component only updates when the selected value changes; unrelated store properties do not trigger updates. [vue quick-start](./references/docs/framework/vue/quick-start.md)

- Write state through `store.setState((prev) => next)` updater functions — immutable updates; the updater receives the previous state. [quick-start](./references/docs/quick-start.md)

- Group multiple updates in `batch(() => { ... })` — subscribers notify once at the end with the final state. [quick-start](./references/docs/quick-start.md)

- Derive with `createStore(() => ...)` — derived stores recompute when dependencies change; use the `prev` argument for accumulating values. [quick-start](./references/docs/quick-start.md)

- Co-locate writes with an actions factory — `createStore(init, ({ setState, get }) => ({ inc: () => setState((s) => s + 1) }))` exposes typed `store.actions`, and `_useStore` returns them as the second tuple element (`src/_useStore.ts:37-38`). [createStore](./references/docs/reference/functions/createStore.md)

- Use `createAsyncAtom` for async data — track pending, done, error through the status discriminated union instead of hand-rolled flags. [docs](./references/docs/reference/functions/createAsyncAtom.md)

- Observe state outside components with `store.subscribe(() => ...)` — returns `{ unsubscribe }`; this replaced the removed `Effect` class in v0.9.0. [quick-start](./references/docs/quick-start.md)

- Keep selectors cheap — the selector runs on every notification of the source (`src/useSelector.ts:46-52`); move expensive computation into a derived `createStore` instead.

## Environment

- Vue `^3.0.0` or `^2.5.0` via `vue-demi`; Vue 2 needs the optional peer `@vue/composition-api@^1.2.1` (package.json peerDependencies).
- Depends on the exact `@tanstack/store@0.11.1`; core APIs are re-exported, so no separate core import is needed in Vue apps.
- Dual format: ESM through the `import` condition (`dist/index.js`), CJS through `require` (`dist/index.cjs`); types at `dist/index.d.cts`; `sideEffects: false`.
- TypeScript support is tested against TS 5.6 through 5.9 (package scripts `test:types:*`).
