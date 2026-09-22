# Best practices for @vueuse/core 15.0.0

## Pass reactive getters, not just refs

Most arguments accept `MaybeRefOrGetter`, so derive values inline instead of
building `computed` wrappers
([guide](https://vueuse.org/best-practice.html)).

```ts
useTitle(() => isDark.value ? 'Night' : 'Day')
useLocalStorage(() => userId.value + ':settings', defaults)
```

## Rate-limit at the composable, not the callback

Use the `eventFilter` option with `debounceFilter` / `throttleFilter` /
`pausableFilter` instead of wrapping handlers by hand
([config guide](https://vueuse.org/config.html#event-filters)). Filters are
re-exported by core (`dist/index.js:1`).

```ts
import { useMouse, throttleFilter } from '@vueuse/core'
const { x, y } = useMouse({ eventFilter: throttleFilter(100) })
```

## Centralize HTTP with `createFetch`

Wrap `useFetch` once per app for base URL, headers, and CORS; call sites
inherit ([docs](https://vueuse.org/useFetch.html#creating-a-custom-instance)).

```ts
export const useApiFetch = createFetch({
  baseUrl: 'https://api.example.com',
  options: { fetchOptions: { mode: 'cors' } },
})
```

v15 `useFetch` ignores stale success responses after a newer request starts
([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0)); do not add
manual request-id guards for that case.

## Storage: merge defaults and pin serializers

- Pass `mergeDefaults: true` when the stored object schema evolves; otherwise
  keys missing from old stored data stay `undefined`
  ([docs](https://vueuse.org/useStorage.html#merge-defaults)).
- When the initial value is `null`, serialization cannot be inferred: pick a
  `StorageSerializers` entry ([docs](https://vueuse.org/useStorage.html#custom-serialization)).

```ts
const id = useLocalStorage('user-id', null, { serializer: StorageSerializers.number })
const settings = useLocalStorage('settings', { theme: 'light' }, { mergeDefaults: true })
```

## Drive timed composables with `scheduler`

Since v15 removed `interval` / `immediate` timer options
([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0)), the
`ConfigurableScheduler.scheduler` option (`dist/index.d.ts:212-217`) is the
only throttle point. `scheduler: (cb) => Pausable` matches `useRafFn`'s return,
so animation-frame or custom cadences plug straight in. Applies to
`useCountdown`, `useNow`, `useTimestamp`, `useTimeAgo`, `useTimeAgoIntl`,
`useTemporalNow`, `useElementByPoint`, `useMemory`, `useVibrate`, and
`useWebSocket` `heartbeat`.

## Share singletons safely

- `createSharedComposable(fn)` runs `fn` once app-wide; on SSR it falls back to
  a per-call instance to avoid cross-request pollution
  ([docs](https://vueuse.org/createSharedComposable.html)).
- `createGlobalState` for plain global refs; `createInjectionState` for
  typed provide/inject pairs ([docs](https://vueuse.org/createInjectionState.html)).

## Decouple computed dependencies with `computedWithControl`

When a computed should refresh only on specific sources, `computedWithControl`
splits the watch source from the getter
([docs](https://vueuse.org/computedWithControl.html)).

```ts
const width = computedWithControl(() => el.value, () => el.value?.offsetWidth ?? 0)
```

## Use outside components: wrap in `effectScope`

Composables with listeners auto-clean via `tryOnScopeDispose`; outside a
component scope, create one and stop it manually
([guide](https://vueuse.org/best-practice.html#side-effect-clean-up)).

```ts
const scope = effectScope()
scope.run(() => { /* composables here */ })
scope.stop() // removes all listeners started inside
```

## Target iframes and tests via configurable globals

Browser composables accept `window` / `document` / `navigator` options
([config guide](https://vueuse.org/config.html#global-dependencies)). Pass an
iframe's `contentWindow` or a test double; never stub `globalThis`.

```ts
const { x, y } = useMouse({ window: iframeEl.value?.contentWindow })
```

## Async computables: mind the v14+ defaults

`computedAsync` defaults to `flush: 'sync'`, `shallow: true`, and reports
errors through `globalThis.reportError` when no `onError` is given
(`dist/index.js:10`). Provide `onError` to keep failures inside your app's
logging, and `flush: 'pre'` if synchronous re-evaluation causes churn.

## SSR width handling

Use `provideSSRWidth` / `useSSRWidth` around `useWindowSize` /
`useElementSize` / `useBreakpoints` so server and first client render agree
([docs](https://vueuse.org/useSSRWidth.html)).
