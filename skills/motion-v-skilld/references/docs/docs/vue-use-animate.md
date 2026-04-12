useAnimate — Manual Vue animation controls | Motion

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

# useAnimate

`useAnimate` provides a way of using the `[animate](https://motion.dev/animate)` function that is scoped to the elements within your component.

This allows you to use manual animation controls, timelines, selectors scoped to your component, and automatic cleanup.

It provides a `scope` ref, and an `animate` function where every DOM selector is scoped to this ref.



<template>
  <ul ref="scope">
    <slot />
  </ul>
</template>

Additionally, when the component calling `useAnimate` is removed, all animations started with its `animate` function will be cleaned up automatically.

## [Usage](#usage)

Import from Motion:

import { useAnimate } from "motion-v"

`useAnimate` returns two arguments, a `scope` ref and an `[animate](https://motion.dev/animate)` function.



This `scope` ref must be passed to either a regular HTML/SVG element or a `motion` component.



<template>
  <ul ref="scope">
    <slot />
  </ul>
</template>

This scoped `animate` function can now be used in effects and event handlers to animate elements.

We can either use the scoped element directly:

animate(scope.current, { opacity: 1 }, { duration: 1 })

Or by passing it a selector:

animate("li", { backgroundColor: "#000" }, { ease: "linear" })

This selector is `"li"`, but we're not selecting all `li` elements on the page, only those that are a child of the scoped element.

### [Scroll-triggered animations](#scroll-triggered-animations)

Animations can be triggered when the scope scrolls into view by combining `useAnimate` with `[useInView](https://motion.dev/vue-use-in-view)`.



<template>
  <ul ref="scope">
    <li />
    <li />
    <li />
  </ul>
</template>

`useAnimate` provides a way of using the `[animate](https://motion.dev/animate)` function that is scoped to the elements within your component.

This allows you to use manual animation controls, timelines, selectors scoped to your component, and automatic cleanup.

It provides a `scope` ref, and an `animate` function where every DOM selector is scoped to this ref.



<template>
  <ul ref="scope">
    <slot />
  </ul>
</template>

Additionally, when the component calling `useAnimate` is removed, all animations started with its `animate` function will be cleaned up automatically.

## [Usage](#usage)

Import from Motion:

import { useAnimate } from "motion-v"

`useAnimate` returns two arguments, a `scope` ref and an `[animate](https://motion.dev/animate)` function.



This `scope` ref must be passed to either a regular HTML/SVG element or a `motion` component.



<template>
  <ul ref="scope">
    <slot />
  </ul>
</template>

This scoped `animate` function can now be used in effects and event handlers to animate elements.

We can either use the scoped element directly:

animate(scope.current, { opacity: 1 }, { duration: 1 })

Or by passing it a selector:

animate("li", { backgroundColor: "#000" }, { ease: "linear" })

This selector is `"li"`, but we're not selecting all `li` elements on the page, only those that are a child of the scoped element.

### [Scroll-triggered animations](#scroll-triggered-animations)

Animations can be triggered when the scope scrolls into view by combining `useAnimate` with `[useInView](https://motion.dev/vue-use-in-view)`.



<template>
  <ul ref="scope">
    <li />
    <li />
    <li />
  </ul>
</template>

`useAnimate` provides a way of using the `[animate](https://motion.dev/animate)` function that is scoped to the elements within your component.

This allows you to use manual animation controls, timelines, selectors scoped to your component, and automatic cleanup.

It provides a `scope` ref, and an `animate` function where every DOM selector is scoped to this ref.



<template>
  <ul ref="scope">
    <slot />
  </ul>
</template>

Additionally, when the component calling `useAnimate` is removed, all animations started with its `animate` function will be cleaned up automatically.

## [Usage](#usage)

Import from Motion:

import { useAnimate } from "motion-v"

`useAnimate` returns two arguments, a `scope` ref and an `[animate](https://motion.dev/animate)` function.



This `scope` ref must be passed to either a regular HTML/SVG element or a `motion` component.



<template>
  <ul ref="scope">
    <slot />
  </ul>
</template>

This scoped `animate` function can now be used in effects and event handlers to animate elements.

We can either use the scoped element directly:

animate(scope.current, { opacity: 1 }, { duration: 1 })

Or by passing it a selector:

animate("li", { backgroundColor: "#000" }, { ease: "linear" })

This selector is `"li"`, but we're not selecting all `li` elements on the page, only those that are a child of the scoped element.

### [Scroll-triggered animations](#scroll-triggered-animations)

Animations can be triggered when the scope scrolls into view by combining `useAnimate` with `[useInView](https://motion.dev/vue-use-in-view)`.



<template>
  <ul ref="scope">
    <li />
    <li />
    <li />
  </ul>
</template>

Previous

useVelocity

Next

useAnimationFrame

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