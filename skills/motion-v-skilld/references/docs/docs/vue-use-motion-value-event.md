useMotionValueEvent — Vue | Motion

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

# useMotionValueEvent

`useMotionValueEvent` manages a motion value event handler throughout the lifecycle of a Vue component.



<template>
   <motion.div :style="{ x }" />
</template>

When the component is unmounted, event handlers will be safely cleaned up.

## [Usage](#usage)

Import from Motion:

import { useMotionValueEvent } from "motion-v"

To add an event listener to a motion value, provide the value, event name and callback:

const color = useMotionValue("#00f")

useMotionValueEvent(color, "change", (latest) => {
  console.log(latest)
})

Available events are:

- `change`
- `animationStart`
- `animationComplete`
- `animationCancel`

`"change"` events are provided the latest value of the motion value.

### [Advanced](#advanced)

`useMotionValueEvent` is a helper function for a motion value's `[on](https://motion.dev/vue-motion-value)` method. With `on`, you can start listening to events whenever you like, for instance within an event handler. But remember to also unsubscribe when the component unmounts.

watch([x, y],(n,o,onCleanUp) => {
  const doSomething = () => {}
  
  const unsubX = x.on("change", doSomething)
  const unsubY = y.on("change", doSomething)
  
  onCleanUp(() => {
    unsubX()
    unsubY()
  })
},{
  immediate:true
})

`useMotionValueEvent` manages a motion value event handler throughout the lifecycle of a Vue component.



<template>
   <motion.div :style="{ x }" />
</template>

When the component is unmounted, event handlers will be safely cleaned up.

## [Usage](#usage)

Import from Motion:

import { useMotionValueEvent } from "motion-v"

To add an event listener to a motion value, provide the value, event name and callback:

const color = useMotionValue("#00f")

useMotionValueEvent(color, "change", (latest) => {
  console.log(latest)
})

Available events are:

- `change`
- `animationStart`
- `animationComplete`
- `animationCancel`

`"change"` events are provided the latest value of the motion value.

### [Advanced](#advanced)

`useMotionValueEvent` is a helper function for a motion value's `[on](https://motion.dev/vue-motion-value)` method. With `on`, you can start listening to events whenever you like, for instance within an event handler. But remember to also unsubscribe when the component unmounts.

watch([x, y],(n,o,onCleanUp) => {
  const doSomething = () => {}
  
  const unsubX = x.on("change", doSomething)
  const unsubY = y.on("change", doSomething)
  
  onCleanUp(() => {
    unsubX()
    unsubY()
  })
},{
  immediate:true
})

`useMotionValueEvent` manages a motion value event handler throughout the lifecycle of a Vue component.



<template>
   <motion.div :style="{ x }" />
</template>

When the component is unmounted, event handlers will be safely cleaned up.

## [Usage](#usage)

Import from Motion:

import { useMotionValueEvent } from "motion-v"

To add an event listener to a motion value, provide the value, event name and callback:

const color = useMotionValue("#00f")

useMotionValueEvent(color, "change", (latest) => {
  console.log(latest)
})

Available events are:

- `change`
- `animationStart`
- `animationComplete`
- `animationCancel`

`"change"` events are provided the latest value of the motion value.

### [Advanced](#advanced)

`useMotionValueEvent` is a helper function for a motion value's `[on](https://motion.dev/vue-motion-value)` method. With `on`, you can start listening to events whenever you like, for instance within an event handler. But remember to also unsubscribe when the component unmounts.

watch([x, y],(n,o,onCleanUp) => {
  const doSomething = () => {}
  
  const unsubX = x.on("change", doSomething)
  const unsubY = y.on("change", doSomething)
  
  onCleanUp(() => {
    unsubX()
    unsubY()
  })
},{
  immediate:true
})

Previous

useMotionTemplate

Next

useScroll

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