---
url: /docs/components/progress.md
description: >-
  Displays an indicator showing the completion progress of a task, typically
  displayed as a progress bar.
---

# Progress

## Features

## Installation

Install the component from your command line.

### Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { ProgressIndicator, ProgressRoot } from 'reka-ui'
</script>

<template>
  <ProgressRoot>
    <ProgressIndicator />
  </ProgressRoot>
</template>
```

## Accessibility

Adheres to the `progressbar` role requirements.

## API Reference

### Root

Contains all of the progress parts.

### Indicator

Used to show the progress visually. It also makes progress accessible to assistive technologies.
