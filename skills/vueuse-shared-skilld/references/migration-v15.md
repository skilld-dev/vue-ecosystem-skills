# Migrating to v15 (from v14)

## Breaking changes in 15.0.0

Release notes: https://github.com/vueuse/vueuse/releases/tag/v15.0.0

- `useThrottleFn`: default `trailing` changed `false -> true` (#5249).
  v15 signature: `(fn, ms = 200, trailing = true, leading = true, rejectOnCancel = false)`
  (dist/index.js:904). Code written against v14 that relied on trailing calls
  never firing must pass `trailing = false`. `throttleFilter` and
  `watchThrottled` use the same defaults (dist/index.js:409-410,
  dist/index.js:1958).
- Node.js 20 support dropped; engines is now `>= 22` (package.json:37, #5553).
- Peer dependency is `vue ^3.5.0` (package.json:40).
- Package is ESM-only since v13 (`"type": "module"`, no `.cjs` in `dist`,
  package.json:2). No `require()` support.

## Added since the v14.3.0 baseline

- v14.4.0: `useDebounceFn` results gained `flush` and `isPending` alongside
  `cancel` (dist/index.js:310-314).
  Release: https://github.com/vueuse/vueuse/releases/tag/v14.4.0

## Removed or pending removal

- `templateRef` was dropped from `@vueuse/core` in v15 (#4883); it never existed
  in `@vueuse/shared`. Use Vue's `useTemplateRef` instead.
- `computedEager` / `eagerComputed`: deprecated with removal planned. Since
  Vue 3.4, plain `computed` skips downstream effects when the new value is
  unchanged (dist/index.d.ts:5-18).
- `watchPausable` / `pausableWatch`: deprecated on all overloads; use Vue's
  built-in `watch` (its `WatchHandle` provides `pause` / `resume`)
  (dist/index.js:1021, dist/index.d.ts:1459-1466). `pausableFilter` remains
  supported for building your own pausable effects.

## Deprecated aliases: use the primary name

All aliases still work in v15 but are marked `@deprecated` (dist/index.d.ts).

| Deprecated alias | Use instead | d.ts line |
| --- | --- | --- |
| `eagerComputed` | `computedEager` (itself deprecated; prefer Vue `computed`) | 20 |
| `controlledComputed` | `computedWithControl` | 35 |
| `createReactiveFn` | `reactify` | 512 |
| `autoResetRef` | `refAutoReset` | 563 |
| `debouncedRef`, `useDebounce` | `refDebounced` | 574, 576 |
| `throttledRef`, `useThrottle` | `refThrottled` | 617, 619 |
| `controlledRef` | `refWithControl` | 650 |
| `debouncedWatch` | `watchDebounced` | 1423 |
| `ignorableWatch` | `watchIgnorable` | 1442 |
| `pausableWatch` | `watchPausable` (itself deprecated; prefer Vue `watch`) | 1466 |
| `throttledWatch` | `watchThrottled` | 1478 |
| `UseTimoutReturn` (type) | `UseTimeoutReturn` | dist/index.d.ts:1322-1324 |

## Behavioral notes to re-check when upgrading

- `useThrottleFn` wrappers now return the trailing call's promise result; the
  filter stores the last value (dist/index.js:423, 433, 444).
- `watchAtMost` returns `{ stop, pause, resume, count }`; `count` is a
  `ShallowRef<number>` of fires so far (dist/index.d.ts:1405-1413).
- `useToggle` returns a `[ShallowRef, toggle]` tuple, or only the toggle
  function when passed an existing `Ref` (dist/index.d.ts:1377-1385).
- `useCounter` `inc` / `dec` / `set` / `reset` return the new value
  (dist/index.js:1501-1508).
