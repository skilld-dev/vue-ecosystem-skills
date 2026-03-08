---
url: /docs/utilities/use-forward-expose.md
description: 'Forward component''s exposed value, props and $el.'
---

# useForwardExpose

When building a component, if we have a non-single root node component, the template refs will not return the DOM element via `$el` (read more) , thus, we need to forward the `$el` in template ref for this component manually. Or in some case you want to target certain element as the expose element..

Furthermore, this composable extend the missing exposed `props` from the template refs.

## Usage

```vue
<script setup lang="ts">
import { useForwardExpose } from 'reka-ui'

const selectedElementId = ref(1)
const { forwardRef } = useForwardExpose()
</script>

<template>
  <span>
    
    <div :ref="forwardRef">
      ...
    </div>
  </span>
</template>
```
