---
title: "Motion values — Composables for Vue animations | Motion"
meta:
  "og:description": "Power Vue animations with Motion values. Track state/velocity, sync components, &amp; update styles without re-renders. Compose with useTransform/useSpring."
  "og:title": "Motion values — Composables for Vue animations | Motion"
  "twitter:description": "Power Vue animations with Motion values. Track state/velocity, sync components, &amp; update styles without re-renders. Compose with useTransform/useSpring."
  "twitter:title": "Motion values — Composables for Vue animations | Motion"
  description: "Power Vue animations with Motion values. Track state/velocity, sync components, &amp; update styles without re-renders. Compose with useTransform/useSpring."
---

Vue

# Motion values

Motion values track the state and velocity of animated values.

They are composable, signal-like values that are performant because Motion can render them with its optimised DOM renderer.

Usually, these are created automatically by `[motion](https://motion.dev/vue-motion-component)` components. But for advanced use cases, it's possible to create them manually.



<template>
  <motion.div :style="{ x }" />
</template>

By manually creating motion values you can:

- Set and get their state.
- Pass to multiple components to synchronise motion across them.
- Chain `MotionValue`s via the `useTransform` hook.
- Update visual properties without triggering Vue's render cycle.
- Subscribe to updates.



<template>

  <motion.div drag="x" :style="{ x, opacity }" />
</template>

## [Usage](#usage)

Motion values can be created with the `useMotionValue` hook. The string or number passed to `useMotionValue` will act as its initial state.

import { useMotionValue } from "motion-v"

const x = useMotionValue(0)

Motion values can be passed to a `motion` component via `style`:

<motion.li :style="{ x }" />

Or for SVG attributes, via the attribute prop itself:

<motion.circle :cx="cx" />

It's possible to pass the same motion value to multiple components.

Motion values can be updated with the `set` method.

x.set(100)

Changes to the motion value will update the DOM **without triggering a Vue re-render**. Motion values can be updated multiple times but renders will be batched to the next animation frame.

A motion value can hold any string or number. We can read it with the `get` method.

x.get() // 100

Motion values containing a number can return a velocity via the `getVelocity` method. This returns the velocity as calculated **per second** to account for variations in frame rate across devices.

const xVelocity = x.getVelocity()

For strings and colors, `getVelocity` will always return `0`.

### [Events](#events)

Listeners can be added to motion values via the`[on](https://motion.dev/vue-motion-value#on)` method or the`[useMotionValueEvent](https://motion.dev/vue-use-motion-value-event)` hook.

useMotionValueEvent(x, "change", (latest) => console.log(latest))

Available events are `"change"`, `"animationStart"`, `"animationComplete"` `"animationCancel"`.

### [Composition](#composition)

Beyond `useMotionValue`, Motion provides a number of hooks for creating and composing motion values, like `[useSpring](https://motion.dev/vue-use-spring)` and `[useTransform](https://motion.dev/vue-use-transform)`.

For example, with `useTransform` we can take the latest state of one or more motion values and create a new motion value with the result.

const y = useTransform(() => x.get() * 2)

`useSpring` can make a motion value that's attached to another via a spring.

const dragX = useMotionValue(0)
const dragY = useMotionValue(0)
const x = useSpring(dragX)
const y = useSpring(dragY)

These motion values can then go on to be passed to `motion` components, or composed with more hooks like `[useVelocity](https://motion.dev/vue-use-velocity)`.

## [API](#api)

### [`get()`](#get())

Returns the latest state of the motion value.

### [`getVelocity()`](#getvelocity())

Returns the latest velocity of the motion value. Returns `0` if the value is non-numerical.

### [`set()`](#set())

Sets the motion value to a new state.

x.set("#f00")

### [`jump()`](#jump())

Jumps the motion value to a new state in a way that breaks continuity from previous values:

