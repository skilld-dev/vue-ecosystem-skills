---
name: floating-ui-vue-skilld
description: "Floating UI for Vue (@floating-ui/vue@2.0.1). ALWAYS use when writing code importing \"@floating-ui/vue\" or using useFloating, arrow, floatingStyles, or autoUpdate. Consult for middleware setup, anchoring, virtual elements, and v1 to v2 migration. Vue 3.3+ only."
---

# @floating-ui/vue 2.0.1

Vue 3 composable for anchor positioning. `useFloating()` computes `x`/`y` coordinates that place a floating element (tooltip, popover, menu) next to a reference element.

## Version limits

- Vue `>=3.3.0` only (peer dependency, `package.json:58`). v2.0.0 dropped the `vue-demi` layer, ending Vue 2 and Vue <3.3 support.
- Vue 2 or Vue <3.3 projects must stay on `npm install @floating-ui/vue@1` (https://floating-ui.com/docs/vue).
- Runtime dependencies: `@floating-ui/dom@^1.8.0`, `@floating-ui/utils@^0.2.12` (`package.json:46-49`).
- TypeScript with `exactOptionalPropertyTypes`: supported since v2.0.1 (optional properties are typed `T | undefined`, `dist/floating-ui.vue.d.ts:198-224`).

## Quick start

```vue
<script setup>
import {ref} from 'vue';
import {useFloating, offset, flip, shift, autoUpdate} from '@floating-ui/vue';

const reference = ref(null);
const floating = ref(null);
const open = ref(false);

const {floatingStyles, isPositioned} = useFloating(reference, floating, {
  open,
  middleware: [offset(10), flip(), shift()],
  whileElementsMounted: autoUpdate,
});
</script>

<template>
  <button ref="reference" @click="open = !open">Button</button>
  <div v-if="open" ref="floating" :style="floatingStyles">Tooltip</div>
</template>
```

Default placement is `bottom`; positioning uses `transform` by default (https://floating-ui.com/docs/vue).

## API changes since 1.x

- BREAKING (2.0.0): `vue-demi` removed. Vue 2 and Vue <3.3 no longer supported. No other breaking API changes; `useFloating`, `arrow`, and all re-exports keep their 1.1.x signatures (https://github.com/floating-ui/floating-ui/releases/tag/@floating-ui/vue@2.0.0).
- FIX (2.0.1): optional `useFloating` options accept explicit `undefined` under `exactOptionalPropertyTypes` (https://github.com/floating-ui/floating-ui/releases/tag/@floating-ui/vue@2.0.1).
- Unchanged behaviors carried from 1.x: `x`/`y` default to `0` (not `null`); `floatingStyles` returns ready-to-bind positioning styles; options accept refs and getters (`MaybeReadonlyRefOrGetter`) since 1.1.0 (verified in `dist/floating-ui.vue.d.ts:193-225`, `dist/floating-ui.vue.mjs:83-84`).

## Best practices

- Pass `whileElementsMounted: autoUpdate` so the floating element stays anchored during scroll, resize, and layout changes (`dist/floating-ui.vue.mjs:146-156`; https://floating-ui.com/docs/vue).
- When wrapping `autoUpdate` to pass options, always return the cleanup function (`dist/floating-ui.vue.mjs:140-145`):
```ts
useFloating(reference, floating, {
  whileElementsMounted(...args) {
    return autoUpdate(...args, {animationFrame: true});
  },
});
```
- Use `v-if` for the floating element when using `whileElementsMounted`. With `v-show`, skip `whileElementsMounted` and manage `autoUpdate` manually, or listeners leak on hidden elements (https://floating-ui.com/docs/vue).
- Pass an `open` ref and gate side effects on `isPositioned`; positioning resolves in a microtask, so the element sits at (0, 0) until then. `isPositioned` stays `false` while `open` is `false` (`dist/floating-ui.vue.mjs:137`, `dist/floating-ui.vue.mjs:157-161`):
```ts
const {isPositioned} = useFloating(reference, floating, {open});
watch(isPositioned, (positioned) => {
  if (positioned) inputRef.value?.focus();
});
```
- Pass refs or getters (`() => props.placement`) to `open`, `placement`, `strategy`, `middleware`, `transform` options for reactivity; they are watched with `flush: 'sync'` (`dist/floating-ui.vue.mjs:162-164`).
- Pass component template refs directly. Components are unwrapped via `$el`; a component that renders a comment node resolves to `null` and positioning safely no-ops (`dist/floating-ui.vue.mjs:6-15`).
- Keep the default `transform: true` and animate an inner wrapper element if you need CSS transform animations; the outer positioned node keeps `translate()` positioning (https://floating-ui.com/docs/vue).
- Use `arrow({element: arrowRef})` with a template ref. It no-ops (returns `{}`) until the arrow element mounts; read `middlewareData.arrow?.x/.y` for placement (`dist/floating-ui.vue.mjs:27-34`).

## Common tasks

- Arrow positioning example and full option defaults: [API reference](./references/api.md).
- Upgrading from 1.x or pinning for Vue 2: [Migration guide](./references/migration.md).

## Package exports

`useFloating`, `arrow`, plus re-exports from `@floating-ui/dom`: `autoPlacement`, `autoUpdate`, `computePosition`, `detectOverflow`, `flip`, `getOverflowAncestors`, `hide`, `inline`, `limitShift`, `offset`, `platform`, `shift`, `size` (`dist/floating-ui.vue.mjs:2`). Import middleware from `@floating-ui/vue`, not `@floating-ui/dom`, to keep the Vue-aware `arrow` behavior.
