---
title: "entries:resolve Hook · Unhead"
meta:
  "og:description": "Hook for processing head entries before tag conversion. Add global meta tags, extract analytics data, and modify tag collections."
  "og:title": "entries:resolve Hook · Unhead"
  description: "Hook for processing head entries before tag conversion. Add global meta tags, extract analytics data, and modify tag collections."
---

**Hooks**

# **entries:resolve Hook**

Copy for LLMs

The `entries:resolve` hook is called when head entries need to be resolved into tags. This hook provides access to both the entries and the tags being generated, allowing you to modify or add to the collection before the final tag resolution process.

## [Lifecycle Position](#lifecycle-position)

This hook runs after `entries:updated` and before `entries:normalize`.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'entries:resolve': (ctx: EntryResolveCtx<any>) => HookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | `EntryResolveCtx<any>` | Context containing the entries and tags being processed |

The `EntryResolveCtx` interface is defined as:

```
interface EntryResolveCtx<T> {
  tags: HeadTag[]
  entries: HeadEntry<T>[]
}
```

### [Returns](#returns)

`HookResult` which is either `void` or `Promise<void>`

## [Usage Example](#usage-example)

```
import { createHead } from 'unhead'

const head = createHead({
  hooks: {
    'entries:resolve': (ctx) => {
      // Inspect the entries being processed
      console.log(\`Processing ${ctx.entries.length} head entries\`)

      // You can modify or add to the tags collection
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

### [Adding Global Meta Tags](#adding-global-meta-tags)

Use this hook to add global meta tags that should be present on all pages:

```
import { defineHeadPlugin } from 'unhead'

export const globalMetaPlugin = defineHeadPlugin({
  hooks: {
    'entries:resolve': (ctx) => {
      // Add global meta tags
      ctx.tags.push(
        {
          tag: 'meta',
          props: {
            name: 'author',
            content: 'Your Company'
          }
        },
        {
          tag: 'meta',
          props: {
            property: 'og:site_name',
            content: 'Your Application'
          }
        }
      )
    }
  }
})
```

### [Extracting Information from Entries](#extracting-information-from-entries)

You can use this hook to extract and process information from entries:

```
import { defineHeadPlugin } from 'unhead'

export const analyticsDataPlugin = defineHeadPlugin({
  hooks: {
    'entries:resolve': (ctx) => {
      // Extract all page titles and descriptions for analytics
      const pageData = ctx.entries.reduce((acc, entry) => {
        const input = entry.input
        if (typeof input === 'object') {
          if ('title' in input) {
            acc.title = input.title
          }

          if ('meta' in input && Array.isArray(input.meta)) {
            const descMeta = input.meta.find(m =>
              m.name === 'description' || m.property === 'og:description'
            )
            if (descMeta) {
              acc.description = descMeta.content
            }
          }
        }
        return acc
      }, {})

      // Use the extracted data
      if (!ctx.entries[0].options.ssr) {
        logPageView(pageData)
      }
    }
  }
})

function logPageView(data) {
  // Send data to analytics service
  console.log('Logging page view:', data)
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**entries:updated** Hook triggered when head entries change. Track title updates, log changes, and react to modifications in your head configuration. **entries:normalize** Hook for normalizing individual head entries. Add entry-specific attributes, conditional modifications, and template processing.