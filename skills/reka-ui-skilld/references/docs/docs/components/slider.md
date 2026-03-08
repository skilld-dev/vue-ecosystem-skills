---
url: /docs/components/slider.md
description: An input where the user selects a value from within a given range.
---

# Slider

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { SliderRange, SliderRoot, SliderThumb, SliderTrack } from 'reka-ui'
</script>

<template>
  <SliderRoot>
    <SliderTrack>
      <SliderRange />
    </SliderTrack>
    <SliderThumb />
  </SliderRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a slider. It will render an `input` for each thumb when used within a `form` to ensure events propagate correctly.

### Track

The track that contains the `SliderRange`.

### Range

The range part. Must live inside `SliderTrack`.

### Thumb

A draggable thumb. You can render multiple thumbs.

## Examples

### Vertical orientation

Use the `orientation` prop to create a vertical slider.

```vue line=10
// index.vue
<script setup>
import { SliderRange, SliderRoot, SliderThumb, SliderTrack } from 'reka-ui'
</script>

<template>
  <SliderRoot
    class="SliderRoot"
    :default-value="[50]"
    orientation="vertical"
  >
    <SliderTrack class="SliderTrack">
      <SliderRange class="SliderRange" />
    </SliderTrack>
    <SliderThumb class="SliderThumb" />
  </SliderRoot>
</template>
```

```css line=7,18,26
/* styles.css */
.SliderRoot {
  position: relative;
  display: flex;
  align-items: center;
}
.SliderRoot[data-orientation="vertical"] {
  flex-direction: column;
  width: 20px;
  height: 100px;
}

.SliderTrack {
  position: relative;
  flex-grow: 1;
  background-color: grey;
}
.SliderTrack[data-orientation="vertical"] {
  width: 3px;
}

.SliderRange {
  position: absolute;
  background-color: black;
}
.SliderRange[data-orientation="vertical"] {
  width: 100%;
}

.SliderThumb {
  display: block;
  width: 20px;
  height: 20px;
  background-color: black;
}
```

### Create a range

Add multiple thumbs and values to create a range slider.

```vue line=7,11-12
// index.vue
<script setup>
import { SliderRange, SliderRoot, SliderThumb, SliderTrack } from 'reka-ui'
</script>

<template>
  <SliderRoot :default-value="[25, 75]">
    <SliderTrack>
      <SliderRange />
    </SliderTrack>
    <SliderThumb />
    <SliderThumb />
  </SliderRoot>
</template>
```

### Define step size

Use the `step` prop to increase the stepping interval.

```vue line=9
// index.vue
<script setup>
import { SliderRange, SliderRoot, SliderThumb, SliderTrack } from 'reka-ui'
</script>

<template>
  <SliderRoot
    :default-value="[50]"
    :step="10"
  >
    <SliderTrack>
      <SliderRange />
    </SliderTrack>
    <SliderThumb />
  </SliderRoot>
</template>
```

### Prevent thumb overlap

Use `minStepsBetweenThumbs` to avoid thumbs with equal values.

```vue line=10
// index.vue
<script setup>
import { SliderRange, SliderRoot, SliderThumb, SliderTrack } from 'reka-ui'
</script>

<template>
  <SliderRoot
    :default-value="[25, 75]"
    :step="10"
    :min-steps-between-thumbs="1"
  >
    <SliderTrack>
      <SliderRange />
    </SliderTrack>
    <SliderThumb />
    <SliderThumb />
  </SliderRoot>
</template>
```

## Accessibility

Adheres to the Slider WAI-ARIA design pattern.

### Keyboard Interactions

#### Inverted sliders

When the slider is inverted, some controls are inverted as well, depending on the orientation.

* When the slider is horizontal (the default), ArrowRight, ArrowLeft, Home, and End are inverted.
* When the slider is vertical, ArrowUp, ArrowDown, PageUp, PageDown, Shift + ArrowUp, and Shift + ArrowDown are inverted.

## Custom APIs

Create your own API by abstracting the primitive parts into your own component.

### Abstract all parts

This example abstracts all of the `Slider` parts so it can be used as a self closing element.

#### Usage

```vue
<script setup lang="ts">
import { Slider } from './your-slider'
</script>

<template>
  <Slider :default-value="[25]" />
</template>
```

#### Implementation

```ts
// your-slider.ts
export { default as Slider } from 'Slider.vue'
```

```vue
 
<script setup lang="ts">
import type { SliderRootEmits, SliderRootProps } from 'reka-ui'
import { SliderRange, SliderRoot, SliderThumb, SliderTrack, useForwardPropsEmits } from 'reka-ui'

const props = defineProps<SliderRootProps>()
const emits = defineEmits<SliderRootEmits>()

const forward = useForwardPropsEmits(props, emits)
</script>

<template>
  <SliderRoot v-slot="{ modelValue }" v-bind="forward">
    <SliderTrack>
      <SliderRange />
    </SliderTrack>

    <SliderThumb
      v-for="(_, i) in modelValue"
      :key="i"
    />
  </SliderRoot>
</template>
```

## Caveats

### Mouse events are not fired

Because of a limitation we faced during implementation, the following example won't work as expected and the `@mousedown` and `@mousedown` event handlers won't be fired:

```vue
<SliderRoot
  @mousedown="() => { console.log('onMouseDown')  }"
  @mouseup="() => { console.log('onMouseUp')  }"
>
  …
</SliderRoot>
```

We recommend using pointer events instead (eg. `@pointerdown`, `@pointerup`). Regardless of the above limitation, these events are better suited for cross-platform/device handling as they are fired for all pointer input types (mouse, touch, pen, etc.).
