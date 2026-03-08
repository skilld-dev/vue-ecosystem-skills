---
url: /docs/components/alert-dialog.md
description: >-
  A modal dialog that interrupts the user with important content and expects a
  response.
---

# Alert Dialog

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup lang="ts">
import {
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogOverlay,
  AlertDialogPortal,
  AlertDialogRoot,
  AlertDialogTitle,
  AlertDialogTrigger,
} from 'reka-ui'
</script>

<template>
  <AlertDialogRoot>
    <AlertDialogTrigger />
    <AlertDialogPortal>
      <AlertDialogOverlay />
      <AlertDialogContent>
        <AlertDialogTitle />
        <AlertDialogDescription />
        <AlertDialogCancel />
        <AlertDialogAction />
      </AlertDialogContent>
    </AlertDialogPortal>
  </AlertDialogRoot>
</template>
```

## API Reference

### Root

Contains all the parts of an alert dialog.

### Trigger

A button that opens the dialog.

### Portal

When used, portals your overlay and content parts into the body.

### Overlay

A layer that covers the inert portion of the view when the dialog is open.

### Content

Contains content to be rendered when the dialog is open.

### Cancel

A button that closes the dialog. This button should be distinguished visually from `AlertDialogAction` buttons.

### Action

A button that closes the dialog. These buttons should be distinguished visually from the `AlertDialogCancel` button.

### Title

An accessible name to be announced when the dialog is opened. Alternatively, you can provide `aria-label` or `aria-labelledby` to `AlertDialogContent` and exclude this component.

### Description

An accessible description to be announced when the dialog is opened. Alternatively, you can provide `aria-describedby` to `AlertDialogContent` and exclude this component.

## Examples

### Close after asynchronous form submission

Use the controlled props to programmatically close the Alert Dialog after an async operation has completed.

```vue line=14,15,19,25-29
<script setup>
import {
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogOverlay,
  AlertDialogPortal,
  AlertDialogRoot,
  AlertDialogTitle,
  AlertDialogTrigger,
} from 'reka-ui'

const wait = () => new Promise(resolve => setTimeout(resolve, 1000))
const open = ref(false)
</script>

<template>
  <AlertDialogRoot v-model:open="open">
    <AlertDialogTrigger>Open</AlertDialogTrigger>
    <AlertDialogPortal>
      <AlertDialogOverlay />
      <AlertDialogContent>
        <form
          @submit.prevent="
            (event) => {
              wait().then(() => open = false);
            }
          "
        >
          
          <button type="submit">
            Submit
          </button>
        </form>
      </AlertDialogContent>
    </AlertDialogPortal>
  </AlertDialogRoot>
</template>
```

### Custom portal container

Customise the element that your alert dialog portals into.

```vue line=4,17
<script setup>
import { ref } from 'vue'

const container = ref(null)
</script>

<template>
  <div>
    <AlertDialogRoot>
      <AlertDialogTrigger />
      <AlertDialogPortal :to="container">
        <AlertDialogOverlay />
        <AlertDialogContent>...</AlertDialogContent>
      </AlertDialogPortal>
    </AlertDialogRoot>

    <div ref="container" />
  </div>
</template>
```

## Accessibility

Adheres to the Alert and Message Dialogs WAI-ARIA design pattern.

### Keyboard Interactions
