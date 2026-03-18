---
title: "Inline Style & Scripts · Unhead"
meta:
  "og:description": "Add inline scripts and styles with textContent and innerHTML. Security best practices for XSS prevention and performance optimization."
  "og:title": "Inline Style & Scripts · Unhead"
  description: "Add inline scripts and styles with textContent and innerHTML. Security best practices for XSS prevention and performance optimization."
---

**Core Concepts**

# **Inline Style & Scripts**

Copy for LLMs

**Quick Answer:** Use `textContent` for inline scripts and styles, `innerHTML` only when you need HTML entities. Example: `script: [{ textContent: 'console.log("Hello")' }]`

## [What Are Inline Styles and Scripts in Unhead?](#what-are-inline-styles-and-scripts-in-unhead)

The `<style>`, `<script>` and `<noscript>` tags are unique in HTML as they can contain inner content that directly affects how your page behaves and appears. Unhead provides powerful utilities to manage this inner content safely and efficiently.

Unlike most other HTML tags which primarily use attributes, these special tags rely on their content to function. With Unhead, you can manipulate this content programmatically while benefiting from the library's deduplication and optimization features.

## [How Do I Set Inner Content for Script and Style Tags?](#how-do-i-set-inner-content-for-script-and-style-tags)

When working with the inner content of a tag, Unhead gives you two options for setting the content that appears between the opening and closing tags:

- `textContent`: Treats the content as plain text, escaping any HTML characters
- `innerHTML`: Interprets the content as HTML, which allows for structured content but requires security considerations

The choice between these properties depends on your specific needs and security requirements:

```
import { useHead } from 'unhead'

// useHead: /docs/head/api/composables/use-head
useHead(unheadInstance, {
  script: [
    {
      innerHTML: 'window.analytics = window.analytics || []',
    },
  ],
  style: [
    {
      textContent: 'body { background: salmon; color: cyan; }',
    },
  ]
})
```

This example demonstrates adding:

1. An inline script that initializes an analytics array
2. An inline style that sets background and text colors

### [When Should I Use innerHTML vs textContent?](#when-should-i-use-innerhtml-vs-textcontent)

Setting inner content using `textContent` is the safest approach for untrusted content. However, in some cases you might need to use `innerHTML`, particularly when working with rich content or third-party scripts that require HTML structure.

When using `innerHTML`, the content is not automatically sanitized. You must sanitize any user input or third-party content to prevent cross-site scripting (XSS) vulnerabilities that could compromise your application's security.

For dealing with external content, consider:

- Using a sanitization library like DOMPurify
- Applying framework-specific sanitization utilities
- Using the **useHeadSafe()** composable instead

#### [Example of Unsafe Usage](#example-of-unsafe-usage)

```
import { useHead } from 'unhead'

// Don't do this!
const someUserScript = await loadUserProvidedScript()
useHead(unheadInstance, {
  script: [
    {
      // ❌ Dangerous - could contain malicious code!
      innerHTML: someUserScript
    },
  ],
})
```

#### [Example of Safe Usage](#example-of-safe-usage)

```
import { useHead } from 'unhead'
import DOMPurify from 'dompurify'

// Do this instead
const userProvidedContent = await loadUserProvidedContent()
useHead(unheadInstance, {
  script: [
    {
      // ✅ Safe - content is sanitized
      innerHTML: DOMPurify.sanitize(userProvidedContent)
    },
  ],
})
```

## [Can I Use a String Shorthand Instead of Objects?](#can-i-use-a-string-shorthand-instead-of-objects)

For ease of use, Unhead provides a convenient shorthand syntax where you can simply provide a string as the array entry instead of an object with `textContent` or `innerHTML`.

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  script: [
    'window.analytics = window.analytics || []',
  ],
  style: [
    'body { background: salmon; color: cyan; }',
  ]
})
```

### [How It Works](#how-it-works)

Behind the scenes, Unhead automatically determines the appropriate property to use:

- For `<style>` tags: Content is applied as `textContent` (safer option)
- For `<script>` and `<noscript>` tags: The appropriate property is selected based on content

The shorthand syntax is ideal for simple, static content where you want cleaner code with fewer lines.

## [What Are the Best Practices for Inline Content?](#what-are-the-best-practices-for-inline-content)

When working with inner content for style and script tags, follow these best practices to ensure security, performance, and maintainability:

### [Security](#security)

Always prefer `textContent` over `innerHTML` whenever possible for security reasons.

- **Sanitize All External Content**: Always sanitize any user-generated or third-party content
- **Consider useHeadSafe**: For untrusted content, prefer the **useHeadSafe()** composable
- **Validate Input**: Check content before including it in your head tags

### [Performance](#performance)

- **Balance Inline vs. External**: While inline scripts and styles eliminate network requests, they can increase HTML size
- **Use Critical CSS**: For critical above-the-fold styles, inline CSS can improve perceived performance
- **Defer Non-Critical Scripts**: Use the `defer` attribute for non-essential scripts

```
import { useHead } from 'unhead'

// Example of critical CSS with non-critical scripts
useHead(unheadInstance, {
  style: [
    // Critical CSS inline for faster rendering
    'header, nav, .hero { /* Critical styles */ }',
  ],
  script: [
    {
      src: '/assets/analytics.js',
      defer: true, // Load after page rendering
    }
  ]
})
```

### [Maintainability](#maintainability)

- **Keep It Simple**: For complex scripts or styles, use external files with `src` or `href`
- **Use Keys**: Add `key` attributes to easily identify and update specific tags
- **Consider the Alternatives**:
  - For scripts, use the dedicated **useScript()** composable
  - For complex styling needs, use external stylesheets

## [What Are Common Use Cases for Inline Content?](#what-are-common-use-cases-for-inline-content)

### [Critical CSS](#critical-css)

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  style: [
    {
      key: 'critical-css',
      textContent: \`
        /* Only include truly critical styles here */
        body { font-family: system-ui, sans-serif; }
        .hero { height: 100vh; display: flex; align-items: center; }
      \`,
    }
  ]
})
```

### [Inline JSON Configuration](#inline-json-configuration)

```
import { useHead } from 'unhead'

const siteConfig = {
  apiEndpoint: '/api/v1',
  features: { darkMode: true, comments: false },
}

useHead(unheadInstance, {
  script: [
    {
      id: 'site-config',
      type: 'application/json',
      textContent: JSON.stringify(siteConfig),
    }
  ]
})
```

## [Key Takeaways](#key-takeaways)

- Use `textContent` for inline scripts and styles
- Use `innerHTML` only when you need HTML entities (prefer `textContent`)
- Inline styles can set CSS variables and custom properties
- Consider using `useScript()` for complex script loading scenarios

## [See Also](#see-also)

- **Loading Scripts** - Script management
- **useScript() API** - Advanced script loading

Edit this page

Markdown For LLMs

**Did this page help you? **

**Class & Style Attributes** Add classes and styles to html and body tags with htmlAttrs and bodyAttrs. Support for strings, arrays, objects, and reactive values. **Tag Deduplication** Automatic tag deduplication by key, name, and property. Override layout tags in pages, manage verification tags, and customize merge strategies.