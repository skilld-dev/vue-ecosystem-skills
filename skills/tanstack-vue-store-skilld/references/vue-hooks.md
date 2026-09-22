# Vue hooks reference

All hooks live in the prepared source under `src/` and are compiled unchanged into `dist/`. Official docs: [Vue reference index](https://tanstack.com/store/latest/docs/framework/vue/reference/).

## useSelector

```ts
function useSelector<TSource, TSelected = NoInfer<TSource>>(
  source: SelectionSource<TSource>,
  selector?: (snapshot: TSource) => TSelected,
  options?: UseSelectorOptions<TSelected>,
): Readonly<Ref<TSelected>>
```

Source: `src/useSelector.ts:39-59`.

- Primary Vue read hook. Accepts a `Store`, an `Atom`, or any `{ get, subscribe }` source (`SelectionSource`, `src/useSelector.ts:8-13`).
- Omit the selector to subscribe to the whole value: `const value = useSelector(countAtom)`.
- Returns a `readonly` shallow ref. Read it as `count.value`; never assign to it.
- Default compare is strict `===` (`defaultCompare`, `src/useSelector.ts:15-17`). Pass `{ compare }` to change it. When the compared value differs, the ref is replaced (`src/useSelector.ts:44-52`).
- Unsubscribes through `onScopeDispose` (`src/useSelector.ts:54-56`), so it must run inside a component setup or other active effect scope.
- Selector-less subscription still runs the default identity selector, so `===` compare applies to the whole state object.

```ts
const count = useSelector(counterStore, (s) => s.count)
// Object slice: new reference each run, must override compare
const pair = useSelector(counterStore, (s) => ({ n: s.count }), { compare: shallow })
```

## useAtom

```ts
function useAtom<TValue>(
  atom: Atom<TValue>,
  options?: UseSelectorOptions<TValue>,
): [Readonly<Ref<TValue>>, Atom<TValue>['set']]
```

Source: `src/useAtom.ts:20-27`.

- Read plus write for one writable `Atom` (from `createAtom(initialValue)`).
- Returns `[readonlyRef, atom.set]`. The setter is `atom.set` itself, so it accepts a value or an updater function: `setCount(5)` or `setCount((prev) => prev + 1)`.
- Implemented as `useSelector(atom, undefined, options)`, so the `===` default compare and scope requirements apply.
- Not for `ReadonlyAtom` (computed atoms have no `set`) or `Store` (use `_useStore` or `store.setState`).

```ts
const countAtom = createAtom(0)
const [count, setCount] = useAtom(countAtom)
setCount((prev) => prev + 1)
```

## _useStore (experimental)

```ts
function _useStore<TState, TActions extends StoreActionMap, TSelected = NoInfer<TState>>(
  store: Store<TState, TActions>,
  selector: (state: NoInfer<TState>) => TSelected,   // required, no default
  options?: UseSelectorOptions<TSelected>,
): [Readonly<Ref<TSelected>>, [TActions] extends [never] ? Store<TState>['setState'] : TActions]
```

Source: `src/_useStore.ts:24-41`.

- Combined read+write tuple for `Store` sources, mirroring `useAtom`.
- Second element is `store.actions` when the store was created with an actions factory, otherwise `store.setState` (`src/_useStore.ts:37-38`).
- The underscore prefix marks it experimental; expect churn across minor versions.
- The selector argument has no default and must be passed, even if it is the identity `(s) => s`.

```ts
const petStore = createStore({ cats: 0 }, ({ setState }) => ({
  addCat: () => setState((s) => ({ ...s, cats: s.cats + 1 })),
}))
const [cats, { addCat }] = _useStore(petStore, (s) => s.cats)

const plainStore = createStore(0)
const [count, setState] = _useStore(plainStore, (s) => s)
setState((prev) => prev + 1)
```

## useStore (deprecated)

```ts
const useStore = <TSource, TSelected = NoInfer<TSource>>(
  source: { get: () => TSource; subscribe: ... },
  selector?: (snapshot: TSource) => TSelected,
  compare?: (a: TSelected, b: TSelected) => boolean,
): Readonly<Ref<TSelected>>
```

Source: `src/useStore.ts:14-23`.

- Deprecated alias for `useSelector`, kept for the 0.10 -> 0.11 transition. New code uses `useSelector`.
- API trap: the third argument is a bare `compare` function, not an options object. `useStore(store, sel, { compare: shallow })` passes an object where a function is expected and silently breaks comparison.

## UseSelectorOptions

```ts
interface UseSelectorOptions<TSelected> {
  compare?: (a: TSelected, b: TSelected) => boolean
}
```

Source: `src/useSelector.ts:4-6`. Shared by `useSelector`, `useAtom`, and `_useStore`. Pass `{ compare: shallow }` for object and array slices; write a custom compare for Dates and other value types.

## createStoreContext is not exported

The 0.11.0 release notes list `createStoreContext` (StoreProvider and useStoreContext) for this package, but neither `src/index.ts` nor `dist/index.d.ts` export it in 0.11.1. There is no context-based consumption API. Share stores by importing them from plain modules instead. Source: [release 0.11.0](https://github.com/TanStack/store/releases/tag/%40tanstack%2Fvue-store%400.11.0).
