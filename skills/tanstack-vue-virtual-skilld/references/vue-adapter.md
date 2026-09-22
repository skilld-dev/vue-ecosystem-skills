# Vue adapter API

Source: prepared `@tanstack/vue-virtual@3.13.39` `src/index.ts` and `dist/esm/index.d.ts`. Official page: [vue-virtual docs](https://tanstack.com/virtual/latest/docs/framework/vue/vue-virtual).

## Exports

- `useVirtualizer`, `useWindowVirtualizer` (`dist/esm/index.d.ts:5-6`)
- Re-export of everything from `@tanstack/virtual-core` (`src/index.ts:21`): the `Virtualizer` class, `elementScroll`, `windowScroll`, `observeElementRect`, `observeWindowRect`, `observeElementOffset`, `observeWindowOffset`, `defaultRangeExtractor`, and the types `VirtualizerOptions`, `VirtualItem`, `Rect`, `Range`, `PartialKeys`.

## Signatures

```ts
function useVirtualizer<TScrollElement extends Element, TItemElement extends Element>(
  options: MaybeRef<
    PartialKeys<
      VirtualizerOptions<TScrollElement, TItemElement>,
      'observeElementRect' | 'observeElementOffset' | 'scrollToFn'
    >
  >,
): Ref<Virtualizer<TScrollElement, TItemElement>>

function useWindowVirtualizer<TItemElement extends Element>(
  options: MaybeRef<
    PartialKeys<
      VirtualizerOptions<Window, TItemElement>,
      'observeElementRect' | 'observeElementOffset' | 'scrollToFn' | 'getScrollElement'
    >
  >,
): Ref<Virtualizer<Window, TItemElement>>
```

`MaybeRef<T> = T | Ref<T>`; options may be a plain object, a `ref`, or a `computed` (`src/index.ts:23`).

## What each hook pre-fills

`useVirtualizer` injects `observeElementRect`, `observeElementOffset`, and `scrollToFn: elementScroll` (`src/index.ts:83-90`). Your spread wins if you override, but there is no reason to.

`useWindowVirtualizer` additionally injects `getScrollElement: () => (typeof document !== 'undefined' ? window : null)` and `initialOffset: () => window.scrollY` (`src/index.ts:104-114`). Both are SSR-safe; do not pass them.

## Reactivity contract

Both hooks share `useVirtualizerBase` (`src/index.ts:25-70`):

1. `new Virtualizer(unref(options))` runs once at setup (`src/index.ts:31`).
2. `_didMount()` installs core observers; the returned cleanup runs on `onScopeDispose` (`src/index.ts:34,67`). Component unmount tears down ResizeObservers and scroll listeners.
3. `watch(() => unref(options).getScrollElement(), ..., { immediate: true })`: when the scroll element appears (template ref set) or changes, `_willUpdate()` re-attach observers (`src/index.ts:36-46`). A `null` return is legal before mount.
4. `watch(() => unref(options), ..., { immediate: true })`: replaces options via `virtualizer.setOptions` and calls `_willUpdate()` (`src/index.ts:48-65`). Because the watch source is the options reference itself, a plain object never re-triggers. Wrap options in `computed(() => ({ ... }))` when any option depends on reactive data (`count`, `overscan`, `enabled`, `scrollMargin`, ...).
5. The adapter overrides `onChange` to call `triggerRef(state)` on its internal `shallowRef(virtualizer)` before invoking your `onChange` (`src/index.ts:53-56`). That trigger is what makes `computed(() => rowVirtualizer.value.getVirtualItems())` and `computed(() => rowVirtualizer.value.getTotalSize())` update during scroll and after measurements.

## Script vs template access

```ts
const rowVirtualizer = useVirtualizer({ ... })
rowVirtualizer.value.scrollToIndex(20)   // script: .value required
const virtualRows = computed(() => rowVirtualizer.value.getVirtualItems())
```

```html
<!-- template: top-level ref auto-unwraps -->
<div v-for="virtualRow in rowVirtualizer.getVirtualItems()" :key="virtualRow.key" ...>
```

Prefer the `computed` + auto-unwrap forms; they stay correct through the `triggerRef` updates.

## SSR

- `useWindowVirtualizer` guards `document` and `window` (`src/index.ts:106,110-111`), so setup during SSR does not throw.
- For element virtualizers rendered on the server, pass `initialRect` and `initialOffset` so the first render has sizes ([virtualizer docs](https://tanstack.com/virtual/latest/docs/api/virtualizer)).

## Vue 2

The peer range is `^2.7.0 || ^3.0.0` (`package.json:59`). The adapter only uses APIs present in Vue 2.7 (`computed`, `watch`, `shallowRef`, `triggerRef`, `unref`, `onScopeDispose`, `src/index.ts:10-19`).
