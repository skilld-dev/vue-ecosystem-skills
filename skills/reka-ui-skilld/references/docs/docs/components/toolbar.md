---
url: /docs/components/toolbar.md
description: >-
  A container for grouping a set of controls, such as buttons, toggle groups or
  dropdown menus.
---

# Toolbar

## Features

## Installation

Install the component from your command line.

## Anatomy

Import the component.

```vue
<script setup lang="ts">
import {
  ToolbarButton,
  ToolbarLink,
  ToolbarRoot,
  ToolbarSeparator,
  ToolbarToggleGroup,
  ToolbarToggleItem,
} from 'reka-ui'
</script>

<template>
  <ToolbarRoot>
    <ToolbarButton />
    <ToolbarSeparator />
    <ToolbarLink />
    <ToolbarToggleGroup>
      <ToolbarToggleItem />
    </ToolbarToggleGroup>
  </ToolbarRoot>
</template>
```

## API Reference

### Root

Contains all the toolbar component parts.

### Button

A button item.

### Link

A link item.

### ToggleGroup

A set of two-state buttons that can be toggled on or off.

### ToggleItem

An item in the group.

### Separator

Used to visually separate items in the toolbar

## Examples

### Use with other primitives

All our primitives which expose a `Trigger` part, such as `Dialog`, `AlertDialog`, `Popover`, `DropdownMenu` can be composed within a toolbar by using the [`asChild` prop](/docs/guides/composition).

Here is an example using our `DropdownMenu` primitive.

```vue line=20-22
<script setup lang="ts">
import {
  DropdownMenuContent,
  DropdownMenuRoot,
  DropdownMenuTrigger,
  ToolbarButton,
  ToolbarLink,
  ToolbarRoot,
  ToolbarSeparator,
  ToolbarToggleGroup,
  ToolbarToggleItem,
} from 'reka-ui'
</script>

<template>
  <ToolbarRoot>
    <ToolbarButton>Action 1</ToolbarButton>
    <ToolbarSeparator />
    <DropdownMenuRoot>
      <ToolbarButton as-child>
        <DropdownMenuTrigger>Trigger</DropdownMenuTrigger>
      </ToolbarButton>
      <DropdownMenuContent>…</DropdownMenuContent>
    </DropdownMenuRoot>
  </ToolbarRoot>
</template>
```

## Accessibility

Uses roving tabindex to manage focus movement among items.

### Keyboard Interactions
