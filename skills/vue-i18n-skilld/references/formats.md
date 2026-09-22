# Datetime and number formatting

Formatting wraps `Intl.DateTimeFormat` and `Intl.NumberFormat` and re-rends reactively on locale change.

## Composer functions

```js
const { d, n } = useI18n()

d(value, key?, locale?)   // value: Date | number
n(value, key?, locale?)   // value: number
```

Overloads accept a format options object directly: `d(date, { dateStyle: 'long' })`, `n(0.5, { style: 'percent' })`.

`$d` and `$n` are available in templates when `globalInjection: true`.

## Named formats

Define named option sets per locale:

```js
createI18n({
  legacy: false,
  datetimeFormats: {
    en: { long: { dateStyle: 'long', timeStyle: 'short' } },
    ja: { long: { dateStyle: 'full' } }
  },
  numberFormats: {
    en: { currency: { style: 'currency', currency: 'USD' } },
    ja: { currency: { style: 'currency', currency: 'JPY' } }
  },
  ...
})
```

Then `d(date, 'long')` and `n(price, 'currency')` resolve per active locale. The `Composer` exposes `getDateTimeFormat` / `setDateTimeFormat` / `mergeDateTimeFormat` and the number equivalents for runtime updates (dist/vue-i18n.d.ts:403-473).

## Component usage

`<i18n-d :value="date" format="long">` and `<i18n-n :value="n" format="currency">`; see [components](./components.md).

## Part options

Both `d` and `n` accept a `parts` option (`true`, or an array of part types) so formatting functions return part arrays for custom assembly; supported for `$n` and `$d` since v11.1.4 (dist/vue-i18n.d.ts:562, 623).

## Fallback behavior

If the key or locale is missing, formatting falls back through `fallbackLocale`. If no named format matches, the bare `Intl` default for the locale applies.

Docs: https://vue-i18n.intlify.dev/guide/essentials/datetime.html, https://vue-i18n.intlify.dev/guide/essentials/number.html
