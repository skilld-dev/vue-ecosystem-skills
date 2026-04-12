useDragControls — Manual Vue drag controls | Motion

Motion homepage

Docs

Examples

Tutorials

AI Kit



Motion+

Motion homepage

Docs

Examples

Tutorials



Motion+

Motion homepage

Docs

Examples

Tutorials

AI Kit



Motion+

Documentation

<h2>JS</h2> <h2>React</h2> Vue Studio

<h3>Get started</h3> <h3>Examples</h3>

### Animation

- Overview
- Directive
- Gesture
- Layout
- Scroll
- Transition options

### Components

- motion
- AnimatePresence
- LayoutGroup
- LazyMotion
- MotionConfig
- Reorder

### Premium APIs

- AnimateNumber
- Cursor
- Ticker
- Typewriter

### Motion values

- Overview
- useMotionTemplate
- useMotionValueEvent
- useScroll
- useSpring
- useTime
- useTransform
- useVelocity

### Hooks

- useAnimate
- useAnimationFrame
- useDragControls
- useInView
- useReducedMotion

### Integrations

- Reka

Vue

Copy page

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

Subscribe



## Site

- Blog
- Docs
- Examples
- Magazine
- Studio
- Support
- Tutorials

## Products

- CSS Studio
- Motion
- Motion+
- MotionScore

###### Most Popular

- React animation
- Layout animation
- SVG animation
- Motion component
- GSAP vs Motion

###### Docs

- JavaScript
- React
- Vue
- Studio

## Social

- Discord
- GitHub
- X/Twitter
- YouTube

Latest version:

12.37.0

Motion+

Login

Register

Upgrade

##### Stay in the loop

Subscribe for the latest news & updates.

Subscribe



## Site

- Blog
- Docs
- Examples
- Magazine
- Studio
- Support
- Tutorials

## Products

- CSS Studio
- Motion
- Motion+
- MotionScore

###### Most Popular

- React animation
- Layout animation
- SVG animation
- Motion component
- GSAP vs Motion

###### Docs

- JavaScript
- React
- Vue
- Studio

## Social

- Discord
- GitHub
- X/Twitter
- YouTube

Latest version:

12.37.0

Motion+

Login

Register

Upgrade

##### Stay in the loop

Subscribe for the latest news & updates.

Subscribe



## Site

- Blog
- Docs
- Examples
- Magazine
- Studio
- Support
- Tutorials

## Products

- CSS Studio
- Motion
- Motion+
- MotionScore

###### Most Popular

- React animation
- Layout animation
- SVG animation
- Motion component
- GSAP vs Motion

###### Docs

- JavaScript
- React
- Vue
- Studio

## Social

- Discord
- GitHub
- X/Twitter
- YouTube

Latest version:

12.37.0

Motion+

Login

Register

Upgrade