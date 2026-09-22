---
name: vueuse-core-skilld
description: Collection of essential Vue Composition Utilities. ALWAYS use when writing code that imports "@vueuse/core" or "@vueuse/shared" (VueUse). Provides the v15.0.0 API surface, v14 to v15 migration rules, new composables (useWebMCP, useTemporalNow, useLiveAnnouncer, useElementOverflow), deprecations, and configuration best practices.
---

# @vueuse/core 15.0.0

Prepared source: `@vueuse/core@15.0.0` (`package.json:4`). File citations below use
paths relative to that package root. Docs citations are absolute URLs.

## Environment limits

- ESM-only since v13 (`"type": "module"`, `package.json:3`). `require()` fails.
- Requires Vue `^3.5.0` (`package.json:42`).
- Requires Node.js `>= 22` (`package.json:39`); Node 20 support dropped in v15.0.0
  ([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0)).
- Exports: `.` and `./metadata` (`package.json:24-28`). Everything ships from `dist/`.
- `@vueuse/shared@15.0.0` is a dependency and fully re-exported
  (`dist/index.d.ts:3`), so `import { useToggle } from '@vueuse/core'` works; see
  [shared API](./references/shared-api.md).

## v15 rules that change generated code

1. **No `templateRef`.** Removed in v15.0.0
   ([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0)). Use Vue's
   built-in `useTemplateRef()` instead.
2. **Timer options are gone; pass `scheduler`.** The deprecated per-composable
   `interval` / `immediate` options were removed from `ConfigurableScheduler`
   composables in v15.0.0 ([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0)).
   Affected options interfaces extend or intersect `ConfigurableScheduler`
   (`dist/index.d.ts:212-217`): `useCountdown`, `useNow`, `useTimestamp`,
   `useTimeAgo`, `useTimeAgoIntl`, `useTemporalNow`, `useElementByPoint`,
   `useMemory`, `useVibrate`, and `useWebSocket`'s `heartbeat` option.
   `scheduler` is `(cb: Fn) => Pausable`, so `useRafFn` plugs in directly.
3. **`useThrottleFn` now fires trailing calls by default** (`trailing` default
   changed false to true, v15.0.0
   ([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0))). Pass
   `trailing = false` (3rd argument) to keep v14 behavior.
4. **`useEventSource` handles SSE `message` events** and triggers both
   `onmessage` and `addEventListener` handlers (v15.0.0
   ([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0))). Do not
   add manual duplicate listeners for unnamed events.
5. **`deepRefs` default flips next major.** It defaults to `true` today with an
   explicit warning that the next major changes it to `false`
   (`dist/index.d.ts:204-211`). Pass `deepRefs` explicitly where the value
   matters.

## Do not use (deprecated or replaced)

| Export | Replacement | Evidence |
| --- | --- | --- |
| `computedEager` | `computed()` (Vue 3.4+ no longer re-triggers on unchanged values) | [docs](https://vueuse.org/shared/computedEager/) "will be removed in future version" |
| `watchPausable` | Vue 3.5 native `watch()` returns `{ stop, pause, resume }` | [docs](https://vueuse.org/shared/watchPausable/) |
| `executeTransition` | `transition(source, from, to, options)` | deprecated at `dist/index.d.ts:5114-5121` |
| `UseTransitionOptions.transition` | `easing` option | same deprecation block |
| `breakpointsVuetify` | `breakpointsVuetifyV2` or `breakpointsVuetifyV3` | deprecated at `dist/index.d.ts:758-762` |
| `asyncComputed` | `computedAsync` (alias remains, `dist/index.d.ts:46`) | alias of `computedAsync` |

## Common tasks

```ts
import { useLocalStorage, useDark, useTitle, useThrottleFn } from '@vueuse/core'

// Reactive getter args enable derived values without computed()
const isDark = useDark()
const title = useTitle(() => isDark.value ? 'Night' : 'Day')

// Storage with schema evolution: mergeDefaults fills new keys
const settings = useLocalStorage('settings', { theme: 'light', density: 'comfortable' }, { mergeDefaults: true })

// v15 throttle fires a trailing call by default; 3rd arg is `trailing`
const onResize = useThrottleFn(handler, 200, false, true) // trailing=false, leading=true
```

```ts
import { useWebMCP } from '@vueuse/core'

// Register a WebMCP tool for browser agents (new in v15)
const { isSupported, isRegistered, error } = useWebMCP({
  name: 'get-current-user',
  description: 'Returns the signed-in user id',
  inputSchema: { type: 'object' },
  execute: () => ({ userId: user.value?.id ?? null }),
})
```

More patterns: [best practices](./references/best-practice.md).

## References

- [API surface](./references/api-surface.md): complete v15 export inventory, grouped.
- [Shared API](./references/shared-api.md): the `@vueuse/shared` functions re-exported by core.
- [Migration v14 to v15](./references/migration-v15.md): every breaking change, feature, and notable fix since v14.3.0, cited.
- [New functions in v15](./references/new-functions-v15.md): `useWebMCP`, `useTemporalNow`, `useLiveAnnouncer`, `useElementOverflow` usage.
- [Best practices](./references/best-practice.md): getters, event filters, storage serializers, schedulers, SSR, scoping.

## Debugging notes (v15 fixes that may explain behavior changes)

- `useFetch` ignores a stale success response after a newer request starts, and
  ignores stale abort errors after a refetch succeeds
  ([v15](https://github.com/vueuse/vueuse/releases/tag/v15.0.0),
  [v14.4](https://github.com/vueuse/vueuse/releases/tag/v14.4.0)).
- `useWebSocket` ignores messages from a superseded socket and syncs status to
  `CLOSED` after explicit `close()` (same releases).
- `useResizeObserver` guards `observe()` with `instanceof Element`, so Vue
  comment nodes no longer crash it ([v15](https://github.com/vueuse/vueuse/releases/tag/v15.0.0)).
- Pointer handling: `useDraggable` and `usePointerSwipe` end on `pointercancel`,
  `usePointer` resets `isInside`, `onLongPress` clears pending presses
  ([v15](https://github.com/vueuse/vueuse/releases/tag/v15.0.0),
  [v14.4](https://github.com/vueuse/vueuse/releases/tag/v14.4.0)).
