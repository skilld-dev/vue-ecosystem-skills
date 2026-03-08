---
title: "useScript() · Unhead"
meta:
  "og:description": "Load third-party scripts with useScript(). Smart defaults for performance, lazy loading triggers, and API proxying for analytics and widgets."
  "og:title": "useScript() · Unhead"
  description: "Load third-party scripts with useScript(). Smart defaults for performance, lazy loading triggers, and API proxying for analytics and widgets."
---

**Composables**

# **useScript()**

Copy for LLMs

**On this page **

- [Basic Usage](#basic-usage)
- [Smart Defaults](#smart-defaults)
- [Input Options](#input-options)
- [Loading Control](#loading-control)
- [Script Lifecycle](#script-lifecycle)
- [Resource Hints](#resource-hints)
- [API Proxying](#api-proxying)
- [Common Use Cases](#common-use-cases)
- [API Reference](#api-reference)
- [TypeScript](#typescript)
- [Common Mistakes](#common-mistakes)
- [Common Questions](#common-questions)
- [See Also](#see-also)

The `useScript` composable provides an enhanced developer experience for loading third-party scripts with intelligent defaults for performance, security, and lifecycle management.

**Quick Start:**

```
const { proxy, onLoaded } = useScript('https://example.com/analytics.js')

// Call functions immediately (queued until loaded)
proxy.track('pageview')

// Or wait for script to load
onLoaded(() => {
  console.log('Script ready!')
})
```

## [Basic Usage](#basic-usage)

```
import { useScript } from 'unhead'

const { onLoaded } = useScript('https://example.com/script.js')

onLoaded(() => {
  // Script loaded successfully
  console.log('Script is ready to use')
})
```

## [Smart Defaults](#smart-defaults)

A singleton pattern is implemented so scripts with the same `src` or `key` are only loaded once globally. This helps prevent duplicate script loading and ensures consistent initialization.

The following defaults are applied for optimal performance and security:

- Scripts load after hydration by default
- `defer` enabled for proper execution order
- `fetchpriority="low"` to prioritize critical resources
- `crossorigin="anonymous"` prevents cookie access
- `referrerpolicy="no-referrer"` blocks referrer headers

## [Input Options](#input-options)

### [Simple URL](#simple-url)

Pass a URL string for the quickest implementation:

```
import { useScript } from 'unhead'

useScript(unheadInstance, 'https://example.com/script.js')
```

### [Full Configuration](#full-configuration)

Pass an options object to customize any `<script>` attribute:

```
import { useScript } from 'unhead'

useScript(unheadInstance, {
  src: 'https://example.com/script.js',
  id: 'my-script',
  async: true,
  defer: false,
  crossorigin: false, // disable crossorigin='anonymous'
  // Any valid script attribute can be used
})
```

## [Loading Control](#loading-control)

Fine-tune when and how scripts load with the second parameter:

```
import { useScript } from 'unhead'

useScript(unheadInstance, 'https://example.com/script.js', {
  // When to load the script
  trigger: 'client', // | 'server' | Promise | ((load) => void)

  // Resource hint strategy
  warmupStrategy: 'preload', // | 'prefetch' | 'preconnect' | 'dns-prefetch',

  // Access the script's API
  use: () => window.externalAPI
})
```

### [Loading Triggers](#loading-triggers)

Control precisely when scripts load with different trigger strategies:

```
import { useScript } from 'unhead'

// Load immediately on the client (default)
useScript(srcunheadInstance, , { trigger: 'client' })

// Load during server rendering
useScript(srcunheadInstance, , { trigger: 'server' })

// Load when a promise resolves
useScript(srcunheadInstance, , {
  trigger: new Promise(resolve =>
    setTimeout(resolve, 3000)
  )
})

// Custom load function
useScript(srcunheadInstance, , {
  trigger: (load) => {
    document.getElementById('load-button').addEventListener('click', load)
  }
})
```

## [Script Lifecycle](#script-lifecycle)

The script passes through these lifecycle states:

- `awaitingLoad` - Initial state
- `loading` - Script is loading
- `loaded` - Script loaded successfully
- `error` - Script failed to load
- `removed` - Script was removed

Monitor these states with lifecycle hooks:

```
import { useScript } from 'unhead'

const script = useScript('https://example.com/script.js')

script.onLoaded((api) => {
  // Script loaded successfully
  console.log('Script is ready')
})

script.onError(() => {
  // Script failed to load
  console.error('Script loading failed')
})
```

## [Resource Hints](#resource-hints)

The `warmupStrategy` option automatically adds resource hints to optimize loading:

```
import { useScript } from 'unhead'

useScript(unheadInstance, 'https://example.com/script.js', {
  // Preload - highest priority, load ASAP
  warmupStrategy: 'preload',

  // Prefetch - load when browser is idle
  warmupStrategy: 'prefetch',

  // Preconnect - setup connection early
  warmupStrategy: 'preconnect',

  // DNS Prefetch - resolve DNS early
  warmupStrategy: 'dns-prefetch'
})
```

Choose the right strategy based on how critical the script is:

- Use `preload` for essential scripts needed soon after page load
- Use `prefetch` for scripts needed later in the user journey
- Use `preconnect` or `dns-prefetch` to optimize third-party domains

## [API Proxying](#api-proxying)

If you need to access the script's API before it loads, use the `use` option with proxy support:

```
import { useScript } from 'unhead'

const script = useScript({
  src: 'https://maps.googleapis.com/maps/api/js'
}, {
  use: () => window.google.maps
})

// Works before script loads!
const map = script.proxy.Map()
```

The proxy records all calls and replays them once the script is loaded, allowing you to use the API immediately in your code without worrying about loading state.

## [Common Use Cases](#common-use-cases)

### [Google Tag Manager](#google-tag-manager)

```
import { useScript } from 'unhead'

useScript(unheadInstance, {
  src: 'https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX',
  async: true
}, {
  trigger: 'client'
})

// Initialize gtag
useHead(unheadInstance, {
  script: [
    {
      children: \`
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-XXXXXXXXXX');
      \`,
      key: 'gtag-config'
    }
  ]
})
```

### [Loading on User Interaction](#loading-on-user-interaction)

```
import { useScript } from 'unhead'

// Load YouTube player only when user clicks play
useScript(unheadInstance, 'https://www.youtube.com/iframe_api', {
  trigger: (load) => {
    document.getElementById('play-video').addEventListener('click', () => {
      load()
      // Show loading indicator while script is loading
    })
  }
})
```

## [API Reference](#api-reference)

### [Input](#input)

- `src`: String URL or object with script attributes

### [Options](#options)

- `trigger`: When to load the script ('client', 'server', Promise, or custom function)
- `warmupStrategy`: Resource hint strategy ('preload', 'prefetch', 'preconnect', 'dns-prefetch')
- `use`: Function to access the script's API

### [Return Value](#return-value)

Returns a script controller object with these properties:

- `status`: Current lifecycle state
- `onLoaded`: Register callback for successful load
- `onError`: Register callback for loading failure
- `proxy`: Proxy to the script's API (if `use` option provided)

## [TypeScript](#typescript)

Type the script's API with generics:

```
import { useScript } from '@unhead/vue'

interface GoogleMaps {
  Map: new (el: HTMLElement, options: object) => object
  Marker: new (options: object) => object
}

const { proxy } = useScript<GoogleMaps>({
  src: 'https://maps.googleapis.com/maps/api/js'
}, {
  use: () => window.google?.maps as GoogleMaps
})

// proxy is now typed
proxy.Map(document.getElementById('map')!, { zoom: 10 })
```

## [Common Mistakes](#common-mistakes)

### [Not handling script load failures](#not-handling-script-load-failures)

```
// ❌ Assumes script always loads
const { proxy } = useScript('https://cdn.example.com/analytics.js')
proxy.track('pageview') // Fails silently if blocked

// ✅ Handle errors gracefully
const { proxy, onError, status } = useScript('https://cdn.example.com/analytics.js')
onError(() => {
  console.warn('Analytics blocked - falling back to internal tracking')
})
```

### [Loading scripts too eagerly](#loading-scripts-too-eagerly)

```
// ❌ Loads heavy library immediately
useScript(unheadInstance, 'https://cdn.example.com/heavy-widget.js')

// ✅ Defer until needed
useScript(unheadInstance, 'https://cdn.example.com/heavy-widget.js', {
  trigger: (load) => {
    document.getElementById('widget-container')?.addEventListener('mouseenter', load, { once: true })
  },
  warmupStrategy: 'preconnect' // Warm up connection early
})
```

### [Using window globals before script loads](#using-window-globals-before-script-loads)

```
// ❌ Race condition - script may not be loaded
useScript(unheadInstance, 'https://example.com/lib.js')
window.MyLib.init() // TypeError: Cannot read property 'init' of undefined

// ✅ Use proxy or onLoaded
const { proxy, onLoaded } = useScript('https://example.com/lib.js', {
  use: () => window.MyLib
})

// Option 1: Proxy (queues calls)
proxy.init()

// Option 2: Wait for load
onLoaded((lib) => {
  lib.init()
})
```

## [Common Questions](#common-questions)

### [How do I load a script only on user interaction?](#how-do-i-load-a-script-only-on-user-interaction)

Use the `trigger` option with a custom function and call `load()`:

```
const { load } = useScript('heavy-library.js', {
  trigger: (load) => {
    button.onclick = () => load()
  }
})
```

### [Why use proxy instead of direct API calls?](#why-use-proxy-instead-of-direct-api-calls)

The proxy queues calls until the script loads, making your code resilient to loading delays and adblockers.

## [See Also](#see-also)

- **useHead()** - General head management
- **useSeoMeta()** - SEO meta tag management

Edit this page

Markdown For LLMs

**Did this page help you? **

**useSeoMeta()** Add SEO meta tags with useSeoMeta(). Type-safe API for Open Graph, Twitter cards, and 100+ meta tags with automatic property/name handling. **entries:updated** Hook triggered when head entries change. Track title updates, log changes, and react to modifications in your head configuration.

**On this page **

- [Basic Usage](#basic-usage)
- [Smart Defaults](#smart-defaults)
- [Input Options](#input-options)
- [Loading Control](#loading-control)
- [Script Lifecycle](#script-lifecycle)
- [Resource Hints](#resource-hints)
- [API Proxying](#api-proxying)
- [Common Use Cases](#common-use-cases)
- [API Reference](#api-reference)
- [TypeScript](#typescript)
- [Common Mistakes](#common-mistakes)
- [Common Questions](#common-questions)
- [See Also](#see-also)