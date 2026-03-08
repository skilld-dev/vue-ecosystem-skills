---
url: /docs/components/tabs.md
description: >-
  A set of layered sections of content—known as tab panels—that are displayed
  one at a time.
---

# Tabs

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { TabsContent, TabsIndicator, TabsList, TabsRoot, TabsTrigger } from 'reka-ui'
</script>

<template>
  <TabsRoot>
    <TabsList>
      <TabsIndicator />
      <TabsTrigger />
    </TabsList>
    <TabsContent />
  </TabsRoot>
</template>
```

## API Reference

### Root

Contains all the tabs component parts.

### List

Contains the triggers that are aligned along the edge of the active content.

### Trigger

The button that activates its associated content.

### Indicator

The indicator that highlights the current active tab.

### Content

Contains the content associated with each trigger.

## Examples

### Vertical

You can create vertical tabs by using the `orientation` prop.

```vue line=8
<script setup>
import { TabsContent, TabsList, TabsRoot, TabsTrigger } from 'reka-ui'
</script>

<template>
  <TabsRoot
    default-value="tab1"
    orientation="vertical"
  >
    <TabsList aria-label="tabs example">
      <TabsTrigger value="tab1">
        One
      </TabsTrigger>
      <TabsTrigger value="tab2">
        Two
      </TabsTrigger>
      <TabsTrigger value="tab3">
        Three
      </TabsTrigger>
    </TabsList>
    <TabsContent value="tab1">
      Tab one content
    </TabsContent>
    <TabsContent value="tab2">
      Tab two content
    </TabsContent>
    <TabsContent value="tab3">
      Tab three content
    </TabsContent>
  </TabsRoot>
</template>
```

## Accessibility

Adheres to the Tabs WAI-ARIA design pattern.

### Keyboard Interactions
