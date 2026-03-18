---
title: "Vue <motion /> component | Motion"
meta:
  "og:description": "Drive animations in Motion for Vue with motion components. Supercharge HTML/SVG for 120fps animations &amp; gestures. High-performance, SSR-compatible &amp; customizable."
  "og:title": "Vue <motion /> component | Motion"
  "twitter:description": "Drive animations in Motion for Vue with motion components. Supercharge HTML/SVG for 120fps animations &amp; gestures. High-performance, SSR-compatible &amp; customizable."
  "twitter:title": "Vue <motion /> component | Motion"
  description: "Drive animations in Motion for Vue with motion components. Supercharge HTML/SVG for 120fps animations &amp; gestures. High-performance, SSR-compatible &amp; customizable."
---

Vue

# Motion component

The `motion` component drives most animations in Motion for Vue.

There's a `motion` component for every HTML and SVG element, for instance `motion.div`, `motion.circle` etc. Think of it as a normal Vue component, supercharged for 120fps animation and gestures.

## [Usage](#usage)

Import `motion` from `motion-v`:

import { motion } from "motion-v"

Now you can use it exactly as you would any normal HTML/SVG component:

<motion.div class="box" />

But you also gain access to powerful animation APIs like the `animate`, `layout`, `whileInView` props and much more.

<motion.div
  class="box"
  // Animate when this value changes:
  :animate="{ scale: 2 }"
  // Fade in when the element enters the viewport:
  :whileInView="{ opacity: 1 }"
  // Animate the component when its layout changes:
  layout
  // Style now supports indepedent transforms:
  :style="{ x: 100 }"
/>

Check out the Animation guide for a full overview on animations in Motion for Vue.

### [Custom components](#custom-components)

Any Vue component can be supercharged into a `motion` component by passing it to `motion.create()` as a function.

const MotionComponent = motion.create(Component)

**Important:**Make sure **not** to call `motion.create()` within template! This will make a new component every render, breaking your animations.

It's also possible to pass strings to `motion.create`, which will create custom DOM elements.

// Will render <custom-element /> into HTML
const MotionComponent = motion.create('custom-element')

By default, all `motion` props (like `animate` etc) are filtered out of the `props` forwarded to the provided component. By providing a `forwardMotionProps` config, the provided component will receive these props.

motion.create(Component, { forwardMotionProps: true })

### [Motion Primitive](#motion-primitive)

For those familiar with Radix UI Primitives, Motion provides a similar primitive pattern through the `<Motion />` component.

Change the rendered element via the `as` prop:


<template>
  <Motion as="button">
    Click me
  </Motion>
</template>

Use the child as the rendered element:


<template>
  <Motion as-child>
    <button>Click me</button>
  </Motion>
</template>

### [Performance](#performance)

`motion` components animate values outside the Vue render cycle for improved performance.

Using motion values instead of Vue state to update `style` will also avoid re-renders.



<template>  
   <motion.div :style="{ x }" />
</template>

### [Server-side rendering](#server-side-rendering)

`motion` components are fully compatible with server-side rendering, meaning the initial state of the component will be reflected in the server-generated output.

// Server will output \`translateX(100px)\`
<motion.div :initial="false" :animate="{ x: 100 }" />

This is with the exception of some SVG attributes like `transform` which require DOM measurements to calculate.

## [Props](#props)

`motion` components accept the following props.

### [Animation](#animation)

#### [`initial`](#initial)

The initial visual state of the `motion` component.

This can be set as an animation target:

<motion.section :initial="{ opacity: 0, x: 0 }" />

Variants:

<motion.li initial="visible" />

<motion.div :initial="['visible', 'active']" />

Or set as `false` to disable the enter animation and initially render as the values found in `animate`.

<motion.div :initial="false" :animate="{ opacity: 0 }" />

#### [`animate`](#animate)

A target to animate to on enter, and on update.

Can be set as an animation target:

<motion.div
  :initial="{ boxShadow: '0px 0px #000' }"
  :animate="{ boxShadow: '10px 10px #000' }"
/>

Or variants:

<motion.li animate="visible" />

<motion.div initial="hidden" :animate="['visible', 'active']" />

#### [`exit`](#exit)

A target to animate to when a component is removed from the tree. Can be set either as an animation target, or variant.

**Note:** Owing to Vue Transition component limitations, the component being removed **must** be a **direct child** of `[AnimatePresence](https://motion.dev/vue-animate-presence)` to enable this animation.

<AnimatePresence>
    <ul v-if="isVisible"  key="list">
      <motion.li :exit="{ opacity: 0 }" />
    </ul>
</AnimatePresence>

#### [`transition`](#transition)

The default transition for this component to use when an animation prop (`animate`, `whileHover` etc) has no `transition` defined.

<motion.div :transition="{ type: 'spring' }" :animate="{ scale: 1.2 }" />

#### [`variants`](#variants)

The variants for this component.



<template>  
  <motion.div
    :variants="variants"
    :animate="isActive ? 'active' : 'inactive'"
  />
</template>

#### [`style`](#style)

The normal Vue DOM `style` prop, with added support for motion values and independent transforms.



<tempalte>
  <motion.div :style="{ x, rotate: 90, originX: 0.5 }" />
</tempalte>

#### [`onUpdate`](#onupdate)

Callback triggered every frame any value on the `motion` component updates. It's provided a single argument with the latest values.

<motion.article
  :animate="{ opacity: 1 }"
  :@update="latest => console.log(latest.opacity)"
/>

#### [`onAnimationStart`](#onanimationstart)

Callback triggered when any animation (except layout animations, see `onLayoutAnimationStart`) starts.

It's provided a single argument, with the target or variant name of the started animation.

<motion.circle
  :animate="{ r: 10 }"
  @animationStart="latest => console.log(latest.r)"
/>

#### [`onAnimationComplete`](#onanimationcomplete)

Callback triggered when any animation (except layout animations, see `onLayoutAnimationComplete`) completes.

It's provided a single argument, with the target or variant name of the completed animation.

<motion.circle
  :animate="{ r: 10 }"
  @animationComplete="latest => console.log(latest.r)"
/>

### [Hover](#hover)

#### [`whileHover`](#whilehover)

Target or variants to label to while the hover gesture is active.


<motion.button :whileHover="{ scale: 1.2 }" />


<motion.div whileHover="hovered" />

#### [`onHoverStart`](#onhoverstart)

Callback function that fires when a pointer starts hovering over the component. Provided the triggering `PointerEvent`.

<motion.div @hoverStart="(event) => console.log(event)" />

#### [`onHoverEnd`](#onhoverend)

Callback function that fires when a pointer stops hovering over the component. Provided the triggering `PointerEvent`.

