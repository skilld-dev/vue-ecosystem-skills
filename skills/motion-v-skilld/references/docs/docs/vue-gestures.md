---
title: "Vue gesture animations — hover, drag, press | Motion"
meta:
  "og:description": "Power your UI with Motion for Vue's gestures: hover, tap, pan, drag &amp; inView. Use while- props for animations &amp; event listeners for interactive experiences."
  "og:title": "Vue gesture animations — hover, drag, press | Motion"
  "twitter:description": "Power your UI with Motion for Vue's gestures: hover, tap, pan, drag &amp; inView. Use while- props for animations &amp; event listeners for interactive experiences."
  "twitter:title": "Vue gesture animations — hover, drag, press | Motion"
  description: "Power your UI with Motion for Vue's gestures: hover, tap, pan, drag &amp; inView. Use while- props for animations &amp; event listeners for interactive experiences."
---

Vue

# Gesture animation

Motion extends Vue's basic set of event listeners with a simple yet powerful set of UI gestures.

The `motion` component currently has support for **hover**, **press**, **pan**, **drag** and **inView**.

Each gesture has both a set of event listeners and a `while-` animation prop.

## [Animation props](#animation-props)

`motion` components provide multiple gesture animation props: `whileHover`, `whilePress`, `whileFocus`, `whileDrag` and `[whileInView](https://motion.dev/vue-scroll-animations)`. These can define animation targets to temporarily animate to while a gesture is active.

<motion.button
  :whileHover="{
    scale: 1.2,
    transition: { duration: 1 },
  }"
  :whilePress="{ scale: 0.9 }"
/>

All props can be set either as a target of values to animate to, or the name of any variants defined via the `variants` prop. Variants will flow down through children as normal.

<motion.button
  whilePress="press"
  whileHover="hover"
  :variants="buttonVariants"
>
  <svg>
    <motion.path :variants="iconVariants" />
  </svg>
</motion.button>

## [Gestures](#gestures)

### [Hover](#hover)

The hover gesture detects when a pointer hovers over or leaves a component.

It differs from `onMouseEnter` and `onMouseLeave` in that hover is guaranteed to only fire as a result of actual mouse events (as opposed to browser-generated mice events emulated from touch input).

<motion.a
  :whileHover="{ scale: 1.2 }"
  @hoverStart="event => {}"
  @hoverEnd="event => {}"

### [Press](#press)

The press gesture detects when the **primary pointer** (like a left click or first touch point) presses down and releases on the same component.

<motion.button :whilePress="{ scale: 0.9, rotate: 3 }" />

It will fire a `press` event when the tap or click ends on the same component it started on, and a `pressCancel` event if the press or click ends outside the component.

If the pressable component is a child of a draggable component, it'll automatically cancel the press gesture if the pointer moves further than 3 pixels during the gesture.

#### [Accessibility](#accessibility)

Elements with press events are keyboard-accessible.

Any element with a press prop will be able to receive focus and `Enter` can be used to trigger press events on focused elements.

- Pressing `Enter` down will trigger `onPressStart` and `whilePress`
- Releasing `Enter` will trigger `onPress`
- If the element loses focus before `Enter` is released, `onPressCancel` will fire.

### [Pan](#pan)

The pan gesture recognises when a pointer presses down on a component and moves further than 3 pixels. The pan gesture is ended when the pointer is released.

<motion.div @pan="(e, pointInfo) => {}" />

Pan doesn't currently have an associated `while-` prop.

**Note:** For pan gestures to work correctly with touch input, the element needs touch scrolling to be disabled on either x/y or both axis with the `[touch-action](https://developer.mozilla.org/en-US/docs/Web/CSS/touch-action)` CSS rule.

### [Drag](#drag)

The drag gesture applies pointer movement to the x and/or y axis of the component.

<motion.div drag :whileDrag="{ scale: 1.2, backgroundColor: '#f00' }" />

By default, when the drag ends the element will perform an inertia animation with the ending velocity.

This can be disabled by setting `dragMomentum` to `false`, or changed via the `dragTransition` prop.

#### [Constraints](#constraints)

It's also possible to set `dragConstraints`, either as an object with `top`, `left`, `right`, and `bottom` values, measured in pixels.

<motion.div
  drag="x"
  :dragConstraints="{ left: 0, right: 300 }"
/>

