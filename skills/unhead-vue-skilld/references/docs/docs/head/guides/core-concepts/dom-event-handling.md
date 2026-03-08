---
title: "Handling DOM Events · Unhead"
meta:
  "og:description": "Handle DOM events with bodyAttrs for window resize, online/offline status, page lifecycle, and print events. Use onload/onerror for stylesheets."
  "og:title": "Handling DOM Events · Unhead"
  description: "Handle DOM events with bodyAttrs for window resize, online/offline status, page lifecycle, and print events. Use onload/onerror for stylesheets."
---

**Core Concepts**

# **Handling DOM Events**

Copy for LLMs

**On this page **

- [What is DOM Event Handling in Unhead?](#what-is-dom-event-handling-in-unhead)
- [How Do I Handle Stylesheet Load Events?](#how-do-i-handle-stylesheet-load-events)
- [How Do I Listen to Window and Document Events?](#how-do-i-listen-to-window-and-document-events)
- [Practical Examples](#practical-examples)
- [What Are the Best Practices for DOM Events?](#what-are-the-best-practices-for-dom-events)
- [When Should I Use DOM Events vs useScript?](#when-should-i-use-dom-events-vs-usescript)
- [Key Takeaways](#key-takeaways)
- [See Also](#see-also)

**Quick Answer:** Use `onload` and `onerror` attributes in your `useHead()` script tags. For advanced event handling, use `useScript()` with `onLoaded()` and `onError()` callbacks. For window/document events, use `bodyAttrs` with event handlers like `onresize` or `ononline`.

## [What is DOM Event Handling in Unhead?](#what-is-dom-event-handling-in-unhead)

Unhead provides support for native DOM event handling, allowing you to attach event listeners to document elements through head management. This feature enables you to execute code in response to various browser events like window resizing, navigation changes, or print events.

This guide focuses on non-script DOM events, particularly those attached to the body element. For script-specific event handling and loading, please refer to the **Loading Scripts** guide which covers the more powerful `useScript()` composable.

## [How Do I Handle Stylesheet Load Events?](#how-do-i-handle-stylesheet-load-events)

For non-script resources like stylesheets, Unhead supports standard HTTP-related events. Use `onload` to detect when a stylesheet has finished loading, and `onerror` to handle failures.

```
import { useHead } from 'unhead'

if (import.meta.client) {
  useHead({
    link: [
      {
        rel: 'stylesheet',
        href: '/assets/critical.css',
        onload: () => {
          console.log('Critical CSS loaded')
          // Load non-critical resources
          loadDeferredResources()
        },
        onerror: () => {
          console.error('Failed to load stylesheet - using fallback styles')
          applyFallbackStyles()
        }
      }
    ]
  })
}
```

Remember that stylesheet events should be wrapped in `if (import.meta.client)` conditionals to ensure they work correctly with SSR.

## [How Do I Listen to Window and Document Events?](#how-do-i-listen-to-window-and-document-events)

Unhead allows you to attach event handlers to the document body through the `bodyAttrs` property. These events effectively let you respond to document and window-level events.

Per the HTML specification, body event handlers are automatically proxied to the `window` object for better browser compatibility.

### [What Body Events Are Supported?](#what-body-events-are-supported)

These events are only supported with `bodyAttrs` and provide access to various browser lifecycle events:

```
import { useHead } from 'unhead'

// Types for body event handlers
interface BodyEvents {
  // Printing events
  onafterprint?: string | ((el: Element) => void) // After print dialog closes
  onbeforeprint?: string | ((el: Element) => void) // Before print dialog opens

  // Page lifecycle events
  onbeforeunload?: string | ((el: Element) => void) // Before page is unloaded
  onload?: string | ((el: Element) => void) // Page finished loading
  onunload?: string | ((el: Element) => void) // Page is being unloaded

  // Navigation events
  onhashchange?: string | ((el: Element) => void) // URL hash has changed
  onpagehide?: string | ((el: Element) => void) // User navigates away
  onpageshow?: string | ((el: Element) => void) // User navigates to page
  onpopstate?: string | ((el: Element) => void) // Window history changes

  // Connection events
  onoffline?: string | ((el: Element) => void) // Browser goes offline
  ononline?: string | ((el: Element) => void) // Browser goes online

  // Other events
  onerror?: string | ((el: Element) => void) // Error occurs
  onmessage?: string | ((el: Element) => void) // Message is received
  onresize?: string | ((el: Element) => void) // Window is resized
  onstorage?: string | ((el: Element) => void) // Web Storage is updated
}
```

Remember that these events should generally be wrapped in `if (import.meta.client)` conditionals to ensure they work properly with server-side rendering.

## [Practical Examples](#practical-examples)

### [How Do I Respond to Window Resize?](#how-do-i-respond-to-window-resize)

Track window size changes and update application state:

```
import { useHead } from 'unhead'

if (import.meta.client) {
  useHead({
    bodyAttrs: {
      onresize: (e) => {
        console.log('Window resized', e)
        // Update responsive state, recalculate layouts, etc.
      }
    }
  })
}
```

### [How Do I Track Page Load Performance?](#how-do-i-track-page-load-performance)

Measure and report page load performance metrics:

```
import { useHead } from 'unhead'

if (import.meta.client) {
  useHead({
    bodyAttrs: {
      onload: () => {
        // Report page load timing data
        if (window.performance) {
          const perfData = window.performance.timing
          const pageLoadTime = perfData.loadEventEnd - perfData.navigationStart
          console.log(\`Page loaded in ${pageLoadTime}ms\`)

          // Send to analytics
          if (window.analytics) {
            window.analytics.track('Page Load Time', {
              milliseconds: pageLoadTime
            })
          }
        }
      }
    }
  })
}
```

### [How Do I Handle Offline/Online Status?](#how-do-i-handle-offlineonline-status)

Notify users when they lose internet connection:

```
import { useHead } from 'unhead'

if (import.meta.client) {
  useHead({
    bodyAttrs: {
      onoffline: () => {
        // Show offline notification
        showNotification('You are currently offline. Some features may be unavailable.')
      },
      ononline: () => {
        // Show back online notification
        showNotification('You are back online!')
        // Resync data if needed
        syncData()
      }
    }
  })
}
```

## [What Are the Best Practices for DOM Events?](#what-are-the-best-practices-for-dom-events)

1. **Always use `if (import.meta.client)`** when working with event handlers to ensure proper hydration```
if (import.meta.client) {
  useHead({
    bodyAttrs: {
      onresize: () => handleResize()
    }
  }) // Critical for event handlers
}
```
2. **Keep event handlers lightweight** to avoid performance issues```
// Good: Lightweight handler that delegates complex logic
if (import.meta.client) {
  useHead({
    bodyAttrs: {
      onresize: () => requestAnimationFrame(recalculateLayout)
    }
  })
}
```
3. **Use `useScript()` for script-related events** rather than direct script event handlers```
// Prefer this approach for scripts
useScript(unheadInstance, {
  src: 'https://example.com/analytics.js',
  onLoaded: api => api.initialize()
})
```
4. **Clean up resources** in event handlers to prevent memory leaks```
if (import.meta.client) {
  useHead({
    bodyAttrs: {
      onload: () => {
        const observer = new ResizeObserver(handleResize)
        observer.observe(document.body)

        // Store cleanup function for framework to use
        return () => observer.disconnect()
      }
    }
  })
}
```

## [When Should I Use DOM Events vs useScript?](#when-should-i-use-dom-events-vs-usescript)

| **Scenario** | **Recommended Approach** |
| --- | --- |
| Script loading and interaction | `useScript()` |
| Window resize handling | DOM events with `bodyAttrs` |
| Page lifecycle events | DOM events with `bodyAttrs` |
| Print events | DOM events with `bodyAttrs` |
| Stylesheet loading | DOM events with `link` tags |
| Online/offline detection | DOM events with `bodyAttrs` |

## [Key Takeaways](#key-takeaways)

- Use `onload` and `onerror` attributes for script events
- Event handlers work in both SSR and CSR contexts
- Prefer `useScript()` for advanced script event handling
- DOM events are automatically cleaned up on component unmount

## [See Also](#see-also)

- **Loading Scripts** - Advanced script loading
- **useScript() API** - Script composable reference
- **useHead() API** - Full API reference

Edit this page

Markdown For LLMs

**Did this page help you? **

**Tag Deduplication** Automatic tag deduplication by key, name, and property. Override layout tags in pages, manage verification tags, and customize merge strategies. **Script Loading** Load external scripts with useScript(). Singleton deduplication, proxy for safe calls, loading triggers, and warmup strategies for performance.

**On this page **

- [What is DOM Event Handling in Unhead?](#what-is-dom-event-handling-in-unhead)
- [How Do I Handle Stylesheet Load Events?](#how-do-i-handle-stylesheet-load-events)
- [How Do I Listen to Window and Document Events?](#how-do-i-listen-to-window-and-document-events)
- [Practical Examples](#practical-examples)
- [What Are the Best Practices for DOM Events?](#what-are-the-best-practices-for-dom-events)
- [When Should I Use DOM Events vs useScript?](#when-should-i-use-dom-events-vs-usescript)
- [Key Takeaways](#key-takeaways)
- [See Also](#see-also)