---
title: "useAnimate — Manual Vue animation controls | Motion"
meta:
  "og:description": "Discover Motion for Vue's useAnimate hook for component-scoped animations. Use its animate function for manual control, scoped selectors &amp; auto cleanup."
  "og:title": "useAnimate — Manual Vue animation controls | Motion"
  "twitter:description": "Discover Motion for Vue's useAnimate hook for component-scoped animations. Use its animate function for manual control, scoped selectors &amp; auto cleanup."
  "twitter:title": "useAnimate — Manual Vue animation controls | Motion"
  description: "Discover Motion for Vue's useAnimate hook for component-scoped animations. Use its animate function for manual control, scoped selectors &amp; auto cleanup."
---

Vue

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