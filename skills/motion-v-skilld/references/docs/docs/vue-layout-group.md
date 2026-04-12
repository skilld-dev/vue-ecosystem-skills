LayoutGroup — Coordinate Vue layout animations | Motion

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

# LayoutGroup

`[motion](https://motion.dev/vue-motion-component)` componentswith a `layout` prop will detect and animate layout changes every time they commit a Vue re-render, or their `layoutDependency` prop changes.

`LayoutGroup` is used to group components that might not render together but do affect each-other's state.

## [Usage](#usage)

Take these accordion items that each handle their own state:


<template>
  <motion.div
      layout
      @click="isOpen=!isOpen"
    >
      <motion.h2 layout>{{header}}</motion.h2>
      {{isOpen ? content : null}}
    </motion.div>
</template>

If we arrange these next to each other in an `Accordion`, when their state updates, their siblings have no way of knowing:


<template>
  <ToggleContent />
  <ToggleContent />
</template>

This can be fixed by grouping both components with `LayoutGroup`:


<template>
  <LayoutGroup>
    <ToggleContent />
    <ToggleContent />
  </LayoutGroup>
</template>

### [Namespace `layoutId`](#namespace-layoutid)

Components expecting to perform shared layout animations are provided a `layoutId` prop.

In this following example, each `Tab` renders an element with the `layoutId="underline"` prop.


<template>
  <li>
      {{label}}
      <motion.div v-if="isSelected" layoutId="underline" />
    </li> 
</template>


<template>
  <Tab v-for="item in items" :key="item.id" v-bind="item"/>
</template>

`layoutId` is global across your site. So to render multiple `TabRow`s we want to group them with `LayoutGroup` and `id` prop:


<template>
  <LayoutGroup :id="id">
    <Tab v-for="item in items" :key="item.id" v-bind="item"/>
  </LayoutGroup>
</template>

`[motion](https://motion.dev/vue-motion-component)` componentswith a `layout` prop will detect and animate layout changes every time they commit a Vue re-render, or their `layoutDependency` prop changes.

`LayoutGroup` is used to group components that might not render together but do affect each-other's state.

## [Usage](#usage)

Take these accordion items that each handle their own state:


<template>
  <motion.div
      layout
      @click="isOpen=!isOpen"
    >
      <motion.h2 layout>{{header}}</motion.h2>
      {{isOpen ? content : null}}
    </motion.div>
</template>

If we arrange these next to each other in an `Accordion`, when their state updates, their siblings have no way of knowing:


<template>
  <ToggleContent />
  <ToggleContent />
</template>

This can be fixed by grouping both components with `LayoutGroup`:


<template>
  <LayoutGroup>
    <ToggleContent />
    <ToggleContent />
  </LayoutGroup>
</template>

### [Namespace `layoutId`](#namespace-layoutid)

Components expecting to perform shared layout animations are provided a `layoutId` prop.

In this following example, each `Tab` renders an element with the `layoutId="underline"` prop.


<template>
  <li>
      {{label}}
      <motion.div v-if="isSelected" layoutId="underline" />
    </li> 
</template>


<template>
  <Tab v-for="item in items" :key="item.id" v-bind="item"/>
</template>

`layoutId` is global across your site. So to render multiple `TabRow`s we want to group them with `LayoutGroup` and `id` prop:


<template>
  <LayoutGroup :id="id">
    <Tab v-for="item in items" :key="item.id" v-bind="item"/>
  </LayoutGroup>
</template>

`[motion](https://motion.dev/vue-motion-component)` componentswith a `layout` prop will detect and animate layout changes every time they commit a Vue re-render, or their `layoutDependency` prop changes.

`LayoutGroup` is used to group components that might not render together but do affect each-other's state.

## [Usage](#usage)

Take these accordion items that each handle their own state:


<template>
  <motion.div
      layout
      @click="isOpen=!isOpen"
    >
      <motion.h2 layout>{{header}}</motion.h2>
      {{isOpen ? content : null}}
    </motion.div>
</template>

If we arrange these next to each other in an `Accordion`, when their state updates, their siblings have no way of knowing:


<template>
  <ToggleContent />
  <ToggleContent />
</template>

This can be fixed by grouping both components with `LayoutGroup`:


<template>
  <LayoutGroup>
    <ToggleContent />
    <ToggleContent />
  </LayoutGroup>
</template>

### [Namespace `layoutId`](#namespace-layoutid)

Components expecting to perform shared layout animations are provided a `layoutId` prop.

In this following example, each `Tab` renders an element with the `layoutId="underline"` prop.


<template>
  <li>
      {{label}}
      <motion.div v-if="isSelected" layoutId="underline" />
    </li> 
</template>


<template>
  <Tab v-for="item in items" :key="item.id" v-bind="item"/>
</template>

`layoutId` is global across your site. So to render multiple `TabRow`s we want to group them with `LayoutGroup` and `id` prop:


<template>
  <LayoutGroup :id="id">
    <Tab v-for="item in items" :key="item.id" v-bind="item"/>
  </LayoutGroup>
</template>

Previous

Typewriter

Next

LazyMotion

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