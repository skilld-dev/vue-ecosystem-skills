---
name: vueuse-components-skilld
description: Renderless components and directives from @vueuse/components 15.x (VueUse). Use when writing, converting, or debugging code that imports @vueuse/components, using Use*/On* components or v* directives in Vue 3 templates, or mapping VueUse composables to component or directive usage. Provides props, slot data shapes, emits, directive binding syntax, and version limits.
---

# @vueuse/components 15.0.0

Renderless component and directive wrappers around `@vueuse/core` composables. 46 components, 14 directives, 2 deprecated directive aliases (dist/index.js:1237).

Facts (all citations are paths inside the prepared `@vueuse/components` package):

- Version 15.0.0 (package.json:4); depends on `@vueuse/core` 15.0.0 and `@vueuse/shared` 15.0.0 (package.json:43-44)
- Peer dependency: `vue` `^3.5.0` (package.json:40)
- Node.js `>=22` (package.json:37); Node 20 support was dropped in v15
- ESM-only (`"type": "module"`, package.json:3); no CJS build
- `sideEffects: false`, tree-shakeable (package.json:22); IIFE bundle exposed for CDN via `unpkg`/`jsdelivr` (package.json:30-31)
- Install: `npm i @vueuse/components @vueuse/core` (README.md:10, https://vueuse.org/guide/components)

## How the components work

Two families, decided by what they render (verified in dist/index.js):

1. **Pure renderless**: no DOM of their own, render only the default slot, scoped slot receives the reactive composable return. Example `UseMouse` (dist/index.js:805-809).
2. **Element wrapper**: render one element (`props.as || "div"`) whose ref feeds the composable, slot content becomes children. The element is the composable's target. Example `UseElementBounding` (dist/index.js:340-345).

Element-wrapper components: `OnClickOutside`, `OnLongPress`, `UseDraggable`, `UseElementBounding`, `UseElementOverflow`, `UseElementSize`, `UseElementVisibility`, `UseFullscreen`, `UseImage` (renders `img` when no default slot), `UseMouseInElement`, `UseMousePressed`, `UsePointerLock`, `UseScreenSafeArea`, `UseVirtualList` (own container/wrapper divs).

All others are pure renderless. Full catalog with props, slot data, and emits: [references/components.md](./references/components.md).

## Common tasks

Mouse position (official guide pattern, https://vueuse.org/guide/components):

```vue
<template>
  <UseMouse v-slot="{ x, y }">
    x: {{ x }} y: {{ y }}
  </UseMouse>
</template>
```

Dark mode toggle; note `UseDark` slot data is `{ isDark, toggleDark }` (dist/index.js:173-178):

```vue
<template>
  <UseDark v-slot="{ isDark, toggleDark }">
    <button @click="toggleDark()">Is Dark: {{ isDark }}</button>
  </UseDark>
</template>
```

Outside click, component style. `OnClickOutside` takes an `options` prop and emits `trigger`; the rendered `div` is the target (dist/index.js:5-17):

```vue
<OnClickOutside :options="{ ignore: [ignoreElRef] }" @trigger="close">
  <div>Click outside of me</div>
</OnClickOutside>
```

Directive style, with the `[handler, options]` tuple binding (dist/index.js:26-29):

```vue
<script setup>
import { vOnClickOutside } from '@vueuse/components'
</script>

<template>
  <div v-if="modal" v-on-click-outside="[closeModal, { ignore: [ignoreElRef] }]">
    Hello World
  </div>
</template>
```

Image with loading and error slots (dist/index.js:763-770):

```vue
<UseImage src="https://place.dog/300/200">
  <template #loading>Loading..</template>
  <template #error>Failed</template>
</UseImage>
```

Draggable with persisted position; `storage-key` enables `useStorage` persistence, `storage-type` picks `local` (default) or `session` (dist/index.d.ts:157-168, dist/index.js:286-300):

```vue
<UseDraggable storage-key="panel-pos" :initial-value="{ x: 10, y: 10 }" v-slot="{ x, y, style }">
  <div :style="style">Drag me at {{ x }}, {{ y }}</div>
</UseDraggable>
```

## Rules to apply

- Import components and directives as named exports from `@vueuse/components`. There is no `app.use()` plugin; register globally yourself if needed (`app.component('UseMouse', UseMouse)`).
- In `On*` components, pass configuration through the `options` prop and react through the `@trigger` emit, not through handler props (dist/index.js:15-16, 66-68).
- On element-wrapper components, set `as` to change the rendered element, e.g. `as="section"` (dist/index.js:11). Exception: `UseScreenSafeArea` types declare `as` but its runtime props array omits it, so it always renders a `div` (dist/index.js:1096-1101 vs dist/index.d.ts:548-553).
- `UseIdle` requires the `timeout` prop (dist/index.d.ts:297-299).
- `UseVirtualList` requires `list` and `options` props; `height` defaults to `300px`; it exposes `scrollTo(index)` via template ref (dist/index.d.ts:590-610, dist/index.js:1190-1206).
- `UseObjectUrl` renders its slot only after the object URL exists; slot prop is the URL string (dist/index.js:906-915).
- `UseOffsetPagination` emits `page-change`, `page-size-change`, `page-count-change` with the full pagination state (dist/index.js:918-951).
- `UsePointer` accepts `target="window"` (default) or `target="self"` (dist/index.d.ts:463-465, dist/index.js:976-984).
- Do not use the deprecated exports `VOnClickOutside` and `VOnLongPress`; they alias `vOnClickOutside` / `vOnLongPress` (dist/index.d.ts:17-18, 43-44).
- Directive binding values: a handler function, or a `[handler, options]` tuple; `vElementSize` takes `[handler, initialSize, options]` and `vScrollLock` takes a boolean. Details and modifiers: [references/directives.md](./references/directives.md).

## References

- [references/components.md](./references/components.md) — catalog of all 46 components: props, slot data shapes, emits, rendered element
- [references/directives.md](./references/directives.md) — all 14 directives: binding value forms, modifiers, handler payloads
- [references/migration.md](./references/migration.md) — version-specific changes v13 to v15 with official release URLs

Official documentation: https://vueuse.org/guide/components
