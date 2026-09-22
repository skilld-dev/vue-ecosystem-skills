# Migration: v14.3.0 to v15.0.0

Everything below is cited to the official release notes; nothing is copied
verbatim. Read the linked release for the full list.

## v15.0.0 (16 Sep 2026)

Release: <https://github.com/vueuse/vueuse/releases/tag/v15.0.0>
Compare range: v14.4.0...v15.0.0.

### Breaking

- **`templateRef` removed.** Migrate to Vue's built-in `useTemplateRef()`.
  PR [#4883](https://github.com/vueuse/vueuse/pull/4883).
- **Node.js 20 support dropped.** Engines now `>= 22` (`package.json:39`).
  PR [#5553](https://github.com/vueuse/vueuse/pull/5553).
- **Deprecated timer options removed in favor of `scheduler`.** Any
  `interval` / `immediate` options passed to `ConfigurableScheduler`
  composables (`useCountdown`, `useNow`, `useTimestamp`, `useTimeAgo`,
  `useTimeAgoIntl`, `useElementByPoint`, `useMemory`, `useVibrate`,
  `useWebSocket` `heartbeat`) are ignored or type errors now. Provide
  `scheduler: (cb) => Pausable` instead (e.g. wrap `useRafFn`).
  PR [#5564](https://github.com/vueuse/vueuse/pull/5564). The affected v15
  option interfaces all extend/intersect `ConfigurableScheduler`
  (`dist/index.d.ts:1291,1967,3415,3707,4834,4894,4942,5282,5634`).
- **`useEventSource`** now handles the SSE `message` event type and triggers
  both `onmessage` and `addEventListener` paths.
  PR [#5331](https://github.com/vueuse/vueuse/pull/5331).
- **`useThrottleFn` default `trailing` changed from `false` to `true`.**
  PR [#5249](https://github.com/vueuse/vueuse/pull/5249).
- `@vueuse/integrations` **`useIDBKeyval`** now syncs changes across tabs
  (behavioral break if you relied on per-tab isolation).
  PR [#5338](https://github.com/vueuse/vueuse/pull/5338).

### New

- **`useWebMCP`**: register WebMCP tools on `document.modelContext`.
  PR [#5580](https://github.com/vueuse/vueuse/pull/5580). See
  [new-functions-v15.md](./new-functions-v15.md).
- **`useLiveAnnouncer`**: aria-live announcements.
  PR [#5315](https://github.com/vueuse/vueuse/pull/5315).
- **`useTemporalNow`**: reactive Temporal `ZonedDateTime`.
  PR [#4793](https://github.com/vueuse/vueuse/pull/4793).

### Fixes that change observed behavior

- `useFetch`: a stale success response after a newer request starts is ignored.
  PR [#5574](https://github.com/vueuse/vueuse/pull/5574).
- `useWebSocket`: messages from a superseded socket are ignored.
  PR [#5573](https://github.com/vueuse/vueuse/pull/5573).
- `useResizeObserver`: `observe()` guarded with `instanceof Element`; comment
  nodes no longer crash it. PR [#5593](https://github.com/vueuse/vueuse/pull/5593).
- `onLongPress`: pending press cleared on `pointercancel`.
  PR [#5555](https://github.com/vueuse/vueuse/pull/5555).
- `usePointer`: `isInside` reset on `pointercancel`.
  PR [#5587](https://github.com/vueuse/vueuse/pull/5587).
- `useBluetooth`: deduped disconnect listener, reconnect on mount.
  PR [#5603](https://github.com/vueuse/vueuse/pull/5603).
- `useCloned`: custom clone function is now type-safe.
  PR [#5559](https://github.com/vueuse/vueuse/pull/5559).
- Tree-shaking annotations corrected for overloaded and arrow functions
  (smaller bundles possible). PR [#5613](https://github.com/vueuse/vueuse/pull/5613).

## v14.4.0 (29 Jul 2026)

Release: <https://github.com/vueuse/vueuse/releases/tag/v14.4.0>
Compare range: v14.3.0...v14.4.0.

### New

- **`useElementOverflow`**: reactive `isXOverflowed` / `isYOverflowed`.
  PR [#4094](https://github.com/vueuse/vueuse/pull/4094).
- `useDebounceFn`: `flush` and `isPending` added to the filter system.
  PR [#5259](https://github.com/vueuse/vueuse/pull/5259).
- `useVirtualList`: `scrollTo(index, { behavior, block, inline })`.
  PR [#4905](https://github.com/vueuse/vueuse/pull/4905).
- `useSpeechRecognition`: exposes `confidence` of the latest result.
  PR [#5398](https://github.com/vueuse/vueuse/pull/5398).
- `onStartTyping`: more configurable options.
  PR [#5395](https://github.com/vueuse/vueuse/pull/5395).

### Fixes that change observed behavior

- `useFetch`: stale abort errors after a successful refetch are ignored.
  PR [#5525](https://github.com/vueuse/vueuse/pull/5525).
- `useWebSocket`: status syncs to `CLOSED` after explicit `close()`.
  PR [#5471](https://github.com/vueuse/vueuse/pull/5471).
- `useEventBus`: uses `tryOnScopeDispose` instead of Vue internal API.
  PR [#5548](https://github.com/vueuse/vueuse/pull/5548).
- `useDraggable` / `usePointerSwipe`: end on `pointercancel`.
  PRs [#5550](https://github.com/vueuse/vueuse/pull/5550),
  [#5379](https://github.com/vueuse/vueuse/pull/5379).
- `useVirtualList`: range recomputed when item size changes.
  PR [#5533](https://github.com/vueuse/vueuse/pull/5533).
- `useStyleTag`: multiple components sharing one id no longer error.
  PR [#5473](https://github.com/vueuse/vueuse/pull/5473).
- `useElementSize`: prefills size based on the `box` option.
  PR [#5524](https://github.com/vueuse/vueuse/pull/5524).

## Standing deprecations in v15 (still exported, avoid in new code)

- `computedEager`: docs state it will be removed; use `computed()` on Vue 3.4+
  ([docs](https://vueuse.org/shared/computedEager/)).
- `watchPausable`: use Vue 3.5 `watch()` `pause`/`resume`
  ([docs](https://vueuse.org/shared/watchPausable/)).
- `executeTransition` and `UseTransitionOptions.transition`: use `transition()`
  and `easing` (`dist/index.d.ts:5114-5121`).
- `breakpointsVuetify`: alias of `breakpointsVuetifyV2`; use V2/V3 explicitly
  (`dist/index.d.ts:758-762`).
- `asyncComputed`: alias of `computedAsync` (`dist/index.d.ts:46`).

## Forward-compatibility warnings

- `ConfigurableDeepRefs.deepRefs` defaults to `true` in v15 and flips to
  `false` in the next major (`dist/index.d.ts:204-211`). Pass `deepRefs`
  explicitly anywhere the ref depth matters.
- `computedAsync` defaults: `flush: 'sync'`, `shallow: true`, and `onError`
  falls back to `globalThis.reportError` (`dist/index.js:10`). Wrap `onError`
  when reportError noise is unwanted.
