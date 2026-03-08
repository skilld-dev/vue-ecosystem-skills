---
title: "Script Loading · Unhead"
meta:
  "og:description": "Load external scripts with useScript(). Singleton deduplication, proxy for safe calls, loading triggers, and warmup strategies for performance."
  "og:title": "Script Loading · Unhead"
  description: "Load external scripts with useScript(). Singleton deduplication, proxy for safe calls, loading triggers, and warmup strategies for performance."
---

**Core Concepts**

# **Script Loading**

Copy for LLMs

**On this page **

- [Introduction](#introduction)
- [How does script deduplication work?](#how-does-script-deduplication-work)
- [What are the default script loading settings?](#what-are-the-default-script-loading-settings)
- [How do I call script functions before loading completes?](#how-do-i-call-script-functions-before-loading-completes)
- [How do I control when scripts load?](#how-do-i-control-when-scripts-load)
- [Resource Warmup Strategies](#resource-warmup-strategies)
- [Complete Example](#complete-example)
- [Best Practices](#best-practices)
- [Common Use Cases](#common-use-cases)
- [Key Takeaways](#key-takeaways)

## [Introduction](#introduction)

The `useScript` composable provides a powerful way to load and manage external scripts in your application. Built on top of `useHead()`, it offers advanced features for script loading, performance optimization, and safe script interaction.

**Quick Answer:** Use `useScript('https://example.com/script.js')` to load external scripts with automatic singleton behavior, proxy for safe function calls, and configurable loading triggers.

## [How does script deduplication work?](#how-does-script-deduplication-work)

A key feature of `useScript` is its singleton pattern - scripts with the same source or key are only loaded once globally, regardless of how many components request them.

```
import { useScript } from 'unhead'

// In component A
useScript(unheadInstance, 'https://maps.googleapis.com/maps/api/js')

// In component B - reuses the same script instance, doesn't load twice
useScript(unheadInstance, 'https://maps.googleapis.com/maps/api/js')
```

### [Creating Reusable Script Composables](#creating-reusable-script-composables)

For better organization and reuse, wrap script initialization in dedicated composables:

```
// composables/useGoogleMaps.ts
import { useScript } from 'unhead'

export function useGoogleMaps(options = {}) {
  return useScript({
    src: 'https://maps.googleapis.com/maps/api/js',
    key: 'google-maps',
    ...options
  })
}
```

## [What are the default script loading settings?](#what-are-the-default-script-loading-settings)

By default, `useScript` is configured for optimal performance and privacy:

### [Performance Attributes](#performance-attributes)

- Scripts load after hydration by default for better performance
- `async: true` - Load without blocking render
- `defer: true` - Execute in document order after page has loaded
- `fetchpriority: 'low'` - Prioritize other critical resources first

### [Privacy Attributes](#privacy-attributes)

- `crossorigin: 'anonymous'` - Prevent third-party cookie access
- `referrerpolicy: 'no-referrer'` - Block referrer headers to script domain

## [How do I call script functions before loading completes?](#how-do-i-call-script-functions-before-loading-completes)

The `proxy` feature allows you to safely call script functions even before the script has loaded:

```
import { useScript } from 'unhead'

const { proxy } = useScript('https://www.googletagmanager.com/gtag/js')

// Works immediately, even if script hasn't loaded yet
proxy.gtag('event', 'page_view')
```

These function calls are queued and executed once the script loads. If the script fails to load, the calls are silently dropped.

### [Benefits of the Proxy Pattern](#benefits-of-the-proxy-pattern)

- Works during server-side rendering
- Resilient to script blocking (adblockers, etc.)
- Maintains function call order
- Allows script loading anytime without breaking application logic

### [Limitations](#limitations)

- Cannot synchronously get return values from function calls
- May mask loading issues (script failing silently)
- More difficult to debug than direct calls
- Not suitable for all script APIs

When using the proxy pattern, script failures are silent. Always add `.onError()` handlers for critical scripts to catch loading issues.

### [Direct API Access](#direct-api-access)

For direct access to the script's API after loading:

```
import { useScript } from 'unhead'

const { onLoaded } = useScript('https://www.googletagmanager.com/gtag/js')

onLoaded(({ gtag }) => {
  // Direct access to the API after script is loaded
  const result = gtag('event', 'page_view')
  console.log(result)
})
```

## [How do I control when scripts load?](#how-do-i-control-when-scripts-load)

Control when scripts load using triggers:

```
import { useScript } from 'unhead'

// Load after a timeout
useScript(unheadInstance, 'https://example.com/analytics.js', {
  trigger: new Promise(resolve => setTimeout(resolve, 3000))
})

// Load on user interaction
useScript(unheadInstance, 'https://example.com/video-player.js', {
  trigger: (load) => {
    // Only runs on client
    document.querySelector('#video-container')
      ?.addEventListener('click', () => load())
  }
})

// Manual loading (useful for lazy loading)
const { load } = useScript('https://example.com/heavy-library.js', {
  trigger: 'manual'
})

// Load when needed
function handleSpecialFeature() {
  load()
  // Rest of the feature code...
}
```

## [Resource Warmup Strategies](#resource-warmup-strategies)

Optimize loading with resource hints to warm up connections before loading the script:

```
import { useScript } from 'unhead'

useScript(unheadInstance, 'https://example.com/script.js', {
  // Choose a strategy
  warmupStrategy: 'preload' | 'prefetch' | 'preconnect' | 'dns-prefetch'
})
```

### [Strategy Selection Guide](#strategy-selection-guide)

- `preload` - High priority, use for immediately needed scripts
- `prefetch` - Lower priority, use for scripts needed soon
- `preconnect` - Establish early connection, use for third-party domains
- `dns-prefetch` - Lightest option, just resolves DNS
- `false` - Disable warmup entirely
- Function - Dynamic strategy based on conditions

### [Manual Warmup Control](#manual-warmup-control)

For granular control over resource warming:

```
import { useScript } from 'unhead'

const script = useScript('https://example.com/video-player.js', {
  trigger: 'manual'
})

// Add warmup hint when user might need the script
function handleHoverVideo() {
  script.warmup('preconnect')
}

// Load when definitely needed
function handlePlayVideo() {
  script.load()
}
```

## [Complete Example](#complete-example)

```
import { useScript } from 'unhead'

const analytics = useScript({
  src: 'https://example.com/analytics.js',
  key: 'analytics',
  defer: true,
  async: true,
  crossorigin: 'anonymous',
  referrerpolicy: 'no-referrer'
}, {
  warmupStrategy: 'preconnect',
  trigger: new Promise((resolve) => {
    // Load after user has been on page for 3 seconds
    setTimeout(resolve, 3000)
  })
})

// Track page view immediately (queued until script loads)
analytics.proxy.track('pageview')

// Access direct API after script is loaded
analytics.onLoaded(({ track }) => {
  // Do something with direct access
  const result = track('event', { category: 'engagement' })
  console.log('Event tracked:', result)
})

// Handle errors
analytics.onError((error) => {
  console.error('Failed to load analytics:', error)
})
```

## [Best Practices](#best-practices)

For effective script management:

- Use composables to encapsulate script initialization logic
- Consider user privacy when loading third-party scripts
- Use appropriate warmup strategies based on script importance
- Add error handling for critical scripts
- Use triggers to control loading timing for better performance
- Be mindful of proxy limitations for complex script APIs

## [Common Use Cases](#common-use-cases)

### [Google Analytics](#google-analytics)

```
export function useGoogleAnalytics() {
  const script = useScript({
    src: 'https://www.googletagmanager.com/gtag/js',
    defer: true
  })

  // Initialize GA
  script.proxy.gtag('js', new Date())
  script.proxy.gtag('config', 'G-XXXXXXXXXX')

  return {
    ...script,
    trackEvent: (category, action, label) => {
      script.proxy.gtag('event', action, {
        event_category: category,
        event_label: label
      })
    }
  }
}
```

## [Key Takeaways](#key-takeaways)

- Scripts with the same source are loaded once globally (singleton pattern)
- Use the proxy pattern for resilient script calls that work even before loading
- Add `.onError()` handlers for critical scripts to catch loading failures
- Use warmup strategies (`preconnect`, `preload`) to optimize loading performance
- Wrap script initialization in reusable composables for better organization

Edit this page

Markdown For LLMs

**Did this page help you? **

**DOM Event Handling** Handle DOM events with bodyAttrs for window resize, online/offline status, page lifecycle, and print events. Use onload/onerror for stylesheets. **Extending Unhead** Create custom composables and plugins with Unhead's hooks API. Tap into tag resolution, DOM rendering, and SSR lifecycle events.

**On this page **

- [Introduction](#introduction)
- [How does script deduplication work?](#how-does-script-deduplication-work)
- [What are the default script loading settings?](#what-are-the-default-script-loading-settings)
- [How do I call script functions before loading completes?](#how-do-i-call-script-functions-before-loading-completes)
- [How do I control when scripts load?](#how-do-i-control-when-scripts-load)
- [Resource Warmup Strategies](#resource-warmup-strategies)
- [Complete Example](#complete-example)
- [Best Practices](#best-practices)
- [Common Use Cases](#common-use-cases)
- [Key Takeaways](#key-takeaways)