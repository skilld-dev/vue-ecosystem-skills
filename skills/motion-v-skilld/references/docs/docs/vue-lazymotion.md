---
title: "LazyMotion — Optimise Motion bundle in Vue | Motion"
meta:
  "og:description": "Reduce your initial bundle size with LazyMotion in Motion for Vue. Load animation features synchronously or asynchronously, shrinking bundles to as low as 6kb."
  "og:title": "LazyMotion — Optimise Motion bundle in Vue | Motion"
  "twitter:description": "Reduce your initial bundle size with LazyMotion in Motion for Vue. Load animation features synchronously or asynchronously, shrinking bundles to as low as 6kb."
  "twitter:title": "LazyMotion — Optimise Motion bundle in Vue | Motion"
  description: "Reduce your initial bundle size with LazyMotion in Motion for Vue. Load animation features synchronously or asynchronously, shrinking bundles to as low as 6kb."
---

Vue

# LazyMotion

For ease of use, the `[motion](https://motion.dev/vue-motion-component)` component comes pre-bundled with all of its features for a bundlesize of around 34kb.

With `LazyMotion` and the `m` component, we can reduce this to 6kb for the initial render and then sync or async load a subset of features.

## [Usage](#usage)

Instead of importing `motion`, import the slimmer `m` component.

import { m } from "motion-v"

`m` is used in the exact same way as `motion`, but unlike `motion`, the `m` component doesn't come preloaded with features like animations, layout animations, or the drag gesture.

Instead, we load these in manually via the `LazyMotion` component. This lets you choose which features you load in, and whether you load them as part of the main bundle, or lazy load them.



<template>
   
  <LazyMotion :features="domAnimation">
    <m.div :animate="{ opacity: 1 }" />
  </LazyMotion>
</template>

### [Available features](#available-features)

There are currently two **feature packages** you can load:

- `domAnimation`: This provides support for animations, variants, exit animations, and press/hover/focus gestures. (**+18kb**)
- `domMax`: This provides support for all of the above, plus pan/drag gestures and layout animations. (**+28kb**)

In the future it might be possible to offer more granular feature packages, but for now these were chosen to reduce the amount of duplication between features, which could result in much more data being downloaded ultimately.

#### [Synchronous loading](#synchronous-loading)

By passing one of these feature packages to `LazyMotion`, they'll be bundled into your main JavaScript bundle.



<template>  
  <LazyMotion :features="domAnimations">
    <m.div :animate="{ opacity: 1 }" />
  </LazyMotion>
</template>

#### [Async loading](#async-loading)

If you're using a bundler like Webpack or Rollup, we can pass a dynamic import function to `features` that will fetch features only after we've performed our initial render.

First, create a file that exports only the features you want to load.

// features.js
import { domAnimation } from "motion-v"
export default domAnimation
  
// index.js
const loadFeatures = import("./features.js")
  .then(res => res.default)

<template>
    <LazyMotion :features="loadFeatures">
      <m.div :animate="{ scale: 1.5 }" />
    </LazyMotion>
</template>

### [`strict`](#strict)

**Default:** `false`

If `true`, will throw an error if a `motion` component renders within a `LazyMotion` component (thereby removing the bundlesize benefits of lazy-loading).


<template>
    <LazyMotion :features="domAnimation" strict>
      <motion.div />
    </LazyMotion>
</template>

For ease of use, the `[motion](https://motion.dev/vue-motion-component)` component comes pre-bundled with all of its features for a bundlesize of around 34kb.

With `LazyMotion` and the `m` component, we can reduce this to 6kb for the initial render and then sync or async load a subset of features.

## [Usage](#usage)

Instead of importing `motion`, import the slimmer `m` component.

import { m } from "motion-v"

`m` is used in the exact same way as `motion`, but unlike `motion`, the `m` component doesn't come preloaded with features like animations, layout animations, or the drag gesture.

Instead, we load these in manually via the `LazyMotion` component. This lets you choose which features you load in, and whether you load them as part of the main bundle, or lazy load them.



<template>
   
  <LazyMotion :features="domAnimation">
    <m.div :animate="{ opacity: 1 }" />
  </LazyMotion>
