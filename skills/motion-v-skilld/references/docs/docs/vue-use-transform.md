---
title: "useTransform — Compose motion values in Vue | Motion"
meta:
  "og:description": "Discover Motion for Vue's useTransform hook. Create new motion values by transforming others. Learn to map ranges &amp; use clamp, ease, mixer for advanced control."
  "og:title": "useTransform — Compose motion values in Vue | Motion"
  "twitter:description": "Discover Motion for Vue's useTransform hook. Create new motion values by transforming others. Learn to map ranges &amp; use clamp, ease, mixer for advanced control."
  "twitter:title": "useTransform — Compose motion values in Vue | Motion"
  description: "Discover Motion for Vue's useTransform hook. Create new motion values by transforming others. Learn to map ranges &amp; use clamp, ease, mixer for advanced control."
---

Vue

# useTransform

`useTransform` creates a new motion value that transforms the output of one or more motion values.

const x = useMotionValue(1)
const y = useMotionValue(1)

const z = useTransform(() => x.get() + y.get()) // z.get() === 2

## [Usage](#usage)

Import from Motion:

import { useTransform } from "motion-v"

`useTransform` can be used in two ways: with a transform function and via value maps:

// Transform function
const doubledX = useTransform(() => x.get() * 2)

// Value mapping
const color = useTransform(x, [0, 100], ["#f00", "00f"])

### [Transform function](#transform-function)

A transform function is a normal function that returns a value.

const doubledX = useTransform(() => x.get() * 2)

Any motion values read in this function via the `get()` method will be automatically subscribed to.

When these motion values change, the function will be run again on the next animation frame to calculate a new value.

const distance = 100
const time = useTime()
const y = useTransform(() => Math.sin(time.get() / 1000) * distance)

### [Value mapping](#value-mapping)

`useTransform` can also map a single motion value from one range of values to another.

To illustrate, look at this `x` motion value:

const x = useMotionValue(0)

We can use `useTransform` to create a new motion value called `opacity`.

const opacity = useTransform(x, input, output)

By defining an `input` range and an `output` range, we can define relationships like "when `x` is `0`, `opacity` should be `1`. When `x` is `100` pixels either side, `opacity` should be `0`".

const input = [-100, 0, 100]
const output = [0, 1, 0]

Both ranges can be **any length** but must be the **same length** as each other.

The input range must always be a series of increasing or decreasing numbers.

The output range must be values all of the same type, but can be in any order. It can also be any value type that Motion can animate, like numbers, units, colors and other strings.

const backgroundColor = useTransform(
  x,
  [0, 100],
  ["#f00", "#00f"]
)

By setting `clamp: false`, the ranges will map perpetually. For instance, in this example we're saying "for every `100px` scrolled, rotate another `360deg`":

const { scrollY } = useScroll()
const rotate = useTransform(
  scrollY,
  [0, 100],
  [0, 360],
  { clamp: false }
)

#### [Output multiple values](#output-multiple-values)

It's common to map a single motion value and input range into multiple motion values.

const opacity = useTransform(offset, [100, 600], [1, 0.4])
const scale = useTransform(offset, [100, 600], [1, 0.6])
const filter = useTransform(offset, [100, 600], ["blur(0px)", "blur(10px)"])

This can lead to some repetition, so `useTransform` also supports mapping to multiple motion values in a single call, by providing a named map:

const { opacity, scale, filter } = useTransform(offset, [100, 600], {
  opacity: [1, 0.4],
  scale: [1, 0.6],
  filter: ["blur(0px)", "blur(10px)"],
})

## [Options](#options)

With value mapping, we can set some additional options.

### [`clamp`](#clamp)

**Default:** `true`

If `true`, will clamp output to within the provided range. If `false`, will carry on mapping even when the input falls outside the provided range.



### [`ease`](#ease)

An easing function, or array of easing functions, to ease the mixing between each value.

These must be JavaScript functions.



### [`mixer`](#mixer)

A function to use to mix between each pair of output values.

This function will be called with each pair of output values and must return a new function, that accepts a progress value between `0` and `1` and returns the mixed value.

This can be used to inject more advanced mixers than Framer Motion's default, for instance Flubber for morphing SVG paths.

`useTransform` creates a new motion value that transforms the output of one or more motion values.

const x = useMotionValue(1)
const y = useMotionValue(1)

const z = useTransform(() => x.get() + y.get()) // z.get() === 2

## [Usage](#usage)

Import from Motion:

import { useTransform } from "motion-v"

`useTransform` can be used in two ways: with a transform function and via value maps:

// Transform function
const doubledX = useTransform(() => x.get() * 2)

// Value mapping
const color = useTransform(x, [0, 100], ["#f00", "00f"])

### [Transform function](#transform-function)

A transform function is a normal function that returns a value.

const doubledX = useTransform(() => x.get() * 2)

Any motion values read in this function via the `get()` method will be automatically subscribed to.

When these motion values change, the function will be run again on the next animation frame to calculate a new value.

const distance = 100
const time = useTime()
const y = useTransform(() => Math.sin(time.get() / 1000) * distance)

### [Value mapping](#value-mapping)

`useTransform` can also map a single motion value from one range of values to another.

To illustrate, look at this `x` motion value:

const x = useMotionValue(0)

We can use `useTransform` to create a new motion value called `opacity`.

const opacity = useTransform(x, input, output)

By defining an `input` range and an `output` range, we can define relationships like "when `x` is `0`, `opacity` should be `1`. When `x` is `100` pixels either side, `opacity` should be `0`".

