---
title: "AnimatePresence — Vue exit animations | Motion"
meta:
  "og:description": "Enable effortless exit animations in Vue with AnimatePresence. It animates components on removal via the exit prop."
  "og:title": "AnimatePresence — Vue exit animations | Motion"
  "twitter:description": "Enable effortless exit animations in Vue with AnimatePresence. It animates components on removal via the exit prop."
  "twitter:title": "AnimatePresence — Vue exit animations | Motion"
  description: "Enable effortless exit animations in Vue with AnimatePresence. It animates components on removal via the exit prop."
---

Vue

# AnimatePresence

`AnimatePresence` makes exit animations easy. By wrapping one or more `[motion](https://motion.dev/vue-motion-component)` components with `AnimatePresence`, we gain access to the `exit` animation prop.

<AnimatePresence>
  <motion.div v-if="show" key="modal" :exit="{ opacity: 0 }" />}
</AnimatePresence>

## [Usage](#usage)

### [Import](#import)

import { AnimatePresence } from "motion-v"

### [Exit animations](#exit-animations)

`AnimatePresence` works by detecting when its **direct children** are removed from the Vue tree.

This can be due to a component mounting/remounting:

<AnimatePresence>
  <Modal v-if="show" key="modal" />
</AnimatePresence>

or using `v-show`:

<AnimatePresence>
  <Modal v-show="show" key="modal" />
</AnimatePresence>

Or Its `key` changing:

<AnimatePresence>
  <Slide :key="activeItem.id" />
</AnimatePresence>

Or when children in a list are added/removed:

<AnimatePresence>
    <motion.li 
      v-for="item in items" 
      :key="item.id" 
      :exit="{ opacity: 1 }" layout
    />
</AnimatePresence>

Any `motion` components within the exiting component will fire animations defined on their `exit` props before the component is removed from the DOM.

<template>
  <motion.div :exit="{ opacity: 0 }">
    <img :src="img.src" />
    <motion.p :exit="{ y: 10 }">{{description}}</motion.p>
  </motion.div>
</template>

**Note:**Direct children must each have a unique `key` prop so `AnimatePresence` can track their presence in the tree.

Like `initial` and `animate`, `exit` can be defined either as an object of values, or as a variant label.



<template>
    <motion.div 
      :variants="modalVariants"
      initial="hidden" animate="visible" exit="hidden"
    >
      {{children}}
    </motion.div>
</template>

### [Changing `key`](#changing-key)

Changing a `key` prop makes Vue create an entirely new component. So by changing the `key` of a single child of `AnimatePresence`, we can easily make components like slideshows.

<template>
  <AnimatePresence>
    <motion.img
      :key="image.src"
      :src="image.src"
      :initial="{ x: 300, opacity: 0 }"
      :animate="{ x: 0, opacity: 1 }"
      :exit="{ x: -300, opacity: 0 }"
    />
  </AnimatePresence>
</template>

## [Props](#props)

### [`initial`](#initial)

By passing `:initial="false"`, `AnimatePresence` will disable any initial animations on children that are present when the component is first rendered.

<AnimatePresence :initial="false">
  <Slide :key="activeItem.id" />
</AnimatePresence>

### [`custom`](#custom)

When a component is removed, there's no longer a chance to update its props (because it's no longer in the Vue tree). Therefore we can't update its exit animation with the same render that removed the component.

By passing a value through `AnimatePresence`'s `custom` prop, we can use dynamic variants to change the `exit` animation.



<template> 
  <AnimatePresence :custom="direction">
    <motion.img
      :key="image.src"
      :src="image.src"
      :variants="variants"
      initial="hidden"
      animate="visible"
      exit="hidden"
    />
  </AnimatePresence>
</template>

### [`mode`](#mode)

**Default:**`"sync"`

Decides how `AnimatePresence` handles entering and exiting children.

- `"sync"`: Children animate in/out as soon as they're added/removed.
- `"wait"`: The entering child will wait until the exiting child has animated out. **Note:**Currently only renders a single child at a time.
- `"popLayout"`: Exiting children will be "popped" out of the page layout. This allows surrounding elements to move to their new layout immediately.

### [`onExitComplete`](#onexitcomplete)

Fires when all exiting nodes have completed animating out.

## [Troubleshooting](#troubleshooting)

### [Exit animations aren't working](#exit-animations-aren-t-working)

Ensure all **immediate** children get a unique `key` prop that **remains the same for that component every render**.

For instance, providing `index` as a `key` is **bad** because if the items reorder then the `index` will not be matched to the `item`:

