---
title: "Integration Motion for Vue with Reka | Motion"
meta:
  "og:description": "Integrate Motion with Reka-UI for stunning animations. Learn to animate Reka primitives, use AnimatePresence for smooth exits, &amp; animate Tooltip, Toast &amp; more."
  "og:title": "Integration Motion for Vue with Reka | Motion"
  "twitter:description": "Integrate Motion with Reka-UI for stunning animations. Learn to animate Reka primitives, use AnimatePresence for smooth exits, &amp; animate Tooltip, Toast &amp; more."
  "twitter:title": "Integration Motion for Vue with Reka | Motion"
  description: "Integrate Motion with Reka-UI for stunning animations. Learn to animate Reka primitives, use AnimatePresence for smooth exits, &amp; animate Tooltip, Toast &amp; more."
---

Vue

# Integrate Motion with Reka

Reka-UI is one of the most popular component libraries for Vue, and it takes just a couple steps to use Motion for Vue for animations.

In this guide, we'll learn how to use `[motion](https://motion.dev/vue-motion-component)` components with Reka primitives, as well as specific setups for exit and layout animations.

## [Setup `motion` components](#setup-motion-components)

Most Reka components render and control their own DOM elements. But they also provide the`[asChild](https://reka-ui.com/docs/guides/composition#composition)` prop that, when set to `true`, will make the component use the first provided child as its DOM node instead.

By passing a `[motion](https://motion.dev/react-motion-component)` component as this child, we can now use all of its animation props as normal:

<template>
  <ToastRoot :as-child="true">
    <Motion
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      layout
    >

## [Exit animations](#exit-animations)

Many Reka components, like Toast or Tooltip, would be perfect for exit animations, but can't perform them without Motion's `[AnimatePresence](https://motion.dev/vue-animate-presence)`.

`AnimatePresence` is built on top of Vue's Transition component,This is how it tracks which components are exiting:

<template>
  <AnimatePresence>
    <Motion
      v-if="isOpen"
      :exit="{ opacity: 0 }"
    />
  </AnimatePresence>
</template>

Using exit animations with Motion Vue and Reka components is straightforward. Just wrap your unmounting component with `AnimatePresence`, and it can detect the direct child DOM unmounting and trigger exit animations.

For example, works with the Tooltip component：

<Tooltip.Provider>
        <Tooltip.Root>
          <Tooltip.Trigger class="tooltip-trigger">
              Hover or focus
          </Tooltip.Trigger>
          <Tooltip.Portal>
            <AnimatePresence>
              <Tooltip.Content as-child :side-offset="10">
                <motion.div
                  class="tooltip-content"
                  :initial="{ opacity: 0, y: 20, scale: 0.8 }"
                  :animate="{ opacity: 1, y: 0, scale: 1 }"
                  :exit="{ opacity: 0,y: 20,}"
                >
                  Add to library
                  <Tooltip.Arrow class="tooltip-arrow" />
                </motion.div>
              </Tooltip.Content>
            </AnimatePresence>
          </Tooltip.Portal>
        </Tooltip.Root>
  </Tooltip.Provider>

## [Layout animations](#layout-animations)

Layout animations also require this same pattern of hoisting state out of the component.



<template>
  <Tabs.Root 
    v-model="tab" 
    as-child
  >
    <motion.div layout>

This is to ensure `motion` components know to perform layout animations when the state changes. You can even pass this state to `layoutDependency` for better performance.

<motion.div layout :layoutDependency="tab">

## [Motion+ examples](#motion-examples)

Motion+ is a one-time payment, lifetime membership that gains you access to the source code of an ever-growing library of examples, as well as premium components like `[Cursor](https://motion.dev/vue-cursor)` and `[AnimateNumber](https://motion.dev/vue-animate-number)`.

Motion+ features examples for most Reka components:

- Accordion
- Checkbox
- Context Menu
- Dialog
- Dropdown Menu
- Progress
- Radio Group
- Select
- Slider
- Switch
- Tabs
- Toast
- Toggle Group
- Toolbar
- Tooltip

Reka-UI is one of the most popular component libraries for Vue, and it takes just a couple steps to use Motion for Vue for animations.

In this guide, we'll learn how to use `[motion](https://motion.dev/vue-motion-component)` components with Reka primitives, as well as specific setups for exit and layout animations.

## [Setup `motion` components](#setup-motion-components)

Most Reka components render and control their own DOM elements. But they also provide the`[asChild](https://reka-ui.com/docs/guides/composition#composition)` prop that, when set to `true`, will make the component use the first provided child as its DOM node instead.

By passing a `[motion](https://motion.dev/react-motion-component)` component as this child, we can now use all of its animation props as normal:

<template>
  <ToastRoot :as-child="true">
    <Motion
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      layout
    >

## [Exit animations](#exit-animations)

Many Reka components, like Toast or Tooltip, would be perfect for exit animations, but can't perform them without Motion's `[AnimatePresence](https://motion.dev/vue-animate-presence)`.

`AnimatePresence` is built on top of Vue's Transition component,This is how it tracks which components are exiting:

<template>
  <AnimatePresence>
    <Motion
      v-if="isOpen"
      :exit="{ opacity: 0 }"
    />
  </AnimatePresence>