<motion.div @hoverEnd="(event) => console.log(event)" />

### [Press](#press)

#### [`whilePress`](#whilepress)

Target or variants to label to while the press gesture is active.


<motion.button :whilePress="{ scale: 0.9 }" />


<motion.div whilePress="tapped" />

#### [`onPressStart`](#onpressstart)

Callback function that fires when a pointer starts pressing the component. Provided the triggering `PointerEvent`.

<motion.div @pressStart="(event) => console.log(event)" />

#### [`onPress`](#onpress)

Callback function that fires when a pointer stops pressing the component and the pointer was released **inside** the component. Provided the triggering `PointerEvent`.

<motion.div @press="(event) => console.log(event)" />

#### [`onPressCancel`](#onpresscancel)

Callback function that fires when a pointer stops pressing the component and the pointer was released **outside** the component. Provided the triggering `PointerEvent`.

<motion.div @pressCancel="(event) => console.log(event)" />

### [Focus](#focus)

#### [`whileFocus`](#whilefocus)

Target or variants to label to while the focus gesture is active.


<motion.button :whileFocus="{ outline: 'dashed #000' }" />


<motion.div whileFocus="focused" />

### [Pan](#pan)

#### [`onPan`](#onpan)

Callback function that fires when the pan gesture is recognised on this element.

**Note:** For pan gestures to work correctly with touch input, the element needs touch scrolling to be disabled on either x/y or both axis with the `[touch-action](https://developer.mozilla.org/en-US/docs/Web/CSS/touch-action)` CSS rule.

function onPan(event, info) {
  console.log(info.point.x, info.point.y)
}

<motion.div @pan="onPan" />

Pan and drag events are provided the origin `PointerEvent` as well as an object `info` that contains `x` and `y` point values for the following:

- `point`: Relative to the device or page.
- `delta`: Distance since the last event.
- `offset`: Distance from the original event.
- `velocity`: Current velocity of the pointer.

#### [`onPanStart`](#onpanstart)

Callback function that fires when a pan gesture starts. Provided the triggering `PointerEvent` and `info`.

<motion.div @panStart="(event, info) => console.log(info.delta.x)" />

#### [`onPanEnd`](#onpanend)

Callback function that fires when a pan gesture ends. Provided the triggering `PointerEvent` and `info`.

<motion.div @panEnd="(event, info) => console.log(info.delta.x)" />

### [Drag](#drag)

#### [`drag`](#drag-1)

**Default:**`false`

Enable dragging for this element. Set `true` to drag in both directions. Set `"x"` or `"y"` to only drag in a specific direction.

<motion.div drag />

#### [`whileDrag`](#whiledrag)

Target or variants to label to while the drag gesture is active.


<motion.div drag :whileDrag="{ scale: 0.9 }" />


<motion.div drag whileDrag="dragging" />

#### [`dragConstraints`](#dragconstraints)

Applies constraints on the draggable area.

Set as an object of optional `top`, `left`, `right`, and `bottom` values, measured in pixels:

<motion.div
  drag="x"
  :dragConstraints="{ left: 0, right: 300 }"
/>

Or as a `ref` to another element to use its bounding box as the draggable constraints:


<template>
  <motion.div ref="constraintsRef">
    <motion.div drag :dragConstraints="constraintsRef" />
  </motion.div>
</template>

#### [`dragSnapToOrigin`](#dragsnaptoorigin)

**Default:**`false`

If `true`, the draggable element will animate back to its center/origin when released.

<motion.div drag dragSnapToOrigin />

#### [`dragElastic`](#dragelastic)

**Default:**`0.5`

The degree of movement allowed outside constraints. `0` = no movement, `1` = full movement.

Set to `0.5` by default. Can also be set as `false` to disable movement.

By passing an object of `top`/`right`/`bottom`/`left`, individual values can be set per constraint. Any missing values will be set to `0`.

<motion.div
  drag
  :dragConstraints="{ left: 0, right: 300 }"
  :dragElastic="0.2"
/>

#### [`dragMomentum`](#dragmomentum)

**Default:**`true`

Apply momentum from the pan gesture to the component when dragging finishes. Set to `true` by default.

<motion.div
  drag
  :dragConstraints="{ left: 0, right: 300 }"
  :dragMomentum="false"
/>

#### [`dragTransition`](#dragtransition)

Allows you to change dragging momentum transition. When releasing a draggable element, an animation with type `"inertia"` starts. The animation is based on your dragging velocity. This property allows you to customize it.

<motion.div
  drag
  :dragTransition="{ bounceStiffness: 600, bounceDamping: 10 }"
/>

#### [`dragDirectionLock`](#dragdirectionlock)

**Default:**`false`

Locks drag direction into the soonest detected direction. For example, if the component is moved more on the `x` axis than `y` axis before the drag gesture kicks in, it will **only** drag on the `x` axis for the remainder of the gesture.

<motion.div drag dragDirectionLock />

#### [`dragPropagation`](#dragpropagation)

**Default:** `false`

Allows drag gesture propagation to child components.

<motion.div drag="x" dragPropagation />

#### [`dragControls`](#dragcontrols)

Usually, dragging is initiated by pressing down on a component and moving it. For some use-cases, for instance clicking at an arbitrary point on a video scrubber, we might want to initiate dragging from a different component than the draggable one.

By creating a `dragControls` using the `[useDragControls](https://motion.dev/vue-use-drag-controls)` hook, we can pass this into the draggable component's `dragControls` prop. It exposes a `start` method that can start dragging from pointer events on other components.



<template>
  <div @pointerDown="startDrag" />
  <motion.div drag="x" :dragControls="dragControls" />
</template>

**Note:**Given that by setting `dragControls` you are taking control of initiating the drag gesture, it is possible to disable the draggable element as the initiator by setting `:dragListener="false"`.

#### [`dragListener`](#draglistener)

Determines whether to trigger the drag gesture from event listeners. If passing `dragControls`, setting this to `false` will ensure dragging can only be initiated by the controls, rather than a `pointerdown` event on the draggable element.

#### [`onDrag`](#ondrag)

Callback function that fires when the drag gesture is recognised on this element.

function onDrag(event, info) {
  console.log(info.point.x, info.point.y)
}

<motion.div drag @drag="onDrag" />

Pan and drag events are provided the origin `PointerEvent` as well as an object `info` that contains `x` and `y` point values for the following:

- `point`: Relative to the device or page.
- `delta`: Distance since the last event.
- `offset`: Distance from the original event.
- `velocity`: Current velocity of the pointer.

#### [`onDragStart`](#ondragstart)

Callback function that fires when a drag gesture starts. Provided the triggering `PointerEvent` and `info`.

