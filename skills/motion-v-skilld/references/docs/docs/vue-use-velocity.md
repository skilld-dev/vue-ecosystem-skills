---
title: "useVelocity — Vue velocity-based animations | Motion"
meta:
  "og:description": "Discover Motion for Vue's useVelocity hook. It tracks a motion value's velocity, letting you monitor the rate of change for any animatable value easily."
  "og:title": "useVelocity — Vue velocity-based animations | Motion"
  "twitter:description": "Discover Motion for Vue's useVelocity hook. It tracks a motion value's velocity, letting you monitor the rate of change for any animatable value easily."
  "twitter:title": "useVelocity — Vue velocity-based animations | Motion"
  description: "Discover Motion for Vue's useVelocity hook. It tracks a motion value's velocity, letting you monitor the rate of change for any animatable value easily."
---

Vue

# useVelocity

`useVelocity` accepts a motion value and returns a new one that updates with the provided motion value's velocity.



<template>
  <Motion drag="x" :style="{ x, scale }" />
</template>

## [Usage](#usage)

Import `useVelocity` from Motion:

import { useVelocity } from "motion-v"

Pass any numerical motion value to `useVelocity`. It'll return a new motion value that updates with the velocity of the original value.



<template>
  <Motion :style="{ x }" />
</template>

Any numerical motion value will work. Even one returned from `useVelocity`.

const x = useMotionValue(0)
const xVelocity = useVelocity(x)
const xAcceleration = useVelocity(xVelocity)

`useVelocity` accepts a motion value and returns a new one that updates with the provided motion value's velocity.



<template>
  <Motion drag="x" :style="{ x, scale }" />
</template>

## [Usage](#usage)

Import `useVelocity` from Motion:

import { useVelocity } from "motion-v"

Pass any numerical motion value to `useVelocity`. It'll return a new motion value that updates with the velocity of the original value.



<template>
  <Motion :style="{ x }" />
</template>

Any numerical motion value will work. Even one returned from `useVelocity`.

const x = useMotionValue(0)
const xVelocity = useVelocity(x)
const xAcceleration = useVelocity(xVelocity)

`useVelocity` accepts a motion value and returns a new one that updates with the provided motion value's velocity.



<template>
  <Motion drag="x" :style="{ x, scale }" />
</template>

## [Usage](#usage)

Import `useVelocity` from Motion:

import { useVelocity } from "motion-v"

Pass any numerical motion value to `useVelocity`. It'll return a new motion value that updates with the velocity of the original value.



<template>
  <Motion :style="{ x }" />
</template>

Any numerical motion value will work. Even one returned from `useVelocity`.

const x = useMotionValue(0)
const xVelocity = useVelocity(x)
const xAcceleration = useVelocity(xVelocity)

Previous

useTransform

Next

useAnimate

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