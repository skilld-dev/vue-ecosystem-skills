---
title: "Schema.org Breadcrumbs · Unhead"
meta:
  "og:description": "Add BreadcrumbList structured data with defineBreadcrumb(). Display clickable navigation paths instead of URLs in Google search results."
  "og:title": "Schema.org Breadcrumbs · Unhead"
  description: "Add BreadcrumbList structured data with defineBreadcrumb(). Display clickable navigation paths instead of URLs in Google search results."
---

**Recipes**

# **Schema.org Breadcrumbs**

Copy for LLMs

Use `defineBreadcrumb()` with an array of `{ name, item }` objects to create breadcrumb navigation markup. Google displays this as a clickable path in search results instead of showing the raw URL.

Breadcrumb structured data replaces URLs in search results with a readable navigation path (Home > Category > Page), helping users understand your site hierarchy.

## [Useful Links](#useful-links)

- **Breadcrumb | Google Search Central**
- **Breadcrumb | Yoast**

## [How do I mark up breadcrumbs?](#how-do-i-mark-up-breadcrumbs)

**defineBreadcrumb** creates Breadcrumb Schema whilst handling relations for you.

Imagine we want to generate the following markup with the appropriate Schema.

Note: Google recommends that the markup for the breadcrumbs should exist on the page matching the Schema.org entry.

```
import { defineBreadcrumb, useSchemaOrg } from '@unhead/schema-org/typescript'

const breadcrumbs = [
  // item is the url and will be resolved to the absolute url
  { name: 'Home', item: '/' },
  { name: 'Articles', item: '/blog' },
  // item is not required for the last list element
  { name: 'How do breadcrumbs work' },
]

useSchemaOrg([
  defineBreadcrumb({
    itemListElement: breadcrumbs
  }),
])
```

Here's an example of how you might structure your breadcrumbs in HTML:

```
<ul>
  <li>
    <a href="/">Home</a>
    <span>/</span>
  </li>
  <li>
    <a href="/blog">Articles</a>
    <span>/</span>
  </li>
  <li>
    <span>How do breadcrumbs work</span>
  </li>
</ul>
```

## [How do I add multiple breadcrumb trails?](#how-do-i-add-multiple-breadcrumb-trails)

There may be some cases where you'd like multiple breadcrumbs to be displayed.

For these cases you can provide an `@id` and it will avoid overwriting the primary breadcrumb.

```
import { defineBreadcrumb, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  // primary breadcrumb
  defineBreadcrumb({
    itemListElement: [
      // item is the url and will be resolved to the absolute url
      { name: 'Home', item: '/' },
      { name: 'Articles', item: '/blog' },
      // item is not required for the last list element
      { name: 'How do breadcrumbs work' },
    ]
  }),
  defineBreadcrumb({
    '@id': '#secondary-breadcrumb',
    'itemListElement': [
      // item is the url and will be resolved to the absolute url
      { name: 'Sub Home', item: '/sub' },
      { name: 'Sub Page', item: '/sub/page' },
      { name: 'Sub Element' },
    ]
  }),
])
```

## [Related Recipes](#related-recipes)

- **Blog Posts** - Article structured data
- **E-Commerce** - Product structured data

Edit this page

Markdown For LLMs

**Did this page help you? **

**Blog** Add Article/BlogPosting structured data with defineArticle(). Enable rich snippets for author, publish date, and thumbnails in search results. **eCommerce** Add Product structured data with defineProduct(). Enable rich results with prices, ratings, stock status, and reviews in search.