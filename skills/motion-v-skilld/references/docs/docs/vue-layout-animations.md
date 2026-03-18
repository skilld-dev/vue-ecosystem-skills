---
title: "Vue layout animations — FLIP & shared element | Motion"
meta:
  "og:description": "Animate layouts effortlessly in Vue with Motion's layout prop. Smoothly transition CSS, even between different elements using layoutId. Performant &amp; flexible."
  "og:title": "Vue layout animations — FLIP &amp; shared element | Motion"
  "twitter:description": "Animate layouts effortlessly in Vue with Motion's layout prop. Smoothly transition CSS, even between different elements using layoutId. Performant &amp; flexible."
  "twitter:title": "Vue layout animations — FLIP &amp; shared element | Motion"
  description: "Animate layouts effortlessly in Vue with Motion's layout prop. Smoothly transition CSS, even between different elements using layoutId. Performant &amp; flexible."
---

Vue

# Layout animation

Motion's industry-leading layout animations makes it easy to animate between any two layouts, even between different elements.

It's as simple as a `layout` prop.

<motion.div layout />

This little prop can animate previously unanimatable CSS values, like switching `justify-content` between `flex-start` and `flex-end`.

<motion.div
  layout
  :style="{ justifyContent: isOn ? 'flex-start' : 'flex-end' }"
/>

Or by using the `layoutId` prop, it's possible to match two elements and animate between them for some truly advanced animations.

<motion.li layoutId="item" />

It can handle anything from microinteractions to full page transitions.

## [Usage](#usage)

Any layout change that happens as a result of a Vue re-render can be animated.

<motion.div layout :style="{ width: isOpen ? '80vw' : 0 }" />

Note that CSS changes should happen immediately via `style`, not `animate`, as `layout` will take care of the animation.

Layout changes can be anything, changing `width`/`height`, number of grid columns, reordering a list, or adding/removing new items:

### [Shared layout animations](#shared-layout-animations)

When a new component is added that has a `layoutId` prop that matches an existing component, it will automatically animate out from the old component.

<motion.div v-if="isSelected" layoutId="underline" />

If the old component is still mounted when the new component enters, they will automatically crossfade from the old to the new.

When removing an element to animate back to its origin layout, `[AnimatePresence](https://motion.dev/vue-animate-presence)` can be used to keep it in the DOM until its exit animation has finished.

<AnimatePresence>
  <motion.div v-if="isOpen" layoutId="modal" />
</AnimatePresence>

### [Setting a transition](#setting-a-transition)

Layout animations can be customised using the`[transition](https://motion.dev/vue-transitions)` prop.

<motion.div layout :transition="{ duration: 0.3 }" />

If you want to set a transition specifically for **only** the layout animation, you can specify a specific `layout` transition.

<motion.div
  layout
  :animate="{ opacity: 0.5 }"
  :transition="{
    default: { ease: 'linear' },
    layout: { duration: 0.3 }
  }"
/>

When performing a shared layout animation, the transition defined for element we're animating **to** will be used.

<motion.button
  layoutId="modal"
  @click="() => isOn=true"
  // This transition will be used when the modal closes
  :transition="{ type: 'spring' }"
>
  Open
</motion.button>
<AnimatePresence>
    <motion.dialog
      v-if="isOn"
      layoutId="modal"
      // This transition will be used when the modal opens
      :transition="{ duration: 0.3 }"
    />
</AnimatePresence>

### [Animating within scrollable element](#animating-within-scrollable-element)

To correctly animate layout within scrollable elements, we need to provide them the `layoutScroll` prop.

<motion.div layoutScroll :style="{ overflow: 'scroll' }" />

This lets Motion account for the element's scroll offset when measuring children.

### [Animating within fixed containers](#animating-within-fixed-containers)

To correctly animate layout within fixed elements, we need to provide them the `layoutRoot` prop.

<motion.div layoutRoot :style="{ position: 'fixed' }" />

