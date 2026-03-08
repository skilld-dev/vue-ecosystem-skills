---
url: /docs/components/toggle-group.md
description: A set of two-state buttons that can be toggled on or off.
---

# ToggleGroup

## Features

## Installation

Install the component from your command line.

## Anatomy

Import the component.

```vue
<script setup>
import { ToggleGroupItem, ToggleGroupRoot } from 'reka-ui'
</script>

<template>
  <ToggleGroupRoot>
    <ToggleGroupItem />
  </ToggleGroupRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a toggle group.

### Item

An item in the group.

## Examples

### Ensuring there is always a value

You can control the component to ensure a value.

```vue line=5,10-13
<script setup>
import { ToggleGroupItem, ToggleGroupRoot } from 'reka-ui'
import { ref } from 'vue'

const value = ref('left')
</script>

<template>
  <ToggleGroupRoot
    :model-value="value"
    @update:model-value="(val) => {
      if (val) value = val
    }"
  >
    <ToggleGroupItem value="left">
      <TextAlignLeftIcon />
    </ToggleGroupItem>
    <ToggleGroupItem value="center">
      <TextAlignCenterIcon />
    </ToggleGroupItem>
    <ToggleGroupItem value="right">
      <TextAlignRightIcon />
    </ToggleGroupItem>
  </ToggleGroupRoot>
</template>
```

## Accessibility

Uses roving tabindex to manage focus movement among items.

### Keyboard Interactions