<AnimatePresence>
  <Component v-for="(item,index) in items" :key="index" />
</AnimatePresence>

It's preferred to pass something that's unique to that item, for instance an ID:

<AnimatePresence>
  <Componen v-for="(item,index) in items" :key="item.id" />
</AnimatePresence>

Also make sure `AnimatePresence` is **outside** of the code that unmounts the element. If `AnimatePresence` itself unmounts, then it can't control exit animations!

For example, this will **not work**:

<AnimatePresence v-if="isVisible">
  <Component />
</AnimatePresence>

Instead, the conditional should be at the root of `AnimatePresence`:

<AnimatePresence>
  <Component v-if="isVisible" />
</AnimatePresence>

### [Layout animations not working with `mode="sync"`](#layout-animations-not-working-with-mode-sync)

When mixing layout and exit animations, it might be necessary to wrap the group in `[LayoutGroup](https://motion.dev/vue-layout-group)` to ensure that components outside of `AnimatePresence` know when to perform a layout animation.

<LayoutGroup>
  <motion.ul layout>
    <AnimatePresence>
        <motion.li v-for="item in items" layout :key="item.id" />
    </AnimatePresence>
  </motion.ul>
</LayoutGroup>

### [Layout animations not working with `mode="popLayout"`](#layout-animations-not-working-with-mode-poplayout)

When any HTML element has an active `transform` it temporarily becomes the offset parent of its children. This can cause children with `position: "absolute"` not to appear where you expect.`mode="popLayout"` works by using `position: "absolute"`. So to ensure consistent and expected positioning during a layout animation, ensure that the animating parent has a `position` other than `"static"`.

<motion.ul layout :style="{ position: 'relative' }">
  <AnimatePresence mode="popLayout">
      <motion.li v-for="item in items" layout :key="item.id" />
  </AnimatePresence>
</motion.ul>

`AnimatePresence` makes exit animations easy. By wrapping one or more `[motion](https://motion.dev/vue-motion-component)` components with `AnimatePresence`, we gain access to the `exit` animation prop.

<AnimatePresence>
  <motion.div v-if="show" key="modal" :exit="{ opacity: 0 }" />}
</AnimatePresence>

## [Usage](#usage)

### [Import](#import)

import { AnimatePresence } from "motion-v"

### [Exit animations](#exit-animations)

`AnimatePresence` works by detecting when its **direct children** are removed from the Vue tree.

This can be due to a component mounting/remounting:

<AnimatePresence>
  <Modal v-if="show" key="modal" />
</AnimatePresence>

or using `v-show`:

<AnimatePresence>
  <Modal v-show="show" key="modal" />
</AnimatePresence>

Or Its `key` changing:

<AnimatePresence>
  <Slide :key="activeItem.id" />
</AnimatePresence>

Or when children in a list are added/removed:

<AnimatePresence>
    <motion.li 
      v-for="item in items" 
      :key="item.id" 
      :exit="{ opacity: 1 }" layout
    />
</AnimatePresence>

Any `motion` components within the exiting component will fire animations defined on their `exit` props before the component is removed from the DOM.

<template>
  <motion.div :exit="{ opacity: 0 }">
    <img :src="img.src" />
    <motion.p :exit="{ y: 10 }">{{description}}</motion.p>
  </motion.div>
</template>

**Note:**Direct children must each have a unique `key` prop so `AnimatePresence` can track their presence in the tree.

Like `initial` and `animate`, `exit` can be defined either as an object of values, or as a variant label.



<template>
    <motion.div 
      :variants="modalVariants"
      initial="hidden" animate="visible" exit="hidden"
    >
      {{children}}
    </motion.div>
</template>

### [Changing `key`](#changing-key)

Changing a `key` prop makes Vue create an entirely new component. So by changing the `key` of a single child of `AnimatePresence`, we can easily make components like slideshows.

<template>
  <AnimatePresence>
    <motion.img
      :key="image.src"
      :src="image.src"
      :initial="{ x: 300, opacity: 0 }"
      :animate="{ x: 0, opacity: 1 }"
      :exit="{ x: -300, opacity: 0 }"
    />
  </AnimatePresence>
</template>

## [Props](#props)

### [`initial`](#initial)

By passing `:initial="false"`, `AnimatePresence` will disable any initial animations on children that are present when the component is first rendered.

<AnimatePresence :initial="false">
  <Slide :key="activeItem.id" />
</AnimatePresence>

### [`custom`](#custom)

