# Composition API

Core APIs for vue-i18n 11 in Composition API mode (`legacy: false`).

## createI18n

`createI18n(options)` returns an `I18n` instance with `global`, `mode` (deprecated, dist/vue-i18n.d.ts:1686), `install`, and `dispose()` (dist/vue-i18n.d.ts:1679-1711).

Key options (`I18nOptions` = `I18nAdditionalOptions` + `ComposerOptions` + `VueI18nOptions`, dist/vue-i18n.d.ts:1788-1800):

| Option | Type | Default | Notes |
| --- | --- | --- | --- |
| `legacy` | boolean | `true` | Deprecated; set `false` for Composition mode (dist/vue-i18n.d.ts:1728) |
| `locale` | string | `'en-US'` | Messages under this key resolve first |
| `fallbackLocale` | string \| string[] | — | Resolution chain for missing keys |
| `messages` | object | — | Top-level key per locale, nested keys below |
| `datetimeFormats`, `numberFormats` | object | — | Named `Intl` option sets per locale |
| `globalInjection` | boolean | `true` | Injects `$t`, `$d`, `$n`, `$rt` into templates (dist/vue-i18n.d.ts:1735-1746) |
| `missing` | function | — | Handler called on missing key |
| `fallbackWarn`, `missingWarn` | boolean \| RegExp | `true` | Silence or filter console warnings |
| `warnHtmlMessage` | boolean | `true` | Warns when HTML detected in messages |
| `escapeParameter` | boolean | `false` | Escape interpolation params (XSS safeguard) |
| `pluralRules` | object | — | Custom pluralization rules per locale |
| `modifiers` | object | — | Custom linked-message modifiers |
| `messageCompiler` | function | — | Replace the message compiler (dist/vue-i18n.d.ts:1022) |

Install options passed to `app.use(i18n, options)`: `globalInstall` (default `true`) registers `i18n-t`, `i18n-d`, `i18n-n` globally (dist/vue-i18n.d.ts:1810-1822).

## useI18n

`useI18n(options?)` returns a `Composer`. Call it at the top of `setup` / `<script setup>`. Options: everything from `ComposerOptions` plus `useScope` (dist/vue-i18n.d.ts:525-552).

```js
import { useI18n } from 'vue-i18n'

const global = useI18n({ useScope: 'global' }) // reuse the global Composer
const local = useI18n({ messages: { en: { banner: 'local only' } } }) // local scope
```

Scopes (`I18nScope`, dist/vue-i18n.d.ts:1832):

- `global`: the app-wide Composer created by `createI18n`.
- `local`: component-private messages via `useI18n({ messages })`. This is the default when `messages` is passed.
- `parent`: inherit the parent component's scope (SFC `<i18n>` blocks default).
- `isolated`: component-private, no inheritance (Web Components / `I18nInjectionKey` provide pattern).

## Composer members

Reactive state (dist/vue-i18n.d.ts:120-525):

- `locale: WritableComputedRef<Locales>` and `fallbackLocale` — assign `.value` to switch.
- `inheritLocale: boolean` — local scope syncs with global locale changes.
- `availableLocales: Locales[]`, `messages`, `datetimeFormats`, `numberFormats` (ComputedRefs).
- Flags: `missingWarn`, `fallbackWarn`, `fallbackRoot`, `fallbackFormat`, `warnHtmlMessage`, `escapeParameter`.
- `modifiers`, `pluralRules`, `isGlobal`.

Translation:

- `t(key, ...)` — translate with named/list params and optional plural choice.
- `te(key, locale?)` — check a message key exists.
- `tm(key)` — get raw message array/object (plural branches, linked nodes).
- `rt(...)` — resolve what `tm` returned into translated strings.

Formatting: `d(value, key?, locale?)`, `n(value, key?, locale?)`. See [formats](./formats.md).

Message management: `getLocaleMessage`, `setLocaleMessage`, `mergeLocaleMessage`, plus the datetime/number get/set/merge pairs.

Handlers: `getMissingHandler` / `setMissingHandler`, post-translation handlers.

## Locale switching pattern

```js
const { locale } = useI18n({ useScope: 'global' })

async function switchLocale(lang) {
  if (!available.value.includes(lang)) {
    const msgs = await import(`./locales/${lang}.json`)
    i18n.global.setLocaleMessage(lang, msgs.default)
  }
  locale.value = lang
  document.querySelector('html').setAttribute('lang', lang) // accessibility
}
```

Docs: https://vue-i18n.intlify.dev/guide/advanced/composition.html, https://vue-i18n.intlify.dev/guide/essentials/scope.html

## Extending Composer

Third parties extend via `ComposerExtender` and the empty `ComposerCustom` interface (dist/vue-i18n.d.ts:613, 551):

```ts
declare module 'vue-i18n' {
  interface ComposerCustom {
    localeCodes: string[]
  }
}
```
