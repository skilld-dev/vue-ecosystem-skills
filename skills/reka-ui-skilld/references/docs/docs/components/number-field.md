---
url: /docs/components/number-field.md
description: >-
  A number field allows a user to enter a number and increment or decrement the
  value using stepper buttons.
---

# Number Field

## Features

## Installation

Install the number package.

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { NumberFieldDecrement, NumberFieldIncrement, NumberFieldInput, NumberFieldRoot } from 'reka-ui'
</script>

<template>
  <NumberFieldRoot>
    <NumberFieldDecrement />
    <NumberFieldInput />
    <NumberFieldIncrement />
  </NumberFieldRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a number field. An `input` will also render when used within a `form` to ensure events propagate correctly.

### Input

Input

The input component that renders the text value based on value and format options.

### Increment

The button that increases the value.

### Decrement

The button that decreases the value.

## Example

### Decimal

All options supported by `Intl.NumberFormat` are supported, including configuration of minimum and maximum fraction digits, sign display, grouping separators, etc.

```vue line=3-7
<template>
  <NumberFieldRoot
    :default-value="5"
    :format-options="{
      signDisplay: 'exceptZero',
      minimumFractionDigits: 1,
    }"
  >
    …
  </NumberFieldRoot>
</template>
```

### Percentage

You can set `formatOptions.style` to `percent` to treat the value as a percentage. You need to set the step to 0.01 manually to allow an appropriate step size in this mode.

```vue line=3-7
<template>
  <NumberFieldRoot
    :default-value="0.05"
    :step="0.01"
    :format-options="{
      style: 'percent',
    }"
  >
    …
  </NumberFieldRoot>
</template>
```

### Currency

You can set `formatOptions.style` to `currency` to treat the value as a currency value. The currency option must also be passed to set the currency code (e.g., USD).

If you need to allow the user to change the currency, you should include a separate dropdown next to the number field. The number field itself will not determine the currency from the user input.

```vue line=4-9
<template>
  <NumberFieldRoot
    :default-value="5"
    :format-options="{
      style: 'currency',
      currency: 'EUR',
      currencyDisplay: 'code',
      currencySign: 'accounting',
    }"
  >
    …
  </NumberFieldRoot>
</template>
```

## Accessibility

Adheres to the Spinbutton WAI-ARIA design pattern.

### Keyboard Interactions