When a component is removed, there's no longer a chance to update its props (because it's no longer in the Vue tree). Therefore we can't update its exit animation with the same render that removed the component.

By passing a value through `AnimatePresence`'s `custom` prop, we can use dynamic variants to change the `exit` animation.



<template> 
  <AnimatePresence :custom="direction">
    <motion.img
      :key="image.src"
      :src="image.src"
      :variants="variants"
      initial="hidden"
      animate="visible"
      exit="hidden"
    />
  </AnimatePresence>
</template>

### [`mode`](#mode)

**Default:**`"sync"`

Decides how `AnimatePresence` handles entering and exiting children.

- `"sync"`: Children animate in/out as soon as they're added/removed.
- `"wait"`: The entering child will wait until the exiting child has animated out. **Note:**Currently only renders a single child at a time.
- `"popLayout"`: Exiting children will be "popped" out of the page layout. This allows surrounding elements to move to their new layout immediately.

### [`onExitComplete`](#onexitcomplete)

Fires when all exiting nodes have completed animating out.

## [Troubleshooting](#troubleshooting)

### [Exit animations aren't working](#exit-animations-aren-t-working)

Ensure all **immediate** children get a unique `key` prop that **remains the same for that component every render**.

For instance, providing `index` as a `key` is **bad** because if the items reorder then the `index` will not be matched to the `item`:

<AnimatePresence>
  <Component v-for="(item,index) in items" :key="index" />
</AnimatePresence>

It's preferred to pass something that's unique to that item, for instance an ID:

<AnimatePresence>
  <Componen v-for="(item,index) in items" :key="item.id" />
</AnimatePresence>

Also make sure `AnimatePresence` is **outside** of the code that unmounts the element. If `AnimatePresence` itself unmounts, then it can't control exit animations!

For example, this will **not work**:

<AnimatePresence v-if="isVisible">
  <Component />
</AnimatePresence>

Instead, the conditional should be at the root of `AnimatePresence`:

<AnimatePresence>
  <Component v-if="isVisible" />
</AnimatePresence>

### [Layout animations not working with `mode="sync"`](#layout-animations-not-working-with-mode-sync)

When mixing layout and exit animations, it might be necessary to wrap the group in `[LayoutGroup](https://motion.dev/vue-layout-group)` to ensure that components outside of `AnimatePresence` know when to perform a layout animation.

<LayoutGroup>
  <motion.ul layout>
    <AnimatePresence>
        <motion.li v-for="item in items" layout :key="item.id" />
    </AnimatePresence>
  </motion.ul>
</LayoutGroup>

### [Layout animations not working with `mode="popLayout"`](#layout-animations-not-working-with-mode-poplayout)

When any HTML element has an active `transform` it temporarily becomes the offset parent of its children. This can cause children with `position: "absolute"` not to appear where you expect.`mode="popLayout"` works by using `position: "absolute"`. So to ensure consistent and expected positioning during a layout animation, ensure that the animating parent has a `position` other than `"static"`.

<motion.ul layout :style="{ position: 'relative' }">
  <AnimatePresence mode="popLayout">
      <motion.li v-for="item in items" layout :key="item.id" />
  </AnimatePresence>
</motion.ul>

`AnimatePresence` makes exit animations easy. By wrapping one or more `[motion](https://motion.dev/vue-motion-component)` components with `AnimatePresence`, we gain access to the `exit` animation prop.

<AnimatePresence>
  <motion.div v-if="show" key="modal" :exit="{ opacity: 0 }" />}
</AnimatePresence>

## [Usage](#usage)

### [Import](#import)

import { AnimatePresence } from "motion-v"

### [Exit animations](#exit-animations)

`AnimatePresence` works by detecting when its **direct children** are removed from the Vue tree.

This can be due to a component mounting/remounting:

<AnimatePresence>
  <Modal v-if="show" key="modal" />
</AnimatePresence>

or using `v-show`:

<AnimatePresence>
  <Modal v-show="show" key="modal" />
</AnimatePresence>

Or Its `key` changing:

<AnimatePresence>
  <Slide :key="activeItem.id" />
</AnimatePresence>

Or when children in a list are added/removed:

<AnimatePresence>
    <motion.li 
      v-for="item in items" 
      :key="item.id" 
      :exit="{ opacity: 1 }" layout
    />
</AnimatePresence>

Any `motion` components within the exiting component will fire animations defined on their `exit` props before the component is removed from the DOM.

<template>
  <motion.div :exit="{ opacity: 0 }">
    <img :src="img.src" />
    <motion.p :exit="{ y: 10 }">{{description}}</motion.p>
  </motion.div>
