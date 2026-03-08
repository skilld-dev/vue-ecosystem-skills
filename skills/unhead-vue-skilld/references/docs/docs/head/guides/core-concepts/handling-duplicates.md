---
title: "Tag Deduplication · Unhead"
meta:
  "og:description": "Automatic tag deduplication by key, name, and property. Override layout tags in pages, manage verification tags, and customize merge strategies."
  "og:title": "Tag Deduplication · Unhead"
  description: "Automatic tag deduplication by key, name, and property. Override layout tags in pages, manage verification tags, and customize merge strategies."
---

**Core Concepts**

# **Tag Deduplication**

Copy for LLMs

**On this page **

- [What Is Tag Deduplication?](#what-is-tag-deduplication)
- [How Does Deduplication Work?](#how-does-deduplication-work)
- [How Do I Allow Multiple Tags with the Same Name?](#how-do-i-allow-multiple-tags-with-the-same-name)
- [How Do I Use Custom Keys for Deduplication?](#how-do-i-use-custom-keys-for-deduplication)
- [How Do I Customize the Duplicate Handling Strategy?](#how-do-i-customize-the-duplicate-handling-strategy)
- [Practical Examples](#practical-examples)
- [Common Use Cases](#common-use-cases)
- [Key Takeaways](#key-takeaways)
- [See Also](#see-also)

**Quick Answer:** Unhead automatically deduplicates tags by `key` attribute. Meta tags dedupe by `name` or `property`. Use unique `key` values when you need multiple similar tags.

## [What Is Tag Deduplication?](#what-is-tag-deduplication)

When implementing head tags across an application hierarchy (layouts, pages, components), you'll often need to override tags. This automatic replacement of duplicate tags is called "deduplication" or "deduping."

Unhead intelligently determines which tags are duplicates based on HTML specifications about which elements can appear multiple times in the DOM.

For example, you can only have one `title` element, and a single `<meta name="description">` tag in a valid HTML document.

## [How Does Deduplication Work?](#how-does-deduplication-work)

When you register multiple tags that are considered duplicates, only the most recent one will be used by default. This allows page-level components to override tags defined at the layout level.

### [How Are Duplicates Identified?](#how-are-duplicates-identified)

Unhead uses several strategies to identify duplicate tags:

- **Special singleton tags**: `base`, `title`, `titleTemplate`, `bodyAttrs`, `htmlAttrs`
- **Specific link types**: `<link rel="canonical">`
- **Charset metadata**: `<meta charset="">`
- **Custom keys**: Any tag with a matching `key` attribute
- **Meta tag identifiers**: Matching `name`, `property`, or `http-equiv` attributes

The deduplication process happens automatically during the head tag resolution phase.

### [Example: Meta Description Override](#example-meta-description-override)

```
import { useHead } from 'unhead'

// useHead: /docs/head/api/composables/use-head
// Called in a layout component (higher in the hierarchy)
useHead(unheadInstance, {
  meta: [
    {
      name: 'description',
      content: 'my site wide description',
    },
  ],
})

// Called in a page component (lower in the hierarchy)
useHead(unheadInstance, {
  meta: [
    {
      name: 'description',
      content: 'my page description',
    },
  ],
})

// Result in the rendered HTML:
// <meta name="description" content="my page description" />
```

You can control which tag takes precedence using **Tag Priorities** to override the default "most recent wins" behavior.

## [How Do I Allow Multiple Tags with the Same Name?](#how-do-i-allow-multiple-tags-with-the-same-name)

While deduplication is useful in most cases, there are scenarios where you need multiple tags with the same identifiers. A common example is verification tags from multiple services.

### [Using Content Arrays](#using-content-arrays)

To have multiple meta tags with the same `name` attribute, you can provide an array of values for the `content` attribute:

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  meta: [
    {
      name: 'google-site-verification',
      content: [
        'verification-id-1',
        'verification-id-2',
      ]
    },
  ],
})

// Result in HTML:
// <meta name="google-site-verification" content="verification-id-1">
// <meta name="google-site-verification" content="verification-id-2">
```

### [Multiple Tags in a Single Entry](#multiple-tags-in-a-single-entry)

Unhead also intelligently preserves multiple tags with the same identifier when they're defined within a single `useHead()` call:

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  meta: [
    {
      name: 'google-site-verification',
      content: 'verification-id-1'
    },
    {
      name: 'google-site-verification',
      content: 'verification-id-2'
    },
  ],
})

// Result in HTML:
// <meta name="google-site-verification" content="verification-id-1">
// <meta name="google-site-verification" content="verification-id-2">
```

This behavior is specifically designed for verification tags and similar use cases where multiple tags with the same name are valid and necessary.

## [How Do I Use Custom Keys for Deduplication?](#how-do-i-use-custom-keys-for-deduplication)

When you need more fine-grained control over deduplication, you can provide a custom `key` attribute to your tags.

The key serves as a unique identifier, ensuring that only one instance of a tag with that key exists in the final HTML output. This works regardless of the tag type or other attributes.

### [Example: Ensuring Script Uniqueness](#example-ensuring-script-uniqueness)

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  script: [
    {
      src: 'https://example.com/script.js',
      key: 'my-script',
    },
  ]
})
```

Custom keys are particularly useful for:

- Managing third-party scripts across components
- Ensuring unique instances of specific resources
- Creating explicit relationships between tags in different components

### [Overriding Tags Using Keys](#overriding-tags-using-keys)

Any tag can be overridden or removed by using the same key in a subsequent `useHead()` call, regardless of the tag type or other properties.

## [How Do I Customize the Duplicate Handling Strategy?](#how-do-i-customize-the-duplicate-handling-strategy)

By default, when a duplicate tag is found, Unhead will `replace` the existing tag with the new one.

### [Default Strategies](#default-strategies)

- **For most tags**: The default strategy is `replace` - the new tag completely replaces the old one
- **For attribute tags**: When dealing with `htmlAttrs` and `bodyAttrs`, the default strategy is `merge` - allowing you to add attributes without removing existing ones (especially useful for `class` and `style` properties)

### [The `tagDuplicateStrategy` Property](#the-tagduplicatestrategy-property)

You can explicitly control this behavior using the `tagDuplicateStrategy` property:

```
import { useHead } from 'unhead'

// In a layout file we added a class
useHead(unheadInstance, {
  htmlAttrs: {
    class: 'my-class',
  },
})

// On a specific page, we want to replace instead of merge
useHead(unheadInstance, {
  htmlAttrs: {
    tagDuplicateStrategy: 'replace', // Override the default merge behavior
    class: 'my-new-class',
  },
})

// Result in HTML:
// <html class="my-new-class">
```

The `tagDuplicateStrategy` is particularly useful when:

- You need to completely replace HTML/body attributes instead of merging them
- You want to ensure clean slate behavior for certain tags

## [Practical Examples](#practical-examples)

### [How Do I Remove a Tag from a Parent Component?](#how-do-i-remove-a-tag-from-a-parent-component)

You can remove a tag defined in a parent component by using its key with an empty object:

```
import { useHead } from 'unhead'

// A layout file sets the background color to red
useHead(unheadInstance, {
  style: [
    {
      key: 'red-bg',
      textContent: 'body { color: red }',
    }
  ]
})

// On a specific page, we want to remove that style
useHead(unheadInstance, {
  style: [
    {
      // A tag with only a key will be removed
      key: 'red-bg',
    }
  ]
})

// Result: No style is rendered
```

### [How Do I Replace a Style with a Different Value?](#how-do-i-replace-a-style-with-a-different-value)

```
import { useHead } from 'unhead'

// A layout file sets the background color to red
useHead(unheadInstance, {
  style: [
    {
      key: 'bg-colour',
      textContent: 'body { color: red }',
    }
  ]
})

// In a page component, we want to change it to blue
useHead(unheadInstance, {
  style: [
    {
      key: 'bg-colour',
      textContent: 'body { color: blue }',
    }
  ]
})

// Result: Only the blue style is rendered
```

## [Common Use Cases](#common-use-cases)

- **Layout/Page Overrides**: Define base tags in layouts and override them in specific pages
- **Component-Specific Tags**: Add tags in components that won't conflict with others
- **Feature Toggles**: Enable/disable certain tags based on feature flags
- **Third-Party Integrations**: Manage verification tags from multiple services
- **Environment-Specific Settings**: Change tags based on development, staging, or production environments

## [Key Takeaways](#key-takeaways)

- Tags with same `key` are deduplicated (last wins)
- Meta tags dedupe by `name` or `property` attribute
- Use unique keys when you need multiple similar tags
- Link tags dedupe by `rel` + `href` combination

## [See Also](#see-also)

- **Tag Positions** - Control tag ordering
- **useHead() API** - Deduplication options

Edit this page

Markdown For LLMs

**Did this page help you? **

**Inline Style & Scripts** Add inline scripts and styles with textContent and innerHTML. Security best practices for XSS prevention and performance optimization. **DOM Event Handling** Handle DOM events with bodyAttrs for window resize, online/offline status, page lifecycle, and print events. Use onload/onerror for stylesheets.

**On this page **

- [What Is Tag Deduplication?](#what-is-tag-deduplication)
- [How Does Deduplication Work?](#how-does-deduplication-work)
- [How Do I Allow Multiple Tags with the Same Name?](#how-do-i-allow-multiple-tags-with-the-same-name)
- [How Do I Use Custom Keys for Deduplication?](#how-do-i-use-custom-keys-for-deduplication)
- [How Do I Customize the Duplicate Handling Strategy?](#how-do-i-customize-the-duplicate-handling-strategy)
- [Practical Examples](#practical-examples)
- [Common Use Cases](#common-use-cases)
- [Key Takeaways](#key-takeaways)
- [See Also](#see-also)