<motion.div drag @dragStart="(event, info) => console.log(info.delta.x)" />

#### [`onDragEnd`](#ondragend)

Callback function that fires when a drag gesture ends. Provided the triggering `PointerEvent` and `info`.

<motion.div drag @dragEnd="(event, info) => console.log(info.delta.x)" />

#### [`onDirectionLock`](#ondirectionlock)

Callback function that fires a drag direction is determined.

<motion.div
  drag
  dragDirectionLock
  @directionLock="axis => console.log(axis)"
/>

### [Viewport](#viewport)

#### [`whileInView`](#whileinview)

Target or variants to label to while the element is in view.


<motion.div :whileInView="{ opacity: 1 }" />

// As variants
<motion.div whileInView="visible" />

#### [`inViewOptions`](#inviewoptions)

Options to define how the element is tracked within the viewport.

<motion.section
  :whileInView="{ opacity: 1 }"
  :inViewOptions="{ once: true }"
/>

Available options:

- `once`: If `true`, once element enters the viewport it won't detect subsequent leave/enter events.
- `root`: The `ref` of an ancestor scrollable element to detect intersections with (instead of `window`).
- `margin`: A margin to add to the viewport to change the detection area. Defaults to `"0px"`. Use multiple values to adjust top/right/bottom/left, e.g. `"0px -20px 0px 100px"`.
- `amount`: The amount of an element that should enter the viewport to be considered "entered". Either `"some"`, `"all"` or a number between `0` and `1`. Defaults to `"some"`.

#### [`onViewportEnter`](#onviewportenter)

Callback function that fires when an element enters the viewport. Provided the `[IntersectionObserverEntry](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserverEntry)` with details of the intersection event.

<motion.div @viewportEnter="(entry) => console.log(entry.isIntersecting)" />

#### [`onViewportLeave`](#onviewportleave)

Callback function that fires when an element enters the viewport. Provided the `[IntersectionObserverEntry](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserverEntry)` with details of the intersection event.

<motion.div @viewportLeave="(entry) => console.log(entry.intersectionRect)" />

### [Layout](#layout)

#### [`layout`](#layout-1)

**Default:**`false`

If `true`, this component will animate changes to its layout.

<motion.div layout />

If set to `"position"` or `"size"`, only its position or size will animate, respectively.

<motion.img layout="position" />

#### [`layoutId`](#layoutid)

If set, this component will animate changes to its layout. Additionally, when a new element enters the DOM and an element already exists with a matching `layoutId`, it will animate out from the previous element's size/position.

<motion.li v-for="item in items" layout>
    {{item.name}}
    <motion.div v-if="item.isSelected" layoutId="underline" />
 </motion.li>

If the previous component remains in the tree, the two elements will crossfade.

#### [`layoutDependency`](#layoutdependency)

By default, layout changes are detected every render. To reduce measurements and thus improve performance, you can pass a `layoutDependency` prop. Measurements will only occur when this value changes.

<motion.nav layout :layoutDependency="isOpen" />

#### [`layoutScroll`](#layoutscroll)

For layout animations to work correctly within scrollable elements, their scroll offset needs measuring. For performance reasons, `Motion` doesn't measure the scroll offset of every ancestor. Add the `layoutScroll` prop to elements that should be measured.

<motion.div layoutScroll style="{ overflow: 'scroll' }">
  <motion.div layout />
</motion.div>

#### [`layoutRoot`](#layoutroot)

For layout animations to work correctly within `position: fixed` elements, we need to account for page scroll. Add `layoutRoot` to mark an element as `position: fixed`.

<motion.div layoutRoot :style="{ position: 'fixed' }">
  <motion.div layout />
</motion.div>

#### [`onLayoutAnimationStart`](#onlayoutanimationstart)

A callback to run when a layout animation starts.

#### [`onLayoutAnimationComplete`](#onlayoutanimationcomplete)

A callback to run when a layout animation completes.

### [Advanced](#advanced)

#### [`inherit`](#inherit)

Set to `false` to prevent a component inheriting or propagating changes in a parent variant.

#### [`custom`](#custom)

Custom data to pass through to dynamic variants.



<template>
  <motion.ul animate="visible">
    <motion.li :custom="0" :variants="variants" />
    <motion.li :custom="1" :variants="variants" />
    <motion.li :custom="2" :variants="variants" />
  </motion.ul>
</template>

#### [`transformTemplate`](#transformtemplate)

By default, transforms are applied in order of `translate`, `scale`, `rotate` and `skew`.

To change this, `transformTemplate` can be set as a function that accepts the latest transforms and the generated transform string and returns a new transform string.


<motion.div
  :style="{ x: 0, rotate: 180 }"
  :transformTemplate="({ x, rotate }) => \`rotate(${rotate}deg) translateX(${x}px)\`"
/>


<motion.div
  :style="{ x: 0, rotate: 180 }"
  :transformTemplate="(latest, generated) => \`translate(-50%, -50%)${generated}\`"
/>

The `motion` component drives most animations in Motion for Vue.

There's a `motion` component for every HTML and SVG element, for instance `motion.div`, `motion.circle` etc. Think of it as a normal Vue component, supercharged for 120fps animation and gestures.

## [Usage](#usage)

Import `motion` from `motion-v`:

import { motion } from "motion-v"

Now you can use it exactly as you would any normal HTML/SVG component:

<motion.div class="box" />

But you also gain access to powerful animation APIs like the `animate`, `layout`, `whileInView` props and much more.

<motion.div
  class="box"
  // Animate when this value changes:
  :animate="{ scale: 2 }"
  // Fade in when the element enters the viewport:
  :whileInView="{ opacity: 1 }"
  // Animate the component when its layout changes:
  layout
  // Style now supports indepedent transforms:
  :style="{ x: 100 }"
/>

Check out the Animation guide for a full overview on animations in Motion for Vue.

### [Custom components](#custom-components)

Any Vue component can be supercharged into a `motion` component by passing it to `motion.create()` as a function.

const MotionComponent = motion.create(Component)

**Important:**Make sure **not** to call `motion.create()` within template! This will make a new component every render, breaking your animations.

It's also possible to pass strings to `motion.create`, which will create custom DOM elements.

// Will render <custom-element /> into HTML
const MotionComponent = motion.create('custom-element')

By default, all `motion` props (like `animate` etc) are filtered out of the `props` forwarded to the provided component. By providing a `forwardMotionProps` config, the provided component will receive these props.

motion.create(Component, { forwardMotionProps: true })

### [Motion Primitive](#motion-primitive)

For those familiar with Radix UI Primitives, Motion provides a similar primitive pattern through the `<Motion />` component.

Change the rendered element via the `as` prop:


