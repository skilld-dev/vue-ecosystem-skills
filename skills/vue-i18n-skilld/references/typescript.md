# TypeScript

vue-i18n ships its own types (`dist/vue-i18n.d.ts`, package.json:36); no `@types/vue-i18n` install is needed.

## Key completion: pass resources to createI18n

The generic `createI18n` overload infers message keys from the `messages` option, so `i18n.global.t` and typed `Composer` usages check keys as literal paths.

## Global resource schema definitions

Augment the exported `DefineLocaleMessage`, `DefineDateTimeFormat`, `DefineNumberFormat` interfaces (dist/vue-i18n.d.ts:1543, 1571, 1600). `useI18n` then infers keys and format names project-wide without generics:

```ts
// vue-i18n.d.ts
declare module 'vue-i18n' {
  interface DefineLocaleMessage {
    nav: { home: string; settings: string }
  }
  interface DefineDateTimeFormat {
    short: Intl.DateTimeFormatOptions
  }
  interface DefineNumberFormat {
    currency: Intl.NumberFormatOptions
  }
}
```

This is the recommended setup over per-call generics: https://vue-i18n.intlify.dev/guide/advanced/typescript.html

## Generated locale types

Since v10, generated locale type configs plug into inference via `GeneratedTypeConfig` / the `GeneratedLocale` type machinery so tooling can emit locale union types (dist/vue-i18n.d.ts:120, 2557). Release notes: https://github.com/intlify/vue-i18n/blob/master/CHANGELOG.md

## Composer customization

Extend `ComposerCustom` to add members for every `Composer` instance (dist/vue-i18n.d.ts:551-561); `ComposerExtender` hooks lifecycle with a `Disposer` (dist/vue-i18n.d.ts:613, 1603).

## Typed message schema

`createI18n<Schema, Locales>` accepts a schema type param constraining message value types (`string | ResourceNode | VNode`, dist/vue-i18n.d.ts:3171) when messages mix functions or AST resources.

## Module augmentation entry points

Common augmentation targets: `'vue-i18n'` for `ComposerCustom` / `Define*`; `'vue'` for `ComponentCustomProperties` (`$t` and friends on component instances, dist/vue-i18n.d.ts injection docs at https://vue-i18n.intlify.dev/api/injection.html).

Docs: https://vue-i18n.intlify.dev/guide/advanced/typescript.html
