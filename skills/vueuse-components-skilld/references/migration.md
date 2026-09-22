# Migration, v13 to v15

Version-specific rules for `@vueuse/components`, each cited to an official release or the prepared 15.0.0 source. Current baseline: 15.0.0.

## v15.0.0

Release: https://github.com/vueuse/vueuse/releases/tag/v15.0.0

- BREAKING: Node.js 20 support dropped; `engines.node` is now `>=22` (release notes; package.json:37)
- BREAKING (core): deprecated timer options removed in favor of `scheduler`. Affects `UseNow`, `UseTimeAgo`, `UseTimestamp`, whose timing prop is now only `scheduler` (release notes; dist/index.js:892-904, 1149-1169, 1172-1187)
- BREAKING (core): `useThrottleFn` default `trailing` changed from `false` to `true`; affects throttled event filters passed via `options` props such as `eventFilter`
- FIX: `onLongPress` (component and directive) clears a pending long press on `pointercancel`
- Also in core, not in this package: `templateRef` dropped, `useEventSource` SSE handling changed, `useIDBKeyval` cross-tab sync

## v14.0.0

Release: https://github.com/vueuse/vueuse/releases/tag/v14.0.0

- BREAKING: requires Vue 3.5+ (release notes; current peer range `^3.5.0` in package.json:40)
- BREAKING: components refactored for consistency. `OnClickOutside` and `OnLongPress` moved configuration to the `options` prop and actions to the `@trigger` emit; current shape verified at dist/index.js:5-17 and dist/index.js:57-69
- DEPRECATED: `VOnClickOutside` and `VOnLongPress` uppercase aliases; the `@deprecated` tags persist in 15.0.0 (dist/index.d.ts:17-18, 43-44)

## v13.0.0

Release: https://github.com/vueuse/vueuse/releases/tag/v13.0.0

- BREAKING: CJS build dropped; the package is ESM-only (`"type": "module"`, package.json:3). Bundlers and Node must use ESM imports; no `require()` support

## Upgrade checklist

1. Node toolchain at 22+ and an ESM-capable build setup.
2. Vue 3.5+.
3. Replace `VOnClickOutside` / `VOnLongPress` imports with `vOnClickOutside` / `vOnLongPress`.
4. On `On*` components, move inline handler props to the `options` prop and listen with `@trigger`.
5. Replace removed timer options on `UseNow`, `UseTimeAgo`, `UseTimestamp` with `scheduler`.
