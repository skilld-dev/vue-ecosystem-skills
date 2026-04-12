Vue transitions — Configure Motion animations | Motion

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

# Transition options

A `transition` defines the type of animation used when animating between two values.

const transition = {
  duration: 0.8,
  delay: 0.5,
  ease: [0, 0.71, 0.2, 1.01],
}

// Motion component
<motion.div
  :animate="{ x: 100 }"
  :transition="transition"
/>

// animate() function
animate(".box", { x: 100 }, transition)

## [Setting a transition](#setting-a-transition)

`transition` can be set on any animation prop, and that transition will be used when the animation fires.

<motion.div
  :whileHover="{
    scale: 1.1,
    transition: { duration: 0.2 }
  }"
/>

### [Value-specific transitions](#value-specific-transitions)

When animating multiple values, each value can be animated with a different transition, with `default` handling all other values:

// Motion component
<motion.li
  :animate="{
    x: 0,
    opacity: 1,
    transition: {
      default: { type: 'spring' },
      opacity: { ease: 'linear' }
    }
  }"
/>

// animate() function
animate("li", { x: 0, opacity: 1 }, {
  default: { type: "spring" },
  opacity: { ease: "linear" }
})

### [Default transitions](#default-transitions)

It's possible to set default transitions via the `transition` prop. Either for specific `motion` components:

<motion.div
  :animate="{ x: 100 }"
  :transition="{ type: 'spring', stiffness: 100 }"
/>

Or for a group of `motion` components via`[MotionConfig](https://motion.dev/vue-motion-config#transition)`:

<MotionConfig :transition="{ duration: 0.4, ease: 'easeInOut' }">
  <App />
</MotionConfig>

## [Transition settings](#transition-settings)

#### [`type`](#type)

**Default:**Dynamic

`type` decides the type of animation to use. It can be `"tween"`, `"spring"` or `"inertia"`.

**Tween** animations are set with a duration and an easing curve.

**Spring** animations are either physics-based or duration-based.

Physics-based spring animations are set via `stiffness`, `damping` and `mass`, and these incorporate the velocity of any existing gestures or animations for natural feedback.

Duration-based spring animations are set via a `duration` and `bounce`. These don't incorporate velocity but are easier to understand.

**Inertia** animations decelerate a value based on its initial velocity, usually used to implement inertial scrolling.

<motion.path
  :animate="{ pathLength: 1 }"
  :transition="{ duration: 2, type: 'tween' }"
/>

#### [Spring visualiser](#spring-visualiser)

Time Physics

DurationBounceUse visual duration

### [Tween](#tween)

#### [`duration`](#duration)

**Default:**`0.3` (or `0.8` if multiple keyframes are defined)

The duration of the animation. Can also be used for `"spring"` animations when `bounce` is also set.

animate("ul > li", { opacity: 1 }, { duration: 1 })

#### [`ease`](#ease)

The easing function to use with tween animations. Accepts:

- Easing function name. E.g `"linear"`
- An array of four numbers to define a cubic bezier curve. E.g `[.17,.67,.83,.67]`
- A JavaScript easing function, that accepts and returns a value `0`-`1`.

These are the available easing function names:

- `"linear"`
- `"easeIn"`, `"easeOut"`, `"easeInOut"`
- `"circIn"`, `"circOut"`, `"circInOut"`
- `"backIn"`, `"backOut"`, `"backInOut"`
- `"anticipate"`

When animating keyframes, `ease` can optionally be set as an array of easing functions to set different easings between each value:

<motion.div
  :animate="{
    x: [0, 100, 0],
    transition: { ease: ['easeIn', 'easeOut'] }
  }"
/>

For immediate visual feedback, you can edit CSS or Motion easing curves directly in your code editor with the Motion extension.

#### [`times`](#times)

When animating multiple keyframes, `times` can be used to adjust the position of each keyframe throughout the animation.

Each value in `times` is a value between `0` and `1`, representing the start and end of the animation.

<motion.div
  :animate="{
    x: [0, 100, 0],
    transition: { times: [0, 0.3, 1] }
  }"
/>

There must be the same number of `times` as there are keyframes. Defaults to an array of evenly-spread durations.

### [Spring](#spring)

#### [`bounce`](#bounce)

