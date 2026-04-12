useScroll — Vue scroll animations | Motion

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

# useScroll

`useScroll` is used to create scroll-linked animations, like progress indicators and parallax effects.



<template>
 <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

`useScroll` is able to run some animations with the browser's `[ScrollTimeline](https://developer.mozilla.org/en-US/docs/Web/API/ScrollTimeline)` API for optimal hardware-accelerated performance, removing scroll measurements, improving scroll synchronisation and ensuring animations remain smooth even under heavy CPI usage.

## [Usage](#usage)

Import `useScroll` from Motion for Vue:

import { useScroll } from "motion-v"

`useScroll` returns four motion values:

- `scrollX`/`Y`: The absolute scroll position, in pixels.
- `scrollXProgress`/`YProgress`: The scroll position between the defined offsets, as a value between `0` and `1`.

### [Page scroll](#page-scroll)

By default, useScroll tracks the page scroll.

const { scrollY } = useScroll()

useMotionValueEvent(scrollY, "change", (latest) => {
  console.log("Page scroll: ", latest)
})

For example, we could show a page scroll indicator by passing `scrollYProgress` straight to the `scaleX` style of a progress bar.



<template>
   <motion.div :style="{ scaleX: scrollYProgress }" />
</template>

As `useScroll` returns motion values, we can compose this scroll info with other motion value hooks like `useTransform` and `useSpring`:



<template>
  <Motion :style="{ scaleX }" />
</template>

> Since `scrollY` is a `MotionValue`, there's a neat trick you can use to tell when the user's scroll direction changes:Perfect for triggering a sticky header animation!
>
> ~ Sam Selikoff, Motion for React Recipes
### [Element scroll](#element-scroll)

To track the scroll position of a scrollable element we can pass the element's `ref` to `useScroll`'s `container` option:



<template>
  <div ref="carouselRef" style="overflow: scroll">
    <slot />
  </div>
</template>

### [Element position](#element-position)

We can track the progress of an element as it moves within a container by passing its `ref` to the `target` option.



<template>
  <div ref="ref"/>
</template>

In this example, each item has its own progress indicator.

### [Scroll offsets](#scroll-offsets)

With the`[offset](https://motion.dev/vue-use-scroll#offset)` option we can define which parts of the element we want to track with the viewport, for instance track elements as they enter in from the bottom, leave at the top, or travel throughout the whole viewport.

## [API](#api)

`useScroll` accepts the following options.

### [`container`](#container)

**Default**: Browser window

The scrollable container to track the scroll position of. By default, this is the window viewport. But it can be any scrollable element.

### [`target`](#target)

By default, this is the scrollable area of the container. It can additionally be set as another element, to track its progress within the viewport.

### [`axis`](#axis)

**Default:**`"y"`

The scroll axis to apply `offset`.

### [`offset`](#offset)

**Default:** `["start start", "end end"]`

`offset` describes intersections, points where the `target` and `container` meet.

For example, the intersection `"start end"` means when the **start of the target** on the tracked axis meets the **end of the container.**

So if the target is an element, the container is the window, and we're tracking the vertical axis then `"start end"` is where the **top of the element** meets **the bottom of the viewport**.

#### [Accepted intersections](#accepted-intersections)

Both target and container points can be defined as:

- **Number:** A value where `0` represents the start of the axis and `1` represents the end. So to define the top of the target with the middle of the container you could define `"0 0.5"`. Values outside this range are permitted.
- **Names:** `"start"`, `"center"` and `"end"` can be used as clear shortcuts for `0`, `0.5` and `1` respectively.
- **Pixels:** Pixel values like `"100px"`, `"-50px"` will be defined as that number of pixels from the start of the target/container.
- **Percent:** Same as raw numbers but expressed as `"0%"` to `"100%"`.
- **Viewport:** `"vh"` and `"vw"` units are accepted.

### [`trackContentSize`](#trackcontentsize)

**Default:** `false`

When the size of a page or element's content changes, its scrollable area can change too. But, because browsers don't provide a callback for changes in content size, by default `useScroll()` will not update until the next `"scroll"` event.

Content size tracking is disabled by default because most of the time, scrollable area remains stable, and tracking changes to it involves a small overhead.

`useScroll` can automatically track changes to content size by setting `trackContentSize` to `true`.

