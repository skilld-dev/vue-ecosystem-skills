Reorder — Vue drag-to-reorder animation | Motion

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

# Reorder

The `Reorder` components can be used to create drag-to-reorder lists, like reorderable tabs or todo items.



<template>  
  <Reorder.Group axis="y" v-model:values="items">
      <Reorder.Item v-for="item in items" :key="item" :value="item">
        {{item}}
      </Reorder.Item>
  </Reorder.Group>
</template>

**Note:** `Reorder` is for simple drag-to-reorder implementations. It's exceptionally lightweight ontop of the base `motion` component but lacks some features like multirow, dragging between columns, or dragging within scrollable containers. For advanced use-cases we recommend using other community drag and drop components.

## [Usage](#usage)

Every reorderable list is wrapped in the `Reorder.Group` component.



<template>
  <Reorder.Group>
    
  </Reorder.Group>
</template>

By default, this is rendered as a `<ul>`, but this can be changed with the `as` prop.

<Reorder.Group as="ol">

`Reorder.Group` must be passed the array of values in your reorderable list via the `values` prop.

Additionally, a `onUpdate:values` event will fire with the latest calculated order. For items to reorder, this must update the `values` state.



<template>
  <Reorder.Group v-model:values="values">
    
  </Reorder.Group>
</template>

To render each reorderable item, use `Reorder.Item`, passing it the value it represents via the `value` prop.



<template>
  <Reorder.Group v-model:values="items">
      <Reorder.Item v-for="item in items" :key="item" :value="item">
        {{ item }}
      </Reorder.Item>
  </Reorder.Group>
</template>

Now, when items are dragged and reordered, `onUpdate:values` will fire with a new order.

### [Layout animations](#layout-animations)

`Reorder.Item` components are already configured to perform layout animations, so if new items are added or removed to the reorderable list, surrounding items will animate to their new position automatically.

### [Exit animations](#exit-animations)

`[AnimatePresence](https://motion.dev/react-animate-presence)` can be used as normal to animate items as they enter/leave the Vue tree.

<AnimatePresence>
    <ReorderItem
      v-for="item in items"
      :key="item"
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      :exit="{ opacity: 0 }"
    />
</AnimatePresence>

### [Drag triggers](#drag-triggers)

By default, all of a `Reorder.Item` will be draggable. `[useDragControls](https://motion.dev/vue-use-drag-controls)` can be used to define a different component to act as a drag trigger.



<template>
  <Reorder.Item
      :value="value"
      :dragListener="false"
      :dragControls="controls"
    >
      <div
        className="reorder-handle"
        @pointerDown="(e) => controls.start(e)"
      />
    </Reorder.Item>
</template>

### [Scrollable lists](#scrollable-lists)

If `Reorder.Item` components are within a scrollable container, that container needs a `layoutScroll` prop so Motion can correctly measure its scroll offset.

<Reorder.Group
  axis="y"
  v-model:values="items"
  layoutScroll
  :style="{ overflowY: 'scroll' }"
>
    <Item v-for="item in items" :key="item" item="item" />
</Reorder.Group>

### [z-index](#z-index)

`Reorder.Item` will automatically set a `z-index` style on the currently dragged item so it appears above the surrounding items.

However, `z-index` only affects items with `position !== "static"`. So to enable this effect ensure the position of the `Reorder.Item` is set to `relative` or `absolute`.

## [API](#api)

### [`Reorder.Group`](#reorder.group)

#### [`as`](#as)

**Default**: `"ul"`

The underlying element for `Reorder.Group` to render as.

<Reorder.Group as="div"></Reorder.Group>

#### [`axis`](#axis)

**Default**: `"y"`

The direction of reorder detection.

**Note:**By default, all `Reorder.Item` components will visibly move only on this axis. To allow visual motion (but **not** reordering) on both axes, pass the `drag` prop to child `Reorder.Item` components.

#### [`values`](#values)

The values array that will be reordered. Each item in this list must match a `value` passed to each `Reorder.Item`.

#### [`onUpdate:values`](#onupdate-values)

A callback that will fire when items are detected to have reordered. The provided `newOrder` should be passed to a `values` state update function.



<template>
  <Reorder.Group v-model:values="items"/>
</template>

### [`Reorder.Item`](#reorder.item)

`Reorder.Item` components accept all `[motion](https://motion.dev/vue-motion-component)` component props in addition to the following:

#### [`as`](#as-1)

**Default:** `"li"`

The element for `Reorder.Item` to render as.

#### [`value`](#value)