**Default:** `0.25`

`bounce` determines the "bounciness" of a spring animation.

`0` is no bounce, and `1` is extremely bouncy.

**Note:** `bounce` and `duration` will be overridden if `stiffness`, `damping` or `mass` are set.

<motion.div
  :animate="{ rotateX: 90 }"
  :transition="{ type: 'spring', bounce: 0.25 }"
/>

#### [`visualDuration`](#visualduration)

If `visualDuration` is set, this will override `duration`.

The visual duration is a time, **set in seconds**, that the animation will take to visually appear to reach its target.

In other words, the bulk of the transition will occur before this time, and the "bouncy bit" will mostly happen after.

This makes it easier to edit a spring, as well as visually coordinate it with other time-based animations.

<motion.div
  :animate="{ rotateX: 90 }"
  :transition="{
    type: 'spring',
    visualDuration: 0.5,
    bounce: 0.25
  }"
/>

#### [`damping`](#damping)

**Default:** `10`

Strength of opposing force. If set to 0, spring will oscillate indefinitely.

<motion.a
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', damping: 300 }"
/>

#### [`mass`](#mass)

**Default:** `1`

Mass of the moving object. Higher values will result in more lethargic movement.

<motion.feTurbulence
  :animate="{ baseFrequency: 0.5 }"
  :transition="{ type: 'spring', mass: 0.5 }"
/>

#### [`stiffness`](#stiffness)

**Default:** `1`

Stiffness of the spring. Higher values will create more sudden movement.

<motion.section
  animate={{ rotate: 180 }}
  transition={{ type: 'spring', stiffness: 50 }}
/>

> _I never really understood how_`_damping_`_,_`_mass_`_ and_`_stiffness_`_ influence a spring animation, so I made a__tool for myself__ to visualise it._~ Emil Kowalski, Animations on the Web
#### [`velocity`](#velocity)

**Default:** Current value velocity

The initial velocity of the spring.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', velocity: 2 }"
/>

#### [`restSpeed`](#restspeed)

**Default:** `0.1`

End animation if absolute speed (in units per second) drops below this value and delta is smaller than `restDelta`.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', restSpeed: 0.5 }"
/>

#### [`restDelta`](#restdelta)

**Default:** `0.01`

End animation if distance is below this value and speed is below `restSpeed`. When animation ends, the spring will end.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', restDelta: 0.5 }"
/>

### [Inertia](#inertia)

An animation that decelerates a value based on its initial velocity. Optionally, `min` and `max` boundaries can be defined, and inertia will snap to these with a spring animation.

This animation will automatically precalculate a target value, which can be modified with the `modifyTarget` property.

This allows you to add snap-to-grid or similar functionality.

Inertia is also the animation used for `dragTransition`, and can be configured via that prop.

#### [`power`](#power)

**Default:**`0.8`

A higher power value equals a further calculated target.

<motion.div
  drag
  :dragTransition="{ power: 0.2 }"
/>

#### [`timeConstant`](#timeconstant)

**Default:**`**700**`

Adjusting the time constant will change the duration of the deceleration, thereby affecting its feel.

<motion.div
  drag
  :dragTransition="{ timeConstant: 200 }"
/>

#### [`modifyTarget`](#modifytarget)

A function that receives the automatically-calculated target and returns a new one. Useful for snapping the target to a grid.

<motion.div
  drag
  // dragTransition always type: inertia
  :dragTransition="{
    power: 0,
    // Snap calculated target to nearest 50 pixels
    modifyTarget: target => Math.round(target / 50) * 50
  }"
/>

#### [`min`](#min)

Minimum constraint. If set, the value will "bump" against this value (or immediately spring to it if the animation starts as less than this value).

<motion.div
  drag
  :dragTransition="{ min: 0, max: 100 }"
/>

#### [`max`](#max)

Maximum constraint. If set, the value will "bump" against this value (or immediately snap to it, if the initial animation value exceeds this value).

<motion.div
  drag
  :dragTransition="{ min: 0, max: 100 }"
/>

#### [`bounceStiffness`](#bouncestiffness)

**Default:**`500`

If `min` or `max` is set, this affects the stiffness of the bounce spring. Higher values will create more sudden movement.

