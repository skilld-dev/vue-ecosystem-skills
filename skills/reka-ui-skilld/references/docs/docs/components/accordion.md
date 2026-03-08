---
url: /docs/components/accordion.md
description: >-
  A vertically stacked set of interactive headings that each reveal an
  associated section of content.
---

# Accordion

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { AccordionContent, AccordionHeader, AccordionItem, AccordionRoot, AccordionTrigger } from 'reka-ui'
</script>

<template>
  <AccordionRoot>
    <AccordionItem>
      <AccordionHeader>
        <AccordionTrigger />
      </AccordionHeader>
      <AccordionContent />
    </AccordionItem>
  </AccordionRoot>
</template>
```

## API Reference

### Root

Contains all the parts of an Accordion

### Item

Contains all the parts of a collapsible section.

### Header

Wraps an `AccordionTrigger`. Use the `asChild` prop to update it to the appropriate heading level for your page.

### Trigger

Toggles the collapsed state of its associated item. It should be nested inside of an `AccordionHeader`.

### Content

Contains the collapsible content for an item.

## Examples

### Expanded by default

Use the `defaultValue` prop to define the open item by default.

```vue line=4
<template>
  <AccordionRoot
    type="single"
    default-value="item-2"
  >
    <AccordionItem value="item-1">
      …
    </AccordionItem>
    <AccordionItem value="item-2">
      …
    </AccordionItem>
  </AccordionRoot>
</template>
```

### Allow collapsing all items

Use the `collapsible` prop to allow all items to close.

```vue line=4
<template>
  <AccordionRoot
    type="single"
    collapsible
  >
    <AccordionItem value="item-1">
      …
    </AccordionItem>
    <AccordionItem value="item-2">
      …
    </AccordionItem>
  </AccordionRoot>
</template>
```

### Multiple items open at the same time

Set the `type` prop to `multiple` to enable opening multiple items at once.

```vue line=2
<template>
  <AccordionRoot type="multiple">
    <AccordionItem value="item-1">
      …
    </AccordionItem>
    <AccordionItem value="item-2">
      …
    </AccordionItem>
  </AccordionRoot>
</template>
```

### Rotated icon when open

You can add extra decorative elements, such as chevrons, and rotate it when the item is open.

```vue line=16
// index.vue
<script setup>
import { Icon } from '@iconify/vue'
import { AccordionContent, AccordionHeader, AccordionItem, AccordionRoot, AccordionTrigger } from 'reka-ui'
import './styles.css'
</script>

<template>
  <AccordionRoot type="single">
    <AccordionItem value="item-1">
      <AccordionHeader>
        <AccordionTrigger class="AccordionTrigger">
          <span>Trigger text</span>
          <Icon
            icon="radix-icons:chevron-down"
            class="AccordionChevron"
          />
        </AccordionTrigger>
      </AccordionHeader>
      <AccordionContent>…</AccordionContent>
    </AccordionItem>
  </AccordionRoot>
</template>
```

```css line=5-7
/* styles.css */
.AccordionChevron {
  transition: transform 300ms;
}
.AccordionTrigger[data-state="open"] > .AccordionChevron {
  transform: rotate(180deg);
}
```

### Horizontal orientation

Use the `orientation` prop to create a horizontal Accordion

```vue line=2
<template>
  <AccordionRoot orientation="horizontal">
    <AccordionItem value="item-1">
      …
    </AccordionItem>
    <AccordionItem value="item-2">
      …
    </AccordionItem>
  </AccordionRoot>
</template>
```

### Animating content size

Use the `--reka-accordion-content-width` and/or `--reka-accordion-content-height` CSS variables to animate the size of the content when it opens/closes:

```vue line=11
// index.vue
<script setup>
import { AccordionContent, AccordionHeader, AccordionItem, AccordionRoot, AccordionTrigger } from 'reka-ui'
import './styles.css'
</script>

<template>
  <AccordionRoot type="single">
    <AccordionItem value="item-1">
      <AccordionHeader>…</AccordionHeader>
      <AccordionContent class="AccordionContent">
        …
      </AccordionContent>
    </AccordionItem>
  </AccordionRoot>
</template>
```

```css line=17,23
/* styles.css */
.AccordionContent {
  overflow: hidden;
}
.AccordionContent[data-state="open"] {
  animation: slideDown 300ms ease-out;
}
.AccordionContent[data-state="closed"] {
  animation: slideUp 300ms ease-out;
}

@keyframes slideDown {
  from {
    height: 0;
  }
  to {
    height: var(--reka-accordion-content-height);
  }
}

@keyframes slideUp {
  from {
    height: var(--reka-accordion-content-height);
  }
  to {
    height: 0;
  }
}
```

### Render content even when closed

By default hidden content will be removed, use `:unmountOnHide="false"` to keep the content always available.

This will also allow browser to search the hidden text, and open the accordion.

```vue line=2
<template>
  <AccordionRoot :unmount-on-hide="false">
    <AccordionItem value="item-1">
      …
    </AccordionItem>
    <AccordionItem value="item-2">
      …
    </AccordionItem>
  </AccordionRoot>
</template>
```

## Accessibility

Adheres to the Accordion WAI-ARIA design pattern.

### Keyboard Interactions
