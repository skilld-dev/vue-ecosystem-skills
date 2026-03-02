---
title: "Vue animations with Motion for Vue | Motion"
meta:
  "og:description": "Animate UIs in Motion for Vue with motion components. Animate CSS, transforms, &amp; SVGs. Use variants for orchestration, gestures, and keyframes."
  "og:title": "Vue animations with Motion for Vue | Motion"
  "twitter:description": "Animate UIs in Motion for Vue with motion components. Animate CSS, transforms, &amp; SVGs. Use variants for orchestration, gestures, and keyframes."
  "twitter:title": "Vue animations with Motion for Vue | Motion"
  description: "Animate UIs in Motion for Vue with motion components. Animate CSS, transforms, &amp; SVGs. Use variants for orchestration, gestures, and keyframes."
---

Vue

# Vue animation

Motion for Vue offers a number of ways to animate your UI. Scaling from extremely simple prop-based animations, to more complex orchestration.

## [Basic animations](#basic-animations)

You'll perform almost all animations on a`[<motion />](https://motion.dev/vue-motion-component)` component. This is basically a DOM element with motion superpowers.

import { motion } from "motion-v"

For basic animations, you can update values on the`[animate](https://motion.dev/vue-motion-component#animate)` prop:

<motion.div :animate="{ opacity: 1 }" />

When any value in its animate prop changes, the component will automatically animate to the new target.

## [Animatable values](#animatable-values)

Motion can animate any CSS value, even those that can't be animated by browsers, like `mask-image`. It supports:

- Numbers: `0`, `100` etc.
- Strings containing numbers: `"0vh"`, `"10px"` etc.
- Colors: Hex, RGBA, HSLA.
- Complex strings containing multiple numbers and/or colors (like `box-shadow`).
- `display: "none"/"block"` and `visibility: "hidden"/"visible"`.

### [Value type conversion](#value-type-conversion)

In general, values can only be animated between two of the same type (i.e `"0px"` to `"100px"`).

Colors can be freely animated between hex, RGBA and HSLA types.

Additionally, `x`, `y`, `width`, `height`, `top`, `left`, `right` and `bottom` can animate between different value types.

<motion.div
  :initial='{ x: "100%" }'
  :animate='{ x: "calc(100vw - 50%)" }'
/>

It's also possible to animate `width` and `height` in to/out of `"auto"`.

<motion.div
  :initial='{ height: "0px" }'
  :animate='{ height: "auto" }'
/>

**Note:**If additionally animating `display` in to/out of `"none"`, replace this with `visibility` `"hidden"` as elements with `display: none` can't be measured.

### [Transforms](#transforms)

Unlike CSS, Motion can animate every transform axis independently:

- Translate: `x`, `y`, `z`
- Scale: `scale`, `scaleX`, `scaleY`
- Rotate: `rotate`, `rotateX`, `rotateY`, `rotateZ`
- Skew: `skewX`, `skewY`
- Perspective: `transformPerspective`

`motion` components have enhanced `style` props, allowing you to set individual transforms:

<motion.section :style="{ x: -20 }" />

Animating transforms independently provides great flexibility, especially around gestures.

<motion.button :whileHover="{ scale: 1.1 }" whilePress="{ scale: 0.9 }" />

Independent transforms perform great, but Motion's hybrid engine also uniquely offers hardware acceleration by setting `transform` directly.

<motion.li
  :initial='{ transform: "translateX(-100px)" }'
  :animate='{ transform: "translateX(0px)" }'
  :transition='{ type: "spring" }'
/>

**SVG note:** For SVG components, `x` and `y` **attributes** can be set using `attrX` and `attrY`.

### [Transform origin](#transform-origin)

`transform-origin` has three shortcut values that can be set and animated individually:

- `originX`
- `originY`
- `originZ`

If set as numbers, `originX` and `Y` default to a progress value between `0` and `1`. `originZ` defaults to pixels.

<motion.div :style='{ originX: 0.5 }' />

### [CSS variables](#css-variables)