This lets Motion account for the page's scroll offset when measuring children.

### [Group layout animations](#group-layout-animations)

Layout animations are triggered when a component re-renders and its layout has changed.



<template>  
    <motion.div
      layout
      :style="{ height: isOpen ? "100px" : "500px" }"
      @click="() => open=!open"
    />
</template>

But what happens when we have two or more components that don't re-render at the same time, but **do** affect each other's layout?

<template>
    <Accordion />
    <Accordion />
</template>

When one re-renders, for performance reasons the other won't be able to detect changes to its layout.

We can synchronise layout changes across multiple components by wrapping them in the `[LayoutGroup component](https://motion.dev/vue-layout-group)`.



<template>
    <LayoutGroup>
      <Accordion />
      <Accordion />
    </LayoutGroup>  
</template>

When layout changes are detected in any grouped `motion` component, layout animations will trigger across all of them.

### [Scale correction](#scale-correction)

All layout animations are performed using the `transform` style, resulting in smooth framerates.

Animating layout using transforms can sometimes visually distort children. To correct this distortion, the first child elements of the element can also be given `layout` property.

Open this sandbox and try removing `layout` from the pink dot to see the difference this will make:

Transforms can also distort `boxShadow` and `borderRadius`. The `motion` component will automatically correct this distortion on both props, as long as they're set as motion values.

If you're not animating these values, the easiest way to do this is to set them via `style`.

<motion.div layout :style="{ borderRadius: 20 }" />

## [Troubleshooting](#troubleshooting)

### [The component isn't animating](#the-component-isn-t-animating)

Ensure the component is **not** set to `display: inline`, as browsers don't apply `transform` to these elements.

Ensure the component is re-rendering when you expect the layout animation to start.

### [SVG layout animations are broken](#svg-layout-animations-are-broken)

SVG components aren't currently supported with layout animations. SVGs don't have layout systems so it's recommended to directly animate their attributes like `cx` etc.

### [The content stretches undesirably](#the-content-stretches-undesirably)

This is a natural side-effect of animating `width` and `height` with `scale`.

Often, this can be fixed by providing these elements a `layout` animation and they'll be scale-corrected.

<motion.section layout>
  <motion.img layout />
</motion.section>

Some elements, like images or text that are changing between different aspect ratios, might be better animated with `layout="position"`.

### [Border radius or box shadows are behaving strangely](#border-radius-or-box-shadows-are-behaving-strangely)

Animating `scale` is performant but can distort some styles like `border-radius` and `box-shadow`.

Motion automatically corrects for scale distortion on these properties, but they must be set on the element via `style`.

<motion.div layout :style="{ borderRadius: '20px' }" />

### [Border looks stretched during animation](#border-looks-stretched-during-animation)

Elements with a `border` may look stretched during the animation. This is for two reasons:

1. Because changing `border` triggers layout recalculations, it defeats the performance benefits of animating via `transform`. You might as well animate `width` and `height` classically.
2. `border` can't render smaller than `1px`, which limits the degree of scale correction that Motion can perform on this style.

A work around is to replace `border` with a parent element with padding that acts as a `border`.

<motion.div layout :style="{ borderRadius: '10px', padding: '5px' }">
  <motion.div layout "style="{ borderRadius: '5px' }" />
</motion.div>

## [Technical reading](#technical-reading)

Interested in the technical details behind layout animations? Nanda does an incredible job of explaining the challenges of animating layout with transforms using interactive examples. Matt, creator of Motion, did a talk at Vercel conference about the implementation details that is largely up to date.

## [Differences with the View Transitions API](#differences-with-the-view-transitions-api)

More browsers are starting to support the View Transitions API, which is similar to Motion's layout animations.

### [Benefits of View Transitions API](#benefits-of-view-transitions-api)

The main two benefits of View Transitions is that **it's included in browsers** and **features a unique rendering system**.

#### [Filesize](#filesize)