const input = [-100, 0, 100]
const output = [0, 1, 0]

Both ranges can be **any length** but must be the **same length** as each other.

The input range must always be a series of increasing or decreasing numbers.

The output range must be values all of the same type, but can be in any order. It can also be any value type that Motion can animate, like numbers, units, colors and other strings.

const backgroundColor = useTransform(
  x,
  [0, 100],
  ["#f00", "#00f"]
)

By setting `clamp: false`, the ranges will map perpetually. For instance, in this example we're saying "for every `100px` scrolled, rotate another `360deg`":

const { scrollY } = useScroll()
const rotate = useTransform(
  scrollY,
  [0, 100],
  [0, 360],
  { clamp: false }
)

#### [Output multiple values](#output-multiple-values)

It's common to map a single motion value and input range into multiple motion values.

const opacity = useTransform(offset, [100, 600], [1, 0.4])
const scale = useTransform(offset, [100, 600], [1, 0.6])
const filter = useTransform(offset, [100, 600], ["blur(0px)", "blur(10px)"])

This can lead to some repetition, so `useTransform` also supports mapping to multiple motion values in a single call, by providing a named map:

const { opacity, scale, filter } = useTransform(offset, [100, 600], {
  opacity: [1, 0.4],
  scale: [1, 0.6],
  filter: ["blur(0px)", "blur(10px)"],
})

## [Options](#options)

With value mapping, we can set some additional options.

### [`clamp`](#clamp)

**Default:** `true`

If `true`, will clamp output to within the provided range. If `false`, will carry on mapping even when the input falls outside the provided range.



### [`ease`](#ease)

An easing function, or array of easing functions, to ease the mixing between each value.

These must be JavaScript functions.



### [`mixer`](#mixer)

A function to use to mix between each pair of output values.

This function will be called with each pair of output values and must return a new function, that accepts a progress value between `0` and `1` and returns the mixed value.

This can be used to inject more advanced mixers than Framer Motion's default, for instance Flubber for morphing SVG paths.

`useTransform` creates a new motion value that transforms the output of one or more motion values.

const x = useMotionValue(1)
const y = useMotionValue(1)

const z = useTransform(() => x.get() + y.get()) // z.get() === 2

## [Usage](#usage)

Import from Motion:

import { useTransform } from "motion-v"

`useTransform` can be used in two ways: with a transform function and via value maps:

// Transform function
const doubledX = useTransform(() => x.get() * 2)

// Value mapping
const color = useTransform(x, [0, 100], ["#f00", "00f"])

### [Transform function](#transform-function)

A transform function is a normal function that returns a value.

const doubledX = useTransform(() => x.get() * 2)

Any motion values read in this function via the `get()` method will be automatically subscribed to.

When these motion values change, the function will be run again on the next animation frame to calculate a new value.

const distance = 100
const time = useTime()
const y = useTransform(() => Math.sin(time.get() / 1000) * distance)

### [Value mapping](#value-mapping)

`useTransform` can also map a single motion value from one range of values to another.

To illustrate, look at this `x` motion value:

const x = useMotionValue(0)

We can use `useTransform` to create a new motion value called `opacity`.

const opacity = useTransform(x, input, output)

By defining an `input` range and an `output` range, we can define relationships like "when `x` is `0`, `opacity` should be `1`. When `x` is `100` pixels either side, `opacity` should be `0`".

const input = [-100, 0, 100]
const output = [0, 1, 0]

Both ranges can be **any length** but must be the **same length** as each other.

The input range must always be a series of increasing or decreasing numbers.

The output range must be values all of the same type, but can be in any order. It can also be any value type that Motion can animate, like numbers, units, colors and other strings.

const backgroundColor = useTransform(
  x,
  [0, 100],
  ["#f00", "#00f"]
)

By setting `clamp: false`, the ranges will map perpetually. For instance, in this example we're saying "for every `100px` scrolled, rotate another `360deg`":

const { scrollY } = useScroll()
const rotate = useTransform(
  scrollY,
  [0, 100],
  [0, 360],
  { clamp: false }
)

#### [Output multiple values](#output-multiple-values)

It's common to map a single motion value and input range into multiple motion values.

const opacity = useTransform(offset, [100, 600], [1, 0.4])
const scale = useTransform(offset, [100, 600], [1, 0.6])
const filter = useTransform(offset, [100, 600], ["blur(0px)", "blur(10px)"])

This can lead to some repetition, so `useTransform` also supports mapping to multiple motion values in a single call, by providing a named map:

const { opacity, scale, filter } = useTransform(offset, [100, 600], {
  opacity: [1, 0.4],
  scale: [1, 0.6],
  filter: ["blur(0px)", "blur(10px)"],
})

## [Options](#options)

With value mapping, we can set some additional options.

### [`clamp`](#clamp)

**Default:** `true`

If `true`, will clamp output to within the provided range. If `false`, will carry on mapping even when the input falls outside the provided range.



### [`ease`](#ease)

An easing function, or array of easing functions, to ease the mixing between each value.

These must be JavaScript functions.



### [`mixer`](#mixer)

A function to use to mix between each pair of output values.

This function will be called with each pair of output values and must return a new function, that accepts a progress value between `0` and `1` and returns the mixed value.

This can be used to inject more advanced mixers than Framer Motion's default, for instance Flubber for morphing SVG paths.

Previous

useTime

Next

useVelocity

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