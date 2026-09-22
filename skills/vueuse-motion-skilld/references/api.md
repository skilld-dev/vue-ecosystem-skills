# API reference

All exports from `@vueuse/motion` 3.0.3 (`dist/index.mjs:1779`, `dist/index.d.mts:1036`). Import path is the package root; Nuxt entry is `@vueuse/motion/nuxt`.

## useMotion

```ts
useMotion<T extends string, V extends MotionVariants<T>>(
  target: MaybeRef<PermissiveTarget>,
  variants?: MaybeRef<V>,
  options?: UseMotionOptions,
): MotionInstance<T, V>
```

`target` accepts an element, `ref`, template ref, or component instance (`VueInstance`). Passing a ref lets the instance re-bind when the element changes (`dist/index.d.mts:983`, `dist/index.mjs:1010-1024`).

`UseMotionOptions` toggles features, all default `true` in the composable (`dist/index.mjs:711-716`):

- `syncVariants`: apply variant whenever `variant` ref changes.
- `lifeCycleHooks`: run `initial` set + `enter` on target mount.
- `visibilityHooks`: IntersectionObserver for `visible`/`visibleOnce`.
- `eventListeners`: hovered/tapped/focused listeners.

The directive path runs with `visibilityHooks: false` at created and registers visibility on mounted (`dist/index.mjs:1073-1085`).

`MotionInstance` = target + `variant: Ref<keyof V>` + `variants` + `state: ComputedRef<Variant>` + `motionProperties` + these controls (`dist/index.d.mts:535-576`, `dist/index.mjs:521-590`):

- `apply(variant | key): Promise<void[]>`: animate to a variant; does not change `variant`. Resolves after every property transition finishes, then calls `variant.transition.onComplete`. Throws on unknown string key.
- `set(variant | key): void`: jump to values without transition (`immediate` push).
- `stop(keys?)`: stop all transitions, or one key / array of keys.
- `leave(done)`: apply `leave` variant (fallback `initial`), then call `done()`.
- `isAnimating: Ref<boolean>`.

Variant switching without `apply`: assign `instance.variant.value = 'key'`; `syncVariants` applies it (`dist/index.mjs:680-691`).

## useSpring

```ts
useSpring(values: Partial<PermissiveMotionProperties>, spring?: UseSpringOptions): SpringControls
```

`values` is usually the `motionProperties` object from `useMotionProperties`; springing mutates it, and binding writes the styles. Options are Popmotion spring options (`stiffness`, `damping`, `mass`, or `duration` + `bounce`) plus `target` to bind an element (`dist/index.d.mts:1024-1027`, `dist/index.mjs:1747-1772`).

`SpringControls`: `set(properties)` animates values with the configured spring; `stop(key?)`; `values` (`dist/index.d.mts:577-596`).

```ts
const box = ref<HTMLElement>()
const { motionProperties } = useMotionProperties(box, { x: 0, y: 0 })
const { set, stop } = useSpring(motionProperties, { duration: 1000, bounce: 0 })
set({ x: 200, y: 50 })
```

Source: https://motion.vueuse.org/api/use-spring.html

## useMotions

Returns the app-global registry of directive-created instances, keyed by the string value given to `v-motion` (`dist/index.mjs:9,1743-1745`). Access lazily; keys appear after the element mounts. Equivalent access in options API: `this.$motions` (`dist/index.d.mts:598-602`).

## Low-level composables

Build custom motion systems; `useMotion` is assembled from these (`dist/index.mjs:1010-1024`):

- `useMotionProperties(target, defaultValues?)`: returns `motionProperties`, `style`, `transform`; reads existing element styles/transforms on bind (`dist/index.mjs:968-994`).
- `useMotionVariants(variants?)`: `variant` ref + `state` computed of the active variant (`dist/index.mjs:996-1008`).
- `useMotionControls(motionProperties, variants?, transitions?)`: `apply`, `set`, `stop`, `leave`, `isAnimating` (`dist/index.mjs:521-590`).
- `useMotionTransitions()`: `push(key, value, target, transition, onComplete?)`, `stop(keys?)`, `motionValues`; `transition.immediate` skips animation (`dist/index.mjs:506-519`).
- `useMotionFeatures(instance, options?)`: registers the feature sets listed above (`dist/index.mjs:711-725`).
- `useElementStyle(target, onInit?)` / `useElementTransform(target, onInit?)`: bind a reactive `style` state / `transform` state to one element; transform parses existing CSS transforms on bind (`dist/index.mjs:844-962`).
- `reactiveStyle(props?)`: `{ state, style }` for CSS properties (`dist/index.mjs:727-752`).
- `reactiveTransform(props?, enableHardwareAcceleration = true)`: `{ state, transform }`; emits `translate3d(...)` for `x`/`y`/`z` and appends `translateZ(0px)` for GPU promotion (`dist/index.mjs:773-806`).
- `useReducedMotion(options?)`: `Ref<boolean>` from `prefers-reduced-motion: reduce` (`dist/index.mjs:1774-1777`).

## Directive factory and components

- `MotionDirective(variants?, isPreset?)`: directive object with `created`, `mounted`, and `getSSRProps` for SSR styles (`dist/index.mjs:1063-1101`, `dist/index.d.mts:635`).
- `MotionComponent` (`Motion`) and `MotionGroupComponent` (`MotionGroup`): props `is`, `preset`, `variants`, `initial`, `enter`, `leave`, `visible`, `visibleOnce`, `hovered`, `tapped`, `focused`, `delay`, `duration`, `instance` (`dist/index.mjs:1470-1531`, `dist/index.d.mts:695-933`). Config merge order: variant props over preset over `:variants` (`defu`, `dist/index.mjs:1590-1598`).
- `MotionPlugin`: `{ install(app, options?: MotionPluginOptions) }`; `MotionPluginOptions` = `{ directives?: Record<string, MotionVariants>, excludePresets?: boolean }` (`dist/index.d.mts:617-620`).

## Presets and utilities

- 30 preset objects, each a `MotionVariants` (`fade`, `fadeVisible`, `fadeVisibleOnce`, `pop*`, `roll{Left,Right,Top,Bottom}` + `Visible`/`VisibleOnce` forms, `slide{...}` same pattern), usable with `<Motion :preset="...">` or as `v-motion-[slug]` directives (`dist/index.mjs:1103-1457`).
- `slugify(str)`: camelCase to dash-case used for directive names (`dist/index.mjs:1459-1464`).
- `isMotionInstance(obj)`: guard for building libraries on top; checks `apply`, `set`, and `target` is a ref (`dist/index.mjs:1738-1741`, `dist/index.d.mts:659`).

## Re-exported types

`MotionInstance`, `MotionControls`, `MotionVariants`, `Variant`, `MotionProperties`, `TransformProperties`, `StyleProperties`, `SVGPathProperties`, `Transition`, `Tween`, `Spring`, `Keyframes`, `Inertia`, `SpringControls`, `MotionPluginOptions`, `ModuleOptions`, `UseMotionOptions`, `MotionTarget`, `PermissiveTarget`, `PermissiveMotionProperties`, and related Popmotion types (`dist/index.d.mts:1036`). Template variant props are typed globally via `HTMLAttributes` augmentation (`dist/index.d.mts:603-615`).