useScroll({ trackContentSize: true })

`useScroll` is used to create scroll-linked animations, like progress indicators and parallax effects.



<template>
 <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

`useScroll` is able to run some animations with the browser's `[ScrollTimeline](https://developer.mozilla.org/en-US/docs/Web/API/ScrollTimeline)` API for optimal hardware-accelerated performance, removing scroll measurements, improving scroll synchronisation and ensuring animations remain smooth even under heavy CPI usage.

## [Usage](#usage)

Import `useScroll` from Motion for Vue:

import { useScroll } from "motion-v"

`useScroll` returns four motion values:

- `scrollX`/`Y`: The absolute scroll position, in pixels.
- `scrollXProgress`/`YProgress`: The scroll position between the defined offsets, as a value between `0` and `1`.

### [Page scroll](#page-scroll)

By default, useScroll tracks the page scroll.

const { scrollY } = useScroll()

useMotionValueEvent(scrollY, "change", (latest) => {
  console.log("Page scroll: ", latest)
})

For example, we could show a page scroll indicator by passing `scrollYProgress` straight to the `scaleX` style of a progress bar.



<template>
   <motion.div :style="{ scaleX: scrollYProgress }" />
</template>

As `useScroll` returns motion values, we can compose this scroll info with other motion value hooks like `useTransform` and `useSpring`:



<template>
  <Motion :style="{ scaleX }" />
</template>

> Since `scrollY` is a `MotionValue`, there's a neat trick you can use to tell when the user's scroll direction changes:Perfect for triggering a sticky header animation!
>
> ~ Sam Selikoff, Motion for React Recipes
### [Element scroll](#element-scroll)

To track the scroll position of a scrollable element we can pass the element's `ref` to `useScroll`'s `container` option:



<template>
  <div ref="carouselRef" style="overflow: scroll">
    <slot />
  </div>
</template>

### [Element position](#element-position)

We can track the progress of an element as it moves within a container by passing its `ref` to the `target` option.



<template>
  <div ref="ref"/>
</template>

In this example, each item has its own progress indicator.

### [Scroll offsets](#scroll-offsets)

With the`[offset](https://motion.dev/vue-use-scroll#offset)` option we can define which parts of the element we want to track with the viewport, for instance track elements as they enter in from the bottom, leave at the top, or travel throughout the whole viewport.

## [API](#api)

`useScroll` accepts the following options.

### [`container`](#container)

**Default**: Browser window

The scrollable container to track the scroll position of. By default, this is the window viewport. But it can be any scrollable element.

### [`target`](#target)

By default, this is the scrollable area of the container. It can additionally be set as another element, to track its progress within the viewport.

### [`axis`](#axis)

**Default:**`"y"`

The scroll axis to apply `offset`.

### [`offset`](#offset)

**Default:** `["start start", "end end"]`

`offset` describes intersections, points where the `target` and `container` meet.

For example, the intersection `"start end"` means when the **start of the target** on the tracked axis meets the **end of the container.**

So if the target is an element, the container is the window, and we're tracking the vertical axis then `"start end"` is where the **top of the element** meets **the bottom of the viewport**.

#### [Accepted intersections](#accepted-intersections)

Both target and container points can be defined as:

- **Number:** A value where `0` represents the start of the axis and `1` represents the end. So to define the top of the target with the middle of the container you could define `"0 0.5"`. Values outside this range are permitted.
- **Names:** `"start"`, `"center"` and `"end"` can be used as clear shortcuts for `0`, `0.5` and `1` respectively.
- **Pixels:** Pixel values like `"100px"`, `"-50px"` will be defined as that number of pixels from the start of the target/container.
- **Percent:** Same as raw numbers but expressed as `"0%"` to `"100%"`.
- **Viewport:** `"vh"` and `"vw"` units are accepted.

### [`trackContentSize`](#trackcontentsize)

**Default:** `false`

When the size of a page or element's content changes, its scrollable area can change too. But, because browsers don't provide a callback for changes in content size, by default `useScroll()` will not update until the next `"scroll"` event.

Content size tracking is disabled by default because most of the time, scrollable area remains stable, and tracking changes to it involves a small overhead.

`useScroll` can automatically track changes to content size by setting `trackContentSize` to `true`.

useScroll({ trackContentSize: true })

