---
title: "dom:beforeRender Hook · Unhead"
meta:
  "og:description": "Hook called before DOM rendering. Control render timing, prepare the DOM environment, and conditionally prevent head tag updates."
  "og:title": "dom:beforeRender Hook · Unhead"
  description: "Hook called before DOM rendering. Control render timing, prepare the DOM environment, and conditionally prevent head tag updates."
---

**Hooks**

# **dom:beforeRender Hook**

Copy for LLMs

The `dom:beforeRender` hook is called before tags are rendered to the DOM in client-side environments. This hook allows you to control whether rendering should proceed and provides access to rendering context.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'dom:beforeRender': (ctx: DomBeforeRenderCtx) => SyncHookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | `DomBeforeRenderCtx` | Context object with rendering information |

The `DomBeforeRenderCtx` interface extends `ShouldRenderContext`:

```
interface DomBeforeRenderCtx extends ShouldRenderContext {
  tags: HeadTag[]
}

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
    'dom:beforeRender': (ctx) => {
      // Log rendering intent
      console.log('About to render tags to DOM')

      // You can prevent rendering by setting shouldRender to false
      if (window.document.querySelector('meta[name="unhead-rendered"]')) {
        console.log('Preventing re-render as tags are already rendered')
        ctx.shouldRender = false
      }
    }
  }
})
```

## [Use Cases](#use-cases)

### [Conditional Rendering](#conditional-rendering)

Control whether rendering should proceed based on page conditions:

```
import { defineHeadPlugin } from 'unhead'

export const conditionalRenderPlugin = defineHeadPlugin({
  hooks: {
    'dom:beforeRender': (ctx) => {
      // Only render head tags if we're not in a specific context
      if (window.location.pathname.startsWith('/admin')) {
        // For admin pages, we want to prevent automatic rendering
        // because we'll handle it differently
        ctx.shouldRender = false
      }

      // Prevent rendering during specific user interactions
      if (document.body.classList.contains('modal-open')) {
        // Don't update head while modal is open to prevent flickering
        ctx.shouldRender = false
      }
    }
  }
})
```

### [Render Preparation](#render-preparation)

Prepare the DOM environment before rendering:

```
import { defineHeadPlugin } from 'unhead'

export const renderPreparationPlugin = defineHeadPlugin({
  hooks: {
    'dom:beforeRender': () => {
      // Add rendering flag to prevent duplicate processing
      if (!document.querySelector('meta[name="unhead-render-id"]')) {
        const meta = document.createElement('meta')
        meta.setAttribute('name', 'unhead-render-id')
        meta.setAttribute('content', Date.now().toString())
        document.head.appendChild(meta)
      }

      // Clean up specific tags that we always want to manage ourselves
      const existingCanonical = document.querySelector('link[rel="canonical"]')
      if (existingCanonical) {
        existingCanonical.remove()
      }
    }
  }
})
```

### [Delayed Rendering](#delayed-rendering)

Set up delayed rendering for better performance:

```
import { defineHeadPlugin } from 'unhead'

export const delayedRenderPlugin = defineHeadPlugin({
  hooks: {
    'dom:beforeRender': (ctx) => {
      // Check if this is the initial page load
      const isInitialLoad = !document.querySelector('[data-unhead-rendered]')

      if (isInitialLoad) {
        // For initial load, we can delay non-critical head updates
        // until the page has finished loading
        if (document.readyState !== 'complete') {
          // Delay rendering until page is complete
          ctx.shouldRender = false

          // Set up listener to trigger rendering when ready
          window.addEventListener('load', () => {
            // Force head to re-evaluate rendering
            setTimeout(() => {
              head.hooks.callHook('entries:updated', head)
            }, 0)
          }, { once: true })
        }
      }
    }
  }
})
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**tags:afterResolve** Final hook before rendering. Perform security checks, reorder tags for performance, and process content before output. **ssr:beforeRender** Hook called before SSR rendering. Control server rendering, set up environment, and optimize performance with caching strategies.