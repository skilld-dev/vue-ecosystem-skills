---
title: "useMotionTemplate — Combine motion values with Vue | Motion"
meta:
  "og:description": "Combine motion values into dynamic strings with Motion for Vue's useMotionTemplate. Create auto-updating, interpolated values for responsive animations."
  "og:title": "useMotionTemplate — Combine motion values with Vue | Motion"
  "twitter:description": "Combine motion values into dynamic strings with Motion for Vue's useMotionTemplate. Create auto-updating, interpolated values for responsive animations."
  "twitter:title": "useMotionTemplate — Combine motion values with Vue | Motion"
  description: "Combine motion values into dynamic strings with Motion for Vue's useMotionTemplate. Create auto-updating, interpolated values for responsive animations."
---

Vue

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