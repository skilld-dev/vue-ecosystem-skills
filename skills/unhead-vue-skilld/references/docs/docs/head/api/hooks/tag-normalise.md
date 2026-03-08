---
title: "tag:normalise Hook · Unhead"
meta:
  "og:description": "Hook for processing individual head tags. Apply security attributes, transform tags per environment, and handle custom attributes."
  "og:title": "tag:normalise Hook · Unhead"
  description: "Hook for processing individual head tags. Apply security attributes, transform tags per environment, and handle custom attributes."
---

**Hooks**

# **tag:normalise Hook**

Copy for LLMs

**On this page **

- [Lifecycle Position](#lifecycle-position)
- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)

The `tag:normalise` hook is called for each individual tag during the normalization process. This hook gives you access to a single tag, its parent entry, and resolved options, allowing you to apply fine-grained modifications to specific tags.

## [Lifecycle Position](#lifecycle-position)

This hook runs after `entries:normalize` and before `tags:beforeResolve`.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'tag:normalise': (ctx: {
    tag: HeadTag
    entry: HeadEntry<any>
    resolvedOptions: CreateClientHeadOptions
  }) => HookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | Object | Context object containing the tag information |
| `ctx.tag` | `HeadTag` | The head tag being normalized |
| `ctx.entry` | `HeadEntry<any>` | The entry that generated this tag |
| `ctx.resolvedOptions` | `CreateClientHeadOptions` | The resolved options for the head instance |

### [Returns](#returns)

`HookResult` which is either `void` or `Promise<void>`

## [Usage Example](#usage-example)

```
import { createHead } from 'unhead'

const head = createHead({
  hooks: {
    'tag:normalise': (ctx) => {
      const { tag, entry } = ctx

      // Apply specific modifications based on tag type
      if (tag.tag === 'link' && tag.props.rel === 'stylesheet') {
        // Add integrity check to all stylesheets
        tag.props.crossorigin = 'anonymous'
      }

      // Add source information for debugging
      tag._source = entry.options.source || 'unknown'
    }
  }
})
```

## [Use Cases](#use-cases)

### [Fine-tuning Specific Tag Types](#fine-tuning-specific-tag-types)

This hook is ideal for applying modifications to specific types of tags:

```
import { defineHeadPlugin } from 'unhead'

export const scriptSecurityPlugin = defineHeadPlugin({
  hooks: {
    'tag:normalise': (ctx) => {
      const { tag } = ctx

      // Add security attributes to all script tags
      if (tag.tag === 'script' && tag.props.src) {
        // Apply Content Security Policy attributes
        tag.props.crossorigin = 'anonymous'

        // Add nonce for CSP if available
        if (globalThis.SCRIPT_NONCE) {
          tag.props.nonce = globalThis.SCRIPT_NONCE
        }
      }
    }
  }
})
```

### [Tag Transformation Based on Environment](#tag-transformation-based-on-environment)

Transform tags differently based on the environment:

```
import { defineHeadPlugin } from 'unhead'

export const environmentSpecificPlugin = defineHeadPlugin({
  hooks: {
    'tag:normalise': (ctx) => {
      const { tag, resolvedOptions } = ctx
      const isDevelopment = process.env.NODE_ENV === 'development'

      // Handle environment-specific transformations
      if (tag.tag === 'meta' && tag.props.name === 'robots') {
        // Prevent indexing in development or staging environments
        if (isDevelopment || resolvedOptions.environment === 'staging') {
          tag.props.content = 'noindex, nofollow'
        }
      }

      // Add debug information in development
      if (isDevelopment && tag.tag !== 'comment') {
        tag.props['data-dev-info'] = \`Entry: ${ctx.entry._i}\`
      }
    }
  }
})
```

### [Custom Attribute Processing](#custom-attribute-processing)

Process custom attributes that need special handling:

```
import { defineHeadPlugin } from 'unhead'

export const dataAttributeProcessingPlugin = defineHeadPlugin({
  hooks: {
    'tag:normalise': (ctx) => {
      const { tag } = ctx

      // Process data attributes with special formatting
      Object.keys(tag.props).forEach((prop) => {
        if (prop.startsWith('data-')) {
          // Convert camelCase values to kebab-case for data attributes
          if (typeof tag.props[prop] === 'string'
            && tag.props[prop].includes('_')) {
            tag.props[prop] = tag.props[prop]
              .replace(/_([a-z])/g, (_, char) => \`-${char.toLowerCase()}\`)
          }

          // Convert objects to JSON strings for data attributes
          if (typeof tag.props[prop] === 'object' && tag.props[prop] !== null) {
            tag.props[prop] = JSON.stringify(tag.props[prop])
          }
        }
      })
    }
  }
})
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**entries:normalize** Hook for normalizing individual head entries. Add entry-specific attributes, conditional modifications, and template processing. **tags:beforeResolve** Hook called before tag resolution. Pre-process tags, add global meta tags, and filter based on environment conditions.

**On this page **

- [Lifecycle Position](#lifecycle-position)
- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)