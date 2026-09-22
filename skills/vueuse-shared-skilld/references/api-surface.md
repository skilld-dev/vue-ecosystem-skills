# API surface, @vueuse/shared 15.0.0

Every runtime export, grouped by area. Types are exported alongside each
function (full list in `dist/index.d.ts:1511`). Deprecated aliases are marked
\*; see [migration-v15](./migration-v15.md).

## Reactivity: refs

| Export | Signature / notes | Source |
| --- | --- | --- |
| `createRef` | `(value, deep?) => Ref \| ShallowRef`; shallow unless `deep: true` | dist/index.d.ts:388-405 |
| `refDefault` | `(source: Ref<T \| null \| undefined>, defaultValue: T) => Ref<T>`; writes pass through | dist/index.d.ts:578-584 |
| `refDebounced` | `(value: Ref<T>, ms = 200, options?) => Readonly<Ref<T>>` | dist/index.js:822 |
| `refThrottled` | `(value: Ref<T>, delay = 200, trailing?, leading?) => Ref<T>`; `delay <= 0` returns source | dist/index.js:918-919 |
| `refAutoReset` | `(defaultValue, afterMs = 10_000) => Ref<T>`; resets after each set | dist/index.js:773 |
| `refManualReset` | `(defaultValue) => Ref<T> & { reset() }`; shallow; `reset()` re-reads `toValue(defaultValue)` | dist/index.js:860-882 |
| `refWithControl` | ref + `get/set/untrackedGet/silentSet/peek/lay`, options `onBeforeChange` (return `false` to veto), `onChanged` | dist/index.js:938-995 |
| `extendRef` | attach extra props to a ref; options `enumerable = false`, `unwrap = true` | dist/index.d.ts:418-442 |
| `controlledRef` \* | alias of `refWithControl` | dist/index.d.ts:650 |
| `autoResetRef` \*, `debouncedRef` \*, `useDebounce` \*, `throttledRef` \*, `useThrottle` \* | aliases | dist/index.d.ts:563-619 |

## Reactivity: computed and conversion

| Export | Signature / notes | Source |
| --- | --- | --- |
| `computedWithControl` | `(source, fn \| { get, set }, options?)`; explicit deps; returns `.trigger()` | dist/index.js:37-71 |
| `controlledComputed` \* | alias | dist/index.d.ts:35 |
| `computedEager` \*, `eagerComputed` \* | deprecated; use Vue `computed` | dist/index.d.ts:5-20 |
| `reactiveComputed` | `(fn: () => object) => UnwrapNestedRefs<T>` | dist/index.js:737-739 |
| `reactivePick` / `reactiveOmit` | `(obj, ...keys \| key[] \| predicate) => reactive subset` | dist/index.js:747-763 |
| `reactify` | `(fn, { computedGetter = true }?) => (...args) => ComputedRef` | dist/index.js:669-674 |
| `createReactiveFn` \* | alias of `reactify` | dist/index.d.ts:512 |
| `reactifyObject` | reactify selected keys of an object; `includeOwnProperties = true` | dist/index.js:680-694 |
| `toRef` | 1 arg: getter -> readonly ref, value -> `ref()`; 2-3 args: Vue `toRef` | dist/index.js:290-297 |
| `toRefs` | extended `toRefs`, accepts refs of objects; `replaceRef = true` copies on set | dist/index.js:1102-1128 |
| `toReactive` | ref-of-object -> reactive proxy (get/set/delete/has/ownKeys) | dist/index.js:703-731 |
| `syncRef` | two-way sync; `flush = 'sync'`, `immediate = true`, `direction = 'both'` | dist/index.js:1048-1075 |
| `syncRefs` | one-way sync to target(s); returns `WatchHandle` | dist/index.js:1084-1092 |
| `makeDestructurable` | `(obj, arr) => T & A`; destructurable both ways | dist/index.js:641-656 |

## Watch

`watchWithFilter`, `watchAtMost` (`count` required; returns `stop/pause/resume/count`,
dist/index.js:1834-1848), `watchDebounced`, `watchDeep`, `watchIgnorable`, `watchImmediate`,
`watchOnce`, `watchPausable` \*, `watchThrottled`, `watchTriggerable`, `watchArray`
(cb gets `new, old, added, removed, onCleanup`, dist/index.js:1813-1831), `until`, `whenever`.
Details: [watch-utilities](./watch-utilities.md).

