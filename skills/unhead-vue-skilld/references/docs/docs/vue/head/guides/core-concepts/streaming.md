---
title: "Streaming SSR · Unhead"
meta:
  "og:description": "Stream head tags as async components resolve during Vue SSR"
  "og:title": "Streaming SSR · Unhead"
  description: "Stream head tags as async components resolve during Vue SSR"
---

**Core Concepts**

# **Streaming SSR**

Copy for LLMs

**v3 Only** - Streaming support is only available in Unhead v3 (currently in beta). This API is experimental and may change.

Standard SSR waits for everything to render before sending HTML. Streaming sends the document shell immediately, then streams content as async components resolve.

The problem: async components using `useHead()` set head tags _after_ the initial render. Without streaming support, those tags never reach the client's `<head>`.

Unhead's streaming integration solves this by injecting `<script>` patches into the stream as each Suspense boundary resolves, updating the `<head>` in real-time.

## [How It Works](#how-it-works)

1. **Shell renders** - Initial `<head>` tags render with the document shell
2. **Suspense boundaries resolve** - Async components call `useHead()`
3. **Patches stream** - Unhead injects DOM updates as inline scripts
4. **Client hydrates** - The client head instance picks up the final state

## [Setup](#setup)

### [Vite Plugin](#vite-plugin)

The plugin transforms your components to enable streaming head updates:

```
// vite.config.ts
import { unheadVuePlugin } from '@unhead/vue/stream/vite'
import vue from '@vitejs/plugin-vue'
import { defineConfig } from 'vite'

export default defineConfig({
  plugins: [
    vue(),
    unheadVuePlugin(),
  ],
})
```

### [Server Entry](#server-entry)

```
// entry-server.ts
import { renderToWebStream } from 'vue/server-renderer'
import { createStreamableHead } from '@unhead/vue/stream/server'
import { VueHeadMixin } from '@unhead/vue'
import { createApp } from './main'

export async function render(url: string, template: string) {
  const { app, router } = createApp()
  const { head, wrapStream } = createStreamableHead()

  app.use(head)
  app.mixin(VueHeadMixin)

  router.push(url)
  await router.isReady()

  const vueStream = renderToWebStream(app)
  return wrapStream(vueStream, template)
}
```

### [Client Entry](#client-entry)

```
// entry-client.ts
import { createStreamableHead } from '@unhead/vue/stream/client'
import { createApp } from './main'

const { app, router } = createApp()
const head = createStreamableHead()

app.use(head)

router.isReady().then(() => {
  app.mount('#app')
})
```

## [Usage](#usage)

Use `useHead()` normally in your components. Tags from async components stream automatically as Suspense boundaries resolve:

```
<script setup lang="ts">
const { data } = await useFetch('/api/page')

useHead({
  title: data.value.title,
  meta: [
    { name: 'description', content: data.value.description }
  ]
})
</script>
```

## [When to Skip](#when-to-skip)

If you're not using async components with Suspense, stick with standard SSR. The streaming setup adds complexity for no benefit when all head tags are synchronous.

Edit this page

Markdown For LLMs

**Did this page help you? **

**Pause DOM Rendering** Pause Unhead DOM updates during route transitions. Use dom:beforeRender hook with Vue Suspense for smoother page loads. **Installation** Add Schema.org to Vue apps with @unhead/schema-org. Setup defineWebSite(), defineWebPage() for Google Rich Results.