</template>

**Note:**Direct children must each have a unique `key` prop so `AnimatePresence` can track their presence in the tree.

Like `initial` and `animate`, `exit` can be defined either as an object of values, or as a variant label.



<template>
    <motion.div 
      :variants="modalVariants"
      initial="hidden" animate="visible" exit="hidden"
    >
      {{children}}
    </motion.div>
</template>

### [Changing `key`](#changing-key)

Changing a `key` prop makes Vue create an entirely new component. So by changing the `key` of a single child of `AnimatePresence`, we can easily make components like slideshows.

<template>
  <AnimatePresence>
    <motion.img
      :key="image.src"
      :src="image.src"
      :initial="{ x: 300, opacity: 0 }"
      :animate="{ x: 0, opacity: 1 }"
      :exit="{ x: -300, opacity: 0 }"
    />
  </AnimatePresence>
</template>

## [Props](#props)

### [`initial`](#initial)

By passing `:initial="false"`, `AnimatePresence` will disable any initial animations on children that are present when the component is first rendered.

<AnimatePresence :initial="false">
  <Slide :key="activeItem.id" />
</AnimatePresence>

### [`custom`](#custom)

When a component is removed, there's no longer a chance to update its props (because it's no longer in the Vue tree). Therefore we can't update its exit animation with the same render that removed the component.

By passing a value through `AnimatePresence`'s `custom` prop, we can use dynamic variants to change the `exit` animation.



<template> 
  <AnimatePresence :custom="direction">
    <motion.img
      :key="image.src"
      :src="image.src"
      :variants="variants"
      initial="hidden"
      animate="visible"
      exit="hidden"
    />
  </AnimatePresence>
</template>

### [`mode`](#mode)

**Default:**`"sync"`

Decides how `AnimatePresence` handles entering and exiting children.

- `"sync"`: Children animate in/out as soon as they're added/removed.
- `"wait"`: The entering child will wait until the exiting child has animated out. **Note:**Currently only renders a single child at a time.
- `"popLayout"`: Exiting children will be "popped" out of the page layout. This allows surrounding elements to move to their new layout immediately.

### [`onExitComplete`](#onexitcomplete)

Fires when all exiting nodes have completed animating out.

## [Troubleshooting](#troubleshooting)

### [Exit animations aren't working](#exit-animations-aren-t-working)

Ensure all **immediate** children get a unique `key` prop that **remains the same for that component every render**.

For instance, providing `index` as a `key` is **bad** because if the items reorder then the `index` will not be matched to the `item`:

<AnimatePresence>
  <Component v-for="(item,index) in items" :key="index" />
</AnimatePresence>

It's preferred to pass something that's unique to that item, for instance an ID:

<AnimatePresence>
  <Componen v-for="(item,index) in items" :key="item.id" />
</AnimatePresence>

Also make sure `AnimatePresence` is **outside** of the code that unmounts the element. If `AnimatePresence` itself unmounts, then it can't control exit animations!

For example, this will **not work**:

<AnimatePresence v-if="isVisible">
  <Component />
</AnimatePresence>

Instead, the conditional should be at the root of `AnimatePresence`:

<AnimatePresence>
  <Component v-if="isVisible" />
</AnimatePresence>

### [Layout animations not working with `mode="sync"`](#layout-animations-not-working-with-mode-sync)

When mixing layout and exit animations, it might be necessary to wrap the group in `[LayoutGroup](https://motion.dev/vue-layout-group)` to ensure that components outside of `AnimatePresence` know when to perform a layout animation.

<LayoutGroup>
  <motion.ul layout>
    <AnimatePresence>
        <motion.li v-for="item in items" layout :key="item.id" />
    </AnimatePresence>
  </motion.ul>
</LayoutGroup>

### [Layout animations not working with `mode="popLayout"`](#layout-animations-not-working-with-mode-poplayout)

When any HTML element has an active `transform` it temporarily becomes the offset parent of its children. This can cause children with `position: "absolute"` not to appear where you expect.`mode="popLayout"` works by using `position: "absolute"`. So to ensure consistent and expected positioning during a layout animation, ensure that the animating parent has a `position` other than `"static"`.

<motion.ul layout :style="{ position: 'relative' }">
  <AnimatePresence mode="popLayout">
      <motion.li v-for="item in items" layout :key="item.id" />
  </AnimatePresence>
</motion.ul>

Previous

Motion component

Next

AnimateNumber

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