<motion.div
  drag
  :dragTransition="{
    min: 0,
    max: 100,
    bounceStiffness: 100
  }"
/>

#### [`bounceDamping`](#bouncedamping)

**Default:**`10`

If `min` or `max` is set, this affects the damping of the bounce spring. If set to `0`, spring will oscillate indefinitely.

<motion.div
  drag
  :dragTransition="{
    min: 0,
    max: 100,
    bounceStiffness: 100
  }"
/>

### [Orchestration](#orchestration)

#### [`delay`](#delay)

**Default:**`0`

Delay the animation by this duration (in seconds).

animate(element, { filter: "blur(10px)" }, { delay: 0.3 })

By setting `delay` to a negative value, the animation will start that long into the animation. For instance to start 1 second in, `delay` can be set to -`1`.

#### [`repeat`](#repeat)

**Default:**`0`

The number of times to repeat the transition. Set to `Infinity` for perpetual animation.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ repeat: Infinity, duration: 2 }"
/>

#### [`repeatType`](#repeattype)

**Default:**`"loop"`

How to repeat the animation. This can be either:

- `loop`: Repeats the animation from the start.
- `reverse`: Alternates between forward and backwards playback.
- `mirror`: Switches animation origin and target on each iteration.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{
    repeat: 1,
    repeatType: 'reverse',
    duration: 2
  }"
/>

#### [`repeatDelay`](#repeatdelay)

**Default:**`0`

When repeating an animation, `repeatDelay` will set the duration of the time to wait, in seconds, between each repetition.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ repeat: Infinity, repeatDelay: 1 }"
/>

#### [`when`](#when)

**Default:**`false`

With variants, describes when an animation should trigger, relative to that of its children.

- `"beforeChildren"`: Children animations will play after the parent animation finishes.
- `"afterChildren"`: Parent animations will play after the children animations finish.



<template>
  <motion.ul :variants="list" animate="hidden">
    <motion.li :variants="item" />
    <motion.li :variants="item" />
  </motion.ul>
</template>

#### [`delayChildren`](#delaychildren)

**Default:**`0`

With variants, setting `delayChildren` on a parent will delay child animations by this duration (in seconds).

<sctipt setup>  
const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: {
      delayChildren: 0.5
    }
  }
}

const item = {
  hidden: { opacity: 0 },
  show: { opacity: 1 }
}
</sctipt>

<template> 
  <motion.ul
    :variants="container"
    initial="hidden"
    animate="show"
  >
    <motion.li :variants="item" />
    <motion.li :variants="item"/>
  </motion.ul>
</template>

Using the `[stagger](https://motion.dev/stagger)` function, we can stagger the delay across children.

const transition = {
  delayChildren: stagger(0.1)
}

By default, delay will stagger across children from first to last. By using `stagger`'s `from` option, we can stagger from the last child, the center, or a specific index.

const transition = {
  delayChildren: stagger(0.1, { from: "last" })
}

A `transition` defines the type of animation used when animating between two values.

const transition = {
  duration: 0.8,
  delay: 0.5,
  ease: [0, 0.71, 0.2, 1.01],
}

// Motion component
<motion.div
  :animate="{ x: 100 }"
  :transition="transition"
/>

// animate() function
animate(".box", { x: 100 }, transition)

## [Setting a transition](#setting-a-transition)

`transition` can be set on any animation prop, and that transition will be used when the animation fires.

<motion.div
  :whileHover="{
    scale: 1.1,
    transition: { duration: 0.2 }
  }"
/>

### [Value-specific transitions](#value-specific-transitions)

When animating multiple values, each value can be animated with a different transition, with `default` handling all other values:

// Motion component
<motion.li
  :animate="{
    x: 0,
    opacity: 1,
    transition: {
      default: { type: 'spring' },
      opacity: { ease: 'linear' }
    }
  }"
/>

// animate() function
animate("li", { x: 0, opacity: 1 }, {
  default: { type: "spring" },
  opacity: { ease: "linear" }
})

### [Default transitions](#default-transitions)

It's possible to set default transitions via the `transition` prop. Either for specific `motion` components:

<motion.div
  :animate="{ x: 100 }"
  :transition="{ type: 'spring', stiffness: 100 }"
/>

Or for a group of `motion` components via`[MotionConfig](https://motion.dev/vue-motion-config#transition)`:

