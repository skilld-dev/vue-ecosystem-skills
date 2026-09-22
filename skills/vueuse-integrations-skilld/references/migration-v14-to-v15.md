# Migration: v14 to v15 (@vueuse/integrations)

Baseline: 14.3.0 → target: 15.0.0. Facts verified against the prepared v15.0.0 source and cited release notes.

## v15.0.0

Release: https://github.com/vueuse/vueuse/releases/tag/v15.0.0 (2026-09-16)

### BREAKING: `useIDBKeyval` returns an object and syncs across tabs

PR: https://github.com/vueuse/vueuse/pull/5338 (labeled BREAKING CHANGE, milestone 15.0). Verified in dist/useIDBKeyval.d.ts:46-51 and dist/useIDBKeyval.js:83-89.

Before (v14):

```ts
const count = useIDBKeyval('my-count', 0) // ref with merged set()
count.value = 10
await count.set(10)
```

After (v15):

```ts
const { data: count, set } = useIDBKeyval('my-count', 0)
count.value = 10
await set(10)
```

Migration steps:

1. Replace `const x = useIDBKeyval(...)` with `const { data: x, set } = useIDBKeyval(...)`.
2. Change `await x.set(v)` to `await set(v)`.
3. Deleting still works by assignment: `x.value = null`.
4. New return members: `isFinished` (initial read done), `isSupported` (BroadcastChannel available).

New option `listenToStorageChanges` (default `true`) syncs every `useIDBKeyval` on the same key across tabs via `BroadcastChannel` named `vueuse-idb-<key>`; it uses `BroadcastChannel`, not the `StorageEvent`, despite the option name matching `useStorage`. Pass `listenToStorageChanges: false` when cross-tab echo is unwanted (dist/useIDBKeyval.js:60-76).

### BREAKING: Node.js 20 dropped

`engines.node` is `>=22` (package.json:52-54; release note "Drop support for Node.js 20", https://github.com/vueuse/vueuse/pull/5553). Upgrade CI images and Lambda runtimes before upgrading.

### drauu peer range aligned

`useDrauu` accepts `drauu@^1 || ^0.4` (package.json:59; https://github.com/vueuse/vueuse/pull/5595). v14 pinned `^0.4`; either major now resolves. The API surface used (`createDrauu`, `Brush`, `Options`) is identical in both.

### Other notes for this window (v14.4.0)

- `useFuse` now calls `triggerRef` after `setCollection`, so refs holding the `fuse` instance update when `data` changes (https://github.com/vueuse/vueuse/pull/5479, dist/useFuse.js:16-19).

## Carried constraints still in force

- Vue `^3.5.0` peer required (since v14.0.0, https://github.com/vueuse/vueuse/releases/tag/v14.0.0; package.json:68).
- ESM-only; the CommonJS build was removed in v13.0.0 (https://github.com/vueuse/vueuse/releases/tag/v13.0.0). Jest users need `transformIgnorePatterns` allowing `@vueuse/integrations`.
- Alias exports deprecated since v14.0.0 (https://github.com/vueuse/vueuse/issues/5009); import original names only.
- Dist layout from tsdown (since v14.0.0): per-function entry files plus `<fn>/component.js` subpaths (package.json:24-43). Deep imports like `@vueuse/integrations/useAxios` are stable public API.
- `useSortable.watchElement` option available since v14.2.0 (https://github.com/vueuse/vueuse/issues/5189).
- `useFocusTrap` peer range `focus-trap@^7 || ^8` since v14.2.0 (https://github.com/vueuse/vueuse/issues/5270).

## Upgrade checklist

1. Node >= 22 everywhere the package installs or builds.
2. `useIDBKeyval` call sites: destructure `data`, switch `.set()` calls (type errors surface immediately because the return type changed).
3. Review any code relying on cross-tab silence from `useIDBKeyval`; opt out with `listenToStorageChanges: false`.
4. Confirm each wrapper's peer dependency is installed; v15 widened only `drauu`.
5. Keep submodule imports (`@vueuse/integrations/useX`) for tree-shaking; remove any deprecated alias usage.
