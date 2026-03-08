---
url: /docs/components/dialog.md
description: >-
  A window overlaid on either the primary window or another dialog window,
  rendering the content underneath inert.
---

# Dialog

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import {
  DialogClose,
  DialogContent,
  DialogDescription,
  DialogOverlay,
  DialogPortal,
  DialogRoot,
  DialogTitle,
  DialogTrigger,
} from 'reka-ui'
</script>

<template>
  <DialogRoot>
    <DialogTrigger />
    <DialogPortal>
      <DialogOverlay />
      <DialogContent>
        <DialogTitle />
        <DialogDescription />
        <DialogClose />
      </DialogContent>
    </DialogPortal>
  </DialogRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a dialog

### Trigger

The button that opens the dialog

### Portal

When used, portals your overlay and content parts into the `body`.

### Overlay

A layer that covers the inert portion of the view when the dialog is open.

### Content

Contains content to be rendered in the open dialog

### Close

The button that closes the dialog

### Title

An accessible title to be announced when the dialog is opened.

If you want to hide the title, wrap it inside our Visually Hidden utility like this `<VisuallyHidden asChild>`.

### Description

An optional accessible description to be announced when the dialog is opened.

If you want to hide the description, wrap it inside our Visually Hidden utility like this `<VisuallyHidden asChild>`. If you want to remove the description entirely, remove this part and pass `:aria-describedby="undefined"` to `DialogContent`.

## Examples

### Nested dialog

You can nest multiple layers of dialogs.

### Close after asynchronous form submission

Use the controlled props to programmatically close the Dialog after an async operation has completed.

```vue line=4,5,15-19,22-24
<script setup>
import { DialogContent, DialogOverlay, DialogPortal, DialogRoot, DialogTrigger } from 'reka-ui'

const wait = () => new Promise(resolve => setTimeout(resolve, 1000))
const open = ref(false)
</script>

<template>
  <DialogRoot v-model:open="open">
    <DialogTrigger>Open</DialogTrigger>
    <DialogPortal>
      <DialogOverlay />
      <DialogContent>
        <form
          @submit.prevent="
            (event) => {
              wait().then(() => (open = false));
            }
          "
        >
          
          <button type="submit">
            Submit
          </button>
        </form>
      </DialogContent>
    </DialogPortal>
  </DialogRoot>
</template>
```

### Scrollable overlay

Move the content inside the overlay to render a dialog with overflow.

```vue
// index.vue
<script setup>
import { DialogContent, DialogOverlay, DialogPortal, DialogRoot, DialogTrigger } from 'reka-ui'
import './styles.css'
</script>

<template>
  <DialogRoot>
    <DialogTrigger />
    <DialogPortal>
      <DialogOverlay class="DialogOverlay">
        <DialogContent class="DialogContent">
          ...
        </DialogContent>
      </DialogOverlay>
    </DialogPortal>
  </DialogRoot>
</template>
```

```css
/* styles.css */
.DialogOverlay {
  background: rgba(0 0 0 / 0.5);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  display: grid;
  place-items: center;
  overflow-y: auto;
}

.DialogContent {
  min-width: 300px;
  background: white;
  padding: 30px;
  border-radius: 4px;
}
```

However, there's a caveat to this approach, where user might click on the scrollbar and close the dialog unintentionally. There's no universal solution that would fix this issue for now, however you can add the following snippet to `DialogContent` to prevent closing of modal when clicking on scrollbar.

```vue
<DialogContent
  @pointer-down-outside="(event) => {
    const originalEvent = event.detail.originalEvent;
    const target = originalEvent.target as HTMLElement;
    if (originalEvent.offsetX > target.clientWidth || originalEvent.offsetY > target.clientHeight) {
      event.preventDefault();
    }
  }"
>
```

### Custom portal container

Customise the element that your dialog portals into.

```vue line=4,11,17
<script setup>
import { DialogContent, DialogOverlay, DialogPortal, DialogRoot, DialogTrigger } from 'reka-ui'

const container = ref(null)
</script>

<template>
  <div>
    <DialogRoot>
      <DialogTrigger />
      <DialogPortal to="container">
        <DialogOverlay />
        <DialogContent>...</DialogContent>
      </DialogPortal>
    </DialogRoot>

    <div ref="container" />
  </div>
</template>
```

### Disable close on Interaction outside

For example, if you have some global Toaster component that should not close the Dialog when clicking on it.

## Accessibility

Adheres to the Dialog WAI-ARIA design pattern.

### Close icon button

When providing an icon (or font icon), remember to label it correctly for screen reader users.

```vue line=9-11
<template>
  <DialogRoot>
    <DialogTrigger />
    <DialogPortal>
      <DialogOverlay />
      <DialogContent>
        <DialogTitle />
        <DialogDescription />
        <DialogClose aria-label="Close">
          <span aria-hidden="true">×</span>
        </DialogClose>
      </DialogContent>
    </DialogPortal>
  </DialogRoot>
</template>
```

### Close using slot props

Alternatively, you can use the `close` method provided by the `DialogRoot` slot props to programmatically close the dialog.

```vue line=4,8,16-20
<script setup>
import { DialogContent, DialogOverlay, DialogPortal, DialogRoot, DialogTrigger } from 'reka-ui'
</script>

<template>
  <DialogRoot v-slot="{ close }">
    <DialogTrigger>Open</DialogTrigger>
    <DialogPortal>
      <DialogOverlay />
      <DialogContent>
        <form>
          
          <button type="submit" @click="close">
            Submit
          </button>
        </form>
      </DialogContent>
      <DialogFooter>
        <button type="submit" @click="close">
          Submit
        </button>
      </DialogFooter>
    </DialogPortal>
  </DialogRoot>
</template>
```

### Keyboard Interactions

## Custom APIs

Create your own API by abstracting the primitive parts into your own component.

### Abstract the overlay and the close button

This example abstracts the `DialogOverlay` and `DialogClose` parts.

#### Usage

```vue
<script setup>
import { Dialog, DialogContent, DialogTrigger } from './your-dialog'
</script>

<template>
  <Dialog>
    <DialogTrigger>Dialog trigger</DialogTrigger>
    <DialogContent>Dialog Content</DialogContent>
  </Dialog>
</template>
```

#### Implementation

```ts
// your-dialog.ts
export { default as DialogContent } from 'DialogContent.vue'
export { DialogRoot as Dialog, DialogTrigger } from 'reka-ui'
```

```vue

<script setup lang="ts">
import type { DialogContentEmits, DialogContentProps } from 'reka-ui'
import { Cross2Icon } from '@radix-icons/vue'
import { DialogClose, DialogContent, DialogOverlay, DialogPortal, useForwardPropsEmits } from 'reka-ui'

const props = defineProps<DialogContentProps>()
const emits = defineEmits<DialogContentEmits>()

const forwarded = useForwardPropsEmits(props, emits)
</script>

<template>
  <DialogPortal>
    <DialogOverlay />
    <DialogContent v-bind="forwarded">
      <slot />

      <DialogClose>
        <Cross2Icon />
        <span class="sr-only">Close</span>
      </DialogClose>
    </DialogContent>
  </DialogPortal>
</template>
```
