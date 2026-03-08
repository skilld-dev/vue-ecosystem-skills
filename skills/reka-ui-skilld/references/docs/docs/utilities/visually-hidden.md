---
url: /docs/utilities/visually-hidden.md
description: Hides content from the screen in an accessible way.
---

# Visually Hidden

## Anatomy

Import the component.

```vue
<script setup lang="ts">
import { VisuallyHidden } from 'reka-ui'
</script>

<template>
  <VisuallyHidden>
    <slot />
  </VisuallyHidden>
</template>
```

## Basic example

Use the visually hidden primitive.

```vue
<script setup lang="ts">
import { GearIcon } from '@radix-icons/vue'
import { VisuallyHidden } from 'reka-ui'
</script>

<template>
  <button>
    <GearIcon />
    <VisuallyHidden>Settings</VisuallyHidden>
  </button>
</template>
```

## API Reference

### Root

Anything you put inside this component will be hidden from the screen but will be announced by screen readers.

## Accessibility

This is useful in certain scenarios as an alternative to traditional labelling with `aria-label` or `aria-labelledby`.