Or, it can accept an HTMLElement `ref` value. You can get the component's DOM ref value using `useDomRef` from `motion-v`, and pass it both to the draggable component's `dragConstraints` prop and the ref of the component you want to use as constraints.


<template>
  <motion.div ref="constraintsRef">
      <motion.div drag :dragConstraints="constraintsRef" />
  </motion.div>
</template>

By default, dragging the element outside the constraints will tug with some elasticity. This can be changed by setting `dragElastic` to a value between `0` and `1`, where `0` equals no motion and `1` equals full motion outside the constraints.

#### [Direction locking](#direction-locking)

It's possible to lock an element to the first axis it's dragged on by setting `dragDirectionLock`.

<motion.div
  drag
  dragDirectionLock
  @directionLock="callback"
/>

Each time the drag gesture starts, the direction of pointer travel will be detected and the element will be draggable only on this axis.

### [Focus](#focus)

The focus gesture detects when a component gains or loses focus by the same rules as the CSS :focus-visible selector.

Typically, this is when an `input` receives focus by any means, and when other elements receive focus by accessible means (like via keyboard navigation).

<motion.a :whileFocus="{ scale: 1.2 }" href="#" />

## [Event propagation](#event-propagation)

Children can stop pointer events propagating to parent `motion` components using the `Capture` Vue props.

For instance, a child can stop drag and tap gestures and their related `while` animations from firing on parents by passing `e.stopPropagation()` to `onPointerDownCapture`.

<motion.div :whilePress="{ scale: 2 }">
  <button @pointerDownCapture="e => e.stopPropagation()" />
</motion.div>

## [Note: SVG filters](#note-svg-filters)

Gestures aren't recognised on SVG `filter` components, as these elements don't have a physical presence and therefore don't receive events.

You can instead add `while-` props and event handlers to a parent and use variants to animate these elements.

<template>
    <motion.svg whileHover="hover">
      <filter id="blur">
        <motion.feGaussianBlur
          :stdDeviation="0"
          :variants="{ hover: { stdDeviation: 2 } }"
        />
      </filter>
    </motion.svg>
</template>

Motion extends Vue's basic set of event listeners with a simple yet powerful set of UI gestures.

The `motion` component currently has support for **hover**, **press**, **pan**, **drag** and **inView**.

Each gesture has both a set of event listeners and a `while-` animation prop.

## [Animation props](#animation-props)

`motion` components provide multiple gesture animation props: `whileHover`, `whilePress`, `whileFocus`, `whileDrag` and `[whileInView](https://motion.dev/vue-scroll-animations)`. These can define animation targets to temporarily animate to while a gesture is active.

<motion.button
  :whileHover="{
    scale: 1.2,
    transition: { duration: 1 },
  }"
  :whilePress="{ scale: 0.9 }"
/>

All props can be set either as a target of values to animate to, or the name of any variants defined via the `variants` prop. Variants will flow down through children as normal.

<motion.button
  whilePress="press"
  whileHover="hover"
  :variants="buttonVariants"
>
  <svg>
    <motion.path :variants="iconVariants" />
  </svg>
</motion.button>

## [Gestures](#gestures)

### [Hover](#hover)

The hover gesture detects when a pointer hovers over or leaves a component.

It differs from `onMouseEnter` and `onMouseLeave` in that hover is guaranteed to only fire as a result of actual mouse events (as opposed to browser-generated mice events emulated from touch input).

<motion.a
  :whileHover="{ scale: 1.2 }"
  @hoverStart="event => {}"
  @hoverEnd="event => {}"

### [Press](#press)

The press gesture detects when the **primary pointer** (like a left click or first touch point) presses down and releases on the same component.

<motion.button :whilePress="{ scale: 0.9, rotate: 3 }" />

It will fire a `press` event when the tap or click ends on the same component it started on, and a `pressCancel` event if the press or click ends outside the component.

If the pressable component is a child of a draggable component, it'll automatically cancel the press gesture if the pointer moves further than 3 pixels during the gesture.

#### [Accessibility](#accessibility)

Elements with press events are keyboard-accessible.

Any element with a press prop will be able to receive focus and `Enter` can be used to trigger press events on focused elements.

- Pressing `Enter` down will trigger `onPressStart` and `whilePress`
- Releasing `Enter` will trigger `onPress`
- If the element loses focus before `Enter` is released, `onPressCancel` will fire.

### [Pan](#pan)

