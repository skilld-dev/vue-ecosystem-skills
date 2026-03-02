---
title: "useScroll — Vue scroll animations | Motion"
meta:
  "og:description": "Create Vue scroll-linked animations like progress bars &amp; parallax with Motion for Vue's useScroll hook. Track scroll, element position &amp; use motion values."
  "og:title": "useScroll — Vue scroll animations | Motion"
  "twitter:description": "Create Vue scroll-linked animations like progress bars &amp; parallax with Motion for Vue's useScroll hook. Track scroll, element position &amp; use motion values."
  "twitter:title": "useScroll — Vue scroll animations | Motion"
  description: "Create Vue scroll-linked animations like progress bars &amp; parallax with Motion for Vue's useScroll hook. Track scroll, element position &amp; use motion values."
---

Vue

# useScroll

`useScroll` is used to create scroll-linked animations, like progress indicators and parallax effects.



<template>
 <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

## [Usage](#usage)

Import `useScroll` from Motion:

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

> Since `scrollY` is a `MotionValue`, there's a neat trick you can use to tell when the user's scroll direction changes:Perfect for triggering a sticky header animation! ~ Sam Selikoff, Motion for React Recipes

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

`useScroll` is used to create scroll-linked animations, like progress indicators and parallax effects.



<template>
 <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

## [Usage](#usage)

Import `useScroll` from Motion:

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

> Since `scrollY` is a `MotionValue`, there's a neat trick you can use to tell when the user's scroll direction changes:Perfect for triggering a sticky header animation! ~ Sam Selikoff, Motion for React Recipes

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

`useScroll` is used to create scroll-linked animations, like progress indicators and parallax effects.



<template>
 <motion.div :style="{ scaleX: scrollYProgress }" />  
</template>

## [Usage](#usage)

Import `useScroll` from Motion:

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

> Since `scrollY` is a `MotionValue`, there's a neat trick you can use to tell when the user's scroll direction changes:Perfect for triggering a sticky header animation! ~ Sam Selikoff, Motion for React Recipes

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