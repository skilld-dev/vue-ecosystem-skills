Vue scroll animation — scroll-linked & parallax | Motion

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

# Scroll animation

There are two types of scroll animations:

- **Scroll-triggered:** A normal animation is triggered when an element enters the viewport.
- **Scroll-linked:** Values are linked directly to scroll progress.

Motion is capable of both types of animation.

## [Scroll-triggered animations](#scroll-triggered-animations)

Scroll-triggered animations are just normal animations that fire when an element enters or leaves the viewport.

Motion offers  the`[whileInView](https://motion.dev/vue-motion-component#whileinview)` prop to set an animation target or variant when the element enters the view.

<motion.div
  :initial="{ opacity: 0 }"
  :whileInView="{ opacity: 1 }"
/>

### [One-time animations](#one-time-animations)

With the`[inViewOptions](https://motion.dev/vue-motion-component#inviewoptions)`, it's possible to set `once: true` so once an element has entered the viewport, it won't animate back out.

<motion.div
  initial="hidden"
  whileInView="visible"
  :inViewOptions="{ once: true }"
/>

### [Changing scroll container](#changing-scroll-container)

By default, the element will be considered within the viewport when it enters/leaves the **window**. This can be changed by providing the `ref` of another scrollable element.



<template>
    <div ref="scrollRef" :style="{ overflow: 'scroll' }">
      <motion.div
        :initial="{ opacity: 0 }"
        :whileInView="{ opacity: 1 }"
        :inViewOptions="{ root: scrollRef }"
      />
    </div>
</template>

For more configuration options, checkout the`[motion](https://motion.dev/vue-motion-component#viewport-1)` component API reference.

### [Setting state](#setting-state)

It's also possible to set state when any element (not just a `motion` component) enters and leaves the viewport with the `[useInView](https://motion.dev/vue-use-in-view)` hook.

## [Scroll-linked animations](#scroll-linked-animations)

Scroll-linked animations are created using motion values and the `[useScroll](https://motion.dev/vue-use-scroll)` hook.

`useScroll` returns four motion values, two that store scroll offset in pixels (`scrollX` and `scrollY`) and two that store scroll progress as a value between `0` and `1`.

These motion values can be passed directly to specific styles. For instance, passing `scrollYProgress` to `scaleX` works great as a progress bar.



<template>
  <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

### [Value smoothing](#value-smoothing)

This value can be smoothed by passing it through `[useSpring](https://motion.dev/vue-use-spring)`.



<template>
 <motion.div :style="{ scaleX }" />
</template>

### [Transform other values](#transform-other-values)

With the`[useTransform](https://motion.dev/vue-use-transform)` hook, it's easy to use the progress motion values to mix between any value, like colors:



<template>
  <motion.div :style="{ backgroundColor }" />
</template>

### [Examples](#examples)

#### [Track element scroll offset](#track-element-scroll-offset)

#### [Track element within viewport](#track-element-within-viewport)

#### [Parallax](#parallax)

#### [Scroll velocity and direction](#scroll-velocity-and-direction)

Read the full`[useScroll](https://motion.dev/vue-use-scroll)` docs to discover more about creating the above effects.

There are two types of scroll animations:

- **Scroll-triggered:** A normal animation is triggered when an element enters the viewport.
- **Scroll-linked:** Values are linked directly to scroll progress.

Motion is capable of both types of animation.

## [Scroll-triggered animations](#scroll-triggered-animations)

Scroll-triggered animations are just normal animations that fire when an element enters or leaves the viewport.

Motion offers  the`[whileInView](https://motion.dev/vue-motion-component#whileinview)` prop to set an animation target or variant when the element enters the view.

<motion.div
  :initial="{ opacity: 0 }"
  :whileInView="{ opacity: 1 }"
/>

### [One-time animations](#one-time-animations)

With the`[inViewOptions](https://motion.dev/vue-motion-component#inviewoptions)`, it's possible to set `once: true` so once an element has entered the viewport, it won't animate back out.

<motion.div
  initial="hidden"
  whileInView="visible"
  :inViewOptions="{ once: true }"
/>

### [Changing scroll container](#changing-scroll-container)

By default, the element will be considered within the viewport when it enters/leaves the **window**. This can be changed by providing the `ref` of another scrollable element.



<template>
    <div ref="scrollRef" :style="{ overflow: 'scroll' }">
      <motion.div
        :initial="{ opacity: 0 }"
        :whileInView="{ opacity: 1 }"
        :inViewOptions="{ root: scrollRef }"
      />
    </div>
</template>

