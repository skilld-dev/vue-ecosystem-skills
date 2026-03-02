---
title: "useReducedMotion — Accessible Vue animations | Motion"
meta:
  "og:description": "Learn to use Motion for Vue's useReducedMotion hook to detect reduced motion settings. Create accessible UIs by adapting animations and motion features."
  "og:title": "useReducedMotion — Accessible Vue animations | Motion"
  "twitter:description": "Learn to use Motion for Vue's useReducedMotion hook to detect reduced motion settings. Create accessible UIs by adapting animations and motion features."
  "twitter:title": "useReducedMotion — Accessible Vue animations | Motion"
  description: "Learn to use Motion for Vue's useReducedMotion hook to detect reduced motion settings. Create accessible UIs by adapting animations and motion features."
---

Vue

# useReducedMotion

A hook that returns `true` if the current device has Reduced Motion setting enabled.

const shouldReduceMotion = useReducedMotion()

This can be used to implement changes to your UI based on Reduced Motion. For instance, replacing potentially motion-sickness inducing `x`/`y` animations with `opacity`, disabling the autoplay of background videos, or turning off parallax motion.

It will actively respond to changes and re-render your components with the latest setting.



<template>
  <Motion
    :animate="{
      opacity: isOpen ? 1 : 0,
      x: isOpen ? 0 : closedX
    }"
  />
</template>

## [Usage](#usage)

Import `useReducedMotion` from Motion:

import { useReducedMotion } from "motion-v"

In any component, call `useReducedMotion` to check whether the device's Reduced Motion setting is enabled.

const prefersReducedMotion = useReducedMotion()

You can then use this `true`/`false` value to change your application logic.

A hook that returns `true` if the current device has Reduced Motion setting enabled.

const shouldReduceMotion = useReducedMotion()

This can be used to implement changes to your UI based on Reduced Motion. For instance, replacing potentially motion-sickness inducing `x`/`y` animations with `opacity`, disabling the autoplay of background videos, or turning off parallax motion.

It will actively respond to changes and re-render your components with the latest setting.



<template>
  <Motion
    :animate="{
      opacity: isOpen ? 1 : 0,
      x: isOpen ? 0 : closedX
    }"
  />
</template>

## [Usage](#usage)

Import `useReducedMotion` from Motion:

import { useReducedMotion } from "motion-v"

In any component, call `useReducedMotion` to check whether the device's Reduced Motion setting is enabled.

const prefersReducedMotion = useReducedMotion()

You can then use this `true`/`false` value to change your application logic.

A hook that returns `true` if the current device has Reduced Motion setting enabled.

const shouldReduceMotion = useReducedMotion()

This can be used to implement changes to your UI based on Reduced Motion. For instance, replacing potentially motion-sickness inducing `x`/`y` animations with `opacity`, disabling the autoplay of background videos, or turning off parallax motion.

It will actively respond to changes and re-render your components with the latest setting.



<template>
  <Motion
    :animate="{
      opacity: isOpen ? 1 : 0,
      x: isOpen ? 0 : closedX
    }"
  />
</template>

## [Usage](#usage)

Import `useReducedMotion` from Motion:

import { useReducedMotion } from "motion-v"

In any component, call `useReducedMotion` to check whether the device's Reduced Motion setting is enabled.

const prefersReducedMotion = useReducedMotion()

You can then use this `true`/`false` value to change your application logic.

Previous

useInView

Next

Integrate Motion with Radix

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