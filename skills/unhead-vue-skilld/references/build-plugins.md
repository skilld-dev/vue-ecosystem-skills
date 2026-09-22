# Build plugins

## Unified bundler entry (3.4.1)

`@unhead/vue/bundler` exports `Unhead(options?)` returning a factory with per-bundler dispatch: `.vite()`, `.webpack()`, `.rspack()`, `.rollup()` (dist/bundler.d.ts:15-19, dependency `@unhead/bundler`).

```ts
// vite.config.ts
import { Unhead } from '@unhead/vue/bundler'
export default defineConfig({ plugins: [...Unhead({ streaming: true }).vite()] })

// Nuxt kit
addBuildPlugin(Unhead({ streaming: true }))
```

`@unhead/vue/vite` exports `Unhead(options?): Plugin[]` directly; it still works but the `/bundler` entry is preferred (dist/vite.d.ts:8-14).

## Options

From the build plugins overview (https://unhead.unjs.io/docs/head/guides/build-plugins/overview):

| Option | Type | Default | Effect |
|---|---|---|---|
| `treeshake` | `object \| false` | enabled | strip server-only composables from the client bundle |
| `transformSeoMeta` | `object \| false` | enabled | rewrite `useSeoMeta()` to `useHead()` (~3kb smaller) |
| `minify` | `object \| false` | disabled | pre-minify static inline script/style |
| `validate` | `boolean` | enabled | inject `ValidatePlugin` in dev for tag warnings |
| `devtools` | `object \| false` | enabled | Vite DevTools inspection (dev only) |
| `filter` | `object` | — | shared include/exclude file filter |
| `sourcemap` | `boolean` | — | sourcemaps for transforms |
| `streaming` | `{ mode }` | disabled | enable streaming SSR wiring (`UnheadVueStreamingOptions`, dist/shared/vue.B_EhRTsW.d.ts:3-11) |

## What the plugin does

- Tree-shakes deprecated server composables (`useServerHead*`) and `useSchemaOrg` calls from client bundles.
- Converts `useSeoMeta()` calls into `useHead()` at build time.
- Streaming mode: wires the client bootstrap (virtual iife module + `transformIndexHtml` head-prepend). Vue needs no source transform; per-chunk head patches are emitted by `wrapStream` on the server as self-deleting inline scripts (dist/shared/vue.B_EhRTsW.d.ts:5-10).
- Dev validation: `ValidatePlugin` warns about missing opt-in plugins and deprecated props in the browser console.

## Webpack / rspack

```ts
import { Unhead } from '@unhead/vue/bundler'
export default { plugins: [Unhead().webpack()] }
```

Nuxt configures everything automatically; do not add the plugin manually in Nuxt.

## ValidatePlugin without the build plugin

```ts
import { ValidatePlugin } from 'unhead/plugins' // also via @unhead/vue/plugins
const head = createHead({ plugins: [ValidatePlugin()] })
```

Warns on: missing `TemplateParamsPlugin` (params render literally), missing `AliasSortingPlugin` (`before:`/`after:` silently ignored), deprecated props (`children`, `hid`, `vmid`, `body: true`), removed `{ mode }` option. Rules are configurable: `ValidatePlugin({ rules: { 'missing-template-params-plugin': 'off' } })`.
