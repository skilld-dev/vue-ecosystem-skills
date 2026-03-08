---
url: /docs/components/hover-card.md
description: For sighted users to preview content available behind a link.
---

# HoverCard

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { HoverCardArrow, HoverCardContent, HoverCardPortal, HoverCardRoot, HoverCardTrigger } from 'reka-ui'
</script>

<template>
  <HoverCardRoot>
    <HoverCardTrigger />
    <HoverCardPortal>
      <HoverCardContent>
        <HoverCardArrow />
      </HoverCardContent>
    </HoverCardPortal>
  </HoverCardRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a hover card.

### Trigger

The link that opens the hover card when hovered.

### Portal

When used, portals the content part into the `body`.

### Content

The component that pops out when the hover card is open.

### Arrow

An optional arrow element to render alongside the hover card. This can be used to help visually link the trigger with the `HoverCardContent`. Must be rendered inside `HoverCardContent`.

## Examples

### Show instantly

Use the `openDelay` prop to control the time it takes for the hover card to open.

```vue line=12
<script setup>
import {
  HoverCardArrow,
  HoverCardContent,
  HoverCardPortal,
  HoverCardRoot,
  HoverCardTrigger,
} from 'reka-ui'
</script>

<template>
  <HoverCardRoot :open-delay="0">
    <HoverCardTrigger>…</HoverCardTrigger>
    <HoverCardContent>…</HoverCardContent>
  </HoverCardRoot>
</template>
```

### Constrain the content size

You may want to constrain the width of the content so that it matches the trigger width. You may also want to constrain its height to not exceed the viewport.

We expose several CSS custom properties such as `--reka-hover-card-trigger-width` and `--reka-hover-card-content-available-height` to support this. Use them to constrain the content dimensions.

```vue line=11
// index.vue
<script setup>
import { HoverCardArrow, HoverCardContent, HoverCardPortal, HoverCardRoot, HoverCardTrigger } from 'reka-ui'
</script>

<template>
  <HoverCardRoot>
    <HoverCardTrigger>…</HoverCardTrigger>
    <HoverCardPortal>
      <HoverCardContent
        class="HoverCardContent"
        :side-offset="5"
      >
        …
      </HoverCardContent>
    </HoverCardPortal>
  </HoverCardRoot>
</template>
```

```css line=3-4
/* styles.css */
.HoverCardContent {
  width: var(--reka-hover-card-trigger-width);
  max-height: var(--reka-hover-card-content-available-height);
}
```

### Origin-aware animations

We expose a CSS custom property `--reka-hover-card-content-transform-origin`. Use it to animate the content from its computed origin based on `side`, `sideOffset`, `align`, `alignOffset` and any collisions.

```vue line=8
<script setup>
import { HoverCardArrow, HoverCardContent, HoverCardPortal, HoverCardRoot, HoverCardTrigger } from 'reka-ui'
</script>

<template>
  <HoverCardRoot>
    <HoverCardTrigger>…</HoverCardTrigger>
    <HoverCardContent class="HoverCardContent">
      …
    </HoverCardContent>
  </HoverCardRoot>
</template>
```

```css line=3
/* styles.css */
.HoverCardContent {
  transform-origin: var(--reka-hover-card-content-transform-origin);
  animation: scaleIn 0.5s ease-out;
}

@keyframes scaleIn {
  from {
    opacity: 0;
    transform: scale(0);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
```

### Collision-aware animations

We expose `data-side` and `data-align` attributes. Their values will change at runtime to reflect collisions. Use them to create collision and direction-aware animations.

```vue line=8
<script setup>
import { HoverCardArrow, HoverCardContent, HoverCardPortal, HoverCardRoot, HoverCardTrigger } from 'reka-ui'
</script>

<template>
  <HoverCardRoot>
    <HoverCardTrigger>…</HoverCardTrigger>
    <HoverCardContent class="HoverCardContent">
      …
    </HoverCardContent>
  </HoverCardRoot>
</template>
```

```css line=6-11
/* styles.css */
.HoverCardContent {
  animation-duration: 0.6s;
  animation-timing-function: cubic-bezier(0.16, 1, 0.3, 1);
}
.HoverCardContent[data-side="top"] {
  animation-name: slideUp;
}
.HoverCardContent[data-side="bottom"] {
  animation-name: slideDown;
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes slideDown {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
```

## Accessibility

The hover card is intended for sighted users only, the content will be inaccessible to keyboard users.

### Keyboard Interactions
