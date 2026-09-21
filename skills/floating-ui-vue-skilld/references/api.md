# API reference: @floating-ui/vue 2.0.1

All citations point to the prepared package source (`dist/` files) or official documentation.

## `useFloating(reference, floating, options?)`

Main composable. Computes coordinates that place the floating element next to the reference element (declaration: `dist/floating-ui.vue.d.ts:191`).

```ts
useFloating<T extends ReferenceElement = ReferenceElement>(
  reference: Readonly<Ref<MaybeElement<T>>>,
  floating: Readonly<Ref<MaybeElement<FloatingElement>>>,
  options?: UseFloatingOptions<T>,
): UseFloatingReturn;
```

Both arguments are Vue template refs (`ref(null)`). They may hold DOM elements, `ComponentPublicInstance` (unwrapped via `$el`), or `null`/`undefined` before mount (`dist/floating-ui.vue.d.ts:134`).

### Options

All options except `whileElementsMounted` accept a plain value, a readonly `Ref`, or a getter (`MaybeReadonlyRefOrGetter`, `dist/floating-ui.vue.d.ts:138`). Defaults from `dist/floating-ui.vue.d.ts:193-225` and `dist/floating-ui.vue.mjs:64-80`:

| Option | Type | Default | Notes |
|---|---|---|---|
| `open` | `boolean \| undefined` | `true` | Open/close state. Drives `isPositioned` reset behavior. |
| `placement` | `Placement \| undefined` | `'bottom'` | Side plus alignment, e.g. `'top-start'`. |
| `strategy` | `'absolute' \| 'fixed' \| undefined` | `'absolute'` | CSS position strategy. |
| `middleware` | `Middleware[] \| undefined` | `undefined` | Ordered list: `offset`, `flip`, `shift`, `arrow`, `size`, `hide`, `inline`, `autoPlacement`. |
| `transform` | `boolean \| undefined` | `true` | Use `transform` instead of `top`/`left` in `floatingStyles`. |
| `whileElementsMounted` | `(reference, floating, update) => () => void` | `undefined` | Manage the update lifecycle, typically `autoUpdate`. Must return a cleanup function. |

### Return value

All refs are shallow readonly (`dist/floating-ui.vue.mjs:174-183`). Types at `dist/floating-ui.vue.d.ts:227-266`:

| Property | Type | Notes |
|---|---|---|
| `x`, `y` | `Readonly<Ref<number>>` | Coordinates. Start at `0`, not `null` (`dist/floating-ui.vue.mjs:83-84`). |
| `placement` | `Readonly<Ref<Placement>>` | Final placement; may differ from the option after `flip`/`autoPlacement`. |
| `strategy` | `Readonly<Ref<Strategy>>` | Final CSS position strategy. |
| `middlewareData` | `Readonly<Ref<MiddlewareData>>` | Per-middleware data, e.g. `middlewareData.value.arrow?.x`. |
| `isPositioned` | `Readonly<Ref<boolean>>` | True after the first successful compute. Stays `false` while `open === false` (`dist/floating-ui.vue.mjs:137`). |
| `floatingStyles` | `Readonly<Ref<{position, top, left, transform?, willChange?}>>` | Bind to `:style`. See below. |
| `update` | `() => void` | Manual recompute; no-ops while either element is `null` (`dist/floating-ui.vue.mjs:116-119`). |

### `floatingStyles` details

From `dist/floating-ui.vue.mjs:89-114`:

- Before the floating element mounts: `{position: strategy, left: '0', top: '0'}`.
- With `transform: true` (default): `position`, `left: '0'`, `top: '0'`, `transform: translate(x, y)`. Adds `willChange: 'transform'` when `devicePixelRatio >= 1.5`.
- With `transform: false`: `position`, `left: '<x>px'`, `top: '<y>px'`.
- Values are rounded by device pixel ratio for crisp rendering (`roundByDPR`, `dist/floating-ui.vue.mjs:39-50`). `getDPR` guards `typeof window === 'undefined'`, so the computed is SSR-safe.

### Behavior notes

- Option refs/getters and element refs are watched with `flush: 'sync'`; option changes trigger `update` immediately (`dist/floating-ui.vue.mjs:162-167`).
- `computePosition` is async; results apply in a microtask. Gate DOM side effects (focus, `scrollIntoView`) on `isPositioned` (https://floating-ui.com/docs/vue).
- If `whileElementsMounted` is not set, `update` runs once per option/element change only. Use `autoUpdate` for scroll/resize anchoring (https://floating-ui.com/docs/autoUpdate).
- Cleanup of the `whileElementsMounted` callback runs automatically on scope dispose (`dist/floating-ui.vue.mjs:171-173`).

## `arrow(options)`

Vue-aware `arrow` middleware. Declaration: `dist/floating-ui.vue.d.ts:65-78`; implementation: `dist/floating-ui.vue.mjs:22-37`.

```ts
import {arrow} from '@floating-ui/vue';

const floatingArrow = ref(null);
useFloating(reference, floating, {
  middleware: [arrow({element: floatingArrow, padding: 4})],
});
```

| Option | Type | Default | Notes |
|---|---|---|---|
| `element` | `MaybeReadonlyRefOrGetter<MaybeElement<Element>>` | required | Template ref, ref, getter, or element. |
| `padding` | `Padding` | `0` | Inset from floating element edges, useful with rounded corners. |

- Wraps `@floating-ui/dom`'s `arrow`; unwraps refs and component instances, and returns `{}` (no-op) while the element is `null`, so it tolerates not-yet-mounted arrows (`dist/floating-ui.vue.mjs:27-30`).
- Read `middlewareData.value.arrow?.x` and `?.y` in the template; both are `null` until positioned. Full example: https://floating-ui.com/docs/vue and https://floating-ui.com/docs/arrow.

## Virtual elements

Any object with `getBoundingClientRect()` works as the reference, e.g. for cursor or range anchoring. Assign it to the reference ref inside a lifecycle hook or event handler (https://floating-ui.com/docs/virtual-elements):

```ts
reference.value = {
  getBoundingClientRect: () => new DOMRect(x, y, 0, 0),
};
```

## Re-exports from `@floating-ui/dom`

`autoPlacement`, `autoUpdate`, `computePosition`, `detectOverflow`, `flip`, `getOverflowAncestors`, `hide`, `inline`, `limitShift`, `offset`, `platform`, `shift`, `size` and their types (`dist/floating-ui.vue.mjs:2`). Prefer these over a direct `@floating-ui/dom` import so one dependency provides everything, except `arrow`, which must come from `@floating-ui/vue` to get template-ref support.

Middleware and positioning concepts: https://floating-ui.com/docs/middleware, https://floating-ui.com/docs/computePosition.
