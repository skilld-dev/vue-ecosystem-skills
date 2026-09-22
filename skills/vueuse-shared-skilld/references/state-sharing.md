# State sharing, @vueuse/shared 15.0.0

## `createGlobalState(stateFactory)`

Module-level singleton in a detached `effectScope(true)`; state is created on
first call and never disposed (dist/index.js:169-180).

```ts
const useUserState = createGlobalState(() => {
  const user = ref(null)
  return { user, setUser: u => user.value = u }
})
```

Warning: on SSR every request shares the module scope, so global state leaks
across requests. Use it for client-only state, or pair it with
`createSharedComposable` semantics instead.

## `createSharedComposable(composable)`

One instance shared by all callers inside the current app; a subscriber count
disposes the instance when it drops to zero, and a later call re-creates it
(dist/index.js:583-605).

```ts
const useSharedMouse = createSharedComposable(useMouse)
// CompA and CompB receive the same state; the last unmount disposes it
```

SSR: on the server it returns the composable unchanged, so every call (and
therefore every request) gets fresh state (dist/index.js:584). Client-only
timer and listener composables are safe to wrap this way.

Pick `createSharedComposable` when state should follow app lifetime but be
reclaimable; pick `createGlobalState` when state must outlive component trees
entirely.

## `createInjectionState(composable, options?)`

Returns a readonly tuple `[useProvidingState, useInjectedState]`
(dist/index.js:230-240, dist/index.d.ts:350-385).

```ts
const [useProvideCounter, useCounter] = createInjectionState(
  (initial: number) => {
    const count = ref(initial)
    return { count, inc: () => count.value++ }
  },
  { injectionKey: 'counter-store', defaultValue: undefined },
)
```

- `options.injectionKey?: string | InjectionKey<Return>`: share the key with
  other code or across HMR boundaries.
- `options.defaultValue?: Return`: when provided, `useInjectedState()` returns
  it instead of `undefined` when no ancestor provided
  (dist/index.d.ts:382-385).
- The inject side returns `Return | undefined` without a default; guard with
  `?? fallback` or throw a helpful error in a wrapper.

## `provideLocal` / `injectLocal`

Same-component provide + inject; also works without a component instance when
an effect scope exists (dist/index.js:197-226).

```ts
provideLocal('key', 1)
const v = injectLocal('key') // 1, same component
```

- Both throw `'provideLocal must be called in setup'` /
  `'injectLocal must be called in setup'` outside a component or scope
  (dist/index.js:202, 221).
- `injectLocal` falls back to standard `inject` when the key was not provided
  locally (dist/index.js:203-204).
- `createInjectionState` is built on these, so injection crosses the normal
  parent/child boundary too.

## Disposal helpers used by the above

- `tryOnScopeDispose(fn, failSilently?)`: registers when a scope exists,
  returns whether it did (dist/index.js:119-125).
- `createEventHook().on(fn)`: auto-removes the listener on scope dispose
  (dist/index.js:143-148); use it to let consumers subscribe to a shared
  composable's events without leaks.
