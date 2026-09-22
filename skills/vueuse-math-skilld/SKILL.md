---
name: vueuse-math-skilld
description: Math composables for Vue 3 from @vueuse/math. Use when writing or debugging code that imports "@vueuse/math", or when clamping, projecting, rounding, averaging, summing, or combining reactive numbers in Vue.
---

# @vueuse/math 15.0.0

Reactive math for Vue 3. Every composable resolves inputs with `toValue` inside a `computed`, so arguments accept plain numbers, refs, or getters (`MaybeRefOrGetter<number>`), and the result is a `ComputedRef<number>` that tracks every input (`dist/index.js:70-71`). The one exception: `useClamp` with a mutable ref returns a writable computed (`dist/index.d.ts:83`).

## Environment

- Install: `npm i @vueuse/math @vueuse/core` (`README.md:10`). `@vueuse/core` is needed only when combining with core functions such as `whenever`.
- Vue `^3.5.0` peer dependency (`package.json:42`), minimum since v14.
- Node.js `>= 22` (`package.json:39`); v15 dropped Node.js 20 ([release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0)).
- ESM-only since v13: `"type": "module"`, no CommonJS build (`package.json:3`; [release](https://github.com/vueuse/vueuse/releases/tag/v13.0.0)). Use dynamic `import()` if a CJS context must load it.
- `"sideEffects": false` (`package.json:24`): unused composables tree shake away.
- Runtime dependency: `@vueuse/shared@15.0.0` (`package.json:45`), which supplies `clamp` and `reactify`.
- Entry `dist/index.js`, types `dist/index.d.ts` (`package.json:30,34`).

## Exports

From `dist/index.d.ts:167`:

- Functions: `createGenericProjection`, `createProjection`, `logicAnd`, `logicNot`, `logicOr`, `useAbs`, `useAverage`, `useCeil`, `useClamp`, `useFloor`, `useMath`, `useMax`, `useMin`, `usePrecision`, `useProjection`, `useRound`, `useSum`, `useTrunc`
- Types: `ProjectorFunction`, `UseProjection`, `UseMathKeys`, `UseMathReturn`, `UsePrecisionOptions`
- Deprecated aliases: `and`, `or`, `not` (`dist/index.d.ts:20-21,32-33,44-45`)

Signatures, behavior notes, and per-function examples: [references/api.md](./references/api.md). Version-specific changes: [references/migrations.md](./references/migrations.md).

## Common tasks

Writable clamped state; pass a mutable ref so assignments are clamped automatically:

```ts
import { useClamp } from '@vueuse/math'

const level = ref(0)
const clamped = useClamp(level, 0, 10)
clamped.value = 15 // clamped.value and level.value are 10
```

Read-only clamp; pass a getter or readonly ref (`dist/index.js:113`):

```ts
const ratio = useClamp(() => raw.value / total.value, 0, 1)
```

Aggregate fixed refs with rest arguments instead of building an array (`dist/index.d.ts:154-155`):

```ts
const total = useSum(refA, refB, refC)
const peak = useMax(refA, refB, refC)
```

Map a value between domains, for sliders, charts, or progress UIs:

```ts
const progress = useProjection(scrollY, [0, pageHeight], [0, 100])
```

Reuse one projection across components; domains may be reactive:

```ts
const toPercent = createProjection(domain, [0, 100])
const a = toPercent(inputA)
```

Round to decimal places and keep a `number`, not the string `toFixed` returns:

```ts
const price = usePrecision(ref(3.1415), 2) // 3.14
const up = usePrecision(ref(3.1415), 2, { math: 'ceil' }) // 3.15
```

Combine boolean flags reactively, then feed side effects to `whenever` from `@vueuse/core`:

```ts
import { whenever } from '@vueuse/core'
import { logicAnd } from '@vueuse/math'

whenever(logicAnd(ready, hasData), run)
```

## Rules and pitfalls

- Never use the aliases `and`, `or`, `not`; deprecated since v14 in favor of `logicAnd`, `logicOr`, `logicNot` (`dist/index.d.ts:20,32,44`; [release](https://github.com/vueuse/vueuse/releases/tag/v14.0.0)).
- `useAverage` divides by `array.length` with no empty check: empty input yields `NaN` (`dist/index.js:91-96`). Guard the empty case yourself.
- `useMax()` with no inputs resolves to `-Infinity` and `useMin()` to `Infinity`, because both spread into `Math.max` / `Math.min` (`dist/index.js:157-176`).
- Aggregations (`useSum`, `useAverage`, `useMin`, `useMax`) accept refs, getters, numbers, arrays of those, and flatten nested arrays one level via `toValueArgsFlat` (`dist/index.js:75-81`).
- `usePrecision` avoids float drift by scaling through the decimal string of the value (`accurateMultiply`, `dist/index.js:187-193`); `options.math` defaults to `'round'` (`dist/index.d.ts:122`).
- `useMath` accepts only `Math` keys that are functions, such as `'pow'` or `'sqrt'`, never constants like `PI` (`dist/index.d.ts:96`).
- Projection is linear by default: `(input - from[0]) / (from[1] - from[0]) * (to[1] - to[0]) + to[0]` (`dist/index.js:12-14`). For non-linear mapping (log scales, easing), pass a custom `projector`, or use `createGenericProjection` for non-number domains (`dist/index.d.ts:4-6`).
- Prefer these composables over `computed(() => Math.x(...))` in templates and watchers; they centralize the `Math` call, stay reactive to every argument, and carry `@__NO_SIDE_EFFECTS__` annotations for tree shaking (`dist/index.js:4,15,111`).
