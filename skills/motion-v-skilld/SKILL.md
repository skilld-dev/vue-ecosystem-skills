---
name: motion-v-skilld
description: "ALWAYS use when writing code importing \"motion-v\". Consult for debugging, best practices, or modifying motion-v, motion v, motion-vue, motion vue."
metadata:
  version: 2.2.1
  generated_at: 2026-04-12
  references_synced_at: 2026-04-12
---

# motiondivision/motion-vue `motion-v@2.2.1`
**Tags:** latest: 2.2.1

**References:** [Docs](./references/docs/_INDEX.md)
## API Changes

This section documents version-specific API changes — prioritize recent major/minor releases.

- BREAKING: `focus`, `hover`, `press`, `inView` shorthand props — removed in v2.0.0-beta.1. Use `whileFocus`, `whileHover`, `whilePress`, and `whileInView` for animations, and full event handlers (e.g. `@hoverStart`, `@pressStart`) for logic [source](./references/releases/v2.0.0-beta.1.md)

- NEW: `v-motion` directive — new in v2.0.0-beta.1, enables declarative animations on any element without requiring a `<motion>` component wrapper [source](./references/releases/v2.0.0-beta.1.md)

- BREAKING: ESM-only — v2.0.0-beta.1 dropped CommonJS support. The package now only ships ESM (`.mjs`) exports [source](./references/releases/v2.0.0-beta.1.md)

- NEW: `MotionPlugin` — new in v2.0.0-beta.1, a Vue plugin for global `v-motion` and custom preset directive registration

- NEW: `createPresetDirective()` — new in v2.0.0-beta.1, allows creating reusable animation directives with baked-in motion options

- BREAKING: `AnimatePresence` lazy discovery — v2.0.0-beta.1 refactored to use `data-ap` attribute for lazy discovery instead of eager registration [source](./references/releases/v2.0.0-beta.1.md)

- DEPRECATED: `staggerChildren` and `staggerDirection` — deprecated in v1.4.0 in favor of using the `stagger()` utility within the `transition` prop [source](./references/releases/v1.4.0.md)

- NEW: `stagger()` utility — correctly handles staggering for newly-entering siblings alongside existing ones since v1.7.0 [source](./references/releases/v1.7.0.md)

- NEW: `useTransform` output maps — supports providing multiple output value maps for complex coordinate transformations since v1.9.0 [source](./references/releases/v1.9.0.md)

- NEW: `Reorder` auto-scrolling — supports automatic parent container scrolling when a `Reorder.Item` is dragged to the edges since v1.8.0 [source](./references/releases/v1.8.0.md)

- NEW: `useScroll` VueInstance support — `container` and `target` options now accept `VueInstance` (ref to component) since v1.6.0 [source](./references/releases/v1.6.0.md)

- NEW: `useInView` `root` option — now accepts `MaybeRef` for dynamic root element assignment since v1.6.0 [source](./references/releases/v1.6.0.md)

- NEW: `AnimatePresence` direct children — supports multiple direct `motion` components as children since v1.10.0 [source](./references/releases/v1.10.0.md)

- NEW: `delayInMs` — exported as a standalone utility function for time-based animation delays since v1.6.0 [source](./references/releases/v1.6.0.md)

**Also changed:** `useTransform` reactive update fix (v1.2.1) · `sequence` at relative start (v1.3.0) · `AnimatePresence` custom prop fix (v1.3.0) · `motionGlobalConfig` exported (v2.0.0-beta.1) · `FeatureBundle` tree-shaking architecture (v2.0.0-beta.1)

## Best Practices

- Use `LazyMotion` + `m` component instead of `motion` to reduce the initial bundle from ~34kb to ~6kb — load `domAnimation` (+18kb) for variants/exit/gestures or `domMax` (+28kb) when you also need drag and layout animations. Add `:strict="true"` to catch accidental `motion` imports inside `LazyMotion` at dev time [source](./references/docs/docs/vue-lazymotion.md#usage)

- Render live motion value output with `<RowValue :value="motionValue" />` rather than syncing to Vue state — `RowValue` writes to `innerHTML` directly and bypasses Vue's reactivity cycle, keeping fast-changing values off the render path [source](./references/docs/docs/vue-animation.md#animate-content)

- Set `reducedMotion="user"` on `MotionConfig` at the app root — the default is `"never"`, meaning transform and layout animations run regardless of the OS accessibility setting unless you explicitly opt in [source](./references/docs/docs/vue-motion-config.md#reducedmotion)

- For layout animations, apply changing CSS to `:style` (not `:animate`) and let the `layout` prop handle the transition — if the value is placed in `:animate`, Motion's FLIP measurement will conflict with it [source](./references/docs/docs/vue-layout-animations.md#usage)

- Set `borderRadius` and `boxShadow` via `:style` (not CSS classes) on `layout`-animated elements — Motion auto-corrects scale distortion on these properties only when they are set as inline style motion values [source](./references/docs/docs/vue-layout-animations.md#scale-correction)

- Add `layoutScroll` to scrollable container ancestors and `layoutRoot` to fixed-position ancestors of layout-animated elements — without these props, Motion measures child positions incorrectly when scroll offset or viewport offset is non-zero [source](./references/docs/docs/vue-layout-animations.md#animating-within-scrollable-element)

- Never place `v-if` on `AnimatePresence` itself — if it unmounts, it cannot intercept the exit of its children. The conditional must be on the direct child:

```vue

<AnimatePresence v-if="isVisible"><Component /></AnimatePresence>


<AnimatePresence><Component v-if="isVisible" /></AnimatePresence>
```

[source](./references/docs/docs/vue-animate-presence.md#exit-animations-aren-t-working)

- Use dynamic variants with the `custom` prop for per-element stagger rather than computing delay in reactive Vue state — pass `:custom="index"` to each `motion` component and resolve the delay inside the variant function, keeping stagger logic declarative and allocation-free [source](./references/docs/docs/vue-animation.md#dynamic-variants)

- Prefer `useMotionValue` over CSS variable animation for values used across many children — animating a CSS variable always triggers paint on every frame, while a `MotionValue` passed to `:style` runs through Motion's optimised DOM renderer without touching the Vue render cycle [source](./references/docs/docs/vue-animation.md#animating-css-variables)

- Use the `v-motion` directive (new in v2.0.0-beta.1) to add animation to any native HTML or SVG element without a wrapper `<motion>` component — register globally via `app.use(MotionPlugin)` or per-component via `createMotionDirective`. Register reusable animation presets via the `presets` option to create project-wide shorthand directives like `v-fade-in` [source](./references/docs/docs/vue-directive.md#presets)
