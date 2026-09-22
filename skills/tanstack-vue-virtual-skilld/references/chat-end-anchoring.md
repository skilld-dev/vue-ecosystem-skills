# Chat and end anchoring

End-anchored virtualization (virtual-core 3.16.0) for chat, AI streams, logs, and reverse feeds. Official guide: [chat docs](https://tanstack.com/virtual/latest/docs/chat). Use a normal scroll container and normal item order; no `flex-direction: column-reverse`, inverted transforms, or manual `scrollTop += delta` prepend compensation.

## Options and methods

| API | Purpose |
| --- | --- |
| `anchorTo: 'end'` | Keep the visible item stable when older items are prepended; keep an end-pinned viewport pinned when the last item grows while streaming. Default is `'start'`. |
| `followOnAppend: boolean \| 'auto' \| 'smooth' \| 'instant'` | With `anchorTo: 'end'`, scroll to the end after appends, but only if the viewport was already within `scrollEndThreshold` of the end. Users reading history are not pulled down. Does not follow prepends. Also follows when older items are trimmed in the same update without growing the count. |
| `scrollEndThreshold: number` | Pixels from the end that count as pinned (default `1`). |
| `scrollToEnd({ behavior? })` | Imperative jump to the latest item. |
| `isAtEnd(threshold?)` | Whether the viewport is pinned; drive "jump to latest" UI. |
| `getDistanceFromEnd()` | Pixel distance to content end. |

## Vue chat component

```vue
<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { useVirtualizer } from '@tanstack/vue-virtual'

const parentRef = ref<HTMLElement | null>(null)
const messages = ref<{ id: string; text: string }[]>([])

const chatVirtualizer = useVirtualizer(
  computed(() => ({
    count: messages.value.length,
    getScrollElement: () => parentRef.value,
    estimateSize: () => 72,
    getItemKey: (index: number) => messages.value[index]!.id,
    anchorTo: 'end',
    followOnAppend: true,
    scrollEndThreshold: 80,
    overscan: 6,
  })),
)

const virtualRows = computed(() => chatVirtualizer.value.getVirtualItems())
const totalSize = computed(() => chatVirtualizer.value.getTotalSize())

// start at the latest message
onMounted(() => chatVirtualizer.value.scrollToEnd())

function loadOlder(older: Message[]) {
  messages.value = [...older, ...messages.value] // prepend stays anchored
}
</script>

<template>
  <div ref="parentRef" style="height: 600px; overflow: auto">
    <div :style="{ height: `${totalSize}px`, position: 'relative' }">
      <div
        v-for="virtualRow in virtualRows"
        :key="virtualRow.key"
        :data-index="virtualRow.index"
        :ref="(el) => chatVirtualizer.measureElement(el as HTMLElement | null)"
        :style="{ position: 'absolute', transform: `translateY(${virtualRow.start}px)` }"
      >
        {{ messages[virtualRow.index]!.text }}
      </div>
    </div>
  </div>
</template>
```

Note the per-item absolute positioning here is fine for chat; smooth `scrollToIndex` flight is rare, and streaming growth is handled by `anchorTo: 'end'`.

## Stable keys are mandatory

`getItemKey` must return the message id. After a prepend, every existing message shifts index; index keys cannot identify the same message across the update, so prepend anchoring and follow-after-trim both break ([chat docs](https://tanstack.com/virtual/latest/docs/chat)).

## Streaming output

While the last item grows (token streaming), end-anchored mode adjusts by the size delta and keeps the bottom pinned, using the normal dynamic measurement pattern above. No extra code.

## Platform notes

- On iOS WebKit, scroll compensation writes are deferred while a finger is down, during momentum, and during elastic overscroll, then flushed once settled (core 3.15.0; [changelog](https://github.com/TanStack/virtual/blob/main/packages/virtual-core/CHANGELOG.md)).
- A smooth `scrollToIndex` stays alive across prepends instead of being cancelled by the anchor sync (core 3.17.11; [changelog](https://github.com/TanStack/virtual/blob/main/packages/virtual-core/CHANGELOG.md)).

## Production checklist

- Stable message ids via `getItemKey`.
- Scroll element with fixed height and `overflow: auto`.
- `measureElement` on every row (`data-index` present).
- `anchorTo: 'end'` for prepend stability and streaming pinning.
- `followOnAppend` so only pinned users follow new output.
- `isAtEnd()` for "jump to latest" UI; `scrollToEnd()` for the button handler.
- Keep loading state outside the virtualizer; prepend/append data normally.
