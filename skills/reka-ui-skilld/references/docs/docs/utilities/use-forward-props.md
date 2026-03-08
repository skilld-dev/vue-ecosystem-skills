---
url: /docs/utilities/use-forward-props.md
description: Forward component's props without boolean casting
---

# useForwardProps

When you are building a wrapper for a component, in some cases you want to ignore Vue Props Boolean Casting.

You can either set default value as `undefined` for all the boolean field, or you can use this composable.

## Usage

```vue
<script setup lang="ts">
import { useForwardProps } from 'reka-ui'

const props = defineProps<CompEmitProps>()
const forwarded = useForwardProps(props)
</script>

<template>
  <Comp v-bind="forwarded">
    ...
  </Comp>
</template>
```
