---
title: "ssr:beforeRender Hook · Unhead"
meta:
  "og:description": "Hook called before SSR rendering. Control server rendering, set up environment, and optimize performance with caching strategies."
  "og:title": "ssr:beforeRender Hook · Unhead"
  description: "Hook called before SSR rendering. Control server rendering, set up environment, and optimize performance with caching strategies."
---

**Hooks**

# **ssr:beforeRender Hook**

Copy for LLMs

**On this page **

- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)

The `ssr:beforeRender` hook is called before the server-side rendering process begins. This hook allows you to control whether the SSR rendering should proceed and is a good place to perform any initialization or checks specific to the server environment.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'ssr:beforeRender': (ctx: ShouldRenderContext) => SyncHookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | `ShouldRenderContext` | Context object with rendering control |

The `ShouldRenderContext` interface is defined as:

```
interface ShouldRenderContext {
  shouldRender: boolean
}
```

### [Returns](#returns)

`SyncHookResult` which is `void`. This hook is synchronous and cannot be async.

## [Usage Example](#usage-example)

```
import { createHead } from 'unhead'

const head = createHead({
  hooks: {
    'ssr:beforeRender': (ctx) => {
      // Log SSR rendering intent
      console.log('Preparing for server-side rendering of head tags')

      // You can prevent rendering by setting shouldRender to false
      if (process.env.SKIP_HEAD_RENDERING === 'true') {
        console.log('Skipping head tag rendering based on environment setting')
        ctx.shouldRender = false
      }
    }
  }
})
```

## [Use Cases](#use-cases)

### [Conditional SSR Rendering](#conditional-ssr-rendering)

Control whether SSR rendering should proceed based on server conditions:

```
import { defineHeadPlugin } from 'unhead'

export const conditionalSsrPlugin = defineHeadPlugin({
  hooks: {
    'ssr:beforeRender': (ctx) => {
      // Only render head tags for specific routes or conditions
      const currentRoute = getCurrentRoute() // Your route detection logic

      // Skip head rendering for specific routes (e.g., API endpoints)
      if (currentRoute.startsWith('/api/')) {
        ctx.shouldRender = false
      }

      // Skip head rendering for certain user agents
      const userAgent = getUserAgent() // Your user-agent detection logic
      if (userAgent.includes('Googlebot') || userAgent.includes('crawler')) {
        // For bots, we might use a different rendering strategy
        ctx.shouldRender = false
      }
    }
  }
})
```

### [SSR Environment Setup](#ssr-environment-setup)

Set up the server environment before rendering:

```
import { defineHeadPlugin } from 'unhead'

export const ssrEnvironmentPlugin = defineHeadPlugin({
  hooks: {
    'ssr:beforeRender': () => {
      // Set up globalThis variables or state needed for SSR
      globalThis.__UNHEAD_SSR_ENABLED = true

      // Configure environment-specific settings
      if (process.env.NODE_ENV === 'development') {
        // In development, we might want to add debug information
        globalThis.__UNHEAD_DEBUG = true
      }

      // Prepare rendering context
      globalThis.__UNHEAD_RENDER_CONTEXT = {
        startTime: process.hrtime(),
        renderer: 'node',
        version: process.version
      }
    }
  }
})
```

### [Performance Optimization](#performance-optimization)

Skip unnecessary rendering for performance optimization:

```
import { defineHeadPlugin } from 'unhead'

export const ssrPerformancePlugin = defineHeadPlugin({
  hooks: {
    'ssr:beforeRender': (ctx) => {
      // Cache key based on current request
      const cacheKey = generateCacheKey() // Your cache key generation logic

      // Check if we have a cached version of the head HTML
      if (globalThis.__UNHEAD_CACHE && globalThis.__UNHEAD_CACHE[cacheKey]) {
        // Skip rendering and use cached value later
        ctx.shouldRender = false

        // Store cache key for later retrieval
        globalThis.__UNHEAD_CURRENT_CACHE_KEY = cacheKey

        console.log('Using cached head HTML, skipping rendering')
      }
      else {
        // Prepare to render and cache
        globalThis.__UNHEAD_CURRENT_CACHE_KEY = cacheKey
      }
    }
  }
})
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**dom:beforeRender** Hook called before DOM rendering. Control render timing, prepare the DOM environment, and conditionally prevent head tag updates. **ssr:render** Hook for SSR tag processing. Add server-specific tags, apply i18n, and optimize platform-specific rendering.

**On this page **

- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)