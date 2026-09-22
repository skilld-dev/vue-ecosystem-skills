# Variants and transitions

## Variant lifecycle

A variant is a set of motion properties plus an optional `transition` (`dist/index.d.mts:514-531`). `MotionVariants` supports `initial`, `enter`, `leave`, `visible`, `visibleOnce`, `hovered`, `tapped`, `focused`, plus arbitrary custom keys.

- `initial`: applied at element creation; combined with `:style`; rendered as inline styles during SSR.
- `enter`: applied right after mount (`dist/index.mjs:659-678`).
- `leave`: not automatic; drive it through `<transition @leave>` and the instance `leave(done)` helper.
- `visible`: on viewport enter; `initial` is re-applied on viewport exit (`dist/index.mjs:696-703`).
- `visibleOnce`: first viewport enter only (`dist/index.mjs:701-706`).
- `hovered` / `focused` / `tapped`: layered event variants, priority hovered < focused < tapped; a combined meta-variant is applied while events are active, then reverts. Listeners register only for declared variants (`dist/index.mjs:597-657`; https://motion.vueuse.org/features/variants.html).
- Custom keys: switch via `instance.variant.value = 'key'` or `apply('key')`.

## Motion properties

- Transform properties (`x`, `y`, `z`, `translateX/Y/Z`, `rotate*`, `scale*`, `skew*`, `origin*`, `perspective`, `transformPerspective`) become a composed CSS `transform` string, not individual styles; `x`/`y`/`z` render as `translate3d` (`dist/index.d.mts:475-498`, `dist/index.mjs:768-806`).
- Style properties: any `CSSProperties` except `transition`, `rotate`, `scale`, `perspective`, `transform*` (`dist/index.d.mts:502`).
- SVG paths: `pathLength`, `pathOffset`, `pathSpacing` (`dist/index.d.mts:466-470`).
- Value types: numbers get units per key (px, deg, color, %) via `style-value-types` (`dist/index.mjs:296-374`). So `y: 100` is 100px, `rotate: 90` is 90deg.
- Keyframes: pass an array (`scale: [0, 1.2, 1]`) or `[null, ...]` where `null` means "from current value" (`dist/index.mjs:424-430`, `dist/index.d.mts:421-424`).

## Transition options

Defined per variant under `transition`. Time values are **milliseconds**. `type: false` disables animation (jump) (`dist/index.mjs:503`).

Orchestration (all types): `delay`, `onComplete`, `immediate` (set value, no animation) (`dist/index.d.mts:139-152`, `dist/index.mjs:511-514`).

Per-type:

- Spring (default for transform keys): `stiffness` (default 100 in type docs; runtime defaults `x`/`y`/`z`/`rotate*` to stiffness 500/damping 25, `scale*` to stiffness 550), `damping`, `mass`, or `duration` + `bounce` (each overrides the other set), `restSpeed`, `restDelta`, `velocity` (`dist/index.d.mts:233-294`, `dist/index.mjs:225-281`).
- Tween / keyframes: `duration` (default 300; 800 for keyframe arrays, `dist/index.mjs:266-281,443-446`), `ease` (name, cubic-bezier `[x1,y1,x2,y2]`, function, or arrays), `times`, `easings`, `from`, `velocity` (`dist/index.d.mts:180-228`).
- Easing names: `linear`, `easeIn`, `easeOut`, `easeInOut`, `circIn`, `circOut`, `circInOut`, `backIn`, `backOut`, `backInOut`, `anticipate` (runtime also accepts `bounceIn`/`bounceOut`/`bounceInOut`) (`dist/index.d.mts:138`, `dist/index.mjs:386-401`).
- Repeat (all types): `repeat` (count or `Infinity`), `repeatType` (`loop` default, `reverse`, `mirror`), `repeatDelay` (`dist/index.d.mts:153-175`).
- Inertia: momentum decay for values with velocity; `modifyTarget`, `power`, `timeConstant`, `min`, `max` (`dist/index.d.mts:309-364`).

Per-property transitions: nest key-specific definitions; `transition.default` is the fallback (`dist/index.mjs:462-464`):

```vue
:enter="{
  y: 0,
  opacity: 1,
  transition: {
    y: { delay: 1600 },
    opacity: { duration: 1600 },
  },
}"
```

Source: https://motion.vueuse.org/features/transition-properties.html

## Shorthand delay / duration props

On the directive and `<Motion>`/`<MotionGroup>`, `:delay` and `:duration` (numbers, or numeric strings on components) are written into the `transition` of every declared `enter`, `visible`, and `visibleOnce` variant (`dist/index.mjs:1043-1051,1573-1588`). They do not affect `initial`, `leave`, or event variants.

## Presets (30)

Each is `{ initial, enter }` (or `visible` / `visibleOnce` variants for the *Visible* forms) (`dist/index.mjs:1103-1457`):

- `fade`, `fadeVisible`, `fadeVisibleOnce`: opacity 0 -> 1.
- `pop`, `popVisible`, `popVisibleOnce`: scale 0 -> 1 + opacity.
- `roll{Left,Right,Top,Bottom}` (+ `Visible`, `VisibleOnce`): offset 100px + rotate +/-90deg -> 0.
- `slide{Left,Right,Top,Bottom}` (+ `Visible`, `VisibleOnce`): offset 100px -> 0 + opacity.

Usage: `<Motion preset="slideVisibleLeft">`, `v-motion-slide-visible-left` (slugified directive name, `dist/index.mjs:1718`), or spread the exported object into your own variants. Import them directly (`import { fadeVisibleOnce } from '@vueuse/motion'`) to compose or extend.