<MotionConfig :transition="{ duration: 0.4, ease: 'easeInOut' }">
  <App />
</MotionConfig>

## [Transition settings](#transition-settings)

#### [`type`](#type)

**Default:**Dynamic

`type` decides the type of animation to use. It can be `"tween"`, `"spring"` or `"inertia"`.

**Tween** animations are set with a duration and an easing curve.

**Spring** animations are either physics-based or duration-based.

Physics-based spring animations are set via `stiffness`, `damping` and `mass`, and these incorporate the velocity of any existing gestures or animations for natural feedback.

Duration-based spring animations are set via a `duration` and `bounce`. These don't incorporate velocity but are easier to understand.

**Inertia** animations decelerate a value based on its initial velocity, usually used to implement inertial scrolling.

<motion.path
  :animate="{ pathLength: 1 }"
  :transition="{ duration: 2, type: 'tween' }"
/>

#### [Spring visualiser](#spring-visualiser)

Time Physics

DurationBounceUse visual duration

### [Tween](#tween)

#### [`duration`](#duration)

**Default:**`0.3` (or `0.8` if multiple keyframes are defined)

The duration of the animation. Can also be used for `"spring"` animations when `bounce` is also set.

animate("ul > li", { opacity: 1 }, { duration: 1 })

#### [`ease`](#ease)

The easing function to use with tween animations. Accepts:

- Easing function name. E.g `"linear"`
- An array of four numbers to define a cubic bezier curve. E.g `[.17,.67,.83,.67]`
- A JavaScript easing function, that accepts and returns a value `0`-`1`.

These are the available easing function names:

- `"linear"`
- `"easeIn"`, `"easeOut"`, `"easeInOut"`
- `"circIn"`, `"circOut"`, `"circInOut"`
- `"backIn"`, `"backOut"`, `"backInOut"`
- `"anticipate"`

When animating keyframes, `ease` can optionally be set as an array of easing functions to set different easings between each value:

<motion.div
  :animate="{
    x: [0, 100, 0],
    transition: { ease: ['easeIn', 'easeOut'] }
  }"
/>

For immediate visual feedback, you can edit CSS or Motion easing curves directly in your code editor with the Motion extension.

#### [`times`](#times)

When animating multiple keyframes, `times` can be used to adjust the position of each keyframe throughout the animation.

Each value in `times` is a value between `0` and `1`, representing the start and end of the animation.

<motion.div
  :animate="{
    x: [0, 100, 0],
    transition: { times: [0, 0.3, 1] }
  }"
/>

There must be the same number of `times` as there are keyframes. Defaults to an array of evenly-spread durations.

### [Spring](#spring)

#### [`bounce`](#bounce)

**Default:** `0.25`

`bounce` determines the "bounciness" of a spring animation.

`0` is no bounce, and `1` is extremely bouncy.

**Note:** `bounce` and `duration` will be overridden if `stiffness`, `damping` or `mass` are set.

<motion.div
  :animate="{ rotateX: 90 }"
  :transition="{ type: 'spring', bounce: 0.25 }"
/>

#### [`visualDuration`](#visualduration)

If `visualDuration` is set, this will override `duration`.

The visual duration is a time, **set in seconds**, that the animation will take to visually appear to reach its target.

In other words, the bulk of the transition will occur before this time, and the "bouncy bit" will mostly happen after.

This makes it easier to edit a spring, as well as visually coordinate it with other time-based animations.

<motion.div
  :animate="{ rotateX: 90 }"
  :transition="{
    type: 'spring',
    visualDuration: 0.5,
    bounce: 0.25
  }"
/>

#### [`damping`](#damping)

**Default:** `10`

Strength of opposing force. If set to 0, spring will oscillate indefinitely.

<motion.a
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', damping: 300 }"
/>

#### [`mass`](#mass)

**Default:** `1`

Mass of the moving object. Higher values will result in more lethargic movement.

<motion.feTurbulence
  :animate="{ baseFrequency: 0.5 }"
  :transition="{ type: 'spring', mass: 0.5 }"
/>

#### [`stiffness`](#stiffness)

**Default:** `1`

Stiffness of the spring. Higher values will create more sudden movement.