For more configuration options, checkout the`[motion](https://motion.dev/vue-motion-component#viewport-1)` component API reference.

### [Setting state](#setting-state)

It's also possible to set state when any element (not just a `motion` component) enters and leaves the viewport with the `[useInView](https://motion.dev/vue-use-in-view)` hook.

## [Scroll-linked animations](#scroll-linked-animations)

Scroll-linked animations are created using motion values and the `[useScroll](https://motion.dev/vue-use-scroll)` hook.

`useScroll` returns four motion values, two that store scroll offset in pixels (`scrollX` and `scrollY`) and two that store scroll progress as a value between `0` and `1`.

These motion values can be passed directly to specific styles. For instance, passing `scrollYProgress` to `scaleX` works great as a progress bar.



<template>
  <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

### [Value smoothing](#value-smoothing)

This value can be smoothed by passing it through `[useSpring](https://motion.dev/vue-use-spring)`.



<template>
 <motion.div :style="{ scaleX }" />
</template>

### [Transform other values](#transform-other-values)

With the`[useTransform](https://motion.dev/vue-use-transform)` hook, it's easy to use the progress motion values to mix between any value, like colors:



<template>
  <motion.div :style="{ backgroundColor }" />
</template>

### [Examples](#examples)

#### [Track element scroll offset](#track-element-scroll-offset)

#### [Track element within viewport](#track-element-within-viewport)

#### [Parallax](#parallax)

#### [Scroll velocity and direction](#scroll-velocity-and-direction)

Read the full`[useScroll](https://motion.dev/vue-use-scroll)` docs to discover more about creating the above effects.

There are two types of scroll animations:

- **Scroll-triggered:** A normal animation is triggered when an element enters the viewport.
- **Scroll-linked:** Values are linked directly to scroll progress.

Motion is capable of both types of animation.

## [Scroll-triggered animations](#scroll-triggered-animations)

Scroll-triggered animations are just normal animations that fire when an element enters or leaves the viewport.

Motion offers  the`[whileInView](https://motion.dev/vue-motion-component#whileinview)` prop to set an animation target or variant when the element enters the view.

<motion.div
  :initial="{ opacity: 0 }"
  :whileInView="{ opacity: 1 }"
/>

### [One-time animations](#one-time-animations)

With the`[inViewOptions](https://motion.dev/vue-motion-component#inviewoptions)`, it's possible to set `once: true` so once an element has entered the viewport, it won't animate back out.

<motion.div
  initial="hidden"
  whileInView="visible"
  :inViewOptions="{ once: true }"
/>

### [Changing scroll container](#changing-scroll-container)

By default, the element will be considered within the viewport when it enters/leaves the **window**. This can be changed by providing the `ref` of another scrollable element.



<template>
    <div ref="scrollRef" :style="{ overflow: 'scroll' }">
      <motion.div
        :initial="{ opacity: 0 }"
        :whileInView="{ opacity: 1 }"
        :inViewOptions="{ root: scrollRef }"
      />
    </div>
</template>

For more configuration options, checkout the`[motion](https://motion.dev/vue-motion-component#viewport-1)` component API reference.

### [Setting state](#setting-state)

It's also possible to set state when any element (not just a `motion` component) enters and leaves the viewport with the `[useInView](https://motion.dev/vue-use-in-view)` hook.

## [Scroll-linked animations](#scroll-linked-animations)

Scroll-linked animations are created using motion values and the `[useScroll](https://motion.dev/vue-use-scroll)` hook.

`useScroll` returns four motion values, two that store scroll offset in pixels (`scrollX` and `scrollY`) and two that store scroll progress as a value between `0` and `1`.

These motion values can be passed directly to specific styles. For instance, passing `scrollYProgress` to `scaleX` works great as a progress bar.



<template>
  <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

### [Value smoothing](#value-smoothing)

This value can be smoothed by passing it through `[useSpring](https://motion.dev/vue-use-spring)`.



<template>
 <motion.div :style="{ scaleX }" />
</template>

### [Transform other values](#transform-other-values)

With the`[useTransform](https://motion.dev/vue-use-transform)` hook, it's easy to use the progress motion values to mix between any value, like colors:



<template>
  <motion.div :style="{ backgroundColor }" />
</template>

### [Examples](#examples)

#### [Track element scroll offset](#track-element-scroll-offset)

#### [Track element within viewport](#track-element-within-viewport)

#### [Parallax](#parallax)

#### [Scroll velocity and direction](#scroll-velocity-and-direction)

Read the full`[useScroll](https://motion.dev/vue-use-scroll)` docs to discover more about creating the above effects.

Previous

Layout animation

Next

Transition options

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