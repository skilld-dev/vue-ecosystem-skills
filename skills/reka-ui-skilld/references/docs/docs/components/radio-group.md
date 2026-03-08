---
url: /docs/components/radio-group.md
description: >-
  A set of checkable buttons—known as radio buttons—where no more than one of
  the buttons can be checked at a time.
---

# RadioGroup

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { RadioGroupIndicator, RadioGroupItem, RadioGroupRoot } from 'reka-ui'
</script>

<template>
  <RadioGroupRoot>
    <RadioGroupItem>
      <RadioGroupIndicator />
    </RadioGroupItem>
  </RadioGroupRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a radio group.

### Item

An item in the group that can be checked. An `input` will also render when used within a `form` to ensure events propagate correctly.

### Indicator

Renders when the radio item is in a checked state. You can style this element directly, or you can use it as a wrapper to put an icon into, or both.

## Accessibility

Adheres to the Radio Group WAI-ARIA design pattern and uses roving tabindex to manage focus movement among radio items.

### Keyboard Interactions
