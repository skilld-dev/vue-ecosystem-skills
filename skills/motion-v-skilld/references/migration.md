# Migration and version notes for motion-v

## Upgrading from v1 to v2

Breaking changes in v2.0.0, summarized from the official release notes:

- Gesture shorthand props `focus`, `hover`, `press`, `inView` were removed.
  Use `whileFocus`, `whileHover`, `whilePress`, `whileInView` for animation.
  Use event props like `onHoverStart` and `onPressStart` for logic.
- CommonJS support was dropped. The package ships ESM (`.mjs`) only.
  Confirmed by the exports map, package.json:20-33.
- `AnimatePresence` now discovers children lazily through a `data-ap` DOM attribute.
- `MotionPlugin`, `createMotionDirective`, and `createPresetDirective` were added for the `v-motion` directive.
- `motionGlobalConfig` export was added.
- Later refinement in 2.2.1: the `data-ap` attribute is only added inside `AnimatePresence`, keeping other DOM clean.

Release notes: https://github.com/motiondivision/motion-vue/releases/tag/v2.0.0

Older v1 changes worth knowing when touching legacy code:

- `staggerChildren` and `staggerDirection` transition options are deprecated since v1.4.0.
  Use the `stagger()` utility inside `transition` instead, typically with `delayChildren`.
- `useScroll` accepts Vue refs for `container` and `target` since v1.6.0.

## Changes from 2.2.1 to 2.4.4

Baseline of the previous Skill was 2.2.1. The prepared source is 2.4.4.

### 2.3.0

- `arc()` enables motion along an arc. Use it as `transition: { path: arc({ rotate: 90 }) }`.
  The type layer pins the `path` key to `MotionPath` so `arc()` is accepted (dist/es/types/state.d.ts:33-44).
- `useAnimate` respects `MotionConfig skipAnimations`.
  Release: https://github.com/motiondivision/motion-vue/releases/tag/v2.3.0

### 2.4.0

- `Reorder` supports multidimensional reorder. Set `axis="xy"` on `Reorder.Group`.
  The axis type is `x`, `y`, or `xy` (dist/es/components/reorder/types.d.ts:2).
  Release: https://github.com/motiondivision/motion-vue/releases/tag/v2.4.0

### 2.4.1

- Layout fixes: promote and relegate are guarded by lead status.
- `MotionState` strict mode type errors resolved.
  Release: https://github.com/motiondivision/motion-vue/releases/tag/v2.4.1

### 2.4.2

- Exit and enter animations work again for `KeepAlive` cached components.
  If you skipped `AnimatePresence` around cached views because of this, retry now.
  Release: https://github.com/motiondivision/motion-vue/releases/tag/v2.4.2

### 2.4.3

- Layout: stale root scroll cache is refreshed before shared node mount.
  Fixes wrong shared layout measurements after page scroll.
  Release: https://github.com/motiondivision/motion-vue/releases/tag/v2.4.3

### 2.4.4

- Nuxt module: `motion-v` removed from build transpile.
  Release: https://github.com/motiondivision/motion-vue/releases/tag/v2.4.4

## Deprecations in current types

- `MotionConfig` prop `reduceMotion` is deprecated. Use `reducedMotion` (dist/es/components/motion-config/types.d.ts:9-13).
- `animationControls()` is deprecated. Use `useAnimationControls()` (dist/es/animation/hooks/animation-controls.d.ts:3-5).

## Full changelogs

- Releases: https://github.com/motiondivision/motion-vue/releases
- npm: https://www.npmjs.com/package/motion-v
