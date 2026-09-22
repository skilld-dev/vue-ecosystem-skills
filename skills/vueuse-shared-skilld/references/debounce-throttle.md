# Debounce and throttle, @vueuse/shared 15.0.0

Guide on event filters: https://vueuse.org/guide/config.html#event-filters

## Factories

```ts
import { useDebounceFn, useThrottleFn } from '@vueuse/shared'

// Debounce: trailing-edge after 300ms of quiet, hard cap 1s
const save = useDebounceFn(saveDraft, 300, { maxWait: 1000, rejectOnCancel: true })

// Throttle: at most one call per 200ms; v15 fires leading AND trailing
const onMove = useThrottleFn(handler, 200)
```

### `useDebounceFn(fn, ms = 200, options?) -> CancelablePromisifyFn`

- Returns a function that resolves to `fn`'s return value (dist/index.js:812-814).
- Attached controls: `.cancel()`, `.flush()` (invoke now if pending),
  `.isPending` readonly ref (dist/index.js:310-314, 366-397).
- `options`: `maxWait?: MaybeRefOrGetter<number>` (invoke anyway after the cap),
  `rejectOnCancel?: boolean = false` (dist/index.d.ts:196-208).
- On cancel the promise resolves (not rejects) unless `rejectOnCancel: true`
  (dist/index.js:349).
- `ms <= 0` or `maxWait <= 0` invokes immediately (dist/index.js:339-346).

### `useThrottleFn(fn, ms = 200, trailing = true, leading = true, rejectOnCancel = false) -> PromisifyFn`

- v15 changed the `trailing` default to `true` (dist/index.js:904,
  https://github.com/vueuse/vueuse/releases/tag/v15.0.0).
- No `cancel` / `flush` controls; only debounce has them.
- `rejectOnCancel` only rejects the pending trailing promise when the window
  closes without firing (dist/index.js:433-434).

## Raw filters

Filters wrap any callback, not just timers:

```ts
import { createFilterWrapper, throttleFilter } from '@vueuse/shared'

const filter = throttleFilter({ delay: 500, leading: true, trailing: false })
const limited = createFilterWrapper(filter, fn)
```

- `debounceFilter(ms, options?) -> CancelableEventFilter` (same options as
  `useDebounceFn`).
- `throttleFilter(ms, trailing?, leading?, rejectOnCancel?)` or
  `throttleFilter({ delay, trailing, leading, rejectOnCancel })`
  (dist/index.js:399-410, dist/index.d.ts:224-246).
- `pausableFilter(extendFilter?, { initialState = 'active' }?)` returns
  `{ isActive, pause, resume, eventFilter }`; while paused the wrapped fn never
  runs (dist/index.js:454-472).
- `bypassFilter`: passthrough (dist/index.js:317-319).
- `createFilterWrapper(filter, fn)`: copies `cancel` / `flush` / `isPending`
  onto the wrapper when the filter is cancelable (dist/index.js:300-316).

## Ref variants

- `refDebounced(ref, ms = 200, options?)`: readonly copy updated after quiet.
- `refThrottled(ref, delay = 200, trailing?, leading?)`: `delay <= 0` returns
  the source ref unchanged (dist/index.js:918-919).

## Watch variants

- `watchDebounced(source, cb, { debounce, maxWait, ...watchOptions })`
  (dist/index.js:1851-1857).
- `watchThrottled(source, cb, { throttle, trailing, leading, ...watchOptions })`
  (dist/index.js:1957-1963).
- Any watch can take `eventFilter` via `watchWithFilter`
  (dist/index.js:1015-1018).

## Picking one

- Input validation, search-as-you-type: `useDebounceFn` + `maxWait`.
- Scroll, resize, pointermove: `useThrottleFn`; add `trailing: false`-style
  call (`useThrottleFn(fn, ms, false)`) when the final position is irrelevant.
- Toggle rate limits at runtime: `pausableFilter` + `watchWithFilter`.
