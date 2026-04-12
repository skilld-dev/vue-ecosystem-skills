useMotionTemplate — Combine motion values with Vue | Motion

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

# useMotionTemplate

`useMotionTemplate` creates a new motion value from a string template containing other motion values.

const x = useMotionValue(100)
const transform = useMotionTemplate\`transform(${x}px)\`

Whenever a motion value within the string template updates, the returned motion value will update with the latest value.

## [Usage](#usage)

Import from Motion:

import { useMotionTemplate } from "motion-v"

`useMotionTemplate` is a "tagged template", so rather than being called like a normal function, it's called as a string template:

useMotionValue\`\`

This string template can accept both text and other motion values:



<template>
 <motion.div :style="{ filter }" />
</template>

The latest value of the returned motion value will be the string template with each provided motion value replaced with its latest value.



<template>
 <motion.div :style="{ filter }" />  
</template>

`useMotionTemplate` creates a new motion value from a string template containing other motion values.

const x = useMotionValue(100)
const transform = useMotionTemplate\`transform(${x}px)\`

Whenever a motion value within the string template updates, the returned motion value will update with the latest value.

## [Usage](#usage)

Import from Motion:

import { useMotionTemplate } from "motion-v"

`useMotionTemplate` is a "tagged template", so rather than being called like a normal function, it's called as a string template:

useMotionValue\`\`

This string template can accept both text and other motion values:



<template>
 <motion.div :style="{ filter }" />
</template>

The latest value of the returned motion value will be the string template with each provided motion value replaced with its latest value.



<template>
 <motion.div :style="{ filter }" />  
</template>

`useMotionTemplate` creates a new motion value from a string template containing other motion values.

const x = useMotionValue(100)
const transform = useMotionTemplate\`transform(${x}px)\`

Whenever a motion value within the string template updates, the returned motion value will update with the latest value.

## [Usage](#usage)

Import from Motion:

import { useMotionTemplate } from "motion-v"

`useMotionTemplate` is a "tagged template", so rather than being called like a normal function, it's called as a string template:

useMotionValue\`\`

This string template can accept both text and other motion values:



<template>
 <motion.div :style="{ filter }" />
</template>

The latest value of the returned motion value will be the string template with each provided motion value replaced with its latest value.



<template>
 <motion.div :style="{ filter }" />  
</template>

Previous

Motion values

Next

useMotionValueEvent

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