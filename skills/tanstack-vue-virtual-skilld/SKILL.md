---
name: tanstack-vue-virtual-skilld
description: Headless UI for virtualizing scrollable elements in Vue. Use when writing, reviewing, or debugging code that imports @tanstack/vue-virtual, calls useVirtualizer or useWindowVirtualizer, or virtualizes lists, grids, masonry, window-scrolled content, or chat feeds in Vue. Provides version-accurate adapter rules, Virtualizer options and methods, and rendering recipes for @tanstack/vue-virtual 3.13.x on @tanstack/virtual-core 3.17.x.
---

# @tanstack/vue-virtual

Headless list/grid virtualization for Vue. The adapter is thin: `useVirtualizer` and `useWindowVirtualizer` construct a core `Virtualizer`, wire it to Vue reactivity, and return it as a `Ref`. Every option and method below comes from `@tanstack/virtual-core`, which the adapter re-exports (`src/index.ts:21`).

## Version facts

- Target: `@tanstack/vue-virtual@3.13.39` (`package.json:3`).
- Exact dependency: `@tanstack/virtual-core@3.17.11` (`package.json:52`).
- Peer: `vue ^2.7.0 || ^3.0.0` (`package.json:59`).
- The adapter API has been stable across 3.13.x; releases 3.13.25 to 3.13.39 only bump virtual-core ([vue-virtual changelog](https://github.com/TanStack/virtual/blob/main/packages/vue-virtual/CHANGELOG.md)).
- Install: `npm install @tanstack/vue-virtual` ([installation docs](https://tanstack.com/virtual/latest/docs/installation)).

## Quick start: dynamic-height rows

Canonical pattern, following the [official Vue dynamic example](https://github.com/TanStack/virtual/blob/main/examples/vue/dynamic/src/components/RowVirtualizerDynamic.vue). Block translation positions the rendered block by the first item's `start`; each item flows normally inside it.

```vue
<script setup lang="ts">
import { computed, onMounted, onUpdated, ref, shallowRef } from 'vue'
import { useVirtualizer } from '@tanstack/vue-virtual'

const parentRef = ref<HTMLElement | null>(null)
const rows = Array.from({ length: 10000 }, (_, i) => `Row ${i}`)

const rowVirtualizer = useVirtualizer({
  count: rows.length,
  getScrollElement: () => parentRef.value,
  estimateSize: () => 55,
  overscan: 5,
})

const virtualRows = computed(() => rowVirtualizer.value.getVirtualItems())
const totalSize = computed(() => rowVirtualizer.value.getTotalSize())

const itemEls = shallowRef<HTMLElement[]>([])
function measureAll() {
  rowVirtualizer.value.measureElement(null) // prune disconnected nodes
  itemEls.value.forEach((el) => el && rowVirtualizer.value.measureElement(el))
}
onMounted(measureAll)
onUpdated(measureAll)
</script>

<template>
  <div ref="parentRef" style="height: 400px; overflow-y: auto; contain: strict">
    <div :style="{ height: `${totalSize}px`, position: 'relative', width: '100%' }">
      <div
        :style="{
          position: 'absolute',
          top: 0,
          left: 0,
          width: '100%',
          transform: `translateY(${virtualRows[0]?.start ?? 0}px)`,
        }"
      >
        <div
          v-for="virtualRow in virtualRows"
          :key="virtualRow.key"
          :data-index="virtualRow.index"
          ref="itemEls"
        >
          {{ rows[virtualRow.index] }}
        </div>
      </div>
    </div>
  </div>
</template>
```

The scroll container needs a bounded height and `overflow: auto`. The inner sizer div carries `getTotalSize()`.

## Window virtualizer

`useWindowVirtualizer` scrolls with the browser window; it pre-fills `getScrollElement` (SSR-safe) and `initialOffset`, so pass neither ([vue-virtual docs](https://tanstack.com/virtual/latest/docs/framework/vue/vue-virtual), `src/index.ts:104-114`). When the list sits below other content, measure that offset into `scrollMargin`:

```ts
const parentOffset = ref(0)
onMounted(() => {
  parentOffset.value = parentRef.value?.offsetTop ?? 0
})

const rowVirtualizer = useWindowVirtualizer(
  computed(() => ({
    count: rows.length,
    estimateSize: () => 45,
    scrollMargin: parentOffset.value,
  })),
)
```

Pattern source: [official window example](https://github.com/TanStack/virtual/blob/main/examples/vue/dynamic/src/components/RowVirtualizerDynamicWindow.vue).

## Vue adapter rules (proven by `src/index.ts`)

- Returns `Ref<Virtualizer>`, not a raw instance. Use `.value` in script; templates auto-unwrap (`src/index.ts:30,69`).
- Options accept `MaybeRef`. A plain object is applied once; to update `count`, `overscan`, `enabled`, etc. reactively, pass a `ref` or `computed` of the whole options object. The adapter watches `() => unref(options)` and calls `setOptions` on change (`src/index.ts:48-65`).
- `getScrollElement()` is watched with `immediate: true`. A template ref that is still `null` on setup is picked up when it mounts (`src/index.ts:36-46`).
- `onChange` is wrapped: the adapter calls `triggerRef` on its internal `shallowRef` before your callback, so `computed(() => rowVirtualizer.value.getVirtualItems())` re-evaluates on scroll and resize (`src/index.ts:53-56`).
- Observers are cleaned up via `onScopeDispose` (`src/index.ts:67`).
- Items measured with `measureElement` must carry the index attribute, `data-index` by default (configurable via `indexAttribute`).
- Do not pass `observeElementRect`, `observeElementOffset`, or `scrollToFn`; the adapter pre-fills them (`src/index.ts:83-90`).

Details: [Vue adapter API](./references/vue-adapter.md).

## API reference

Full options table, instance methods, and `VirtualItem` shape: [Virtualizer API](./references/virtualizer-api.md).

Required options for `useVirtualizer`: `count`, `getScrollElement`, `estimateSize` ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)).

## What is new since virtual-core 3.14.0

vue-virtual 3.13.39 ships core 3.17.11; these arrived via core minors ([virtual-core changelog](https://github.com/TanStack/virtual/blob/main/packages/virtual-core/CHANGELOG.md)):

- 3.16.0: end-anchored mode for chat, logs, reverse feeds. `anchorTo: 'end'`, `followOnAppend`, `scrollEndThreshold`, plus `scrollToEnd()`, `isAtEnd()`, `getDistanceFromEnd()`. See [Chat and end anchoring](./references/chat-end-anchoring.md).
- 3.15.0: `takeSnapshot()` for scroll restoration round-trips with `initialMeasurementsCache` + `initialOffset`.
- 3.15.0: default scroll adjustment now skips compensation during backward scroll (fixes "items jump while scrolling up"); override by assigning the instance property `shouldAdjustScrollPositionOnItemSizeChange`, which is not an option.
- 3.15.0: iOS Safari momentum-scroll handling, default on; scroll compensation writes are deferred while touching or bouncing.
- 3.17.0: `useCachedMeasurements` keeps measurements alive while the list is hidden.
- Pre-3.15 options still current: `lanes` with `laneAssignmentMode` (3.14.0), `gap`, `indexAttribute`, `initialMeasurementsCache`, `isRtl`.

## Best practices

- Estimate large for dynamic items: set `estimateSize` near the maximum likely size so initial positions and the scrollbar stay stable ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)).
- Prefer block translation (as in the quick start) over per-item absolute positioning; smooth `scrollToIndex` skips measuring items far from the target, and block translation keeps the rendered block internally consistent ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)).
- Give a stable `getItemKey` (row id, not index) whenever data reorders, filters, prepends, or streams; index keys break end-anchored chat and scroll restoration ([chat docs](https://tanstack.com/virtual/latest/docs/chat)).
- Subtract `scrollMargin` from item starts when items are positioned absolutely inside a shared scroll container ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)).
- Use the `gap` option instead of CSS margins so `getTotalSize()` accounts for spacing.
- `count` changes invalidate the measurement cache and update `getTotalSize()` automatically (fixed in 3.13.13, [changelog](https://github.com/TanStack/virtual/blob/main/packages/vue-virtual/CHANGELOG.md)); in Vue still route reactive data through `computed` options.
- Leave `useAnimationFrameWithResizeObserver` off unless measured to help; it defers measurements by a frame ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)).
- Pause observers with `enabled: false` instead of unmounting to preserve measurements.

Recipes for masonry, padding, sticky headers, scroll restoration, and hidden lists: [Patterns](./references/patterns.md).

Migrating from v2: `useVirtual` is gone; v3 uses `useVirtualizer`, the `count` option (not `size`), `getScrollElement` (not `parentRef`), and `measureElement` refs with `data-index` ([vue-virtual docs](https://tanstack.com/virtual/latest/docs/framework/vue/vue-virtual)).

## References

- [Vue adapter API](./references/vue-adapter.md): signatures, reactivity contract, SSR behavior.
- [Virtualizer API](./references/virtualizer-api.md): all options, defaults, instance methods, `VirtualItem`.
- [Patterns](./references/patterns.md): masonry, scroll margin, sticky ranges, scroll restoration, hidden lists.
- [Chat and end anchoring](./references/chat-end-anchoring.md): `anchorTo: 'end'` chat feeds in Vue.
