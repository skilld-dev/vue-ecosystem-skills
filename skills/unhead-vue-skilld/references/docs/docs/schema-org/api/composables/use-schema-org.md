---
title: "useSchemaOrg() · Unhead"
meta:
  "og:description": "Add Schema.org structured data with useSchemaOrg(). Pass defineArticle(), defineProduct(), and other schema nodes for Google Rich Results."
  "og:title": "useSchemaOrg() · Unhead"
  description: "Add Schema.org structured data with useSchemaOrg(). Pass defineArticle(), defineProduct(), and other schema nodes for Google Rich Results."
---

**Composables**

# **useSchemaOrg()**

Copy for LLMs

**On this page **

- [Example](#example)
- [Input](#input)
- [Options](#options)
- [Entry API](#entry-api)
- [XSS safety](#xss-safety)
- [Common Questions](#common-questions)
- [See Also](#see-also)

The `useSchemaOrg()` composable is the primary way to add Schema.org structured data to your pages.

**Quick Start:**

```
useSchemaOrg([
  defineWebSite({ name: 'My Site' }),
  defineWebPage({ name: 'Home' })
])
```

```
useSchemaOrg(input, options)
```

## [Example](#example)

Define an article with structured data for Google Rich Results:

```
useSchemaOrg([
  defineArticle({
    headline: 'My Blog Post',
    image: '/images/post.jpg',
    datePublished: new Date(),
  })
])
```

## [Input](#input)

The input accepts an array of Schema.org node definitions created using `define*` functions:

```
type SchemaOrgInput = SchemaOrgNode | SchemaOrgNode[]
```

Available node functions include:

- `defineWebSite()` - Site-level metadata
- `defineWebPage()` - Page-level metadata
- `defineArticle()` - Blog posts and articles
- `defineProduct()` - E-commerce products
- `defineOrganization()` - Company/organization info
- `definePerson()` - Author/person profiles
- `defineBreadcrumb()` - Navigation breadcrumbs
- And **many more**

## [Options](#options)

The second parameter to `useSchemaOrg` is the `HeadEntryOptions`. This allows you to apply options to the entry, meaning all tags that exist within the `input`.

```
export interface HeadEntryOptions {
  processTemplateParams?: boolean
  tagPriority?: number | 'critical' | 'high' | 'low' | \`before:${string}\` | \`after:${string}\`
  tagPosition?: 'head' | 'bodyClose' | 'bodyOpen'
  transform?: (input: unknown) => unknown
  head?: Unhead
}
```

## [Entry API](#entry-api)

The `useSchemaOrg` composable returns an API to manage the lifecycle of the schema entry. Using this you can either `patch` or `dispose` of the entry.

```
const schemaEntry = useSchemaOrg([
  defineWebPage({ name: 'My Page' })
])

// removes the schema nodes
schemaEntry.dispose()
```

## [XSS safety](#xss-safety)

The `useSchemaOrg` function only applies minimal sanitization on input to improve the developer experience.

Be careful, **do not** use this function with any unknown / third party input, that isn't sanitised. It is not possible to guarantee that the output is safe when dealing with unknown input.

If you need XSS safety, sanitise your input or look at using the **useSeoMeta** or **useHeadSafe** composables instead. If you're having issues working around the default nodes, you should disable them.

```
// nuxt.config.ts
export default defineNuxtConfig({
  schemaOrg: {
    defaults: false
  }
})
```

## [Common Questions](#common-questions)

### [How do I add multiple schema types to a page?](#how-do-i-add-multiple-schema-types-to-a-page)

Pass an array to `useSchemaOrg()` - each item becomes a node in the graph.

```
useSchemaOrg([
  defineWebPage({ name: 'Product Page' }),
  defineProduct({ name: 'Widget', price: 29.99 }),
  defineBreadcrumb({
    itemListElement: [
      { name: 'Home', item: '/' },
      { name: 'Products', item: '/products' },
    ]
  })
])
```

### [Do I need to set @id manually?](#do-i-need-to-set-id-manually)

No, Unhead automatically generates unique IDs and links related nodes.

### [How does Schema.org get page metadata?](#how-does-schemaorg-get-page-metadata)

It automatically infers data from your `<head>` tags like `<title>`, meta description, canonical URL, and og:image.

## [See Also](#see-also)

- **useHead()** - General head management
- **useSeoMeta()** - SEO meta tag management
- **Schema.org Nodes** - All available schema types

Edit this page

Markdown For LLMs

**Did this page help you? **

**Site Search** Add SearchAction to WebSite schema with defineSearchAction(). Enable Google Sitelinks Searchbox for your site in search results. **Article** Implement Article structured data with Unhead. JSON-LD examples for BlogPosting, NewsArticle, TechArticle with datePublished and author markup.

**On this page **

- [Example](#example)
- [Input](#input)
- [Options](#options)
- [Entry API](#entry-api)
- [XSS safety](#xss-safety)
- [Common Questions](#common-questions)
- [See Also](#see-also)