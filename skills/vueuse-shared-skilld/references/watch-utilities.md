# Watch utilities, @vueuse/shared 15.0.0

All variants forward sources and options to Vue's `watch`; most return a
`WatchHandle` (dist/index.d.ts:1386-1509).

## Shorthands

| Export | Equivalent | Source |
| --- | --- | --- |
| `watchDeep(src, cb, opts)` | `watch(src, cb, { ...opts, deep: true })` | dist/index.js:1867-1872 |
| `watchImmediate(src, cb, opts)` | `watch(src, cb, { ...opts, immediate: true })` | dist/index.js:1936-1941 |
| `watchOnce(src, cb, opts)` | `watch(src, cb, { ...opts, once: true })` | dist/index.js:1949-1954 |

Prefer Vue's native `{ deep: true }`, `{ immediate: true }`, `{ once: true }`
options when you do not need a named import; the shorthands exist for
readability.

## `watchWithFilter`

`watch(src, cb, { ...watchOptions, eventFilter })`: route callbacks through a
filter such as `debounceFilter` or `pausableFilter`
(dist/index.js:1015-1018). See [debounce-throttle](./debounce-throttle.md).

## `watchIgnorable`

Returns `{ stop, ignoreUpdates, ignorePrevAsyncUpdates }`
(dist/index.d.ts:1430-1443).

```ts
const { stop, ignoreUpdates } = watchIgnorable(source, cb)

ignoreUpdates(() => {
  source.value = 'silent' // cb will not fire for this write
})
```

Implementation differs by flush: with `flush: 'sync'` a flag suppresses the
callback; otherwise two watches count updates (dist/index.js:1881-1919).
`ignorePrevAsyncUpdates()` discards updates queued since the last callback and
is a no-op with `flush: 'sync'`.

## `watchAtMost`

`watchAtMost(src, cb, { count, ...opts })` stops automatically after `count`
fires; returns `{ stop, pause, resume, count }` where `count` is a
`ShallowRef<number>` tally (dist/index.js:1834-1848, dist/index.d.ts:1401-1413).
`count` is required.

## `watchTriggerable`

`watchIgnorable` plus `trigger()`: run the callback immediately with current
values, ignoring the resulting update, returning the callback's value
(dist/index.js:1968-1997, dist/index.d.ts:1480-1489). Callback signature
`(value, oldValue, onCleanup) => R`.

## `watchArray`

Diffing watch for arrays; the callback receives
`(newList, oldList, added, removed, onCleanup)` (dist/index.js:1813-1831).
Elements are matched by identity. With `immediate: true` the first callback
reports the whole list as `added` (old starts `[]`, dist/index.js:1814).

## `watchPausable` (deprecated)

All overloads are deprecated in favor of Vue's built-in `watch` whose handle
has `pause()` / `resume()` (dist/index.js:1021). If you need a shared pausable
gate for several effects, use `pausableFilter` instead.

## `until`

Promised one-time watch (dist/index.js:1181-1276, dist/index.d.ts:835-889).

```ts
await until(isReady).toBe(true)
await until(count).toMatch(v => v > 7)
await until(list).toContains(item)      // array sources get toContains
await until(source).changed()
await until(source).changedTimes(3)
await until(flag).not.toBeTruthy()
await until(val).toBe(target, { timeout: 1000, throwOnTimeout: true })
```

- Options `{ flush = 'sync', deep = false, timeout?, throwOnTimeout? }`;
  without `throwOnTimeout` a timeout resolves with the current value instead
  of throwing (dist/index.js:1182, 1197).
- `toBe` accepts a ref or getter as the comparand and watches both sides
  (dist/index.js:1200-1210).
- Any `Promise.race` consumer can race it; each call creates its own watch,
  which stops on resolution.

## `whenever`

`watch` that only fires while the source is truthy; the callback receives the
truthy value (dist/index.js:2008-2019). `{ once: true }` stops the watcher on
`nextTick` after the first fire (dist/index.js:2011). All other options match
`watch`.

```ts
whenever(isReady, data => init(data), { once: true })
```