Because the View Transitions API is already included in browsers, it's cheap to implement very simple crossfade animations.

However, the CSS complexity can scale quite quickly. Motion's layout animations are around 12kb but from there it's very cheap to change transitions, add springs, mark matching

#### [Rendering](#rendering)

Whereas Motion animates the elements as they exist on the page, View Transitions API does something quite unique in that it takes an image snapshot of the previous page state, and crossfades it with a live view of the new page state.

For shared elements, it does the same thing, taking little image snapshots and then crossfading those with a live view of the element's new state.

This can be leveraged to create interesting effects like full-screen wipes that aren't really in the scope of layout animations. Framer's Page Effects were built with the View Transitions API and it also extensively uses layout animations. The right tool for the right job.

### [Drawbacks to View Transitions API](#drawbacks-to-view-transitions-api)

There are quite a few drawbacks to the API vs layout animations:

- **Not interruptible**: Interrupting an animation mid-way will snap the animation to the end before starting the next one. This feels very janky.
- **Blocks interaction**: The animating elements overlay the "real" page underneath and block pointer events. Makes things feel quite sticky.
- **Difficult to manage IDs**: Layout animations allow more than one element with a `layoutId` whereas View Transitions will break if the previous element isn't removed.
- **Less performant:** View Transitions take an actual screenshot and animate via `width`/`height` vs layout animation's `transform`. This is measurably less performant when animating many elements.
- **Doesn't account for scroll**: If the page scroll changes during a view transition, elements will incorrectly animate this delta.
- **No relative animations:**If a nested element has a `delay` it will get "left behind" when its parent animates away, whereas Motion handles this kind of relative animation.
- **One animation at a time**: View Transitions animate the whole screen, which means combining it with other animations is difficult and other view animations impossible.

All-in-all, each system offers something different and each might be a better fit for your needs. In the future it might be that Motion also offers an API based on View Transitions API.

Motion's industry-leading layout animations makes it easy to animate between any two layouts, even between different elements.

It's as simple as a `layout` prop.

<motion.div layout />

This little prop can animate previously unanimatable CSS values, like switching `justify-content` between `flex-start` and `flex-end`.

<motion.div
  layout
  :style="{ justifyContent: isOn ? 'flex-start' : 'flex-end' }"
/>

Or by using the `layoutId` prop, it's possible to match two elements and animate between them for some truly advanced animations.

<motion.li layoutId="item" />

It can handle anything from microinteractions to full page transitions.

## [Usage](#usage)

Any layout change that happens as a result of a Vue re-render can be animated.

<motion.div layout :style="{ width: isOpen ? '80vw' : 0 }" />

Note that CSS changes should happen immediately via `style`, not `animate`, as `layout` will take care of the animation.

Layout changes can be anything, changing `width`/`height`, number of grid columns, reordering a list, or adding/removing new items:

### [Shared layout animations](#shared-layout-animations)

When a new component is added that has a `layoutId` prop that matches an existing component, it will automatically animate out from the old component.

<motion.div v-if="isSelected" layoutId="underline" />

If the old component is still mounted when the new component enters, they will automatically crossfade from the old to the new.

When removing an element to animate back to its origin layout, `[AnimatePresence](https://motion.dev/vue-animate-presence)` can be used to keep it in the DOM until its exit animation has finished.

<AnimatePresence>
  <motion.div v-if="isOpen" layoutId="modal" />
</AnimatePresence>

### [Setting a transition](#setting-a-transition)

Layout animations can be customised using the`[transition](https://motion.dev/vue-transitions)` prop.

<motion.div layout :transition="{ duration: 0.3 }" />

If you want to set a transition specifically for **only** the layout animation, you can specify a specific `layout` transition.

<motion.div
  layout
  :animate="{ opacity: 0.5 }"
  :transition="{
    default: { ease: 'linear' },
    layout: { duration: 0.3 }
  }"
/>

