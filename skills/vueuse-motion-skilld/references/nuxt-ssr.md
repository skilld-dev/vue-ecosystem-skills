# Nuxt and SSR

## Nuxt module

Add to `nuxt.config` (`dist/nuxt/module.mjs`, `dist/nuxt/module.json`):

```js
export default defineNuxtConfig({
  modules: ['@vueuse/motion/nuxt'],
})
```

The module (`configKey: "motion"`) automatically:

- installs the `MotionPlugin` via a runtime plugin, reading options from `runtimeConfig.public.motion` (`dist/nuxt/module.mjs:12-14`, `dist/nuxt/runtime/templates/motion.js`),
- auto-imports all composables (`addImportsDir`, `dist/nuxt/module.mjs:14`),
- registers the `Motion` and `MotionGroup` components (`dist/nuxt/module.mjs:15-24`),
- transpiles `defu`, `@vueuse/motion`, `@vueuse/shared`, `@vueuse/core` (`dist/nuxt/module.mjs:25-31`).

Custom directives / presets go in module options or the equivalent runtime config:

```js
export default defineNuxtConfig({
  modules: ['@vueuse/motion/nuxt'],
  motion: {
    directives: {
      'pop-bottom': {
        initial: { scale: 0, opacity: 0, y: 100 },
        visible: { scale: 1, opacity: 1, y: 0 },
      },
    },
  },
})
```

Module options are merged into `runtimeConfig.public.motion` with `defu` (`dist/nuxt/module.mjs:12`), so either location works; this also enables runtime-overridable config. Result: global `v-motion-pop-bottom` directive and a usable `<Motion preset="pop-bottom">`.

Source: https://motion.vueuse.org/getting-started/nuxt.html

## SSR behavior

SSR renders only the `initial` variant, as inline styles merged into the element's `style` attribute; all other variants run client-side after hydration.

- Directive: `getSSRProps` merges the directive's own `initial`, then any `:initial` binding (refs are unwrapped), and serializes it via `variantToStyle` (`dist/index.mjs:1089-1099`).
- `<Motion>` / `<MotionGroup>`: inject `initial` as style props on the rendered vnode, including when the tag comes from `:is` (`dist/index.mjs:1662-1667,1683-1685`).
- Both `v-motion="{ initial: {...}, enter: {...} }"` object form and separate `:initial` / `:enter` bindings are SSR-safe (`https://motion.vueuse.org/getting-started/nuxt.html`).

Rendered example:

```html
<!-- initial: { y: 100, opacity: 0 } server-renders as -->
<div style="opacity:0;transform:translate3d(0px,100px,0px);">Hello</div>
```

## Caveats

- Components are the safer choice for SSR and MDC/Markdown content: they attach styles directly to vnodes, while directive SSR support depends on `getSSRProps` resolving bindings (`dist/index.mjs:1089-1099`; https://motion.vueuse.org/features/components.html).
- Visibility, event, and enter variants require a running browser; nothing animates during SSR, so `initial` should encode a sensible pre-animation state.
- In development mode, `<Motion>`/`<MotionGroup>` replay `initial` -> trigger variants on every component update, and warn if a `preset` name is unknown; this replay does not run in production (`dist/index.mjs:1599-1621`).
- Global plugin options (`excludePresets`, custom `directives`) apply in Nuxt through the same runtime config path; there is no separate plugin file to write.
