---
name: quasar-skilld
description: Build, configure, and debug apps with the Quasar framework (`quasar` npm package, v2.33.1). Use when writing, reviewing, or debugging code that imports "quasar" or "quasar/wrappers", configuring Quasar with Vite, Vitest, Storybook, UMD, or Quasar CLI, styling with Quasar Sass variables, or upgrading between Quasar v2 releases.
---

# Quasar `quasar@2.33.1`

Vue 3 UI framework for SPA, PWA, SSR, SSG, mobile (Cordova/Capacitor) and desktop
(Electron) apps from one codebase. Vue 3 only. ESM package, Node >= 22
(`package.json:102-104`). Baseline for this Skill: quasar 2.33.1 (2026-09-22).

## First: read the docs shipped in the installed package

Quasar 2.33+ bundles its documentation offline. Before guessing an API, look inside
the project's `node_modules/quasar`:

- `dist/api/<Name>.json` — props, slots, events, methods of every component,
  plugin and directive, with `addedIn` version markers. This is the ground truth.
- `dist/mcp/**/*.md` — the quasar.dev pages (components, plugins, directives,
  composables, utils, styling, layout) as Markdown; `dist/mcp/api/<Name>.md`
  holds the same API in compact readable form. `dist/mcp/meta.json` (160 pages,
  `version: 2.33.1`) indexes them all.
- `@quasar/mcp` MCP server serves the same docs to MCP-capable agents.

Details and search commands: [references/offline-docs.md](./references/offline-docs.md)

## Package map

| Entry | Path | Notes |
| --- | --- | --- |
| browser ESM | `dist/quasar.client.js` | default `import` target |
| node/server | `dist/quasar.server.prod.js` | what Node/Vitest resolve without the Vite plugin |
| UMD | `dist/quasar.umd.prod.js` | CDN usage with Vue 3 global build |
| types | `dist/types/index.d.ts` | |
| wrappers | `wrappers/index.js` | no-op typings, deprecated; use `#q-app/wrappers` (`wrappers/index.js:9-16`) |
| lang packs | `lang/*.js` (75) | `import langDe from 'quasar/lang/de'` |
| icon sets | `icon-set/*.js` (44) | `import iconSet from 'quasar/icon-set/material-icons'` |

Full export surface (components, plugins, directives, composables, utils):
[references/api-surface.md](./references/api-surface.md)

## Common tasks

Install with the Vite plugin (`@quasar/vite-plugin` v2 needs Vite 8+,
`@vitejs/plugin-vue` 6+, quasar v2.24+, Node 20.19+; ESM-only;
`dist/mcp/start/vite-plugin.md:10`):

```js
// main.js
import { createApp } from 'vue'
import { Quasar, Notify } from 'quasar'
import '@quasar/extras/material-icons/material-icons.css'
import 'quasar/src/css/index.sass'
import App from './App.vue'

createApp(App).use(Quasar, { plugins: { Notify } }).mount('#app')
```

```js
// vite.config.js
import { quasar, transformAssetUrls } from '@quasar/vite-plugin'
import vue from '@vitejs/plugin-vue'

plugins: [vue({ template: { transformAssetUrls } }), quasar()]
```

Access `$q` in Composition API:

```js
import { useQuasar } from 'quasar'
const $q = useQuasar()
$q.notify('Saved') // $q.platform, $q.dark, $q.screen, $q.lang, ...
```

Templates use kebab-case props exactly as the API JSON lists them
(`hide-dropdown-icon`, `no-error-icon`); two-way props bind as
`v-model:propName` (the v1 `.sync` modifier is gone).

Sass variables: quasar >= 2.14 pairs with `sass-embedded@^1.93.2`; quasar <= 2.13
needs `sass@1.32.12` pinned (`dist/mcp/start/vite-plugin.md:38-39`).

More on Vite, Vitest, Storybook, UMD and Quasar CLI:
[references/installation.md](./references/installation.md)

## Best practices (verified against the 2.33.1 shipped docs)

- Prefer responsive CSS classes (`gt-sm`, `lt-md`, window-width visibility
  classes) over the Screen plugin in JS, for performance.
- Large `QTree`: `no-transition` for big datasets; `virtual-scroll` (v2.25+) for
  huge ones.
- Custom Dialog plugin components: bootstrap with `useDialogPluginComponent`;
  bind `@hide="onDialogHide"` directly (v2.28+ forwards the dismissal reason).
- Prefer `useInterval`/`useTimeout`/`useAnimationFrame` over native timers;
  they auto-cancel on unmount and are SSR-safe no-ops.
- SSR/SSG: avoid `Dark` mode `'auto'` unless the server knows the preference
  (cookie), else users see a light flash.
- Use the LoadingBar plugin instead of a manual `QAjaxBar`.
- Validation for `QInput`: Quasar recommends Regle (`dist/mcp/vue-components/input.md:2397`).
- Quasar CLI projects: import wrappers from `#q-app/wrappers`, never
  `quasar/wrappers`.

Full list with citations: [references/best-practices.md](./references/best-practices.md)

## Upgrading (2.20 -> 2.33.1 highlights)

- v2.33.0: docs + compact API now ship inside the package (offline, exact
  version); pair with the `@quasar/mcp` server. Fixes: `extractDate()` matches
  the longest locale name; QTable rows-per-page selector follows a controlled
  `v-model:pagination`; virtual-scroll `scrollTo()` no longer dropped right
  after a scroll event.
- v2.33.1: QPagination `input` mode clears the typed page on submit
  (`src/components/pagination/QPagination.js:290-292`); `textToRgb()` keeps the
  alpha of `rgb(R, G, B, A)` (`src/utils/colors/colors.js:149-174`).
- v2.28: `QMenu`/`QTooltip` lost the `scroll-target` prop; popups track every
  scrolling container automatically. `Platform.is` dropped `ie`, `edgeChromium`,
  `winphone`, `kindle`, `silk`.
- v2.29: a `@click` listener on `QItem`/`QChip` now implies `clickable`.
- v2.31: readonly fields (`QInput`/`QSelect`/`QFile`/`QField`) now reflect focus
  and validate on blur.
- v2.32: `QImg` renders its `<img>` into SSR HTML when the box shape is known
  (`ratio`/`initial-ratio`/`height`); `ssr-prerender` opts in otherwise.
  `QExpansionItem`/`QTree` no longer wrap content in `QSlideTransition`.
- Deprecated: `QInput`/`QFile` `getNativeElement()` -> use the `nativeEl` property
  (`dist/api/QInput.json`).

No API was added in 2.33.x itself: no `addedIn: v2.33` marker exists in
`dist/api/*.json`. All behavior changes and new APIs, with release URLs:
[references/whats-new.md](./references/whats-new.md)

## Security

The `*-html` boolean props (`options-html`, `display-value-html`, `html` on
Notify/Dialog/Loading) opt into rendering HTML and are an XSS surface: sanitize
before enabling. `QEditor` has no sanitize option; strip `<script>`/`<iframe>`
server-side. Quasar CLI only exposes env variables with the `QCLI_` prefix to
client code.

Checklist: [references/security.md](./references/security.md)
