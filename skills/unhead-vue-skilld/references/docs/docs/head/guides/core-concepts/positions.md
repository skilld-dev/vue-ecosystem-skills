---
title: "Tag Sorting & Placement · Unhead"
meta:
  "og:description": "Control where head tags render with tagPosition (head, bodyOpen, bodyClose) and tagPriority for ordering. Optimize performance with Capo.js weights."
  "og:title": "Tag Sorting & Placement · Unhead"
  description: "Control where head tags render with tagPosition (head, bodyOpen, bodyClose) and tagPriority for ordering. Optimize performance with Capo.js weights."
---

**Core Concepts**

# **Tag Sorting & Placement**

Copy for LLMs

**Quick Answer:** Use `tagPosition: 'head' | 'bodyOpen' | 'bodyClose'` to control where tags render. Use `tagPriority: 'critical' | 'high' | number | 'low'` to control ordering within those positions.

## [Introduction](#introduction)

By default, tags are rendered in the document `<head>` in a [**specific order**](#how-does-tag-sort-order-work) for optimal performance and compatibility.

However, this is not always useful, say if you need to render a script at the end of the document or have a specific placement of a tag.

To solve these issues we have three options:

- [**Document Placement**](#how-do-i-control-where-tags-render-in-the-document): To control where the tag is rendered in the document (e.g. `head`, `bodyClose`, `bodyOpen`, etc)
- [**Sort Order**](#how-does-tag-sort-order-work): To control the order of tags within the document section
- [**Hooks**](#how-can-i-programmatically-reorder-tags): For advanced use cases, the `tags:afterResolve` hook allows programmatic reordering

## [How do I control where tags render in the document?](#how-do-i-control-where-tags-render-in-the-document)

For the `<script>`, `<noscript>` and `<style>` tags you may provide an optional `tagPosition` property with the possible values:

- `head` - Render in the `<head>` (default)
- `bodyOpen` - Render at the start of the `<body>`
- `bodyClose` - Render at the end of the `<body>`

Using `bodyClose` for scripts that aren't critical for page rendering can significantly improve page load performance, as these scripts won't block the initial render.

### [Common Use Cases](#common-use-cases)

- **Analytics Scripts**: Place tracking scripts at `bodyClose` to avoid impacting page performance
- **Critical CSS**: Place essential styles in `head` with high priority
- **Polyfills**: Place in `bodyOpen` when they need to be loaded early but not block rendering

```
import { useHead } from 'unhead'

// useHead: /docs/head/api/composables/use-head
useHead(unheadInstance, {
  script: [
    {
      src: '/my-lazy-script.js',
      tagPosition: 'bodyClose',
    },
  ],
})
// renders
//   ...
//   <script src="/my-lazy-script.js"></script>
// </body>
```

## [How does tag sort order work?](#how-does-tag-sort-order-work)

All tags are given a weight with the lower the number, the higher the priority.

**Capo.js** weights are automatically applied to tags to avoid **Critical Request Chains**. As well as default weights to avoid site stability issues:

- **-20**: `<meta charset ...>`
- **-10**: `<base>`
- **0**: `<meta http-equiv="content-security-policy" ...>`
- **10**: `<title>`
- **20**: `<link rel="preconnect" ...>`

All other tags have a default priority of `100`.

Escaping out of these default weights can be accomplished by setting the `tagPriority` property.

### [How do I set tag priority?](#how-do-i-set-tag-priority)

The `tagPriority` property can be set to an explicit weight, a string alias or a string to target a specific tag.

#### [Sorting with Aliases](#sorting-with-aliases)

Using an alias to set the position of a tag is the best practice as it allows you to retain the existing capo.js weights that are configured for performance.

- `critical`: **-8**
- `high`: **-1**
- `low`: **2**

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  script: [
    {
      src: '/my-lazy-script.js',
      tagPriority: 'low',
    },
  ],
})
```

#### [Sort by number](#sort-by-number)

When providing a number, refer to the priorities set for critical tags above.

```
import { useHead } from 'unhead'

// some layout we have a js file that is ran
useHead(unheadInstance, {
  script: [
    {
      src: '/not-important-script.js',
    },
  ],
})

// but in our page we want to run a script before the above
useHead(unheadInstance, {
  script: [
    {
      src: '/very-important-script.js',
      tagPriority: 0,
    },
  ],
})

// <script src=\"/very-important-script.js\"></script>
// <script src=\"/not-important-script.js\"></script>
```

#### [Sort with `before:` and `after:`](#sort-with-before-and-after)

If you'd like to place a tag before or after another tag, you can use the optional **Alias Sorting Plugin** which provides a more intuitive way to order your tags relative to each other.

The Alias Sorting Plugin is particularly useful when you need precise control over tag order but don't want to manage numerical priorities directly.

### [Why is tagPriority ignored during hydration?](#why-is-tagpriority-ignored-during-hydration)

When hydrating the state (e.g., SSR or page switch), Unhead replaces existing tags in their current position to avoid a flash of content.

This may cause `tagPriority` to be ignored during hydration. For client-side-only applications or SPAs, this isn't an issue, but for SSR applications, be aware that the initial render positions may be preserved during hydration.

## [How can I programmatically reorder tags?](#how-can-i-programmatically-reorder-tags)

For advanced use cases where you need programmatic control over tag ordering, Unhead provides a powerful hook system.

The `tags:afterResolve` hook gives you access to the tags after they've been resolved but before they're rendered to the DOM. This allows for custom ordering logic beyond what's possible with `tagPriority`.

```
import { injectHead } from 'unhead'

const head = injectHead()

// Hook into the tags:afterResolve lifecycle
head.hooks.hook('tags:afterResolve', (ctx) => {
  // ctx.tags is an array of all tags that will be rendered
  // You can reorder, filter, or modify them before they are rendered

  // Example: Move all font preloads to the beginning
  const fontPreloads = ctx.tags.filter(tag =>
    tag.tag === 'link'
    && tag.props.rel === 'preload'
    && tag.props.as === 'font'
  )

  // Remove the font preloads from their current position
  ctx.tags = ctx.tags.filter(tag =>
    !(tag.tag === 'link'
      && tag.props.rel === 'preload'
      && tag.props.as === 'font')
  )

  // Add them to the beginning of the array
  ctx.tags = [...fontPreloads, ...ctx.tags]
})
```

The hooks approach is particularly useful for:

- Complex ordering logic that depends on runtime conditions
- Dynamic reordering based on user preferences or device capabilities
- Implementation of custom sorting algorithms for specific tag types

## [Key Takeaways](#key-takeaways)

- Use `tagPosition` to control where tags render (head, bodyOpen, bodyClose)
- Use `tagPriority` for ordering: 'critical', 'high', number, 'low'
- Critical tags like charset and viewport should have highest priority
- Scripts can be moved to body end for better performance

## [See Also](#see-also)

- **Alias Sorting Plugin** - Sort tags by alias
- **Handling Duplicates** - Deduplication strategies
- **useHead() API** - tagPriority option

Edit this page

Markdown For LLMs

**Did this page help you? **

**Titles & Title Templates** Learn how to master page titles using useHead, title templates, and SEO best practices. Includes reactive titles, social sharing, and template params. **Class & Style Attributes** Add classes and styles to html and body tags with htmlAttrs and bodyAttrs. Support for strings, arrays, objects, and reactive values.