Motion for Vue can animate the value of CSS variables, and also use CSS variables as animation targets.

#### [Animating CSS variables](#animating-css-variables)

Sometimes it's convenient to be able to animate a CSS variable to animate many children:

<motion.ul
  :initial="{ '--rotate': '0deg' }"
  :animate="{ '--rotate': '360deg' }"
  :transition="{ duration: 2, repeat: Infinity }"
>
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
</motion.ul>

**Note:**Animating the value of a CSS variable **always triggers paint**, therefore it can be more performant to use `[MotionValue](https://motion.dev/vue-motion-value)`s to setup this kind of animation.

### [CSS variables as animation targets](#css-variables-as-animation-targets)

HTML `motion` components accept animation targets with CSS variables:

<motion.li :animate="{ backgroundColor: 'var(--action-bg)' }" />

#### [SVG line drawing](#svg-line-drawing)

Line drawing animations can be created with many different SVG elements using three special properties: `pathLength`, `pathSpacing` and `pathOffset`.

<motion.path :initial="{ pathLength: 0 }" :animate="{ pathLength: 1 }" />

All three are set as a progress value between `0` and `1`, `1` representing the total length of the path.

Path animations are compatible with `circle`, `ellipse`, `line`, `path`, `polygon`, `polyline` and `rect` elements.

## [Transitions](#transitions)

By default, Motion will create appropriate transitions for snappy animations based on the type of value being animated.

For instance, physical properties like `x` or `scale` are animated with spring physics, whereas values like `opacity` or `color` are animated with duration-based easing curves.

However, you can define your own animations via the`[transition](https://motion.dev/vue-transitions)` prop.

<motion.div
  :animate="{ x: 100 }"
  :transition="{ ease: 'easeOut', duration: 2 }"
/>

## [Enter animations](#enter-animations)

When a `motion` component is first created, it'll automatically animate to the values in `animate` if they're different from those initially rendered, which you can either do via CSS or via the`[initial](https://motion.dev/vue-motion-component)` prop.

<motion.li
  :initial="{ opacity: 0, scale: 0 }"
  :animate="{ opacity: 1, scale: 1 }"
/>

You can also disable the enter animation entirely by setting `:initial="false"`. This will make the element render with the values defined in `animate`.

<motion.div :initial="false" :animate="{ y: 100 }" />

## [Exit animations](#exit-animations)

You can also easily animate elements as they exit the DOM.

In Vue, when a component is removed, it's usually removed instantly. Motion provides the`[AnimatePresence](https://motion.dev/vue-animate-presence)` component which keeps elements in the DOM while they perform an `exit` animation.

<AnimatePresence>
    <motion.div
      v-if="isVisible"
      key="modal"
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      :exit="{ opacity: 0 }"
    />
</AnimatePresence>

## [Keyframes](#keyframes)

Values in `animate` can be set as a series of keyframes. This will animate through each value in sequence.

<motion.div :animate="{ x: [0, 100, 0] }" />

We can use a value's current state as the initial keyframe by setting it to `null`.

<motion.div :animate="{ x: [null, 100, 0] }" />

This way, if a keyframe animation is interrupting another animation, the transition will feel more natural.

By default, each keyframe is spaced naturally throughout the animation. You can override this by setting the`[times](https://motion.dev/vue-transitions#times)` option via `transition`.

`times` is an array of progress values between `0` and `1`, defining where in the animation each keyframe should be positioned.

<motion.circle
  :cx="500"
  :animate="{
    cx: [null, 100, 200],
    transition={{ duration: 3, times: [0, 0.2, 1] }}
  }"
/>

## [Gesture animations](#gesture-animations)

Motion for Vue has shortcut props for animating to/from a target when a gesture starts/ends.

<motion.button
  :initial="{ opacity: 0 }"
  :whileHover="{ backgroundColor: 'rgba(220, 220, 220, 1)' }"
  :whilePress="{ backgroundColor: 'rgba(255, 255, 255, 1)' }"
  :whileInView="{ opacity: 1 }"
/>

It supports `hover`, `press`, `drag`, `focus` and `inView`.

