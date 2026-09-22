# Best practices proven by the quasar 2.33.1 shipped docs

Each item cites the page inside `dist/mcp/` (of the installed package).

## Performance

- Prefer the responsive CSS classes (`gt-sm`, `lt-md`, `lt-xl`, visibility
  classes) over reading `$q.screen` in JavaScript when you can; the docs
  recommend it for performance (`options/screen-plugin.md:4`).
- Large `QTree`: two remedies in increasing order of effect
  (`vue-components/tree.md:214-228`):
  1. `no-transition` — drops the expand/collapse animation and lets collapsed
     subtrees leave the DOM.
  2. `virtual-scroll` (v2.25+) — constant cost regardless of expansion; give
     the tree a height or point `virtual-scroll-target` at a scrolling ancestor.
- `QSelect` virtual scroll: freeze the `options` array and reference
  `option-value`/`option-label` functions from scope instead of inline arrow
  functions (API desc, `dist/api/QSelect.json`).
- `lazy-rules: 'ondemand'` defers `QInput`/`QSelect` validation to form submit
  or a manual `validate()` call when the default blur timing fights you.

## Dialog plugin

- Custom components invoked through `$q.dialog({ component: ... })` must
  bootstrap with `useDialogPluginComponent()`
  (`vue-composables/use-dialog-plugin-component.md`).
- Since v2.28 the composable forwards the dismissal reason
  (`cancel`, `backdrop`, `escape`, `programmatic`) to `onCancel`/`onDismiss`:
  bind `@hide="onDialogHide"` directly — a wrapper like `@hide="onDialogHide()"`
  drops the event — and settle cancel through `onDialogCancel()`, not `hide()`.

## State, timers, platform

- `useQuasar()` is the Composition API way to `$q`
  (`vue-composables/use-quasar.md`).
- Use `useInterval`, `useTimeout`, `useAnimationFrame` instead of native
  timers: they cancel on component destroy/deactivate and are SSR no-ops
  (`vue-composables/use-interval.md:5-6`; start server-side work outside the
  rendering lifecycle instead of registering a timer in `setup()`).
- `Platform.is` booleans are explicitly `false`, not `undefined` (since v2.17)
  and the dead flags (`ie`, `winphone`, `kindle`, `silk`, `edgeChromium`) are
  gone since v2.28. Test with `=== false`, never falsiness, if you must branch.

## Layout and navigation

- Inside `QLayout`, put `QPullToRefresh` as a direct child of `QPage` and wrap
  the page content with it (`vue-components/pull-to-refresh.md:214`); call
  `updateScrollTarget()` if you move its parent.
- `QRouteTab` has no `model-value` prop; its active state derives from the
  route (`dist/api/QRouteTab.json`). Do not wire v-model to it.
- Menus that need `role="menu"` (since v2.25): declare it on the wrapped
  `QList`; its actionable `QItem`s then expose `menuitem` roles automatically.

## Theming

- Dark mode in SSR/SSG: `'auto'` renders light on the server and resolves on
  the client, so dark users see a flash; if the preference is knowable
  server-side (cookie), call `$q.dark.set()` from `src/App.vue` before mount
  (`quasar-plugins/dark.md:93`).
- Colors: read/write brand colors with `getCssVar`/`setCssVar`; palette lookup
  with `getPaletteColor` from the `colors` util. Since 2.33.1 `textToRgb()`
  preserves the alpha of `rgb(R, G, B, A)` strings
  (`src/utils/colors/colors.js:149-174`).
- The LoadingBar plugin is the recommended way to show an Ajax progress bar
  over manual `QAjaxBar` instances (`vue-components/ajax-bar.md:16`).

## Validation

- Connect Regle (https://reglejs.dev/) to `QInput`/fields for externalized
  validation; Quasar's docs recommend it
  (`vue-components/input.md:2397`).

## Quasar CLI projects

- Import wrappers from `#q-app/wrappers` (boot files, `configure`, store,
  router, SSR hooks); `quasar/wrappers` is the deprecated path
  (`wrappers/index.js:9-16`, docs `quasar-cli-vite` upgrade guide).
