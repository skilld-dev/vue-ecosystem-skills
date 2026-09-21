# API surface

Every export of `@vueuse/math` 15.0.0 with signatures from `dist/index.d.ts`, behavior from `dist/index.js`, and examples in the style of the official docs (https://vueuse.org/math.html). All inputs typed `MaybeRefOrGetter<T>` accept plain values, refs, and getters; every function returns a `ComputedRef` except the writable `useClamp` overload.

## Reactive Math wrappers

Each wraps one static `Math` method. Same shape, so they are listed together.

```ts
import { useAbs, useCeil, useFloor, useRound, useTrunc } from '@vueuse/math'

const value = ref(-3.7)
useAbs(value)   // ComputedRef<number>, 3.7  (dist/index.js:70-72)
useCeil(value)  // -3                        (dist/index.js:106-108)
useFloor(value) // -4                        (dist/index.js:133-135)
useRound(value) // -4                        (dist/index.js:230-232)
useTrunc(value) // -3                        (dist/index.js:254-256)
```

- `useAbs(value: MaybeRefOrGetter<number>): ComputedRef<number>` (`dist/index.d.ts:55`)
- `useCeil(...)`, `useFloor(...)`, `useRound(...)`, `useTrunc(...)`: same signature (`dist/index.d.ts:69,93,151,165`)

## useMath

```ts
declare function useMath<K extends keyof Math>(key: K, ...args: ArgumentsType<Reactified<Math[K], true>>): UseMathReturn<K>
```

Wraps any function-valued `Math` key with reactive arguments through `reactify` (`dist/index.js:145-147`). Only keys where `Math[K]` is callable type-check (`dist/index.d.ts:96`); constants like `'PI'` are rejected.

```ts
const base = ref(2)
const result = useMath('pow', base, 3) // 8; updates when base changes
const root = useMath('sqrt', ref(4)) // 2
```

Prefer the dedicated wrappers (`useRound` and so on) when one exists; use `useMath` for the rest of the `Math` surface such as `hypot`, `log`, `atan2`.

## Aggregations: useSum, useAverage, useMin, useMax

Each has two overloads, array form and rest form (`dist/index.d.ts:58-59,108-109,112-113,154-155`):

```ts
declare function useSum(array: MaybeRefOrGetter<MaybeRefOrGetter<number>[]>): ComputedRef<number>
declare function useSum(...args: MaybeRefOrGetter<number>[]): ComputedRef<number>
```

```ts
const list = ref([1, 2, 3, 4])
useSum(list)      // 10
useSum(a, b, 2)   // mixed refs, getters, and plain numbers
useAverage(a, b)  // (1 + 3) / 2
useMax(list)      // 4
useMin(list)      // 1
```

Behavior shared by all four (`dist/index.js:75-81` `toValueArgsFlat`):

- Each argument is resolved with `toValue`; a resolved array has each element resolved too, so nested arrays flatten one level.
- `useAverage` returns `NaN` for empty input, `reduce sum / length` with no guard (`dist/index.js:91-96`).
- `useMin` and `useMax` spread into `Math.min` / `Math.max` (`dist/index.js:157-176`), so empty input resolves to `Infinity` / `-Infinity`.

## useClamp

```ts
declare function useClamp(value: ReadonlyRefOrGetter<number>, min: MaybeRefOrGetter<number>, max: MaybeRefOrGetter<number>): ComputedRef<number>
declare function useClamp(value: MaybeRefOrGetter<number>, min: ..., max: ...): Ref<number>
```

Writable form (`dist/index.js:112-123`): with a mutable ref or a plain number, returns a writable computed bound to that ref; both `get` and `set` clamp, and `get` also writes the clamped value back, so the source ref never drifts out of bounds.

```ts
const level = ref(0)
const clamped = useClamp(level, 0, 10)
clamped.value = 15 // 10
clamped.value = -5 // 0
```

Read-only form (`dist/index.js:113`): with a getter or readonly ref, returns a plain computed.

```ts
const clamped = useClamp(() => value.value * 2, 0, 10)
```

`min` and `max` are reactive; when bounds change, the value re-clamps on next read (`dist/index.js:115-118`).

## usePrecision

```ts
interface UsePrecisionOptions { math?: 'floor' | 'ceil' | 'round' } // default 'round' (dist/index.d.ts:116-123)
declare function usePrecision(value: MaybeRefOrGetter<number>, digits: MaybeRefOrGetter<number>, options?: MaybeRefOrGetter<UsePrecisionOptions>): ComputedRef<number>
```

Returns a `number`, unlike `toFixed` which returns a string. Scales through `accurateMultiply` to avoid float error before rounding and dividing back (`dist/index.js:187-208`).

```ts
const value = ref(3.1415)
usePrecision(value, 2)                    // 3.14
usePrecision(value, 2, { math: 'ceil' })  // 3.15
usePrecision(value, 3, { math: 'floor' }) // 3.141
```

## useProjection, createProjection, createGenericProjection

```ts
declare function useProjection(input: MaybeRefOrGetter<number>, fromDomain: MaybeRefOrGetter<readonly [number, number]>, toDomain: MaybeRefOrGetter<readonly [number, number]>, projector?: ProjectorFunction<number, number>): ComputedRef<number>
declare function createProjection(fromDomain, toDomain, projector?): UseProjection<number, number>
declare function createGenericProjection<F, T>(fromDomain, toDomain, projector: ProjectorFunction<F, T>): UseProjection<F, T>
```

- `useProjection` projects one input now (`dist/index.js:218-220`).
- `createProjection` returns a reusable projector function; call it on many inputs with shared domains.
- Default projector is the linear interpolation `(input - from[0]) / (from[1] - from[0]) * (to[1] - to[0]) + to[0]` (`dist/index.js:12-14`).
- `createGenericProjection` handles non-number domains and always requires a custom `projector`; `createProjection`'s projector is optional (`dist/index.d.ts:6,9`).
- Domains are reactive; pass refs for zoomable charts or responsive sliders.

```ts
const input = ref(0)
useProjection(input, [0, 10], [0, 100]) // input 5 -> 50

const toPercent = createProjection([0, 10], [0, 100])
toPercent(input) // reusable across inputs

// non-linear example: log scale
const logScale = createProjection([1, 100], [0, 1], (v, from, to) =>
  (Math.log(v) - Math.log(from[0])) / (Math.log(from[1]) - Math.log(from[0])),
)
```

## logicAnd, logicOr, logicNot

```ts
declare function logicAnd(...args: MaybeRefOrGetter<any>[]): ComputedRef<boolean> // args.every (dist/index.js:28-30)
declare function logicOr(...args: MaybeRefOrGetter<any>[]): ComputedRef<boolean>  // args.some  (dist/index.js:56-58)
declare function logicNot(v: MaybeRefOrGetter<any>): ComputedRef<boolean>         // !v         (dist/index.js:42-44)
```

```ts
import { whenever } from '@vueuse/core'

const a = ref(true)
const b = ref(false)

whenever(logicAnd(a, b), () => { /* both truthy */ })
whenever(logicOr(a, b), () => { /* at least one truthy */ })
whenever(logicNot(a), () => { /* a falsy */ })
```

## Deprecated aliases

`and`, `or`, `not` re-export `logicAnd`, `logicOr`, `logicNot` and are marked `@deprecated` (`dist/index.d.ts:20-21,32-33,44-45`, `dist/index.js:31-32,45-46,59-60`). Do not use them in new code; see [migrations.md](./migrations.md).

## Types

- `ProjectorFunction<F, T> = (input: F, from: readonly [F, F], to: readonly [T, T]) => T` (`dist/index.d.ts:4`)
- `UseProjection<F, T> = (input: MaybeRefOrGetter<F>) => ComputedRef<T>` (`dist/index.d.ts:5`)
- `UseMathKeys`, `UseMathReturn` for `useMath` typing (`dist/index.d.ts:96-97`)
- `UsePrecisionOptions` (`dist/index.d.ts:116-123`)