## [Variants](#variants)

Setting `animate` as a target is useful for simple, single-element animations. But sometimes we want to orchestrate animations that propagate throughout the DOM. We can do so with variants.

Variants are a set of named targets.

const variants = {
  visible: { opacity: 1 },
  hidden: { opacity: 0 },
}

They're passed to `motion` components via the `variants` prop:

<motion.div :variants="variants" />

These variants can now be referred to by a label, wherever you can define an animation target:

<motion.div
  :variants="variants"
  initial="hidden"
  animate="visible"
/>

You can also define multiple variants via an array:

:animate="['visible', 'danger']"

### [Propagation](#propagation)

This is already useful for reusing and combining animation targets. But it becomes powerful for orchestrating animations throughout trees.

Variants will flow down through `motion` components. So in this example when the `ul` enters the viewport, all of its children with a "visible" variant will also animate in:

const list = {
  visible: { opacity: 1 },
  hidden: { opacity: 0 },
}

const item = {
  visible: { opacity: 1, x: 0 },
  hidden: { opacity: 0, x: -100 },
}

return (
  <motion.ul
    initial="hidden"
    whileInView="visible"
    :variants="list"
  >
    <motion.li :variants="item" />
    <motion.li :variants="item" />
    <motion.li :variants="item" />
  </motion.ul>
)

### [Orchestration](#orchestration)

By default, this children animations will start simultaneously with the parent. But with variants we gain access to new `transition` props like `[when](https://motion.dev/vue-transitions#orchestration)` and`[delayChildren](https://motion.dev/vue-transitions#orchestration)`.

const list = {
  visible: {
    opacity: 1,
    transition: {
      when: "beforeChildren",
      delayChildren: stagger(0.3), // Stagger children by .3 seconds
    },
  },
  hidden: {
    opacity: 0,
    transition: {
      when: "afterChildren",
    },
  },
}

### [Dynamic variants](#dynamic-variants)

Each variant can be defined as a function that resolves when a variant is made active.

const variants = {
  hidden: { opacity: 0 },
  visible: (index) => ({
    opacity: 1,
    transition: { delay: index * 0.3 }
  })
}

These functions are provided a single argument, which is passed via the `custom` prop:

<motion.div v-for="(item,index) in items" :custom="index" :variants="variants" />

This way, variants can be resolved differently for each animating element.

## [Animation controls](#animation-controls)

Declarative animations are ideal for most UI interactions. But sometimes we need to take manual control over animation playback.

The `[useAnimate](https://motion.dev/vue-use-animate)` hook can be used for:

- Animating any HTML/SVG element (not just `motion` components).
- Complex animation sequences.
- Controlling animations with `time`, `speed`, `play()`, `pause()` and other playback controls.



<template>
  <ul ref="scope">
    <li />
    <li />
    <li />
  </ul>
</template>

## [Animate content](#animate-content)

By passing a`[MotionValue](https://motion.dev/vue-motion-value)` as value prop to a `RowValue` component, it will render its latest value in the HTML.



<template>
 <motion.pre><RowValue :value="count"/></motion.pre> 
</template>

This is more performant than setting Vue state as the `RowValue` component will set `innerHTML` directly.

Motion for Vue offers a number of ways to animate your UI. Scaling from extremely simple prop-based animations, to more complex orchestration.

## [Basic animations](#basic-animations)

You'll perform almost all animations on a`[<motion />](https://motion.dev/vue-motion-component)` component. This is basically a DOM element with motion superpowers.

import { motion } from "motion-v"

For basic animations, you can update values on the`[animate](https://motion.dev/vue-motion-component#animate)` prop:

<motion.div :animate="{ opacity: 1 }" />

When any value in its animate prop changes, the component will automatically animate to the new target.

## [Animatable values](#animatable-values)

Motion can animate any CSS value, even those that can't be animated by browsers, like `mask-image`. It supports:

