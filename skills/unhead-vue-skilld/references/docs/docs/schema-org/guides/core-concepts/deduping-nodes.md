---
title: "Deduping Nodes · Unhead"
meta:
  "og:description": "Automatic Schema.org node deduplication by @id. Add multiple nodes of same type with custom IDs, replace vs merge strategies."
  "og:title": "Deduping Nodes · Unhead"
  description: "Automatic Schema.org node deduplication by @id. Add multiple nodes of same type with custom IDs, replace vs merge strategies."
---

**Core Concepts**

# **Deduping Nodes**

Copy for LLMs

**Quick Answer:** Schema.org nodes are automatically deduplicated by their `@id`. Only one node of each type (like `WebPage`) can exist by default. Later definitions merge with earlier ones unless you specify a custom `@id`.

## [How does node deduplication work?](#how-does-node-deduplication-work)

When generating many of the Schema.org nodes a default global `@id` is used to help with best practices.

For example:

```
import { defineOrganization, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineOrganization() // generates the nodes with an #identity id
])
```

This allows the node relations to be automatically mapped for best practices.

```
import { defineWebPage, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineWebPage() // knows to link the #identity id
])
```

## [How do I add multiple nodes of the same type?](#how-do-i-add-multiple-nodes-of-the-same-type)

The default `@id` can prevent having multiple nodes of the same type. Provide your own `@id` to create separate nodes:

```
import { defineOrganization, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineOrganization({
    '@id': '#some-company'
  })
])
```

## [How do I replace a node instead of merging?](#how-do-i-replace-a-node-instead-of-merging)

Use `tagDuplicateStrategy: 'replace'` to fully replace a node instead of merging properties:

```
import { defineOrganization, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineOrganization({
    '@id': '#some-company',
    'name': 'Bar Company',
    'url': 'https://bar.com',
  }),
])

useSchemaOrg([
  defineOrganization({
    '@id': '#some-company',
    'name': 'Foo Company',
  })
], {
  tagDuplicateStrategy: 'replace'
})

// Replaced!
// {
//   '@id': '#some-company',
//   name: 'Foo Company',
// }
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Introduction** Generate JSON-LD structured data for Google Rich Results. TypeScript functions like defineArticle() and defineProduct() with automatic validation. **Supported Nodes** Schema.org nodes for Google Rich Results with define* functions. Article, Product, Event, Recipe, FAQ, and 30+ more types with TypeScript validation.