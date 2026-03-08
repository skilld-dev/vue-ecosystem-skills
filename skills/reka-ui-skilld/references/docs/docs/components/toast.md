---
url: /docs/components/toast.md
description: A succinct message that is displayed temporarily.
---

# Toast

## Installation

Install the component from your command line.

## Anatomy

Import the component.

```vue
<script setup lang="ts">
import { ToastAction, ToastClose, ToastDescription, ToastProvider, ToastRoot, ToastTitle, ToastViewport } from 'reka-ui'
</script>

<template>
  <ToastProvider>
    <ToastRoot>
      <ToastTitle />
      <ToastDescription />
      <ToastAction />
      <ToastClose />
    </ToastRoot>

    <ToastViewport />
  </ToastProvider>
</template>
```

## API Reference

### Provider

The provider that wraps your toasts and toast viewport. It usually wraps the application.

### Viewport

The fixed area where toasts appear. Users can jump to the viewport by pressing a hotkey. It is up to you to ensure the discoverability of the hotkey for keyboard users.

### Root

The toast that automatically closes. It should not be held open to [acquire a user response](/docs/components/toast#action).

### Portal

When used, portals the content part into the `body`.

### Title

An optional title for the toast

### Description

The toast message.

### Action

An action that is safe to ignore to ensure users are not expected to complete tasks with unexpected side effects as a result of a time limit.

When obtaining a user response is necessary, portal an ["AlertDialog"](/docs/components/alert-dialog) styled as a toast into the viewport instead.

### Close

A button that allows users to dismiss the toast before its duration has elapsed.

## Examples

### Custom hotkey

Override the default hotkey using the `event.code` value for each key from keycode.info.

```vue line=4
<template>
  <ToastProvider>
    ...
    <ToastViewport :hotkey="['altKey', 'KeyT']" />
  </ToastProvider>
</template>
```

### Custom duration

Customise the duration of a toast to override the provider value.

```vue line=2
<template>
  <ToastRoot :duration="3000">
    <ToastDescription>Saved!</ToastDescription>
  </ToastRoot>
</template>
```

### Duplicate toasts

When a toast must appear every time a user clicks a button, use state to render multiple instances of the same toast (see below). Alternatively, you can abstract the parts to create your own [imperative API](/docs/components/toast#imperative-api).

```vue line=3,8
<template>
  <div>
    <form @submit="count++">
      ...
      <button>save</button>
    </form>

    <ToastRoot v-for="(_, index) in count" :key="index">
      <ToastDescription>Saved!</ToastDescription>
    </ToastRoot>
  </div>
</template>
```

### Animating swipe gesture

Combine `--reka-toast-swipe-move-[x|y]` and `--reka-toast-swipe-end-[x|y]` CSS variables with `data-swipe="[start|move|cancel|end]"` attributes to animate a swipe to close gesture. Here's an example:

```vue line=2
<template>
  <ToastProvider swipe-direction="right">
    <ToastRoot class="ToastRoot">
      ...
    </ToastRoot>
    <ToastViewport />
  </ToastProvider>
</template>
```

```css line=2,3,5,9,15
/* styles.css */
.ToastRoot[data-swipe='move'] {
  transform: translateX(var(--reka-toast-swipe-move-x));
}
.ToastRoot[data-swipe='cancel'] {
  transform: translateX(0);
  transition: transform 200ms ease-out;
}
.ToastRoot[data-swipe='end'] {
  animation: slideRight 100ms ease-out;
}

@keyframes slideRight {
  from {
    transform: translateX(var(--reka-toast-swipe-end-x));
  }
  to {
    transform: translateX(100%);
  }
}
```

## Accessibility

Adheres to the `aria-live` requirements.

### Sensitivity

Control the sensitivity of the toast for screen readers using the `type` prop.

For toasts that are the result of a user action, choose `foreground`. Toasts generated from background tasks should use `background`.

#### Foreground

Foreground toasts are announced immediately. Assistive technologies may choose to clear previously queued messages when a foreground toast appears. Try to avoid stacking distinct foreground toasts at the same time.

#### Background

Background toasts are announced at the next graceful opportunity, for example, when the screen reader has finished reading its current sentence. They do not clear queued messages so overusing them can be perceived as a laggy user experience for screen reader users when used in response to a user interaction.

```vue line=2,7
<template>
  <ToastRoot type="foreground">
    <ToastDescription>File removed successfully.</ToastDescription>
    <ToastClose>Dismiss</ToastClose>
  </ToastRoot>

  <ToastRoot type="background">
    <ToastDescription>We've just released Reka UI 2.0.</ToastDescription>
    <ToastClose>Dismiss</ToastClose>
  </ToastRoot>
</template>
```

### Alternative action

Use the `altText` prop on the `Action` to instruct an alternative way of actioning the toast to screen reader users.

You can direct the user to a permanent place in your application where they can action it or implement your own custom hotkey logic. If implementing the latter, use `foreground` type to announce immediately and increase the duration to give the user ample time.

```vue line=5,11,13
<template>
  <ToastRoot type="background">
    <ToastTitle>Upgrade Available!</ToastTitle>
    <ToastDescription>We've just released Reka UI 2.0.</ToastDescription>
    <ToastAction alt-text="Goto account settings to upgrade">
      Upgrade
    </ToastAction>
    <ToastClose>Dismiss</ToastClose>
  </ToastRoot>

  <ToastRoot type="foreground" :duration="10000">
    <ToastDescription>File removed successfully.</ToastDescription>
    <ToastAction alt-text="Undo (Alt+U)">
      Undo <kbd>Alt</kbd>+<kbd>U</kbd>
    </ToastAction>
    <ToastClose>Dismiss</ToastClose>
  </ToastRoot>
</template>
```

### Close icon button

When providing an icon (or font icon), remember to label it correctly for screen reader users.

```vue line=4-5
<template>
  <ToastRoot type="foreground">
    <ToastDescription>Saved!</ToastDescription>
    <ToastClose aria-label="Close">
      <span aria-hidden="true">×</span>
    </ToastClose>
  </ToastRoot>
</template>
```

### Keyboard Interactions

## Custom APIs

### Abstract parts

Create your own API by abstracting the primitive parts into your own component.

#### Usage

```vue
<script setup lang="ts">
import Toast from './your-toast.vue'
</script>

<template>
  <Toast
    title="Upgrade available"
    content="We've just released Radix 3.0!"
  >
    <button @click="handleUpgrade">
      Upgrade
    </button>
  </Toast>
</template>
```

#### Implementation

```vue
// your-toast.vue
<script setup lang="ts">
import { ToastAction, ToastClose, ToastDescription, ToastRoot, ToastTitle } from 'reka-ui'

defineProps<{
  title: string
  content: string
}>()
</script>

<template>
  <ToastRoot>
    <ToastTitle v-if="title">
      {{ title }}
    </ToastTitle>
    <ToastDescription v-if="content">
      {{ content }}
    </ToastDescription>
    <ToastAction
      as-child
      alt-text="toast"
    >
      <slot />
    </ToastAction>
    <ToastClose aria-label="Close">
      <span aria-hidden="true">×</span>
    </ToastClose>
  </ToastRoot>
</template>
```

### Imperative API

Create your own imperative API to allow [toast duplication](/docs/components/toast#duplicate-toasts) if preferred.

#### Usage

```vue
<script setup lang="ts">
import Toast from './your-toast.vue'

const savedRef = ref<InstanceType<typeof Toast>>()
</script>

<template>
  <div>
    <form @submit="savedRef.publish()">
      ...
    </form>
    <Toast ref="savedRef">
      Saved successfully!
    </Toast>
  </div>
</template>
```

#### Implementation

```vue
// your-toast.vue
<script setup lang="ts">
import { ToastClose, ToastDescription, ToastRoot, ToastTitle } from 'reka-ui'
import { ref } from 'vue'

const count = ref(0)

function publish() {
  count.value++
}

defineExpose({
  publish
})
</script>

<template>
  <ToastRoot
    v-for="index in count"
    :key="index"
  >
    <ToastDescription>
      <slot />
    </ToastDescription>
    <ToastClose>Dismiss</ToastClose>
  </ToastRoot>
</template>
```
