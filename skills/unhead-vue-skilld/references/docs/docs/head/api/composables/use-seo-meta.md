---
title: "useSeoMeta() · Unhead"
meta:
  "og:description": "Add SEO meta tags with useSeoMeta(). Type-safe API for Open Graph, Twitter cards, and 100+ meta tags with automatic property/name handling."
  "og:title": "useSeoMeta() · Unhead"
  description: "Add SEO meta tags with useSeoMeta(). Type-safe API for Open Graph, Twitter cards, and 100+ meta tags with automatic property/name handling."
---

**Composables**

# **useSeoMeta()**

Copy for LLMs

The `useSeoMeta` composable lets you define your site's SEO meta tags as a flat object with full TypeScript support.

**Quick Start:**

```
useSeoMeta(unheadInstance, {
  title: 'Page Title',
  description: 'Page description for search engines',
  ogTitle: 'Social Share Title',
  ogDescription: 'Description for social media',
  ogImage: 'https://example.com/og-image.jpg'
})
```

This helps you avoid common mistakes, such as using `name` instead of `property` attributes, and prevents typos with over 100+ meta tags fully typed.

This is the recommended way to add meta tags to your site as it is XSS safe and provides comprehensive TypeScript support.

## [Basic Usage](#basic-usage)

```
import { useSeoMeta } from 'unhead'

useSeoMeta(unheadInstance, {
  title: 'About',
  description: 'My about page',
  ogDescription: 'Still about my about page',
  ogTitle: 'About',
  ogImage: 'https://example.com/image.png',
  twitterCard: 'summary_large_image',
})
```

## [Common Use Cases](#common-use-cases)

### [Complete SEO Setup](#complete-seo-setup)

```
import { useSeoMeta } from 'unhead'

useSeoMeta(unheadInstance, {
  // Basic SEO
  title: 'Product Name - Your Brand',
  description: 'Detailed product description optimized for search engines.',

  // Open Graph
  ogTitle: 'Product Name - Your Brand',
  ogDescription: 'Engaging description for social media shares.',
  ogImage: 'https://example.com/product-social.jpg',
  ogUrl: 'https://example.com/products/my-product',
  ogType: 'product',
  ogSiteName: 'Your Brand',

  // Twitter
  twitterTitle: 'Product Name - Your Brand',
  twitterDescription: 'Engaging description for Twitter shares.',
  twitterImage: 'https://example.com/product-twitter.jpg',
  twitterCard: 'summary_large_image',

  // Product specific (structured data will be generated)
  articleAuthor: 'Author Name',
  articlePublishedTime: '2023-01-01',
  articleModifiedTime: '2023-02-15',
})
```

### [Dynamic Meta Tags](#dynamic-meta-tags)

```
import { useSeoMeta } from 'unhead'
import { computed } from 'vue' // or equivalent in your framework

const product = ref({
  name: 'Awesome Product',
  description: 'This product is amazing',
  image: 'https://example.com/image.png'
})

useSeoMeta(unheadInstance, {
  title: computed(() => \`${product.value.name} - Your Brand\`),
  description: computed(() => product.value.description),
  ogImage: computed(() => product.value.image),
})
```

## [How it works](#how-it-works)

The `useSeoMeta` composable is powered by the **zhead** schema and `unpackMeta` function. Unhead knows which meta tags belong where, as well as handling all the browser quirks for you.

## [API Reference](#api-reference)

### [Input](#input)

A flat object with keys representing different meta tags. All properties are optional.

### [Return Value](#return-value)

The composable returns a `MetaProxy` object that allows updating the meta tags reactively.

## [Best Practices](#best-practices)

- Include essential meta tags for social sharing (og:title, og:description, og:image)
- Keep descriptions concise (under 160 characters) but informative
- Use unique titles and descriptions for each page
- Provide appropriately sized images for social sharing

## [Super-charged SEO](#super-charged-seo)

Use it with the **Infer SEO Meta Tags** guide to super-charge your app's SEO with minimal effort.

## [Common Mistakes](#common-mistakes)

### [Forgetting essential OG tags](#forgetting-essential-og-tags)

```
// ❌ Incomplete - missing image and url
useSeoMeta(unheadInstance, {
  ogTitle: 'My Page',
  ogDescription: 'Description'
})

// ✅ Complete - all required OG tags
useSeoMeta(unheadInstance, {
  ogTitle: 'My Page',
  ogDescription: 'Description',
  ogImage: 'https://example.com/og.jpg',
  ogUrl: 'https://example.com/page'
})
```

### [Using wrong image dimensions](#using-wrong-image-dimensions)

```
// ❌ Image too small for Twitter large card
useSeoMeta(unheadInstance, {
  twitterCard: 'summary_large_image',
  twitterImage: 'https://example.com/small-icon.png' // 100x100
})

// ✅ Proper dimensions (1200x630 for OG, 1200x600 for Twitter large)
useSeoMeta(unheadInstance, {
  twitterCard: 'summary_large_image',
  twitterImage: 'https://example.com/twitter-card.jpg' // 1200x600
})
```

### [Duplicating content unnecessarily](#duplicating-content-unnecessarily)

```
// ❌ Redundant - description repeated 3 times
useSeoMeta(unheadInstance, {
  description: 'My description',
  ogDescription: 'My description',
  twitterDescription: 'My description'
})

// ✅ Let platforms fall back - only specify when different
useSeoMeta(unheadInstance, {
  description: 'SEO-optimized description for search',
  ogDescription: 'More engaging description for social shares'
  // twitterDescription falls back to ogDescription
})
```

## [Common Questions](#common-questions)

### [What's the difference between useSeoMeta and useHead?](#whats-the-difference-between-useseometa-and-usehead)

`useSeoMeta()` provides a flat, type-safe API specifically for SEO meta tags. `useHead()` is the general-purpose API for all head tags.

### [Do I need both title and ogTitle?](#do-i-need-both-title-and-ogtitle)

The `title` sets the `<title>` tag. `ogTitle` sets `og:title` for social sharing. They can be different - social titles are often more engaging.

## [See Also](#see-also)

- **Titles Guide** - Setting page titles
- **useHead()** - General head management
- **useHeadSafe()** - Safe head management with XSS protection

Edit this page

Markdown For LLMs

**Did this page help you? **

**useHeadSafe()** Safely manage head tags with XSS protection using useHeadSafe(). Sanitize untrusted user input for titles, meta tags, and other head elements. **useScript()** Load third-party scripts with useScript(). Smart defaults for performance, lazy loading triggers, and API proxying for analytics and widgets.