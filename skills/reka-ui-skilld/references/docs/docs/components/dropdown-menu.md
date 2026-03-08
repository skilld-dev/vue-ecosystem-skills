---
url: /docs/components/dropdown-menu.md
description: >-
  Displays a menu to the user—such as a set of actions or functions—triggered by
  a button.
---

# DropdownMenu

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup lang="ts">
import {
  DropdownMenuArrow,
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuItemIndicator,
  DropdownMenuLabel,
  DropdownMenuPortal,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuRoot,
  DropdownMenuSeparator,
  DropdownMenuSub,
  DropdownMenuSubContent,
  DropdownMenuSubTrigger,
  DropdownMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger />

    <DropdownMenuPortal>
      <DropdownMenuContent>
        <DropdownMenuLabel />
        <DropdownMenuItem />

        <DropdownMenuGroup>
          <DropdownMenuItem />
        </DropdownMenuGroup>

        <DropdownMenuCheckboxItem>
          <DropdownMenuItemIndicator />
        </DropdownMenuCheckboxItem>

        <DropdownMenuRadioGroup>
          <DropdownMenuRadioItem>
            <DropdownMenuItemIndicator />
          </DropdownMenuRadioItem>
        </DropdownMenuRadioGroup>

        <DropdownMenuSub>
          <DropdownMenuSubTrigger />
          <DropdownMenuPortal>
            <DropdownMenuSubContent />
          </DropdownMenuPortal>
        </DropdownMenuSub>

        <DropdownMenuSeparator />
        <DropdownMenuArrow />
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a dropdown menu.

### Trigger

The button that toggles the dropdown menu. By default, the `DropdownMenuContent` will position itself against the trigger.

### Portal

When used, portals the content part into the `body`.

### Content

The component that pops out when the dropdown menu is open.

### Arrow

An optional arrow element to render alongside the dropdown menu. This can be used to help visually link the trigger with the `DropdownMenuContent`. Must be rendered inside `DropdownMenuContent`.

### Item

The component that contains the dropdown menu items.

### Group

Used to group multiple `DropdownMenuItem`s.

### Label

Used to render a label. It won't be focusable using arrow keys.

### CheckboxItem

An item that can be controlled and rendered like a checkbox.

### RadioGroup

Used to group multiple `DropdownMenuRadioItem`s.

### RadioItem

An item that can be controlled and rendered like a radio.

### ItemIndicator

Renders when the parent `DropdownMenuCheckboxItem` or `DropdownMenuRadioItem` is checked. You can style this element directly, or you can use it as a wrapper to put an icon into, or both.

### Separator

Used to visually separate items in the dropdown menu.

### Sub

Contains all the parts of a submenu.

### SubTrigger

An item that opens a submenu. Must be rendered inside `DropdownMenuSub`.

### SubContent

The component that pops out when a submenu is open. Must be rendered inside `DropdownMenuSub`.

## Examples

### With submenus

You can create submenus by using `DropdownMenuSub` in combination with its parts.

```vue line=9-11,24-33
<script setup lang="ts">
import {
  DropdownMenuArrow,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuPortal,
  DropdownMenuRoot,
  DropdownMenuSeparator,
  DropdownMenuSub,
  DropdownMenuSubContent,
  DropdownMenuSubTrigger,
  DropdownMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent>
        <DropdownMenuItem>…</DropdownMenuItem>
        <DropdownMenuItem>…</DropdownMenuItem>
        <DropdownMenuSeparator />
        <DropdownMenuSub>
          <DropdownMenuSubTrigger>Sub menu →</DropdownMenuSubTrigger>
          <DropdownMenuPortal>
            <DropdownMenuSubContent>
              <DropdownMenuItem>Sub menu item</DropdownMenuItem>
              <DropdownMenuItem>Sub menu item</DropdownMenuItem>
              <DropdownMenuArrow />
            </DropdownMenuSubContent>
          </DropdownMenuPortal>
        </DropdownMenuSub>
        <DropdownMenuSeparator />
        <DropdownMenuItem>…</DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

### With disabled items

You can add special styles to disabled items via the `data-disabled` attribute.

```vue line=18
<script setup lang="ts">
import {
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuPortal,
  DropdownMenuRoot,
  DropdownMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent>
        <DropdownMenuItem
          class="DropdownMenuItem"
          disabled
        >
          …
        </DropdownMenuItem>
        <DropdownMenuItem class="DropdownMenuItem">
          …
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

```css line=2
/* styles.css */
.DropdownMenuItem[data-disabled] {
  color: gainsboro;
}
```

### With separators

Use the `Separator` part to add a separator between items.

```vue line=7,18,20
<script setup lang="ts">
import {
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuPortal,
  DropdownMenuRoot,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent>
        <DropdownMenuItem>…</DropdownMenuItem>
        <DropdownMenuSeparator />
        <DropdownMenuItem>…</DropdownMenuItem>
        <DropdownMenuSeparator />
        <DropdownMenuItem>…</DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

### With labels

Use the `Label` part to help label a section.

```vue line=5,17
<script setup lang="ts">
import {
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuPortal,
  DropdownMenuRoot,
  DropdownMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent>
        <DropdownMenuLabel>Label</DropdownMenuLabel>
        <DropdownMenuItem>…</DropdownMenuItem>
        <DropdownMenuItem>…</DropdownMenuItem>
        <DropdownMenuItem>…</DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

### With checkbox items

Use the `CheckboxItem` part to add an item that can be checked.

```vue line=5,26-31
<script setup lang="ts">
import { Icon } from '@iconify/vue'
import {
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuItemIndicator,
  DropdownMenuPortal,
  DropdownMenuRoot,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from 'reka-ui'
import { ref } from 'vue'

const checked = ref(false)
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent>
        <DropdownMenuItem>…</DropdownMenuItem>
        <DropdownMenuItem>…</DropdownMenuItem>
        <DropdownMenuSeparator />
        <DropdownMenuCheckboxItem v-model="checked">
          <DropdownMenuItemIndicator>
            <Icon icon="radix-icons:check" />
          </DropdownMenuItemIndicator>
          Checkbox item
        </DropdownMenuCheckboxItem>
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

### With radio items

Use the `RadioGroup` and `RadioItem` parts to add an item that can be checked amongst others.

```vue line=8-9,22-41
<script setup lang="ts">
import { Icon } from '@iconify/vue'
import {
  DropdownMenuContent,
  DropdownMenuItemIndicator,
  DropdownMenuPortal,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuRoot,
  DropdownMenuTrigger,
} from 'reka-ui'
import { ref } from 'vue'

const color = ref(false)
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent>
        <DropdownMenuRadioGroup v-model="color">
          <DropdownMenuRadioItem value="red">
            <DropdownMenuItemIndicator>
              <Icon icon="radix-icons:check" />
            </DropdownMenuItemIndicator>
            Red
          </DropdownMenuRadioItem>
          <DropdownMenuRadioItem value="blue">
            <DropdownMenuItemIndicator>
              <Icon icon="radix-icons:check" />
            </DropdownMenuItemIndicator>
            Blue
          </DropdownMenuRadioItem>
          <DropdownMenuRadioItem value="green">
            <DropdownMenuItemIndicator>
              <Icon icon="radix-icons:check" />
            </DropdownMenuItemIndicator>
            Green
          </DropdownMenuRadioItem>
        </DropdownMenuRadioGroup>
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

### With complex items

You can add extra decorative elements in the `Item` parts, such as images.

```vue line=17,21
<script setup lang="ts">
import {
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuPortal,
  DropdownMenuRoot,
  DropdownMenuTrigger,
} from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent>
        <DropdownMenuItem>
          <img src="…">
          Adolfo Hess
        </DropdownMenuItem>
        <DropdownMenuItem>
          <img src="…">
          Miyah Myles
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

### Constrain the content/sub-content size

You may want to constrain the width of the content (or sub-content) so that it matches the trigger (or sub-trigger) width. You may also want to constrain its height to not exceed the viewport.

We expose several CSS custom properties such as `--reka-dropdown-menu-trigger-width` and `--reka-dropdown-menu-content-available-height` to support this. Use them to constrain the content dimensions.

```vue line=9-12
<script setup lang="ts">
import { DropdownMenuContent, DropdownMenuPortal, DropdownMenuRoot, DropdownMenuTrigger } from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent
        class="DropdownMenuContent"
        :side-offset="5"
      >
        …
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

```css line=3-4
/* styles.css */
.DropdownMenuContent {
  width: var(--reka-dropdown-menu-trigger-width);
  max-height: var(--reka-dropdown-menu-content-available-height);
}
```

### Origin-aware animations

We expose a CSS custom property `--reka-dropdown-menu-content-transform-origin`. Use it to animate the content from its computed origin based on `side`, `sideOffset`, `align`, `alignOffset` and any collisions.

```vue line=9
<script setup lang="ts">
import { DropdownMenuContent, DropdownMenuPortal, DropdownMenuRoot, DropdownMenuTrigger } from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent class="DropdownMenuContent">
        …
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

```css line=3
/* styles.css */
.DropdownMenuContent {
  transform-origin: var(--reka-dropdown-menu-content-transform-origin);
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
import { DropdownMenuContent, DropdownMenuPortal, DropdownMenuRoot, DropdownMenuTrigger } from 'reka-ui'
</script>

<template>
  <DropdownMenuRoot>
    <DropdownMenuTrigger>…</DropdownMenuTrigger>
    <DropdownMenuPortal>
      <DropdownMenuContent class="DropdownMenuContent">
        …
      </DropdownMenuContent>
    </DropdownMenuPortal>
  </DropdownMenuRoot>
</template>
```

```css line=6-11
/* styles.css */
.DropdownMenuContent {
  animation-duration: 0.6s;
  animation-timing-function: cubic-bezier(0.16, 1, 0.3, 1);
}
.DropdownMenuContent[data-side="top"] {
  animation-name: slideUp;
}
.DropdownMenuContent[data-side="bottom"] {
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

## Custom APIs

Create your own API by abstracting the primitive parts into your own component.

### Abstract the arrow and item indicators

This example abstracts the `DropdownMenuArrow` and `DropdownMenuItemIndicator` parts. It also wraps implementation details for `CheckboxItem` and `RadioItem`.

#### Usage

```vue
<script setup lang="ts">
import {
  DropdownMenu,
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from './your-dropdown-menu'
</script>

<template>
  <DropdownMenu>
    <DropdownMenuTrigger>DropdownMenu trigger</DropdownMenuTrigger>
    <DropdownMenuContent>
      <DropdownMenuItem>Item</DropdownMenuItem>
      <DropdownMenuLabel>Label</DropdownMenuLabel>
      <DropdownMenuGroup>Group</DropdownMenuGroup>
      <DropdownMenuCheckboxItem>CheckboxItem</DropdownMenuCheckboxItem>
      <DropdownMenuSeparator>Separator</DropdownMenuSeparator>
      <DropdownMenuRadioGroup>
        <DropdownMenuRadioItem>RadioItem</DropdownMenuRadioItem>
        <DropdownMenuRadioItem>RadioItem</DropdownMenuRadioItem>
      </DropdownMenuRadioGroup>
    </DropdownMenuContent>
  </DropdownMenu>
</template>
```

#### Implementation

```ts
export { default as DropdownMenuCheckboxItem } from 'DropdownMenuCheckboxItem.vue'
// your-dropdown-menu.ts
export { default as DropdownMenuContent } from 'DropdownMenuContent.vue'
export { default as DropdownMenuRadioItem } from 'DropdownMenuRadioItem.vue'

export {
  DropdownMenuRoot as DropdownMenu,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuSeparator,
  DropdownMenuTrigger
} from 'reka-ui'
```

```vue

<script setup lang="ts">
import type { DropdownMenuContentEmits, DropdownMenuContentProps } from 'reka-ui'
import { DropdownMenuContent, DropdownMenuPortal, useForwardPropsEmits } from 'reka-ui'

const props = defineProps<DropdownMenuContentProps>()
const emits = defineEmits<DropdownMenuContentEmits>()

const forwarded = useForwardPropsEmits(props, emits)
</script>

<template>
  <DropdownMenuPortal>
    <DropdownMenuContent v-bind="forwarded">
      <slot />
    </DropdownMenuContent>
  </DropdownMenuPortal>
</template>
```

```vue

<script setup lang="ts">
import type { DropdownMenuCheckboxItemEmits, DropdownMenuCheckboxItemProps } from 'reka-ui'
import { CheckIcon } from '@radix-icons/vue'
import { DropdownMenuCheckboxItem, DropdownMenuItemIndicator, useForwardPropsEmits } from 'reka-ui'

const props = defineProps<DropdownMenuCheckboxItemProps>()
const emits = defineEmits<DropdownMenuCheckboxItemEmits>()

const forwarded = useForwardPropsEmits(props, emits)
</script>

<template>
  <DropdownMenuCheckboxItem v-bind="forwarded">
    <span>
      <DropdownMenuItemIndicator>
        <CheckIcon />
      </DropdownMenuItemIndicator>
    </span>
    <slot />
  </DropdownMenuCheckboxItem>
</template>
```

```vue

<script setup lang="ts">
import type { DropdownMenuRadioItemEmits, DropdownMenuRadioItemProps } from 'reka-ui'
import { DotFilledIcon } from '@radix-icons/vue'
import { DropdownMenuItemIndicator, DropdownMenuRadioItem, useForwardPropsEmits } from 'reka-ui'

const props = defineProps<DropdownMenuRadioItemProps>()
const emits = defineEmits<DropdownMenuRadioItemEmits>()

const forwarded = useForwardPropsEmits(props, emits)
</script>

<template>
  <DropdownMenuRadioItem v-bind="forwarded">
    <span>
      <DropdownMenuItemIndicator>
        <DotFilledIcon />
      </DropdownMenuItemIndicator>
    </span>
    <slot />
  </DropdownMenuRadioItem>
</template>
```