- Numbers: `0`, `100` etc.
- Strings containing numbers: `"0vh"`, `"10px"` etc.
- Colors: Hex, RGBA, HSLA.
- Complex strings containing multiple numbers and/or colors (like `box-shadow`).
- `display: "none"/"block"` and `visibility: "hidden"/"visible"`.

### [Value type conversion](#value-type-conversion)

In general, values can only be animated between two of the same type (i.e `"0px"` to `"100px"`).

Colors can be freely animated between hex, RGBA and HSLA types.

Additionally, `x`, `y`, `width`, `height`, `top`, `left`, `right` and `bottom` can animate between different value types.

<motion.div
  :initial='{ x: "100%" }'
  :animate='{ x: "calc(100vw - 50%)" }'
/>

It's also possible to animate `width` and `height` in to/out of `"auto"`.

<motion.div
  :initial='{ height: "0px" }'
  :animate='{ height: "auto" }'
/>

**Note:**If additionally animating `display` in to/out of `"none"`, replace this with `visibility` `"hidden"` as elements with `display: none` can't be measured.

### [Transforms](#transforms)

Unlike CSS, Motion can animate every transform axis independently:

- Translate: `x`, `y`, `z`
- Scale: `scale`, `scaleX`, `scaleY`
- Rotate: `rotate`, `rotateX`, `rotateY`, `rotateZ`
- Skew: `skewX`, `skewY`
- Perspective: `transformPerspective`

`motion` components have enhanced `style` props, allowing you to set individual transforms:

<motion.section :style="{ x: -20 }" />

Animating transforms independently provides great flexibility, especially around gestures.

<motion.button :whileHover="{ scale: 1.1 }" whilePress="{ scale: 0.9 }" />

Independent transforms perform great, but Motion's hybrid engine also uniquely offers hardware acceleration by setting `transform` directly.

<motion.li
  :initial='{ transform: "translateX(-100px)" }'
  :animate='{ transform: "translateX(0px)" }'
  :transition='{ type: "spring" }'
/>

**SVG note:** For SVG components, `x` and `y` **attributes** can be set using `attrX` and `attrY`.

### [Transform origin](#transform-origin)

`transform-origin` has three shortcut values that can be set and animated individually:

- `originX`
- `originY`
- `originZ`

If set as numbers, `originX` and `Y` default to a progress value between `0` and `1`. `originZ` defaults to pixels.

<motion.div :style='{ originX: 0.5 }' />

### [CSS variables](#css-variables)

Motion for Vue can animate the value of CSS variables, and also use CSS variables as animation targets.

#### [Animating CSS variables](#animating-css-variables)

Sometimes it's convenient to be able to animate a CSS variable to animate many children:

<motion.ul
  :initial="{ '--rotate': '0deg' }"
  :animate="{ '--rotate': '360deg' }"
  :transition="{ duration: 2, repeat: Infinity }"
>
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
</motion.ul>

**Note:**Animating the value of a CSS variable **always triggers paint**, therefore it can be more performant to use `[MotionValue](https://motion.dev/vue-motion-value)`s to setup this kind of animation.

### [CSS variables as animation targets](#css-variables-as-animation-targets)

HTML `motion` components accept animation targets with CSS variables:

<motion.li :animate="{ backgroundColor: 'var(--action-bg)' }" />

#### [SVG line drawing](#svg-line-drawing)

Line drawing animations can be created with many different SVG elements using three special properties: `pathLength`, `pathSpacing` and `pathOffset`.

<motion.path :initial="{ pathLength: 0 }" :animate="{ pathLength: 1 }" />

All three are set as a progress value between `0` and `1`, `1` representing the total length of the path.

Path animations are compatible with `circle`, `ellipse`, `line`, `path`, `polygon`, `polyline` and `rect` elements.

## [Transitions](#transitions)

By default, Motion will create appropriate transitions for snappy animations based on the type of value being animated.

For instance, physical properties like `x` or `scale` are animated with spring physics, whereas values like `opacity` or `color` are animated with duration-based easing curves.

However, you can define your own animations via the`[transition](https://motion.dev/vue-transitions)` prop.

<motion.div
  :animate="{ x: 100 }"
  :transition="{ ease: 'easeOut', duration: 2 }"
