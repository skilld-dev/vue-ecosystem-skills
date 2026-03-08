---
url: /docs/components/time-field.md
description: Enables users to input specific times within a designated field.
---

# Time Field

Alpha

## Features

## Preface

The component depends on the @internationalized/date package, which solves a lot of the problems that come with working with dates and times in JavaScript.

We highly recommend reading through the documentation for the package to get a solid feel for how it works, and you'll need to install it in your project to use the date-related components.

## Installation

Install the date package.

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import {
  TimeFieldInput,
  TimeFieldRoot,
} from 'reka-ui'
</script>

<template>
  <TimeFieldRoot>
    <TimeFieldInput />
  </TimeFieldRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a time field

### Input

Contains the time field segments

## Accessibility

### Keyboard Interactions
