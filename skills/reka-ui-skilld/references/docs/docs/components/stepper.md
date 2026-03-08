---
url: /docs/components/stepper.md
description: >-
  A set of steps that are used to indicate progress through a multi-step
  process.
---

# Stepper

Alpha

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { StepperDescription, StepperIndicator, StepperItem, StepperRoot, StepperTitle, StepperTrigger } from 'reka-ui'
</script>

<template>
  <StepperRoot>
    <StepperItem>
      <StepperTrigger />
      <StepperIndicator />

      <StepperTitle />
      <StepperDescription />

      <StepperSeparator />
    </StepperItem>
  </StepperRoot>
</template>
```

## API Reference

### Root

Contains all the stepper component parts.

### Item

The step item component.

### Trigger

The trigger that toggles the step.

### Indicator

The indicator for the step.

### Title

An accessible title to be announced when the stepper trigger is focused.

If you want to hide the title, wrap it inside our Visually Hidden utility like this `<VisuallyHidden asChild>`.

### Description

An optional accessible description to be announced when the stepper trigger is focused.

If you want to hide the description, wrap it inside our Visually Hidden utility like this `<VisuallyHidden asChild>`. If you want to remove the description entirely, remove this part and pass `aria-describedby="undefined"` to `StepperTrigger`.

## Examples

### Vertical

You can create vertical steps by using the `orientation` prop.

```vue line=8
<script setup>
import { StepperDescription, StepperIndicator, StepperItem, StepperRoot, StepperTitle } from 'reka-ui'
</script>

<template>
  <StepperRoot
    :default-value="1"
    orientation="vertical"
  >
    <StepperItem>
      <StepperIndicator />
      <StepperTitle />
      <StepperDescription />
    </StepperItem>
    <StepperItem>
      <StepperIndicator />
      <StepperTitle />
      <StepperDescription />
    </StepperItem>
  </StepperRoot>
</template>
```

### With controls

You can add additional controls for the stepper using buttons and access the typed component instance using `useTemplateRef`.

```vue line=8
<script setup lang="ts">
const stepper = useTemplateRef('stepper')
</script>

<template>
  <StepperRoot
    ref="stepper"
    :default-value="1"
  >
    <StepperItem>
      <StepperIndicator />
      <StepperTitle />
      <StepperDescription />
    </StepperItem>
    <StepperItem>
      <StepperIndicator />
      <StepperTitle />
      <StepperDescription />
    </StepperItem>
  </StepperRoot>

  <div class="flex gap-2 justify-between mt-4">
    <button
      :disabled="!stepper?.hasPrev()"
      @click="stepper?.prevStep()"
    >
      Prev
    </button>

    <button
      :disabled="!stepper?.hasNext()"
      @click="stepper?.nextStep()"
    >
      Next
    </button>
  </div>
</template>
```

## Accessibility

### Keyboard Interactions
