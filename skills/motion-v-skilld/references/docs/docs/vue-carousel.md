---
title: "Carousel, a performant, infinite scrolling carousel | Motion"
meta:
  "og:description": "A production-ready Vue carousel featuring infinite scrolling, composable controls, and animated pagination. Lightweight, fully accessible, and supports touch, wheel, and keyboard navigation."
  "og:title": "Carousel, a performant, infinite scrolling carousel | Motion"
  "twitter:description": "A production-ready Vue carousel featuring infinite scrolling, composable controls, and animated pagination. Lightweight, fully accessible, and supports touch, wheel, and keyboard navigation."
  "twitter:title": "Carousel, a performant, infinite scrolling carousel | Motion"
  description: "A production-ready Vue carousel featuring infinite scrolling, composable controls, and animated pagination. Lightweight, fully accessible, and supports touch, wheel, and keyboard navigation."
---

Vue

Motion+ Exclusive

# Carousel

This feature is available with Motion+

Checking Motion+ status…

Carousel

is exclusive to Motion+

300+ examples & 40+ tutorials

Premium APIs

Motion Studio editing tools

`alpha`

Discord community

Early access

Lifetime updates

Get Motion+ for instant access

One-time payment, lifetime updates

Already joined?

Login

The Carousel component creates performant, accessible and fully-featured carousels in Vue. It's designed to be flexible and easy to use, supporting pointer, wheel and keyboard navigation out the box.

It allows you to go beyond the traditional limitations of CSS-only approaches, with support for infinitely-scrolling carousels and without limitations on styling.

### [Features](#features)

- **Lightweight:** Just `+5.8kb` on top of the`[motion](https://motion.dev/vue-motion-component)` component.
- **Accessible:** Automatic ARIA labels, respects reduced motion, RTL layouts, and all major input methods.
- **Performant:** Built on the same unique rendering used by the Ticker component that achieves infinite scrolling with while minimising or eliminating item cloning.
- **Customisable:** Provides functions and state to easily create custom controls and pagination.

## [Install](#install)

npm

npm

npm

## [Usage](#usage)

### [Import](#import)

