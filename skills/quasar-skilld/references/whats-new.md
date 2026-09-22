# What changed: quasar 2.20 -> 2.33.1

Baseline of the previous Skill: 2.33.0. Each item cites the official release
(URL) or the prepared source. Read the linked release before advising on an
upgrade edge case.

## Behavior changes to check before upgrading

- **v2.33.1** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.33.1
  - Fix only, no API change. `QPagination` in `input` mode clears the typed
    page after submit (the field showed the stale typed number next to the
    placeholder) (#18552, `src/components/pagination/QPagination.js:290-292`).
  - `textToRgb()` keeps the alpha of the `rgb(R, G, B, A)` form (before, only
    `rgba()` preserved it); `rgb()` without alpha still yields `a: 100`
    (#18555, `src/utils/colors/colors.js:149-174`).
- **v2.33.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.33.0
  - Documentation ships inside the package (guides + compact API, offline,
    exact version); pair with the new `@quasar/mcp` server.
  - `extractDate()` matches the longest locale name instead of the first
    declared one, so `formatDate()` output parses back to the same date (16
    round-trips fixed across 7 language packs; vi `YYYY MMM`, tr `Pazar`).
  - Language pack `lv`: the short name of Friday is now `Pk` (was `Pi`,
    colliding with Monday).
  - `QTable`: the rows-per-page selector follows a controlled
    `v-model:pagination` (#18550); `scrollTo()` emits the `to` of its
    `virtual-scroll` payload as the last rendered row index.
  - Virtual scroll (`QVirtualScroll`, `QSelect`, `QTable`, `QTree`): a
    `scrollTo()` issued right after a scroll event is no longer dropped while
    the scroller still moves.
- **v2.32.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.32.0
  - `QImg` renders its `<img>` into SSR/SSG HTML whenever the box shape is known
    (`ratio`, `initial-ratio` or `height`); new `ssr-prerender` prop forces it
    for unknown shapes. Crawler/no-JS markup changes.
  - `.q-responsive__filler` element removed; ratio now uses CSS `aspect-ratio`
    on `QResponsive`/`QImg`/`QVideo` roots.
  - `QExpansionItem` and `QTree` no longer mount a `QSlideTransition` child;
    `duration` became a real Number prop on both.
  - `QInput` autogrow textareas are browser-sized (`field-sizing: content`) on
    Chromium 123+/Safari 26+; no inline height styles there.
  - `QParallax` uses view timelines and registers no listeners where supported;
    using the `content` slot scope forces JS tracking back on.
- **v2.31.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.31.0
  - Readonly `QInput`/`QSelect`/`QFile`/`QField` now reflect focus (focused
    styling, `focus`/`blur` events, `lazy-rules` validation on blur). Only
    `disable` exempts.
  - `config.dark: 'auto'` resolves on the client again in SSR/SSG apps (had been
    a silent `false` since 2.18.2); first paint stays light without the cookie
    approach.
  - `.q-transition--field-message-*` classes removed; use
    `.q-field__messages--animated`.
  - Elevation shadow colors are CSS custom properties.
- **v2.30.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.30.0
  - `QInfiniteScroll` watches the end of its content instead of the scroll
    position: `offset` is measured from the content end, nothing loads after
    scrolling past the component.
  - `v-scroll-fire` fires once any part of the element is visible (old timing:
    the `:1` argument) and also fires on non-scroll visibility.
  - `v-intersection` dispatches every entry of a callback batch and no longer
    passes the observer as a second argument.
- **v2.29.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.29.0
  - A `@click` listener on `QItem` or `QChip` now implies `clickable`
    (tri-state prop, `null` default); markup with dead click listeners gains
    hover styling, focusability and role.
- **v2.28.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.28.0
  - `QMenu`/`QTooltip` lost the `scroll-target` prop; popups hear every
    scrolling container via one capture-phase document listener. Remove the
    prop from templates.
  - `QMenu`/`QTooltip` freeze their placement per show: no re-flip while the
    anchor scrolls; `updatePosition()` re-runs the placement decision.
  - `Platform.is` dropped `ie`, `edgeChromium`, `winphone`, `kindle`, `silk`;
    `is.edge` semantics changed accordingly.
- **v2.27.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.27.0
  - Language packs `kur-CKB`, `mm`, `sr-CYR` report `ckb`, `my`, `sr-Cyrl`.
    Old import paths keep working as deprecated aliases for all of v2; code
    comparing `$q.lang.isoName` needs updating.
- **v2.26.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.26.0
  - `QInput` textarea rows are no longer pinned to 18px line-height; bigger
    fonts change the height.
- **v2.25.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.25.0
  - `QMenu` no longer claims `role="menu"` and QBtnDropdown's toggle dropped
    `aria-haspopup`; declare `role="menu"` on the wrapped `QList` and use the
    new `toggle-aria-haspopup` prop.
  - SSR'd virtual lists render their first slice on the server: item templates
    of server-rendered `QVirtualScroll`/`QTable` must be SSR-safe.
  - `QSlideTransition` animates immediately (no 100ms delay).
- **v2.24.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.24.0
  - Tree-shaking and toolchain work; no runtime or breaking changes. Pairs with
    `@quasar/vite-plugin` v2.
- **v2.23.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.23.0
  - RTL: update `postcss.config.js` to `postcss-rtlcss` `Mode.Override`
    (import `{ Mode }` from `postcss-rtlcss/options`).
- **v2.22.0** https://github.com/quasarframework/quasar/releases/tag/quasar-v2.22.0
  - Security fixes; SSG mode with Quasar CLI requires this version or later.
- **v2.20.0**: legacy Vetur build step removed. **v2.21.0**: `QTable`
  `getCellValue()` method added.

## New API since v2.20 (from `addedIn` markers in `dist/api/*.json`)

None in v2.33.x: no descriptor carries `addedIn: v2.33` in 2.33.1.

- v2.25: `QTree` `virtual-scroll` + virtual-scroll props, `scrollTo`,
  `getParentNode`, tick-state methods; `QDrawer` `@escape-key`; `QRange`
  `left/right-thumb-aria-label`; `QSplitter` `separator-aria-label`; `QList`/
  `QItem`/`QVirtualScroll` `role`; `QBtnDropdown` `toggle-aria-haspopup`,
  `toggle` slot.
- v2.26: `hover`, `hover-delay`, `hover-hide-delay` on `QMenu`, `QBtnDropdown`,
  `QPopupEdit`, `QPopupProxy`; `QRange` `min-range`/`max-range`; `QTable`
  `footer` slot.
- v2.27: `QTd`/`QTh` `col-name`; `QFab` `hover` props.
- v2.28: `QSelect` `hover` props, `hide-dialog-close`, `no-option-label`,
  `no-chip-remove`, `no-option-prefetch`; `useDialogPluginComponent` reports the
  dismissal reason (`cancel`/`backdrop`/`escape`/`programmatic`) through
  `onDialogHide`; `Lang.getClosestIsoName()`.
- v2.30: `QPullToRefresh` `side`; `QTooltip` `cursor-position`; `QPagination`
  `ellipsis` slot; `QFab` `stagger`; `QEditor` `dropdown-hover` props.
- v2.31: `QColor` `palette` slot.
- v2.32: `QImg` `ssr-prerender`; `QDrawer` `@pan`; `QParallax` `refresh()`.

## Deprecations in v2.33

- `QInput`/`QFile` method `getNativeElement()` -> read the `nativeEl` property
  instead (`dist/api/QInput.json`, `dist/api/QFile.json`).
- `quasar/wrappers` imports -> `#q-app/wrappers` (deprecated since
  `@quasar/app-vite` v2 / `@quasar/app-webpack` v4, `wrappers/index.js:9-16`).
- v2.17 note corrected by the current API: the QSelect prop is
  `disable-tab-selection` (not `disable-tab-select`).

## Staying current

`dist/transforms/api-list.json` names every API descriptor; scan
`node_modules/quasar/dist/api/*.json` for `addedIn` values above your floor
version before using a newer member. Release index:
https://github.com/quasarframework/quasar/releases
