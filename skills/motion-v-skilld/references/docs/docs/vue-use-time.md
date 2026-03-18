---
title: "useTime — Vue requestAnimationFrame alternative | Motion"
meta:
  "og:description": "Explore Motion for Vue's useTime hook. It returns elapsed time in ms every frame. Learn how it creates perpetual animations &amp; composes with other motion values."
  "og:title": "useTime — Vue requestAnimationFrame alternative | Motion"
  "twitter:description": "Explore Motion for Vue's useTime hook. It returns elapsed time in ms every frame. Learn how it creates perpetual animations &amp; composes with other motion values."
  "twitter:title": "useTime — Vue requestAnimationFrame alternative | Motion"
  description: "Explore Motion for Vue's useTime hook. It returns elapsed time in ms every frame. Learn how it creates perpetual animations &amp; composes with other motion values."
---

Vue

# useTime

`useTime` returns a motion value that updates once per frame with the duration, in milliseconds, since it was first created.

This is especially useful in generating perpetual animations.



<template>
  <motion.div :style="{ rotate }" />
</template>

## [Usage](#usage)

Import from Motion:

import { useTime } from "motion-v"

When called, `useTime` will create a new motion value. This value will update every frame with the time since its creation.

You can use this either directly or by composing with other motion value hooks.

const time = useTime()
const rotate = useTransform(
  time,
  [0, 4000], // For every 4 seconds...
  [0, 360], // ...rotate 360deg
  { clamp: false }
)

`useTime` returns a motion value that updates once per frame with the duration, in milliseconds, since it was first created.

This is especially useful in generating perpetual animations.



<template>
  <motion.div :style="{ rotate }" />
</template>

## [Usage](#usage)

Import from Motion:

import { useTime } from "motion-v"

When called, `useTime` will create a new motion value. This value will update every frame with the time since its creation.

You can use this either directly or by composing with other motion value hooks.

const time = useTime()
const rotate = useTransform(
  time,
  [0, 4000], // For every 4 seconds...
  [0, 360], // ...rotate 360deg
  { clamp: false }
)

`useTime` returns a motion value that updates once per frame with the duration, in milliseconds, since it was first created.

This is especially useful in generating perpetual animations.



<template>
  <motion.div :style="{ rotate }" />
</template>

## [Usage](#usage)

Import from Motion:

import { useTime } from "motion-v"

When called, `useTime` will create a new motion value. This value will update every frame with the time since its creation.

You can use this either directly or by composing with other motion value hooks.

const time = useTime()
const rotate = useTransform(
  time,
  [0, 4000], // For every 4 seconds...
  [0, 360], // ...rotate 360deg
  { clamp: false }
)

Previous

useSpring

Next

useTransform

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