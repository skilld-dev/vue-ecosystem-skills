---
title: "useDragControls — Manual Vue drag controls | Motion"
meta:
  "og:description": "Master Motion for Vue's useDragControls hook. Manually start drag gestures, add touch support, snap to cursor &amp; customize drag interactions for your components."
  "og:title": "useDragControls — Manual Vue drag controls | Motion"
  "twitter:description": "Master Motion for Vue's useDragControls hook. Manually start drag gestures, add touch support, snap to cursor &amp; customize drag interactions for your components."
  "twitter:title": "useDragControls — Manual Vue drag controls | Motion"
  description: "Master Motion for Vue's useDragControls hook. Manually start drag gestures, add touch support, snap to cursor &amp; customize drag interactions for your components."
---

Vue

# useDragControls

Usually, dragging is initiated by pressing down on a`[motion](https://motion.dev/vue-gestures#drag)` component with a`[drag](https://motion.dev/vue-gestures#drag)` prop and then moving the pointer.

For some use-cases, for example clicking at an arbitrary point on a video scrubber, we might want to initiate that dragging from a different element.

With `useDragControls`, we can create a set of controls to manually start dragging from any pointer event.

## [Usage](#usage)

Import `useDragControls` from Motion:

import { useDragControls } from "motion-v"

`useDragControls` returns drag controls that can be passed to a draggable `motion` component:



<template>
  <motion.div drag :drag-controls="controls" />
</template>

Now we can start a drag session from another any element's `onPointerDown` event via the `start` method.

<template>
  <div @pointerdown="(event) => controls.start(event)" />
</template>

### [Touch support](#touch-support)

To support touch screens, the triggering element should have the `touch-action: none` style applied.

<template>
  <div 
    @pointerdown="startDrag" 
    style="touch-action: none"
  />
</template>

### [Snap to cursor](#snap-to-cursor)

By default, the drag gesture will only apply **changes** to the pointer position.

We can also make the `motion` component immediately snap to the cursor by passing `snapToCursor: true` to the `start` method.

controls.start(event, { snapToCursor: true })

### [Disable automatic drag](#disable-automatic-drag)

With this configuration, the `motion` component will still automatically start a drag gesture when it receives a `pointerdown` event itself.

We can stop this behaviour by passing it a `:dragListener="false"` prop.

<template>
  <motion.div
    drag
    :drag-listener="false"
    :drag-controls="controls"
  />
</template>

Usually, dragging is initiated by pressing down on a`[motion](https://motion.dev/vue-gestures#drag)` component with a`[drag](https://motion.dev/vue-gestures#drag)` prop and then moving the pointer.

For some use-cases, for example clicking at an arbitrary point on a video scrubber, we might want to initiate that dragging from a different element.

With `useDragControls`, we can create a set of controls to manually start dragging from any pointer event.

## [Usage](#usage)

Import `useDragControls` from Motion:

import { useDragControls } from "motion-v"

`useDragControls` returns drag controls that can be passed to a draggable `motion` component:



<template>
  <motion.div drag :drag-controls="controls" />
</template>

Now we can start a drag session from another any element's `onPointerDown` event via the `start` method.

<template>
  <div @pointerdown="(event) => controls.start(event)" />
</template>

### [Touch support](#touch-support)

To support touch screens, the triggering element should have the `touch-action: none` style applied.

<template>
  <div 
    @pointerdown="startDrag" 
    style="touch-action: none"
  />
</template>

### [Snap to cursor](#snap-to-cursor)

By default, the drag gesture will only apply **changes** to the pointer position.

We can also make the `motion` component immediately snap to the cursor by passing `snapToCursor: true` to the `start` method.

controls.start(event, { snapToCursor: true })

### [Disable automatic drag](#disable-automatic-drag)

With this configuration, the `motion` component will still automatically start a drag gesture when it receives a `pointerdown` event itself.

We can stop this behaviour by passing it a `:dragListener="false"` prop.

<template>
  <motion.div
    drag
    :drag-listener="false"
    :drag-controls="controls"
  />
</template>

Usually, dragging is initiated by pressing down on a`[motion](https://motion.dev/vue-gestures#drag)` component with a`[drag](https://motion.dev/vue-gestures#drag)` prop and then moving the pointer.

For some use-cases, for example clicking at an arbitrary point on a video scrubber, we might want to initiate that dragging from a different element.

With `useDragControls`, we can create a set of controls to manually start dragging from any pointer event.

## [Usage](#usage)

Import `useDragControls` from Motion:

import { useDragControls } from "motion-v"

`useDragControls` returns drag controls that can be passed to a draggable `motion` component:



<template>
  <motion.div drag :drag-controls="controls" />
</template>

Now we can start a drag session from another any element's `onPointerDown` event via the `start` method.

<template>
  <div @pointerdown="(event) => controls.start(event)" />
</template>

### [Touch support](#touch-support)

To support touch screens, the triggering element should have the `touch-action: none` style applied.

<template>
  <div 
    @pointerdown="startDrag" 
    style="touch-action: none"
  />
</template>

### [Snap to cursor](#snap-to-cursor)

By default, the drag gesture will only apply **changes** to the pointer position.

We can also make the `motion` component immediately snap to the cursor by passing `snapToCursor: true` to the `start` method.

controls.start(event, { snapToCursor: true })

### [Disable automatic drag](#disable-automatic-drag)

With this configuration, the `motion` component will still automatically start a drag gesture when it receives a `pointerdown` event itself.

We can stop this behaviour by passing it a `:dragListener="false"` prop.

<template>
  <motion.div
    drag
    :drag-listener="false"
    :drag-controls="controls"
  />
</template>

Previous

useAnimationFrame

Next

useInView

Motion+

## Level up your animations with Motion+

Unlock the full vault of 330+ Motion examples, 100+ tutorials, premium APIs, private Discord and GitHub, and powerful Motion Studio animation editing tools for your IDE.

Get Motion+

Get Motion+

One-time payment, lifetime updates.



 AI-ready animations Make your LLM an animation expert with 330+ pre-built examples available via MCP.

Motion is supported by the best in the industry.











animations.dev 

##### Stay in the loop

Subscribe for the latest news & updates.



Latest version:

12.34.3

Motion+

Login

Register

Upgrade

##### Stay in the loop

Subscribe for the latest news & updates.



Latest version:

12.34.3

Motion+

Login

Register

Upgrade

##### Stay in the loop

Subscribe for the latest news & updates.



Latest version:

12.34.3

Motion+

Login

Register

Upgrade