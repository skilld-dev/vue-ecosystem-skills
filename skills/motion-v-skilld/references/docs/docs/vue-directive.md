---
title: "v-motion Directive – Motion for Vue | Motion"
meta:
  "og:description": "v-motion directive for Motion for Vue : add enter/exit, gestures, layout, and variants to any HTML/SVG element without wrapping in a motion component. Use with AnimatePresence, presets, and SSR."
  "og:title": "v-motion Directive – Motion for Vue | Motion"
  "twitter:description": "v-motion directive for Motion for Vue : add enter/exit, gestures, layout, and variants to any HTML/SVG element without wrapping in a motion component. Use with AnimatePresence, presets, and SSR."
  "twitter:title": "v-motion Directive – Motion for Vue | Motion"
  description: "v-motion directive for Motion for Vue : add enter/exit, gestures, layout, and variants to any HTML/SVG element without wrapping in a motion component. Use with AnimatePresence, presets, and SSR."
---

Vue

# Motion Directive

The `v-motion` directive provides a declarative way to add Motion animations to any HTML or SVG element without using wrapper components. It offers most of the powerful animation capabilities of the `[<motion/>](https://motion.dev/vue-motion-component)` component with a more traditional Vue directive syntax.

## [Install](#install)

### [Global registration (Vue)](#global-registration-(vue))

import { createApp } from 'vue'
import { MotionPlugin } from 'motion-v'

const app = createApp(App)
app.use(MotionPlugin)

### [Global registration (Nuxt)](#global-registration-(nuxt))

// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['motion-v/nuxt'],
  motionV: {
    directives: true,
  },
})

### [Local registration](#local-registration)



## [Syntax](#syntax)

### [Basic animation](#basic-animation)

<div v-motion :initial="{ opacity: 0 }" :animate="{ opacity: 1 }">
  Hello Motion
</div>

`v-motion` supports two syntax styles. You can also mix them: Element props take priority over the binding value.

### [Binding value](#binding-value)

Pass all options as a single object:

<div
  v-motion="{
    initial: { opacity: 0, x: -30 },
    animate: { opacity: 1, x: 0 },
    transition: { duration: 0.6 },
  }"
>
  Slide In
</div>

### [Props](#props)

Use `v-motion` as a marker and pass motion options as individual props:

<div
  v-motion
  :initial="{ opacity: 0, y: 30 }"
  :animate="{ opacity: 1, y: 0 }"
  :transition="{ duration: 0.6 }"
>
  Fade In
</div>

### [Mixed](#mixed)

When both are used, element props override binding value keys:


<div
  v-motion="{ initial: { opacity: 0.5 }, transition: { duration: 0.5 } }"
  :initial="{ opacity: 0.2 }"
>
  Props Win
</div>

## [Usage](#usage)

`v-motion` supports the same animation props as the `[<motion>](https://motion.dev/vue-motion-component)` component — `initial`, `animate`, `exit`, `transition`, gesture props (`whileHover`, `whilePress`, `whileFocus`, `whileInView`, `whileDrag`), and reactive bindings.

For detailed usage of these features, see the Animation.

## [Exit animation](#exit-animation)

Use `exit` with `[<AnimatePresence>](https://motion.dev/vue-animate-presence)` to animate elements out when they are removed with `v-if`.



<template>
  <button @click="isVisible = !isVisible">
    Toggle
  </button>

  <AnimatePresence>
    <div
      v-if="isVisible"
      v-motion
      :initial="{ opacity: 0, scale: 0.5, rotate: -10 }"
      :animate="{ opacity: 1, scale: 1, rotate: 0 }"
      :exit="{ opacity: 0, scale: 0.5, rotate: 10 }"
      :transition="{ type: 'spring', duration: 0.5 }"
    >
      Toggle me
    </div>
  </AnimatePresence>
</template>

## [Presets](#presets)

`MotionPlugin` accepts a `presets` option to register custom preset directives. Each preset is automatically registered as a `v-{name}` global directive:

### [`MotionPlugin`](#motionplugin)

app.use(MotionPlugin, {
  presets: {
    'fade-in': {
      initial: { opacity: 0 },
      animate: { opacity: 1 },
      transition: { duration: 0.5 },
    },
    'slide-up': {
      initial: { opacity: 0, y: 40 },
      animate: { opacity: 1, y: 0 },
      transition: { duration: 0.5 },
    },
    'scale-in': {
      initial: { opacity: 0, scale: 0.5 },
      animate: { opacity: 1, scale: 1 },
      transition: { type: 'spring', stiffness: 300, damping: 20 },
    },
  },
})

### [Nuxt Module](#nuxt-module)