/>

## [Enter animations](#enter-animations)

When a `motion` component is first created, it'll automatically animate to the values in `animate` if they're different from those initially rendered, which you can either do via CSS or via the`[initial](https://motion.dev/vue-motion-component)` prop.

<motion.li
  :initial="{ opacity: 0, scale: 0 }"
  :animate="{ opacity: 1, scale: 1 }"
/>

You can also disable the enter animation entirely by setting `:initial="false"`. This will make the element render with the values defined in `animate`.

<motion.div :initial="false" :animate="{ y: 100 }" />

## [Exit animations](#exit-animations)

You can also easily animate elements as they exit the DOM.

In Vue, when a component is removed, it's usually removed instantly. Motion provides the`[AnimatePresence](https://motion.dev/vue-animate-presence)` component which keeps elements in the DOM while they perform an `exit` animation.

<AnimatePresence>
    <motion.div
      v-if="isVisible"
      key="modal"
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      :exit="{ opacity: 0 }"
    />
</AnimatePresence>

## [Keyframes](#keyframes)

Values in `animate` can be set as a series of keyframes. This will animate through each value in sequence.

<motion.div :animate="{ x: [0, 100, 0] }" />

We can use a value's current state as the initial keyframe by setting it to `null`.

<motion.div :animate="{ x: [null, 100, 0] }" />

This way, if a keyframe animation is interrupting another animation, the transition will feel more natural.

By default, each keyframe is spaced naturally throughout the animation. You can override this by setting the`[times](https://motion.dev/vue-transitions#times)` option via `transition`.

`times` is an array of progress values between `0` and `1`, defining where in the animation each keyframe should be positioned.

<motion.circle
  :cx="500"
  :animate="{
    cx: [null, 100, 200],
    transition={{ duration: 3, times: [0, 0.2, 1] }}
  }"
/>

## [Gesture animations](#gesture-animations)

Motion for Vue has shortcut props for animating to/from a target when a gesture starts/ends.

<motion.button
  :initial="{ opacity: 0 }"
  :whileHover="{ backgroundColor: 'rgba(220, 220, 220, 1)' }"
  :whilePress="{ backgroundColor: 'rgba(255, 255, 255, 1)' }"
  :whileInView="{ opacity: 1 }"
/>

It supports `hover`, `press`, `drag`, `focus` and `inView`.

## [Variants](#variants)

Setting `animate` as a target is useful for simple, single-element animations. But sometimes we want to orchestrate animations that propagate throughout the DOM. We can do so with variants.

Variants are a set of named targets.

const variants = {
  visible: { opacity: 1 },
  hidden: { opacity: 0 },
}

They're passed to `motion` components via the `variants` prop:

<motion.div :variants="variants" />

These variants can now be referred to by a label, wherever you can define an animation target:

<motion.div
  :variants="variants"
  initial="hidden"
  animate="visible"
/>

You can also define multiple variants via an array:

:animate="['visible', 'danger']"

### [Propagation](#propagation)

This is already useful for reusing and combining animation targets. But it becomes powerful for orchestrating animations throughout trees.

Variants will flow down through `motion` components. So in this example when the `ul` enters the viewport, all of its children with a "visible" variant will also animate in:

const list = {
  visible: { opacity: 1 },
  hidden: { opacity: 0 },
}

const item = {
  visible: { opacity: 1, x: 0 },
  hidden: { opacity: 0, x: -100 },
}

return (
  <motion.ul
    initial="hidden"
    whileInView="visible"
    :variants="list"
  >
    <motion.li :variants="item" />
    <motion.li :variants="item" />
    <motion.li :variants="item" />
  </motion.ul>
)

### [Orchestration](#orchestration)

By default, this children animations will start simultaneously with the parent. But with variants we gain access to new `transition` props like `[when](https://motion.dev/vue-transitions#orchestration)` and`[delayChildren](https://motion.dev/vue-transitions#orchestration)`.

