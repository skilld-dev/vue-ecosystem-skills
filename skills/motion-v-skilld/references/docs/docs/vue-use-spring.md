---
title: "useSpring — Vue spring animations | Motion"
meta:
  "og:description": "Discover Motion for Vue's useSpring hook. Create smooth spring animations for motion values. Learn to animate with .set(), track values &amp; customize transitions."
  "og:title": "useSpring — Vue spring animations | Motion"
  "twitter:description": "Discover Motion for Vue's useSpring hook. Create smooth spring animations for motion values. Learn to animate with .set(), track values &amp; customize transitions."
  "twitter:title": "useSpring — Vue spring animations | Motion"
  description: "Discover Motion for Vue's useSpring hook. Create smooth spring animations for motion values. Learn to animate with .set(), track values &amp; customize transitions."
---

Vue

# useSpring

`useSpring` creates a motion value that will animate to its latest target with a spring animation.

The target can either be set manually via `.set`, or automatically by passing in another motion value.

## [Usage](#usage)

Import `useSpring` from Motion:

import { useSpring } from "motion-v"

### [Direct control](#direct-control)

`useSpring` can be created with a number, or a unit-type (`px`, `%` etc) string:

const x = useSpring(0)
const y = useSpring("100vh")

Now, whenever this motion value is updated via `set()`, the value will animate to its new target with the defined spring.

x.set(100)
y.set("50vh")

It's also possible to update this value immediately, without a spring, with the`[jump()](https://motion.dev/react-motion-value#jump)` method.

x.jump(50)
y.jump("0vh")

### [Track another motion value](#track-another-motion-value)

Its also possible to automatically spring towards the latest value of another motion value:

const x = useMotionValue(0)
const y = useSpring(x)

This source motion value must also be a number, or unit-type string.

### [Transition](#transition)

The type of `spring` can be defined with the usual spring transition option.

useSpring(0, { stiffness: 300 })

`useSpring` creates a motion value that will animate to its latest target with a spring animation.

The target can either be set manually via `.set`, or automatically by passing in another motion value.

## [Usage](#usage)

Import `useSpring` from Motion:

import { useSpring } from "motion-v"

### [Direct control](#direct-control)

`useSpring` can be created with a number, or a unit-type (`px`, `%` etc) string:

const x = useSpring(0)
const y = useSpring("100vh")

Now, whenever this motion value is updated via `set()`, the value will animate to its new target with the defined spring.

x.set(100)
y.set("50vh")

It's also possible to update this value immediately, without a spring, with the`[jump()](https://motion.dev/react-motion-value#jump)` method.

x.jump(50)
y.jump("0vh")

### [Track another motion value](#track-another-motion-value)

Its also possible to automatically spring towards the latest value of another motion value:

const x = useMotionValue(0)
const y = useSpring(x)

This source motion value must also be a number, or unit-type string.

### [Transition](#transition)

The type of `spring` can be defined with the usual spring transition option.

useSpring(0, { stiffness: 300 })

`useSpring` creates a motion value that will animate to its latest target with a spring animation.

The target can either be set manually via `.set`, or automatically by passing in another motion value.

## [Usage](#usage)

Import `useSpring` from Motion:

import { useSpring } from "motion-v"

### [Direct control](#direct-control)

`useSpring` can be created with a number, or a unit-type (`px`, `%` etc) string:

const x = useSpring(0)
const y = useSpring("100vh")

Now, whenever this motion value is updated via `set()`, the value will animate to its new target with the defined spring.

x.set(100)
y.set("50vh")

It's also possible to update this value immediately, without a spring, with the`[jump()](https://motion.dev/react-motion-value#jump)` method.

x.jump(50)
y.jump("0vh")

### [Track another motion value](#track-another-motion-value)

Its also possible to automatically spring towards the latest value of another motion value:

const x = useMotionValue(0)
const y = useSpring(x)

This source motion value must also be a number, or unit-type string.

### [Transition](#transition)

The type of `spring` can be defined with the usual spring transition option.

useSpring(0, { stiffness: 300 })

Previous

useScroll

Next

useTime

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