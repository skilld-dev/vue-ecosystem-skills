---
name: vueuse-shared-skilld
description: Use when writing, reviewing, or debugging code that imports from "@vueuse/shared" (or its utilities re-exported by "@vueuse/core"). Provides the v15.0.0 API surface, debounce and throttle defaults, watch variants, state-sharing patterns, and v14 to v15 migration rules.
---

# @vueuse/shared 15.0.0

Framework-agnostic reactive utilities for Vue. Peer dependency `vue ^3.5.0`
(`package.json:40`). ESM-only: `"type": "module"` and no CJS build in `dist`
(`package.json:2`). Requires Node.js >= 22 (`package.json:37`).

Source citations like `dist/index.js:904` refer to the prepared package source.
Function docs: `https://vueuse.org/<functionName>`.

## Critical v15 rules

- `useThrottleFn` default `trailing` changed from `false` to `true` in v15.0.0.
  Defaults are now `ms = 200, trailing = true, leading = true, rejectOnCancel = false`
  (dist/index.js:904). Release: https://github.com/vueuse/vueuse/releases/tag/v15.0.0
  To get v14 leading-edge-only behavior, pass `trailing = false` explicitly.
- `computedEager` / `eagerComputed` are deprecated and slated for removal.
  Use Vue 3.4+ `computed` instead (dist/index.d.ts:5-18).
- `watchPausable` / `pausableWatch` are deprecated on every overload.
  Use Vue's built-in `watch`, whose handle already has `pause()` and `resume()`
  (dist/index.js:1021, dist/index.d.ts:1459-1466).
- Prefer primary names over deprecated aliases; see the table in
  [migration-v15](./references/migration-v15.md).
- Timer composables are no-ops on the server: `useIntervalFn` and `useTimeoutFn`
  only start timers when `isClient` (dist/index.js:1654, dist/index.js:1726-1729).

## Common tasks

```ts
import { useDebounceFn, useThrottleFn } from '@vueuse/shared'

// Debounced fn: returns a promise; cancel/flush/isPending attached
const search = useDebounceFn(query => fetchApi(query), 300, { maxWait: 1000 })

// Rate-limit scroll/resize; v15 fires on BOTH edges by default
const onScroll = useThrottleFn(handler, 200)          // leading + trailing
const onScrollV14 = useThrottleFn(handler, 200, false) // trailing=false, v14 style
```

```ts
import { until, whenever } from '@vueuse/shared'

// One-shot async flow control instead of manual watchers
await until(isReady).toBe(true, { timeout: 5000, throwOnTimeout: true })

// Runs only while truthy; { once: true } auto-stops after the first run
whenever(isReady, data => render(data), { once: true })
```

```ts
import { createInjectionState } from '@vueuse/shared'

// Typed provide/inject pair without manual InjectionKey
const [useProvideStore, useStore] = createInjectionState(() => {
  const count = ref(0)
  return { count, inc: () => count.value++ }
}, { defaultValue: { count: ref(0), inc: () => {} } })
```

```ts
import { refManualReset, syncRef } from '@vueuse/shared'

const message = refManualReset('idle')   // message.reset() restores 'idle'
const num = ref(10), str = ref('10')
syncRef(num, str, {                       // transform is required when
  transform: {                            // types differ (type-level check)
    ltr: v => String(v),
    rtl: v => Number(v),
  },
})
```

More worked patterns: [reactivity-utilities](./references/reactivity-utilities.md),
[watch-utilities](./references/watch-utilities.md).

## Choosing state-sharing tools

| Tool | Lifetime | Use when |
| --- | --- | --- |
| `createGlobalState` | App lifetime, never disposed (dist/index.js:169-180) | App-wide singleton state |
| `createSharedComposable` | Disposed when last subscriber leaves (dist/index.js:583-605) | One shared instance of a composable, e.g. one `useMouse` |
| `createInjectionState` | Tied to component tree | Typed provider/consumer stores |
| `provideLocal` / `injectLocal` | Same component or scope | Provide and inject within one component |

SSR: `createSharedComposable` falls back to the plain composable on the server,
so every request gets fresh state (dist/index.js:584). Details:
[state-sharing](./references/state-sharing.md).

## References

- [api-surface](./references/api-surface.md): complete export inventory with signatures and defaults
- [migration-v15](./references/migration-v15.md): v14 to v15 changes and deprecated alias map
- [debounce-throttle](./references/debounce-throttle.md): filters, `useDebounceFn`, `useThrottleFn` semantics
- [watch-utilities](./references/watch-utilities.md): watch variants, `until`, `whenever`
- [reactivity-utilities](./references/reactivity-utilities.md): ref/computed/sync helpers
- [state-sharing](./references/state-sharing.md): global, shared, and injected state
- [timers-and-utils](./references/timers-and-utils.md): timers, counters, formatting, plain utils
