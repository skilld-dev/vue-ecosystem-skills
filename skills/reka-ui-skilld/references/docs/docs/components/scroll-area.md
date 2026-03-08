---
url: /docs/components/scroll-area.md
description: 'Augments native scroll functionality for custom, cross-browser styling.'
---

# ScrollArea

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { ScrollAreaRoot, ScrollAreaScrollbar, ScrollAreaThumb, ScrollAreaViewport } from 'reka-ui'
</script>

<template>
  <ScrollAreaRoot>
    <ScrollAreaViewport />
    <ScrollAreaScrollbar orientation="horizontal">
      <ScrollAreaThumb />
    </ScrollAreaScrollbar>
    <ScrollAreaScrollbar orientation="vertical">
      <ScrollAreaThumb />
    </ScrollAreaScrollbar>
    <ScrollAreaCorner />
  </ScrollAreaRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a scroll area.

### Viewport

The viewport area of the scroll area.

### Scrollbar

The vertical scrollbar. Add a second `Scrollbar` with an `orientation` prop to enable horizontal scrolling.

### Thumb

The thumb to be used in `ScrollAreaScrollbar`.

### Corner

The corner where both vertical and horizontal scrollbars meet.

## Examples

### Custom Scroll

Use the exposed `viewport` to modify / or set the scroll position outside default methods

```vue line=4,18
<script setup lang="ts">
import { ScrollAreaRoot, ScrollAreaScrollbar, ScrollAreaThumb, ScrollAreaViewport } from 'reka-ui'

const scrollArea = useTemplateRef('scrollArea')
function scrollToBottom() {
  const viewport = scrollArea.value?.viewport
  if (viewport) {
    const top = scrollArea.value?.$el.scrollHeight
    container.scrollTo({
      top,
      behavior: 'smooth'
    })
  }
}
</script>

<template>
  <ScrollAreaRoot ref="scrollArea">
    <ScrollAreaViewport />
    <ScrollAreaScrollbar orientation="horizontal">
      <ScrollAreaThumb />
    </ScrollAreaScrollbar>
    <ScrollAreaScrollbar orientation="vertical">
      <ScrollAreaThumb />
    </ScrollAreaScrollbar>
    <ScrollAreaCorner />
  </ScrollAreaRoot>
</template>
```

## Accessibility

In most cases, it's best to rely on native scrolling and work with the customization options available in CSS. When that isn't enough, `ScrollArea` provides additional customizability while maintaining the browser's native scroll behavior (as well as accessibility features, like keyboard scrolling).

### Keyboard Interactions

Scrolling via keyboard is supported by default because the component relies on native scrolling. Specific keyboard interactions may differ between platforms, so we do not specify them here or add specific event listeners to handle scrolling via key events.
