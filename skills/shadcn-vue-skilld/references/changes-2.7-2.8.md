# Changes in 2.7 and 2.8

Baseline for this Skill update: 2.6.2. Prepared source: 2.8.2. This file lists what changed between them, so code written against older advice can be fixed. Facts cite the prepared dist or the official changelog; read the originals for detail.

## Preset names lost the reka- prefix

2.8.2 named presets are `vega`, `nova`, `maia`, `lyra`, `mira`, `luma`, `sera` (`dist/registry-hxzbzXMt.js:3141-3244`). The 2.6.x baseline and the current docs CLI page use prefixed forms like `reka-vega`; those names now fail with "Invalid preset". Registry style ids keep the prefix: preset `vega` fetches from style `reka-vega` (`dist/registry-hxzbzXMt.js:492-496`).

Action: replace `reka-<name>` with `<name>` in `init -p` and `apply` calls.

## Drawer rebuilt on Reka UI

Breaking. `Drawer` uses the Reka UI `Drawer` primitive instead of `vaul-vue`. `direction` becomes `swipe-direction` (the dismiss direction: `up`, `right`, `down`, `left`, default `down`), and `should-scale-background` is gone. Drop the `vaul-vue` dependency. Re-run `add drawer` to get the new source.
See https://www.shadcn-vue.com/docs/changelog and https://www.shadcn-vue.com/docs/components/drawer.

## Data Table moved to TanStack Table v9

Breaking. `useVueTable` becomes `useTable`, features are declared through `tableFeatures()` (sorting, filtering, pagination register explicitly and tree-shake), and the `valueUpdater` helper is gone because v9 manages that state internally. Filter and sort functions must be registered under `filterFns` and `sortFns`; referencing one by string without registering it silently does nothing.
Older Skill advice recommended the `valueUpdater` helper for TanStack Table state. That pattern is obsolete; delete it when updating a table.
See https://www.shadcn-vue.com/docs/components/data-table.

## New since the baseline

- `rhea` style: valid in encoded preset codes (`dist/preset/index.d.ts:3`); no named preset yet. Changelog: https://www.shadcn-vue.com/docs/changelog (July 2026).
- Chat interface components: `message-scroller`, `message`, `bubble`, `attachment`, `marker`.
- `questionnaire` component: multi-step single-question flows.
- `typeset`: one CSS file for rendered markdown; builder at https://www.shadcn-vue.com/typeset.
- CSS utilities `scroll-fade` and `shimmer` ship with the package (`dist/tailwind.css`), nothing extra to install after `init`.
- `field`, `item`, `empty`, `input-group`, `kbd`, `spinner`, `button-group` components, added earlier in the 2.x line.

## Durable deprecations and conventions

- `toast` and `toaster` are deprecated in favor of `sonner` (`dist/transform-menu-CLNZ5vUh.js:446-454`).
- `lucide-vue-next` is the legacy lucide package; current package is `@lucide/vue` (`dist/transform-menu-CLNZ5vUh.js:457`).
- Default color space is OKLCH with CSS variables, since 2.0.0 and Tailwind v4. Migration notes: https://github.com/unovue/shadcn-vue/releases/tag/v2.0.0.
- `Chart` uses `showGradient`, fixing the old `showGradiant` typo (since 2.3.0): https://github.com/unovue/shadcn-vue/releases/tag/v2.3.0.
- `NavigationMenuLink` exposes `data-active` (since 2.4.0): https://github.com/unovue/shadcn-vue/releases/tag/v2.4.0.
- All primitives carry `data-slot` attributes for granular styling.

## Release notes

Per-version detail: https://github.com/unovue/shadcn-vue/releases (CLI lives in `packages/cli`).
