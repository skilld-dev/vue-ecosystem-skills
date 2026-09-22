# Virtualizer API (virtual-core 3.17.11)

Types verified against the published [`virtual-core@3.17.11` type definitions](https://unpkg.com/@tanstack/virtual-core@3.17.11/dist/esm/index.d.ts). Full prose: [virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer), [virtual-item docs](https://tanstack.com/virtual/latest/docs/api/virtual-item).

## Required options

| Option | Type | Notes |
| --- | --- | --- |
| `count` | `number` | Total items. Changes propagate to `getTotalSize()` automatically. |
| `getScrollElement` | `() => TScrollElement \| null` | Return the scroll container or `null` before mount. |
| `estimateSize` | `(index: number) => number` | Size in the scroll axis. Overestimate for dynamic items. |

## Optional options

| Option | Type | Default | Purpose |
| --- | --- | --- | --- |
| `enabled` | `boolean` | `true` | `false` disables observers and resets state. |
| `debug` | `boolean` | `false` | Console debug logs. |
| `initialRect` | `Rect` | `{ width: 0, height: 0 }` | SSR scroll element size. |
| `onChange` | `(instance, sync) => void` | none | Fires on state change; `sync` is true while scrolling. Adapter wraps it (`src/index.ts:53-56`). |
| `measureElement` | `(element, entry, instance) => number` | border-box measurement | Custom measurement; override only for special cases. |
| `overscan` | `number` | `1` | Extra items rendered beyond the visible range. |
| `horizontal` | `boolean` | `false` | Horizontal orientation. |
| `paddingStart` / `paddingEnd` | `number` | `0` | Offsets inside the virtualized area. |
| `scrollPaddingStart` / `scrollPaddingEnd` | `number` | `0` | Extra offset applied by `scrollToIndex`. |
| `initialOffset` | `number \| (() => number)` | `0` | Start scroll position; function form is lazy. |
| `getItemKey` | `(index) => Key` | index | Stable keys preserve state and enable chat anchoring. |
| `rangeExtractor` | `(range: Range) => number[]` | `defaultRangeExtractor` | Add fixed indexes (sticky headers, footers). |
| `scrollMargin` | `number` | `0` | Offset of the list start inside the scroll container. |
| `gap` | `number` | `0` | Pixel spacing between items, included in `getTotalSize()`. |
| `indexAttribute` | `string` | `'data-index'` | Attribute `measureElement` reads to map an element to its index. |
| `initialMeasurementsCache` | `VirtualItem[]` | `[]` | Seed measurements; pair with `takeSnapshot()`. |
| `lanes` | `number` | `1` | Columns (vertical) or rows (horizontal) for masonry. |
| `anchorTo` | `'start' \| 'end'` | `'start'` | `'end'` anchors chat/log/reverse feeds. See [chat reference](./chat-end-anchoring.md). |
| `followOnAppend` | `boolean \| 'auto' \| 'smooth' \| 'instant'` | `false` | With `anchorTo: 'end'`, scroll to end on append only if already pinned within `scrollEndThreshold`. |
| `scrollEndThreshold` | `number` | `1` | Pixel threshold for "at end" checks. |
| `isScrollingResetDelay` | `number` | `150` | ms before `isScrolling` resets (fallback path). |
| `useScrollendEvent` | `boolean` | `false` | Use native `scrollend` instead of the debounce. |
| `isRtl` | `boolean` | `false` | Inverts horizontal scrolling for RTL. |
| `useAnimationFrameWithResizeObserver` | `boolean` | `false` | Defers measurements one frame; usually leave off. |
| `laneAssignmentMode` | `'estimate' \| 'measured'` | `'estimate'` | When masonry lane assignments are cached. |
| `useCachedMeasurements` | `boolean` | `false` | Skip DOM reads while the list is hidden; see [patterns](./patterns.md). |

Adapter-required (pre-filled, do not pass): `scrollToFn`, `observeElementRect`, `observeElementOffset`.

## Instance properties and methods

| Member | Signature / type | Purpose |
| --- | --- | --- |
| `options` | `Required<VirtualizerOptions>` | Current options (read-only view). |
| `scrollElement` | `TScrollElement \| null` | Current scroll element. |
| `getVirtualItems()` | `() => VirtualItem[]` | Items to render now. |
| `getVirtualIndexes()` | `() => number[]` | Indexes after `rangeExtractor`. |
| `scrollToOffset(offset, opts?)` | `align?: 'start'\|'center'\|'end'\|'auto'`, `behavior?: 'auto'\|'smooth'\|'instant'` | Scroll to pixel offset. |
| `scrollToIndex(index, opts?)` | same align/behavior | Scroll to item. Smooth scroll measures only near the target; prefer block-translation layout. |
| `scrollBy(delta, opts?)` | `behavior?` | Relative scroll. |
| `scrollToEnd(opts?)` | `behavior?: 'auto'\|'smooth'\|'instant'` | Jump-to-latest for chat/logs. |
| `getDistanceFromEnd()` | `() => number` | Pixels from content end. |
| `isAtEnd(threshold?)` | `() => boolean` | Within threshold (default `scrollEndThreshold`) of the end. |
| `getTotalSize()` | `() => number` | Size for the sizer element. |
| `measure()` | `() => void` | Clear all measurements and re-measure. |
| `takeSnapshot()` | `() => VirtualItem[]` | Measured items for scroll restoration; feed back via `initialMeasurementsCache`. |
| `measureElement(el)` | `(el: TItemElement \| null) => void` | Attach measurement; element needs `data-index`; `null` prunes disconnected nodes. |
| `resizeItem(index, size)` | `(index: number, size: number) => void` | Manual size override; do not mix with `measureElement` on the same index. |
| `scrollRect` | `Rect \| null` | Scroll element size. |
| `scrollOffset` | `number \| null` | Current scroll position. |
| `scrollDirection` | `'forward' \| 'backward' \| null` | Last scroll direction. |
| `isScrolling` | `boolean` | Scroll in progress. |
| `shouldAdjustScrollPositionOnItemSizeChange` | instance property, not an option | See below. |

### `shouldAdjustScrollPositionOnItemSizeChange`

Assign directly on the instance after creation; it is a class field, not an option ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer), [core types](https://unpkg.com/@tanstack/virtual-core@3.17.11/dist/esm/index.d.ts)):

```ts
rowVirtualizer.value.shouldAdjustScrollPositionOnItemSizeChange = (
  item,
  delta,
  instance,
) => item.start + item.size <= instance.scrollOffset!
```

Default behavior: compensate scroll when an above-viewport item's measured size differs from its estimate, but skip compensation for re-measurements while scrolling backward (added in core 3.15.0, refined in 3.17.1 and 3.17.6; [changelog](https://github.com/TanStack/virtual/blob/main/packages/virtual-core/CHANGELOG.md)). On iOS WebKit, compensation writes are deferred while the user is touching, momentum-scrolling, or bouncing, then flushed in one write.

## VirtualItem

| Field | Type | Purpose |
| --- | --- | --- |
| `key` | `Key` (`number \| string \| bigint`) | Key from `getItemKey`; use as `v-for` `:key`. |
| `index` | `number` | Index into your data; write to `data-index`. |
| `start` / `end` | `number` | Pixel offsets in the scroll axis. |
| `size` | `number` | Estimate before measurement, measured after. |
| `lane` | `number` | Lane index for masonry (`lanes > 1`); always `0` otherwise. |
