---
name: motion-v-skilld
description: ALWAYS load when writing or debugging code that imports "motion-v" (Motion for Vue, motion-vue). Covers the motion component, AnimatePresence, variants, gestures, layout, scroll, motion values, the v-motion directive, and the Nuxt module for version 2.4.4. Provides API facts, recipes, best practices, and migration notes.
---

# motion-v (Motion for Vue) 2.4.4

Motion for Vue is the Vue port of Motion (formerly Framer Motion).
It animates DOM and SVG through props, motion values, and a hybrid engine.

Facts, all verified from the prepared source:

- Package: `motion-v` 2.4.4, MIT, ESM only (package.json:4, package.json:20-33).
- Peer deps: `vue >= 3.0.0`, `@vueuse/core >= 10.0.0` (package.json:53-56).
- Engine deps: `framer-motion`, `motion-dom`, `motion-utils`, all `^13.3.0` (package.json:57-62).
- Entry points: `motion-v`, `motion-v/nuxt`, `motion-v/resolver` (package.json:20-33).
- The root entry re-exports all of `framer-motion/dom` (dist/es/index.d.ts:1). So `animate`, `stagger`, `arc`, easing functions, and more come from the Motion engine.
- Repo and docs: https://github.com/motiondivision/motion-vue, https://motion.dev/docs/vue

## Quick start

```
npm install motion-v
```

```vue
<script setup>
import { motion } from 'motion-v'
</script>

<template>
  <motion.div :initial="{ opacity: 0 }" :animate="{ opacity: 1, x: 100 }" />
</template>
```

`motion` is a namespace of typed components for every HTML and SVG tag
(dist/es/components/motion/index.d.ts:3-182). `motion.div`, `motion.svg`, `motion.path` and so on.

## Core model

- Set `initial`, `animate`, `exit`, `whileHover`, `whilePress`, `whileInView`, `whileFocus`, `whileDrag` to values or variant labels.
- When `animate` values change, the element animates to them.
- `transition` configures timing, spring, delay, stagger.
- `variants` plus `custom` support dynamic, per element targets.
- Animatable values include independent transforms (`x`, `y`, `scale`, `rotate`, `skewX`), colors, and CSS variables (dist/es/types/state.d.ts:45-47).
- In templates, bind motion props with `:` prefix. They are props, not attributes.

Full prop and hook listing: [references/api-surface.md](./references/api-surface.md)

## Hard rules

These rules prevent the most common bugs. Each cites its source.

1. Use `m` plus `LazyMotion` instead of `motion` when bundle size matters.
   `motion` ships all features, about 34 kb. `m` starts near 6 kb.
   Load `domAnimation` for variants, gestures, exit. Load `domMax` for drag and layout.
   Set `strict` to catch stray `motion` usage in dev.
   https://motion.dev/docs/vue-lazymotion, dist/es/components/lazy-motion/index.d.ts:4-13

2. Never put `v-if` on `AnimatePresence` itself. If it unmounts, it cannot intercept child exits.
   Put the condition on the direct child instead:

   ```vue
   <AnimatePresence>
     <motion.div v-if="isVisible" :exit="{ opacity: 0 }" />
   </AnimatePresence>
   ```

   https://motion.dev/docs/vue-animate-presence

3. For layout animations, apply changing CSS to `:style`, never to `:animate`.
   The `layout` prop animates the measured change. Values in `:animate` fight the FLIP measurement.
   https://motion.dev/docs/vue-layout-animations

4. Set `borderRadius` and `boxShadow` as inline styles on `layout` elements.
   Motion corrects scale distortion for these two only when they are motion values in `:style`.
   https://motion.dev/docs/vue-layout-animations#scale-correction

5. Add `layoutScroll` on scrollable ancestors and `layoutRoot` on fixed position ancestors.
   Without them, layout measurement is wrong when scroll or viewport offset is non zero.
   dist/es/components/motion/props.d.ts:71-78

6. Set `reducedMotion="user"` on a root `MotionConfig`.
   The default is `"never"`, so animations ignore the OS accessibility setting unless you opt in.
   dist/es/components/motion-config/types.d.ts:5-20

7. Use dynamic variants with `custom` for stagger, not computed delays in reactive state.
   Pass `:custom="index"` and resolve `delay` inside the variant function.
   https://motion.dev/docs/vue-animation

8. Render live motion values with `<RowValue :value="mv" />` in demos and readouts.
   It writes `innerHTML` directly and keeps fast values off the Vue render path.
   dist/es/components/RowValue.d.ts:1-15

9. Use `v-motion` for plain elements when a wrapper component does not fit.
   Register it globally with `app.use(MotionPlugin)`, or create presets with `createPresetDirective`.
   The directive supports SSR through `getSSRProps` and defaults to `domMax` features.
   dist/es/directive/index.mjs:153-172

10. Gesture shorthand props `focus`, `hover`, `press`, `inView` were removed in v2.0.0.
    Use `whileFocus`, `whileHover`, `whilePress`, `whileInView` for animation, and event props like `onHoverStart` for logic.
    See [references/migration.md](./references/migration.md)

## Common tasks

Enter and exit, stagger, drag, scroll linked, imperative `useAnimate`, shared layout, Reorder lists, directive usage, LazyMotion, and Nuxt setup, each with a runnable snippet: [references/recipes.md](./references/recipes.md)

## Changes since the 2.2.1 baseline

- 2.3.0: `arc()` motion along an arc, usable as `transition: { path: arc(...) }`. `useAnimate` now respects `MotionConfig skipAnimations`.
- 2.4.0: multidimensional Reorder, `axis="xy"` on `Reorder.Group`.
- 2.4.2: exit and enter animations restored for `KeepAlive` cached components.
- 2.4.4: Nuxt module no longer transpires `motion-v` in builds.

Details and links: [references/migration.md](./references/migration.md)

## Version specific notes

- SVG positions use `attrX`, `attrY`, `attrScale` instead of `x`, `y`, `scale` (dist/es/types/state.d.ts:15-20).
- `useSpring` accepts a value or a `MotionValue` source and returns the matching type (dist/es/value/use-spring.d.ts:6-7).
- `useTransform` maps ranges and also returns a named map of outputs in one call (dist/es/value/use-transform.d.ts:54-97).
- `AnimatePresence` supports `mode` `sync`, `wait`, `popLayout`, plus `anchorX` for popLayout exit direction (dist/es/components/animate-presence/types.d.ts:1-8).
- Directive and components share one resolver, so `v-motion` inherits variant, presence, and config context (dist/es/utils/resolve-motion-props.d.ts:11-15).
