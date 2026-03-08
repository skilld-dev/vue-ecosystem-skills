---
url: /docs/components/collapsible.md
description: An interactive component which expands/collapses a panel.
---

# Collapsible

## Features

## Installation

Install the component from your command line.

## Anatomy

Import the components and piece the parts together.

```vue
<script setup>
import { CollapsibleContent, CollapsibleRoot, CollapsibleTrigger } from 'reka-ui'
</script>

<template>
  <CollapsibleRoot>
    <CollapsibleTrigger />
    <CollapsibleContent />
  </CollapsibleRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a collapsible

### Trigger

The button that toggles the collapsible

### Content

The component that contains the collapsible content.

## Examples

### Animating content size

Use the `--reka-collapsible-content-width` and/or `--reka-collapsible-content-height` CSS variables to animate the size of the content when it opens/closes. Here's a demo:

```vue line=10
// index.vue
<script setup>
import { CollapsibleContent, CollapsibleRoot, CollapsibleTrigger } from 'reka-ui'
import './styles.css'
</script>

<template>
  <CollapsibleRoot>
    <CollapsibleTrigger>…</CollapsibleTrigger>
    <CollapsibleContent class="CollapsibleContent">
      …
    </CollapsibleContent>
  </CollapsibleRoot>
</template>
```

```css line=17,23
/* styles.css */
.CollapsibleContent {
  overflow: hidden;
}
.CollapsibleContent[data-state="open"] {
  animation: slideDown 300ms ease-out;
}
.CollapsibleContent[data-state="closed"] {
  animation: slideUp 300ms ease-out;
}

@keyframes slideDown {
  from {
    height: 0;
  }
  to {
    height: var(--reka-collapsible-content-height);
  }
}

@keyframes slideUp {
  from {
    height: var(--reka-collapsible-content-height);
  }
  to {
    height: 0;
  }
}
```

### Render content even when collapsed

By default hidden content will be removed, use `:unmountOnHide="false"` to keep the content always available.

This will also allow browser to search the hidden text, and open the collapsible.

```vue line=6
<script setup>
import { CollapsibleContent, CollapsibleRoot, CollapsibleTrigger } from 'reka-ui'
</script>

<template>
  <CollapsibleRoot :unmount-on-hide="false">
    …
  </CollapsibleRoot>
</template>
```

## Accessibility

Adheres to the Disclosure WAI-ARIA design pattern.

### Keyboard Interactions
