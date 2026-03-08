---
title: "Supported Nodes · Unhead"
meta:
  "og:description": "Schema.org nodes for Google Rich Results with define* functions. Article, Product, Event, Recipe, FAQ, and 30+ more types with TypeScript validation."
  "og:title": "Supported Nodes · Unhead"
  description: "Schema.org nodes for Google Rich Results with define* functions. Article, Product, Event, Recipe, FAQ, and 30+ more types with TypeScript validation."
---

**Core Concepts**

# **Supported Nodes**

Copy for LLMs

**On this page **

- [How do I add a custom Schema.org node?](#how-do-i-add-a-custom-schemaorg-node)
- [Which nodes are officially supported?](#which-nodes-are-officially-supported)

**Quick Answer:** Schema.org nodes are created with `define*` functions like `defineArticle()`, `defineProduct()`, etc. Each function validates input and outputs valid JSON-LD.

Official nodes are ones that have a direct impact on Google Rich Results.

## [How do I add a custom Schema.org node?](#how-do-i-add-a-custom-schemaorg-node)

If you need a node that isn't officially supported, provide it as a plain object following the **Schema.org specification**.

For TypeScript support, use **schema-dts**.

```
import { useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  {
    '@type': 'DefinedTerm',
    'name': 'Nuxt Schema.org',
    'description': 'Nuxt Schema.org is a Nuxt module for adding Schema.org to your Nuxt app.',
    'inDefinedTermSet': {
      '@type': 'DefinedTermSet',
      'name': 'Nuxt Modules',
    },
  }
])
```

```
import type { DefinedTerm } from 'schema-dts'
import { useSchemaOrg } from '@unhead/schema-org/typescript'

const NuxtSchemaOrgDefinedTerm: DefinedTerm = {
  '@type': 'DefinedTerm',
  'name': 'Nuxt Schema.org',
  'description': 'Nuxt Schema.org is a Nuxt module for adding Schema.org to your Nuxt app.',
  'inDefinedTermSet': {
    '@type': 'DefinedTermSet',
    'name': 'Nuxt Modules',
  },
}

useSchemaOrg([NuxtSchemaOrgDefinedTerm])
```

## [Which nodes are officially supported?](#which-nodes-are-officially-supported)

Officially supported nodes are those that enable Google Rich Results. Each has a dedicated `define*` function with validation and auto-completion.

Edit this page

Markdown For LLMs

**Did this page help you? **

**Deduping Nodes** Automatic Schema.org node deduplication by @id. Add multiple nodes of same type with custom IDs, replace vs merge strategies. **Schema.org Params** Configure site-wide defaults for Schema.org with host, inLanguage, currency, and trailingSlash. Automatically cascade to all schema nodes.

**On this page **

- [How do I add a custom Schema.org node?](#how-do-i-add-a-custom-schemaorg-node)
- [Which nodes are officially supported?](#which-nodes-are-officially-supported)