<motion.section
  animate={{ rotate: 180 }}
  transition={{ type: 'spring', stiffness: 50 }}
/>

> _I never really understood how_`_damping_`_,_`_mass_`_ and_`_stiffness_`_ influence a spring animation, so I made a__tool for myself__ to visualise it._~ Emil Kowalski, Animations on the Web
#### [`velocity`](#velocity)

**Default:** Current value velocity

The initial velocity of the spring.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', velocity: 2 }"
/>

#### [`restSpeed`](#restspeed)

**Default:** `0.1`

End animation if absolute speed (in units per second) drops below this value and delta is smaller than `restDelta`.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', restSpeed: 0.5 }"
/>

#### [`restDelta`](#restdelta)

**Default:** `0.01`

End animation if distance is below this value and speed is below `restSpeed`. When animation ends, the spring will end.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', restDelta: 0.5 }"
/>

### [Inertia](#inertia)

An animation that decelerates a value based on its initial velocity. Optionally, `min` and `max` boundaries can be defined, and inertia will snap to these with a spring animation.

This animation will automatically precalculate a target value, which can be modified with the `modifyTarget` property.

This allows you to add snap-to-grid or similar functionality.

Inertia is also the animation used for `dragTransition`, and can be configured via that prop.

#### [`power`](#power)

**Default:**`0.8`

A higher power value equals a further calculated target.

<motion.div
  drag
  :dragTransition="{ power: 0.2 }"
/>

#### [`timeConstant`](#timeconstant)

**Default:**`**700**`

Adjusting the time constant will change the duration of the deceleration, thereby affecting its feel.

<motion.div
  drag
  :dragTransition="{ timeConstant: 200 }"
/>

#### [`modifyTarget`](#modifytarget)

A function that receives the automatically-calculated target and returns a new one. Useful for snapping the target to a grid.

<motion.div
  drag
  // dragTransition always type: inertia
  :dragTransition="{
    power: 0,
    // Snap calculated target to nearest 50 pixels
    modifyTarget: target => Math.round(target / 50) * 50
  }"
/>

#### [`min`](#min)

Minimum constraint. If set, the value will "bump" against this value (or immediately spring to it if the animation starts as less than this value).

<motion.div
  drag
  :dragTransition="{ min: 0, max: 100 }"
/>

#### [`max`](#max)

Maximum constraint. If set, the value will "bump" against this value (or immediately snap to it, if the initial animation value exceeds this value).

<motion.div
  drag
  :dragTransition="{ min: 0, max: 100 }"
/>

#### [`bounceStiffness`](#bouncestiffness)

**Default:**`500`

If `min` or `max` is set, this affects the stiffness of the bounce spring. Higher values will create more sudden movement.

<motion.div
  drag
  :dragTransition="{
    min: 0,
    max: 100,
    bounceStiffness: 100
  }"
/>

#### [`bounceDamping`](#bouncedamping)

**Default:**`10`

If `min` or `max` is set, this affects the damping of the bounce spring. If set to `0`, spring will oscillate indefinitely.

<motion.div
  drag
  :dragTransition="{
    min: 0,
    max: 100,
    bounceStiffness: 100
  }"
/>

### [Orchestration](#orchestration)

#### [`delay`](#delay)

**Default:**`0`

Delay the animation by this duration (in seconds).

animate(element, { filter: "blur(10px)" }, { delay: 0.3 })

By setting `delay` to a negative value, the animation will start that long into the animation. For instance to start 1 second in, `delay` can be set to -`1`.

#### [`repeat`](#repeat)

**Default:**`0`

The number of times to repeat the transition. Set to `Infinity` for perpetual animation.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ repeat: Infinity, duration: 2 }"
/>

#### [`repeatType`](#repeattype)

**Default:**`"loop"`

How to repeat the animation. This can be either:

- `loop`: Repeats the animation from the start.
- `reverse`: Alternates between forward and backwards playback.
- `mirror`: Switches animation origin and target on each iteration.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{
    repeat: 1,
    repeatType: 'reverse',
    duration: 2
  }"
/>

#### [`repeatDelay`](#repeatdelay)

**Default:**`0`

When repeating an animation, `repeatDelay` will set the duration of the time to wait, in seconds, between each repetition.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ repeat: Infinity, repeatDelay: 1 }"
/>