<template>
  <Motion as="button">
    Click me
  </Motion>
</template>

Use the child as the rendered element:


<template>
  <Motion as-child>
    <button>Click me</button>
  </Motion>
</template>

### [Performance](#performance)

`motion` components animate values outside the Vue render cycle for improved performance.

Using motion values instead of Vue state to update `style` will also avoid re-renders.



<template>  
   <motion.div :style="{ x }" />
</template>

### [Server-side rendering](#server-side-rendering)

`motion` components are fully compatible with server-side rendering, meaning the initial state of the component will be reflected in the server-generated output.

// Server will output \`translateX(100px)\`
<motion.div :initial="false" :animate="{ x: 100 }" />

This is with the exception of some SVG attributes like `transform` which require DOM measurements to calculate.

## [Props](#props)

`motion` components accept the following props.

### [Animation](#animation)

#### [`initial`](#initial)

The initial visual state of the `motion` component.

This can be set as an animation target:

<motion.section :initial="{ opacity: 0, x: 0 }" />

Variants:

<motion.li initial="visible" />

<motion.div :initial="['visible', 'active']" />

Or set as `false` to disable the enter animation and initially render as the values found in `animate`.

<motion.div :initial="false" :animate="{ opacity: 0 }" />

#### [`animate`](#animate)

A target to animate to on enter, and on update.

Can be set as an animation target:

<motion.div
  :initial="{ boxShadow: '0px 0px #000' }"
  :animate="{ boxShadow: '10px 10px #000' }"
/>

Or variants:

<motion.li animate="visible" />

<motion.div initial="hidden" :animate="['visible', 'active']" />

#### [`exit`](#exit)

A target to animate to when a component is removed from the tree. Can be set either as an animation target, or variant.

**Note:** Owing to Vue Transition component limitations, the component being removed **must** be a **direct child** of `[AnimatePresence](https://motion.dev/vue-animate-presence)` to enable this animation.

<AnimatePresence>
    <ul v-if="isVisible"  key="list">
      <motion.li :exit="{ opacity: 0 }" />
    </ul>
</AnimatePresence>

#### [`transition`](#transition)

The default transition for this component to use when an animation prop (`animate`, `whileHover` etc) has no `transition` defined.

<motion.div :transition="{ type: 'spring' }" :animate="{ scale: 1.2 }" />

#### [`variants`](#variants)

The variants for this component.



<template>  
  <motion.div
    :variants="variants"
    :animate="isActive ? 'active' : 'inactive'"
  />
</template>

#### [`style`](#style)

The normal Vue DOM `style` prop, with added support for motion values and independent transforms.



<tempalte>
  <motion.div :style="{ x, rotate: 90, originX: 0.5 }" />
</tempalte>

#### [`onUpdate`](#onupdate)

Callback triggered every frame any value on the `motion` component updates. It's provided a single argument with the latest values.

<motion.article
  :animate="{ opacity: 1 }"
  :@update="latest => console.log(latest.opacity)"
/>

#### [`onAnimationStart`](#onanimationstart)

Callback triggered when any animation (except layout animations, see `onLayoutAnimationStart`) starts.

It's provided a single argument, with the target or variant name of the started animation.

<motion.circle
  :animate="{ r: 10 }"
  @animationStart="latest => console.log(latest.r)"
/>

#### [`onAnimationComplete`](#onanimationcomplete)

Callback triggered when any animation (except layout animations, see `onLayoutAnimationComplete`) completes.

It's provided a single argument, with the target or variant name of the completed animation.

<motion.circle
  :animate="{ r: 10 }"
  @animationComplete="latest => console.log(latest.r)"
/>

### [Hover](#hover)

#### [`whileHover`](#whilehover)

Target or variants to label to while the hover gesture is active.


<motion.button :whileHover="{ scale: 1.2 }" />


<motion.div whileHover="hovered" />

#### [`onHoverStart`](#onhoverstart)

Callback function that fires when a pointer starts hovering over the component. Provided the triggering `PointerEvent`.

<motion.div @hoverStart="(event) => console.log(event)" />

#### [`onHoverEnd`](#onhoverend)

Callback function that fires when a pointer stops hovering over the component. Provided the triggering `PointerEvent`.

<motion.div @hoverEnd="(event) => console.log(event)" />

### [Press](#press)

#### [`whilePress`](#whilepress)

Target or variants to label to while the press gesture is active.


<motion.button :whilePress="{ scale: 0.9 }" />


<motion.div whilePress="tapped" />

#### [`onPressStart`](#onpressstart)

Callback function that fires when a pointer starts pressing the component. Provided the triggering `PointerEvent`.

<motion.div @pressStart="(event) => console.log(event)" />

#### [`onPress`](#onpress)

Callback function that fires when a pointer stops pressing the component and the pointer was released **inside** the component. Provided the triggering `PointerEvent`.

<motion.div @press="(event) => console.log(event)" />

#### [`onPressCancel`](#onpresscancel)

Callback function that fires when a pointer stops pressing the component and the pointer was released **outside** the component. Provided the triggering `PointerEvent`.

<motion.div @pressCancel="(event) => console.log(event)" />

### [Focus](#focus)

#### [`whileFocus`](#whilefocus)

Target or variants to label to while the focus gesture is active.


<motion.button :whileFocus="{ outline: 'dashed #000' }" />


<motion.div whileFocus="focused" />

### [Pan](#pan)

#### [`onPan`](#onpan)

Callback function that fires when the pan gesture is recognised on this element.

**Note:** For pan gestures to work correctly with touch input, the element needs touch scrolling to be disabled on either x/y or both axis with the `[touch-action](https://developer.mozilla.org/en-US/docs/Web/CSS/touch-action)` CSS rule.

function onPan(event, info) {
  console.log(info.point.x, info.point.y)
}

<motion.div @pan="onPan" />

Pan and drag events are provided the origin `PointerEvent` as well as an object `info` that contains `x` and `y` point values for the following:

- `point`: Relative to the device or page.
- `delta`: Distance since the last event.
- `offset`: Distance from the original event.
- `velocity`: Current velocity of the pointer.

#### [`onPanStart`](#onpanstart)

Callback function that fires when a pan gesture starts. Provided the triggering `PointerEvent` and `info`.

<motion.div @panStart="(event, info) => console.log(info.delta.x)" />

#### [`onPanEnd`](#onpanend)

Callback function that fires when a pan gesture ends. Provided the triggering `PointerEvent` and `info`.

<motion.div @panEnd="(event, info) => console.log(info.delta.x)" />

### [Drag](#drag)

#### [`drag`](#drag-1)

**Default:**`false`

