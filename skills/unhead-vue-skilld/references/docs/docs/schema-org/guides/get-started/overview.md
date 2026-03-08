---
title: "Unhead Schema.org · Unhead"
meta:
  "og:description": "Generate JSON-LD structured data for Google Rich Results. TypeScript functions like defineArticle() and defineProduct() with automatic validation."
  "og:title": "Unhead Schema.org · Unhead"
  description: "Generate JSON-LD structured data for Google Rich Results. TypeScript functions like defineArticle() and defineProduct() with automatic validation."
---

**Get Started**

# **Unhead Schema.org**

**On this page **

- [What is Unhead Schema.org?](#what-is-unhead-schemaorg)
- [Background](#background)
- [How does Schema.org get page data?](#how-does-schemaorg-get-page-data)
- [How are duplicate nodes handled?](#how-are-duplicate-nodes-handled)
- [How are values transformed?](#how-are-values-transformed)
- [How Do Nodes Relate to Each Other?](#how-do-nodes-relate-to-each-other)
- [Testing Your Schema](#testing-your-schema)

## [What is Unhead Schema.org?](#what-is-unhead-schemaorg)

Unhead Schema.org automatically generates valid JSON-LD structured data for Google Rich Results. Instead of manually writing complex JSON-LD, you use simple TypeScript functions like `defineArticle()` or `defineProduct()` that handle validation, URL resolution, and Google requirements automatically.

### [Quick Start](#quick-start)

```
import { defineArticle, useSchemaOrg } from '@unhead/schema-org/typescript'

// Generates complete Article JSON-LD with all required Google fields
useSchemaOrg([
  defineArticle({
    headline: 'My Blog Post',
    image: '/images/post.jpg',
    datePublished: new Date(),
  })
])
```

## [Background](#background)

With Unhead Schema.org you can inject a Schema.org graph into your page.

Wrapper functions have been added to make opting in to **Google Rich Results** nodes easier.

For officially supported nodes, when the graph is being resolved it will apply a number of transforms to ensure the data is valid for Google.

Otherwise, you can provide your own custom nodes that are passed through as is.

## [How does Schema.org get page data?](#how-does-schemaorg-get-page-data)

When resolving the graph, the package will inject config from the site and page level to reduce the amount of boilerplate.

For example, if you have a `<title>` on your page, then it's likely we can use this same title to generate the Schema.org WebPage's `name`.

The following inferences are from your `<head>` data:

- `inLanguage` - `<html lang="en">` (`en`)
- `name` - `<title>test</title>` (`test`)
- `description` - `<meta name="description" content="test">` (`test`)
- `url` - `<link rel="canonical" href="https://example.com/my-page">` (`https://example.com`)
- `image` - `<meta property="og:image" content="https://example.com/image.jpg">` (`https://example.com/image.jpg`)

Otherwise, they will come from your **Schema.org Params**.

## [How are duplicate nodes handled?](#how-are-duplicate-nodes-handled)

For certain nodes, only one of them can exist at once. For example, a page can only have one `WebPage` node.

When resolving the graph, the package will dedupe nodes based on the `@id` of the node.

## [How are values transformed?](#how-are-values-transformed)

There's numerous resolvers available to help minimise the work in maintaining and developing Schema.

In code examples, `@unhead/schema-org/@framework` is a placeholder. Replace `@framework` with your framework: `vue`, `react`, etc.

### [URL Transformer](#url-transformer)

Any URL field allows a relevant link to be provided. This link will either be prefixed with the canonical host or the canonical page URL.

```
import { defineComment } from '@unhead/schema-org/typescript'

defineComment({
  text: 'This is really cool!',
  author: {
    name: 'Harlan Wilton',
    url: '/user/harlan-wilton',
  }
})
```

```
[
  {
    "@id": "https://example.com/#/schema/person/1230192103",
    "@type": "Person",
    "name": "Harlan Wilton",
    "url": "https://example.com/user/harlan-wilton"
  },
  {
    "@id": "https://example.com/#/schema/comment/2288441280",
    "@type": "Comment",
    "author": {
      "@id": "https://example.com/#/schema/person/1230192103"
    },
    "text": "This is really cool!"
  }
]
```

### [Image Transformer](#image-transformer)

Uses the same relative link logic as the URL transformer.

Additionally, single string images will be transformed to an **ImageObject** and added as a root node and an applicable link to the `@id` will be added.

```
import { defineWebPage } from '@unhead/schema-org/typescript'

defineWebPage({
  image: '/my-image.png',
})
```

```
{
  "@id": "https://example.com/#/schema/image/1571960974",
  "@type": "ImageObject",
  "contentUrl": "https://example.com//my-image.png",
  "url": "https://example.com//my-image.png"
}
```

### [ID Transformer](#id-transformer)

Providing an `@id` for a Schema node is sometimes useful to setup your own relations. When configuring the `@id` you can provide it as a simple string beginning with `#`.

The ID will be resolved to use the canonical host or the canonical page path as a prefix.

```
import { defineBreadcrumb } from '@unhead/schema-org/typescript'

defineBreadcrumb({
  '@id': '#subbreadcrumb',
  'itemListElement': [
    { name: 'Sub breadcrumb link', item: '/blog/test' },
  ],
})
```

```
{
  "@id": "https://example.com/#subbreadcrumb",
  "@type": "BreadcrumbList"
}
```

### [Type Transformer](#type-transformer)

Providing a string of `@type` will be augmented with the default type. This is to allow fallbacks when the specific `@type` is not supported by Google.

```
import { defineWebPage } from '@unhead/schema-org/typescript'

defineWebPage({
  '@type': 'FAQPage',
})
```

```
{
  "@type": [
    "WebPage",
    "FAQPage"
  ]
}
```

### [Date Transformer](#date-transformer)

Any date can be provided as a string or a js `Date` object. When a `Date` object is provided it will be transformed to the **ISO 8601** format.

```
import { defineWebPage } from '@unhead/schema-org/typescript'

defineWebPage({
  datePublished: new Date(2022, 1, 10, 0, 0, 0),
})
```

```
{
  "datePublished": "2022-01-10T00:00:0+00:00"
}
```

## [How Do Nodes Relate to Each Other?](#how-do-nodes-relate-to-each-other)

Schema.org nodes form a graph with relationships. Unhead automatically creates these connections:

```
WebSite (your site identity)
   └── WebPage (each page)
         ├── Article / Product / etc. (page content type)
         └── BreadcrumbList (navigation path)
```

When you define nodes, Unhead links them automatically:

```
useSchemaOrg([
  defineWebSite({ name: 'My Blog' }), // Root node
  defineWebPage({ name: 'About Us' }), // Linked to WebSite
  defineArticle({ headline: 'My Post' }), // Linked to WebPage
])
```

The generated JSON-LD uses `@id` references to connect nodes, following Google's best practices.

## [Testing Your Schema](#testing-your-schema)

Always validate your Schema.org markup before deploying:

### [1. Google Rich Results Test](#_1-google-rich-results-test)

**URL:** **search.google.com/test/rich-results**

Tests specifically for Google Rich Results eligibility. Shows:

- Which rich result types your page qualifies for
- Missing required fields
- Warnings about recommended fields

### [2. Schema.org Validator](#_2-schemaorg-validator)

**URL:** **validator.schema.org**

General Schema.org validation. Shows:

- Syntax errors in JSON-LD
- Type mismatches
- Unknown properties

### [How Rich Results Appear in Google](#how-rich-results-appear-in-google)

When Schema.org is properly implemented, Google may display enhanced results:

| **Schema Type** | **Rich Result** |
| --- | --- |
| `Article` | Article preview with image, date, author |
| `Product` | Price, availability, star ratings |
| `FAQ` | Expandable Q&A directly in search results |
| `Recipe` | Cook time, ratings, calorie count |
| `Event` | Date, location, ticket availability |
| `BreadcrumbList` | Navigation path shown below title |

Rich Results are not guaranteed—Google decides based on quality and relevance. Valid Schema.org increases eligibility but doesn't guarantee display.

Edit this page

Markdown For LLMs

**Did this page help you? **

**script:updated** Hook triggered on script status changes. Monitor loading, manage dependencies, and implement error recovery strategies. **Deduping Nodes** Automatic Schema.org node deduplication by @id. Add multiple nodes of same type with custom IDs, replace vs merge strategies.

**On this page **

- [What is Unhead Schema.org?](#what-is-unhead-schemaorg)
- [Background](#background)
- [How does Schema.org get page data?](#how-does-schemaorg-get-page-data)
- [How are duplicate nodes handled?](#how-are-duplicate-nodes-handled)
- [How are values transformed?](#how-are-values-transformed)
- [How Do Nodes Relate to Each Other?](#how-do-nodes-relate-to-each-other)
- [Testing Your Schema](#testing-your-schema)