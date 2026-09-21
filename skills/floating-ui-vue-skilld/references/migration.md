# Migration guide: @floating-ui/vue 1.x to 2.x

## v2.0.0 (breaking)

Dropped the abandoned `vue-demi` package, ending support for Vue 2 and Vue <3.3.0.

- Source: https://github.com/floating-ui/floating-ui/releases/tag/@floating-ui/vue@2.0.0
- Effect in the prepared source: `vue` is imported directly instead of `vue-demi` (`dist/floating-ui.vue.mjs:4`); peer dependency is `vue: ">=3.3.0"` (`package.json:58`).
- Required action:
  - If the project uses Vue >=3.3.0, no code changes. `useFloating` and `arrow` signatures, options, defaults, and return values are unchanged from 1.1.x (compare `dist/floating-ui.vue.d.ts:191-266` with the 1.x API).
  - If the project uses Vue 2 or Vue <3.3.0, either upgrade Vue or stay on the v1 line: `npm install @floating-ui/vue@1` (https://floating-ui.com/docs/vue).
- Remove `vue-demi` from your dependencies if you installed it only for this package. v2 never reads it.
- If you used `@floating-ui/vue` with `vue-demi`'s Vue 2 mode (e.g. `isVue2` branches), port those branches to a Vue 3 project or keep the v1 line.

## v2.0.1 (patch)

- Supports explicit `undefined` for optional properties when the project compiles with TypeScript `exactOptionalPropertyTypes`. Options are typed `MaybeReadonlyRefOrGetter<T | undefined> | undefined` (`dist/floating-ui.vue.d.ts:198-224`).
- Updated dependencies: `@floating-ui/dom@1.8.0`, `@floating-ui/utils@0.2.12` (`package.json:46-49`).
- Source: https://github.com/floating-ui/floating-ui/releases/tag/@floating-ui/vue@2.0.1

## Earlier changes still relevant when jumping from pre-1.0

- 1.0.0: `x` and `y` default to `0` instead of `null`. Check readiness with `isPositioned`, not coordinate null checks (`dist/floating-ui.vue.mjs:83-84`).
- 1.0.0: `floatingStyles` introduced; bind it to the floating element's `:style`.
- 1.1.0: `useFloating` options accept refs and getters (`MaybeReadonlyRefOrGetter`), e.g. `placement: () => props.placement` (`dist/floating-ui.vue.d.ts:138`).
- 1.1.5: `isPositioned` is not set to `true` while `open` is `false` (`dist/floating-ui.vue.mjs:137`).

## Upgrade checklist

1. Confirm Vue version: `node -e "console.log(require('vue/package.json').version)"`. Must be >=3.3.0.
2. Update the dependency: `npm install @floating-ui/vue@^2.0.1` (or the pnpm/yarn equivalent).
3. Remove `vue-demi` if present: `npm uninstall vue-demi`.
4. If TypeScript uses `exactOptionalPropertyTypes`, no workaround is needed on 2.0.1+.
5. Run typecheck and tests. No runtime API changed between 1.1.x and 2.0.1.
