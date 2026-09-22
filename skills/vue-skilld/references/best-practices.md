# Best practices

Patterns for vue@3.6 with citations to the official documentation.

## Props and composables

- Use reactive props destructure with native default syntax instead of `withDefaults()`. Destructured variables stay reactive; the compiler rewrites accesses to `props.x`. When passing to `watch()` or composables, wrap in a getter: `watch(() => count, ...)`. ([script setup docs](https://vuejs.org/api/sfc-script-setup.html#reactive-props-destructure))
- Accept `MaybeRefOrGetter<T>` in composables and normalize with `toValue()`. Callers can then pass a plain value, a ref, or a getter. ([reactivity utilities](https://vuejs.org/api/reactivity-utilities.html#tovalue))
- Prefer `onWatcherCleanup()` over the `onCleanup` callback parameter; it works from nested helper functions in the same synchronous stack. ([reactivity core](https://vuejs.org/api/reactivity-core.html#onwatchercleanup))
- Use `useTemplateRef('key')` instead of a plain ref whose variable name matches `ref="key"`; it supports dynamic IDs and better type inference. ([composition helpers](https://vuejs.org/api/composition-api-helpers.html#usetemplateref))

## IDs and SSR

- Generate form and accessibility IDs with `useId()`; IDs match between server and client, so they cannot cause hydration mismatches. Do not call it inside `computed()`. ([composition helpers](https://vuejs.org/api/composition-api-helpers.html#useid))
- Defer hydration of below-the-fold async components with a hydration strategy; the strategy helpers are tree-shakable. ([async components](https://vuejs.org/guide/components/async.html#lazy-hydration))

```ts
import { defineAsyncComponent, hydrateOnVisible } from 'vue'

const Chart = defineAsyncComponent({
  loader: () => import('./Chart.vue'),
  hydrate: hydrateOnVisible(),
})
```

## Performance

From the [performance guide](https://vuejs.org/guide/best-practices/performance.html):

- Use `shallowRef()` / `shallowReactive()` for large immutable structures; deep reactivity pays proxy overhead on every property access, shallow variants react only to root replacement.
- Pass computed booleans as props instead of IDs that children compare; a stable prop avoids re-rendering every list item when one item's state changes.
- When a `computed` returns a fresh object each run, return the unchanged `oldValue` when data is equivalent; since 3.4 effects trigger only on reference change.
- Use `v-once` / `v-memo` for truly static or rarely-changing subtrees; profile before adding them.

## Vapor-specific

- Reach for `<script setup vapor>` on performance-sensitive pages or small new apps; keep the rest of an existing app on VDOM and bridge with `vaporInteropPlugin`. Details and constraints in [Vapor Mode](./vapor-mode.md).
- In Vapor, never call `slots.default()` to probe content; it renders as a side effect.
- Vapor custom directives are functions receiving a reactive getter, optionally returning a cleanup function; effects created with `watchEffect` inside them are auto-disposed.

## Style and safety

- Trust the compiler: plain `ref`, `computed`, and reactive props destructure cover everything Reactivity Transform did, without a macro layer.
- Keep components on the latest API (`defineModel`, `useTemplateRef`, `useId`) so upgrades stay mechanical.
- This skill targets a beta; before adopting a Vapor or 3.6-only API in production code, check [the changelog](https://github.com/vuejs/core/blob/minor/CHANGELOG.md) for changes after beta.17.