The pan gesture recognises when a pointer presses down on a component and moves further than 3 pixels. The pan gesture is ended when the pointer is released.

<motion.div @pan="(e, pointInfo) => {}" />

Pan doesn't currently have an associated `while-` prop.

**Note:** For pan gestures to work correctly with touch input, the element needs touch scrolling to be disabled on either x/y or both axis with the `[touch-action](https://developer.mozilla.org/en-US/docs/Web/CSS/touch-action)` CSS rule.

### [Drag](#drag)

The drag gesture applies pointer movement to the x and/or y axis of the component.

<motion.div drag :whileDrag="{ scale: 1.2, backgroundColor: '#f00' }" />

By default, when the drag ends the element will perform an inertia animation with the ending velocity.

This can be disabled by setting `dragMomentum` to `false`, or changed via the `dragTransition` prop.

#### [Constraints](#constraints)

It's also possible to set `dragConstraints`, either as an object with `top`, `left`, `right`, and `bottom` values, measured in pixels.

<motion.div
  drag="x"
  :dragConstraints="{ left: 0, right: 300 }"
/>

Or, it can accept an HTMLElement `ref` value. You can get the component's DOM ref value using `useDomRef` from `motion-v`, and pass it both to the draggable component's `dragConstraints` prop and the ref of the component you want to use as constraints.


<template>
  <motion.div ref="constraintsRef">
      <motion.div drag :dragConstraints="constraintsRef" />
  </motion.div>
</template>

By default, dragging the element outside the constraints will tug with some elasticity. This can be changed by setting `dragElastic` to a value between `0` and `1`, where `0` equals no motion and `1` equals full motion outside the constraints.

#### [Direction locking](#direction-locking)

It's possible to lock an element to the first axis it's dragged on by setting `dragDirectionLock`.

<motion.div
  drag
  dragDirectionLock
  @directionLock="callback"
/>

Each time the drag gesture starts, the direction of pointer travel will be detected and the element will be draggable only on this axis.

### [Focus](#focus)

The focus gesture detects when a component gains or loses focus by the same rules as the CSS :focus-visible selector.

Typically, this is when an `input` receives focus by any means, and when other elements receive focus by accessible means (like via keyboard navigation).

<motion.a :whileFocus="{ scale: 1.2 }" href="#" />

## [Event propagation](#event-propagation)

Children can stop pointer events propagating to parent `motion` components using the `Capture` Vue props.

For instance, a child can stop drag and tap gestures and their related `while` animations from firing on parents by passing `e.stopPropagation()` to `onPointerDownCapture`.

<motion.div :whilePress="{ scale: 2 }">
  <button @pointerDownCapture="e => e.stopPropagation()" />
</motion.div>

## [Note: SVG filters](#note-svg-filters)

Gestures aren't recognised on SVG `filter` components, as these elements don't have a physical presence and therefore don't receive events.

You can instead add `while-` props and event handlers to a parent and use variants to animate these elements.

<template>
    <motion.svg whileHover="hover">
      <filter id="blur">
        <motion.feGaussianBlur
          :stdDeviation="0"
          :variants="{ hover: { stdDeviation: 2 } }"
        />
      </filter>
    </motion.svg>
</template>

Motion extends Vue's basic set of event listeners with a simple yet powerful set of UI gestures.

The `motion` component currently has support for **hover**, **press**, **pan**, **drag** and **inView**.

Each gesture has both a set of event listeners and a `while-` animation prop.

## [Animation props](#animation-props)

`motion` components provide multiple gesture animation props: `whileHover`, `whilePress`, `whileFocus`, `whileDrag` and `[whileInView](https://motion.dev/vue-scroll-animations)`. These can define animation targets to temporarily animate to while a gesture is active.

<motion.button
  :whileHover="{
    scale: 1.2,
    transition: { duration: 1 },
  }"
  :whilePress="{ scale: 0.9 }"
/>

All props can be set either as a target of values to animate to, or the name of any variants defined via the `variants` prop. Variants will flow down through children as normal.

<motion.button
  whilePress="press"
  whileHover="hover"
  :variants="buttonVariants"
>
  <svg>
    <motion.path :variants="iconVariants" />
  </svg>
</motion.button>

## [Gestures](#gestures)

### [Hover](#hover)

The hover gesture detects when a pointer hovers over or leaves a component.