In `nuxt.config.ts`:

export default defineNuxtConfig({
  modules: ['motion-v/nuxt'],
  motionV: {
    directives: true, // globally register v-motion
    presets: {
      'fade-in': {
        initial: { opacity: 0 },
        animate: { opacity: 1 },
      },
    },
  },
})

Then use anywhere without imports:

<template>
  <div v-fade-in>
    Fade
  </div>
  
  <div v-slide-up>
    Slide
  </div>
  
  <div v-scale-in>
    Scale
  </div>
</template>

The `v-motion` directive provides a declarative way to add Motion animations to any HTML or SVG element without using wrapper components. It offers most of the powerful animation capabilities of the `[<motion/>](https://motion.dev/vue-motion-component)` component with a more traditional Vue directive syntax.

## [Install](#install)

### [Global registration (Vue)](#global-registration-(vue))

import { createApp } from 'vue'
import { MotionPlugin } from 'motion-v'

const app = createApp(App)
app.use(MotionPlugin)

### [Global registration (Nuxt)](#global-registration-(nuxt))

// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['motion-v/nuxt'],
  motionV: {
    directives: true,
  },
})

### [Local registration](#local-registration)



## [Syntax](#syntax)

### [Basic animation](#basic-animation)

<div v-motion :initial="{ opacity: 0 }" :animate="{ opacity: 1 }">
  Hello Motion
</div>

`v-motion` supports two syntax styles. You can also mix them: Element props take priority over the binding value.

### [Binding value](#binding-value)

Pass all options as a single object:

<div
  v-motion="{
    initial: { opacity: 0, x: -30 },
    animate: { opacity: 1, x: 0 },
    transition: { duration: 0.6 },
  }"
>
  Slide In
</div>

### [Props](#props)

Use `v-motion` as a marker and pass motion options as individual props:

<div
  v-motion
  :initial="{ opacity: 0, y: 30 }"
  :animate="{ opacity: 1, y: 0 }"
  :transition="{ duration: 0.6 }"
>
  Fade In
</div>

### [Mixed](#mixed)

When both are used, element props override binding value keys:


<div
  v-motion="{ initial: { opacity: 0.5 }, transition: { duration: 0.5 } }"
  :initial="{ opacity: 0.2 }"
>
  Props Win
</div>

## [Usage](#usage)

`v-motion` supports the same animation props as the `[<motion>](https://motion.dev/vue-motion-component)` component — `initial`, `animate`, `exit`, `transition`, gesture props (`whileHover`, `whilePress`, `whileFocus`, `whileInView`, `whileDrag`), and reactive bindings.

For detailed usage of these features, see the Animation.

## [Exit animation](#exit-animation)

Use `exit` with `[<AnimatePresence>](https://motion.dev/vue-animate-presence)` to animate elements out when they are removed with `v-if`.



<template>
  <button @click="isVisible = !isVisible">
    Toggle
  </button>

  <AnimatePresence>
    <div
      v-if="isVisible"
      v-motion
      :initial="{ opacity: 0, scale: 0.5, rotate: -10 }"
      :animate="{ opacity: 1, scale: 1, rotate: 0 }"
      :exit="{ opacity: 0, scale: 0.5, rotate: 10 }"
      :transition="{ type: 'spring', duration: 0.5 }"
    >
      Toggle me
    </div>
  </AnimatePresence>
</template>

## [Presets](#presets)

`MotionPlugin` accepts a `presets` option to register custom preset directives. Each preset is automatically registered as a `v-{name}` global directive:

### [`MotionPlugin`](#motionplugin)

app.use(MotionPlugin, {
  presets: {
    'fade-in': {
      initial: { opacity: 0 },
      animate: { opacity: 1 },
      transition: { duration: 0.5 },
    },
    'slide-up': {
      initial: { opacity: 0, y: 40 },
      animate: { opacity: 1, y: 0 },
      transition: { duration: 0.5 },
    },
    'scale-in': {
      initial: { opacity: 0, scale: 0.5 },
      animate: { opacity: 1, scale: 1 },
      transition: { type: 'spring', stiffness: 300, damping: 20 },
    },
  },
})

### [Nuxt Module](#nuxt-module)

In `nuxt.config.ts`:

export default defineNuxtConfig({
  modules: ['motion-v/nuxt'],
  motionV: {
    directives: true, // globally register v-motion
    presets: {
      'fade-in': {
        initial: { opacity: 0 },
        animate: { opacity: 1 },
      },
    },
  },
})

Then use anywhere without imports:

<template>
  <div v-fade-in>
    Fade
  </div>
  
  <div v-slide-up>
    Slide
  </div>
  
  <div v-scale-in>
    Scale
  </div>
