---
url: /docs/components/year-picker.md
description: Presents a calendar view tailored for selecting years.
---

# Year Picker

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
  YearPickerCell,
  YearPickerCellTrigger,
  YearPickerGrid,
  YearPickerGridBody,
  YearPickerGridRow,
  YearPickerHeader,
  YearPickerHeading,
  YearPickerNext,
  YearPickerPrev,
  YearPickerRoot,
} from 'reka-ui'
</script>

<template>
  <YearPickerRoot>
    <YearPickerHeader>
      <YearPickerPrev />
      <YearPickerHeading />
      <YearPickerNext />
    </YearPickerHeader>
    <YearPickerGrid>
      <YearPickerGridBody>
        <YearPickerGridRow>
          <YearPickerCell>
            <YearPickerCellTrigger />
          </YearPickerCell>
        </YearPickerGridRow>
      </YearPickerGridBody>
    </YearPickerGrid>
  </YearPickerRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a year picker

### Header

Contains the navigation buttons and the heading segments.

### Prev Button

Calendar navigation button. It navigates the calendar one page (default: 12 years) in the past.

### Next Button

Calendar navigation button. It navigates the calendar one page (default: 12 years) in the future.

### Heading

Heading for displaying the current year range (e.g., "2020 - 2031").

### Grid

Container for wrapping the year picker grid.

### Grid Body

Container for wrapping the grid body.

### Grid Row

Container for wrapping the grid row.

### Cell

Container for wrapping the year picker cells.

### Cell Trigger

Interactable container for displaying the cell years. Clicking it selects the year.

## Accessibility

### Keyboard Interactions