#### [`when`](#when)

**Default:**`false`

With variants, describes when an animation should trigger, relative to that of its children.

- `"beforeChildren"`: Children animations will play after the parent animation finishes.
- `"afterChildren"`: Parent animations will play after the children animations finish.



<template>
  <motion.ul :variants="list" animate="hidden">
    <motion.li :variants="item" />
    <motion.li :variants="item" />
  </motion.ul>
</template>

#### [`delayChildren`](#delaychildren)

**Default:**`0`

With variants, setting `delayChildren` on a parent will delay child animations by this duration (in seconds).

<sctipt setup>  
const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: {
      delayChildren: 0.5
    }
  }
}

const item = {
  hidden: { opacity: 0 },
  show: { opacity: 1 }
}
</sctipt>

<template> 
  <motion.ul
    :variants="container"
    initial="hidden"
    animate="show"
  >
    <motion.li :variants="item" />
    <motion.li :variants="item"/>
  </motion.ul>
</template>

Using the `[stagger](https://motion.dev/stagger)` function, we can stagger the delay across children.

const transition = {
  delayChildren: stagger(0.1)
}

By default, delay will stagger across children from first to last. By using `stagger`'s `from` option, we can stagger from the last child, the center, or a specific index.

const transition = {
  delayChildren: stagger(0.1, { from: "last" })
}

A `transition` defines the type of animation used when animating between two values.

const transition = {
  duration: 0.8,
  delay: 0.5,
  ease: [0, 0.71, 0.2, 1.01],
}

// Motion component
<motion.div
  :animate="{ x: 100 }"
  :transition="transition"
/>

// animate() function
animate(".box", { x: 100 }, transition)

## [Setting a transition](#setting-a-transition)

`transition` can be set on any animation prop, and that transition will be used when the animation fires.

<motion.div
  :whileHover="{
    scale: 1.1,
    transition: { duration: 0.2 }
  }"
/>

### [Value-specific transitions](#value-specific-transitions)

When animating multiple values, each value can be animated with a different transition, with `default` handling all other values:

// Motion component
<motion.li
  :animate="{
    x: 0,
    opacity: 1,
    transition: {
      default: { type: 'spring' },
      opacity: { ease: 'linear' }
    }
  }"
/>

// animate() function
animate("li", { x: 0, opacity: 1 }, {
  default: { type: "spring" },
  opacity: { ease: "linear" }
})

### [Default transitions](#default-transitions)

It's possible to set default transitions via the `transition` prop. Either for specific `motion` components:

<motion.div
  :animate="{ x: 100 }"
  :transition="{ type: 'spring', stiffness: 100 }"
/>

Or for a group of `motion` components via`[MotionConfig](https://motion.dev/vue-motion-config#transition)`:

<MotionConfig :transition="{ duration: 0.4, ease: 'easeInOut' }">
  <App />
</MotionConfig>

## [Transition settings](#transition-settings)

#### [`type`](#type)

**Default:**Dynamic

`type` decides the type of animation to use. It can be `"tween"`, `"spring"` or `"inertia"`.

**Tween** animations are set with a duration and an easing curve.

**Spring** animations are either physics-based or duration-based.

Physics-based spring animations are set via `stiffness`, `damping` and `mass`, and these incorporate the velocity of any existing gestures or animations for natural feedback.

Duration-based spring animations are set via a `duration` and `bounce`. These don't incorporate velocity but are easier to understand.

**Inertia** animations decelerate a value based on its initial velocity, usually used to implement inertial scrolling.

<motion.path
  :animate="{ pathLength: 1 }"
  :transition="{ duration: 2, type: 'tween' }"
/>

#### [Spring visualiser](#spring-visualiser)

Time Physics

DurationBounceUse visual duration

### [Tween](#tween)

#### [`duration`](#duration)

**Default:**`0.3` (or `0.8` if multiple keyframes are defined)

The duration of the animation. Can also be used for `"spring"` animations when `bounce` is also set.

animate("ul > li", { opacity: 1 }, { duration: 1 })

#### [`ease`](#ease)

The easing function to use with tween animations. Accepts:

