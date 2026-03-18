---
title: "tags:beforeResolve Hook · Unhead"
meta:
  "og:description": "Hook called before tag resolution. Pre-process tags, add global meta tags, and filter based on environment conditions."
  "og:title": "tags:beforeResolve Hook · Unhead"
  description: "Hook called before tag resolution. Pre-process tags, add global meta tags, and filter based on environment conditions."
---

**Hooks**

# **tags:beforeResolve Hook**

Copy for LLMs

The `tags:beforeResolve` hook is called just before the tag resolution process begins. This hook provides access to all tags that have been collected from entries and allows for bulk modifications before the main resolution process.

## [Lifecycle Position](#lifecycle-position)

This hook runs after `tag:normalise` and before `tags:resolve`.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'tags:beforeResolve': (ctx: TagResolveContext) => HookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | `TagResolveContext` | Context object with the collection of tags |

The `TagResolveContext` interface is defined as:

```
interface TagResolveContext {
  tagMap: Map<string, HeadTag>
  tags: HeadTag[]
}
```

### [Returns](#returns)

`HookResult` which is either `void` or `Promise<void>`

## [Usage Example](#usage-example)

```
import { createHead } from 'unhead'

const head = createHead({
  hooks: {
    'tags:beforeResolve': (ctx) => {
      // Log all tags before resolution
      console.log(\`Processing ${ctx.tags.length} tags before resolution\`)

      // Add a tag that should be included in all pages
      ctx.tags.push({
        tag: 'meta',
        props: {
          name: 'generator',
          content: 'Unhead'
        }
      })
    }
  }
})
```

## [Use Cases](#use-cases)

### [Pre-processing Tags](#pre-processing-tags)

You can use this hook to pre-process tags before the main resolution:

```
import { defineHeadPlugin } from 'unhead'

export const tagsPreprocessPlugin = defineHeadPlugin({
  hooks: {
    'tags:beforeResolve': (ctx) => {
      // Sort tags by priority before resolution
      ctx.tags.sort((a, b) => {
        const aPriority = a.tagPriority === 'high'
          ? 0
          : a.tagPriority === 'critical' ? -1 : 1
        const bPriority = b.tagPriority === 'high'
          ? 0
          : b.tagPriority === 'critical' ? -1 : 1
        return aPriority - bPriority
      })
    }
  }
})
```

### [Adding Global Tags](#adding-global-tags)

This hook is ideal for adding tags that should be present on all pages:

```
import { defineHeadPlugin } from 'unhead'

export const globalTagsPlugin = defineHeadPlugin({
  hooks: {
    'tags:beforeResolve': (ctx) => {
      // Add global meta tags
      const globalTags = [
        {
          tag: 'meta',
          props: {
            charset: 'utf-8'
          }
        },
        {
          tag: 'meta',
          props: {
            name: 'viewport',
            content: 'width=device-width, initial-scale=1'
          }
        },
        {
          tag: 'link',
          props: {
            rel: 'icon',
            href: '/favicon.ico'
          }
        }
      ]

      ctx.tags.push(...globalTags)
    }
  }
})
```

### [Filtering Tags Based on Environment](#filtering-tags-based-on-environment)

Filter or modify tags based on the current environment:

```
import { defineHeadPlugin } from 'unhead'

export const environmentFilterPlugin = defineHeadPlugin((head) => {
  return {
    hooks: {
      'tags:beforeResolve': (ctx) => {
        const isProduction = process.env.NODE_ENV === 'production'

        // Remove development-only tags in production
        if (isProduction) {
          ctx.tags = ctx.tags.filter((tag) => {
            // Remove development-specific meta tags
            if (tag.tag === 'meta' && tag.props.name === 'robots'
              && tag.props.content === 'noindex, nofollow') {
              return false
            }

            // Remove debug scripts
            if (tag.tag === 'script' && tag.props['data-debug']) {
              return false
            }

            return true
          })
        }
      }
    }
  }
})
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**tag:normalise** Hook for processing individual head tags. Apply security attributes, transform tags per environment, and handle custom attributes. **tags:resolve** Main tag resolution hook for deduplication, transformation, and template parameter processing. Modify all tags before rendering.