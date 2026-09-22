# Setup guide

All examples verified against `@unhead/vue` 3.4.1 (`dist/client.d.ts`, `dist/server.d.ts`, `dist/stream/server.d.ts`).

## SPA / client

```ts
// entry-client.ts
import { createHead } from '@unhead/vue/client'
import { createApp } from './main'

const { app } = createApp()
const head = createHead()
app.use(head)
app.mount('#app')
```

`createHead(options?: CreateClientHeadOptions): VueHeadClient` from `@unhead/vue/client` (dist/client.d.ts:10). DOM updates are debounced to the next tick internally (dist/client.mjs `debouncedRenderer`).

## SSR

Server entry creates the instance, the HTTP layer renders tags into the HTML template after Vue finishes:

```ts
// entry-server.ts
import { createHead } from '@unhead/vue/server'
import { renderToString } from 'vue/server-renderer'
import { createApp } from './main'

export async function render(_url: string) {
  const { app } = createApp()
  const head = createHead()
  app.use(head)
  const html = await renderToString(app)
  return { html, head }
}
```

```ts
// server.ts (Node/Express layer)
import { transformHtmlTemplate } from '@unhead/vue/server'

const html = transformHtmlTemplate(
  rendered.head,
  template.replace('<!--app-html-->', rendered.html ?? ''),
)
res.status(200).set({ 'Content-Type': 'text/html' }).send(html)
```

`@unhead/vue/server` also re-exports `renderSSRHead`, `prepareTemplate`, `propsToString`, `PreparedTemplate`, `SSRHeadPayload` (dist/server.d.ts:5). In v3 `renderSSRHead` and `transformHtmlTemplate` are synchronous. The server instance registers the `VueResolver` prop resolver automatically (dist/server.mjs).

Source: https://unhead.unjs.io/docs/vue/head/guides/get-started/installation

## Default tags

Unhead inserts `<meta charset="utf-8">`, `<meta name="viewport" content="width=device-width, initial-scale=1">`, and `<html lang="en">`. Override via `init`, disable via `createHead({ disableDefaults: true })`:

```ts
const head = createHead({
  init: [{ title: 'Default title', titleTemplate: '%s | My Site', htmlAttrs: { lang: 'fr' } }],
})
```

## Streaming SSR

For apps with async components behind Suspense. Vue emits resolved Suspense boundaries in document order, so `wrapStream()` writes each head patch after its app chunk (dist/stream/server.d.ts:28-33).

```ts
// vite.config.ts
import { Unhead } from '@unhead/vue/vite'
export default defineConfig({ plugins: [vue(), Unhead({ streaming: true })] })
```

```ts
// entry-server.ts
import { renderToWebStream } from 'vue/server-renderer'
import { createStreamableHead } from '@unhead/vue/stream/server'
import { VueHeadMixin } from '@unhead/vue'

export async function render(url: string, template: string) {
  const { app, router } = createApp()
  const { head, wrapStream } = createStreamableHead()
  app.use(head)
  app.mixin(VueHeadMixin) // required with streaming so async components register head
  router.push(url)
  await router.isReady()
  return wrapStream(renderToWebStream(app), template)
}
```

```ts
// entry-client.ts
import { createStreamableHead } from '@unhead/vue/stream/client'
const head = createStreamableHead()
app.use(head)
```

Skip streaming when no async components use `useHead()`; it adds complexity for no benefit.
Source: https://unhead.unjs.io/docs/vue/head/guides/core-concepts/streaming

## `<Head>` component

Import from `@unhead/vue/components`. In 3.4.1 it is a single `Head` component that converts child vnodes into a head entry (dist/components.mjs `vnodesToHeadObj`); use plain HTML elements as children:

```vue
<script setup lang="ts">
import { Head } from '@unhead/vue/components'
</script>

<template>
  <Head>
    <title>My awesome site</title>
    <meta name="description" content="My awesome site description">
  </Head>
</template>
```

Child vnodes map to entry keys: `html` -> `htmlAttrs`, `body` -> `bodyAttrs`, others by tag name (`title`, `meta`, `link`, `script`, `style`, `noscript`, `base`). Tag children become `textContent`, except `script` children which become `innerHTML`. Tags are removed when the component unmounts. Prefer `useHead()` for full TypeScript support.
Source: https://unhead.unjs.io/docs/vue/head/guides/core-concepts/components

## Options API

Install `VueHeadMixin` globally (exported from root, `/client`, and `/server`):

```ts
import { createHead, VueHeadMixin } from '@unhead/vue/client'
const head = createHead()
app.use(head)
app.mixin(VueHeadMixin)
```

```vue
<script>
export default {
  data: () => ({ title: 'Hello World' }),
  head() {
    return { title: this.title } // reactive on this; plain object also allowed
  },
}
</script>
```

Source: https://unhead.unjs.io/docs/vue/head/guides/core-concepts/options-api

## Auto-imports (unplugin-auto-import)

```ts
// vite.config.ts
import { unheadVueComposablesImports } from '@unhead/vue'
import AutoImport from 'unplugin-auto-import/vite'

export default defineConfig({
  plugins: [AutoImport({ imports: [unheadVueComposablesImports] })],
})
```

`unheadVueComposablesImports` covers `injectHead`, `useHead`, `useSeoMeta`, `useHeadSafe` (dist/index.d.ts:15).

## Pausing DOM rendering

Useful with `<Suspense>` and route transitions: gate `dom:beforeRender` on a flag, then call `renderDOMHead(head)` (synchronous in v3) to flush.

```ts
import { createHead } from '@unhead/vue/client'
import { renderDOMHead } from 'unhead/client'

const head = createHead()
let pauseDOMUpdates = true
head.hooks.hook('dom:beforeRender', (ctx) => { ctx.shouldRender = !pauseDOMUpdates })

router.beforeEach(() => { pauseDOMUpdates = true })
router.afterEach(() => {
  if (pauseDOMUpdates) {
    pauseDOMUpdates = false
    renderDOMHead(head)
  }
})
```

Source: https://unhead.unjs.io/docs/vue/head/guides/core-concepts/pausing-dom-rendering
