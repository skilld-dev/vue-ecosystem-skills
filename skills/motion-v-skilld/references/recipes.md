# Recipes for motion-v 2.4.4

Small, runnable patterns. Combine with the rules in SKILL.md.

## Enter and exit

```vue
<script setup>
import { ref } from 'vue'
import { motion, AnimatePresence } from 'motion-v'

const visible = ref(true)
</script>

<template>
  <button @click="visible = !visible">Toggle</button>
  <AnimatePresence>
    <motion.div
      v-if="visible"
      :initial="{ opacity: 0, y: 8 }"
      :animate="{ opacity: 1, y: 0 }"
      :exit="{ opacity: 0, y: -8 }"
    >
      Content
    </motion.div>
  </AnimatePresence>
</template>
```

- `mode="wait"` plays exits before enters. `mode="popLayout"` removes exiting nodes from flow.
- `anchorX` sets the popLayout exit side.
- `:initial="false"` on `AnimatePresence` disables enter animation on first render.
- With `KeepAlive`, exit and enter work since 2.4.2. See migration notes.

## Stagger with variants and custom

```vue
<script setup>
import { motion } from 'motion-v'

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { delayChildren: 0.1, staggerChildren: 0.05 },
  },
}
</script>

<template>
  <motion.ul :variants="container" initial="hidden" animate="show">
    <motion.li v-for="i in 5" :key="i" />
  </motion.ul>
</template>
```

For per element delay, use dynamic variants. Do not compute delays in reactive state:

```vue
<script setup lang="ts">
import { motion } from 'motion-v'
const items = ['a', 'b', 'c']
const variants = {
  hidden: { opacity: 0 },
  show: (i: number) => ({
    opacity: 1,
    transition: { delay: i * 0.1 },
  }),
}
</script>

<template>
  <motion.span
    v-for="(item, i) in items"
    :key="item"
    :variants="variants"
    initial="hidden"
    animate="show"
    :custom="i"
  />
</template>
```

The `stagger()` helper is also available from the root entry, useful with `delayChildren`.

## Gestures

```vue
<motion.button
  :whileHover="{ scale: 1.05 }"
  :whilePress="{ scale: 0.95 }"
  @hoverStart="onHover"
/>
```

Animation goes in `while*` props. Logic goes in event props such as `onHoverStart`.

## Drag

```vue
<script setup>
import { ref } from 'vue'
import { motion } from 'motion-v'
const frame = ref(null)
</script>

<template>
  <div ref="frame" class="frame">
    <motion.div
      drag
      :dragConstraints="frame"
      :dragElastic="0.2"
      :whileDrag="{ scale: 1.1 }"
    />
  </div>
</template>
```

Start drag from a different element with `useDragControls`:

```vue
<script setup>
import { motion, useDragControls } from 'motion-v'
const controls = useDragControls()
</script>

<template>
  <div @pointerdown="e => controls.start(e)" class="handle" />
  <motion.div drag="x" :dragListener="false" :dragControls="controls" />
</template>
```

## Scroll linked animation

```vue
<script setup>
import { ref } from 'vue'
import { motion, useScroll, useTransform } from 'motion-v'

const target = ref(null)
const { scrollYProgress } = useScroll({ target, offset: ['start end', 'end start'] })
const opacity = useTransform(scrollYProgress, [0, 0.5, 1], [0, 1, 0])
</script>

<template>
  <section ref="target">
    <motion.div :style="{ opacity }" />
  </section>
</template>
```

`useScroll` options accept element refs (dist/es/value/use-scroll.d.ts:4-7).
Use `ScrollOffset.Enter` style presets for common ranges.

## Motion value springs and templates

```vue
<script setup>
import { motion, useMotionValue, useSpring, useMotionTemplate } from 'motion-v'

const x = useMotionValue(0)
const sx = useSpring(x, { stiffness: 300, damping: 30 })
const shadow = useMotionTemplate`drop-shadow(${sx}px 10px 10px rgba(0,0,0,0.3))`
</script>

<template>
  <motion.div :style="{ x, filter: shadow }" />
</template>
```

