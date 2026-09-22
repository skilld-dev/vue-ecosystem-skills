# Migrating v3 to v4

v4 targets Material Design 3. Official guide: https://vuetifyjs.com/getting-started/upgrade-guide/. Migration can be incremental: typography, elevation, grid, and reset all have compat snippets (see [styling.md](./styling.md)).

The Vuetify MCP server automates scanning: `get_v4_breaking_changes` lists all breaking changes, and an agent prompt maps them onto your files (https://vuetifyjs.com/getting-started/upgrade-guide/). eslint-plugin-vuetify flags many v3 usages.

## Styles and tokens

- New precompiled entry points `vuetify/styles/core|colors|utilities`; a settings file that only set `$color-pack: false` or `$utilities: false` can be replaced by `import 'vuetify/styles/core'`.
- Cascade layers everywhere; five layer names replace the single v3 `vuetify` layer.
- CSS reset mostly removed; `button`, `input`, `select` keep native chrome.
- Theme color transparency: `rgba(var(--v-theme-color), .8)` -> `color-mix(in srgb, rgb(var(--v-theme-color)) 80%, transparent)` or `rgb(from rgb(var(--v-theme-color)) / 0.8)`.

## Breakpoints

| Breakpoint | v3 | v4 |
| - | - | - |
| md | 960 | 840 |
| lg | 1280 | 1145 |
| xl | 1920 | 1545 |
| xxl | 2560 | 2138 |

v4 values in `lib/composables/display.js:10`. Restore v3 values via `display.thresholds` (JS) or `$grid-breakpoints` (SASS). `VContainer` max widths also shrank (md 700px, lg 1000px, xl 1400px, xxl 2000px).

## Typography (MD2 -> MD3)

| v3 | v4 |
| - | - |
| `h1`-`h3` | `display-large`, `display-medium`, `display-small` |
| `h4`-`h6` | `headline-large`, `headline-medium`, `headline-small` |
| `subtitle-1`, `body-1` | `body-large` |
| `body-2` | `body-medium` |
| `caption` | `body-small` |
| `button`, `subtitle-2` | `label-large` |
| `overline` | `label-small` |

Applies to `text-*` classes and typography props. Details: https://vuetifyjs.com/getting-started/typography-migration/.

## Elevation

25 levels (0-24) reduced to 6 (0-5): `elevation-0` 0dp, `elevation-1` 1dp, `elevation-2` 3dp, `elevation-3` 6dp, `elevation-4` 8dp, `elevation-5` 12dp (`lib/styles/settings/_elevations.scss:6`). Map old values onto the nearest new level, or restore legacy shadows per https://vuetifyjs.com/getting-started/elevation-migration/.

## Grid (VRow / VCol)

Layout now uses CSS `gap`; VRow gains a `gap` prop accepting number, string, or `[x, y]` (`lib/components/VGrid/VRow.js:154`).

| v3 | v4 |
| - | - |
| `<v-row dense>` | `<v-row density="compact">` or `gap="8"` |
| `align` / `justify` / `align-content` props on VRow | utility classes (`class="align-center justify-space-between"`) |
| `order`, `align-self` props on VCol | utility classes (`class="order-2 align-self-center"`) |
| `.offset-*` classes | `offset` prop (classes renamed `.v-col-offset-*`) |

Responsive variants follow the same pattern: `align-sm="start"` -> `class="align-sm-start"`. Legacy negative-margin mode snippet: [styling.md](./styling.md). `$form-grid-gutter` -> `$grid-density`; `$grid-gutters` removed.

## Components

- VBtn: `text-transform: uppercase` removed by default; restore via `class: 'text-uppercase'` default or `$button-text-transform`. `$button-stacked-icon-margin` -> `$button-stacked-gap`.
- VSelect / VCombobox / VAutocomplete: slot `item` -> `internalItem`; `item` is now an alias of `internalItem.raw`, so `item.raw.name` becomes `item.name`.
- VForm: slot values (`isValid`, `errors`, `isDisabled`, `isReadonly`, `isValidating`, `items`) are unwrapped; drop `.value` in templates.
- VSnackbar: `multi-line` prop removed; use `min-height`.
- VSnackbarQueue: rewritten for multiple simultaneous snackbars; `default` slot renamed `item`.
- VContainer: `fill-height` no longer centers content; add `d-flex align-center flex-wrap`.
- VBadge: `$badge-dot-border-radius` default `4.5px` -> `50%`.
- VCounter: `$counter-color` removed in favor of opacity.
- VFileInput / VRadioGroup / VTextField: `*-details-padding-inline` variables consolidated into `$input-details-padding-inline`.
- Promoted from labs to stable: VCalendar, VHotkey. Still labs: VDateInput, VPicker, VPie, VVideo and others (`lib/labs/components.js:1`).
- VSelect `return-object`, overlay, and other internals unchanged from late v3 unless listed in the official guide.

## Behavior changes

- Default theme is `system` (`lib/composables/theme.js:10`); set `theme: { defaultTheme: 'light' }` to keep v3 behavior.
- Defaults merging skips `undefined` values; `VDefaultsProvider` overrides that used to fall through now do not. Use `null` to force an override.
- Grid CSS variable names: spacing now flows through `--v-col-gap-x` / `--v-col-gap-y` (`lib/components/VGrid/VRow.js:203`).
