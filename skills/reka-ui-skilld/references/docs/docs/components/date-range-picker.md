---
url: /docs/components/date-range-picker.md
description: >-
  Facilitates the selection of date ranges through an input and calendar-based
  interface.
---

# Date Range Picker

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
  DateRangePickerAnchor,
  DateRangePickerArrow,
  DateRangePickerCalendar,
  DateRangePickerCell,
  DateRangePickerCellTrigger,
  DateRangePickerClose,
  DateRangePickerContent,
  DateRangePickerField,
  DateRangePickerGrid,
  DateRangePickerGridBody,
  DateRangePickerGridHead,
  DateRangePickerGridRow,
  DateRangePickerHeadCell,
  DateRangePickerHeader,
  DateRangePickerHeading,
  DateRangePickerInput,
  DateRangePickerNext,
  DateRangePickerPrev,
  DateRangePickerRoot,
  DateRangePickerTrigger,
} from 'reka-ui'
</script>

<template>
  <DateRangePickerRoot>
    <DateRangePickerField>
      <DateRangePickerInput />
      <DateRangePickerTrigger />
    </DateRangePickerField>

    <DateRangePickerAnchor />

    <DateRangePickerContent>
      <DateRangePickerClose />
      <DateRangePickerArrow />

      <DateRangePickerCalendar>
        <DateRangePickerHeader>
          <DateRangePickerPrev />
          <DateRangePickerHeading />
          <DateRangePickerNext />
        </DateRangePickerHeader>

        <DateRangePickerGrid>
          <DateRangePickerGridHead>
            <DateRangePickerGridRow>
              <DateRangePickerHeadCell />
            </DateRangePickerGridRow>
          </DateRangePickerGridHead>

          <DateRangePickerGridBody>
            <DateRangePickerGridRow>
              <DateRangePickerCell>
                <DateRangePickerCellTrigger />
              </DateRangePickerCell>
            </DateRangePickerGridRow>
          </DateRangePickerGridBody>
        </DateRangePickerGrid>
      </DateRangePickerCalendar>
    </DateRangePickerContent>
  </DateRangePickerRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a date picker

### Field

Contains the date picker date field segments and trigger

### Input

Contains the date picker date field segments

### Trigger

The button that toggles the popover. By default, the `DateRangePickerContent` will position itself against the trigger.

### Content

The component that pops out when the popover is open.

### Arrow

An optional arrow element to render alongside the popover. This can be used to help visually link the anchor with the `DateRangePickerContent`. Must be rendered inside `DateRangePickerContent`.

### Close

The button that closes an open date picker.

### Anchor

An optional element to position the `DateRangePickerContent` against. If this part is not used, the content will position alongside the `DateRangePickerTrigger`.

### Calendar

Contains all the parts of a calendar

### Header

Contains the navigation buttons and the heading segments.

### Prev Button

Calendar navigation button. It navigates the calendar one month/year/decade in the past based on the current calendar view.

### Next Button

Calendar navigation button. It navigates the calendar one month/year/decade in the future based on the current calendar view.

### Heading

Heading for displaying the current month and year

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
