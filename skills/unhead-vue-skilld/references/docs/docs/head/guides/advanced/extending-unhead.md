---
title: "Extending Unhead · Unhead"
meta:
  "og:description": "Create custom composables and plugins with Unhead's hooks API. Tap into tag resolution, DOM rendering, and SSR lifecycle events."
  "og:title": "Extending Unhead · Unhead"
  description: "Create custom composables and plugins with Unhead's hooks API. Tap into tag resolution, DOM rendering, and SSR lifecycle events."
---

**Advanced**

# **Extending Unhead**

Copy for LLMs

## [Introduction](#introduction)

Unhead is designed with extensibility in mind, providing lower-level primitives that can be composed to create powerful functionality. This guide explores how to extend Unhead using hooks and plugins to meet your specific requirements.

## [Understanding the Architecture](#understanding-the-architecture)

Unhead uses a hooks-based architecture powered by **unjs/hookable**, allowing you to tap into different parts of the head tag management lifecycle. This enables you to create custom features without modifying the core library.

### [Hook Execution Sequence](#hook-execution-sequence)

Understanding the order in which hooks are executed is important for creating plugins that work well together. Here is the typical flow:

1. **Entry Processing**:

- `entries:updated`
- `entries:resolve`
- For each entry: `entries:normalize`

1. **Tag Processing**:

- For each tag: `tag:normalise`
- `tags:beforeResolve`
- `tags:resolve`
- `tags:afterResolve`

1. **Client-side Rendering**:

- `dom:beforeRender`

1. **Server-side Rendering**:

- `ssr:beforeRender`
- `ssr:render`
- `ssr:rendered`

1. **Script Management**:

- When applicable: `script:updated`

### [Available Hooks](#available-hooks)

Unhead provides several hooks you can use to extend functionality:

```
import { createHead, useHead } from 'unhead'

const head = createHead({
  hooks: {
    'entries:resolve': (ctx) => {
      // Called when entries need to be resolved to tags
    },
    'tags:resolve': (ctx) => {
      // Called when tags are being resolved for rendering
    },
    'tag:normalise': (ctx) => {
      // Called when a tag is being normalized
    },
    'tag:generated': (ctx) => {
      // Called after a tag has been generated
    }
    // See full list in the API reference
  }
})
```

## [Accessing Head State](#accessing-head-state)

The recommended way to access the head state is through the `resolveTags` function:

```
import { injectHead, useHead } from 'unhead'

const head = injectHead()
const tags = head.resolveTags()

// Now you can inspect or manipulate the tags
console.log(tags)
```

This gives you access to the fully processed tags that would be rendered to the DOM.

## [Creating Custom Composables](#creating-custom-composables)

Unhead's composables like `useHead()` and `useSeoMeta()` are built on top of primitive APIs. You can create your own composables for specific use cases.

### [Example: Creating useTitle Composable](#example-creating-usetitle-composable)

```
import { useHead } from 'unhead'

export function useTitle(title: string, options = {}) {
  return useHead({
    title,
  }, options)
}
```

### [Example: Creating useBodyClass Composable](#example-creating-usebodyclass-composable)

```
import { useHead } from 'unhead'

export function useBodyClass(classes: string | string[]) {
  const classList = Array.isArray(classes) ? classes : [classes]

  return useHead({
    bodyAttrs: {
      class: classList.join(' ')
    }
  })
}
```

## [Building Plugins](#building-plugins)

For more complex extensions, you can create plugins that hook into multiple parts of Unhead's lifecycle.

### [Example: Custom Deduplication Plugin](#example-custom-deduplication-plugin)

```
import { defineHeadPlugin } from 'unhead'

export const customDedupePlugin = defineHeadPlugin({
  hooks: {
    'tags:resolve': (ctx) => {
      // Custom logic to deduplicate tags
      ctx.tags = deduplicateTagsWithCustomLogic(ctx.tags)
    }
  }
})

// Usage
const head = createHead({
  plugins: [
    customDedupePlugin()
  ]
})
```

## [Common Use Cases](#common-use-cases)

### [Example: Tailwind Class Deduplication](#example-tailwind-class-deduplication)

This example shows how to deduplicate Tailwind CSS classes using `tailwind-merge`:

```
import { defineHeadPlugin } from 'unhead'
import { twMerge } from 'tailwind-merge'

export const tailwindMergePlugin = defineHeadPlugin({
  hooks: {
    'tags:resolve': (ctx) => {
      // Find body tags with class attributes
      ctx.tags.forEach((tag) => {
        if (tag.tag === 'bodyAttrs' && tag.props.class) {
          // Deduplicate classes with tailwind-merge
          tag.props.class = twMerge(tag.props.class)
        }
      })
    }
  }
})
```

### [Example: Custom MetaInfo Provider](#example-custom-metainfo-provider)

Create a plugin that pulls meta information from a global store:

```
import { defineHeadPlugin } from 'unhead'

export const storeMetaPlugin = defineHeadPlugin({
  hooks: {
    'entries:resolve': (ctx) => {
      // Add entries from a store
      const storeMetaInfo = getMetaFromStore()
      ctx.entries.push(storeMetaInfo)
    }
  }
})
```

## [Best Practices](#best-practices)

When extending Unhead:

- Keep extensions focused on a single concern
- Use typed hooks for better developer experience
- Document your extensions for team usage
- Consider performance implications in your hooks
- Test extensions with a variety of input cases

## [API Reference](#api-reference)

For a complete list of available hooks and their signatures, refer to the hooks definitions in the source code:

```
// From packages/unhead/src/types/hooks.ts
export interface HeadHooks {
  'entries:updated': (ctx: Unhead<any>) => HookResult
  'entries:resolve': (ctx: EntryResolveCtx<any>) => SyncHookResult
  'entries:normalize': (ctx: { tags: HeadTag[], entry: HeadEntry<any> }) => SyncHookResult
  'tag:normalise': (ctx: { tag: HeadTag, entry: HeadEntry<any>, resolvedOptions: CreateClientHeadOptions }) => SyncHookResult
  'tags:beforeResolve': (ctx: TagResolveContext) => SyncHookResult
  'tags:resolve': (ctx: TagResolveContext) => SyncHookResult
  'tags:afterResolve': (ctx: TagResolveContext) => SyncHookResult
  'dom:beforeRender': (ctx: DomBeforeRenderCtx) => SyncHookResult
  // ...additional hooks
}
```

Note: `SyncHookResult` is `void` (synchronous only), while `HookResult` is `void | Promise<void>`.

Edit this page

Markdown For LLMs

**Did this page help you? **

**Script Loading** Load external scripts with useScript(). Singleton deduplication, proxy for safe calls, loading triggers, and warmup strategies for performance. **Bundle Optimizations** Reduce bundle size with client-only and server-only tags. Use mode option or import.meta guards for SSR/CSR optimization.