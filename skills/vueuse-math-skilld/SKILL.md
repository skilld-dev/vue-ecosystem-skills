---
name: vueuse-math-skilld
description: "Math functions for VueUse. ALWAYS use when writing code importing \"@vueuse/math\". Consult for debugging, best practices, or modifying @vueuse/math, vueuse/math, vueuse math, vueuse."
---

# vueuse/vueuse `@vueuse/math@15.0.0`
**Tags:** latest: 15.0.0

**References:** [Docs](./references/docs/_INDEX.md) · [Releases](./references/releases/_INDEX.md)

## Environment

- Install with `npm i @vueuse/math @vueuse/core` (source `README.md`)
- Requires Vue `^3.5.0` as peer dependency (source `package.json` `peerDependencies`)
- Requires Node.js `>=22`; v15 dropped Node.js 20 (source `package.json` `engines`; [release](./references/releases/v15.0.0.md))
- ESM-only (`"type": "module"`), no CommonJS since v13; `"sideEffects": false` for tree shaking (source `package.json`)
- Depends on `@vueuse/shared@15.0.0`; every export returns a `ComputedRef` (or writable computed for `useClamp`) built on `computed` + `toValue`

## API Changes

This section documents version-specific API changes — prioritize recent major/minor releases.

- NO MATH API CHANGES: v15.0.0 — the export set is identical to v14 (verified against `dist/index.d.ts` of the prepared 15.0.0 package); only the Node.js `>=22` engines requirement and the pinned `@vueuse/shared@15.0.0` dependency changed [source](./references/releases/v15.0.0.md)

- BREAKING: Requires Node.js 22+ — v15 dropped support for Node.js 20 [source](./references/releases/v15.0.0.md)

- DEPRECATED: `and`, `or`, `not` — v14 deprecated the aliases in favor of original names `logicAnd`, `logicOr`, `logicNot`; all three aliases are still exported in 15.0.0 and marked `@deprecated` (source `dist/index.d.ts:20-21,32-33,44-45`) [source](./references/releases/v14.0.0.md)

- BREAKING: Requires Vue 3.5+ — v14 moved to Vue 3.5 as minimum version, enabling native `MaybeRefOrGetter` [source](./references/releases/v14.0.0.md)

- BREAKING: ESM-only — v13 dropped CommonJS (CJS) support entirely [source](./references/releases/v13.0.0.md)

**Exports (15.0.0, source `dist/index.d.ts`):** `createGenericProjection`, `createProjection`, `logicAnd`, `logicNot`, `logicOr`, `useAbs`, `useAverage`, `useCeil`, `useClamp`, `useFloor`, `useMath`, `useMax`, `useMin`, `usePrecision`, `useProjection`, `useRound`, `useSum`, `useTrunc`, plus deprecated aliases `and`, `or`, `not` and types `ProjectorFunction`, `UseProjection`, `UseMathKeys`, `UseMathReturn`, `UsePrecisionOptions`

**Also changed:** `tsdown` build system v14 · `WatchSource<T>` types v14 · `MaybeRefOrGetter` native v12.8

## Best Practices

- Use `useClamp` with a mutable `ref` to create a self-validating state. When a mutable ref is passed, it returns a writable computed that automatically clamps any value assigned to it [source](./references/docs/useClamp/index.md)

```ts
// Preferred: prevents invalid state assignment
const value = useClamp(shallowRef(0), 0, 10)
value.value = 15 // state remains 10
```

- Pass a getter or readonly ref to `useClamp` for a read-only computed; pass a plain number or mutable ref for the writable form (source `dist/index.d.ts:82-83`)

- Pass reactive arrays for domains in `useProjection` to handle dynamic scaling. This is preferred for UI elements like zoomable charts or responsive sliders where the input/output boundaries change over time [source](./references/docs/useProjection/index.md)

- Define reusable mappers with `createProjection` outside component logic. This ensures consistent scaling across different parts of the application and reduces the overhead of redefining domains [source](./references/docs/createProjection/index.md)

- Leverage rest arguments in aggregation composables for ad-hoc calculations. `useSum`, `useAverage`, `useMax`, and `useMin` accept multiple refs directly, avoiding intermediate array refs (source `dist/index.d.ts:58-59,108-113,154-155`)

```ts
// Preferred: cleaner syntax for fixed sets of refs
const total = useSum(refA, refB, refC)
```

- Guard against empty input in `useAverage`. It divides by `array.length` without an empty check, so an empty array or argument list yields `NaN` (source `dist/index.js:91-96`)

- Prefer `usePrecision` over `toFixed` for numeric operations. `usePrecision` returns a `number`, which prevents type-coercion bugs and allows further mathematical operations without re-parsing strings [source](./references/docs/usePrecision/index.md)

- Use explicit rounding modes in `usePrecision` for specific UI requirements. Pass the `math` option ('floor' | 'ceil' | 'round', default 'round') to control how fractional values are handled in paginators or progress bars [source](./references/docs/usePrecision/index.md)

- Combine `logicAnd` or `logicOr` with `@vueuse/core`'s `whenever` for cleaner side effects. This pattern is more readable than complex manual `computed` properties when triggering actions based on multiple reactive flags [source](./references/docs/logicAnd/index.md)

- Employ `createGenericProjection` for non-linear domain mapping. Provide a custom projector function to handle logarithmic scales or custom eased transitions between arbitrary domains [source](./references/docs/createGenericProjection/index.md)

- Use `useMath` to reactively derive values from standard `Math` methods. It wraps any `Math` key with reactive arguments, so the result updates whenever any input dependency changes [source](./references/docs/useMath/index.md)

- Use `logicNot` for reactive boolean inversion in templates. It expresses intent more clearly than `!ref.value` or manual `computed` wrappers when defining visibility or disabled states [source](./references/docs/logicNot/index.md)
