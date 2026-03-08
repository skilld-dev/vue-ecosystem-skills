---
url: /docs/components/menubar.md
description: >-
  A visually persistent menu common in desktop applications that provides quick
  access to a consistent set of commands.
---

# Menubar

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup lang="ts">
import {
  MenubarArrow,
  MenubarCheckboxItem,
  MenubarContent,
  MenubarItem,
  MenubarItemIndicator,
  MenubarLabel,
  MenubarMenu,
  MenubarPortal,
  MenubarRadioGroup,
  MenubarRadioItem,
  MenubarRoot,
  MenubarSeparator,
  MenubarSub,
  MenubarSubContent,
  MenubarSubTrigger,
  MenubarTrigger,
} from './'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger />
      <MenubarPortal>
        <MenubarContent>
          <MenubarLabel />
          <MenubarItem />

          <MenubarGroup>
            <MenubarItem />
          </MenubarGroup>

          <MenubarCheckboxItem>
            <MenubarItemIndicator />
          </MenubarCheckboxItem>

          <MenubarRadioGroup>
            <MenubarRadioItem>
              <MenubarItemIndicator />
            </MenubarRadioItem>
          </MenubarRadioGroup>

          <MenubarSub>
            <MenubarSubTrigger />
            <MenubarPortal>
              <MenubarSubContent />
            </MenubarPortal>
          </MenubarSub>

          <MenubarSeparator />
          <MenubarArrow />
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a menubar

### Menu

A top level menu item, contains a trigger with content combination.

### Trigger

The button that toggles the content. By default, the `MenubarContent` will position itself against the trigger.

### Portal

When used, portals the content part into the `body`.

### Content

The component that pops out when a menu is open.

### Arrow

An optional arrow element to render alongside a menubar menu. This can be used to help visually link the trigger with the `MenubarContent`. Must be rendered inside `MenubarContent`.

### Item

The component that contains the menubar items.

### Group

Used to group multiple `MenubarItem`s.

### Label

Used to render a label. It won't be focusable using arrow keys.

### CheckboxItem

An item that can be controlled and rendered like a checkbox.

### RadioGroup

Used to group multiple `MenubarRadioItem`s.

### RadioItem

An item that can be controlled and rendered like a radio.

### ItemIndicator

Renders when the parent `MenubarCheckboxItem` or `MenubarRadioItem` is checked. You can style this element directly, or you can use it as a wrapper to put an icon into, or both.

### Separator

Used to visually separate items in a menubar menu.

### Sub

Contains all the parts of a submenu.

### SubTrigger

An item that opens a submenu. Must be rendered inside `MenubarSub`.

### SubContent

The component that pops out when a submenu is open. Must be rendered inside `MenubarSub`.

## Examples

### With submenus

You can create submenus by using `MenubarSub` in combination with its parts.

```vue line=9-11,25-34
<script setup lang="ts">
import {
  MenubarContent,
  MenubarItem,
  MenubarMenu,
  MenubarPortal,
  MenubarRoot,
  MenubarSeparator,
  MenubarSub,
  MenubarSubContent,
  MenubarSubTrigger,
  MenubarTrigger,
} from 'reka-ui'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent>
          <MenubarItem>…</MenubarItem>
          <MenubarItem>…</MenubarItem>
          <MenubarSeparator />
          <MenubarSub>
            <MenubarSubTrigger>Sub menu →</MenubarSubTrigger>
            <MenubarPortal>
              <MenubarSubContent>
                <MenubarItem>Sub menu item</MenubarItem>
                <MenubarItem>Sub menu item</MenubarItem>
                <MenubarArrow />
              </MenubarSubContent>
            </MenubarPortal>
          </MenubarSub>
          <MenubarSeparator />
          <MenubarItem>…</MenubarItem>
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

### With disabled items

You can add special styles to disabled items via the `data-disabled` attribute.

```vue line=13
<script setup lang="ts">
import { MenubarContent, MenubarItem, MenubarMenu, MenubarPortal, MenubarRoot, MenubarTrigger } from 'reka-ui'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent>
          <MenubarItem
            class="MenubarItem"
            disabled
          >
            …
          </MenubarItem>
          <MenubarItem class="MenubarItem">
            …
          </MenubarItem>
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

```css line=2
/* styles.css */
.MenubarItem[data-disabled] {
  color: gainsboro;
}
```

### With separators

Use the `Separator` part to add a separator between items.

```vue line=8,20,22
<script setup lang="ts">
import {
  MenubarContent,
  MenubarItem,
  MenubarMenu,
  MenubarPortal,
  MenubarRoot,
  MenubarSeparator,
  MenubarTrigger,
} from 'reka-ui'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent>
          <MenubarItem>…</MenubarItem>
          <MenubarSeparator />
          <MenubarItem>…</MenubarItem>
          <MenubarSeparator />
          <MenubarItem>…</MenubarItem>
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

### With labels

Use the `Label` part to help label a section.

```vue line=5,19
<script setup lang="ts">
import {
  MenubarContent,
  MenubarItem,
  MenubarLabel,
  MenubarMenu,
  MenubarPortal,
  MenubarRoot,
  MenubarTrigger,
} from 'reka-ui'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent>
          <MenubarLabel>Label</MenubarLabel>
          <MenubarItem>…</MenubarItem>
          <MenubarItem>…</MenubarItem>
          <MenubarItem>…</MenubarItem>
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

