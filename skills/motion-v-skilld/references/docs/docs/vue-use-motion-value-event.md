---
title: "useMotionValueEvent — Vue | Motion"
meta:
  "og:description": "Manage motion value event listeners in Vue with useMotionValueEvent. Auto-cleans events like change &amp; animationComplete for dynamic UIs."
  "og:title": "useMotionValueEvent — Vue | Motion"
  "twitter:description": "Manage motion value event listeners in Vue with useMotionValueEvent. Auto-cleans events like change &amp; animationComplete for dynamic UIs."
  "twitter:title": "useMotionValueEvent — Vue | Motion"
  description: "Manage motion value event listeners in Vue with useMotionValueEvent. Auto-cleans events like change &amp; animationComplete for dynamic UIs."
---

Vue

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



Latest version:

12.34.5

Motion+

Login

Register

Upgrade

##### Stay in the loop

Subscribe for the latest news & updates.



Latest version:

12.34.5

Motion+

Login

Register

Upgrade

##### Stay in the loop

Subscribe for the latest news & updates.



Latest version:

12.34.5

Motion+

Login

Register

Upgrade