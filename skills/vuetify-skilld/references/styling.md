# Styles and SASS

## JavaScript (precompiled CSS)

| Import | Contents | Rule |
| - | - | - |
| `vuetify/styles` | All-in-one: core, colors, utilities | Default choice |
| `vuetify/styles/core` | Reset, typography, structure | Must be first if used |
| `vuetify/styles/colors` | Material palette classes | Optional |
| `vuetify/styles/utilities` | Layout and spacing helpers | Optional |

Sources: `package.json:61`, `lib/styles/`. With the loader plugin and `styles.configFile` set, `vuetify/styles` redirects to SASS compilation (https://vuetifyjs.com/styles/entry-points/).

## SASS

Requires `sass` installed and the loader plugin:

```js
// vite.config.js
vuetify({ styles: { configFile: 'src/styles/settings.scss' } })
```

```scss
// src/styles/settings.scss
@use 'vuetify/settings' with (
  $utilities: false,                        // drop all utility classes
  $body-font-family: ('Remora Sans', sans-serif), // parentheses required for comma lists
);
```

- `@use 'vuetify'` (SASS) is only for `$utilities`, `$color-pack`, and `$reset` (https://vuetifyjs.com/features/sass-variables/).
- Never `@use 'vuetify/styles'` in SASS: it resolves to precompiled CSS and breaks the build.
- To read variables in component styles, `@forward 'vuetify/settings' with (...)` in your settings file, then `@use './settings'` and reference `settings.$button-height`.
- Selectively disable utilities with `$utilities: ("align-content": false, ...)`; `elevation`, `hidden`, `sr-only`, `pointer-events` are controlled by `$misc`.

## Cascade layers

v4 styles live in five top-level layers: `vuetify-core`, `vuetify-components`, `vuetify-overrides`, `vuetify-utilities`, `vuetify-final`. Any unlayered CSS now beats Vuetify regardless of specificity. Declare your own layer order to interleave:

```css
@layer vuetify-core, base, vuetify-components, vuetify-overrides, overrides, vuetify-utilities, utilities, vuetify-final;
```

Put compatibility and override snippets inside `@layer vuetify-overrides` so they behave like pre-v4 overrides (https://vuetifyjs.com/getting-started/upgrade-guide/).

### Tailwind CSS interop

Give Vuetify styles a dedicated layer with lower precedence than Tailwind's base:

```css
@layer theme, base, vuetify, components, utilities;
@import 'vuetify/styles' layer(vuetify);
@import 'tailwindcss';
```

Source: https://github.com/vuetifyjs/vuetify/discussions/21241.

## Grid legacy mode

v4 grid uses CSS `gap` with no row margins or column padding. To restore v3 negative-margin behavior during migration:

```scss
@layer vuetify-overrides {
  .v-row {
    gap: unset;
    margin: calc(var(--v-col-gap-y) * -.5) calc(var(--v-col-gap-x) * -.5);
  }
  .v-row + .v-row { margin-top: calc(var(--v-col-gap-y) * .5); }
  .v-col {
    padding: calc(var(--v-col-gap-y) * .5) calc(var(--v-col-gap-x) * .5);
    flex-basis: var(--v-col-is-size, calc(100% * var(--v-col-size) / var(--v-col-size-columns))) var(--v-col-is-auto, auto) var(--v-col-is-grow, 0);
  }
  .v-col:where([class*='v-col--offset-']) {
    margin-inline-start: calc(100% * var(--v-col-offset) / var(--v-col-size-columns));
  }
}
```

Internal class renames: `.v-col-{n}` -> `.v-col--cols-{n}`, `.offset-{n}` -> `.v-col--offset-{n}` (https://vuetifyjs.com/getting-started/grid-legacy-mode/).

## CSS reset

The v4 global reset is mostly removed; normalization moved into components. If bare elements gain unwanted spacing, restore selectively:

```css
@layer vuetify-core.reset {
  ul, ol, figure, details, summary { padding: 0; margin: 0; }
  h1, h2, h3, h4, h5, h6 { margin: 0; }
}
```

## Fonts

Roboto is the default font family but is not bundled. Install `@fontsource/roboto` and import the weights you use, or serve it another way (https://vuetifyjs.com/getting-started/installation/).
