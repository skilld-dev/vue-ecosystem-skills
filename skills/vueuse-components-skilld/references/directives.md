# Directive catalog

All 14 directives exported by `@vueuse/components` 15.0.0 plus the 2 deprecated aliases. Citations are paths inside the package.

Import as named exports and use in templates (kebab-case or the imported name):

```vue
<script setup>
import { vOnClickOutside, vOnKeyStroke } from '@vueuse/components'
</script>

<template>
  <div v-on-click-outside="close">...</div>
  <input v-on-key-stroke:enter="submit">
</template>
```

## Binding value forms

Most directives accept either a handler or a `[handler, options]` tuple (each directive below cites its runtime source):

- Function: `v-xyz="handler"`
- Tuple: `v-xyz="[handler, options]"`

All directives except `vOnClickOutside` are built with `createDisposableDirective` (dist/index.js:3), which disposes the underlying composable when the element unmounts. `vOnClickOutside` implements its own `unmounted` cleanup via a WeakMap (dist/index.js:20-38).

## Catalog

### vOnClickOutside (dist/index.js:21-38)
- Value: `handler` or `[handler, options]` (`onClickOutside` options merged with the directive's capture setting)
- Modifier: `.bubble` switches from the default capture phase to bubble phase (`capture = !binding.modifiers.bubble`, dist/index.js:23)
- Handler receives the triggering `PointerEvent`

```vue
<div v-on-click-outside="[close, { ignore: [ignoreElRef], detectIframe: true }]">Modal</div>
```

### vOnKeyStroke (dist/index.js:43-54)
- Arg: key or comma-separated keys, e.g. `v-on-key-stroke:Escape` or `v-on-key-stroke:a,shift` (split on `,`, dist/index.js:44-45)
- Value: `handler` or `[handler, options]` (`onKeyStroke` options); the element is forced as the listener `target` (dist/index.js:50-53)
- Handler receives the `KeyboardEvent`

### vOnLongPress (dist/index.js:72-75)
- Value: `handler` or `[handler, options]` (`onLongPress` options)
- When the value is a plain function, directive modifiers become the long-press modifiers (dist/index.js:73)
- Handler receives the `PointerEvent`

### vElementBounding (dist/index.js:359-381)
- Value: `handler` or `[handler, options]` (`useElementBounding` options)
- Handler receives `{ height, bottom, left, right, top, width, x, y }` on every change

### vElementHover (dist/index.js:384-394)
- Value: `handler` or `[handler, options]` (`useElementHover` options)
- Handler receives a boolean hover state

### vElementOverflow (dist/index.js:615-620)
- Value: `handler` or `[handler, options]` (`observeMutation` bool or `MutationObserverInit`)
- Handler receives the full overflow state `{ isXOverflowed, isYOverflowed, stop, update }`, fired immediately and on every change

### vElementSize (dist/index.js:649-658)
- Value: `handler` or `[handler, initialSize, options]` (note: three-element tuple, dist/index.d.ts:247)
- Handler receives `{ width, height }`, fired immediately

### vElementVisibility (dist/index.js:683-698)
- Value: `handler` or `[handler, options]`
- Without `options.controls`, the handler receives a boolean. With `controls: true`, it receives the full state including `isVisible` (dist/index.d.ts:259-267)

### vInfiniteScroll (dist/index.js:793-796)
- Value: `handler` or `[handler, options]` (`useInfiniteScroll` options)
- Handler receives the unwrapped `useScroll` state

### vIntersectionObserver (dist/index.js:799-802)
- Value: `handler` or `[handler, options]` (`useIntersectionObserver` options, including `rootMargin`, `threshold`)
- Handler receives the standard `IntersectionObserverCallback` arguments

### vMouseInElement (dist/index.js:850-854)
- Value: `handler` or `[handler, options]`
- Handler receives the reactive mouse-in-element state with `stop` omitted (via `reactiveOmit`, dist/index.js:852)

### vResizeObserver (dist/index.js:1074-1077)
- Value: `handler` or `[handler, options]` (`useResizeObserver` options)
- Handler receives the standard `ResizeObserverCallback` arguments

### vScroll (dist/index.js:1105-1132)
- Value: `handler` or `[handler, options]` (`useScroll` options)
- The handler receives the full `useScroll` state on every scroll and every scroll-end, because the directive wraps `onScroll` and `onStop` internally (dist/index.js:1106-1131); user-provided `onScroll`/`onStop` options still run

### vScrollLock (dist/index.js:1135-1146)
- Value: boolean; `true` locks the element's scroll
- The binding is reactive: later updates toggle the lock without recreating it

## Deprecated aliases

- `VOnClickOutside`: alias of `vOnClickOutside`, marked `@deprecated use vOnClickOutside instead` (dist/index.d.ts:17-18)
- `VOnLongPress`: alias of `vOnLongPress`, same deprecation (dist/index.d.ts:43-44)

Use the lowercase `v`-prefixed exports in all new code.
