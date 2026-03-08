---
url: /docs/utilities/primitive.md
description: >-
  Compose Reka's functionality onto alternative element types or your own Vue
  components.
---

# Primitive

When you are building a component, in some cases you might want to allow user to compose some functionalities onto the underlying element, or alternative element. This is where `Primitive` comes in handy as it expose this capability to the user.

## API Reference

## Usage

### Changing `as` value

If you want to change the default element or component being render, you can set the default `as` when defining the props.

```vue
<script setup lang="ts">
import type { PrimitiveProps } from 'reka-ui'
import { Primitive } from 'reka-ui'

const props = withDefaults(defineProps<PrimitiveProps>(), {
  as: 'span'
})
</script>

<template>
  
  <Primitive v-bind="props">
    ...
  </Primitive>
</template>
```

### Render `asChild`

Change the default rendered element for the one passed as a child, merging their props and behavior.Read our Composition guide for more details.