`useScroll` is used to create scroll-linked animations, like progress indicators and parallax effects.



<template>
 <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

`useScroll` is able to run some animations with the browser's `[ScrollTimeline](https://developer.mozilla.org/en-US/docs/Web/API/ScrollTimeline)` API for optimal hardware-accelerated performance, removing scroll measurements, improving scroll synchronisation and ensuring animations remain smooth even under heavy CPI usage.

## [Usage](#usage)

Import `useScroll` from Motion for Vue:

import { useScroll } from "motion-v"

`useScroll` returns four motion values:

- `scrollX`/`Y`: The absolute scroll position, in pixels.
- `scrollXProgress`/`YProgress`: The scroll position between the defined offsets, as a value between `0` and `1`.

### [Page scroll](#page-scroll)

By default, useScroll tracks the page scroll.

const { scrollY } = useScroll()

useMotionValueEvent(scrollY, "change", (latest) => {
  console.log("Page scroll: ", latest)
})

For example, we could show a page scroll indicator by passing `scrollYProgress` straight to the `scaleX` style of a progress bar.



<template>
   <motion.div :style="{ scaleX: scrollYProgress }" />
</template>

As `useScroll` returns motion values, we can compose this scroll info with other motion value hooks like `useTransform` and `useSpring`:



<template>
  <Motion :style="{ scaleX }" />
</template>

> Since `scrollY` is a `MotionValue`, there's a neat trick you can use to tell when the user's scroll direction changes:Perfect for triggering a sticky header animation!
>
> ~ Sam Selikoff, Motion for React Recipes
### [Element scroll](#element-scroll)

To track the scroll position of a scrollable element we can pass the element's `ref` to `useScroll`'s `container` option:



<template>
  <div ref="carouselRef" style="overflow: scroll">
    <slot />
  </div>
</template>

### [Element position](#element-position)

We can track the progress of an element as it moves within a container by passing its `ref` to the `target` option.



<template>
  <div ref="ref"/>
</template>

In this example, each item has its own progress indicator.

### [Scroll offsets](#scroll-offsets)

With the`[offset](https://motion.dev/vue-use-scroll#offset)` option we can define which parts of the element we want to track with the viewport, for instance track elements as they enter in from the bottom, leave at the top, or travel throughout the whole viewport.

## [API](#api)

`useScroll` accepts the following options.

### [`container`](#container)

**Default**: Browser window

The scrollable container to track the scroll position of. By default, this is the window viewport. But it can be any scrollable element.

### [`target`](#target)

By default, this is the scrollable area of the container. It can additionally be set as another element, to track its progress within the viewport.

### [`axis`](#axis)

**Default:**`"y"`

The scroll axis to apply `offset`.

### [`offset`](#offset)

**Default:** `["start start", "end end"]`

`offset` describes intersections, points where the `target` and `container` meet.

For example, the intersection `"start end"` means when the **start of the target** on the tracked axis meets the **end of the container.**

So if the target is an element, the container is the window, and we're tracking the vertical axis then `"start end"` is where the **top of the element** meets **the bottom of the viewport**.

#### [Accepted intersections](#accepted-intersections)

Both target and container points can be defined as:

- **Number:** A value where `0` represents the start of the axis and `1` represents the end. So to define the top of the target with the middle of the container you could define `"0 0.5"`. Values outside this range are permitted.
- **Names:** `"start"`, `"center"` and `"end"` can be used as clear shortcuts for `0`, `0.5` and `1` respectively.
- **Pixels:** Pixel values like `"100px"`, `"-50px"` will be defined as that number of pixels from the start of the target/container.
- **Percent:** Same as raw numbers but expressed as `"0%"` to `"100%"`.
- **Viewport:** `"vh"` and `"vw"` units are accepted.

### [`trackContentSize`](#trackcontentsize)

**Default:** `false`

When the size of a page or element's content changes, its scrollable area can change too. But, because browsers don't provide a callback for changes in content size, by default `useScroll()` will not update until the next `"scroll"` event.

Content size tracking is disabled by default because most of the time, scrollable area remains stable, and tracking changes to it involves a small overhead.

`useScroll` can automatically track changes to content size by setting `trackContentSize` to `true`.

useScroll({ trackContentSize: true })

Previous

useMotionValueEvent

Next

useSpring

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