---
title: "Custom Nodes · Unhead"
meta:
  "og:description": "Create custom Schema.org types not in built-in helpers. Pass plain objects to useSchemaOrg() with TypeScript support via schema-dts."
  "og:title": "Custom Nodes · Unhead"
  description: "Create custom Schema.org types not in built-in helpers. Pass plain objects to useSchemaOrg() with TypeScript support via schema-dts."
---

**Recipes**

# **Custom Nodes**

Copy for LLMs

**On this page **

- [Why Create Custom Schema.org Nodes?](#why-create-custom-schemaorg-nodes)
- [How Do I Add TypeScript Support for Custom Nodes?](#how-do-i-add-typescript-support-for-custom-nodes)
- [Related Recipes](#related-recipes)

**Quick Answer:** Create custom Schema.org nodes by passing a plain object to `useSchemaOrg()`. Use `@type` for the schema type and any valid Schema.org properties.

## [Why Create Custom Schema.org Nodes?](#why-create-custom-schemaorg-nodes)

If you need to add a node that isn't officially implemented, you can provide it yourself. This is useful for:

- Niche schema types not covered by built-in helpers
- Emerging schema types not yet added to the library
- Highly specific industry schemas

Custom nodes are plain objects following the **Schema.org specification**.

```
import { useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  {
    '@type': 'SingleFamilyResidence',
    'numberOfRooms': 3,
    'occupancy': 5,
    'numberOfBathroomsTotal': 2,
    'floorSize': '2000 sqft',
    'petsAllowed': true,
  }
])
```

## [How Do I Add TypeScript Support for Custom Nodes?](#how-do-i-add-typescript-support-for-custom-nodes)

Use **schema-dts** for full TypeScript support with custom nodes.

```
import type { DefinedTerm } from 'schema-dts'
import { useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  <DefinedTerm> {
    '@type': 'DefinedTerm',
    'name': 'Unhead Schema.org',
    'description': 'Unhead Schema.org is a library for adding Schema.org to your application.',
    'inDefinedTermSet': {
      '@type': 'DefinedTermSet',
      'name': 'Schema.org Libraries',
    },
  }
])
```

## [Related Recipes](#related-recipes)

- **Setting Up Your Identity** - Define your organization/person
- **Blog Posts** - Article structured data
- **eCommerce** - Product structured data

Edit this page

Markdown For LLMs

**Did this page help you? **

**Schema.org Params** Configure site-wide defaults for Schema.org with host, inLanguage, currency, and trailingSlash. Automatically cascade to all schema nodes. **Identity** Set up Organization, Person, or LocalBusiness as your site identity. Enable Google Knowledge Panel and connect content to E-E-A-T signals.

**On this page **

- [Why Create Custom Schema.org Nodes?](#why-create-custom-schemaorg-nodes)
- [How Do I Add TypeScript Support for Custom Nodes?](#how-do-i-add-typescript-support-for-custom-nodes)
- [Related Recipes](#related-recipes)