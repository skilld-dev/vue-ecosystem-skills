# Rendering patterns

Recipes for `@tanstack/vue-virtual` on virtual-core 3.17.11. Options and methods: [API reference](./virtualizer-api.md). Official examples live under [examples/vue](https://github.com/TanStack/virtual/tree/main/examples/vue/dynamic).

## Fixed-size rows

Skip `measureElement` entirely; `estimateSize` is the size. Everything else in the SKILL.md quick start stays, minus the refs and `measureAll`.

## Dynamic measurement

Two proven wiring options:

1. Array ref + `measureAll` (official Vue examples; see quick start in SKILL.md). `measureElement(null)` first prunes disconnected nodes from the internal observer.
2. Function ref per item:

```html
<div
  v-for="virtualRow in virtualRows"
  :key="virtualRow.key"
  :data-index="virtualRow.index"
  :ref="(el) => rowVirtualizer.measureElement(el as HTMLElement | null)"
>
```

Both rely on the element carrying `data-index` (default `indexAttribute`). Without it, `measureElement` warns and maps the element to index `-1`.

Set `estimateSize` near the largest likely item so scrollbar position and upward scroll stay stable before items measure ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)).

## scrollMargin: headers and shared containers

When the list starts below other content in the same scroll container (header above a window list, several lists sharing a scroller), pass the distance from the container start to the list start. With absolute per-item positioning, subtract it from item starts:

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

```html
:style="{ transform: `translateY(${virtualRows[0]?.start - rowVirtualizer.options.scrollMargin ?? 0}px)` }"
```

Source: [official window example](https://github.com/TanStack/virtual/blob/main/examples/vue/dynamic/src/components/RowVirtualizerDynamicWindow.vue), [virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer). Measure it with `offsetTop`/`getBoundingClientRect()` or a ResizeObserver when content above resizes.

## Masonry / grids

- `lanes: n` splits the list into n columns (vertical) or rows (horizontal); items go to the shortest lane and `VirtualItem.lane` gives the lane index.
- Lane assignments cache immediately from `estimateSize` so items do not jump between lanes on resize. Set `laneAssignmentMode: 'measured'` to cache from measured sizes instead (core 3.14.0, [changelog](https://github.com/TanStack/virtual/blob/main/packages/virtual-core/CHANGELOG.md)).
- Changing `lanes` (responsive column counts) clears measurements and reassigns lanes correctly; content flashes while re-measuring.
- Use `gap` for spacing so `getTotalSize()` includes it.

## Sticky headers and footers

Add fixed indexes outside the visible range with `rangeExtractor`:

```ts
import { defaultRangeExtractor } from '@tanstack/vue-virtual'

rangeExtractor: (range) => {
  const base = defaultRangeExtractor(range)
  const indexes = new Set([0, ...base]) // 0 = sticky header row
  return [...indexes].sort((a, b) => a - b)
}
```

Then treat `virtualItem.index === 0` as the header in the template. See [virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer).

## Horizontal and RTL

`horizontal: true` virtualizes along the x axis (measure with widths, translate with `translateX`). `isRtl: true` inverts offsets for right-to-left layouts.

## Smooth scrolling

`scrollToIndex(i, { behavior: 'smooth' })` skips measuring items far from the target so their size changes cannot shift the target mid-flight ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)). Because of that, use block-translation layout (translate the whole rendered block by the first item's `start`, as in the quick start) rather than positioning each item independently.

## Scroll restoration

Persist on unmount, restore on mount (core 3.15.0; [changelog](https://github.com/TanStack/virtual/blob/main/packages/virtual-core/CHANGELOG.md)):

```ts
const snapshot = rowVirtualizer.value.takeSnapshot()
const offset = rowVirtualizer.value.scrollOffset ?? 0
sessionStorage.setItem('list', JSON.stringify({ snapshot, offset }))
```

```ts
const saved = JSON.parse(sessionStorage.getItem('list') ?? 'null')
const rowVirtualizer = useVirtualizer({
  count: rows.length,
  getScrollElement: () => parentRef.value,
  estimateSize: () => 55,
  initialMeasurementsCache: saved?.snapshot,
  initialOffset: saved?.offset,
})
```

Only measured items are in the snapshot; the rest fall back to `estimateSize` on restore.

## Hidden lists (display: none, inactive tabs)

While the list is hidden, ResizeObserver reports size 0 and resets measurements. Toggle `useCachedMeasurements` (core 3.17.0) around the hidden period:

```ts
const rowVirtualizer = useVirtualizer(
  computed(() => ({
    ...staticOptions,
    useCachedMeasurements: !tabVisible.value, // true while hidden
  })),
)
```

It only affects the default `measureElement` ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)).

## Pausing without unmounting

`enabled: false` (reactively, via computed options) stops observers and resets state while keeping the instance; flip back to `true` to resume.