When `onUpdate:values` is called, this is the value that will be passed through in the newly ordered array.

The `Reorder` components can be used to create drag-to-reorder lists, like reorderable tabs or todo items.



<template>  
  <Reorder.Group axis="y" v-model:values="items">
      <Reorder.Item v-for="item in items" :key="item" :value="item">
        {{item}}
      </Reorder.Item>
  </Reorder.Group>
</template>

**Note:** `Reorder` is for simple drag-to-reorder implementations. It's exceptionally lightweight ontop of the base `motion` component but lacks some features like multirow, dragging between columns, or dragging within scrollable containers. For advanced use-cases we recommend using other community drag and drop components.

## [Usage](#usage)

Every reorderable list is wrapped in the `Reorder.Group` component.



<template>
  <Reorder.Group>
    
  </Reorder.Group>
</template>

By default, this is rendered as a `<ul>`, but this can be changed with the `as` prop.

<Reorder.Group as="ol">

`Reorder.Group` must be passed the array of values in your reorderable list via the `values` prop.

Additionally, a `onUpdate:values` event will fire with the latest calculated order. For items to reorder, this must update the `values` state.



<template>
  <Reorder.Group v-model:values="values">
    
  </Reorder.Group>
</template>

To render each reorderable item, use `Reorder.Item`, passing it the value it represents via the `value` prop.



<template>
  <Reorder.Group v-model:values="items">
      <Reorder.Item v-for="item in items" :key="item" :value="item">
        {{ item }}
      </Reorder.Item>
  </Reorder.Group>
</template>

Now, when items are dragged and reordered, `onUpdate:values` will fire with a new order.

### [Layout animations](#layout-animations)

`Reorder.Item` components are already configured to perform layout animations, so if new items are added or removed to the reorderable list, surrounding items will animate to their new position automatically.

### [Exit animations](#exit-animations)

`[AnimatePresence](https://motion.dev/react-animate-presence)` can be used as normal to animate items as they enter/leave the Vue tree.

<AnimatePresence>
    <ReorderItem
      v-for="item in items"
      :key="item"
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      :exit="{ opacity: 0 }"
    />
</AnimatePresence>

### [Drag triggers](#drag-triggers)

By default, all of a `Reorder.Item` will be draggable. `[useDragControls](https://motion.dev/vue-use-drag-controls)` can be used to define a different component to act as a drag trigger.



<template>
  <Reorder.Item
      :value="value"
      :dragListener="false"
      :dragControls="controls"
    >
      <div
        className="reorder-handle"
        @pointerDown="(e) => controls.start(e)"
      />
    </Reorder.Item>
</template>

### [Scrollable lists](#scrollable-lists)

If `Reorder.Item` components are within a scrollable container, that container needs a `layoutScroll` prop so Motion can correctly measure its scroll offset.

<Reorder.Group
  axis="y"
  v-model:values="items"
  layoutScroll
  :style="{ overflowY: 'scroll' }"
>
    <Item v-for="item in items" :key="item" item="item" />
</Reorder.Group>

### [z-index](#z-index)

`Reorder.Item` will automatically set a `z-index` style on the currently dragged item so it appears above the surrounding items.

However, `z-index` only affects items with `position !== "static"`. So to enable this effect ensure the position of the `Reorder.Item` is set to `relative` or `absolute`.

## [API](#api)

### [`Reorder.Group`](#reorder.group)

#### [`as`](#as)

**Default**: `"ul"`

The underlying element for `Reorder.Group` to render as.

<Reorder.Group as="div"></Reorder.Group>

#### [`axis`](#axis)

**Default**: `"y"`

The direction of reorder detection.

**Note:**By default, all `Reorder.Item` components will visibly move only on this axis. To allow visual motion (but **not** reordering) on both axes, pass the `drag` prop to child `Reorder.Item` components.

#### [`values`](#values)

The values array that will be reordered. Each item in this list must match a `value` passed to each `Reorder.Item`.

#### [`onUpdate:values`](#onupdate-values)

A callback that will fire when items are detected to have reordered. The provided `newOrder` should be passed to a `values` state update function.



<template>
  <Reorder.Group v-model:values="items"/>
</template>

### [`Reorder.Item`](#reorder.item)

`Reorder.Item` components accept all `[motion](https://motion.dev/vue-motion-component)` component props in addition to the following:

#### [`as`](#as-1)

**Default:** `"li"`

The element for `Reorder.Item` to render as.

#### [`value`](#value)

When `onUpdate:values` is called, this is the value that will be passed through in the newly ordered array.