When performing a shared layout animation, the transition defined for element we're animating **to** will be used.

<motion.button
  layoutId="modal"
  @click="() => isOn=true"
  // This transition will be used when the modal closes
  :transition="{ type: 'spring' }"
>
  Open
</motion.button>
<AnimatePresence>
    <motion.dialog
      v-if="isOn"
      layoutId="modal"
      // This transition will be used when the modal opens
      :transition="{ duration: 0.3 }"
    />
</AnimatePresence>

### [Animating within scrollable element](#animating-within-scrollable-element)

To correctly animate layout within scrollable elements, we need to provide them the `layoutScroll` prop.

<motion.div layoutScroll :style="{ overflow: 'scroll' }" />

This lets Motion account for the element's scroll offset when measuring children.

### [Animating within fixed containers](#animating-within-fixed-containers)

To correctly animate layout within fixed elements, we need to provide them the `layoutRoot` prop.

<motion.div layoutRoot :style="{ position: 'fixed' }" />

This lets Motion account for the page's scroll offset when measuring children.

### [Group layout animations](#group-layout-animations)

Layout animations are triggered when a component re-renders and its layout has changed.



<template>  
    <motion.div
      layout
      :style="{ height: isOpen ? "100px" : "500px" }"
      @click="() => open=!open"
    />
</template>

But what happens when we have two or more components that don't re-render at the same time, but **do** affect each other's layout?

<template>
    <Accordion />
    <Accordion />
</template>

When one re-renders, for performance reasons the other won't be able to detect changes to its layout.

We can synchronise layout changes across multiple components by wrapping them in the `[LayoutGroup component](https://motion.dev/vue-layout-group)`.



<template>
    <LayoutGroup>
      <Accordion />
      <Accordion />
    </LayoutGroup>  
</template>

When layout changes are detected in any grouped `motion` component, layout animations will trigger across all of them.

### [Scale correction](#scale-correction)

All layout animations are performed using the `transform` style, resulting in smooth framerates.

Animating layout using transforms can sometimes visually distort children. To correct this distortion, the first child elements of the element can also be given `layout` property.

Open this sandbox and try removing `layout` from the pink dot to see the difference this will make:

Transforms can also distort `boxShadow` and `borderRadius`. The `motion` component will automatically correct this distortion on both props, as long as they're set as motion values.

If you're not animating these values, the easiest way to do this is to set them via `style`.

<motion.div layout :style="{ borderRadius: 20 }" />

## [Troubleshooting](#troubleshooting)

### [The component isn't animating](#the-component-isn-t-animating)

Ensure the component is **not** set to `display: inline`, as browsers don't apply `transform` to these elements.

Ensure the component is re-rendering when you expect the layout animation to start.

### [SVG layout animations are broken](#svg-layout-animations-are-broken)

SVG components aren't currently supported with layout animations. SVGs don't have layout systems so it's recommended to directly animate their attributes like `cx` etc.

### [The content stretches undesirably](#the-content-stretches-undesirably)

This is a natural side-effect of animating `width` and `height` with `scale`.

Often, this can be fixed by providing these elements a `layout` animation and they'll be scale-corrected.

<motion.section layout>
  <motion.img layout />
</motion.section>

Some elements, like images or text that are changing between different aspect ratios, might be better animated with `layout="position"`.

### [Border radius or box shadows are behaving strangely](#border-radius-or-box-shadows-are-behaving-strangely)

Animating `scale` is performant but can distort some styles like `border-radius` and `box-shadow`.

Motion automatically corrects for scale distortion on these properties, but they must be set on the element via `style`.

<motion.div layout :style="{ borderRadius: '20px' }" />

### [Border looks stretched during animation](#border-looks-stretched-during-animation)

Elements with a `border` may look stretched during the animation. This is for two reasons:

