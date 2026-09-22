# Migration

Version-specific changes that affect vue-i18n 11.4.12 code. Changelog (cited, not copied): https://github.com/intlify/vue-i18n/blob/master/CHANGELOG.md

## v11 breaking changes

https://vue-i18n.intlify.dev/guide/migration/breaking11.html

- **Legacy API mode deprecated.** Still functional in v11, removed in v12 (dist/vue-i18n.d.ts:1728). Migrate via https://vue-i18n.intlify.dev/guide/migration/vue3.html.
- **`v-t` directive deprecated.** Removed in v12 (dist/vue-i18n.d.ts:2138). Replace with `t()`, `$t`, or `<i18n-t>`.
- **`tc` and `$tc` dropped.** No trace in the v11 type surface; use `t`/`$t` plural options.

## v10 breaking changes

https://vue-i18n.intlify.dev/guide/migration/breaking10.html

- **JIT message compilation default.** Runtime compiles message strings just in time, solving CSP issues with the old compiler; pre-compile with `@intlify/unplugin-vue-i18n` for strict CSP and performance.
- **`$t` / `t` legacy overloads changed.** Legacy API mode signatures align with Composition API mode; positional plural arguments require the options object form.
- **Modulo `%` interpolation removed.** Use `{name}` named interpolation.
- **`vue-i18n-bridge` dropped.** Vue 2 EOL; Vue 2 projects stay on v8.
- **`allowComposition` option dropped.** Was a v9 Legacy-to-Composition bridge.
- **Generated locale types added.** `GeneratedTypeConfig` supports generated locale type inference.

## v9 changes (from v8)

https://vue-i18n.intlify.dev/guide/migration/breaking.html

- New `createI18n` entry point replaces `new VueI18n()`.
- Composition API mode (`useI18n`) introduced; Legacy API mode emulates v8.
- Custom formatter dropped in favor of message functions and `Intl`.
- `$tc`, `v-t` deprecated (warnings) before their v11 fate.

## v12 removal plan (affects v11 code today)

Do not write new code with: `legacy: true`, the `VueI18n` instance API, `v-t`, `I18n#mode`, `vTDirective`, `Choice` type (all marked `@deprecated will be removed at vue-i18n v12` in dist/vue-i18n.d.ts:1686-3154).

## v8 (Vue 2) quick map

| v8 | v11 |
| --- | --- |
| `new VueI18n({...})` | `createI18n({...})` + `app.use(i18n)` |
| `this.$t` in Options API | `const { t } = useI18n()` |
| `this.$i18n.locale = 'en'` | `locale.value = 'en'` on Composer |
| `%s` interpolation | `{0}` list interpolation |
| `tc` | `t(key, choice, args)` |

https://vue-i18n.intlify.dev/guide/migration/vue2.html