Enable dragging for this element. Set `true` to drag in both directions. Set `"x"` or `"y"` to only drag in a specific direction.

<motion.div drag />

#### [`whileDrag`](#whiledrag)

Target or variants to label to while the drag gesture is active.


<motion.div drag :whileDrag="{ scale: 0.9 }" />


<motion.div drag whileDrag="dragging" />

#### [`dragConstraints`](#dragconstraints)

Applies constraints on the draggable area.

Set as an object of optional `top`, `left`, `right`, and `bottom` values, measured in pixels:

<motion.div
  drag="x"
  :dragConstraints="{ left: 0, right: 300 }"
/>

Or as a `ref` to another element to use its bounding box as the draggable constraints:


<template>
  <motion.div ref="constraintsRef">
    <motion.div drag :dragConstraints="constraintsRef" />
  </motion.div>
</template>

#### [`dragSnapToOrigin`](#dragsnaptoorigin)

**Default:**`false`

If `true`, the draggable element will animate back to its center/origin when released.

<motion.div drag dragSnapToOrigin />

#### [`dragElastic`](#dragelastic)

**Default:**`0.5`

The degree of movement allowed outside constraints. `0` = no movement, `1` = full movement.

Set to `0.5` by default. Can also be set as `false` to disable movement.

By passing an object of `top`/`right`/`bottom`/`left`, individual values can be set per constraint. Any missing values will be set to `0`.

<motion.div
  drag
  :dragConstraints="{ left: 0, right: 300 }"
  :dragElastic="0.2"
/>

#### [`dragMomentum`](#dragmomentum)

**Default:**`true`

Apply momentum from the pan gesture to the component when dragging finishes. Set to `true` by default.

<motion.div
  drag
  :dragConstraints="{ left: 0, right: 300 }"
  :dragMomentum="false"
/>

#### [`dragTransition`](#dragtransition)

Allows you to change dragging momentum transition. When releasing a draggable element, an animation with type `"inertia"` starts. The animation is based on your dragging velocity. This property allows you to customize it.

<motion.div
  drag
  :dragTransition="{ bounceStiffness: 600, bounceDamping: 10 }"
/>

#### [`dragDirectionLock`](#dragdirectionlock)

**Default:**`false`

Locks drag direction into the soonest detected direction. For example, if the component is moved more on the `x` axis than `y` axis before the drag gesture kicks in, it will **only** drag on the `x` axis for the remainder of the gesture.

<motion.div drag dragDirectionLock />

#### [`dragPropagation`](#dragpropagation)

**Default:** `false`

Allows drag gesture propagation to child components.

<motion.div drag="x" dragPropagation />

#### [`dragControls`](#dragcontrols)

Usually, dragging is initiated by pressing down on a component and moving it. For some use-cases, for instance clicking at an arbitrary point on a video scrubber, we might want to initiate dragging from a different component than the draggable one.

By creating a `dragControls` using the `[useDragControls](https://motion.dev/vue-use-drag-controls)` hook, we can pass this into the draggable component's `dragControls` prop. It exposes a `start` method that can start dragging from pointer events on other components.



<template>
  <div @pointerDown="startDrag" />
  <motion.div drag="x" :dragControls="dragControls" />
</template>

**Note:**Given that by setting `dragControls` you are taking control of initiating the drag gesture, it is possible to disable the draggable element as the initiator by setting `:dragListener="false"`.

#### [`dragListener`](#draglistener)

Determines whether to trigger the drag gesture from event listeners. If passing `dragControls`, setting this to `false` will ensure dragging can only be initiated by the controls, rather than a `pointerdown` event on the draggable element.

#### [`onDrag`](#ondrag)

Callback function that fires when the drag gesture is recognised on this element.

function onDrag(event, info) {
  console.log(info.point.x, info.point.y)
}

<motion.div drag @drag="onDrag" />

Pan and drag events are provided the origin `PointerEvent` as well as an object `info` that contains `x` and `y` point values for the following:

- `point`: Relative to the device or page.
- `delta`: Distance since the last event.
- `offset`: Distance from the original event.
- `velocity`: Current velocity of the pointer.

#### [`onDragStart`](#ondragstart)

Callback function that fires when a drag gesture starts. Provided the triggering `PointerEvent` and `info`.

<motion.div drag @dragStart="(event, info) => console.log(info.delta.x)" />

#### [`onDragEnd`](#ondragend)

Callback function that fires when a drag gesture ends. Provided the triggering `PointerEvent` and `info`.

<motion.div drag @dragEnd="(event, info) => console.log(info.delta.x)" />

#### [`onDirectionLock`](#ondirectionlock)

Callback function that fires a drag direction is determined.

<motion.div
  drag
  dragDirectionLock
  @directionLock="axis => console.log(axis)"
/>

### [Viewport](#viewport)

#### [`whileInView`](#whileinview)

Target or variants to label to while the element is in view.


<motion.div :whileInView="{ opacity: 1 }" />

// As variants
<motion.div whileInView="visible" />

#### [`inViewOptions`](#inviewoptions)

Options to define how the element is tracked within the viewport.

<motion.section
  :whileInView="{ opacity: 1 }"
  :inViewOptions="{ once: true }"
/>

Available options:

- `once`: If `true`, once element enters the viewport it won't detect subsequent leave/enter events.
- `root`: The `ref` of an ancestor scrollable element to detect intersections with (instead of `window`).
- `margin`: A margin to add to the viewport to change the detection area. Defaults to `"0px"`. Use multiple values to adjust top/right/bottom/left, e.g. `"0px -20px 0px 100px"`.
- `amount`: The amount of an element that should enter the viewport to be considered "entered". Either `"some"`, `"all"` or a number between `0` and `1`. Defaults to `"some"`.

#### [`onViewportEnter`](#onviewportenter)

Callback function that fires when an element enters the viewport. Provided the `[IntersectionObserverEntry](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserverEntry)` with details of the intersection event.

<motion.div @viewportEnter="(entry) => console.log(entry.isIntersecting)" />

#### [`onViewportLeave`](#onviewportleave)

Callback function that fires when an element enters the viewport. Provided the `[IntersectionObserverEntry](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserverEntry)` with details of the intersection event.

<motion.div @viewportLeave="(entry) => console.log(entry.intersectionRect)" />

### [Layout](#layout)

#### [`layout`](#layout-1)

**Default:**`false`

If `true`, this component will animate changes to its layout.

<motion.div layout />

If set to `"position"` or `"size"`, only its position or size will animate, respectively.

<motion.img layout="position" />

#### [`layoutId`](#layoutid)

If set, this component will animate changes to its layout. Additionally, when a new element enters the DOM and an element already exists with a matching `layoutId`, it will animate out from the previous element's size/position.