Import the `Carousel` component from "motion-plus-vue"`:

import { Carousel } from "motion-plus-vue"

import { Carousel } from "motion-plus-vue"

import { Carousel } from "motion-plus-vue"

`Carousel` component receives its items via the `default slot`. You can pass any valid Vue nodes (components, strings, or numbers)

<Carousel>
    <span>One</span>
    <span>Two</span>
    <span>Three</span>
 </Carousel>

<Carousel>
    <span>One</span>
    <span>Two</span>
    <span>Three</span>
 </Carousel>

<Carousel>
    <span>One</span>
    <span>Two</span>
    <span>Three</span>
 </Carousel>

<Carousel>
  <Box src="sonic3" title="Sonic 3" />  
  <div>Some text</div>                   
  123                                    
</Carousel>
<

<Carousel>
  <Box src="sonic3" title="Sonic 3" />  
  <div>Some text</div>                   
  123                                    
</Carousel>
<

<Carousel>
  <Box src="sonic3" title="Sonic 3" />  
  <div>Some text</div>                   
  123                                    
</Carousel>
<

<Carousel>
  <Box src="sonic3" title="Sonic 3" />
  
  <Fragment>
    <div>Some text</div>
    123
  </Fragment>
</Carousel>

<Carousel>
  <Box src="sonic3" title="Sonic 3" />
  
  <Fragment>
    <div>Some text</div>
    123
  </Fragment>
</Carousel>

<Carousel>
  <Box src="sonic3" title="Sonic 3" />
  
  <Fragment>
    <div>Some text</div>
    123
  </Fragment>
</Carousel>

### [Direction](#direction)

By default, carousels will scroll horizontally. Setting the `axis` prop to `y`, we can make them vertical.

<Carousel axis="y" />

<Carousel axis="y" />

<Carousel axis="y" />

### [Layout](#layout)

Items are laid out via flexbox. Passing `gap` and `align` will adjust the spacing and off-axis alignment of them items.

<Carousel  :gap="0" align="start" />

<Carousel  :gap="0" align="start" />

<Carousel  :gap="0" align="start" />

### [Overflow](#overflow)

By setting `overflow` to `true`, items will visually extend out from the container to the edges of the viewport.

<Carousel  overflow />

<Carousel  overflow />

<Carousel  overflow />

This makes it straightforward to place a `Carousel` within a document flow but still extend the ticker effect across the full viewport.

### [Infinite scrolling](#infinite-scrolling)

By default, carousels will scroll infinitely. This can be disabled by setting `:loop="false"`.

<Carousel :loop="false"/>

<Carousel :loop="false"/>

<Carousel :loop="false"/>

### [Layout](#layout-1)

By default, each item will be sized according to its contents. By setting `itemSize="fill"`, items will extend the match the width of the container.

<Carousel itemSize="fill" />

<Carousel itemSize="fill" />

<Carousel itemSize="fill" />

### [Snapping](#snapping)

By default, drag and wheel controls will snap between pages. By setting `:snap="false"`, snapping can be disabled and the carousel will freely scroll.

<Carousel  :snap="false" />

<Carousel  :snap="false" />

<Carousel  :snap="false" />

### [Custom controls](#custom-controls)

Custom controls can be passed to Carousel using the `after` slots. The `after` slot renders `after` the Carousel container:

<Carousel :loop="false" >
    {{items}}
  <template #after>
    <Next/>
  </template>
</Carousel>

<Carousel :loop="false" >
    {{items}}
  <template #after>
    <Next/>
  </template>
</Carousel>

<Carousel :loop="false" >
    {{items}}
  <template #after>
    <Next/>
  </template>
</Carousel>

Any component rendered within `Carousel` can call `useCarousel` to access state and pagination functions. This hook provides:

- `nextPage`/`prevPage`: Paginate next/previous.
- `gotoPage`: Pass it a page index to animate to this page.
- `paginationState`:
  - `isNextActive`/`isPrevActive`: If `:loop="false"` then these will be false when we hit the limits of the carousel.
  - `currentPage`: Index of the current page
  - `totalPages`: Number of total pages.

<script setup>
import { useCarousel } from "motion-plus-vue"

const { nextPage, isNextActive } = useCarousel()
</script>

<template>
  <button :disabled="!isNextActive" @click="nextPage">
    Next
  </button>
</template>

<script setup>
import { useCarousel } from "motion-plus-vue"

const { nextPage, isNextActive } = useCarousel()
</script>

<template>
  <button :disabled="!isNextActive" @click="nextPage">
    Next
  </button>
</template>

<script setup>
import { useCarousel } from "motion-plus-vue"

const { nextPage, isNextActive } = useCarousel()
</script>

<template>
  <button :disabled="!isNextActive" @click="nextPage">
    Next
  </button>
</template>

### [Autoplay](#autoplay)

With `currentPage` and `nextPage` from `useCarousel`, we can also set up our own autoplay functionality.

By watching `currentPage` with `watch`, the timer will restart whenever the page changes, whether that's from a swipe/drag, or from the autoplay timer itself.

const { paginationState, nextPage } = useCarousel()
const progress = useMotionValue(0)

watch(
  [() => paginationState.value.currentPage, () => props.duration],
  (_1,_2,onCleanup) => {
    const animation = animate(progress, [0, 1], {
      duration,
      ease: "linear",
      onComplete: nextPage,
    })
    
    onCleanup(() => {
      animation.stop()
    })
  },
  { immediate: true }
)

const { paginationState, nextPage } = useCarousel()
const progress = useMotionValue(0)

watch(
  [() => paginationState.value.currentPage, () => props.duration],
  (_1,_2,onCleanup) => {
    const animation = animate(progress, [0, 1], {
      duration,
      ease: "linear",
      onComplete: nextPage,
    })
    
    onCleanup(() => {
      animation.stop()
    })
  },
  { immediate: true }
)

const { paginationState, nextPage } = useCarousel()
const progress = useMotionValue(0)

watch(
  [() => paginationState.value.currentPage, () => props.duration],
  (_1,_2,onCleanup) => {
    const animation = animate(progress, [0, 1], {
      duration,
      ease: "linear",
      onComplete: nextPage,
    })
    
    onCleanup(() => {
      animation.stop()
    })
  },
  { immediate: true }
)

### [Pagination visualisation](#pagination-visualisation)

By using `currentPage`, `totalPages` and `gotoPage` from `useCarousel`, a custom pagination indicator/navigator can be built.



<template>
  <ul class="dots">
    <li 
      v-for="(_, index) in Array.from({ length: paginationState.totalPages })" 
      :key="index"
      class="dot"
    >
      <motion.button
        :initial="false"
        :animate="{ opacity: paginationState.currentPage === index ? 1 : 0.5 }"
        tag="button"
        @click="gotoPage(index)"
      />
    </li>
  </ul>
</template>



<template>
  <ul class="dots">
    <li 
      v-for="(_, index) in Array.from({ length: paginationState.totalPages })" 
      :key="index"
      class="dot"
    >
      <motion.button
        :initial="false"
        :animate="{ opacity: paginationState.currentPage === index ? 1 : 0.5 }"
        tag="button"
        @click="gotoPage(index)"
      />
    </li>
  </ul>
</template>



<template>
  <ul class="dots">
    <li 
      v-for="(_, index) in Array.from({ length: paginationState.totalPages })" 
      :key="index"
      class="dot"
    >
      <motion.button
        :initial="false"
        :animate="{ opacity: paginationState.currentPage === index ? 1 : 0.5 }"
        tag="button"
        @click="gotoPage(index)"
      />
    </li>
  </ul>
</template>

## Related topics

- Motion+<h3>Ticker</h3>Infinitely-scrolling ticker and marquee effects, driven by time, drag or scroll. Ticker Motion+<h3>Ticker</h3>Infinitely-scrolling ticker and marquee effects, driven by time, drag or scroll. Ticker

- <h3>Carousel examples</h3>See all examples & tutorials, with full copy & paste source code. Carousel examples

- <h3>Carousel examples</h3>See all examples & tutorials, with full copy & paste source code. Carousel examples

Previous

AnimateNumber

Next

Cursor

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