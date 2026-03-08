---
url: /docs/utilities/roving-focus.md
description: >-
  Utility component that implements the roving tabindex method to manage focus
  between items.
---

# Roving Focus

Learn more about roving tabindex in Keyboard Navigation Inside Composite Components

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { RovingFocusGroup, RovingFocusItem } from 'reka-ui'
</script>

<template>
  <RovingFocusGroup>
    <RovingFocusItem />
  </RovingFocusGroup>
</template>
```

## API Reference

### Group

Contains all the parts of a Roving Focus

### Item

The item that would inherit the roving tabindex

## Examples

### Vertical orientation

```vue{2}
<template>
  <RovingFocusGroup :orientation="'vertical'">
    …
  </RovingFocusGroup>
</template>
```

### Loop

Use `loop` property to enable roving from last item to the first item, and vice versa.

```vue{2}
<template>
  <RovingFocusGroup loop>
    …
  </RovingFocusGroup>
</template>
```

### Initial focus item

Set `active` prop to item to initially focused item.

```vue{4}
<template>
  <RovingFocusGroup>
    <RovingFocusItem>1</RovingFocusItem>
    <RovingFocusItem active>2</RovingFocusItem>
    <RovingFocusItem>3</RovingFocusItem>
  </RovingFocusGroup>
</template>
```

### Unfocusable item

Set `focusable="false"` prop to item will prevent them from being focused.

```vue{4}
<template>
  <RovingFocusGroup>
    <RovingFocusItem>1</RovingFocusItem>
    <RovingFocusItem :focusable="false">2</RovingFocusItem>
    <RovingFocusItem>3</RovingFocusItem>
  </RovingFocusGroup>
</template>
```

## Accessibility

Adheres to the Keyboard Navigation Inside Composite Components.

### Keyboard Interactions
