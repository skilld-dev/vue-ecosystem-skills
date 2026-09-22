# createVuetify configuration

`createVuetify(options)` merges `blueprint` underneath explicit options (`lib/framework.js:15`, `mergeDeep(source, target)` gives target priority, `lib/util/helpers.js:250`), creates the defaults, display, theme, icons, locale, date, and goTo services, and returns them alongside `install`/`unmount` (`lib/framework.js:99`).

## defaults

Per-component prop defaults, applied to every instance. `class` and `style` are supported on component keys only, never in `global` (https://vuetifyjs.com/features/global-configuration/).

```js
createVuetify({
  defaults: {
    VBtn: { class: 'text-none', variant: 'outlined' },
    VTextField: { variant: 'filled' },
  },
})
```

- v4: `undefined` values are skipped during merging. To override a global default use `null` (https://vuetifyjs.com/getting-started/upgrade-guide/).
- Scoped overrides in templates: `<VDefaultsProvider :defaults="{ VBtn: { color: 'primary' } }">`.
- Aliases register virtual components; value is the base component, and defaults are keyed by the alias name (https://vuetifyjs.com/features/aliasing/):

```js
import { VBtn } from 'vuetify/components/VBtn'
createVuetify({
  aliases: { MyButton: VBtn },
  defaults: { MyButton: { variant: 'tonal' } },
})
```

Virtual-component classes merge with template classes instead of replacing them (`lib/framework.js:42`).

## theme

Type `ThemeOptions` (`lib/composables/theme.d.ts:7`): `{ cspNonce, defaultTheme, variations, themes, stylesheetId, scope, utilities }` or `false` to disable.

- v4 default is `system`, which follows `prefers-color-scheme` at runtime (`lib/composables/theme.js:10`). Set `defaultTheme: 'light'` to pin one theme.
- Built-in themes: `light`, `dark`, `system`. Custom themes add entries to `themes`.
- Theme colors support transparency in v4; replace `rgba(var(--v-theme-color), 0.8)` with `color-mix(in srgb, rgb(var(--v-theme-color)) 80%, transparent)` or `rgb(from rgb(var(--v-theme-color)) / 0.8)` (https://vuetifyjs.com/getting-started/upgrade-guide/).

```js
createVuetify({
  theme: {
    defaultTheme: 'myTheme',
    themes: {
      myTheme: {
        dark: false,
        colors: {
          background: '#FFFFFF',
          surface: '#FFFFFF',
          primary: '#1867C0',
          secondary: '#48A9A6',
          error: '#B00020', info: '#2196F3', success: '#4CAF50', warning: '#FB8C00',
          // custom colors generate classes and CSS variables automatically
          'brand-accent': '#00ff00',
        },
        variables: { 'border-color': '#000000', 'border-opacity': 0.12 },
      },
    },
  },
})
```

- Standard color keys include `on-*` counterparts (`on-background`, `on-surface`, `on-primary`, ...) (`lib/composables/theme.d.ts:31`).
- `variations: { colors: ['primary'], lighten: 2, darken: 2 }` generates `-lighten-N` / `-darken-N` shades.
- Runtime control via `useTheme()`: `change(name)`, `toggle()`, `cycle([names])` (`lib/composables/theme.d.ts:45`).
- `theme` prop on any component switches theme for its subtree; `<VThemeProvider>` does the same for a section.

## display

```js
createVuetify({
  display: {
    mobileBreakpoint: 'md', // number or breakpoint name
    thresholds: { md: 960, lg: 1280, xl: 1920, xxl: 2560 }, // restore v3 values
  },
})
```

v4 defaults (`lib/composables/display.js:10`): `sm 600, md 840, lg 1145, xl 1545, xxl 2138`. The v3 values above changed in v4; restore them only when matching an existing layout.

## icons

```js
import { aliases, mdi } from 'vuetify/iconsets/mdi-svg'
createVuetify({
  icons: {
    defaultSet: 'mdi', // default value
    aliases,           // maps internal names (prev, next, cancel, ...) to set icons
    sets: { mdi },
  },
})
```

- Webfont sets (`vuetify/iconsets/mdi`) need the font CSS (e.g. `@mdi/font/css/materialdesignicons.css`).
- SVG sets (`vuetify/iconsets/mdi-svg`) import only icons used by Vuetify internals; best for production bundle size.
- Custom aliases: `aliases: { ...aliases, account: mdiAccount }` then `<v-icon icon="$account" />`.
- Icon aliases type covers names like `collapse`, `cancel`, `close`, `prev`, `next`, `loading`, and more (`lib/composables/icons.d.ts:8`).

## date

```js
createVuetify({
  date: {
    // default adapter wraps native Date (lib/composables/date/adapters/vuetify.js)
    adapter: DateFnsAdapter, // from @date-io/date-fns, after installing it
    formats: { weekdayNarrow: { weekday: 'narrow' } }, // Intl options for built-in adapter
    locale: { en: 'en-US' },
  },
})
```

- Built-in adapter formats via `Intl.DateTimeFormat`; custom format keys are registered in `formats` and used with `date.format(value, 'weekdayNarrow')`.
- Any date-io adapter works: `@date-io/date-fns`, `@date-io/dayjs`, `@date-io/luxon`, `@date-io/moment` (https://vuetifyjs.com/features/dates/).
- `useDate()` exposes `format`, `parseISO`, `toISO`, `isSameDay`, `addDays`, `getWeekArray`, and the rest of the adapter surface (`lib/composables/date/date.d.ts:23`).

## locale

```js
createVuetify({
  locale: {
    locale: 'en',       // active language
    fallback: 'en',
    messages: { ... },  // merged over vuetify/locale/<lang>
    rtl: { ar: true },  // right-to-left languages
  },
})
```

- 42+ languages ship as named exports of `vuetify/locale` (`README.md:155`).
- vue-i18n integration: `createVueI18nAdapter({ i18n, useI18n })` from `vuetify/locale/adapters/vue-i18n` (`lib/locale/adapters/vue-i18n.js`).
- Wrap sections with `<VLocaleProvider>` for scoped language/RTL.

## blueprint

```js
import { md2 } from 'vuetify/blueprints'
createVuetify({ blueprint: md2, theme: { defaultTheme: 'light' } })
```

md1/md2/md3 preset component defaults, colors, and typography for their Material Design generation (`lib/blueprints/index.js:1`). Explicit options win over the blueprint. Blueprints require utility classes to be enabled (https://vuetifyjs.com/features/blueprints/).

## ssr and goTo

- `ssr: true` in Nuxt or other SSR frameworks; Vuetify then patches `app.mount` to refresh display metrics (`lib/framework.js:62`).
- `goTo` customizes `useGoTo()` scrolling defaults (duration, easing).