const list = {
  visible: {
    opacity: 1,
    transition: {
      when: "beforeChildren",
      delayChildren: stagger(0.3), // Stagger children by .3 seconds
    },
  },
  hidden: {
    opacity: 0,
    transition: {
      when: "afterChildren",
    },
  },
}

### [Dynamic variants](#dynamic-variants)

Each variant can be defined as a function that resolves when a variant is made active.

const variants = {
  hidden: { opacity: 0 },
  visible: (index) => ({
    opacity: 1,
    transition: { delay: index * 0.3 }
  })
}

These functions are provided a single argument, which is passed via the `custom` prop:

<motion.div v-for="(item,index) in items" :custom="index" :variants="variants" />

This way, variants can be resolved differently for each animating element.

## [Animation controls](#animation-controls)

Declarative animations are ideal for most UI interactions. But sometimes we need to take manual control over animation playback.

The `[useAnimate](https://motion.dev/vue-use-animate)` hook can be used for:

- Animating any HTML/SVG element (not just `motion` components).
- Complex animation sequences.
- Controlling animations with `time`, `speed`, `play()`, `pause()` and other playback controls.



<template>
  <ul ref="scope">
    <li />
    <li />
    <li />
  </ul>
</template>

## [Animate content](#animate-content)

By passing a`[MotionValue](https://motion.dev/vue-motion-value)` as value prop to a `RowValue` component, it will render its latest value in the HTML.



<template>
 <motion.pre><RowValue :value="count"/></motion.pre> 
</template>

This is more performant than setting Vue state as the `RowValue` component will set `innerHTML` directly.

Motion for Vue offers a number of ways to animate your UI. Scaling from extremely simple prop-based animations, to more complex orchestration.

## [Basic animations](#basic-animations)

You'll perform almost all animations on a`[<motion />](https://motion.dev/vue-motion-component)` component. This is basically a DOM element with motion superpowers.

import { motion } from "motion-v"

For basic animations, you can update values on the`[animate](https://motion.dev/vue-motion-component#animate)` prop:

<motion.div :animate="{ opacity: 1 }" />

When any value in its animate prop changes, the component will automatically animate to the new target.

## [Animatable values](#animatable-values)

Motion can animate any CSS value, even those that can't be animated by browsers, like `mask-image`. It supports:

- Numbers: `0`, `100` etc.
- Strings containing numbers: `"0vh"`, `"10px"` etc.
- Colors: Hex, RGBA, HSLA.
- Complex strings containing multiple numbers and/or colors (like `box-shadow`).
- `display: "none"/"block"` and `visibility: "hidden"/"visible"`.

### [Value type conversion](#value-type-conversion)

In general, values can only be animated between two of the same type (i.e `"0px"` to `"100px"`).

Colors can be freely animated between hex, RGBA and HSLA types.

Additionally, `x`, `y`, `width`, `height`, `top`, `left`, `right` and `bottom` can animate between different value types.

<motion.div
  :initial='{ x: "100%" }'
  :animate='{ x: "calc(100vw - 50%)" }'
/>

It's also possible to animate `width` and `height` in to/out of `"auto"`.

<motion.div
  :initial='{ height: "0px" }'
  :animate='{ height: "auto" }'
/>

**Note:**If additionally animating `display` in to/out of `"none"`, replace this with `visibility` `"hidden"` as elements with `display: none` can't be measured.

### [Transforms](#transforms)

Unlike CSS, Motion can animate every transform axis independently:

- Translate: `x`, `y`, `z`
- Scale: `scale`, `scaleX`, `scaleY`
- Rotate: `rotate`, `rotateX`, `rotateY`, `rotateZ`
- Skew: `skewX`, `skewY`
- Perspective: `transformPerspective`

`motion` components have enhanced `style` props, allowing you to set individual transforms:

<motion.section :style="{ x: -20 }" />

Animating transforms independently provides great flexibility, especially around gestures.

<motion.button :whileHover="{ scale: 1.1 }" whilePress="{ scale: 0.9 }" />

Independent transforms perform great, but Motion's hybrid engine also uniquely offers hardware acceleration by setting `transform` directly.

