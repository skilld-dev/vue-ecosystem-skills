---
title: "ssr:render Hook · Unhead"
meta:
  "og:description": "Hook for SSR tag processing. Add server-specific tags, apply i18n, and optimize platform-specific rendering."
  "og:title": "ssr:render Hook · Unhead"
  description: "Hook for SSR tag processing. Add server-specific tags, apply i18n, and optimize platform-specific rendering."
---

**Hooks**

# **ssr:render Hook**

Copy for LLMs

**On this page **

- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)

The `ssr:render` hook is called during the server-side rendering process after tags have been resolved but before they're converted to HTML strings. This hook provides access to the finalized tags and allows for last-minute modifications specific to server-side rendering.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'ssr:render': (ctx: { tags: HeadTag[] }) => SyncHookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | Object | Context object with rendering information |
| `ctx.tags` | `HeadTag[]` | Array of finalized head tags being rendered |

### [Returns](#returns)

`SyncHookResult` which is `void`. This hook is synchronous and cannot be async.

## [Usage Example](#usage-example)

```
import { createHead } from 'unhead'

const head = createHead({
  hooks: {
    'ssr:render': (ctx) => {
      // Log the tags being rendered in SSR
      console.log(\`Rendering ${ctx.tags.length} tags during SSR\`)

      // Add a server-specific meta tag
      ctx.tags.push({
        tag: 'meta',
        props: {
          name: 'ssr-timestamp',
          content: Date.now().toString()
        }
      })
    }
  }
})
```

## [Use Cases](#use-cases)

### [Server-specific Tag Modifications](#server-specific-tag-modifications)

Modify tags specifically for server-side rendering:

```
import { defineHeadPlugin } from 'unhead'

export const ssrTagsPlugin = defineHeadPlugin({
  hooks: {
    'ssr:render': (ctx) => {
      // Add SSR-specific attributes to all tags
      ctx.tags.forEach((tag) => {
        if (tag.props) {
          // Add data attribute to indicate this was rendered on the server
          tag.props['data-ssr'] = 'true'
        }
      })

      // Add server-rendered timestamp
      ctx.tags.push({
        tag: 'meta',
        props: {
          name: 'server-render-time',
          content: new Date().toISOString()
        }
      })

      // Add cache-control meta tag for browsers
      ctx.tags.push({
        tag: 'meta',
        props: {
          'http-equiv': 'Cache-Control',
          'content': 'no-cache, no-store, must-revalidate'
        }
      })
    }
  }
})
```

### [Platform-specific Optimizations](#platform-specific-optimizations)

Apply optimizations based on the server platform:

```
import { defineHeadPlugin } from 'unhead'

export const platformOptimizationPlugin = defineHeadPlugin({
  hooks: {
    'ssr:render': (ctx) => {
      // Add preload hints based on platform capabilities
      const isNodeJS = typeof process !== 'undefined' && process.versions && process.versions.node

      if (isNodeJS) {
        // Modern Node.js - add HTTP/2 Server Push hints through special meta tags
        const criticalResources = [
          { path: '/css/main.css', as: 'style' },
          { path: '/js/main.js', as: 'script' }
        ]

        criticalResources.forEach((resource) => {
          ctx.tags.push({
            tag: 'link',
            props: {
              rel: 'preload',
              href: resource.path,
              as: resource.as,
              crossorigin: resource.as === 'font' ? 'anonymous' : undefined
            }
          })
        })
      }

      // Remove client-only script tags during SSR
      ctx.tags = ctx.tags.filter((tag) => {
        if (tag.tag === 'script' && tag.props.type === 'application/json') {
          // Keep JSON data scripts for hydration
          return true
        }
        if (tag.tag === 'script' && tag.props['data-client-only']) {
          // Remove client-only scripts during SSR
          return false
        }
        return true
      })
    }
  }
})
```

### [Internationalization Support](#internationalization-support)

Handle internationalization (i18n) aspects in server rendering:

```
import { defineHeadPlugin } from 'unhead'

export const i18nSsrPlugin = defineHeadPlugin({
  hooks: {
    'ssr:render': (ctx) => {
      // Get current locale from your i18n system
      const currentLocale = getCurrentLocale() // Your locale detection logic
      const defaultLocale = getDefaultLocale()

      // Find existing language tags
      const htmlLangTag = ctx.tags.find(tag =>
        tag.tag === 'htmlAttrs' && tag.props.lang
      )

      // Update or add language attributes
      if (htmlLangTag) {
        htmlLangTag.props.lang = currentLocale
      }
      else {
        // Add lang attribute to html tag
        ctx.tags.push({
          tag: 'htmlAttrs',
          props: { lang: currentLocale }
        })
      }

      // Add language alternates for SEO
      const supportedLocales = getSupportedLocales() // Your locales list
      const currentPath = getCurrentPath() // Current request path

      supportedLocales.forEach((locale) => {
        // Generate localized URL
        const localizedUrl = generateLocalizedUrl(currentPath, locale)

        // Add hreflang link
        ctx.tags.push({
          tag: 'link',
          props: {
            rel: 'alternate',
            hreflang: locale,
            href: localizedUrl
          }
        })
      })

      // Add x-default hreflang
      ctx.tags.push({
        tag: 'link',
        props: {
          rel: 'alternate',
          hreflang: 'x-default',
          href: generateLocalizedUrl(currentPath, defaultLocale)
        }
      })
    }
  }
})
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**ssr:beforeRender** Hook called before SSR rendering. Control server rendering, set up environment, and optimize performance with caching strategies. **ssr:rendered** Hook called after SSR completes. Post-process HTML output, implement caching, and collect rendering metrics.

**On this page **

- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)