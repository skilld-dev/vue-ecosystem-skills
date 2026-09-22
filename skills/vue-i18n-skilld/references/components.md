# Components

`i18n-t`, `i18n-n`, `i18n-d` ship with vue-i18n and register globally at `app.use` time unless `globalInstall: false` (dist/vue-i18n.d.ts:1810-1822). Programmatic names: `Translation` (I18nT), `NumberFormat` (I18nN), `DatetimeFormat` (I18nD) (dist/vue-i18n.mjs:2529).

## Common base props (`BaseFormatProps`, dist/vue-i18n.d.ts:68-107)

| Prop | Type | Notes |
| --- | --- | --- |
| `tag` | string \| object | Wrapper element; omit for Fragment |
| `locale` | string | Override the scope locale |
| `scope` | `'global' \| 'parent'` | Which scope to use |
| `i18n` | Composer | Explicit composer; takes precedence over `scope` |

## i18n-t (Translation)

Interpolates slot content into placeholders (dist/vue-i18n.d.ts:2031-2043).

Props: `keypath: string` (required), `plural?: number | string`.

```vue
<i18n-t keypath="term" tag="label" for="tos">
  <a href="/tos" target="_blank">{{ $t('tos') }}</a>
</i18n-t>
```

```json
{ "term": "I accept {0}." }
```

Slot names match placeholders: named interpolation `{name}` uses slot `#name`, list interpolation `{0}` uses the default slot. Placeholders without a matching slot render empty.

## i18n-n (NumberFormat)

Props: `value: number` (required), `format: string | Intl.NumberFormatOptions`, plus `BaseFormatProps` (dist/vue-i18n.d.ts:1900).

```vue
<i18n-n :value="1234.15" format="currency"></i18n-n>
```

Scoped slot receives formatted parts (`{ parts }`) for per-part markup (integer, decimal, currency symbol).

## i18n-d (DatetimeFormat)

Props: `value: number | Date` (required), `format: string | Intl.DateTimeFormatOptions`, plus `BaseFormatProps` (dist/vue-i18n.d.ts:1497).

```vue
<i18n-d :value="new Date()" format="long"></i18n-d>
```

Scoped slot receives `{ parts }` (literal text vs day/month/year values).

Named `format` values resolve from the `numberFormats` / `datetimeFormats` options passed to `createI18n` or `useI18n`.

## v-t directive (deprecated)

`v-t` updates `textContent` from a keypath (string or `{ path, locale, args }` object). Deprecated in v11, removed in v12 (dist/vue-i18n.d.ts:2024, 2136-2138). Replace with `t()`, `$t`, or `<i18n-t>`. Lint existing usage with `@intlify/vue-i18n/no-deprecated-v-t` (https://eslint-plugin-vue-i18n.intlify.dev/rules/no-deprecated-v-t.html).

Docs: https://vue-i18n.intlify.dev/guide/advanced/component.html
