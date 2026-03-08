---
url: /docs/components/switch.md
description: A control that allows the user to toggle between checked and not checked.
---

# Switch

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { SwitchRoot, SwitchThumb } from 'reka-ui'
</script>

<template>
  <SwitchRoot>
    <SwitchThumb />
  </SwitchRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a switch. An `input` will also render when used within a `form` to ensure events propagate correctly.

### Thumb

The thumb that is used to visually indicate whether the switch is on or off.

## Examples

### Custom Values

Use the `trueValue` and `falseValue` props to specify custom values for the on and off states instead of the default `true`/`false`.

```vue line=4-5,9-10
<script setup>
import { SwitchRoot, SwitchThumb } from 'reka-ui'
import { ref } from 'vue'

// With string values
const status = ref('inactive')

// With number values
const enabled = ref(0)
</script>

<template>
  
  <SwitchRoot v-model="status" true-value="active" false-value="inactive">
    <SwitchThumb />
  </SwitchRoot>
  <span>Status: {{ status }}</span> 

  
  <SwitchRoot v-model="enabled" :true-value="1" :false-value="0">
    <SwitchThumb />
  </SwitchRoot>
  <span>Enabled: {{ enabled }}</span> 
</template>
```

## Accessibility

Adheres to the `switch` role requirements.

### Keyboard Interactions
