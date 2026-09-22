# Optimization and builds

## Bundle size: tree shaking

The `esm-bundler` builds expose compile-time feature flags (README.md:62-74):

| Flag | Default | Controls |
| --- | --- | --- |
| `__VUE_I18N_FULL_INSTALL__` | `true` | Install components and directives with the plugin |
| `__VUE_I18N_LEGACY_API__` | `true` | Legacy API support; set `false` in Composition-only apps |
| `__INTLIFY_DROP_MESSAGE_COMPILER__` | `false` | Drop the message compiler when all messages are pre-compiled |

Replace with boolean literals (never strings) via Vite `define`, webpack `DefinePlugin`, or `@rollup/plugin-replace`:

```js
// vite.config.js
export default {
  define: {
    __VUE_I18N_FULL_INSTALL__: true,
    __VUE_I18N_LEGACY_API__: false,
    __INTLIFY_DROP_MESSAGE_COMPILER__: true // only with pre-compiled messages
  }
}
```

https://vue-i18n.intlify.dev/guide/advanced/optimization.html#reduce-bundle-size-with-tree-shaking

## Pre-compile messages

`@intlify/unplugin-vue-i18n` compiles locale message resources (JSON / SFC `<i18n>` blocks) at build time. Required for strict CSP (no runtime `eval`/`new Function`) and improves runtime performance. Since v10 the runtime JIT-compiles string messages by default; pre-compiling keeps that off the hot path (https://vue-i18n.intlify.dev/guide/migration/breaking10.html#default-enable-for-jit-compilation).

## Lazy loading locales

```js
export async function loadLocale(i18n, locale) {
  if (i18n.global.availableLocales.includes(locale)) return
  const messages = await import(`./locales/${locale}.json`)
  i18n.global.setLocaleMessage(locale, messages.default)
  // or mergeLocaleMessage to add keys without replacing
}
```

Load in a router guard or locale switcher; keep initial bundle to the default locale. Keep the `html` `lang` attribute in sync on switch. https://vue-i18n.intlify.dev/guide/advanced/lazy.html

## Distribution files

Package exports (package.json:63-83, README.md:5-55):

- Bundlers (Vite, webpack, Rollup): root import resolves `dist/vue-i18n.mjs` (ESM). The JIT compiler is included; pair with `__INTLIFY_DROP_MESSAGE_COMPILER__` when pre-compiled.
- CDN `<script>`: `dist/vue-i18n.global.js` exposes `VueI18n`; `.prod.js` for production; `.runtime.global.js` if messages are pre-compiled.
- Node CJS: `dist/vue-i18n.cjs` (dev) / `vue-i18n.prod.cjs` (prod), auto-selected by `NODE_ENV` via index.js:3-6. CJS is slated for deprecation; prefer `dist/vue-i18n.node.mjs` for ESM Node usage (README.md:55).
- Global builds inline `@intlify/*`: import everything from the single file only.

## SSR notes

- The `v-t` directive required extra SSR settings and is deprecated anyway; avoid it.
- Use the same lazy-load discipline on the server; set response `Accept-Language` handling consistently.
