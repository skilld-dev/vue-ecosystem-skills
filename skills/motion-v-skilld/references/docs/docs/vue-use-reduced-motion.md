useReducedMotion — Accessible Vue animations | Motion

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

# useReducedMotion

A hook that returns `true` if the current device has Reduced Motion setting enabled.

const shouldReduceMotion = useReducedMotion()

This can be used to implement changes to your UI based on Reduced Motion. For instance, replacing potentially motion-sickness inducing `x`/`y` animations with `opacity`, disabling the autoplay of background videos, or turning off parallax motion.

It will actively respond to changes and re-render your components with the latest setting.



<template>
  <Motion
    :animate="{
      opacity: isOpen ? 1 : 0,
      x: isOpen ? 0 : closedX
    }"
  />
</template>

## [Usage](#usage)

Import `useReducedMotion` from Motion:

import { useReducedMotion } from "motion-v"

In any component, call `useReducedMotion` to check whether the device's Reduced Motion setting is enabled.

const prefersReducedMotion = useReducedMotion()

You can then use this `true`/`false` value to change your application logic.

A hook that returns `true` if the current device has Reduced Motion setting enabled.

const shouldReduceMotion = useReducedMotion()

This can be used to implement changes to your UI based on Reduced Motion. For instance, replacing potentially motion-sickness inducing `x`/`y` animations with `opacity`, disabling the autoplay of background videos, or turning off parallax motion.

It will actively respond to changes and re-render your components with the latest setting.



<template>
  <Motion
    :animate="{
      opacity: isOpen ? 1 : 0,
      x: isOpen ? 0 : closedX
    }"
  />
</template>

## [Usage](#usage)

Import `useReducedMotion` from Motion:

import { useReducedMotion } from "motion-v"

In any component, call `useReducedMotion` to check whether the device's Reduced Motion setting is enabled.

const prefersReducedMotion = useReducedMotion()

You can then use this `true`/`false` value to change your application logic.

A hook that returns `true` if the current device has Reduced Motion setting enabled.

const shouldReduceMotion = useReducedMotion()

This can be used to implement changes to your UI based on Reduced Motion. For instance, replacing potentially motion-sickness inducing `x`/`y` animations with `opacity`, disabling the autoplay of background videos, or turning off parallax motion.

It will actively respond to changes and re-render your components with the latest setting.



<template>
  <Motion
    :animate="{
      opacity: isOpen ? 1 : 0,
      x: isOpen ? 0 : closedX
    }"
  />
</template>

## [Usage](#usage)

Import `useReducedMotion` from Motion:

import { useReducedMotion } from "motion-v"

In any component, call `useReducedMotion` to check whether the device's Reduced Motion setting is enabled.

const prefersReducedMotion = useReducedMotion()

You can then use this `true`/`false` value to change your application logic.

Previous

useInView

Next

Integrate Motion with Reka

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