useSpring — Vue spring animations | Motion

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