- Resets `velocity` to `0`.
- Ends active animations.
- Ignores attached effects (for instance `useSpring`'s spring).

const x = useSpring(0)
x.jump(10)
x.getVelocity() // 0

### [`isAnimating()`](#isanimating())

Returns `true` if the value is currently animating.

### [`stop()`](#stop())

Stop the active animation.

### [`on()`](#on())

Subscribe to motion value events. Available events are:

- `change`
- `animationStart`
- `animationCancel`
- `animationComplete`

It returns a function that, when called, will unsubscribe the listener.

const unsubscribe = x.on("change", latest => console.log(latest))

### [`destroy()`](#destroy())

Destroy and clean up subscribers to this motion value.

This is normally handled automatically, so this method is only necessary if you've manually created a motion value outside the Vue render cycle using the vanilla `motionValue` hook.

Motion values track the state and velocity of animated values.

They are composable, signal-like values that are performant because Motion can render them with its optimised DOM renderer.

Usually, these are created automatically by `[motion](https://motion.dev/vue-motion-component)` components. But for advanced use cases, it's possible to create them manually.



<template>
  <motion.div :style="{ x }" />
</template>

By manually creating motion values you can:

- Set and get their state.
- Pass to multiple components to synchronise motion across them.
- Chain `MotionValue`s via the `useTransform` hook.
- Update visual properties without triggering Vue's render cycle.
- Subscribe to updates.



<template>

  <motion.div drag="x" :style="{ x, opacity }" />
</template>

## [Usage](#usage)

Motion values can be created with the `useMotionValue` hook. The string or number passed to `useMotionValue` will act as its initial state.

import { useMotionValue } from "motion-v"

const x = useMotionValue(0)

Motion values can be passed to a `motion` component via `style`:

<motion.li :style="{ x }" />

Or for SVG attributes, via the attribute prop itself:

<motion.circle :cx="cx" />

It's possible to pass the same motion value to multiple components.

Motion values can be updated with the `set` method.

x.set(100)

Changes to the motion value will update the DOM **without triggering a Vue re-render**. Motion values can be updated multiple times but renders will be batched to the next animation frame.

A motion value can hold any string or number. We can read it with the `get` method.

x.get() // 100

Motion values containing a number can return a velocity via the `getVelocity` method. This returns the velocity as calculated **per second** to account for variations in frame rate across devices.

const xVelocity = x.getVelocity()

For strings and colors, `getVelocity` will always return `0`.

### [Events](#events)

Listeners can be added to motion values via the`[on](https://motion.dev/vue-motion-value#on)` method or the`[useMotionValueEvent](https://motion.dev/vue-use-motion-value-event)` hook.

useMotionValueEvent(x, "change", (latest) => console.log(latest))

Available events are `"change"`, `"animationStart"`, `"animationComplete"` `"animationCancel"`.

### [Composition](#composition)

Beyond `useMotionValue`, Motion provides a number of hooks for creating and composing motion values, like `[useSpring](https://motion.dev/vue-use-spring)` and `[useTransform](https://motion.dev/vue-use-transform)`.

For example, with `useTransform` we can take the latest state of one or more motion values and create a new motion value with the result.

const y = useTransform(() => x.get() * 2)

`useSpring` can make a motion value that's attached to another via a spring.

const dragX = useMotionValue(0)
const dragY = useMotionValue(0)
const x = useSpring(dragX)
const y = useSpring(dragY)

These motion values can then go on to be passed to `motion` components, or composed with more hooks like `[useVelocity](https://motion.dev/vue-use-velocity)`.

## [API](#api)

### [`get()`](#get())

Returns the latest state of the motion value.

### [`getVelocity()`](#getvelocity())

Returns the latest velocity of the motion value. Returns `0` if the value is non-numerical.

### [`set()`](#set())

Sets the motion value to a new state.

x.set("#f00")

### [`jump()`](#jump())

Jumps the motion value to a new state in a way that breaks continuity from previous values:

- Resets `velocity` to `0`.
- Ends active animations.
- Ignores attached effects (for instance `useSpring`'s spring).

const x = useSpring(0)
x.jump(10)
x.getVelocity() // 0

### [`isAnimating()`](#isanimating())

Returns `true` if the value is currently animating.

### [`stop()`](#stop())

Stop the active animation.

### [`on()`](#on())

Subscribe to motion value events. Available events are:

- `change`
- `animationStart`
- `animationCancel`
- `animationComplete`

It returns a function that, when called, will unsubscribe the listener.

const unsubscribe = x.on("change", latest => console.log(latest))

### [`destroy()`](#destroy())

Destroy and clean up subscribers to this motion value.

This is normally handled automatically, so this method is only necessary if you've manually created a motion value outside the Vue render cycle using the vanilla `motionValue` hook.

Motion values track the state and velocity of animated values.

They are composable, signal-like values that are performant because Motion can render them with its optimised DOM renderer.

Usually, these are created automatically by `[motion](https://motion.dev/vue-motion-component)` components. But for advanced use cases, it's possible to create them manually.



<template>
  <motion.div :style="{ x }" />
</template>

By manually creating motion values you can:

- Set and get their state.
- Pass to multiple components to synchronise motion across them.
- Chain `MotionValue`s via the `useTransform` hook.
- Update visual properties without triggering Vue's render cycle.
- Subscribe to updates.



<template>

  <motion.div drag="x" :style="{ x, opacity }" />
</template>

## [Usage](#usage)

Motion values can be created with the `useMotionValue` hook. The string or number passed to `useMotionValue` will act as its initial state.

import { useMotionValue } from "motion-v"

const x = useMotionValue(0)

Motion values can be passed to a `motion` component via `style`:

<motion.li :style="{ x }" />

Or for SVG attributes, via the attribute prop itself:

<motion.circle :cx="cx" />

It's possible to pass the same motion value to multiple components.

Motion values can be updated with the `set` method.

x.set(100)

Changes to the motion value will update the DOM **without triggering a Vue re-render**. Motion values can be updated multiple times but renders will be batched to the next animation frame.

A motion value can hold any string or number. We can read it with the `get` method.

x.get() // 100

Motion values containing a number can return a velocity via the `getVelocity` method. This returns the velocity as calculated **per second** to account for variations in frame rate across devices.

const xVelocity = x.getVelocity()

For strings and colors, `getVelocity` will always return `0`.

### [Events](#events)

Listeners can be added to motion values via the`[on](https://motion.dev/vue-motion-value#on)` method or the`[useMotionValueEvent](https://motion.dev/vue-use-motion-value-event)` hook.

useMotionValueEvent(x, "change", (latest) => console.log(latest))

Available events are `"change"`, `"animationStart"`, `"animationComplete"` `"animationCancel"`.

### [Composition](#composition)

Beyond `useMotionValue`, Motion provides a number of hooks for creating and composing motion values, like `[useSpring](https://motion.dev/vue-use-spring)` and `[useTransform](https://motion.dev/vue-use-transform)`.

For example, with `useTransform` we can take the latest state of one or more motion values and create a new motion value with the result.

const y = useTransform(() => x.get() * 2)

`useSpring` can make a motion value that's attached to another via a spring.

const dragX = useMotionValue(0)
const dragY = useMotionValue(0)
const x = useSpring(dragX)
const y = useSpring(dragY)

These motion values can then go on to be passed to `motion` components, or composed with more hooks like `[useVelocity](https://motion.dev/vue-use-velocity)`.

## [API](#api)

### [`get()`](#get())

Returns the latest state of the motion value.

### [`getVelocity()`](#getvelocity())

Returns the latest velocity of the motion value. Returns `0` if the value is non-numerical.

### [`set()`](#set())

Sets the motion value to a new state.

x.set("#f00")

### [`jump()`](#jump())

Jumps the motion value to a new state in a way that breaks continuity from previous values:

- Resets `velocity` to `0`.
- Ends active animations.
- Ignores attached effects (for instance `useSpring`'s spring).

const x = useSpring(0)
x.jump(10)
x.getVelocity() // 0

### [`isAnimating()`](#isanimating())

Returns `true` if the value is currently animating.

### [`stop()`](#stop())

Stop the active animation.

### [`on()`](#on())

Subscribe to motion value events. Available events are:

- `change`
- `animationStart`
- `animationCancel`
- `animationComplete`

It returns a function that, when called, will unsubscribe the listener.

const unsubscribe = x.on("change", latest => console.log(latest))

### [`destroy()`](#destroy())

Destroy and clean up subscribers to this motion value.

This is normally handled automatically, so this method is only necessary if you've manually created a motion value outside the Vue render cycle using the vanilla `motionValue` hook.

Previous

Reorder

Next

useMotionTemplate

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