The `Reorder` components can be used to create drag-to-reorder lists, like reorderable tabs or todo items.



<template>  
  <Reorder.Group axis="y" v-model:values="items">
      <Reorder.Item v-for="item in items" :key="item" :value="item">
        {{item}}
      </Reorder.Item>
  </Reorder.Group>
</template>

**Note:** `Reorder` is for simple drag-to-reorder implementations. It's exceptionally lightweight ontop of the base `motion` component but lacks some features like multirow, dragging between columns, or dragging within scrollable containers. For advanced use-cases we recommend using other community drag and drop components.

## [Usage](#usage)

Every reorderable list is wrapped in the `Reorder.Group` component.



<template>
  <Reorder.Group>
    
  </Reorder.Group>
</template>

By default, this is rendered as a `<ul>`, but this can be changed with the `as` prop.

<Reorder.Group as="ol">

`Reorder.Group` must be passed the array of values in your reorderable list via the `values` prop.

Additionally, a `onUpdate:values` event will fire with the latest calculated order. For items to reorder, this must update the `values` state.



<template>
  <Reorder.Group v-model:values="values">
    
  </Reorder.Group>
</template>

To render each reorderable item, use `Reorder.Item`, passing it the value it represents via the `value` prop.



<template>
  <Reorder.Group v-model:values="items">
      <Reorder.Item v-for="item in items" :key="item" :value="item">
        {{ item }}
      </Reorder.Item>
  </Reorder.Group>
</template>

Now, when items are dragged and reordered, `onUpdate:values` will fire with a new order.

### [Layout animations](#layout-animations)

`Reorder.Item` components are already configured to perform layout animations, so if new items are added or removed to the reorderable list, surrounding items will animate to their new position automatically.

### [Exit animations](#exit-animations)

`[AnimatePresence](https://motion.dev/react-animate-presence)` can be used as normal to animate items as they enter/leave the Vue tree.

<AnimatePresence>
    <ReorderItem
      v-for="item in items"
      :key="item"
      :initial="{ opacity: 0 }"
      :animate="{ opacity: 1 }"
      :exit="{ opacity: 0 }"
    />
</AnimatePresence>

### [Drag triggers](#drag-triggers)

By default, all of a `Reorder.Item` will be draggable. `[useDragControls](https://motion.dev/vue-use-drag-controls)` can be used to define a different component to act as a drag trigger.



<template>
  <Reorder.Item
      :value="value"
      :dragListener="false"
      :dragControls="controls"
    >
      <div
        className="reorder-handle"
        @pointerDown="(e) => controls.start(e)"
      />
    </Reorder.Item>
</template>

### [Scrollable lists](#scrollable-lists)

If `Reorder.Item` components are within a scrollable container, that container needs a `layoutScroll` prop so Motion can correctly measure its scroll offset.

<Reorder.Group
  axis="y"
  v-model:values="items"
  layoutScroll
  :style="{ overflowY: 'scroll' }"
>
    <Item v-for="item in items" :key="item" item="item" />
</Reorder.Group>

### [z-index](#z-index)

`Reorder.Item` will automatically set a `z-index` style on the currently dragged item so it appears above the surrounding items.

However, `z-index` only affects items with `position !== "static"`. So to enable this effect ensure the position of the `Reorder.Item` is set to `relative` or `absolute`.

## [API](#api)

### [`Reorder.Group`](#reorder.group)

#### [`as`](#as)

**Default**: `"ul"`

The underlying element for `Reorder.Group` to render as.

<Reorder.Group as="div"></Reorder.Group>

#### [`axis`](#axis)

**Default**: `"y"`

The direction of reorder detection.

**Note:**By default, all `Reorder.Item` components will visibly move only on this axis. To allow visual motion (but **not** reordering) on both axes, pass the `drag` prop to child `Reorder.Item` components.

#### [`values`](#values)

The values array that will be reordered. Each item in this list must match a `value` passed to each `Reorder.Item`.

#### [`onUpdate:values`](#onupdate-values)

A callback that will fire when items are detected to have reordered. The provided `newOrder` should be passed to a `values` state update function.



<template>
  <Reorder.Group v-model:values="items"/>
</template>

### [`Reorder.Item`](#reorder.item)

`Reorder.Item` components accept all `[motion](https://motion.dev/vue-motion-component)` component props in addition to the following:

#### [`as`](#as-1)

**Default:** `"li"`

The element for `Reorder.Item` to render as.

#### [`value`](#value)

When `onUpdate:values` is called, this is the value that will be passed through in the newly ordered array.

Previous

MotionConfig

Next

Motion values

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