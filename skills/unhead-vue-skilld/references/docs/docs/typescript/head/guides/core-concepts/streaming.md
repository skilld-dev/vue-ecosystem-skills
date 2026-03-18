---
title: "Streaming SSR · Unhead"
meta:
  "og:description": "Stream head tags as async content resolves during server-side rendering"
  "og:title": "Streaming SSR · Unhead"
  description: "Stream head tags as async content resolves during server-side rendering"
---

**Core Concepts**

# **Streaming SSR**

Copy for LLMs

**v3 Only** - Streaming support is only available in Unhead v3 (currently in beta). This API is experimental and may change.

Standard SSR waits for everything to render before sending HTML. Streaming sends the document shell immediately, then streams content as async operations complete.

The problem: when content loads asynchronously during SSR, any head tags set _after_ the initial render never reach the client's `<head>`. The shell has already been sent.

Unhead's streaming integration solves this by injecting `<script>` patches into the stream as content resolves, updating the `<head>` in real-time.

## [How It Works](#how-it-works)

1. **Shell renders** - Initial `<head>` tags render with the document shell
2. **Async content resolves** - New head tags are registered via `head.push()`
3. **Patches stream** - Unhead injects DOM updates as inline scripts
4. **Client hydrates** - The client head instance picks up the final state

## [Setup](#setup)

### [Server](#server)

Use `wrapStream` to inject head updates into your response stream:

```
import { createStreamableHead, wrapStream } from 'unhead/stream/server'

const { head } = createStreamableHead()

head.push({
  title: 'My App',
  htmlAttrs: { lang: 'en' }
})

const template = '<!DOCTYPE html><html><head></head><body></body></html>'

// Wrap your app stream with head injection
const fullStream = wrapStream(head, appStream, template)
return new Response(fullStream)
```

### [Client](#client)

The client automatically processes queued entries from the stream:

```
import { createStreamableHead } from 'unhead/stream/client'

const head = createStreamableHead()
```

## [Manual Stream Control](#manual-stream-control)

For fine-grained control over when head updates are injected, use `renderSSRHeadShell` and `renderSSRHeadSuspenseChunk` directly:

```
import { renderSSRHeadShell, renderSSRHeadSuspenseChunk } from 'unhead/stream/server'

// Render initial shell with current head state
res.write(renderSSRHeadShell(head, template))

// After each async chunk, emit head updates
for await (const chunk of appStream) {
  res.write(chunk)
  const update = renderSSRHeadSuspenseChunk(head)
  if (update)
    res.write(\`<script>${update}</script>\`)
}

res.write('</body></html>')
```

This approach is useful when integrating with custom streaming frameworks or when you need to control exactly when head patches are emitted.

## [Template-Free Integration](#template-free-integration)

For frameworks that construct HTML programmatically (like Nuxt) rather than using an HTML template, use `renderShell` and `createBootstrapScript` directly:

```
import { createBootstrapScript, renderShell, renderSSRHeadSuspenseChunk } from 'unhead/stream/server'

// Render and consume all current head entries atomically
const { headTags, bodyTags, bodyTagsOpen, htmlAttrs, bodyAttrs } = renderShell(head)

// Get the bootstrap script that creates the client-side stream queue
const bootstrap = createBootstrapScript()

// Build shell HTML programmatically
const shell = '<!DOCTYPE html>'
  + \`<html${htmlAttrs ? ' ' + htmlAttrs : ''}>\`
  + \`<head>${bootstrap}${headTags}</head>\`
  + \`<body${bodyAttrs ? ' ' + bodyAttrs : ''}>\`
  + (bodyTagsOpen || '')

res.write(shell)

// Stream app content, injecting head updates between chunks
for await (const chunk of appStream) {
  res.write(chunk)
  const update = renderSSRHeadSuspenseChunk(head)
  if (update)
    res.write(\`<script>${update}</script>\`)
}

// Render any final head entries (e.g. payload scripts added post-render)
const closing = renderShell(head)
res.write(closing.bodyTags + '</body></html>')
```

## [API Reference](#api-reference)

### [createStreamableHead](#createstreamablehead)

Creates a streaming-aware head instance:

```
import { createStreamableHead } from 'unhead/stream/server'

const { head, wrapStream } = createStreamableHead(options?: {
  streamKey?: string  // Custom key for stream identification
})
```

### [wrapStream](#wrapstream)

Wraps a `ReadableStream` with head injection:

```
import { wrapStream } from 'unhead/stream/server'

const wrappedStream = wrapStream(
  head: Unhead,
  stream: ReadableStream<Uint8Array>,
  template: string
): ReadableStream<Uint8Array>
```

### [renderShell](#rendershell)

Renders the current head state and clears entries atomically. Use this instead of manually calling `head.render()` followed by `head.entries.clear()`:

```
import { renderShell } from 'unhead/stream/server'

const { headTags, bodyTags, bodyTagsOpen, htmlAttrs, bodyAttrs } = renderShell(head)
```

### [createBootstrapScript](#createbootstrapscript)

Generates the inline `<script>` tag that creates the streaming queue on the window object. Must run before any streaming updates:

```
import { createBootstrapScript } from 'unhead/stream/server'

const script = createBootstrapScript() // uses default key '__unhead__'
const script2 = createBootstrapScript('myKey') // custom stream key
```

## [When to Skip](#when-to-skip)

If your SSR is fully synchronous (no async data fetching during render), stick with standard SSR. The streaming setup adds complexity for no benefit when all head tags are available at initial render.

Edit this page

Markdown For LLMs

**Did this page help you? **

**Wrapping Composables** Learn how to create custom head composables by wrapping useHead with your own defaults and context management. **Installation** Add Schema.org to TypeScript apps with @unhead/schema-org. Setup defineWebSite(), defineWebPage() for Google Rich Results.