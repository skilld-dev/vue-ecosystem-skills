---
title: "useInView — Scroll-triggered Vue state | Motion"
meta:
  "og:description": "Use Motion for Vue's tiny useInView hook (0.6kb) to detect when elements enter the viewport. Track visibility, trigger effects &amp; customize detection easily."
  "og:title": "useInView — Scroll-triggered Vue state | Motion"
  "twitter:description": "Use Motion for Vue's tiny useInView hook (0.6kb) to detect when elements enter the viewport. Track visibility, trigger effects &amp; customize detection easily."
  "twitter:title": "useInView — Scroll-triggered Vue state | Motion"
  description: "Use Motion for Vue's tiny useInView hook (0.6kb) to detect when elements enter the viewport. Track visibility, trigger effects &amp; customize detection easily."
---

Vue

# useInView

`useInView` is a tiny (0.6kb) hook that detects when the provided element is within the viewport. It can be used with any Vue element.



<template>
  <div ref="domRef" />
</template>

## [Usage](#usage)

Import `useInView` from Motion:

import { useInView } from "motion-v"

`useInView` can track the visibility of any HTML element. Pass a `ref` object to both `useInView` and the HTML element.



<template>
  <div ref="domRef" />
</template>

While the element is outside the viewport, `useInView` will return `false`. When it moves inside the view, it'll re-render the component and return `true`.

### [Effects](#effects)

`useInView` is vanilla Vue ref state, so firing functions when `isInView` changes is a matter of passing it to a `watch`.



## [Options](#options)

`useInView` can accept options to define how the element is tracked within the viewport.

const isInView = useInView(domRef, { once: true })

### [`root`](#root)

By default, `useInView` will track the visibility of an element as it enters/leaves the window viewport. Set `root` to be the ref of a scrollable parent, and it'll use that element to be the viewport instead.



<template>
  <div ref="container" style="overflow: scroll">
    <div ref="boxRef" />
  </div>
</template>

### [`margin`](#margin)

**Default:**`"0px"`

A margin to add to the viewport to change the detection area. Use multiple values to adjust top/right/bottom/left, e.g. `"0px -20px 0px 100px"`.

const isInView = useInView({
  margin: "0px 100px -50px 0px"
})

**]Note:** For browser security reasons, `margin` won't take affect within cross-origin iframes unless `root` is explicitly defined.

### [`once`](#once)

**Default:**`false`

If `true`, once an element is in view, useInView will stop observing the element and always return `true`.

const isInView = useInView(ref, { once: true })

### [`initial`](#initial)

**Default:**`false`

Set an initial value to return until the element has been measured.

const isInView = useInView(ref, { initial: true })

### [`amount`](#amount)

**Default:** `"some"`

The amount of an element that should enter the viewport to be considered "entered". Either `"some"`, `"all"` or a number between `0` and `1`.

## [Example](#example)

`useInView` is a tiny (0.6kb) hook that detects when the provided element is within the viewport. It can be used with any Vue element.



<template>
  <div ref="domRef" />
</template>

## [Usage](#usage)

Import `useInView` from Motion:

import { useInView } from "motion-v"

`useInView` can track the visibility of any HTML element. Pass a `ref` object to both `useInView` and the HTML element.



<template>
  <div ref="domRef" />
</template>

While the element is outside the viewport, `useInView` will return `false`. When it moves inside the view, it'll re-render the component and return `true`.

### [Effects](#effects)

`useInView` is vanilla Vue ref state, so firing functions when `isInView` changes is a matter of passing it to a `watch`.



## [Options](#options)

`useInView` can accept options to define how the element is tracked within the viewport.

const isInView = useInView(domRef, { once: true })

### [`root`](#root)

By default, `useInView` will track the visibility of an element as it enters/leaves the window viewport. Set `root` to be the ref of a scrollable parent, and it'll use that element to be the viewport instead.



<template>
  <div ref="container" style="overflow: scroll">
    <div ref="boxRef" />
  </div>
</template>

### [`margin`](#margin)

**Default:**`"0px"`

A margin to add to the viewport to change the detection area. Use multiple values to adjust top/right/bottom/left, e.g. `"0px -20px 0px 100px"`.

const isInView = useInView({
  margin: "0px 100px -50px 0px"
})

**]Note:** For browser security reasons, `margin` won't take affect within cross-origin iframes unless `root` is explicitly defined.

### [`once`](#once)

**Default:**`false`

If `true`, once an element is in view, useInView will stop observing the element and always return `true`.

const isInView = useInView(ref, { once: true })

### [`initial`](#initial)

**Default:**`false`

Set an initial value to return until the element has been measured.

const isInView = useInView(ref, { initial: true })

### [`amount`](#amount)

**Default:** `"some"`

The amount of an element that should enter the viewport to be considered "entered". Either `"some"`, `"all"` or a number between `0` and `1`.

## [Example](#example)

`useInView` is a tiny (0.6kb) hook that detects when the provided element is within the viewport. It can be used with any Vue element.



<template>
  <div ref="domRef" />
</template>

## [Usage](#usage)

Import `useInView` from Motion:

import { useInView } from "motion-v"

`useInView` can track the visibility of any HTML element. Pass a `ref` object to both `useInView` and the HTML element.



<template>
  <div ref="domRef" />
</template>

While the element is outside the viewport, `useInView` will return `false`. When it moves inside the view, it'll re-render the component and return `true`.

### [Effects](#effects)

`useInView` is vanilla Vue ref state, so firing functions when `isInView` changes is a matter of passing it to a `watch`.



## [Options](#options)

`useInView` can accept options to define how the element is tracked within the viewport.

const isInView = useInView(domRef, { once: true })

### [`root`](#root)

By default, `useInView` will track the visibility of an element as it enters/leaves the window viewport. Set `root` to be the ref of a scrollable parent, and it'll use that element to be the viewport instead.



<template>
  <div ref="container" style="overflow: scroll">
    <div ref="boxRef" />
  </div>
</template>

### [`margin`](#margin)

**Default:**`"0px"`

A margin to add to the viewport to change the detection area. Use multiple values to adjust top/right/bottom/left, e.g. `"0px -20px 0px 100px"`.

const isInView = useInView({
  margin: "0px 100px -50px 0px"
})

**]Note:** For browser security reasons, `margin` won't take affect within cross-origin iframes unless `root` is explicitly defined.

### [`once`](#once)

**Default:**`false`

If `true`, once an element is in view, useInView will stop observing the element and always return `true`.

const isInView = useInView(ref, { once: true })

### [`initial`](#initial)

**Default:**`false`

Set an initial value to return until the element has been measured.

const isInView = useInView(ref, { initial: true })

### [`amount`](#amount)

**Default:** `"some"`

The amount of an element that should enter the viewport to be considered "entered". Either `"some"`, `"all"` or a number between `0` and `1`.

## [Example](#example)

Previous

useDragControls

Next

useReducedMotion

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