<motion.li v-for="item in items" layout>
    {{item.name}}
    <motion.div v-if="item.isSelected" layoutId="underline" />
 </motion.li>

If the previous component remains in the tree, the two elements will crossfade.

#### [`layoutDependency`](#layoutdependency)

By default, layout changes are detected every render. To reduce measurements and thus improve performance, you can pass a `layoutDependency` prop. Measurements will only occur when this value changes.

<motion.nav layout :layoutDependency="isOpen" />

#### [`layoutScroll`](#layoutscroll)

For layout animations to work correctly within scrollable elements, their scroll offset needs measuring. For performance reasons, `Motion` doesn't measure the scroll offset of every ancestor. Add the `layoutScroll` prop to elements that should be measured.

<motion.div layoutScroll style="{ overflow: 'scroll' }">
  <motion.div layout />
</motion.div>

#### [`layoutRoot`](#layoutroot)

For layout animations to work correctly within `position: fixed` elements, we need to account for page scroll. Add `layoutRoot` to mark an element as `position: fixed`.

<motion.div layoutRoot :style="{ position: 'fixed' }">
  <motion.div layout />
</motion.div>

#### [`onLayoutAnimationStart`](#onlayoutanimationstart)

A callback to run when a layout animation starts.

#### [`onLayoutAnimationComplete`](#onlayoutanimationcomplete)

A callback to run when a layout animation completes.

### [Advanced](#advanced)

#### [`inherit`](#inherit)

Set to `false` to prevent a component inheriting or propagating changes in a parent variant.

#### [`custom`](#custom)

Custom data to pass through to dynamic variants.



<template>
  <motion.ul animate="visible">
    <motion.li :custom="0" :variants="variants" />
    <motion.li :custom="1" :variants="variants" />
    <motion.li :custom="2" :variants="variants" />
  </motion.ul>
</template>

#### [`transformTemplate`](#transformtemplate)

By default, transforms are applied in order of `translate`, `scale`, `rotate` and `skew`.

To change this, `transformTemplate` can be set as a function that accepts the latest transforms and the generated transform string and returns a new transform string.


<motion.div
  :style="{ x: 0, rotate: 180 }"
  :transformTemplate="({ x, rotate }) => \`rotate(${rotate}deg) translateX(${x}px)\`"
/>


<motion.div
  :style="{ x: 0, rotate: 180 }"
  :transformTemplate="(latest, generated) => \`translate(-50%, -50%)${generated}\`"
/>

The `motion` component drives most animations in Motion for Vue.

There's a `motion` component for every HTML and SVG element, for instance `motion.div`, `motion.circle` etc. Think of it as a normal Vue component, supercharged for 120fps animation and gestures.

## [Usage](#usage)

Import `motion` from `motion-v`:

import { motion } from "motion-v"

Now you can use it exactly as you would any normal HTML/SVG component:

<motion.div class="box" />

But you also gain access to powerful animation APIs like the `animate`, `layout`, `whileInView` props and much more.

<motion.div
  class="box"
  // Animate when this value changes:
  :animate="{ scale: 2 }"
  // Fade in when the element enters the viewport:
  :whileInView="{ opacity: 1 }"
  // Animate the component when its layout changes:
  layout
  // Style now supports indepedent transforms:
  :style="{ x: 100 }"
/>

Check out the Animation guide for a full overview on animations in Motion for Vue.

### [Custom components](#custom-components)

Any Vue component can be supercharged into a `motion` component by passing it to `motion.create()` as a function.

const MotionComponent = motion.create(Component)

**Important:**Make sure **not** to call `motion.create()` within template! This will make a new component every render, breaking your animations.

It's also possible to pass strings to `motion.create`, which will create custom DOM elements.

// Will render <custom-element /> into HTML
const MotionComponent = motion.create('custom-element')

By default, all `motion` props (like `animate` etc) are filtered out of the `props` forwarded to the provided component. By providing a `forwardMotionProps` config, the provided component will receive these props.

motion.create(Component, { forwardMotionProps: true })

### [Motion Primitive](#motion-primitive)

For those familiar with Radix UI Primitives, Motion provides a similar primitive pattern through the `<Motion />` component.

Change the rendered element via the `as` prop:


<template>
  <Motion as="button">
    Click me
  </Motion>
</template>

Use the child as the rendered element:


<template>
  <Motion as-child>
    <button>Click me</button>
  </Motion>
</template>

### [Performance](#performance)

`motion` components animate values outside the Vue render cycle for improved performance.

Using motion values instead of Vue state to update `style` will also avoid re-renders.



<template>  
   <motion.div :style="{ x }" />
</template>

### [Server-side rendering](#server-side-rendering)

`motion` components are fully compatible with server-side rendering, meaning the initial state of the component will be reflected in the server-generated output.

// Server will output \`translateX(100px)\`
<motion.div :initial="false" :animate="{ x: 100 }" />

This is with the exception of some SVG attributes like `transform` which require DOM measurements to calculate.

## [Props](#props)

`motion` components accept the following props.

### [Animation](#animation)

#### [`initial`](#initial)

The initial visual state of the `motion` component.

This can be set as an animation target:

<motion.section :initial="{ opacity: 0, x: 0 }" />

Variants:

<motion.li initial="visible" />

<motion.div :initial="['visible', 'active']" />

Or set as `false` to disable the enter animation and initially render as the values found in `animate`.

<motion.div :initial="false" :animate="{ opacity: 0 }" />

#### [`animate`](#animate)

A target to animate to on enter, and on update.

Can be set as an animation target:

<motion.div
  :initial="{ boxShadow: '0px 0px #000' }"
  :animate="{ boxShadow: '10px 10px #000' }"
/>

Or variants:

<motion.li animate="visible" />

<motion.div initial="hidden" :animate="['visible', 'active']" />

#### [`exit`](#exit)

A target to animate to when a component is removed from the tree. Can be set either as an animation target, or variant.

**Note:** Owing to Vue Transition component limitations, the component being removed **must** be a **direct child** of `[AnimatePresence](https://motion.dev/vue-animate-presence)` to enable this animation.

<AnimatePresence>
    <ul v-if="isVisible"  key="list">
      <motion.li :exit="{ opacity: 0 }" />
    </ul>
</AnimatePresence>

#### [`transition`](#transition)

The default transition for this component to use when an animation prop (`animate`, `whileHover` etc) has no `transition` defined.

<motion.div :transition="{ type: 'spring' }" :animate="{ scale: 1.2 }" />

#### [`variants`](#variants)

The variants for this component.



<template>  
  <motion.div
    :variants="variants"
    :animate="isActive ? 'active' : 'inactive'"
  />
</template>