- Easing function name. E.g `"linear"`
- An array of four numbers to define a cubic bezier curve. E.g `[.17,.67,.83,.67]`
- A JavaScript easing function, that accepts and returns a value `0`-`1`.

These are the available easing function names:

- `"linear"`
- `"easeIn"`, `"easeOut"`, `"easeInOut"`
- `"circIn"`, `"circOut"`, `"circInOut"`
- `"backIn"`, `"backOut"`, `"backInOut"`
- `"anticipate"`

When animating keyframes, `ease` can optionally be set as an array of easing functions to set different easings between each value:

<motion.div
  :animate="{
    x: [0, 100, 0],
    transition: { ease: ['easeIn', 'easeOut'] }
  }"
/>

For immediate visual feedback, you can edit CSS or Motion easing curves directly in your code editor with the Motion extension.

#### [`times`](#times)

When animating multiple keyframes, `times` can be used to adjust the position of each keyframe throughout the animation.

Each value in `times` is a value between `0` and `1`, representing the start and end of the animation.

<motion.div
  :animate="{
    x: [0, 100, 0],
    transition: { times: [0, 0.3, 1] }
  }"
/>

There must be the same number of `times` as there are keyframes. Defaults to an array of evenly-spread durations.

### [Spring](#spring)

#### [`bounce`](#bounce)

**Default:** `0.25`

`bounce` determines the "bounciness" of a spring animation.

`0` is no bounce, and `1` is extremely bouncy.

**Note:** `bounce` and `duration` will be overridden if `stiffness`, `damping` or `mass` are set.

<motion.div
  :animate="{ rotateX: 90 }"
  :transition="{ type: 'spring', bounce: 0.25 }"
/>

#### [`visualDuration`](#visualduration)

If `visualDuration` is set, this will override `duration`.

The visual duration is a time, **set in seconds**, that the animation will take to visually appear to reach its target.

In other words, the bulk of the transition will occur before this time, and the "bouncy bit" will mostly happen after.

This makes it easier to edit a spring, as well as visually coordinate it with other time-based animations.

<motion.div
  :animate="{ rotateX: 90 }"
  :transition="{
    type: 'spring',
    visualDuration: 0.5,
    bounce: 0.25
  }"
/>

#### [`damping`](#damping)

**Default:** `10`

Strength of opposing force. If set to 0, spring will oscillate indefinitely.

<motion.a
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', damping: 300 }"
/>

#### [`mass`](#mass)

**Default:** `1`

Mass of the moving object. Higher values will result in more lethargic movement.

<motion.feTurbulence
  :animate="{ baseFrequency: 0.5 }"
  :transition="{ type: 'spring', mass: 0.5 }"
/>

#### [`stiffness`](#stiffness)

**Default:** `1`

Stiffness of the spring. Higher values will create more sudden movement.

<motion.section
  animate={{ rotate: 180 }}
  transition={{ type: 'spring', stiffness: 50 }}
/>

> _I never really understood how_`_damping_`_,_`_mass_`_ and_`_stiffness_`_ influence a spring animation, so I made a__tool for myself__ to visualise it._~ Emil Kowalski, Animations on the Web
#### [`velocity`](#velocity)

**Default:** Current value velocity

The initial velocity of the spring.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', velocity: 2 }"
/>

#### [`restSpeed`](#restspeed)

**Default:** `0.1`

End animation if absolute speed (in units per second) drops below this value and delta is smaller than `restDelta`.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', restSpeed: 0.5 }"
/>

#### [`restDelta`](#restdelta)

**Default:** `0.01`

End animation if distance is below this value and speed is below `restSpeed`. When animation ends, the spring will end.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ type: 'spring', restDelta: 0.5 }"
/>

### [Inertia](#inertia)

An animation that decelerates a value based on its initial velocity. Optionally, `min` and `max` boundaries can be defined, and inertia will snap to these with a spring animation.

This animation will automatically precalculate a target value, which can be modified with the `modifyTarget` property.

This allows you to add snap-to-grid or similar functionality.

Inertia is also the animation used for `dragTransition`, and can be configured via that prop.

#### [`power`](#power)

**Default:**`0.8`

A higher power value equals a further calculated target.

<motion.div
  drag
  :dragTransition="{ power: 0.2 }"
/>

#### [`timeConstant`](#timeconstant)

**Default:**`**700**`

