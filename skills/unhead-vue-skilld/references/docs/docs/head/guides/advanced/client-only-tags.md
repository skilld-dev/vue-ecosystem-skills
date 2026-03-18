---
title: "Bundle Optimizations · Unhead"
meta:
  "og:description": "Reduce bundle size with client-only and server-only tags. Use mode option or import.meta guards for SSR/CSR optimization."
  "og:title": "Bundle Optimizations · Unhead"
  description: "Reduce bundle size with client-only and server-only tags. Use mode option or import.meta guards for SSR/CSR optimization."
---

**Advanced**

# **Bundle Optimizations**

Copy for LLMs

**Quick Answer:** To reduce bundle size, use `import.meta.client` to conditionally add tags only on the client. For Vite, use the Unhead Vite plugin to tree-shake server-only code.

Unhead runs on both server and client. You can conditionally render tags in one environment to optimize bundle size.

## [How Do I Add Client-Only Tags?](#how-do-i-add-client-only-tags)

Client-only tags render exclusively in the browser, reducing server-side bundle size.

### [When to Use Client-Only Tags](#when-to-use-client-only-tags)

- Analytics scripts (Google Analytics, Plausible, etc.)
- User tracking and personalization scripts
- Client-side feature detection
- Progressive enhancement

Use `import.meta.client` to conditionally add tags:

```
import { useHead } from 'unhead'

// Using import.meta environment variables
if (import.meta.client) {
  useHead({
    script: [
      {
        src: 'https://example.com/analytics.js',
        defer: true
      }
    ]
  })
}
```

## [How Do I Add Server-Only Tags?](#how-do-i-add-server-only-tags)

Server-only tags render during SSR, reducing client-side bundle size.

### [When to Use Server-Only Tags](#when-to-use-server-only-tags)

- SEO metadata that doesn't need client reactivity
- Open Graph images and social media metadata
- Static metadata that appears on every page
- Schema.org structured data

Use `import.meta.server` to conditionally add tags:

```
import { useHead } from 'unhead'

if (import.meta.server) {
  useHead({
    meta: [
      {
        property: 'og:image',
        content: 'https://example.com/my-image.jpg'
      }
    ]
  })
}
```

## [Example Use Cases](#example-use-cases)

### [Analytics After Hydration](#analytics-after-hydration)

Load analytics only after the application has hydrated:

```
import { useHead } from 'unhead'

if (import.meta.client) {
  useHead({
    script: [
      {
        src: 'https://example.com/analytics.js',
        defer: true,
        async: true
      }
    ]
  })
}
```

### [Static SEO Tags on Server](#static-seo-tags-on-server)

Add SEO metadata that doesn't need client updates:

```
import { useHead } from 'unhead'

if (import.meta.server) {
  useHead({
    meta: [
      { name: 'robots', content: 'index, follow' },
      { name: 'description', content: 'Site description' }
    ]
  })
}
```

## [What Are the Caveats?](#what-are-the-caveats)

Some tags have dependencies that span client and server rendering:

- `titleTemplate` affects `title` rendering - include on both client and server to avoid title flashing
- Tags with `tagPosition` or `tagPriority` may behave differently if not consistently applied
- Event handlers are only triggered in their respective environments

Ensure dependent tags are included in both environments when needed.

## [See Also](#see-also)

- **Tag Positions** - Control tag placement
- **Vite Plugin** - Build-time optimizations
- **useHead() API** - Full API reference

Edit this page

Markdown For LLMs

**Did this page help you? **

**Extending Unhead** Create custom composables and plugins with Unhead's hooks API. Tap into tag resolution, DOM rendering, and SSR lifecycle events. **Build Plugins** Vite and Webpack plugins for Unhead. Tree-shake server composables, transform useSeoMeta, save ~3kb in production bundles.