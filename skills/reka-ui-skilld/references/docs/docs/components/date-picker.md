---
url: /docs/components/date-picker.md
description: >-
  Facilitates the selection of dates through an input and calendar-based
  interface.
---

# Date Picker

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
  DatePickerAnchor,
  DatePickerArrow,
  DatePickerCalendar,
  DatePickerCell,
  DatePickerCellTrigger,
  DatePickerClose,
  DatePickerContent,
  DatePickerField,
  DatePickerGrid,
  DatePickerGridBody,
  DatePickerGridHead,
  DatePickerGridRow,
  DatePickerHeadCell,
  DatePickerHeader,
  DatePickerHeading,
  DatePickerInput,
  DatePickerNext,
  DatePickerPrev,
  DatePickerRoot,
  DatePickerTrigger,
} from 'reka-ui'
</script>

<template>
  <DatePickerRoot>
    <DatePickerField>
      <DatePickerInput />
      <DatePickerTrigger />
    </DatePickerField>

    <DatePickerAnchor />
    <DatePickerContent>
      <DatePickerClose />
      <DatePickerArrow />

      <DatePickerCalendar>
        <DatePickerHeader>
          <DatePickerPrev />
          <DatePickerHeading />
          <DatePickerNext />
        </DatePickerHeader>

        <DatePickerGrid>
          <DatePickerGridHead>
            <DatePickerGridRow>
              <DatePickerHeadCell />
            </DatePickerGridRow>
          </DatePickerGridHead>

          <DatePickerGridBody>
            <DatePickerGridRow>
              <DatePickerCell>
                <DatePickerCellTrigger />
              </DatePickerCell>
            </DatePickerGridRow>
          </DatePickerGridBody>
        </DatePickerGrid>
      </DatePickerCalendar>
    </DatePickerContent>
  </DatePickerRoot>
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

The button that toggles the popover. By default, the `DatePickerContent` will position itself against the trigger.

### Content

The component that pops out when the popover is open.

### Arrow

An optional arrow element to render alongside the popover. This can be used to help visually link the anchor with the `DatePickerContent`. Must be rendered inside `DatePickerContent`.

### Close

The button that closes an open date picker.

### Anchor

An optional element to position the `DatePickerContent` against. If this part is not used, the content will position alongside the `DatePickerTrigger`.

### Calendar

Contains all the parts of a calendar

### Header

Contains the navigation buttons and the heading segments.

### Prev Button

Calendar navigation button. It navigates the calendar one month/year/decade in the past based on the current calendar view.

### Next Button

Calendar navigation button. It navigates the calendar one month/year/decade in the future based on the current calendar view.

### Heading

Heading for displaying the current month and year/

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
