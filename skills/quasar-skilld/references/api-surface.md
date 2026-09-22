# API surface of quasar@2.33.1

Everything below is exported from the package root (`src/components.js`,
`src/plugins.js`, `src/directives.js`, `src/composables.js`, `src/utils.js`)
unless noted. Verify members against `dist/api/<Name>.json`.

## Components (123)

QAjaxBar QAvatar QBadge QBanner QBar QBreadcrumbs QBreadcrumbsEl QBtn
QBtnDropdown QBtnGroup QBtnToggle QCard QCardActions QCardSection QCarousel
QCarouselControl QCarouselSlide QChatMessage QCheckbox QChip QCircularProgress
QColor QDate QDialog QDrawer QEditor QExpansionItem QFab QFabAction QField QFile
QFooter QForm QFormChildMixin QHeader QIcon QImg QInfiniteScroll QInnerLoading
QInput QIntersection QItem QItemLabel QItemSection QKnob QLayout QLinearProgress
QList QMarkupTable QMenu QNoSsr QOptionGroup QPage QPageContainer QPageScroller
QPageSticky QPagination QParallax QPopupEdit QPopupProxy QPullToRefresh QRadio
QRange QRating QResizeObserver QResponsive QRouteTab QScrollArea QScrollObserver
QSelect QSeparator QSkeleton QSlideItem QSlider QSlideTransition QSpace QSpinner
QSpinnerAudio QSpinnerBall QSpinnerBars QSpinnerBox QSpinnerClock QSpinnerComment
QSpinnerCube QSpinnerDots QSpinnerFacebook QSpinnerGears QSpinnerGrid
QSpinnerHearts QSpinnerHourglass QSpinnerInfinity QSpinnerIos QSpinnerOrbit
QSpinnerOval QSpinnerPie QSpinnerPuff QSpinnerRadio QSpinnerRings QSpinnerTail
QSplitter QStep QStepper QStepperNavigation QTab QTable QTabPanel QTabPanels
QTabs QTd QTh QTime QTimeline QTimelineEntry QToggle QToolbar QToolbarTitle
QTooltip QTr QTree QUploader QUploaderAddTrigger QVideo QVirtualScroll

## Plugins (17)

AddressbarColor AppFullscreen AppVisibility BottomSheet Cookies Dark Dialog
IconSet Lang Loading LoadingBar Meta Notify Platform Screen LocalStorage
SessionStorage

All are installed via `app.use(Quasar, { plugins: { Notify, Dialog } })` and
reach components as `$q.notify`, `$q.dialog`, ... (`injection` key in each
`dist/api/<Name>.json`). The 18th plugin-typed descriptor, `Brand.json`, is
internal (no export, no injection).

## Directives (11)

ClosePopup Intersection Morph Mutation Ripple ScrollFire Scroll TouchHold
TouchPan TouchRepeat TouchSwipe

Use as `v-close-popup`, `v-ripple`, `v-intersection:once`, ...

## Composables (13, `src/composables.js`)

useAnimationFrame useDialogPluginComponent useFormChild useMeta useQuasar
useHydration useId useIntersection useInterval useRenderCache useSplitAttrs
useTick useTimeout

## Utils (24, `src/utils.js`)

clone colors copyToClipboard createMetaMixin createUploaderComponent date
debounce dom EventBus event exportFile extend format frameDebounce getCssVar
is morph openURL patterns runSequentialPromises scroll setCssVar throttle uid
(`noop` is also exported, `src/utils.js:10`.)

Notes proven by the source:

- `colors` exposes `getPaletteColor`; brand color access moved to `getCssVar` /
  `setCssVar` (v2 rename, `src/utils/css-var/`).
- `scroll` exposes `getVerticalScrollPosition`, `setVerticalScrollPosition`,
  `animVerticalScrollTo` (v2 names).
- `date` interval keys use the plural form: `years`, `months`, `days`, `hours`,
  `minutes`, `seconds`, `milliseconds` (`src/utils/date/date.js`; the v1
  singular names were renamed in the v2 upgrade guide).
- `EventBus` is the generic event bus (do not confuse with the framework bus).

## Language packs and icon sets

- 75 language packs: `import lang from 'quasar/lang/<iso-name>'` (`lang/`).
  Since v2.27 three packs report canonical `isoName`s: `ckb` (was `kur-CKB`),
  `my` (was `mm`), `sr-Cyrl` (was `sr-CYR`); old import paths remain as
  deprecated aliases for all of v2.
- 44 icon sets: `import iconSet from 'quasar/icon-set/<name>'` (`icon-set/`).

## The `$q` object

`useQuasar()` (Composition API) or `this.$q` (Options API). Members: `version`,
`platform`, `screen`, `dark`, `lang`, `iconSet`, `cookies`, plus one property
per installed plugin (`dist/mcp/options/the-q-object.md`).

## Tooling assets in the package

- `dist/transforms/auto-import.json` — import name map for auto-import setups
  (PascalCase and kebab-case to component name).
- `dist/transforms/import-map.json` — export name to source file map.
- `dist/transforms/sass-variables.json` — every Sass variable declaration.
- `dist/transforms/loader-asset-urls.json` — tag/attribute map behind the
  `transformAssetUrls` feature of `@quasar/vite-plugin`.
- `dist/transforms/api-list.json` — all 152 API descriptor names.
- `dist/types/` — TypeScript definitions; `quasar/lang` and `quasar/icon-set`
  have typed shims (`dist/types/shim-lang.d.ts`, `shim-icon-set.d.ts`).