It differs from `onMouseEnter` and `onMouseLeave` in that hover is guaranteed to only fire as a result of actual mouse events (as opposed to browser-generated mice events emulated from touch input).

<motion.a
  :whileHover="{ scale: 1.2 }"
  @hoverStart="event => {}"
  @hoverEnd="event => {}"

### [Press](#press)

The press gesture detects when the **primary pointer** (like a left click or first touch point) presses down and releases on the same component.

<motion.button :whilePress="{ scale: 0.9, rotate: 3 }" />

It will fire a `press` event when the tap or click ends on the same component it started on, and a `pressCancel` event if the press or click ends outside the component.

If the pressable component is a child of a draggable component, it'll automatically cancel the press gesture if the pointer moves further than 3 pixels during the gesture.

#### [Accessibility](#accessibility)

Elements with press events are keyboard-accessible.

Any element with a press prop will be able to receive focus and `Enter` can be used to trigger press events on focused elements.

- Pressing `Enter` down will trigger `onPressStart` and `whilePress`
- Releasing `Enter` will trigger `onPress`
- If the element loses focus before `Enter` is released, `onPressCancel` will fire.

### [Pan](#pan)

The pan gesture recognises when a pointer presses down on a component and moves further than 3 pixels. The pan gesture is ended when the pointer is released.

<motion.div @pan="(e, pointInfo) => {}" />

Pan doesn't currently have an associated `while-` prop.

**Note:** For pan gestures to work correctly with touch input, the element needs touch scrolling to be disabled on either x/y or both axis with the `[touch-action](https://developer.mozilla.org/en-US/docs/Web/CSS/touch-action)` CSS rule.

### [Drag](#drag)

The drag gesture applies pointer movement to the x and/or y axis of the component.

<motion.div drag :whileDrag="{ scale: 1.2, backgroundColor: '#f00' }" />

By default, when the drag ends the element will perform an inertia animation with the ending velocity.

This can be disabled by setting `dragMomentum` to `false`, or changed via the `dragTransition` prop.

#### [Constraints](#constraints)

It's also possible to set `dragConstraints`, either as an object with `top`, `left`, `right`, and `bottom` values, measured in pixels.

<motion.div
  drag="x"
  :dragConstraints="{ left: 0, right: 300 }"
/>

Or, it can accept an HTMLElement `ref` value. You can get the component's DOM ref value using `useDomRef` from `motion-v`, and pass it both to the draggable component's `dragConstraints` prop and the ref of the component you want to use as constraints.


<template>
  <motion.div ref="constraintsRef">
      <motion.div drag :dragConstraints="constraintsRef" />
  </motion.div>
</template>

By default, dragging the element outside the constraints will tug with some elasticity. This can be changed by setting `dragElastic` to a value between `0` and `1`, where `0` equals no motion and `1` equals full motion outside the constraints.

#### [Direction locking](#direction-locking)

It's possible to lock an element to the first axis it's dragged on by setting `dragDirectionLock`.

<motion.div
  drag
  dragDirectionLock
  @directionLock="callback"
/>

Each time the drag gesture starts, the direction of pointer travel will be detected and the element will be draggable only on this axis.

### [Focus](#focus)

The focus gesture detects when a component gains or loses focus by the same rules as the CSS :focus-visible selector.

Typically, this is when an `input` receives focus by any means, and when other elements receive focus by accessible means (like via keyboard navigation).

<motion.a :whileFocus="{ scale: 1.2 }" href="#" />

## [Event propagation](#event-propagation)

Children can stop pointer events propagating to parent `motion` components using the `Capture` Vue props.

For instance, a child can stop drag and tap gestures and their related `while` animations from firing on parents by passing `e.stopPropagation()` to `onPointerDownCapture`.

<motion.div :whilePress="{ scale: 2 }">
  <button @pointerDownCapture="e => e.stopPropagation()" />
</motion.div>

## [Note: SVG filters](#note-svg-filters)

Gestures aren't recognised on SVG `filter` components, as these elements don't have a physical presence and therefore don't receive events.

You can instead add `while-` props and event handlers to a parent and use variants to animate these elements.

<template>
    <motion.svg whileHover="hover">
      <filter id="blur">
        <motion.feGaussianBlur
          :stdDeviation="0"
          :variants="{ hover: { stdDeviation: 2 } }"
        />
      </filter>
    </motion.svg>
</template>

Previous

Motion Directive

Next

Layout animation

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