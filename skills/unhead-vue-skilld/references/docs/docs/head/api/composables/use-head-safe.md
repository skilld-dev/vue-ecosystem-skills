---
title: "useHeadSafe() · Unhead"
meta:
  "og:description": "Safely manage head tags with XSS protection using useHeadSafe(). Sanitize untrusted user input for titles, meta tags, and other head elements."
  "og:title": "useHeadSafe() · Unhead"
  description: "Safely manage head tags with XSS protection using useHeadSafe(). Sanitize untrusted user input for titles, meta tags, and other head elements."
---

**Composables**

# **useHeadSafe()**

Copy for LLMs

**On this page **

- [How It Works](#how-it-works)
- [API Reference](#api-reference)
- [Examples](#examples)
- [Security Considerations](#security-considerations)
- [Common Use Cases](#common-use-cases)
- [Common Questions](#common-questions)
- [See Also](#see-also)

The `useHeadSafe` composable is a security-focused wrapper around the **useHead** composable that restricts input to only allow safe values, providing protection against XSS attacks when working with untrusted content.

**Quick Start:**

```
useHeadSafe(unheadInstance, {
  title: userInput.title, // Automatically sanitized
  meta: [{ name: 'description', content: userInput.description }]
})
```

## [How It Works](#how-it-works)

The composable implements a strict whitelist of allowed tags and attributes. When you attempt to use a tag or attribute that isn't on the whitelist, it will be silently ignored to prevent potential security issues.

The whitelist is intentionally restrictive since there are many vectors for XSS attacks. If you need to use a tag or attribute that isn't on the whitelist, you can use the **useHead** composable instead, but **you must sanitize the input yourself**.

### [Security Whitelist](#security-whitelist)

The security whitelist specifies which attributes are allowed for each tag type:

```
import { useHeadSafe } from 'unhead'

// The whitelist used internally by useHeadSafe
const WhitelistAttributes = {
  htmlAttrs: ['class', 'style', 'lang', 'dir'] satisfies (keyof HtmlAttributes)[],
  bodyAttrs: ['class', 'style'] satisfies (keyof BodyAttributes)[],
  meta: ['name', 'property', 'charset', 'content', 'media'] satisfies (keyof Meta)[],
  noscript: ['textContent'] satisfies (Partial<keyof Noscript> | 'textContent')[],
  style: ['media', 'textContent', 'nonce', 'title', 'blocking'] satisfies (Partial<keyof Style> | 'textContent')[],
  script: ['type', 'textContent', 'nonce', 'blocking'] satisfies (Partial<keyof Script> | 'textContent')[],
  link: ['color', 'crossorigin', 'fetchpriority', 'href', 'hreflang', 'imagesrcset', 'imagesizes', 'integrity', 'media', 'referrerpolicy', 'rel', 'sizes', 'type'] satisfies (keyof Link)[],
} as const
```

### [Additional Restrictions](#additional-restrictions)

The following security restrictions also apply:

- Scripts of any sort are not allowed, except for JSON (`<script type="application/json">`) - use `textContent: myObject`
- `http-equiv` attribute is not allowed on meta tags
- `data-*` attributes are allowed on all elements
- Link tags will strip invalid href values (like `data:`, `javascript:`)
- Link tags don't support these rel values: `['stylesheet', 'canonical', 'modulepreload', 'prerender', 'preload', 'prefetch']`

## [API Reference](#api-reference)

```
function useHeadSafe(input: UseHeadInput, options?: HeadEntryOptions): ActiveHeadEntry
```

The API signature is identical to **useHead**, but with additional security filtering applied to the input.

## [Examples](#examples)

### [Handling Untrusted Data](#handling-untrusted-data)

When working with head data from an untrusted data source:

```
import { useHeadSafe } from 'unhead'

// Load metadata from a third-party source
const thirdPartyMeta = loadMeta()

// Safely apply the metadata
useHeadSafe(thirdPartyMeta)
unheadInstance,
```

### [User-Generated Content](#user-generated-content)

When allowing users to provide custom meta tags:

```
import { useHeadSafe } from 'unhead'

// User profile with user-defined metadata
const userProfile = await fetchUserProfile(userId)

useHeadSafe(unheadInstance, {
  title: userProfile.pageTitle,
  meta: [
    { name: 'description', content: userProfile.pageDescription },
    ...userProfile.customMetaTags // These will be filtered for safety
  ]
})
```

## [Security Considerations](#security-considerations)

While `useHeadSafe` offers protection for most XSS vectors, there are still some important security considerations:

### [Styles](#styles)

While style attributes are permitted, it's important to note that **clickjacking** vulnerabilities can still be introduced through malicious CSS. Always validate style content even when using `useHeadSafe`.

### [Best Practices](#best-practices)

For maximum security when handling untrusted content:

1. Apply additional validation to any user inputs before passing to `useHeadSafe`
2. Consider using a dedicated content security policy (CSP)
3. Use the built-in sanitization but don't rely on it as your only defense
4. Avoid allowing custom styles when possible with untrusted content

## [Common Use Cases](#common-use-cases)

- Working with user-generated content
- Displaying metadata from third-party APIs
- Creating CMS systems where content editors can customize SEO fields
- Implementing white-label solutions where customers can customize branding

## [Common Questions](#common-questions)

### [When should I use useHeadSafe instead of useHead?](#when-should-i-use-useheadsafe-instead-of-usehead)

Use `useHeadSafe()` whenever you're working with untrusted or user-provided input to prevent XSS attacks.

### [What gets sanitized?](#what-gets-sanitized)

All string values are HTML-escaped. Script tags and event handlers are stripped. Only safe attributes are allowed.

## [See Also](#see-also)

- **useHead()** - General head management
- **useSeoMeta()** - SEO meta tags
- **Security Considerations**

Edit this page

Markdown For LLMs

**Did this page help you? **

**useHead()** Manage document head tags with useHead(). Set titles, meta tags, scripts, and styles with full TypeScript support and reactive updates. **useSeoMeta()** Add SEO meta tags with useSeoMeta(). Type-safe API for Open Graph, Twitter cards, and 100+ meta tags with automatic property/name handling.

**On this page **

- [How It Works](#how-it-works)
- [API Reference](#api-reference)
- [Examples](#examples)
- [Security Considerations](#security-considerations)
- [Common Use Cases](#common-use-cases)
- [Common Questions](#common-questions)
- [See Also](#see-also)