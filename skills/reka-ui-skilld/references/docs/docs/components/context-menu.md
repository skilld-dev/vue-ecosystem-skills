---
url: /docs/components/context-menu.md
description: >-
  Displays a menu located at the pointer, triggered by a right-click or a
  long-press.
---

# Context Menu

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup lang="ts">
import {
  ContextMenuCheckboxItem,
  ContextMenuContent,
  ContextMenuGroup,
  ContextMenuItem,
  ContextMenuItemIndicator,
  ContextMenuLabel,
  ContextMenuPortal,
  ContextMenuRadioGroup,
  ContextMenuRadioItem,
  ContextMenuRoot,
  ContextMenuSeparator,
  ContextMenuSub,
  ContextMenuSubContent,
  ContextMenuSubTrigger,
  ContextMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger />

    <ContextMenuPortal>
      <ContextMenuContent>
        <ContextMenuLabel />
        <ContextMenuItem />

        <ContextMenuGroup>
          <ContextMenuItem />
        </ContextMenuGroup>

        <ContextMenuCheckboxItem>
          <ContextMenuItemIndicator />
        </ContextMenuCheckboxItem>

        <ContextMenuRadioGroup>
          <ContextMenuRadioItem>
            <ContextMenuItemIndicator />
          </ContextMenuRadioItem>
        </ContextMenuRadioGroup>

        <ContextMenuSub>
          <ContextMenuSubTrigger />
          <ContextMenuPortal>
            <ContextMenuSubContent />
          </ContextMenuPortal>
        </ContextMenuSub>

        <ContextMenuSeparator />
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

## API Reference

Adheres to the Menu WAI-ARIA design pattern and uses roving tabindex to manage focus movement among menu items.

### Root

Contains all the parts of a context menu.

### Trigger

The area that opens the context menu. Wrap it around the target you want the context menu to open from when right-clicking (or using the relevant keyboard shortcuts).

### Portal

When used, portals the content part into the `body`.

### Content

The component that pops out in an open context menu.

### Arrow

An optional arrow element to render alongside a submenu. This can be used to help visually link the trigger item with the `ContextMenu.Content`. Must be rendered inside `ContextMenu.Content`.

### Item

The component that contains the context menu items.

### Group

Used to group multiple `ContextMenu.Item`s.

### Label

Used to render a label. It won't be focusable using arrow keys.

### CheckboxItem

An item that can be controlled and rendered like a checkbox.

### RadioGroup

Used to group multiple `ContextMenu.RadioItem`s.

### RadioItem

An item that can be controlled and rendered like a radio.

### ItemIndicator

Renders when the parent `ContextMenu.CheckboxItem` or `ContextMenu.RadioItem` is checked. You can style this element directly, or you can use it as a wrapper to put an icon into, or both.

### Separator

Used to visually separate items in the context menu.

### Sub

Contains all the parts of a submenu.

### SubTrigger

An item that opens a submenu. Must be rendered inside `ContextMenu.Sub`.

### SubContent

The component that pops out when a submenu is open. Must be rendered inside `ContextMenu.Sub`.

## Examples

### With submenus

You can create submenus by using `ContextMenuSub` in combination with its parts.

```vue line=24-33
<script setup lang="ts">
import {
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuLabel,
  ContextMenuPortal,
  ContextMenuRoot,
  ContextMenuSeparator,
  ContextMenuSub,
  ContextMenuSubContent,
  ContextMenuSubTrigger,
  ContextMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent>
        <ContextMenuItem>…</ContextMenuItem>
        <ContextMenuItem>…</ContextMenuItem>
        <ContextMenuSeparator />
        <ContextMenuSub>
          <ContextMenuSubTrigger>Sub menu →</ContextMenuSubTrigger>
          <ContextMenuPortal>
            <ContextMenuSubContent>
              <ContextMenuItem>Sub menu item</ContextMenuItem>
              <ContextMenuItem>Sub menu item</ContextMenuItem>
              <ContextMenuArrow />
            </ContextMenuSubContent>
          </ContextMenuPortal>
        </ContextMenuSub>
        <ContextMenuSeparator />
        <ContextMenuItem>…</ContextMenuItem>
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

### With disabled items

You can add special styles to disabled items via the `data-disabled` attribute.

```vue line=12
<script setup lang="ts">
import { ContextMenuContent, ContextMenuItem, ContextMenuPortal, ContextMenuRoot, ContextMenuTrigger } from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent>
        <ContextMenuItem
          class="ContextMenuItem"
          disabled
        >
          …
        </ContextMenuItem>
        <ContextMenuItem class="ContextMenuItem">
          …
        </ContextMenuItem>
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

```css line=2
/* styles.css */
.ContextMenuItem[data-disabled] {
  color: gainsboro;
}
```

### With separators

Use the `Separator` part to add a separator between items.

```vue line=7,18,20
<script setup lang="ts">
import {
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuPortal,
  ContextMenuRoot,
  ContextMenuSeparator,
  ContextMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent>
        <ContextMenuItem>…</ContextMenuItem>
        <ContextMenuSeparator />
        <ContextMenuItem>…</ContextMenuItem>
        <ContextMenuSeparator />
        <ContextMenuItem>…</ContextMenuItem>
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

### With labels

Use the `Label` part to help label a section.

```vue line=5,17
<script setup lang="ts">
import {
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuLabel,
  ContextMenuPortal,
  ContextMenuRoot,
  ContextMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent>
        <ContextMenuLabel>Label</ContextMenuLabel>
        <ContextMenuItem>…</ContextMenuItem>
        <ContextMenuItem>…</ContextMenuItem>
        <ContextMenuItem>…</ContextMenuItem>
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

### With checkbox items

Use the `CheckboxItem` part to add an item that can be checked.

```vue line=3,25-30
<script setup lang="ts">
import { Icon } from '@iconify/vue'
import {
  ContextMenuCheckboxItem,
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuItemIndicator,
  ContextMenuPortal,
  ContextMenuRoot,
  ContextMenuSeparator,
  ContextMenuTrigger,
} from 'reka-ui'

const checked = ref(true)
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent>
        <ContextMenuItem>…</ContextMenuItem>
        <ContextMenuItem>…</ContextMenuItem>
        <ContextMenuSeparator />
        <ContextMenuCheckboxItem v-model="checked">
          <ContextMenuItemIndicator>
            <Icon icon="radix-icons:check" />
          </ContextMenuItemIndicator>
          Checkbox item
        </ContextMenuCheckboxItem>
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

### With radio items

Use the `RadioGroup` and `RadioItem` parts to add an item that can be checked amongst others.

```vue line=8,9,24-43
<script setup lang="ts">
import { Icon } from '@iconify/vue'
import {
  ContextMenuCheckboxItem,
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuItemIndicator,
  ContextMenuPortal,
  ContextMenuRadioGroup,
  ContextMenuRadioItem,
  ContextMenuRoot,
  ContextMenuSeparator,
  ContextMenuTrigger,
} from 'reka-ui'

const color = ref('blue')
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent>
        <ContextMenuRadioGroup v-model="color">
          <ContextMenuRadioItem value="red">
            <ContextMenuItemIndicator>
              <Icon icon="radix-icons:check" />
            </ContextMenuItemIndicator>
            Red
          </ContextMenuRadioItem>
          <ContextMenuRadioItem value="blue">
            <ContextMenuItemIndicator>
              <Icon icon="radix-icons:check" />
            </ContextMenuItemIndicator>
            Blue
          </ContextMenuRadioItem>
          <ContextMenuRadioItem value="green">
            <ContextMenuItemIndicator>
              <Icon icon="radix-icons:check" />
            </ContextMenuItemIndicator>
            Green
          </ContextMenuRadioItem>
        </ContextMenuRadioGroup>
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

### With complex items

You can add extra decorative elements in the `Item` parts, such as images.

```vue line=11,15
<script setup lang="ts">
import { ContextMenuContent, ContextMenuItem, ContextMenuPortal, ContextMenuRoot, ContextMenuTrigger } from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent>
        <ContextMenuItem>
          <img src="…">
          Adolfo Hess
        </ContextMenuItem>
        <ContextMenuItem>
          <img src="…">
          Miyah Myles
        </ContextMenuItem>
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

### Constrain the content/sub-content size

You may want to constrain the width of the content (or sub-content) so that it matches the trigger (or sub-trigger) width. You may also want to constrain its height to not exceed the viewport.

We expose several CSS custom properties such as `--reka-context-menu-trigger-width` and `--reka-context-menu-content-available-height` to support this. Use them to constrain the content dimensions.

```vue line=9
<script setup lang="ts">
import { ContextMenuContent, ContextMenuItem, ContextMenuPortal, ContextMenuRoot, ContextMenuTrigger } from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent class="ContextMenuContent">
        …
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

```css line=3-4
/* styles.css */
.ContextMenuContent {
  width: var(--reka-context-menu-trigger-width);
  max-height: var(--reka-context-menu-content-available-height);
}
```

### Origin-aware animations

We expose a CSS custom property `--reka-context-menu-content-transform-origin`. Use it to animate the content from its computed origin based on `side`, `sideOffset`, `align`, `alignOffset` and any collisions.

```vue line=9
<script setup lang="ts">
import { ContextMenuContent, ContextMenuPortal, ContextMenuRoot, ContextMenuTrigger } from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent class="ContextMenuContent">
        …
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

```css line=3
/* styles.css */
.ContextMenuContent {
  transform-origin: var(--reka-context-menu-content-transform-origin);
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

```vue line=9
<script setup lang="ts">
import { ContextMenuContent, ContextMenuPortal, ContextMenuRoot, ContextMenuTrigger } from 'reka-ui'
</script>

<template>
  <ContextMenuRoot>
    <ContextMenuTrigger>…</ContextMenuTrigger>
    <ContextMenuPortal>
      <ContextMenuContent class="ContextMenuContent">
        …
      </ContextMenuContent>
    </ContextMenuPortal>
  </ContextMenuRoot>
</template>
```

```css line=6-11
/* styles.css */
.ContextMenuContent {
  animation-duration: 0.6s;
  animation-timing-function: cubic-bezier(0.16, 1, 0.3, 1);
}
.ContextMenuContent[data-side="top"] {
  animation-name: slideUp;
}
.ContextMenuContent[data-side="bottom"] {
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

Uses roving tabindex to manage focus movement among menu items.

### Keyboard Interactions
