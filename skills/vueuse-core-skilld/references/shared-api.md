# @vueuse/shared surface re-exported by @vueuse/core

`@vueuse/core` re-exports all of `@vueuse/shared@15.0.0`
(`dist/index.d.ts:3`, `package.json:47`). Import these from `@vueuse/core`;
importing `@vueuse/shared` directly is only needed in non-Vue utility packages.
Grouped per the official docs ([vueuse.org/functions](https://vueuse.org/functions)).

## State

`createGlobalState` · `createInjectionState` · `createSharedComposable` ·
`injectLocal` · `provideLocal` · `useLastChanged`

## Animation timers

`useInterval` · `useIntervalFn` · `useTimeout` · `useTimeoutFn`

## Component lifecycle

`tryOnBeforeMount` · `tryOnBeforeUnmount` · `tryOnMounted` ·
`tryOnScopeDispose` · `tryOnUnmounted`

## Watch variants

`until` · `watchArray` · `watchAtMost` · `watchDebounced` · `watchDeep` ·
`watchIgnorable` · `watchImmediate` · `watchOnce` · `watchPausable`
(deprecated, see below) · `watchThrottled` · `watchTriggerable` ·
`watchWithFilter` · `whenever`

## Reactivity

`computedEager` (deprecated, see below) · `computedWithControl` · `createRef` ·
`extendRef` · `reactify` · `reactifyObject` · `reactiveComputed` ·
`reactiveOmit` · `reactivePick` · `refAutoReset` · `refDebounced` ·
`refDefault` · `refManualReset` (v14+) · `refThrottled` · `refWithControl` ·
`syncRef` · `syncRefs` · `toReactive` · `toRef` · `toRefs` · `toValue`

## Array

`useArrayDifference` · `useArrayEvery` · `useArrayFilter` · `useArrayFind` ·
`useArrayFindIndex` · `useArrayFindLast` · `useArrayIncludes` ·
`useArrayJoin` · `useArrayMap` · `useArrayReduce` · `useArraySome` ·
`useArrayUnique`

## Time

`useDateFormat`

## Utilities

`createDisposableDirective` · `createEventHook` · `get` · `isDefined` ·
`makeDestructurable` · `set` · `useCounter` · `useDebounceFn` ·
`useThrottleFn` · `useToggle` · `useToNumber` · `useToString`

## Event-filter system

Used via the `eventFilter` option on watch variants and event-driven
composables (`useLocalStorage`, `useMouse`, ...) per the
[config guide](https://vueuse.org/config.html#event-filters):

`bypassFilter` · `debounceFilter` · `throttleFilter` · `pausableFilter` ·
`createFilterWrapper` (all confirmed imported by the core bundle,
`dist/index.js:1`)

## Version-specific behavior

- **`useThrottleFn(fn, ms?, trailing = true, leading = true, rejectOnCancel?)`**:
  the `trailing` default changed from `false` to `true` in v15.0.0
  ([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0); signature
  per [docs](https://vueuse.org/shared/useThrottleFn/)). Any v14 code that
  counted on suppressing the trailing call must pass `trailing = false`.
- **`useDebounceFn`** gained `flush` and `isPending` support in the filter
  system in v14.4.0
  ([release](https://github.com/vueuse/vueuse/releases/tag/v14.4.0)).
- **`computedEager`** is flagged for removal; Vue 3.4+ `computed()` no longer
  notifies dependents when the value is unchanged
  ([docs](https://vueuse.org/shared/computedEager/)).
- **`watchPausable`** is superseded by Vue 3.5 native `watch()`, which returns
  `{ stop, pause, resume }` directly
  ([docs](https://vueuse.org/shared/watchPausable/)).