<motion.li
  :initial='{ transform: "translateX(-100px)" }'
  :animate='{ transform: "translateX(0px)" }'
  :transition='{ type: "spring" }'
/>

**SVG note:** For SVG components, `x` and `y` **attributes** can be set using `attrX` and `attrY`.

### [Transform origin](#transform-origin)

`transform-origin` has three shortcut values that can be set and animated individually:

- `originX`
- `originY`
- `originZ`

If set as numbers, `originX` and `Y` default to a progress value between `0` and `1`. `originZ` defaults to pixels.

<motion.div :style='{ originX: 0.5 }' />

### [CSS variables](#css-variables)

Motion for Vue can animate the value of CSS variables, and also use CSS variables as animation targets.

#### [Animating CSS variables](#animating-css-variables)

Sometimes it's convenient to be able to animate a CSS variable to animate many children:

<motion.ul
  :initial="{ '--rotate': '0deg' }"
  :animate="{ '--rotate': '360deg' }"
  :transition="{ duration: 2, repeat: Infinity }"
>
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
  <li :style="{ transform: 'rotate(var(--rotate))' }" />
</motion.ul>

**Note:**Animating the value of a CSS variable **always triggers paint**, therefore it can be more performant to use `[MotionValue](https://motion.dev/vue-motion-value)`s to setup this kind of animation.

### [CSS variables as animation targets](#css-variables-as-animation-targets)

HTML `motion` components accept animation targets with CSS variables:

<motion.li :animate="{ backgroundColor: 'var(--action-bg)' }" />

#### [SVG line drawing](#svg-line-drawing)

Line drawing animations can be created with many different SVG elements using three special properties: `pathLength`, `pathSpacing` and `pathOffset`.

<motion.path :initial="{ pathLength: 0 }" :animate="{ pathLength: 1 }" />

All three are set as a progress value between `0` and `1`, `1` representing the total length of the path.

Path animations are compatible with `circle`, `ellipse`, `line`, `path`, `polygon`, `polyline` and `rect` elements.

## [Transitions](#transitions)

By default, Motion will create appropriate transitions for snappy animations based on the type of value being animated.

For instance, physical properties like `x` or `scale` are animated with spring physics, whereas values like `opacity` or `color` are animated with duration-based easing curves.

However, you can define your own animations via the`[transition](https://motion.dev/vue-transitions)` prop.

<motion.div
  :animate="{ x: 100 }"
  :transition="{ ease: 'easeOut', duration: 2 }"
/>

## [Enter animations](#enter-animations)

When a `motion` component is first created, it'll automatically animate to the values in `animate` if they're different from those initially rendered, which you can either do via CSS or via the`[initial](https://motion.dev/vue-motion-component)` prop.

<motion.li
  :initial="{ opacity: 0, scale: 0 }"
  :animate="{ opacity: 1, scale: 1 }"
/>

You can also disable the enter animation entirely by setting `:initial="false"`. This will make the element render with the values defined in `animate`.

<motion.div :initial="false" :animate="{ y: 100 }" />

## [Exit animations](#exit-animations)

You can also easily animate elements as they exit the DOM.

In Vue, when a component is removed, it's usually removed instantly. Motion provides the`[AnimatePresence](https://motion.dev/vue-animate-presence)` component which keeps elements in the DOM while they perform an `exit` animation.

<AnimatePresence>
    <motion.div
      v-if="isVisible"
      key="modal"
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      :exit="{ opacity: 0 }"
    />
</AnimatePresence>

## [Keyframes](#keyframes)

Values in `animate` can be set as a series of keyframes. This will animate through each value in sequence.

<motion.div :animate="{ x: [0, 100, 0] }" />

We can use a value's current state as the initial keyframe by setting it to `null`.

<motion.div :animate="{ x: [null, 100, 0] }" />

This way, if a keyframe animation is interrupting another animation, the transition will feel more natural.

By default, each keyframe is spaced naturally throughout the animation. You can override this by setting the`[times](https://motion.dev/vue-transitions#times)` option via `transition`.