1. Because changing `border` triggers layout recalculations, it defeats the performance benefits of animating via `transform`. You might as well animate `width` and `height` classically.
2. `border` can't render smaller than `1px`, which limits the degree of scale correction that Motion can perform on this style.

A work around is to replace `border` with a parent element with padding that acts as a `border`.

<motion.div layout :style="{ borderRadius: '10px', padding: '5px' }">
  <motion.div layout "style="{ borderRadius: '5px' }" />
</motion.div>

## [Technical reading](#technical-reading)

Interested in the technical details behind layout animations? Nanda does an incredible job of explaining the challenges of animating layout with transforms using interactive examples. Matt, creator of Motion, did a talk at Vercel conference about the implementation details that is largely up to date.

## [Differences with the View Transitions API](#differences-with-the-view-transitions-api)

More browsers are starting to support the View Transitions API, which is similar to Motion's layout animations.

### [Benefits of View Transitions API](#benefits-of-view-transitions-api)

The main two benefits of View Transitions is that **it's included in browsers** and **features a unique rendering system**.

#### [Filesize](#filesize)

Because the View Transitions API is already included in browsers, it's cheap to implement very simple crossfade animations.

However, the CSS complexity can scale quite quickly. Motion's layout animations are around 12kb but from there it's very cheap to change transitions, add springs, mark matching

#### [Rendering](#rendering)

Whereas Motion animates the elements as they exist on the page, View Transitions API does something quite unique in that it takes an image snapshot of the previous page state, and crossfades it with a live view of the new page state.

For shared elements, it does the same thing, taking little image snapshots and then crossfading those with a live view of the element's new state.

This can be leveraged to create interesting effects like full-screen wipes that aren't really in the scope of layout animations. Framer's Page Effects were built with the View Transitions API and it also extensively uses layout animations. The right tool for the right job.

### [Drawbacks to View Transitions API](#drawbacks-to-view-transitions-api)

There are quite a few drawbacks to the API vs layout animations:

- **Not interruptible**: Interrupting an animation mid-way will snap the animation to the end before starting the next one. This feels very janky.
- **Blocks interaction**: The animating elements overlay the "real" page underneath and block pointer events. Makes things feel quite sticky.
- **Difficult to manage IDs**: Layout animations allow more than one element with a `layoutId` whereas View Transitions will break if the previous element isn't removed.
- **Less performant:** View Transitions take an actual screenshot and animate via `width`/`height` vs layout animation's `transform`. This is measurably less performant when animating many elements.
- **Doesn't account for scroll**: If the page scroll changes during a view transition, elements will incorrectly animate this delta.
- **No relative animations:**If a nested element has a `delay` it will get "left behind" when its parent animates away, whereas Motion handles this kind of relative animation.
- **One animation at a time**: View Transitions animate the whole screen, which means combining it with other animations is difficult and other view animations impossible.

All-in-all, each system offers something different and each might be a better fit for your needs. In the future it might be that Motion also offers an API based on View Transitions API.

Motion's industry-leading layout animations makes it easy to animate between any two layouts, even between different elements.

It's as simple as a `layout` prop.

<motion.div layout />

This little prop can animate previously unanimatable CSS values, like switching `justify-content` between `flex-start` and `flex-end`.

<motion.div
  layout
  :style="{ justifyContent: isOn ? 'flex-start' : 'flex-end' }"
/>

Or by using the `layoutId` prop, it's possible to match two elements and animate between them for some truly advanced animations.

<motion.li layoutId="item" />

It can handle anything from microinteractions to full page transitions.

## [Usage](#usage)

Any layout change that happens as a result of a Vue re-render can be animated.

<motion.div layout :style="{ width: isOpen ? '80vw' : 0 }" />

Note that CSS changes should happen immediately via `style`, not `animate`, as `layout` will take care of the animation.

Layout changes can be anything, changing `width`/`height`, number of grid columns, reordering a list, or adding/removing new items:

### [Shared layout animations](#shared-layout-animations)

