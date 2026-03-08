---
url: /docs/components/color-swatch-picker.md
description: >-
  A component that allows users to select from a set of predefined colors, often
  used for themes or branding.
---

# Color Swatch Picker

Alpha

## Features

## Installation

Install the component from your command line.

Looking for a complete color picker? Check out the [Color Picker example](/examples/color-picker) that combines Color Area, Color Slider, Color Field, and Color Swatch components.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import {
  ColorSwatchPickerItem,
  ColorSwatchPickerItemIndicator,
  ColorSwatchPickerItemSwatch,
  ColorSwatchPickerRoot,
} from 'reka-ui'
</script>

<template>
  <ColorSwatchPickerRoot>
    <ColorSwatchPickerItem value="#ff0000">
      <ColorSwatchPickerItemSwatch />
      <ColorSwatchPickerItemIndicator />
    </ColorSwatchPickerItem>
    <ColorSwatchPickerItem value="#00ff00">
      <ColorSwatchPickerItemSwatch />
      <ColorSwatchPickerItemIndicator />
    </ColorSwatchPickerItem>
    <ColorSwatchPickerItem value="#0000ff">
      <ColorSwatchPickerItemSwatch />
      <ColorSwatchPickerItemIndicator />
    </ColorSwatchPickerItem>
  </ColorSwatchPickerRoot>
</template>
```

## API Reference

### ColorSwatchPickerRoot

The main component that displays a color swatch picker.

### ColorSwatchPickerItem

The item that represents a selectable color swatch.

### ColorSwatchPickerItemSwatch

The component that displays the color swatch within an item.

### ColorSwatchPickerItemIndicator

The component that indicates the selected color swatch within an item.
