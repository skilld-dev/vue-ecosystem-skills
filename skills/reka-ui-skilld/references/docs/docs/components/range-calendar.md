---
url: /docs/components/range-calendar.md
description: Presents a calendar view tailored for selecting date ranges.
---

# Range Calendar

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
  RangeCalendarCell,
  RangeCalendarCellTrigger,
  RangeCalendarGrid,
  RangeCalendarGridBody,
  RangeCalendarGridHead,
  RangeCalendarGridRow,
  RangeCalendarHeadCell,
  RangeCalendarHeader,
  RangeCalendarHeading,
  RangeCalendarNext,
  RangeCalendarPrev,
  RangeCalendarRoot,
} from 'reka-ui'
</script>

<template>
  <RangeCalendarRoot>
    <RangeCalendarHeader>
      <RangeCalendarPrev />
      <RangeCalendarHeading />
      <RangeCalendarNext />
    </RangeCalendarHeader>
    <RangeCalendarGrid>
      <RangeCalendarGridHead>
        <RangeCalendarGridRow>
          <RangeCalendarHeadCell />
        </RangeCalendarGridRow>
      </RangeCalendarGridHead>
      <RangeCalendarGridBody>
        <RangeCalendarGridRow>
          <RangeCalendarCell>
            <RangeCalendarCellTrigger />
          </RangeCalendarCell>
        </RangeCalendarGridRow>
      </RangeCalendarGridBody>
    </RangeCalendarGrid>
  </RangeCalendarRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a calendar

### Header

Contains the navigation buttons and the heading segments.

### Prev Button

Calendar navigation button. It navigates the calendar one month/year/decade in the past based on the current calendar view.

### Next Button

Calendar navigation button. It navigates the calendar one month/year/decade in the future based on the current calendar view.

### Heading

Heading for displaying the current month and year.

### Grid

Container for wrapping the calendar grid.

### Grid Head

Container for wrapping the grid head.

### Grid Body

Container for wrapping the grid body.

### Grid Row

Container for wrapping the grid row.

### Head Cell

Container for wrapping the head cell. Used for displaying the week days.

### Cell

Container for wrapping the calendar cells.

### Cell Trigger

Interactable container for displaying the cell dates. Clicking it selects the date.

## Accessibility

### Keyboard Interactions
