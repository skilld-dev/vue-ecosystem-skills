---
url: /docs/components/month-picker.md
description: Presents a calendar view tailored for selecting months.
---

# Month Picker

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
  MonthPickerCell,
  MonthPickerCellTrigger,
  MonthPickerGrid,
  MonthPickerGridBody,
  MonthPickerGridRow,
  MonthPickerHeader,
  MonthPickerHeading,
  MonthPickerNext,
  MonthPickerPrev,
  MonthPickerRoot,
} from 'reka-ui'
</script>

<template>
  <MonthPickerRoot>
    <MonthPickerHeader>
      <MonthPickerPrev />
      <MonthPickerHeading />
      <MonthPickerNext />
    </MonthPickerHeader>
    <MonthPickerGrid>
      <MonthPickerGridBody>
        <MonthPickerGridRow>
          <MonthPickerCell>
            <MonthPickerCellTrigger />
          </MonthPickerCell>
        </MonthPickerGridRow>
      </MonthPickerGridBody>
    </MonthPickerGrid>
  </MonthPickerRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a month picker

### Header

Contains the navigation buttons and the heading segments.

### Prev Button

Calendar navigation button. It navigates the calendar one year in the past.

### Next Button

Calendar navigation button. It navigates the calendar one year in the future.

### Heading

Heading for displaying the current year.

### Grid

Container for wrapping the month picker grid.

### Grid Body

Container for wrapping the grid body.

### Grid Row

Container for wrapping the grid row.

### Cell

Container for wrapping the month picker cells.

### Cell Trigger

Interactable container for displaying the cell months. Clicking it selects the month.

## Accessibility

### Keyboard Interactions