</template>

### [Available features](#available-features)

There are currently two **feature packages** you can load:

- `domAnimation`: This provides support for animations, variants, exit animations, and press/hover/focus gestures. (**+18kb**)
- `domMax`: This provides support for all of the above, plus pan/drag gestures and layout animations. (**+28kb**)

In the future it might be possible to offer more granular feature packages, but for now these were chosen to reduce the amount of duplication between features, which could result in much more data being downloaded ultimately.

#### [Synchronous loading](#synchronous-loading)

By passing one of these feature packages to `LazyMotion`, they'll be bundled into your main JavaScript bundle.



<template>  
  <LazyMotion :features="domAnimations">
    <m.div :animate="{ opacity: 1 }" />
  </LazyMotion>
</template>

#### [Async loading](#async-loading)

If you're using a bundler like Webpack or Rollup, we can pass a dynamic import function to `features` that will fetch features only after we've performed our initial render.

First, create a file that exports only the features you want to load.

// features.js
import { domAnimation } from "motion-v"
export default domAnimation
  
// index.js
const loadFeatures = import("./features.js")
  .then(res => res.default)

<template>
    <LazyMotion :features="loadFeatures">
      <m.div :animate="{ scale: 1.5 }" />
    </LazyMotion>
</template>

### [`strict`](#strict)

**Default:** `false`

If `true`, will throw an error if a `motion` component renders within a `LazyMotion` component (thereby removing the bundlesize benefits of lazy-loading).


<template>
    <LazyMotion :features="domAnimation" strict>
      <motion.div />
    </LazyMotion>
</template>

For ease of use, the `[motion](https://motion.dev/vue-motion-component)` component comes pre-bundled with all of its features for a bundlesize of around 34kb.

With `LazyMotion` and the `m` component, we can reduce this to 6kb for the initial render and then sync or async load a subset of features.

## [Usage](#usage)

Instead of importing `motion`, import the slimmer `m` component.

import { m } from "motion-v"

`m` is used in the exact same way as `motion`, but unlike `motion`, the `m` component doesn't come preloaded with features like animations, layout animations, or the drag gesture.

Instead, we load these in manually via the `LazyMotion` component. This lets you choose which features you load in, and whether you load them as part of the main bundle, or lazy load them.



<template>
   
  <LazyMotion :features="domAnimation">
    <m.div :animate="{ opacity: 1 }" />
  </LazyMotion>
</template>

### [Available features](#available-features)

There are currently two **feature packages** you can load:

- `domAnimation`: This provides support for animations, variants, exit animations, and press/hover/focus gestures. (**+18kb**)
- `domMax`: This provides support for all of the above, plus pan/drag gestures and layout animations. (**+28kb**)

In the future it might be possible to offer more granular feature packages, but for now these were chosen to reduce the amount of duplication between features, which could result in much more data being downloaded ultimately.

#### [Synchronous loading](#synchronous-loading)

By passing one of these feature packages to `LazyMotion`, they'll be bundled into your main JavaScript bundle.



<template>  
  <LazyMotion :features="domAnimations">
    <m.div :animate="{ opacity: 1 }" />
  </LazyMotion>
</template>

#### [Async loading](#async-loading)

If you're using a bundler like Webpack or Rollup, we can pass a dynamic import function to `features` that will fetch features only after we've performed our initial render.

First, create a file that exports only the features you want to load.

// features.js
import { domAnimation } from "motion-v"
export default domAnimation
  
// index.js
const loadFeatures = import("./features.js")
  .then(res => res.default)

<template>
    <LazyMotion :features="loadFeatures">
      <m.div :animate="{ scale: 1.5 }" />
    </LazyMotion>
</template>

### [`strict`](#strict)

**Default:** `false`

If `true`, will throw an error if a `motion` component renders within a `LazyMotion` component (thereby removing the bundlesize benefits of lazy-loading).


<template>
    <LazyMotion :features="domAnimation" strict>
      <motion.div />
    </LazyMotion>
</template>

Previous

LayoutGroup

Next

MotionConfig

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