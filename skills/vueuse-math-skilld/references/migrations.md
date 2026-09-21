# Migrations and version rules

Version-specific rules for `@vueuse/math`. Release content is cited by URL, not copied.

## v15.0.0 (2026-09-16)

- No `@vueuse/math` API changes; the export set is identical to v14 (`dist/index.d.ts:167`).
- Requires Node.js `>= 22`; Node.js 20 support dropped (`package.json:39`; [release](https://github.com/vueuse/vueuse/releases/tag/v15.0.0)).
- Pins `@vueuse/shared@15.0.0` as a dependency (`package.json:45`).

## v14.0.0 (2025-10-22)

[Release](https://github.com/vueuse/vueuse/releases/tag/v14.0.0)

- BREAKING: requires Vue 3.5 as minimum (`package.json:42`).
- DEPRECATED: alias exports `and`, `or`, `not` in favor of `logicAnd`, `logicOr`, `logicNot` ([issue](https://github.com/vueuse/vueuse/issues/5009)); aliases remain exported and marked `@deprecated` in 15.0.0 (`dist/index.d.ts:20-21,32-33,44-45`).
- Build moved to `tsdown` with relocated dist files ([issue](https://github.com/vueuse/vueuse/issues/5004)); deep imports resolve via the `"./*": "./dist/*"` export map (`package.json:27`).

## v13.0.0 (2025-03-10)

- BREAKING: ESM-only, the CommonJS build is removed ([release](https://github.com/vueuse/vueuse/releases/tag/v13.0.0), [issue](https://github.com/vueuse/vueuse/issues/4581)). `"type": "module"` in `package.json:3`.

## v12.8.0 (2025-03-05)

- VueUse's own `MaybeRef` / `MaybeRefOrGetter` types deprecated in favor of Vue's native ones ([release](https://github.com/vueuse/vueuse/releases/tag/v12.8.0), [issue](https://github.com/vueuse/vueuse/issues/4636)). Current signatures import `MaybeRefOrGetter` from `vue` (`dist/index.d.ts:1`).

## Migration checklist

1. Coming from v13 or older: confirm the build chain handles ESM; no `require('@vueuse/math')`.
2. Coming from v14 or older: confirm Node.js 22+ runtime.
3. Any version: replace `and` / `or` / `not` imports with `logicAnd` / `logicOr` / `logicNot`.
4. Any version: Vue 3.5+ peer, `npm i @vueuse/math @vueuse/core` (`README.md:10`).