Adjusting the time constant will change the duration of the deceleration, thereby affecting its feel.

<motion.div
  drag
  :dragTransition="{ timeConstant: 200 }"
/>

#### [`modifyTarget`](#modifytarget)

A function that receives the automatically-calculated target and returns a new one. Useful for snapping the target to a grid.

<motion.div
  drag
  // dragTransition always type: inertia
  :dragTransition="{
    power: 0,
    // Snap calculated target to nearest 50 pixels
    modifyTarget: target => Math.round(target / 50) * 50
  }"
/>

#### [`min`](#min)

Minimum constraint. If set, the value will "bump" against this value (or immediately spring to it if the animation starts as less than this value).

<motion.div
  drag
  :dragTransition="{ min: 0, max: 100 }"
/>

#### [`max`](#max)

Maximum constraint. If set, the value will "bump" against this value (or immediately snap to it, if the initial animation value exceeds this value).

<motion.div
  drag
  :dragTransition="{ min: 0, max: 100 }"
/>

#### [`bounceStiffness`](#bouncestiffness)

**Default:**`500`

If `min` or `max` is set, this affects the stiffness of the bounce spring. Higher values will create more sudden movement.

<motion.div
  drag
  :dragTransition="{
    min: 0,
    max: 100,
    bounceStiffness: 100
  }"
/>

#### [`bounceDamping`](#bouncedamping)

**Default:**`10`

If `min` or `max` is set, this affects the damping of the bounce spring. If set to `0`, spring will oscillate indefinitely.

<motion.div
  drag
  :dragTransition="{
    min: 0,
    max: 100,
    bounceStiffness: 100
  }"
/>

### [Orchestration](#orchestration)

#### [`delay`](#delay)

**Default:**`0`

Delay the animation by this duration (in seconds).

animate(element, { filter: "blur(10px)" }, { delay: 0.3 })

By setting `delay` to a negative value, the animation will start that long into the animation. For instance to start 1 second in, `delay` can be set to -`1`.

#### [`repeat`](#repeat)

**Default:**`0`

The number of times to repeat the transition. Set to `Infinity` for perpetual animation.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ repeat: Infinity, duration: 2 }"
/>

#### [`repeatType`](#repeattype)

**Default:**`"loop"`

How to repeat the animation. This can be either:

- `loop`: Repeats the animation from the start.
- `reverse`: Alternates between forward and backwards playback.
- `mirror`: Switches animation origin and target on each iteration.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{
    repeat: 1,
    repeatType: 'reverse',
    duration: 2
  }"
/>

#### [`repeatDelay`](#repeatdelay)

**Default:**`0`

When repeating an animation, `repeatDelay` will set the duration of the time to wait, in seconds, between each repetition.

<motion.div
  :animate="{ rotate: 180 }"
  :transition="{ repeat: Infinity, repeatDelay: 1 }"
/>

#### [`when`](#when)

**Default:**`false`

With variants, describes when an animation should trigger, relative to that of its children.

- `"beforeChildren"`: Children animations will play after the parent animation finishes.
- `"afterChildren"`: Parent animations will play after the children animations finish.



<template>
  <motion.ul :variants="list" animate="hidden">
    <motion.li :variants="item" />
    <motion.li :variants="item" />
  </motion.ul>
</template>

#### [`delayChildren`](#delaychildren)

**Default:**`0`

With variants, setting `delayChildren` on a parent will delay child animations by this duration (in seconds).

<sctipt setup>  
const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: {
      delayChildren: 0.5
    }
  }
}

const item = {
  hidden: { opacity: 0 },
  show: { opacity: 1 }
}
</sctipt>

<template> 
  <motion.ul
    :variants="container"
    initial="hidden"
    animate="show"
  >
    <motion.li :variants="item" />
    <motion.li :variants="item"/>
  </motion.ul>
</template>

Using the `[stagger](https://motion.dev/stagger)` function, we can stagger the delay across children.

const transition = {
  delayChildren: stagger(0.1)
}

By default, delay will stagger across children from first to last. By using `stagger`'s `from` option, we can stagger from the last child, the center, or a specific index.

const transition = {
  delayChildren: stagger(0.1, { from: "last" })
}

Previous

Scroll animation

Next

Motion component

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