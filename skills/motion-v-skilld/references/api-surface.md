# API surface, motion-v 2.4.4

Every claim below cites the prepared source at `dist/es/...` inside the package.

## Entry points

Defined in package.json:20-33:

- `motion-v`: types `dist/es/index.d.ts`, import `dist/es/index.mjs`
- `motion-v/nuxt`: Nuxt module, types `dist/nuxt/index.d.mts`
- `motion-v/resolver`: `unplugin-vue-components` resolver, types `dist/resolver/index.d.mts`

The root entry re-exports `framer-motion/dom` wholesale (dist/es/index.d.ts:1).
From there you get `animate`, `stagger`, `arc`, `motionValue`, easings, and engine types.

## Components

### motion, m, Motion

- `motion.<tag>`: typed component per HTML and SVG tag (dist/es/components/motion/index.d.ts:3-176).
- `m.<tag>`: same shape, no preloaded features, for `LazyMotion` (dist/es/components/motion/m.d.ts:2).
- `Motion`: dynamic tag form, defaults to `div` (dist/es/components/motion/index.d.ts:183).
- `motion.create(component, options?)`: wrap a Vue component or tag string with motion props. Options accept a feature bundle and `forwardMotionProps` (dist/es/components/motion/index.d.ts:177-182, dist/es/components/motion/utils.d.ts:12-19).

`MotionProps` adds `as`, `asChild`, the five `while*` props, `forwardMotionProps`, `ignoreStrict` (dist/es/components/motion/types.d.ts:3-13).

Key prop groups from `Options` (dist/es/types/state.d.ts:48-68) and the declared prop list (dist/es/components/motion/props.d.ts:1-192):

| Group | Props |
|---|---|
| Animation | `initial`, `animate`, `exit`, `variants`, `custom`, `inherit`, `transition`, `onAnimationStart`, `onAnimationComplete`, `onUpdate` |
| Style | `style` (accepts `MotionValue` per key), `transformTemplate` |
| Gestures | `whileHover`, `whilePress`, `whileFocus`, `whileDrag`, `whileInView`, plus `onHoverStart`, `onHoverEnd`, `onPressStart`, `onPress`, `onPressCancel`, `onPan`, `onPanStart`, `onPanEnd`, `onPanSessionStart` |
| Viewport | `inViewOptions`, `onViewportEnter`, `onViewportLeave` |
| Drag | `drag` (`true`, `"x"`, `"y"`), `dragConstraints`, `dragElastic`, `dragMomentum`, `dragSnapToOrigin`, `dragDirectionLock`, `dragPropagation`, `dragListener`, `dragControls`, `dragTransition`, `onDrag`, `onDragStart`, `onDragEnd`, `onDirectionLock`, `onDragTransitionEnd`, `onMeasureDragConstraints` |
| Layout | `layout` (`true`, `"position"`, `"size"`, `"preserve-aspect"`), `layoutId`, `layoutScroll`, `layoutRoot`, `layoutDependency`, `crossfade`, plus layout measure callbacks |

Transition accepts `path: arc(...)` for motion along an arc through the `WithMotionPath` override (dist/es/types/state.d.ts:33-44, dist/es/types/state.d.ts:60-62).

### AnimatePresence

Props: `mode` (`"wait"`, `"popLayout"`, `"sync"`), `initial`, `as`, `custom`, `onExitComplete`, `anchorX` (`"left"`, `"right"`) (dist/es/components/animate-presence/types.d.ts:1-8).

### LayoutGroup

Props: `id`, `inherit` (`true`, `"id"`, `"group"`) (dist/es/components/use-layout-group.d.ts:5-15).
Slot scope exposes `renderKey` and `forceRender` (dist/es/components/LayoutGroup.d.ts:5-9).

### LazyMotion

Props: `features` (required, accepts a bundle, a promise, or a loader function), `strict` (dist/es/components/lazy-motion/index.d.ts:3-13).

### MotionConfig

State props: `transition`, `reducedMotion` (`"user"`, `"never"`, `"always"`), `skipAnimations`, `nonce` for CSP, `inViewOptions` (dist/es/components/motion-config/types.d.ts:5-20). `reduceMotion` is deprecated in favor of `reducedMotion`.

### Reorder

- `Reorder.Group`: `axis` (`"x"`, `"y"`, `"xy"`), `values`, `onUpdate:values` (so `v-model:values` works), plus full motion props (dist/es/components/reorder/index.d.ts:8-46, dist/es/components/reorder/types.d.ts:2).
- `Reorder.Item`: motion props plus item behavior, exported from the same index.
- Multidimensional reorder (`axis="xy"`) shipped in 2.4.0, see migration notes.

### RowValue

Render helper that prints a live `MotionValue` through `innerHTML` (dist/es/components/RowValue.d.ts:1-15).

## Hooks

Animation (dist/es/animation/index.d.ts:1-3):