## Imperative animation with useAnimate

```vue
<script setup>
import { useAnimate } from 'motion-v'

const [scope, animate] = useAnimate()

async function play() {
  await animate(scope.value, { x: 100 }, { type: 'spring' })
  await animate(scope.value.querySelectorAll('li'), { opacity: 1 }, { delay: 0.1 })
}
</script>

<template>
  <ul ref="scope" @click="play">
    <li v-for="i in 3" :key="i" />
  </ul>
</template>
```

`useAnimate` honors `MotionConfig skipAnimations` since 2.3.0.

## Layout and shared layout

```vue
<script setup>
import { ref } from 'vue'
import { motion } from 'motion-v'
const wide = ref(false)
</script>

<template>
  <motion.div
    layout
    :style="{ width: wide ? '300px' : '100px' }"
    @click="wide = !wide"
  />
</template>
```

Shared layout across different trees uses the same `layoutId`:

```vue
<motion.img v-if="selected" layoutId="avatar" src="large.jpg" />
<motion.img v-else layoutId="avatar" src="thumb.jpg" />
```

Put changing size and position in `:style`. Keep `borderRadius` and `boxShadow` inline so scale correction applies. See SKILL.md rules 3 to 5.

## Reorder list

```vue
<script setup>
import { ref } from 'vue'
import { Reorder } from 'motion-v'

const items = ref(['Item 1', 'Item 2', 'Item 3'])
</script>

<template>
  <Reorder.Group v-model:values="items" axis="y">
    <Reorder.Item v-for="item in items" :key="item" :value="item">
      {{ item }}
    </Reorder.Item>
  </Reorder.Group>
</template>
```

Since 2.4.0, `axis="xy"` reorders in two dimensions.

## Arc motion

```vue
<script setup>
import { motion, arc } from 'motion-v'
</script>

<template>
  <motion.div
    :animate="{ x: 200, y: -100 }"
    :transition="{ path: arc({ rotate: 90 }) }"
  />
</template>
```

`arc()` ships in 2.3.0. The `path` transition key is typed for it (dist/es/types/state.d.ts:33-44).

## v-motion directive

Global registration:

```ts
import { createApp } from 'vue'
import { MotionPlugin } from 'motion-v'

const app = createApp(App)
app.use(MotionPlugin, {
  presets: {
    'fade-in': { initial: { opacity: 0 }, animate: { opacity: 1 } },
  },
})
```

Usage, either style, props win over the binding value:

```vue
<div v-motion :initial="{ opacity: 0 }" :animate="{ opacity: 1 }" />
<div v-motion="{ initial: { opacity: 0, x: -30 }, animate: { opacity: 1, x: 0 } }" />
<div v-fade-in />
```

Local, tree shaken:

```ts
import { domAnimation } from 'motion-v'
const vMotion = createMotionDirective(domAnimation)
```

## LazyMotion

```vue
<script setup>
import { LazyMotion, m } from 'motion-v'
</script>

<template>
  <LazyMotion :features="() => import('motion-v').then(m => m.domMax)" :strict="true">
    <m.div :animate="{ x: 100 }" />
  </LazyMotion>
</template>
```

Load `domAnimation` for variants, gestures, exit. Load `domMax` when you also need drag and layout.

## Nuxt

```ts
export default defineNuxtConfig({
  modules: ['motion-v/nuxt'],
  motionV: {
    components: true,
    directives: true,
  },
})
```

Options: `components`, `utilities`, `prefix`, `directives`, `presets` (dist/nuxt/index.d.mts:8-16).

## SSR

- Components render initial values as inline styles on the server.
- The directive computes styles in `getSSRProps` (dist/es/directive/index.mjs:153-162).
- The package is ESM only. Server runtimes must support ESM imports.