</template>

The `v-motion` directive provides a declarative way to add Motion animations to any HTML or SVG element without using wrapper components. It offers most of the powerful animation capabilities of the `[<motion/>](https://motion.dev/vue-motion-component)` component with a more traditional Vue directive syntax.

## [Install](#install)

### [Global registration (Vue)](#global-registration-(vue))

import { createApp } from 'vue'
import { MotionPlugin } from 'motion-v'

const app = createApp(App)
app.use(MotionPlugin)

### [Global registration (Nuxt)](#global-registration-(nuxt))

// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['motion-v/nuxt'],
  motionV: {
    directives: true,
  },
})

### [Local registration](#local-registration)



## [Syntax](#syntax)

### [Basic animation](#basic-animation)

<div v-motion :initial="{ opacity: 0 }" :animate="{ opacity: 1 }">
  Hello Motion
</div>

`v-motion` supports two syntax styles. You can also mix them: Element props take priority over the binding value.

### [Binding value](#binding-value)

Pass all options as a single object:

<div
  v-motion="{
    initial: { opacity: 0, x: -30 },
    animate: { opacity: 1, x: 0 },
    transition: { duration: 0.6 },
  }"
>
  Slide In
</div>

### [Props](#props)

Use `v-motion` as a marker and pass motion options as individual props:

<div
  v-motion
  :initial="{ opacity: 0, y: 30 }"
  :animate="{ opacity: 1, y: 0 }"
  :transition="{ duration: 0.6 }"
>
  Fade In
</div>

### [Mixed](#mixed)

When both are used, element props override binding value keys:


<div
  v-motion="{ initial: { opacity: 0.5 }, transition: { duration: 0.5 } }"
  :initial="{ opacity: 0.2 }"
>
  Props Win
</div>

## [Usage](#usage)

`v-motion` supports the same animation props as the `[<motion>](https://motion.dev/vue-motion-component)` component — `initial`, `animate`, `exit`, `transition`, gesture props (`whileHover`, `whilePress`, `whileFocus`, `whileInView`, `whileDrag`), and reactive bindings.

For detailed usage of these features, see the Animation.

## [Exit animation](#exit-animation)

Use `exit` with `[<AnimatePresence>](https://motion.dev/vue-animate-presence)` to animate elements out when they are removed with `v-if`.



<template>
  <button @click="isVisible = !isVisible">
    Toggle
  </button>

  <AnimatePresence>
    <div
      v-if="isVisible"
      v-motion
      :initial="{ opacity: 0, scale: 0.5, rotate: -10 }"
      :animate="{ opacity: 1, scale: 1, rotate: 0 }"
      :exit="{ opacity: 0, scale: 0.5, rotate: 10 }"
      :transition="{ type: 'spring', duration: 0.5 }"
    >
      Toggle me
    </div>
  </AnimatePresence>
</template>

## [Presets](#presets)

`MotionPlugin` accepts a `presets` option to register custom preset directives. Each preset is automatically registered as a `v-{name}` global directive:

### [`MotionPlugin`](#motionplugin)

app.use(MotionPlugin, {
  presets: {
    'fade-in': {
      initial: { opacity: 0 },
      animate: { opacity: 1 },
      transition: { duration: 0.5 },
    },
    'slide-up': {
      initial: { opacity: 0, y: 40 },
      animate: { opacity: 1, y: 0 },
      transition: { duration: 0.5 },
    },
    'scale-in': {
      initial: { opacity: 0, scale: 0.5 },
      animate: { opacity: 1, scale: 1 },
      transition: { type: 'spring', stiffness: 300, damping: 20 },
    },
  },
})

### [Nuxt Module](#nuxt-module)

In `nuxt.config.ts`:

export default defineNuxtConfig({
  modules: ['motion-v/nuxt'],
  motionV: {
    directives: true, // globally register v-motion
    presets: {
      'fade-in': {
        initial: { opacity: 0 },
        animate: { opacity: 1 },
      },
    },
  },
})

Then use anywhere without imports:

<template>
  <div v-fade-in>
    Fade
  </div>
  
  <div v-slide-up>
    Slide
  </div>
  
  <div v-scale-in>
    Scale
  </div>
</template>

Previous

Vue animation

Next

Gesture animation

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

12.37.0

Motion+

Login

Register

Upgrade

##### Stay in the loop

Subscribe for the latest news & updates.



Latest version:

12.37.0

Motion+

Login

Register

Upgrade

##### Stay in the loop

Subscribe for the latest news & updates.



Latest version:

12.37.0

Motion+

Login

Register

Upgrade