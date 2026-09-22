# Timers, counters, formatting, plain utils, @vueuse/shared 15.0.0

## `useIntervalFn(cb, interval = 1000, { immediate = true, immediateCallback = false })`

Pausable `{ isActive, pause, resume }` (dist/index.js:1632-1663).

- `resume()` re-reads `toValue(interval)`; reactive intervals re-arm on change
  (dist/index.js:1647, 1655-1657).
- `immediateCallback: true` also calls `cb()` on every `resume()`
  (dist/index.js:1650).
- Auto-pauses on scope dispose; never starts on the server (dist/index.js:1654,
  1658).

## `useInterval(interval = 1000, { controls, immediate, callback })`

Readonly incrementing counter; with `controls: true` returns
`{ counter, reset, isActive, pause, resume }` (dist/index.js:1667-1684,
dist/index.d.ts:1186-1218). `callback(count)` runs after each tick.

## `useTimeoutFn(cb, interval, { immediate = true, immediateCallback = false })`

Stoppable `{ isPending, start, stop }` (dist/index.js:1702-1735,
dist/index.d.ts:1280-1303). `interval` is required and reactive. Like the
interval variant, `start()` only runs on the client (dist/index.js:1726-1729).

## `useTimeout(interval = 1000, { controls, callback, ... })`

`ready` computed that flips true when the timeout fires; with
`controls: true` returns `{ ready, isPending, start, stop }`
(dist/index.js:1739-1748).

## `useCounter(initialValue = 0, { min = -Infinity, max = Infinity })`

`{ count, inc, dec, get, set, reset }`; all mutators clamp to `min` / `max` and
return the new value; `reset(v?)` also moves the initial value
(dist/index.js:1497-1517).

## `useToggle(initialValue = false, { truthyValue = true, falsyValue = false })`

- No ref passed: returns `[ShallowRef, toggle]`; `toggle(value?)` sets or
  flips between `truthyValue` / `falsyValue` and returns the new value.
- Ref passed: returns only the toggle function operating on that ref
  (dist/index.js:1789-1805).
- Truthy/falsy values accept refs or getters.
- Template caution: `@click="toggle"` passes the event object as `value`;
  write `@click="toggle()"` (https://vueuse.org/useToggle).

## Conversions

- `useToNumber(value, { method = 'parseFloat', radix, nanToZero = false })`:
  `method` may be `'parseFloat' | 'parseInt' | ((v) => number)`
  (dist/index.js:1756-1764).
- `useToString(value)`: template-string conversion in a `ComputedRef`
  (dist/index.js:1775-1777).

## `useDateFormat(date, formatStr = 'HH:mm:ss', { locales, customMeridiem })`

Tokens include `YY YYYY Yo`, `M MM MMM MMMM Mo`, `D DD Do`, `H HH Ho`,
`h hh ho`, `m mm mo`, `s ss so`, `SSS`, `d dd ddd dddd`, `A AA a aa`,
`z zz zzz zzzz` (offsets); bracket `[text]` is literal
(dist/index.js:1521, 1552-1589, 1619-1621).

```ts
useDateFormat(now, 'YYYY-MM-DD [at] HH:mm:ss')
```

- Input may be `Date | number | string | undefined` via `MaybeRefOrGetter`;
  `normalizeDate` parses timezone-less strings as local time
  (dist/index.js:1595-1608).
- Non-reactive helpers `formatDate(date, str, options)` and
  `normalizeDate(date)` are exported too.
- `locales` feeds `Intl` for name tokens; `customMeridiem(hours, minutes,
  isLowercase, hasPeriod)` replaces AM/PM rendering.

## `useLastChanged(source, { initialValue = null, ...watchOptions })`

Readonly `ShallowRef<number | null>` timestamp of the last change; accepts all
`watch` options (dist/index.js:1687-1692, dist/index.d.ts:1245-1257).

## Plain utils worth knowing

- `createSingletonPromise(fn)`: memoized promise with `.reset()` that awaits
  the previous run (dist/index.js:496-507).
- `promiseTimeout(ms, throwOnTimeout = false, reason = 'Timeout')`
  (dist/index.js:475-480).
- `increaseWithUnit('2px', 1)` -> `'3px'` (dist/index.js:515-523).
- `pxValue('2rem')` -> `32`: assumes 1rem = 16px, intended for SSR only
  (dist/index.js:527-528).
- `objectPick(obj, keys, omitUndefined?)` / `objectOmit(obj, keys, omitUndefined?)`
  / `objectEntries` / `toArray` (dist/index.js:533-553).
- `clamp(n, min, max)`, `rand(min, max)` inclusive integer, `timestamp()`,
  `hyphenate` / `camelize` cached (dist/index.js:557-568, 273-281).
- `isClient` / `isWorker` are compile-time-friendly booleans
  (dist/index.js:264-265); guard browser-only code with `isClient` so SSR
  bundles can drop it.
- `getLifeCycleTarget(target?)`: resolve the current component instance for
  the `tryOn*` helpers (dist/index.js:571-573).