- `useAnimate(): [scope, animate]`. `scope` is a template ref carrying `animations` (dist/es/animation/hooks/use-animate.d.ts:4-7).
- `useAnimationControls(): AnimationControls` with `start`, `stop`, `set`, `mount`. Pass to `animate` prop (dist/es/animation/hooks/use-animation-controls.d.ts:28-33).
- `useReducedMotion(options?: { window? }): Ref<boolean>` (dist/es/animation/hooks/use-reduced-motion.d.ts:5-7).
- `animationControls()` is deprecated (dist/es/animation/hooks/animation-controls.d.ts:3-5).

Motion values (dist/es/value/index.d.ts:1-10):

- `useMotionValue`: alias of engine `motionValue` (dist/es/index.d.ts:3).
- `useSpring(source, config?)`: accepts value or `MotionValue`, string or number overloads (dist/es/value/use-spring.d.ts:6-7). Also `useFollowValue` (line 5).
- `useTransform`: four shapes, range map, plain transformer, multi input transformer, and a named output map that returns several `MotionValue`s at once (dist/es/value/use-transform.d.ts:54-97).
- `useMotionTemplate`: tagged template combining values and constants (dist/es/value/use-motion-template.d.ts:21).
- `useMotionValueEvent(value, event, cb): VoidFunction` unsubscribe (dist/es/value/use-motion-value-event.d.ts:2).
- `useVelocity(value): MotionValue<number>` (dist/es/value/use-velocity.d.ts:12).
- `useTime(): MotionValue<number>` (dist/es/value/use-time.d.ts:1).
- `useComputed(() => T): MotionValue<T>` (dist/es/value/use-computed.d.ts:2).
- `useCombineMotionValues(() => T)` low level combiner (dist/es/value/use-combine-values.d.ts:2-6).

Scroll and visibility (dist/es/utils/index.d.ts:1-7):

- `useScroll(options?)`: `container`, `target` accept `MaybeComputedElementRef`. Returns `scrollX`, `scrollY`, `scrollXProgress`, `scrollYProgress` (dist/es/value/use-scroll.d.ts:4-13).
- `ScrollOffset` presets `Enter`, `Exit`, `Any`, `All` for the `offset` option (dist/es/value/scroll/offsets.d.ts:10-19). Recognized patterns map to native view timelines, others fall back to JS tracking (lines 22-30).
- `useInView(domRef, options?)`: options extend IntersectionObserver options, `root` accepts a ref. Returns `Ref<boolean>` (dist/es/utils/use-in-view.d.ts:4-7).
- `usePageInView(): Ref<boolean>` (dist/es/utils/use-page-in-view.d.ts:1).
- `useAnimationFrame(cb)` with `timestamp` and `delta` args (dist/es/utils/use-animation-frame.d.ts:1-2).
- `useDragControls(): DragControls` with `start(event, options?)` to start drag from another element (dist/es/features/gestures/drag/use-drag-controls.d.ts:22-73).

Layout: `useLayoutGroupProvider` and `useLayoutGroup` (dist/es/components/use-layout-group.d.ts:20-23).

## Directive and plugin

From `dist/es/directive/index.d.ts` and `index.mjs`:

- `vMotion`: ready to use directive, defaults to `domMax` features (index.mjs:168).
- `createMotionDirective(featureBundle?, defaultOptions?)`: custom bundle plus defaults merged under user props (index.d.ts:11, index.mjs:100-113).
- `createPresetDirective(preset, featureBundle?)`: bake options into a reusable directive (index.d.ts:25).
- `MotionPlugin`: plugin registering `v-motion` globally and named preset directives from `options.presets` (index.mjs:169-172).
- `MotionPluginOptions.presets`: map of directive name to motion options (index.d.ts:27-30).
- The directive handles SSR via `getSSRProps` (index.mjs:153-162) and resolves provides so it inherits variants, presence, and config context (index.mjs:80-99).

## Feature bundles

- `FeatureBundle`: `renderer` plus `features` array (dist/es/features/dom-animation.d.ts:3-6).
- `domAnimation`: animations, variants, exit, gestures (dist/es/features/dom-animation.d.ts:7).
- `domMax`: everything, drag and layout included (dist/es/features/dom-max.d.ts:2).

## Global config

`motionGlobalConfig.motionAttribute`: the data attribute used for element discovery, used by AnimatePresence exit detection (dist/es/config.d.ts:10-15).

## Nuxt module

Module options: `components`, `utilities`, `prefix`, `directives`, `presets` (dist/nuxt/index.d.mts:8-16).

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['motion-v/nuxt'],
  motionV: { directives: true },
})
```

## Utility exports

- `delayInMs` (dist/es/index.d.ts:2).
- `mountedStates`: live map of element to motion state (dist/es/components/index.d.ts:8).
- `PanInfo` type (dist/es/index.d.ts:14).
- Context helpers `injectMotion`, `provideMotion`, `injectLayoutGroup`, `provideLayoutGroup` (dist/es/components/context.d.ts:4-11).
