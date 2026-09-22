# Installation and integration (quasar 2.33.1)

## Vite plugin route (existing Vite project)

`@quasar/vite-plugin` v2 offers tree-shaking and Sass variable integration
(`dist/mcp/start/vite-plugin.md`).

Requirements: Vite 8+, `@vitejs/plugin-vue` 6+, quasar v2.24+, Node 20.19+,
ESM-only (`dist/mcp/start/vite-plugin.md:10`). On older stacks use
`@quasar/vite-plugin` v1.x. SSR/SSG builds are NOT supported through this
plugin; only Quasar CLI (Vite) builds them (`dist/mcp/start/vite-plugin.md:18`).

```bash
pnpm add quasar@latest @quasar/extras@latest
pnpm add -D @quasar/vite-plugin@latest sass-embedded@^1.93.2
```

- Sass dependency: quasar >= v2.14 -> `sass-embedded@^1.93.2`; quasar <= v2.13
  -> `sass@1.32.12` exactly pinned (`dist/mcp/start/vite-plugin.md:38-39`).
- Variables file goes through the plugin option, not a plain import
  (`dist/mcp/start/vite-plugin.md:84-95`):

```js
// vite.config.js
import { join } from 'node:path'
import { quasar, transformAssetUrls } from '@quasar/vite-plugin'

quasar({ sassVariables: join(import.meta.dirname, 'src/quasar-variables.sass') })
```

## Vitest

Node resolves `quasar` through its `node` export condition, which points at the
SSR server build; without the plugin Quasar refuses to install with
"The SSR server build was installed without an ssrContext"
(`dist/mcp/start/vite-plugin.md:120-124`).

Keep `quasar()` in the Vite config Vitest uses; add it to a standalone
`vitest.config.js` too:

```js
import { quasar, transformAssetUrls } from '@quasar/vite-plugin'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue({ template: { transformAssetUrls } }), quasar()],
  test: { environment: 'jsdom' }
})
```

Then install Quasar once for every `mount()`:

```js
import { config } from '@vue/test-utils'
import { Quasar } from 'quasar'
config.global.plugins.unshift([Quasar, {}])
```

Quasar CLI projects should prefer the `@quasar/testing-unit-vitest` App
Extension, which wires this up (`dist/mcp/start/vite-plugin.md:150`).

## Storybook

Storybook's own Vite config knows nothing about yours. Add `quasar()` to
`.storybook/main.js` `viteFinal` (Sass variables + package resolution) and
install Quasar in `.storybook/preview.js` `setup()`. Boot files, `build.env`
and non-web modes do not apply inside Storybook
(`dist/mcp/start/vite-plugin.md:159-223`).

## UMD / CDN

Vue 3 global build + Quasar UMD, versions matched (`dist/mcp/start/umd.md`):

```html
<link href="https://cdn.jsdelivr.net/npm/quasar@2.33.1/dist/quasar.prod.css" rel="stylesheet">
<div id="q-app"></div>
<script src="https://cdn.jsdelivr.net/npm/vue@3/dist/vue.global.prod.js"></script>
<script src="https://cdn.jsdelivr.net/npm/quasar@2.33.1/dist/quasar.umd.prod.js"></script>
<script>
  const app = Vue.createApp({ setup () { return {} } })
  app.use(Quasar)
  app.mount('#q-app')
</script>
```

Rules: never self-close Quasar tags (`<q-icon ...></q-icon>`, `umd.md:55`),
keep `<!doctype html>` (`umd.md:53`), with an RTL language pack use the RTL css
variant (`quasar.rtl.prod.css`, `umd.md:54`), and pin the exact versions you
tested (`umd.md:56`).

## Quasar CLI projects

- Full-featured route (`quasar dev`/`build`, SSR/SSG/PWA/Capacitor/Cordova/
  Electron/BEX): https://quasar.dev/start/quasar-cli
- Import boot file / config / SSR wrappers from `#q-app/wrappers`; the
  `quasar/wrappers` exports still exist but are deprecated no-ops kept for
  typings (`wrappers/index.js:9-16`).
- `quasar prepare` (also run by `postinstall`) regenerates
  `.quasar/quasar-user-options.js` (language pack, icon set, plugins, config)
  for tools like Storybook to import (`dist/mcp/start/vite-plugin.md:221`).

## Environment limits

- quasar package itself: Node >= 22 (`package.json:102-104`).
- `@quasar/vite-plugin` v2: Node 20.19+, Vite 8+, plugin-vue 6+, quasar 2.24+.
- `@quasar/mcp` docs server: quasar 2.33+ (pages), `@quasar/app-vite` 3.9+.
- Supported browsers: Baseline Widely Available
  (`dist/mcp/start/browser-support.md`); the 2.28 cleanup removed code obsolete
  under that floor.
