---
url: /docs/components/date-range-field.md
description: Allows users to input a range of dates within a designated field.
---

# Date Range Field

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
  DateRangeFieldInput,
  DateRangeFieldRoot,
} from 'reka-ui'
</script>

<template>
  <DateRangeFieldRoot>
    <DateRangeFieldInput />
  </DateRangeFieldRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a date field

### Input

Contains the date field segments

## Accessibility

### Keyboard Interactions
