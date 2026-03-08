---
url: /docs/components/editable.md
description: >-
  Displays an input field used for editing a single line of text, rendering as
  static text on load.
---

# Editable

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import {
  EditableArea,
  EditableCancelTrigger,
  EditableEditTrigger,
  EditableInput,
  EditablePreview,
  EditableRoot,
  EditableSubmitTrigger
} from 'reka-ui'
</script>

<template>
  <EditableRoot>
    <EditableArea>
      <EditablePreview />
      <EditableInput />
    </EditableArea>
    <EditableEditTrigger />
    <EditableSubmitTrigger />
    <EditableCancelTrigger />
  </EditableRoot>
</template>
```

## API Reference

### Root

Contains all the parts of an editable component.

### Area

Contains the text parts of an editable component.

### Input

Contains the input of an editable component.

### Preview

Contains the preview of the editable component.

### Edit Trigger

Contains the edit trigger of the editable component.

### Submit Trigger

Contains the submit trigger of the editable component.

### Cancel Trigger

Contains the cancel trigger of the editable component.

## Examples

### Change only on submit

By default the component will submit when `blur` event triggers. We can modify the `submit-mode` prop to alter this behavior.
In this case, we want to submit only when user click on `EditableSubmitTrigger`, so we change the submit mode to `none`.

```vue line=2,8
<template>
  <EditableRoot submit-mode="none">
    <EditableArea>
      <EditablePreview />
      <EditableInput />
    </EditableArea>
    <EditableEditTrigger />
    <EditableSubmitTrigger />
    <EditableCancelTrigger />
  </EditableRoot>
</template>
```

## Accessibility

### Keyboard Interactions