When a new component is added that has a `layoutId` prop that matches an existing component, it will automatically animate out from the old component.

<motion.div v-if="isSelected" layoutId="underline" />

If the old component is still mounted when the new component enters, they will automatically crossfade from the old to the new.

When removing an element to animate back to its origin layout, `[AnimatePresence](https://motion.dev/vue-animate-presence)` can be used to keep it in the DOM until its exit animation has finished.

<AnimatePresence>
  <motion.div v-if="isOpen" layoutId="modal" />
</AnimatePresence>

### [Setting a transition](#setting-a-transition)

Layout animations can be customised using the`[transition](https://motion.dev/vue-transitions)` prop.

<motion.div layout :transition="{ duration: 0.3 }" />

If you want to set a transition specifically for **only** the layout animation, you can specify a specific `layout` transition.

<motion.div
  layout
  :animate="{ opacity: 0.5 }"
  :transition="{
    default: { ease: 'linear' },
    layout: { duration: 0.3 }
  }"
/>

When performing a shared layout animation, the transition defined for element we're animating **to** will be used.

<motion.button
  layoutId="modal"
  @click="() => isOn=true"
  // This transition will be used when the modal closes
  :transition="{ type: 'spring' }"
>
  Open
</motion.button>
<AnimatePresence>
    <motion.dialog
      v-if="isOn"
      layoutId="modal"
      // This transition will be used when the modal opens
      :transition="{ duration: 0.3 }"
    />
</AnimatePresence>

### [Animating within scrollable element](#animating-within-scrollable-element)

To correctly animate layout within scrollable elements, we need to provide them the `layoutScroll` prop.

<motion.div layoutScroll :style="{ overflow: 'scroll' }" />

This lets Motion account for the element's scroll offset when measuring children.

### [Animating within fixed containers](#animating-within-fixed-containers)

To correctly animate layout within fixed elements, we need to provide them the `layoutRoot` prop.

<motion.div layoutRoot :style="{ position: 'fixed' }" />

This lets Motion account for the page's scroll offset when measuring children.

### [Group layout animations](#group-layout-animations)

Layout animations are triggered when a component re-renders and its layout has changed.



<template>  
    <motion.div
      layout
      :style="{ height: isOpen ? "100px" : "500px" }"
      @click="() => open=!open"
    />
</template>

But what happens when we have two or more components that don't re-render at the same time, but **do** affect each other's layout?

<template>
    <Accordion />
    <Accordion />
</template>

When one re-renders, for performance reasons the other won't be able to detect changes to its layout.

We can synchronise layout changes across multiple components by wrapping them in the `[LayoutGroup component](https://motion.dev/vue-layout-group)`.



<template>
    <LayoutGroup>
      <Accordion />
      <Accordion />
    </LayoutGroup>  
</template>

When layout changes are detected in any grouped `motion` component, layout animations will trigger across all of them.

### [Scale correction](#scale-correction)

All layout animations are performed using the `transform` style, resulting in smooth framerates.

Animating layout using transforms can sometimes visually distort children. To correct this distortion, the first child elements of the element can also be given `layout` property.

Open this sandbox and try removing `layout` from the pink dot to see the difference this will make:

Transforms can also distort `boxShadow` and `borderRadius`. The `motion` component will automatically correct this distortion on both props, as long as they're set as motion values.

If you're not animating these values, the easiest way to do this is to set them via `style`.

<motion.div layout :style="{ borderRadius: 20 }" />

## [Troubleshooting](#troubleshooting)

### [The component isn't animating](#the-component-isn-t-animating)

Ensure the component is **not** set to `display: inline`, as browsers don't apply `transform` to these elements.

Ensure the component is re-rendering when you expect the layout animation to start.

### [SVG layout animations are broken](#svg-layout-animations-are-broken)

SVG components aren't currently supported with layout animations. SVGs don't have layout systems so it's recommended to directly animate their attributes like `cx` etc.

