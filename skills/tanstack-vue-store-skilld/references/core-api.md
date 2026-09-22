# Core API reference (`@tanstack/store` re-exports)

`src/index.ts:1` does `export * from '@tanstack/store'`, so every symbol below is importable from `@tanstack/vue-store` in Vue apps. Official reference: [API index](https://tanstack.com/store/latest/docs/reference/).

## createStore

[Official docs](https://tanstack.com/store/latest/docs/reference/functions/createStore)

```ts
createStore<T>(getValue: (prev?) => T): ReadonlyStore<T>          // derived
createStore<T>(initialValue: T): Store<T>                          // simple
createStore<T, TActions>(initialValue: NonFunction<T>,
  actions: StoreActionsFactory<T, TActions>): Store<T, TActions>   // with actions
```

- Passing a function creates a derived `ReadonlyStore`. It recomputes when dependencies change; `prev` receives the previous computed value, useful for accumulation.
- The actions factory receives `{ setState, get }` and returns an actions object exposed as typed `store.actions`.

```ts
const counter = createStore(0)
const derived = createStore(() => counter.state * 2)
const petStore = createStore({ cats: 0 }, ({ setState }) => ({
  addCat: () => setState((s) => ({ ...s, cats: s.cats + 1 })),
}))
```

## Store and ReadonlyStore

[Store docs](https://tanstack.com/store/latest/docs/reference/classes/Store) · [ReadonlyStore docs](https://tanstack.com/store/latest/docs/reference/classes/ReadonlyStore)

`Store<T, TActions = never>`:

- `state` getter and `get()`: read current value.
- `setState(updater: (prev) => T)`: immutable update; the updater receives previous state.
- `subscribe(observerOrFn): Subscription`: observer function or RxJS-style observer object; returns `{ unsubscribe }`. This replaced the removed `Effect` class in v0.9.0.
- `actions`: bound, typed actions when created with an actions factory.

`ReadonlyStore<T>` implements `Store` without `setState` and `actions`. Derived stores return this type.

## createAtom

[Official docs](https://tanstack.com/store/latest/docs/reference/functions/createAtom)

```ts
createAtom<T>(getValue: (prev?) => T, options?: AtomOptions<T>): ReadonlyAtom<T>  // computed
createAtom<T>(initialValue: T, options?: AtomOptions<T>): Atom<T>                 // writable
```

- Writable `Atom<T>` exposes `set`, which accepts a value or an updater function (`set: (fn) => void & (value) => void`).
- Computed atoms return `ReadonlyAtom<T>` without `set`.
- `AtomOptions.compare?: (prev, next) => boolean` controls change detection. [AtomOptions docs](https://tanstack.com/store/latest/docs/reference/interfaces/AtomOptions)

## createAsyncAtom

[Official docs](https://tanstack.com/store/latest/docs/reference/functions/createAsyncAtom)

```ts
createAsyncAtom<T>(getValue: () => Promise<T>, options?): ReadonlyAtom<AsyncAtomState<T, unknown>>
```

- Wraps a promise in an atom whose value is a status discriminated union:
  `{ status: 'pending' } | { status: 'done'; data: T } | { status: 'error'; error: unknown }`.
- Consume with `useSelector(atom)` and branch on `status`; no hand-rolled loading flags.
- The `AsyncAtomState` type itself is not exported; use `ReturnType` or infer from the atom if the shape is needed.

## batch and flush

[batch docs](https://tanstack.com/store/latest/docs/reference/functions/batch) · [flush docs](https://tanstack.com/store/latest/docs/reference/functions/flush)

```ts
batch(() => { /* grouped updates */ }): void
flush(): void
```

- `batch(fn)` groups updates inside `fn` into one notification cycle; subscribers are notified once with the final state.
- `flush()` drains pending effects immediately. It is a no-op inside `batch`.

## shallow

[Official docs](https://tanstack.com/store/latest/docs/reference/functions/shallow)

```ts
shallow<T>(objA: T, objB: T): boolean
```

- Compare order: `Object.is`, then Map and Set contents, Date timestamps, then own keys including symbols.
- Main use: `{ compare: shallow }` in the Vue hooks when a selector builds fresh objects or arrays.
- Caution: objects with only property getters compare unequal even when contents match ([issue #218](https://github.com/TanStack/store/issues/218), open). Symbol-key comparison was fixed in [#226](https://github.com/TanStack/store/issues/226).
- Dates: `shallow` compares timestamps, not identity. Under the default `===` compare, a new `Date` reference is always a change; see [issue #160](https://github.com/TanStack/store/issues/160).

## toObserver

[Official docs](https://tanstack.com/store/latest/docs/reference/functions/toObserver)

Normalizes a callback or RxJS-style observer (`{ next, error, complete }`) for `subscribe`.

## Exported types

From the [reference index](https://tanstack.com/store/latest/docs/reference/):

- Classes: `Store`, `ReadonlyStore`.
- Interfaces: `Atom`, `AtomOptions`, `BaseAtom`, `InteropSubscribable`, `Readable`, `ReadonlyAtom`, `Subscribable`, `Subscription` (plus internal `InternalBaseAtom`, `InternalReadonlyAtom`).
- Type aliases: `AnyAtom`, `Observer`, `Selection`, `StoreAction`, `StoreActionMap`, `StoreActionsFactory`.
