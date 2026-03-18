---
title: "tags:resolve Hook · Unhead"
meta:
  "og:description": "Main tag resolution hook for deduplication, transformation, and template parameter processing. Modify all tags before rendering."
  "og:title": "tags:resolve Hook · Unhead"
  description: "Main tag resolution hook for deduplication, transformation, and template parameter processing. Modify all tags before rendering."
---

**Hooks**

# **tags:resolve Hook**

Copy for LLMs

The `tags:resolve` hook is one of the most important hooks in Unhead, called during the main tag resolution process. This hook provides access to all collected tags after basic normalization but before final rendering, allowing for comprehensive transformations, deduplication, and other processing.

## [Lifecycle Position](#lifecycle-position)

This hook runs after `tags:beforeResolve` and before `tags:afterResolve`.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'tags:resolve': (ctx: TagResolveContext) => HookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | `TagResolveContext` | Context object with the tag collection |

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
    'tags:resolve': (ctx) => {
      // Inspect all tags during resolution
      console.log(\`Resolving ${ctx.tags.length} tags\`)

      // Process specific tags
      ctx.tags.forEach((tag) => {
        if (tag.tag === 'meta' && tag.props.name === 'description') {
          // Ensure descriptions don't exceed a certain length
          if (tag.props.content && tag.props.content.length > 160) {
            tag.props.content = \`${tag.props.content.substring(0, 157)}...\`
          }
        }
      })
    }
  }
})
```

## [Use Cases](#use-cases)

### [Custom Deduplication Logic](#custom-deduplication-logic)

Implement custom deduplication for specific tag types:

```
import { defineHeadPlugin } from 'unhead'

export const customDedupePlugin = defineHeadPlugin({
  hooks: {
    'tags:resolve': (ctx) => {
      // Custom deduplication for script tags with the same src
      const seenScripts = new Map()

      ctx.tags.forEach((tag) => {
        if (tag.tag === 'script' && tag.props.src) {
          const src = tag.props.src

          if (seenScripts.has(src)) {
            // Keep the script with higher priority or more attributes
            const existing = seenScripts.get(src)
            const existingProps = Object.keys(existing.props).length
            const newProps = Object.keys(tag.props).length

            if (tag.tagPriority === 'critical'
              || (tag.tagPriority === 'high' && existing.tagPriority !== 'critical')
              || (newProps > existingProps && existing.tagPriority === tag.tagPriority)) {
              seenScripts.set(src, tag)
            }
          }
          else {
            seenScripts.set(src, tag)
          }
        }
      })

      // Replace script tags with deduplicated versions
      ctx.tags = ctx.tags.map((tag) => {
        if (tag.tag === 'script' && tag.props.src && seenScripts.has(tag.props.src)) {
          return seenScripts.get(tag.props.src) === tag ? tag : null
        }
        return tag
      }).filter(Boolean)
    }
  }
})
```

### [Transforming Tags Based on Content](#transforming-tags-based-on-content)

Process and transform tags based on their content:

```
import { defineHeadPlugin } from 'unhead'

export const imageOptimizationPlugin = defineHeadPlugin({
  hooks: {
    'tags:resolve': (ctx) => {
      // Find all image-related meta tags
      ctx.tags.forEach((tag) => {
        if (tag.tag === 'meta'
          && (tag.props.property === 'og:image' || tag.props.name === 'twitter:image')) {
          // Process image URLs
          const imageUrl = tag.props.content

          // Skip already processed or external URLs
          if (!imageUrl || imageUrl.startsWith('https://')
            || imageUrl.includes('?processed=true')) {
            return
          }

          // Apply image optimization parameters
          tag.props.content = \`${imageUrl}?processed=true&width=1200&quality=80\`
        }
      })
    }
  }
})
```

### [Implementing Template Parameter Processing](#implementing-template-parameter-processing)

A real-world example of template parameter processing:

```
import { defineHeadPlugin } from 'unhead'

export const templateParamsPlugin = defineHeadPlugin({
  hooks: {
    'tags:resolve': (ctx) => {
      // Extract template parameters
      const templateParamsTag = ctx.tags.find(tag => tag.tag === 'templateParams')

      if (!templateParamsTag)
        return

      // Get parameters
      const params = templateParamsTag.props || {}
      const separator = params.separator || '|'

      // Remove the templateParams tag as it's not meant for rendering
      ctx.tags = ctx.tags.filter(tag => tag.tag !== 'templateParams')

      // Process tags with template parameters
      ctx.tags.forEach((tag) => {
        // Process meta content
        if (tag.tag === 'meta' && tag.props.content
          && typeof tag.props.content === 'string') {
          tag.props.content = processTemplateParams(tag.props.content, params, separator)
        }

        // Process title text
        if (tag.tag === 'title' && tag.textContent) {
          tag.textContent = processTemplateParams(tag.textContent, params, separator)
        }

        // Process other text content
        if (tag.innerHTML && typeof tag.innerHTML === 'string') {
          tag.innerHTML = processTemplateParams(tag.innerHTML, params, separator)
        }
      })
    }
  }
})

// Helper function to process template parameters
function processTemplateParams(text, params, separator) {
  if (!text || typeof text !== 'string')
    return text

  return text.replace(/%(\w+)%/g, (match, key) => {
    return params[key] !== undefined ? params[key] : match
  })
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**tags:beforeResolve** Hook called before tag resolution. Pre-process tags, add global meta tags, and filter based on environment conditions. **tags:afterResolve** Final hook before rendering. Perform security checks, reorder tags for performance, and process content before output.