---
url: /docs/components/pin-input.md
description: A sequence of one-character alphanumeric inputs.
---

# Pin Input

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { PinInputInput, PinInputRoot } from 'reka-ui'
</script>

<template>
  <PinInputRoot>
    <PinInputInput />
  </PinInputRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a pin. An `input` will also render when used within a `form` to ensure events propagate correctly.

### Input

Input field for Pin Input. You can add as many input as you like.

## Examples

### OTP mode

You can set the pin input to `otp` mode by setting otp to `true`.

```vue{6}
<script setup lang="ts">
import { Label, PinInputInput, PinInputRoot } from 'reka-ui'
</script>

<template>
  <PinInputRoot v-model="value" otp>
    …
  </PinInputRoot>
</template>
```

### Numeric mode

You can set the pin input to only accept `number` type by setting type to `number`.

```vue{6}
<script setup lang="ts">
import { Label, PinInputInput, PinInputRoot } from 'reka-ui'
</script>

<template>
  <PinInputRoot v-model="value" type="number">
    …
  </PinInputRoot>
</template>
```

## Accessibility

### Keyboard Interactions
