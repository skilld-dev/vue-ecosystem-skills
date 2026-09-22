# Vapor Mode (3.6, experimental)

Vapor Mode is a new compilation mode for Vue SFCs that skips the Virtual DOM, reducing baseline bundle size and update overhead. It is opt-in, feature-complete as of the RC phase, and targets Solid/Svelte-5-level benchmark performance ([release notes](https://github.com/vuejs/core/releases/tag/v3.6.0-rc.1), [CHANGELOG on `minor`](https://github.com/vuejs/core/blob/minor/CHANGELOG.md)).

## Opting in

One SFC at a time, with `<script setup>`:

```vue
<script setup vapor>
// Composition API only
</script>

<template>
  <button @click="count++">{{ count }}</button>
</template>
```

Template-only SFCs also compile as Vapor. In this beta line the officially documented marker is `<script setup vapor>`. Later, v3.6.0-rc.1 added `<script vapor>` as shorthand and a `<template vapor>` marker for the whole SFC ([rc.1 notes](https://github.com/vuejs/core/releases/tag/v3.6.0-rc.1)); do not rely on them at beta.17.

## Creating an app

Pure Vapor apps skip the VDOM runtime entirely:

```ts
import { createVaporApp } from 'vue'
import App from './App.vue'

createVaporApp(App).mount('#app')
```

For SSR: `createVaporSSRApp`. For components authored with render functions or JSX (always VDOM), interop is required.

## Mixing with VDOM

Install `vaporInteropPlugin` in a `createApp()` instance to allow Vapor components inside a VDOM tree:

```ts
import { createApp, vaporInteropPlugin } from 'vue'

createApp(App).use(vaporInteropPlugin).mount('#app')
```

Rules of thumb from the release notes:

- Props, events, and slots work across the boundary; edge cases remain (VDOM component libraries in Vapor trees are a rough edge).
- Keep distinct regions of the app in one mode; avoid deep mixed nesting.
- A Vapor app can also install the plugin to host VDOM components, but that pulls the VDOM runtime back into the bundle.

## What does not work in Vapor components

- Options API (including `data`, `methods`, `computed` options).
- `app.config.globalProperties`.
- `getCurrentInstance()` returns `null`.
- `@vue:xxx` per-element lifecycle events.
- `v-memo`.
- Template refs do not expose `$el`, `$props`, `$attrs`, `$slots`, `$refs`.

## Custom directives use a different interface

Vapor directives are functions, not hook objects:

```ts
type VaporDirective = (
  node: Element | VaporComponentInstance,
  value?: () => any,      // reactive getter for the binding value
  argument?: string,
  modifiers?: DirectiveModifiers,
) => (() => void) | void  // may return a cleanup function
```

Use `watchEffect()` inside for reactive behavior; effects are disposed on unmount:

```ts
const highlight = (el, source) => {
  watchEffect(() => {
    el.textContent = source()
  })
  return () => console.log('cleanup')
}
```

## Event delegation and stopPropagation

At beta.17, Vapor delegates supported static events (for example `click`) to `document`; a single listener walks the event path. If any ancestor calls `stopPropagation()`, delegated handlers never run. These forms always attach directly and are unaffected:

```vue
<button @[event]="onClick" />
<button v-bind="{ onClick }" />
<button v-on="{ click: onClick }" />
```

Disable delegation for a build with `compilerOptions.eventDelegation` (added in beta.15, [#14924](https://github.com/vuejs/core/pull/14924)). Forward-looking: rc.2 inverted the default; listeners now attach directly unless the Vapor-only `.delegate` modifier is used, and the compiler option was removed ([rc.2 notes](https://github.com/vuejs/core/releases/tag/v3.6.0-rc.2)).

## slots.default() is not a safe dry run

Calling a slot in Vapor executes its rendering logic: it creates blocks and DOM nodes, registers effects, and claims SSR DOM during hydration. Never inspect a slot's output to decide what to render:

```vue
<script setup vapor>
// wrong: renders the slot as a side effect
const slots = useSlots()
const showFallback = !slots.default?.()
</script>
```

Let the template own slot rendering (`<slot />`) and provide fallback content there.

## Behavior consistency

Vapor aims to match VDOM behavior for the supported API subset, but the release notes state minor inconsistencies may exist in edge cases and are not treated as breaking changes.