#### [`style`](#style)

The normal Vue DOM `style` prop, with added support for motion values and independent transforms.



<tempalte>
  <motion.div :style="{ x, rotate: 90, originX: 0.5 }" />
</tempalte>

#### [`onUpdate`](#onupdate)

Callback triggered every frame any value on the `motion` component updates. It's provided a single argument with the latest values.

<motion.article
  :animate="{ opacity: 1 }"
  :@update="latest => console.log(latest.opacity)"
/>

#### [`onAnimationStart`](#onanimationstart)

Callback triggered when any animation (except layout animations, see `onLayoutAnimationStart`) starts.

It's provided a single argument, with the target or variant name of the started animation.

<motion.circle
  :animate="{ r: 10 }"
  @animationStart="latest => console.log(latest.r)"
/>

#### [`onAnimationComplete`](#onanimationcomplete)

Callback triggered when any animation (except layout animations, see `onLayoutAnimationComplete`) completes.

It's provided a single argument, with the target or variant name of the completed animation.

<motion.circle
  :animate="{ r: 10 }"
  @animationComplete="latest => console.log(latest.r)"
/>

### [Hover](#hover)

#### [`whileHover`](#whilehover)

Target or variants to label to while the hover gesture is active.


<motion.button :whileHover="{ scale: 1.2 }" />


<motion.div whileHover="hovered" />

#### [`onHoverStart`](#onhoverstart)

Callback function that fires when a pointer starts hovering over the component. Provided the triggering `PointerEvent`.

<motion.div @hoverStart="(event) => console.log(event)" />

#### [`onHoverEnd`](#onhoverend)

Callback function that fires when a pointer stops hovering over the component. Provided the triggering `PointerEvent`.

<motion.div @hoverEnd="(event) => console.log(event)" />

### [Press](#press)

#### [`whilePress`](#whilepress)

Target or variants to label to while the press gesture is active.


<motion.button :whilePress="{ scale: 0.9 }" />


<motion.div whilePress="tapped" />

#### [`onPressStart`](#onpressstart)

Callback function that fires when a pointer starts pressing the component. Provided the triggering `PointerEvent`.

<motion.div @pressStart="(event) => console.log(event)" />

#### [`onPress`](#onpress)

Callback function that fires when a pointer stops pressing the component and the pointer was released **inside** the component. Provided the triggering `PointerEvent`.

<motion.div @press="(event) => console.log(event)" />

#### [`onPressCancel`](#onpresscancel)

Callback function that fires when a pointer stops pressing the component and the pointer was released **outside** the component. Provided the triggering `PointerEvent`.

<motion.div @pressCancel="(event) => console.log(event)" />

### [Focus](#focus)

#### [`whileFocus`](#whilefocus)

Target or variants to label to while the focus gesture is active.


<motion.button :whileFocus="{ outline: 'dashed #000' }" />


<motion.div whileFocus="focused" />

### [Pan](#pan)

#### [`onPan`](#onpan)

Callback function that fires when the pan gesture is recognised on this element.

**Note:** For pan gestures to work correctly with touch input, the element needs touch scrolling to be disabled on either x/y or both axis with the `[touch-action](https://developer.mozilla.org/en-US/docs/Web/CSS/touch-action)` CSS rule.

function onPan(event, info) {
  console.log(info.point.x, info.point.y)
}

<motion.div @pan="onPan" />

Pan and drag events are provided the origin `PointerEvent` as well as an object `info` that contains `x` and `y` point values for the following:

- `point`: Relative to the device or page.
- `delta`: Distance since the last event.
- `offset`: Distance from the original event.
- `velocity`: Current velocity of the pointer.

#### [`onPanStart`](#onpanstart)

Callback function that fires when a pan gesture starts. Provided the triggering `PointerEvent` and `info`.

<motion.div @panStart="(event, info) => console.log(info.delta.x)" />

#### [`onPanEnd`](#onpanend)

Callback function that fires when a pan gesture ends. Provided the triggering `PointerEvent` and `info`.

<motion.div @panEnd="(event, info) => console.log(info.delta.x)" />

### [Drag](#drag)

#### [`drag`](#drag-1)

**Default:**`false`

Enable dragging for this element. Set `true` to drag in both directions. Set `"x"` or `"y"` to only drag in a specific direction.

<motion.div drag />

#### [`whileDrag`](#whiledrag)

Target or variants to label to while the drag gesture is active.


<motion.div drag :whileDrag="{ scale: 0.9 }" />


<motion.div drag whileDrag="dragging" />

#### [`dragConstraints`](#dragconstraints)

Applies constraints on the draggable area.

Set as an object of optional `top`, `left`, `right`, and `bottom` values, measured in pixels:

<motion.div
  drag="x"
  :dragConstraints="{ left: 0, right: 300 }"
/>

Or as a `ref` to another element to use its bounding box as the draggable constraints:


<template>
  <motion.div ref="constraintsRef">
    <motion.div drag :dragConstraints="constraintsRef" />
  </motion.div>
</template>

#### [`dragSnapToOrigin`](#dragsnaptoorigin)

**Default:**`false`

If `true`, the draggable element will animate back to its center/origin when released.

<motion.div drag dragSnapToOrigin />

#### [`dragElastic`](#dragelastic)

**Default:**`0.5`

The degree of movement allowed outside constraints. `0` = no movement, `1` = full movement.

Set to `0.5` by default. Can also be set as `false` to disable movement.

By passing an object of `top`/`right`/`bottom`/`left`, individual values can be set per constraint. Any missing values will be set to `0`.

<motion.div
  drag
  :dragConstraints="{ left: 0, right: 300 }"
  :dragElastic="0.2"
/>

#### [`dragMomentum`](#dragmomentum)

**Default:**`true`

Apply momentum from the pan gesture to the component when dragging finishes. Set to `true` by default.

<motion.div
  drag
  :dragConstraints="{ left: 0, right: 300 }"
  :dragMomentum="false"
/>

#### [`dragTransition`](#dragtransition)

Allows you to change dragging momentum transition. When releasing a draggable element, an animation with type `"inertia"` starts. The animation is based on your dragging velocity. This property allows you to customize it.

<motion.div
  drag
  :dragTransition="{ bounceStiffness: 600, bounceDamping: 10 }"
/>

#### [`dragDirectionLock`](#dragdirectionlock)

**Default:**`false`

Locks drag direction into the soonest detected direction. For example, if the component is moved more on the `x` axis than `y` axis before the drag gesture kicks in, it will **only** drag on the `x` axis for the remainder of the gesture.

<motion.div drag dragDirectionLock />

#### [`dragPropagation`](#dragpropagation)

**Default:** `false`

Allows drag gesture propagation to child components.

