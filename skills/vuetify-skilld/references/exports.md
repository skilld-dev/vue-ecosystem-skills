# Export map

All paths verified against `package.json` `exports` and `lib/` of vuetify@4.0.1.

## JS / TS entry points

| Import | Contents | Source |
| - | - | - |
| `vuetify` | `createVuetify`, `version`, all public composables, types | `lib/framework.js:15` |
| `vuetify/framework` | Same framework entry without styles redirect | `package.json:78` |
| `vuetify/components` | All stable components (dev perf hit) | `lib/components/index.js:1` |
| `vuetify/components/<Name>` | One component group, e.g. `vuetify/components/VList` exports VList, VListGroup, VListItem, VListItemTitle... | `package.json:82` |
| `vuetify/directives` | All directives | `lib/directives/index.js:1` |
| `vuetify/directives/<Name>` | One directive | `package.json:84` |
| `vuetify/labs/components` | All labs components | `lib/labs/components.js:1` |
| `vuetify/labs/<Name>` | One labs component, e.g. `vuetify/labs/VPicker` | `package.json:89` |
| `vuetify/blueprints` | `md1`, `md2`, `md3` | `lib/blueprints/index.js:1` |
| `vuetify/locale` | Each language as a named export (`en`, `de`, `zh-Hans`, ...) | `package.json:85` |
| `vuetify/locale/adapters/*` | `vuetify` (`createVuetifyAdapter`), `vue-i18n` (`createVueI18nAdapter`) | `lib/locale/adapters/` |
| `vuetify/iconsets/*` | Icon presets, see below | `package.json:87` |
| `vuetify/date/adapters/*` | `vuetify` (default, native Date), `string` | `lib/composables/date/adapters/` |
| `vuetify/util/colors` | Color constants | `package.json:90` |
| `vuetify/util/transitions` | Transition component factory | `package.json:92` |
| `vuetify/dist/vuetify.js` | Full bundle (also jsdelivr/unpkg entry) | `package.json:93` |
| `vuetify/dist/vuetify-labs.js` | Full bundle including labs | `package.json:98` |

## Stable components (lib/components/index.js:1)

VApp, VAppBar, VAlert, VAutocomplete, VAvatar, VBadge, VBanner, VBottomNavigation, VBottomSheet, VBreadcrumbs, VBtn, VBtnGroup, VBtnToggle, VCalendar, VCard, VCarousel, VCheckbox, VChip, VChipGroup, VCode, VColorPicker, VCombobox, VConfirmEdit, VCounter, VDataIterator, VDataTable, VDatePicker, VDefaultsProvider, VDialog, VDivider, VEmptyState, VExpansionPanel, VFab, VField, VFileInput, VFooter, VForm, VGrid (VContainer, VRow, VCol, VSpacer), VHotkey, VHover, VIcon, VImg, VInfiniteScroll, VInput, VItemGroup, VKbd, VLabel, VLayout, VLazy, VList, VLocaleProvider, VMain, VMenu, VMessages, VNavigationDrawer, VNoSsr, VNumberInput, VOtpInput, VOverlay, VPagination, VParallax, VProgressCircular, VProgressLinear, VRadio, VRadioGroup, VRangeSlider, VRating, VResponsive, VSelect, VSelectionControl, VSelectionControlGroup, VSheet, VSkeletonLoader, VSlideGroup, VSlider, VSnackbar, VSnackbarQueue, VSparkline, VSpeedDial, VStepper, VSwitch, VSystemBar, VTabs, VTable, VTextarea, VTextField, VThemeProvider, VTimeline, VTimePicker, VToolbar, VTooltip, VTreeview, VValidation, VVirtualScroll, VWindow, plus transition components.

Notable v4 facts:

- `VCalendar` and `VHotkey` are stable in v4 (were labs in v3).
- `VSnackbarQueue` is stable.
- `VOverflowBtn` exists as a directory but its export is commented out of the index (`lib/components/index.js:58`); do not use it.

## Labs components (lib/labs/components.js:1)

VAvatarGroup, VColorInput, VCommandPalette, VDateInput, VFileUpload, VIconBtn, VMaskInput, VPicker, VPie, VStepperVertical, VPullToRefresh, VVideo.

- Labs components are alpha quality; breaking changes arrive in patch releases (https://vuetifyjs.com/labs/introduction/).
- `VPie`, `VVideo` are labs only; their exports are commented out of the stable index (`lib/components/index.js:61`, `lib/components/index.js:93`).

## Directives (lib/directives/index.js:1)

`ClickOutside`, `Intersect`, `Mutate`, `Resize`, `Ripple`, `Scroll`, `Touch`, `Tooltip`.

## Iconsets (lib/iconsets/)

`mdi` (default), `mdi-svg`, `mdi-unocss`, `md`, `fa` (FontAwesome 5 webfont), `fa4`, `fa6`, `fa-svg`, `bx` (BoxIcons), `carbon`, `lucide`, `ph` (Phosphor), `ri` (Remix), `tabler`.

CSS font sets need their font stylesheet installed (e.g. `@mdi/font`); `-svg` sets bundle only used SVG paths and need no font package (https://vuetifyjs.com/features/icon-fonts/).

## Styles entry points

| Import | Contents |
| - | - |
| `vuetify/styles` | Precompiled all-in-one CSS |
| `vuetify/styles/core` | Reset, typography, structure; import first |
| `vuetify/styles/colors` | Material palette classes (`text-red`, `bg-blue-darken-1`) |
| `vuetify/styles/utilities` | Helper classes (`d-flex`, `mt-4`, `pa-2`) |
| SASS: `vuetify` / `vuetify/styles` | SASS entry for `$utilities`, `$color-pack`, `$reset` |
| SASS: `vuetify/settings` | All SASS variables |
| SASS: `vuetify/tools` | Mixins and functions |

Sources: `package.json:61`, `package.json:77`, https://vuetifyjs.com/styles/entry-points/. See [styling.md](./styling.md).
