# Legacy API mode (deprecated)

Legacy API mode reproduces the vue-i18n v8 API on Vue 3 for migration. Deprecated in v11, removed in v12. Do not start new work here; migrate with https://vue-i18n.intlify.dev/guide/migration/vue3.html.

## What activates it

`createI18n({ legacy: true })` (the default). The `I18n.global` property then returns a `VueI18n` instance instead of a `Composer` (dist/vue-i18n.d.ts:1699), and `I18n.mode` reports `'legacy'` (deprecated, dist/vue-i18n.d.ts:1686-1690).

## Surface still present in 11.4.12

The `VueI18n` interface (dist/vue-i18n.d.ts:2154-2486) mirrors the v8 class: `locale`, `fallbackLocale`, `t`, `d`, `n`, `te`, `tm`, `rt`, `getLocaleMessage`, `setLocaleMessage`, `mergeLocaleMessage`, plus `pluralizationRules` (Legacy name; Composition uses `pluralRules`).

Component globals: `$t`, `$d`, `$n`, `$rt`, `$te`, `$tm`, `$tc` (removed), `$i18n` (the `VueI18nInstance` union, dist/vue-i18n.d.ts:2557).

## Migration moves

1. Set `legacy: false` in `createI18n`.
2. Keep `$t` in templates working with `globalInjection: true` (default) while you convert scripts.
3. Replace Options API `this.$t` / `this.$i18n` with `useI18n()` in `setup`.
4. Replace `pluralizationRules` with `pluralRules`.
5. Drop any `allowComposition` usage (removed in v10).
6. Remove `v-t` directives (also deprecated independently).

## Options API note

Options API components (`this.$t`) imply Legacy mode wiring. Options API without legacy injections: use `useI18n()` inside a `setup()` block; the Composition API works in both script styles.

Docs: https://vue-i18n.intlify.dev/guide/advanced/composition.html#legacy-api-mode, API: https://vue-i18n.intlify.dev/api/legacy.html
