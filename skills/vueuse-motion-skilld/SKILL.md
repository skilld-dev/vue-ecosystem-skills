---
name: vueuse-motion-skilld
description: Use when writing, reviewing, or debugging code that imports @vueuse/motion (v-motion directive, Motion/MotionGroup components, useMotion, useSpring, presets, Nuxt module). Gives correct v3.x API usage, variants and transition syntax, SSR behavior, and setup for Vue 3 and Nuxt 3.
---

# @vueuse/motion 3.0.3

Vue 3 composables for declarative animation, built on Popmotion (not WAAPI). Three interchangeable surfaces: `v-motion` directive, `<Motion>`/`<MotionGroup>` components, and the `useMotion()` composable.

## Environment limits

- Vue 3 only (`vue >=3.0.0` peer, `package.json:79-81`).
- ESM-only since v3.0.0: no CommonJS build (`"type": "module"`, only `.mjs` exports, `package.json:2,31-35`; https://github.com/vueuse/motion/pull/254). No `require()`; CJS projects must migrate to ESM or dynamic `import()`.
- Depends on `@vueuse/core`/`@vueuse/shared` v13, `popmotion` 11 (`package.json:82-89`).
- Nuxt integration needs `@nuxt/kit` >=3.13 (optional dependency, `package.json:90-92`).
- Animations run on `window`; SSR only renders the `initial` variant as inline styles (see [Nuxt & SSR](./references/nuxt-ssr.md)).

## Setup

Vue app entry (`README.md:32-44`):

```js
import { createApp } from 'vue'
import { MotionPlugin } from '@vueuse/motion'
import App from './App.vue'

createApp(App).use(MotionPlugin).mount('#app')
```

`MotionPlugin` registers the `v-motion` directive, 30 preset directives (`v-motion-fade`, ...), global `Motion`/`MotionGroup` components, and custom directives from options (`dist/index.mjs:1712-1736`).

```js
app.use(MotionPlugin, {
  directives: { 'pop-bottom': { initial: { scale: 0, y: 100 }, visible: { scale: 1, y: 0 } } },
  excludePresets: true, // skip the 30 built-in preset directives
})
```

Nuxt: add `'@vueuse/motion/nuxt'` to `modules`; the plugin, components, and composable auto-imports are installed for you (`dist/nuxt/module.mjs:13-24`). See [Nuxt & SSR](./references/nuxt-ssr.md).

## Common tasks

### Directive (most common)

```vue
<template>
  <div
    v-motion
    :initial="{ opacity: 0, y: 100 }"
    :enter="{ opacity: 1, y: 0 }"
  />
  <!-- Preset: applies the built-in slideVisibleLeft variants -->
  <div v-motion-slide-visible-left />
</template>
```

Variant props: `initial`, `enter`, `leave`, `visible`, `visibleOnce` (kebab `visible-once` also accepted, `dist/index.mjs:1054-1057`), `hovered`, `tapped`, `focused`, plus `:variants` for custom keys. Shorthand `:delay` / `:duration` (milliseconds) apply to the `enter`/`visible`/`visibleOnce` transitions (`dist/index.mjs:1043-1051`).

### Component (better SSR/MDC compatibility)

```vue
<Motion is="p" preset="slideVisibleLeft" :duration="600">Text in Motion!</Motion>
```

`preset` takes the camelCase preset name, including names from plugin `directives` (`dist/index.mjs:1551-1562`). `<MotionGroup>` applies one config to all children, renderless unless given `:is`.

### Composable (programmatic control)

```vue
<script setup lang="ts">
import { ref } from 'vue'
import { useMotion } from '@vueuse/motion'

const target = ref<HTMLElement>()
const { variant, apply, stop } = useMotion(target, {
  initial: { opacity: 0, y: 100 },
  enter: { opacity: 1, y: 0 },
  custom2: { scale: 1.2 },
})
// switch variant (triggers transition): variant.value = 'custom2'
// temporary animation, then revert: await apply({ scale: 2 }); await apply('enter')
</script>
```

Instance members: `target`, `variant`, `variants`, `state`, `motionProperties`, `apply`, `set`, `stop`, `leave`, `isAnimating` (`dist/index.d.mts:535-576`). Full surface: [API reference](./references/api.md).

### Access a template motion from script

Give the directive a string value, then read it from `useMotions()`:

```vue
<div v-motion="'hero'" :initial="{ opacity: 0 }" :enter="{ opacity: 1 }" />
```

```ts
const motions = useMotions()
const play = () => { motions.hero?.variant.value = 'custom' }
```

## Rules that prevent bugs

- **Durations, delays, and `repeatDelay` are milliseconds** (`delay: 1000` = 1s). The JSDoc in `dist/index.d.mts` says "in seconds" (copied from Framer Motion types) but values pass straight to Popmotion in ms; official docs and runtime defaults (300/800) are ms (`dist/index.mjs:266-281,431-441`; https://motion.vueuse.org/features/transition-properties.html).
- **Always declare `initial` with every key you animate later**, so elements start from a known state and `leave`/`visible` reversal has a base to return to (https://motion.vueuse.org/features/variants.html).
- **`visible` re-applies `initial` when the element leaves the viewport; `visibleOnce` fires once** (`dist/index.mjs:696-707`).
- **Do not destructure `useMotions()` at setup top level.** Instances register after setup runs; keep the object and index it lazily (`motions.hero?.apply('x')`). Registration is global and keyed by the string value passed to `v-motion` (`dist/index.mjs:9,1065`; https://github.com/vueuse/motion/issues/109).
- **`apply('unknown-key')` throws** `The variant unknown-key does not exist.` Use object form `apply({ ... })` for one-off states (`dist/index.mjs:534-537`).
- **`leave(done)` expects a `leave` variant, falling back to `initial`**; map it onto `<transition @leave="(el, done) => leave(done)">` (`dist/index.mjs:568-582`).
- **Default transitions are picked per property**: springs for `x`/`y`/`z`/`rotate*`/`scale*`, 300ms linear tween for `opacity`/`color`/`backgroundColor`, 800ms keyframes for array targets (`dist/index.mjs:266-290,443-446`). Override via the variant's `transition` (https://motion.vueuse.org/features/transition-properties.html).
- **Event variants (`hovered`/`tapped`/`focused`) layer over the current variant** in priority order hovered < focused < tapped; listeners are only registered for declared variants (`dist/index.mjs:597-657`; https://motion.vueuse.org/features/variants.html).
- **`v-motion` preset directives use slugged names**: `v-motion-fade-visible-once`, `v-motion-roll-left`, `v-motion-slide-top`, etc. (camelCase key -> `slugify`, `dist/index.mjs:1459-1464,1718`). All 30 presets listed in [Variants & transitions](./references/variants-transitions.md).

## When to choose which surface

- Template-only reveal animations: directive, or a preset directive.
- SSR-heavy or Markdown-rendered content (MDC): `<Motion>`/`<MotionGroup>`; they inject `initial` styles more reliably than the directive (`dist/index.mjs:1662-1667`; https://motion.vueuse.org/features/components.html).
- Gestures, sequencing, or values driven outside templates: `useMotion()`, or `useSpring()` + `useMotionProperties()` for raw Popmotion-level springs without the variant system (`dist/index.mjs:1747-1772`).
- Respect user preference: `const reduced = useReducedMotion()` and skip or shorten animations when true (`dist/index.mjs:1774-1777`).

## References

- [API reference](./references/api.md): every export, composable signatures, `MotionInstance`/`SpringControls` members, low-level composables.
- [Variants & transitions](./references/variants-transitions.md): variant semantics, animatable motion properties, transition options, presets list.
- [Nuxt & SSR](./references/nuxt-ssr.md): module setup, runtime config directives, SSR behavior and caveats.
- [Migration & versions](./references/migration.md): v2 -> v3 changes, nightly channel, package facts.