</template>

Using exit animations with Motion Vue and Reka components is straightforward. Just wrap your unmounting component with `AnimatePresence`, and it can detect the direct child DOM unmounting and trigger exit animations.

For example, works with the Tooltip component：

<Tooltip.Provider>
        <Tooltip.Root>
          <Tooltip.Trigger class="tooltip-trigger">
              Hover or focus
          </Tooltip.Trigger>
          <Tooltip.Portal>
            <AnimatePresence>
              <Tooltip.Content as-child :side-offset="10">
                <motion.div
                  class="tooltip-content"
                  :initial="{ opacity: 0, y: 20, scale: 0.8 }"
                  :animate="{ opacity: 1, y: 0, scale: 1 }"
                  :exit="{ opacity: 0,y: 20,}"
                >
                  Add to library
                  <Tooltip.Arrow class="tooltip-arrow" />
                </motion.div>
              </Tooltip.Content>
            </AnimatePresence>
          </Tooltip.Portal>
        </Tooltip.Root>
  </Tooltip.Provider>

## [Layout animations](#layout-animations)

Layout animations also require this same pattern of hoisting state out of the component.



<template>
  <Tabs.Root 
    v-model="tab" 
    as-child
  >
    <motion.div layout>

This is to ensure `motion` components know to perform layout animations when the state changes. You can even pass this state to `layoutDependency` for better performance.

<motion.div layout :layoutDependency="tab">

## [Motion+ examples](#motion-examples)

Motion+ is a one-time payment, lifetime membership that gains you access to the source code of an ever-growing library of examples, as well as premium components like `[Cursor](https://motion.dev/vue-cursor)` and `[AnimateNumber](https://motion.dev/vue-animate-number)`.

Motion+ features examples for most Reka components:

- Accordion
- Checkbox
- Context Menu
- Dialog
- Dropdown Menu
- Progress
- Radio Group
- Select
- Slider
- Switch
- Tabs
- Toast
- Toggle Group
- Toolbar
- Tooltip

Reka-UI is one of the most popular component libraries for Vue, and it takes just a couple steps to use Motion for Vue for animations.

In this guide, we'll learn how to use `[motion](https://motion.dev/vue-motion-component)` components with Reka primitives, as well as specific setups for exit and layout animations.

## [Setup `motion` components](#setup-motion-components)

Most Reka components render and control their own DOM elements. But they also provide the`[asChild](https://reka-ui.com/docs/guides/composition#composition)` prop that, when set to `true`, will make the component use the first provided child as its DOM node instead.

By passing a `[motion](https://motion.dev/react-motion-component)` component as this child, we can now use all of its animation props as normal:

<template>
  <ToastRoot :as-child="true">
    <Motion
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      layout
    >

## [Exit animations](#exit-animations)

Many Reka components, like Toast or Tooltip, would be perfect for exit animations, but can't perform them without Motion's `[AnimatePresence](https://motion.dev/vue-animate-presence)`.

`AnimatePresence` is built on top of Vue's Transition component,This is how it tracks which components are exiting:

<template>
  <AnimatePresence>
    <Motion
      v-if="isOpen"
      :exit="{ opacity: 0 }"
    />
  </AnimatePresence>
</template>

Using exit animations with Motion Vue and Reka components is straightforward. Just wrap your unmounting component with `AnimatePresence`, and it can detect the direct child DOM unmounting and trigger exit animations.

For example, works with the Tooltip component：

<Tooltip.Provider>
        <Tooltip.Root>
          <Tooltip.Trigger class="tooltip-trigger">
              Hover or focus
          </Tooltip.Trigger>
          <Tooltip.Portal>
            <AnimatePresence>
              <Tooltip.Content as-child :side-offset="10">
                <motion.div
                  class="tooltip-content"
                  :initial="{ opacity: 0, y: 20, scale: 0.8 }"
                  :animate="{ opacity: 1, y: 0, scale: 1 }"
                  :exit="{ opacity: 0,y: 20,}"
                >
                  Add to library
                  <Tooltip.Arrow class="tooltip-arrow" />
                </motion.div>
              </Tooltip.Content>
            </AnimatePresence>
          </Tooltip.Portal>
        </Tooltip.Root>
  </Tooltip.Provider>

## [Layout animations](#layout-animations)

Layout animations also require this same pattern of hoisting state out of the component.



<template>
  <Tabs.Root 
    v-model="tab" 
    as-child
  >
    <motion.div layout>

This is to ensure `motion` components know to perform layout animations when the state changes. You can even pass this state to `layoutDependency` for better performance.

<motion.div layout :layoutDependency="tab">

## [Motion+ examples](#motion-examples)

Motion+ is a one-time payment, lifetime membership that gains you access to the source code of an ever-growing library of examples, as well as premium components like `[Cursor](https://motion.dev/vue-cursor)` and `[AnimateNumber](https://motion.dev/vue-animate-number)`.

Motion+ features examples for most Reka components:

- Accordion
- Checkbox
- Context Menu
- Dialog
- Dropdown Menu
- Progress
- Radio Group
- Select
- Slider
- Switch
- Tabs
- Toast
- Toggle Group
- Toolbar
- Tooltip

Previous

useReducedMotion

Next

Get started with Motion for React

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