### With checkbox items

Use the `CheckboxItem` part to add an item that can be checked.

```vue line=3,27-32
<script setup lang="ts">
import { Icon } from '@iconify/vue'
import {
  MenubarCheckboxItem,
  MenubarContent,
  MenubarItem,
  MenubarItemIndicator,
  MenubarMenu,
  MenubarPortal,
  MenubarRoot,
  MenubarSeparator,
  MenubarTrigger,
} from 'reka-ui'

const checked = ref(true)
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent>
          <MenubarItem>…</MenubarItem>
          <MenubarItem>…</MenubarItem>
          <MenubarSeparator />
          <MenubarCheckboxItem v-model="checked">
            <MenubarItemIndicator>
              <Icon icon="radix-icons:check" />
            </MenubarItemIndicator>
            Checkbox item
          </MenubarCheckboxItem>
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

### With radio items

Use the `RadioGroup` and `RadioItem` parts to add an item that can be checked amongst others.

```vue line=9-10,26-39
<script setup lang="ts">
import { Icon } from '@iconify/vue'
import {
  MenubarCheckboxItem,
  MenubarContent,
  MenubarItem,
  MenubarItemIndicator,
  MenubarMenu,
  MenubarPortal,
  MenubarRadioGroup,
  MenubarRadioItem,
  MenubarRoot,
  MenubarSeparator,
  MenubarTrigger,
} from 'reka-ui'

const color = ref('blue')
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent>
          <MenubarRadioGroup v-model="color">
            <MenubarRadioItem value="red">
              <MenubarItemIndicator>
                <Icon icon="radix-icons:check" />
              </MenubarItemIndicator>
              Red
            </MenubarRadioItem>
            <MenubarRadioItem value="blue">
              <MenubarItemIndicator>
                <Icon icon="radix-icons:check" />
              </MenubarItemIndicator>
              Blue
            </MenubarRadioItem>
          </MenubarRadioGroup>
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

### With complex items

You can add extra decorative elements in the `Item` parts, such as images.

```vue line=12,16
<script setup lang="ts">
import { MenubarContent, MenubarItem, MenubarMenu, MenubarPortal, MenubarRoot, MenubarTrigger } from 'reka-ui'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent>
          <MenubarItem>
            <img src="…">
            Adolfo Hess
          </MenubarItem>
          <MenubarItem>
            <img src="…">
            Miyah Myles
          </MenubarItem>
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

### Constrain the content/sub-content size

You may want to constrain the width of the content (or sub-content) so that it matches the trigger (or sub-trigger) width. You may also want to constrain its height to not exceed the viewport.

We expose several CSS custom properties such as `--reka-menubar-trigger-width` and `--reka-menubar-content-available-height` to support this. Use them to constrain the content dimensions.

```vue line=10-13
<script setup lang="ts">
import { MenubarContent, MenubarItem, MenubarMenu, MenubarPortal, MenubarRoot, MenubarTrigger } from 'reka-ui'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger> Trigger </MenubarTrigger>
      <MenubarPortal>
        <MenubarContent
          class="MenubarContent"
          :side-offset="5"
          :align-offset="-3"
        >
          <MenubarItem> New Tab </MenubarItem>
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

```css line=3-4
/* styles.css */
.MenubarContent {
  width: var(--reka-menubar-trigger-width);
  max-height: var(--reka-menubar-content-available-height);
}
```

### Origin-aware animations

We expose a CSS custom property `--reka-menubar-content-transform-origin`. Use it to animate the content from its computed origin based on `side`, `sideOffset`, `align`, `alignOffset` and any collisions.

```vue line=10
<script setup lang="ts">
import { MenubarContent, MenubarMenu, MenubarPortal, MenubarRoot, MenubarTrigger } from 'reka-ui'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent class="MenubarContent">
          …
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

```css line=3
/* styles.css */
.MenubarContent {
  transform-origin: var(--reka-menubar-content-transform-origin);
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

```vue line=10
<script setup lang="ts">
import { MenubarContent, MenubarMenu, MenubarPortal, MenubarRoot, MenubarTrigger } from 'reka-ui'
</script>

<template>
  <MenubarRoot>
    <MenubarMenu>
      <MenubarTrigger>…</MenubarTrigger>
      <MenubarPortal>
        <MenubarContent class="MenubarContent">
          …
        </MenubarContent>
      </MenubarPortal>
    </MenubarMenu>
  </MenubarRoot>
</template>
```

```css line=6-11
/* styles.css */
.MenubarContent {
  animation-duration: 0.6s;
  animation-timing-function: cubic-bezier(0.16, 1, 0.3, 1);
}
.MenubarContent[data-side="top"] {
  animation-name: slideUp;
}
.MenubarContent[data-side="bottom"] {
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

Adheres to the Menu Button WAI-ARIA design pattern and uses roving tabindex to manage focus movement among menu items.

### Keyboard Interactions
