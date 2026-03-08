---
url: /docs/components/checkbox.md
description: A control that allows the user to toggle between checked and not checked.
---

# Checkbox

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { CheckboxGroupRoot, CheckboxIndicator, CheckboxRoot } from 'reka-ui'
</script>

<template>
  <CheckboxRoot>
    <CheckboxIndicator />
  </CheckboxRoot>

  
  <CheckboxGroupRoot>
    <CheckboxRoot>
      <CheckboxIndicator />
    </CheckboxRoot>
  </CheckboxGroupRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a checkbox. An `input` will also render when used within a `form` to ensure events propagate correctly.

### Indicator

Renders when the checkbox is in a checked or indeterminate state. You can style this element directly, or you can use it as a wrapper to put an icon into, or both.

### Group Root

Wrapper around `CheckboxRoot` to support array of `modelValue`

## Examples

### Custom Values

Use the `trueValue` and `falseValue` props to specify custom values for the checked and unchecked states instead of the default `true`/`false`.

```vue line=5-6,11-12
<script setup>
import { Icon } from '@iconify/vue'
import { CheckboxIndicator, CheckboxRoot } from 'reka-ui'
import { ref } from 'vue'

// With string values
const acceptTerms = ref('no')

// With number values
const permission = ref(0)
</script>

<template>
  
  <CheckboxRoot v-model="acceptTerms" true-value="yes" false-value="no">
    <CheckboxIndicator>
      <Icon icon="radix-icons:check" />
    </CheckboxIndicator>
  </CheckboxRoot>
  <span>Value: {{ acceptTerms }}</span> 

  
  <CheckboxRoot v-model="permission" :true-value="1" :false-value="0">
    <CheckboxIndicator>
      <Icon icon="radix-icons:check" />
    </CheckboxIndicator>
  </CheckboxRoot>
  <span>Value: {{ permission }}</span> 
</template>
```

### Indeterminate

You can set the checkbox to `indeterminate` by taking control of its state.

```vue line=5,9-14,16-18
<script setup>
import { Icon } from '@iconify/vue'
import { CheckboxIndicator, CheckboxRoot } from 'reka-ui'

const checked = ref('indeterminate')
</script>

<template>
  <CheckboxRoot v-model="checked">
    <CheckboxIndicator>
      <Icon
        v-if="checked === 'indeterminate'"
        icon="radix-icons:divider-horizontal"
      />
      <Icon
        v-if="checked"
        icon="radix-icons:check"
      />
    </CheckboxIndicator>
  </CheckboxRoot>

  <button
    type="button"
    @click="() => (checked === 'indeterminate' ? (checked = false) : (checked = 'indeterminate'))"
  >
    Toggle indeterminate
  </button>
</template>
```

## Accessibility

Adheres to the tri-state Checkbox WAI-ARIA design pattern.

### Keyboard Interactions