<motion.div drag="x" dragPropagation />

#### [`dragControls`](#dragcontrols)

Usually, dragging is initiated by pressing down on a component and moving it. For some use-cases, for instance clicking at an arbitrary point on a video scrubber, we might want to initiate dragging from a different component than the draggable one.

By creating a `dragControls` using the `[useDragControls](https://motion.dev/vue-use-drag-controls)` hook, we can pass this into the draggable component's `dragControls` prop. It exposes a `start` method that can start dragging from pointer events on other components.



<template>
  <div @pointerDown="startDrag" />
  <motion.div drag="x" :dragControls="dragControls" />
</template>

**Note:**Given that by setting `dragControls` you are taking control of initiating the drag gesture, it is possible to disable the draggable element as the initiator by setting `:dragListener="false"`.

#### [`dragListener`](#draglistener)

Determines whether to trigger the drag gesture from event listeners. If passing `dragControls`, setting this to `false` will ensure dragging can only be initiated by the controls, rather than a `pointerdown` event on the draggable element.

#### [`onDrag`](#ondrag)

Callback function that fires when the drag gesture is recognised on this element.

function onDrag(event, info) {
  console.log(info.point.x, info.point.y)
}

<motion.div drag @drag="onDrag" />

Pan and drag events are provided the origin `PointerEvent` as well as an object `info` that contains `x` and `y` point values for the following:

- `point`: Relative to the device or page.
- `delta`: Distance since the last event.
- `offset`: Distance from the original event.
- `velocity`: Current velocity of the pointer.

#### [`onDragStart`](#ondragstart)

Callback function that fires when a drag gesture starts. Provided the triggering `PointerEvent` and `info`.

<motion.div drag @dragStart="(event, info) => console.log(info.delta.x)" />

#### [`onDragEnd`](#ondragend)

Callback function that fires when a drag gesture ends. Provided the triggering `PointerEvent` and `info`.

<motion.div drag @dragEnd="(event, info) => console.log(info.delta.x)" />

#### [`onDirectionLock`](#ondirectionlock)

Callback function that fires a drag direction is determined.

<motion.div
  drag
  dragDirectionLock
  @directionLock="axis => console.log(axis)"
/>

### [Viewport](#viewport)

#### [`whileInView`](#whileinview)

Target or variants to label to while the element is in view.


<motion.div :whileInView="{ opacity: 1 }" />

// As variants
<motion.div whileInView="visible" />

#### [`inViewOptions`](#inviewoptions)

Options to define how the element is tracked within the viewport.

<motion.section
  :whileInView="{ opacity: 1 }"
  :inViewOptions="{ once: true }"
/>

Available options:

- `once`: If `true`, once element enters the viewport it won't detect subsequent leave/enter events.
- `root`: The `ref` of an ancestor scrollable element to detect intersections with (instead of `window`).
- `margin`: A margin to add to the viewport to change the detection area. Defaults to `"0px"`. Use multiple values to adjust top/right/bottom/left, e.g. `"0px -20px 0px 100px"`.
- `amount`: The amount of an element that should enter the viewport to be considered "entered". Either `"some"`, `"all"` or a number between `0` and `1`. Defaults to `"some"`.

#### [`onViewportEnter`](#onviewportenter)

Callback function that fires when an element enters the viewport. Provided the `[IntersectionObserverEntry](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserverEntry)` with details of the intersection event.

<motion.div @viewportEnter="(entry) => console.log(entry.isIntersecting)" />

#### [`onViewportLeave`](#onviewportleave)

Callback function that fires when an element enters the viewport. Provided the `[IntersectionObserverEntry](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserverEntry)` with details of the intersection event.

<motion.div @viewportLeave="(entry) => console.log(entry.intersectionRect)" />

### [Layout](#layout)

#### [`layout`](#layout-1)

**Default:**`false`

If `true`, this component will animate changes to its layout.

<motion.div layout />

If set to `"position"` or `"size"`, only its position or size will animate, respectively.

<motion.img layout="position" />

#### [`layoutId`](#layoutid)

If set, this component will animate changes to its layout. Additionally, when a new element enters the DOM and an element already exists with a matching `layoutId`, it will animate out from the previous element's size/position.

<motion.li v-for="item in items" layout>
    {{item.name}}
    <motion.div v-if="item.isSelected" layoutId="underline" />
 </motion.li>

If the previous component remains in the tree, the two elements will crossfade.

#### [`layoutDependency`](#layoutdependency)

By default, layout changes are detected every render. To reduce measurements and thus improve performance, you can pass a `layoutDependency` prop. Measurements will only occur when this value changes.

<motion.nav layout :layoutDependency="isOpen" />

#### [`layoutScroll`](#layoutscroll)

For layout animations to work correctly within scrollable elements, their scroll offset needs measuring. For performance reasons, `Motion` doesn't measure the scroll offset of every ancestor. Add the `layoutScroll` prop to elements that should be measured.

<motion.div layoutScroll style="{ overflow: 'scroll' }">
  <motion.div layout />
</motion.div>

#### [`layoutRoot`](#layoutroot)

For layout animations to work correctly within `position: fixed` elements, we need to account for page scroll. Add `layoutRoot` to mark an element as `position: fixed`.

<motion.div layoutRoot :style="{ position: 'fixed' }">
  <motion.div layout />
</motion.div>

#### [`onLayoutAnimationStart`](#onlayoutanimationstart)

A callback to run when a layout animation starts.

#### [`onLayoutAnimationComplete`](#onlayoutanimationcomplete)

A callback to run when a layout animation completes.

### [Advanced](#advanced)

#### [`inherit`](#inherit)

Set to `false` to prevent a component inheriting or propagating changes in a parent variant.

#### [`custom`](#custom)

Custom data to pass through to dynamic variants.



<template>
  <motion.ul animate="visible">
    <motion.li :custom="0" :variants="variants" />
    <motion.li :custom="1" :variants="variants" />
    <motion.li :custom="2" :variants="variants" />
  </motion.ul>
</template>

#### [`transformTemplate`](#transformtemplate)

By default, transforms are applied in order of `translate`, `scale`, `rotate` and `skew`.

To change this, `transformTemplate` can be set as a function that accepts the latest transforms and the generated transform string and returns a new transform string.


<motion.div
  :style="{ x: 0, rotate: 180 }"
  :transformTemplate="({ x, rotate }) => \`rotate(${rotate}deg) translateX(${x}px)\`"
/>


<motion.div
  :style="{ x: 0, rotate: 180 }"
  :transformTemplate="(latest, generated) => \`translate(-50%, -50%)${generated}\`"
/>

Previous

Transition options

Next

AnimatePresence

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