`times` is an array of progress values between `0` and `1`, defining where in the animation each keyframe should be positioned.

<motion.circle
  :cx="500"
  :animate="{
    cx: [null, 100, 200],
    transition={{ duration: 3, times: [0, 0.2, 1] }}
  }"
/>

## [Gesture animations](#gesture-animations)

Motion for Vue has shortcut props for animating to/from a target when a gesture starts/ends.

<motion.button
  :initial="{ opacity: 0 }"
  :whileHover="{ backgroundColor: 'rgba(220, 220, 220, 1)' }"
  :whilePress="{ backgroundColor: 'rgba(255, 255, 255, 1)' }"
  :whileInView="{ opacity: 1 }"
/>

It supports `hover`, `press`, `drag`, `focus` and `inView`.

## [Variants](#variants)

Setting `animate` as a target is useful for simple, single-element animations. But sometimes we want to orchestrate animations that propagate throughout the DOM. We can do so with variants.

Variants are a set of named targets.

const variants = {
  visible: { opacity: 1 },
  hidden: { opacity: 0 },
}

They're passed to `motion` components via the `variants` prop:

<motion.div :variants="variants" />

These variants can now be referred to by a label, wherever you can define an animation target:

<motion.div
  :variants="variants"
  initial="hidden"
  animate="visible"
/>

You can also define multiple variants via an array:

:animate="['visible', 'danger']"

### [Propagation](#propagation)

This is already useful for reusing and combining animation targets. But it becomes powerful for orchestrating animations throughout trees.

Variants will flow down through `motion` components. So in this example when the `ul` enters the viewport, all of its children with a "visible" variant will also animate in:

const list = {
  visible: { opacity: 1 },
  hidden: { opacity: 0 },
}

const item = {
  visible: { opacity: 1, x: 0 },
  hidden: { opacity: 0, x: -100 },
}

return (
  <motion.ul
    initial="hidden"
    whileInView="visible"
    :variants="list"
  >
    <motion.li :variants="item" />
    <motion.li :variants="item" />
    <motion.li :variants="item" />
  </motion.ul>
)

### [Orchestration](#orchestration)

By default, this children animations will start simultaneously with the parent. But with variants we gain access to new `transition` props like `[when](https://motion.dev/vue-transitions#orchestration)` and`[delayChildren](https://motion.dev/vue-transitions#orchestration)`.

const list = {
  visible: {
    opacity: 1,
    transition: {
      when: "beforeChildren",
      delayChildren: stagger(0.3), // Stagger children by .3 seconds
    },
  },
  hidden: {
    opacity: 0,
    transition: {
      when: "afterChildren",
    },
  },
}

### [Dynamic variants](#dynamic-variants)

Each variant can be defined as a function that resolves when a variant is made active.

const variants = {
  hidden: { opacity: 0 },
  visible: (index) => ({
    opacity: 1,
    transition: { delay: index * 0.3 }
  })
}

These functions are provided a single argument, which is passed via the `custom` prop:

<motion.div v-for="(item,index) in items" :custom="index" :variants="variants" />

This way, variants can be resolved differently for each animating element.

## [Animation controls](#animation-controls)

Declarative animations are ideal for most UI interactions. But sometimes we need to take manual control over animation playback.

The `[useAnimate](https://motion.dev/vue-use-animate)` hook can be used for:

- Animating any HTML/SVG element (not just `motion` components).
- Complex animation sequences.
- Controlling animations with `time`, `speed`, `play()`, `pause()` and other playback controls.



<template>
  <ul ref="scope">
    <li />
    <li />
    <li />
  </ul>
</template>

## [Animate content](#animate-content)

By passing a`[MotionValue](https://motion.dev/vue-motion-value)` as value prop to a `RowValue` component, it will render its latest value in the HTML.



<template>
 <motion.pre><RowValue :value="count"/></motion.pre> 
</template>

This is more performant than setting Vue state as the `RowValue` component will set `innerHTML` directly.

Previous

Get started with Motion for Vue

Next

Motion Directive

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