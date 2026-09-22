# Setup and configuration

Sources: prepared package `input/source` (`primevue@5.0.1`), official docs at https://primevue.dev. Config type facts verified against `@primevue/core@5.0.1/config/index.d.ts` (jsdelivr), which `primevue/config` re-exports (`input/source/config/index.mjs`).

## Install

```sh
npm install primevue
```

Runtime dependencies pulled in automatically (`input/source/package.json`): `@primevue/core`, `@primevue/icons` (both 5.0.1, icons deprecated in favor of `@primeicons/vue` ^8.0.0), `@primeuix/styles`, `@primeuix/styled`, `@primeuix/utils`, `@primeuix/motion`, `@primeui/license-manager`.

Entry points (exports map):

- `primevue` root: every component, style, service, composable.
- `primevue/<name>`: single component (e.g. `primevue/datatable`) or module (e.g. `primevue/config`, `primevue/usetoast`).
- `primevue/<name>/style`: design token style class for a component (e.g. `DataTableStyle`).

## Plugin and license

The plugin is required; it is configuration-only and lightweight (https://primevue.dev/vite).

```js
import { createApp } from 'vue';
import PrimeVue from 'primevue/config';
import Aura from '@primeuix/themes/aura';

const app = createApp(App);
app.use(PrimeVue, {
    license: '<PrimeUI license key>',
    theme: { preset: Aura }
});
```

- `license` is a top-level string option on the plugin configuration (declared in `@primevue/core/config` `PrimeVueConfiguration`; the local re-declared interface in `input/source/config/index.d.ts` omits it, trust the core type).
- The license key can be a free Community key or a Commercial key (https://primevue.dev/configuration/).
- Community license eligibility (from `input/source/LICENSE.md`): under $1M USD annual gross revenue, fewer than 5 developers, fewer than 10 employees, under $3M USD outside funding; supports up to 4 developers; requires annual renewal. Individuals, students, non-profits, and non-commercial open source projects qualify.
- Verification is offline, no telemetry, no remote connection. A missing, invalid, or expired key may display a license notice.
- Full license terms: https://primeui.dev/licenses/community and https://primeui.dev/licenses/commercial.

## Configuration options

`PrimeVueConfiguration` (`input/source/config/index.d.ts` and `@primevue/core/config`):

| Option | Type | Notes |
| --- | --- | --- |
| `license` | string | PrimeUI license key |
| `ripple` | boolean | Ripple animation, default false |
| `inputVariant` | `'filled' \| 'outlined'` | Replaces v4's `inputStyle` (removed in v5) |
| `theme` | object | `{ preset, options }` |
| `unstyled` | boolean | Disables built-in style classes |
| `locale` | PrimeVueLocaleOptions | Reactive; second `use()` parameter can init it |
| `pt` | PassThrough | Global per-component passthrough |
| `ptOptions` | PassThroughOptions | `mergeSections` (default true), `mergeProps` (default false) |
| `csp` | `{ nonce }` | Nonce for dynamically generated styles |
| `zIndex` | `{ modal, overlay, menu, tooltip }` | Overlay layering defaults |
| `filterMatchModeOptions` | any | Custom filter match modes |

Filled inputs app-wide: set `inputVariant: 'filled'` in config. Teleported components (Dialog) are not descendants of the app root, so a `.p-variant-filled` class on an ancestor will not reach them; use the config option instead (https://primevue.dev/configuration/).

## Theming

- Presets: Aura, Material, Lara, Nora from `@primeuix/themes` (e.g. `@primeuix/themes/aura`).
- 16px/14px base: standard presets assume a 16px document root. Use `@primeuix/themes/aura-compat` (also `lara-compat`, `material-compat`, `nora-compat`) for legacy 14px roots; compat variants are maintained until June 2027 (https://primevue.dev/theming/styled/).
- Theme options: `prefix` (CSS variable prefix, default `p`), `darkModeSelector` (default `system` = `@media (prefers-color-scheme: dark)`; use a class like `.app-dark` for a toggle; `false`/`none` disables dark mode), `cssLayer` (default false), `cssVariables`.
- Token tiers: primitive, semantic, component. Reserved preset keys that cannot be token names: `primitive`, `semantic`, `components`, `directives`, `colorscheme`, `light`, `dark`, `common`, `root`, `states`, `extend`.
- Customization: `definePreset(preset, tokens)`, scoped per-component tokens via the `dt` prop, runtime `usePreset`, `updatePreset`, `updatePrimaryPalette`, `updateSurfacePalette`, `$dt`, `palette`. `switchTheme` was removed in v5; use `usePreset`.
- Component style classes now import from `@primeuix/styles/<component>` (e.g. `input/source/virtualscroller/style/index.mjs` imports `@primeuix/styles/virtualscroller`).

Dark mode switch example flow: set `darkModeSelector: '.app-dark'`, then toggle that class on `document.documentElement`.

## Unstyled mode

`unstyled: true` globally, or per component with the `unstyled` prop. Components then render no built-in classes; style via the `pt` passthrough with Tailwind or custom CSS (https://primevue.dev/theming/unstyled/).

## Nuxt

Use `@primevue/nuxt-module`; the old `nuxt-primevue` module was removed in v5 (https://primevue.dev/migration/v5/).

## Auto import

`@primevue/auto-import-resolver` with `unplugin-vue-components` registers components on use for tree shaking without manual imports (https://primevue.dev/autoimport/).

## Forms

Advanced form state and validation live in the separate `@primevue/forms` package (`Form`, `FormField`, resolvers; https://primevue.dev/forms/). Components also work with plain `v-model` and the `invalid` prop.

## Icons

- SVG icon components: `@primeicons/vue` (dependency `^8.0.0`, `input/source/package.json`).
- `@primevue/icons` package is deprecated since v5 (removal in v6).
