---
title: "entries:normalize Hook · Unhead"
meta:
  "og:description": "Hook for normalizing individual head entries. Add entry-specific attributes, conditional modifications, and template processing."
  "og:title": "entries:normalize Hook · Unhead"
  description: "Hook for normalizing individual head entries. Add entry-specific attributes, conditional modifications, and template processing."
---

**Hooks**

# **entries:normalize Hook**

Copy for LLMs

**On this page **

- [Lifecycle Position](#lifecycle-position)
- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)

The `entries:normalize` hook is called for each entry when it's being normalized into tags. This hook gives you access to the tags generated from a specific entry, allowing you to transform, add, or remove tags on a per-entry basis.

## [Lifecycle Position](#lifecycle-position)

This hook runs after `entries:resolve` and before `tag:normalise`.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'entries:normalize': (ctx: { tags: HeadTag[], entry: HeadEntry<any> }) => HookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | Object | Context containing the tags and the entry being processed |
| `ctx.tags` | `HeadTag[]` | Array of tags generated from the entry |
| `ctx.entry` | `HeadEntry<any>` | The head entry being normalized |

### [Returns](#returns)

`HookResult` which is either `void` or `Promise<void>`

## [Usage Example](#usage-example)

```
import { createHead } from 'unhead'

const head = createHead({
  hooks: {
    'entries:normalize': (ctx) => {
      // Log the entry being normalized
      console.log('Normalizing entry:', ctx.entry._i)

      // Modify tags from this specific entry
      ctx.tags.forEach((tag) => {
        if (tag.tag === 'meta' && tag.props.name === 'description') {
          // Modify description meta tag content
          tag.props.content += ' (processed by normalize hook)'
        }
      })
    }
  }
})
```

## [Use Cases](#use-cases)

### [Adding Entry-specific Attributes](#adding-entry-specific-attributes)

You can use this hook to add specific attributes based on entry properties:

```
import { defineHeadPlugin } from 'unhead'

export const entrySourcePlugin = defineHeadPlugin({
  hooks: {
    'entries:normalize': (ctx) => {
      // Add a data attribute to all tags from this entry to track source
      ctx.tags.forEach((tag) => {
        if (tag.props && typeof tag.props === 'object') {
          // Store the component or source that created this entry
          tag.props['data-source'] = ctx.entry.options.source || 'unknown'
        }
      })
    }
  }
})
```

### [Conditional Tag Modification](#conditional-tag-modification)

This hook is useful for modifying tags conditionally based on the entry:

```
import { defineHeadPlugin } from 'unhead'

export const developmentInformationPlugin = defineHeadPlugin({
  hooks: {
    'entries:normalize': (ctx) => {
      // Only in development mode
      if (process.env.NODE_ENV === 'development') {
        // Add a custom comment to help with debugging
        ctx.tags.push({
          tag: 'comment',
          textContent: \`Entry ID: ${ctx.entry._i} from ${ctx.entry.options.source || 'unknown'}\`
        })

        // Enhance title tags with entry information
        ctx.tags.forEach((tag) => {
          if (tag.tag === 'title') {
            tag.textContent = \`[DEV] ${tag.textContent}\`
          }
        })
      }
    }
  }
})
```

### [Processing Template Parameters](#processing-template-parameters)

You can use this hook to detect and process template parameters in entries:

```
import { defineHeadPlugin } from 'unhead'

export const templateParamsPlugin = defineHeadPlugin({
  hooks: {
    'entries:normalize': (ctx) => {
      // Extract template parameters from entry
      const params = ctx.tags.find(t => t.tag === 'templateParams')?.props || {}

      if (Object.keys(params).length > 0) {
        // Store params for later processing
        ctx.entry._templateParams = params

        // Remove the templateParams tag as it's not meant for rendering
        ctx.tags = ctx.tags.filter(t => t.tag !== 'templateParams')
      }
    }
  }
})
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**entries:resolve** Hook for processing head entries before tag conversion. Add global meta tags, extract analytics data, and modify tag collections. **tag:normalise** Hook for processing individual head tags. Apply security attributes, transform tags per environment, and handle custom attributes.

**On this page **

- [Lifecycle Position](#lifecycle-position)
- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)