## Scheduling and rate control

`debounceFilter`, `throttleFilter`, `pausableFilter`, `bypassFilter`,
`createFilterWrapper`, `useDebounceFn`, `useThrottleFn`.
Details: [debounce-throttle](./debounce-throttle.md).

## Timers and misc composables

`useInterval`, `useIntervalFn`, `useTimeout`, `useTimeoutFn`, `useCounter`,
`useToggle`, `useToNumber`, `useToString`, `useDateFormat` (+ `formatDate`,
`normalizeDate`), `useLastChanged`.
Details: [timers-and-utils](./timers-and-utils.md).

## State sharing and injection

`createGlobalState`, `createSharedComposable`, `createInjectionState`,
`provideLocal`, `injectLocal`.
Details: [state-sharing](./state-sharing.md).

## Reactive array math

`useArrayDifference` (`key` or `compareFn`, `symmetric` option, dist/index.js:1290-1305),
`useArrayEvery`, `useArrayFilter`, `useArrayFind`, `useArrayFindIndex`,
`useArrayFindLast`, `useArrayIncludes` (comparator fn, `keyof T`, or
`{ fromIndex, comparator }`, dist/index.js:1386-1403), `useArrayJoin`, `useArrayMap`,
`useArrayReduce` (initial value may be a ref, getter, or getter factory,
dist/index.js:1439-1445), `useArraySome`, `useArrayUnique` (optional `compareFn`,
dist/index.js:1482-1487). All return `ComputedRef`; lists accept
`MaybeRefOrGetter<MaybeRefOrGetter<T>[]>` (elements may be refs).

## Lifecycle guards

| Export | Behavior | Source |
| --- | --- | --- |
| `tryOnScopeDispose` | `(fn, failSilently?) => boolean`; true when a scope existed | dist/index.js:119-125 |
| `tryOnMounted` / `tryOnBeforeMount` | in component: hook; else `sync ? fn() : nextTick(fn)` (`sync = true`) | dist/index.js:1163-1167 |
| `tryOnUnmounted` / `tryOnBeforeUnmount` | in component: hook; else nothing | dist/index.js:1151-1177 |
| `getLifeCycleTarget` | `(target?) => ComponentInternalInstance \| null` | dist/index.js:571-573 |

## Directives and events

| Export | Signature / notes | Source |
| --- | --- | --- |
| `createDisposableDirective` | wraps a directive; effects in `mounted` run in an `effectScope` stopped on `unmounted` | dist/index.js:83-111 |
| `createEventHook` | `{ on, off, trigger, clear }`; `on` auto-offs on scope dispose; `trigger` awaits all handlers | dist/index.js:135-158 |

## Plain utilities (non-reactive)

`get` (unref, optional key, dist/index.js:629-632), `set`, `isDefined`
(`unref(v) != null`), `identity`, `invoke`, `noop`, `assert` (warn only),
`clamp`, `rand` (inclusive integer), `now`, `timestamp`, `promiseTimeout`,
`createSingletonPromise` (+ `.reset()`), `containsProp`, `increaseWithUnit`,
`pxValue` (assumes 1rem = 16px, SSR only, dist/index.js:527-528),
`objectPick`, `objectOmit`, `objectEntries`, `toArray`, `hyphenate`, `camelize`,
`hasOwn`, `isObject` (plain objects only, dist/index.js:272),
`isDef`, `notNullish`, `isClient`, `isWorker` (dist/index.js:264-265), `isIOS`.

## Shared types worth reusing

`Pausable` (`isActive`, `pause`, `resume`), `Stoppable` (`isPending`, `stop`,
`start`), `EventFilter`, `ConfigurableEventFilter`, `ConfigurableFlush` /
`ConfigurableFlushSync` (default `'sync'`), `RemovableRef`, `Arrayable`,
`ElementOf`, `Awaitable`, `PromisifyFn`, `TimerHandle`, `DateLike`,
`MapSources`, `MapOldSources` (dist/index.d.ts:48-149).