### [The content stretches undesirably](#the-content-stretches-undesirably)

This is a natural side-effect of animating `width` and `height` with `scale`.

Often, this can be fixed by providing these elements a `layout` animation and they'll be scale-corrected.

<motion.section layout>
  <motion.img layout />
</motion.section>

Some elements, like images or text that are changing between different aspect ratios, might be better animated with `layout="position"`.

### [Border radius or box shadows are behaving strangely](#border-radius-or-box-shadows-are-behaving-strangely)

Animating `scale` is performant but can distort some styles like `border-radius` and `box-shadow`.

Motion automatically corrects for scale distortion on these properties, but they must be set on the element via `style`.

<motion.div layout :style="{ borderRadius: '20px' }" />

### [Border looks stretched during animation](#border-looks-stretched-during-animation)

Elements with a `border` may look stretched during the animation. This is for two reasons:

1. Because changing `border` triggers layout recalculations, it defeats the performance benefits of animating via `transform`. You might as well animate `width` and `height` classically.
2. `border` can't render smaller than `1px`, which limits the degree of scale correction that Motion can perform on this style.

A work around is to replace `border` with a parent element with padding that acts as a `border`.

<motion.div layout :style="{ borderRadius: '10px', padding: '5px' }">
  <motion.div layout "style="{ borderRadius: '5px' }" />
</motion.div>

## [Technical reading](#technical-reading)

Interested in the technical details behind layout animations? Nanda does an incredible job of explaining the challenges of animating layout with transforms using interactive examples. Matt, creator of Motion, did a talk at Vercel conference about the implementation details that is largely up to date.

## [Differences with the View Transitions API](#differences-with-the-view-transitions-api)

More browsers are starting to support the View Transitions API, which is similar to Motion's layout animations.

### [Benefits of View Transitions API](#benefits-of-view-transitions-api)

The main two benefits of View Transitions is that **it's included in browsers** and **features a unique rendering system**.

#### [Filesize](#filesize)

Because the View Transitions API is already included in browsers, it's cheap to implement very simple crossfade animations.

However, the CSS complexity can scale quite quickly. Motion's layout animations are around 12kb but from there it's very cheap to change transitions, add springs, mark matching

#### [Rendering](#rendering)

Whereas Motion animates the elements as they exist on the page, View Transitions API does something quite unique in that it takes an image snapshot of the previous page state, and crossfades it with a live view of the new page state.

For shared elements, it does the same thing, taking little image snapshots and then crossfading those with a live view of the element's new state.

This can be leveraged to create interesting effects like full-screen wipes that aren't really in the scope of layout animations. Framer's Page Effects were built with the View Transitions API and it also extensively uses layout animations. The right tool for the right job.

### [Drawbacks to View Transitions API](#drawbacks-to-view-transitions-api)

There are quite a few drawbacks to the API vs layout animations:

- **Not interruptible**: Interrupting an animation mid-way will snap the animation to the end before starting the next one. This feels very janky.
- **Blocks interaction**: The animating elements overlay the "real" page underneath and block pointer events. Makes things feel quite sticky.
- **Difficult to manage IDs**: Layout animations allow more than one element with a `layoutId` whereas View Transitions will break if the previous element isn't removed.
- **Less performant:** View Transitions take an actual screenshot and animate via `width`/`height` vs layout animation's `transform`. This is measurably less performant when animating many elements.
- **Doesn't account for scroll**: If the page scroll changes during a view transition, elements will incorrectly animate this delta.
- **No relative animations:**If a nested element has a `delay` it will get "left behind" when its parent animates away, whereas Motion handles this kind of relative animation.
- **One animation at a time**: View Transitions animate the whole screen, which means combining it with other animations is difficult and other view animations impossible.

All-in-all, each system offers something different and each might be a better fit for your needs. In the future it might be that Motion also offers an API based on View Transitions API.

Previous

Gesture animation

Next

Scroll animation

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