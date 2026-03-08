---
title: "Choosing a Schema.org Identity · Unhead"
meta:
  "og:description": "Set up Organization, Person, or LocalBusiness as your site identity. Enable Google Knowledge Panel and connect content to E-E-A-T signals."
  "og:title": "Choosing a Schema.org Identity · Unhead"
  description: "Set up Organization, Person, or LocalBusiness as your site identity. Enable Google Knowledge Panel and connect content to E-E-A-T signals."
---

**Recipes**

# **Choosing a Schema.org Identity**

Copy for LLMs

**On this page **

- [Why does Schema.org identity matter for SEO?](#why-does-schemaorg-identity-matter-for-seo)
- [Which identity type should I choose?](#which-identity-type-should-i-choose)
- [How does identity connect to other Schema.org nodes?](#how-does-identity-connect-to-other-schemaorg-nodes)
- [Related Recipes](#related-recipes)

**Quick Answer:** Set up your site identity with `defineOrganization()` or `definePerson()`. This establishes who owns/creates your content and enables Google Knowledge Panel eligibility.

## [Why does Schema.org identity matter for SEO?](#why-does-schemaorg-identity-matter-for-seo)

Providing an identity allows Google to display a prominent Knowledge Panel with details of the identity. It also connects all your content to a single entity, improving E-E-A-T signals.

## [Which identity type should I choose?](#which-identity-type-should-i-choose)

Choose based on what your site represents. If unsure, select `Organization`.

### [When should I use Organization?](#when-should-i-use-organization)

Use Organization for companies, brands, or any non-personal entity. It's the most common choice.

- Doesn't need to relate to an official business
- Use for eCommerce without a physical location

Example: **nuxtjs.org**, **vuejs.org**

```
import { defineOrganization, defineWebPage, defineWebSite, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineOrganization({
    name: 'My company',
    logo: '/logo.png',
    sameAs: [
      'https://twitter.com/company'
    ]
  }),
  defineWebSite({/* ... */}),
  defineWebPage(),
])
```

### [When should I use Person?](#when-should-i-use-person)

Use Person when your website represents an individual, personal brand, or personal blog.

Example: **harlanzw.com**, **antfu.me**

```
import { definePerson, defineWebPage, defineWebSite, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  definePerson({
    name: 'Harlan Wilton',
    image: '/me.png',
    sameAs: [
      'https://github.com/harlan-zw',
    ]
  }),
  defineWebSite({/* ... */}),
  defineWebPage(),
])
```

### [When should I use Local Business?](#when-should-i-use-local-business)

Use LocalBusiness when your website represents a physical business with an address.

- Extends **Organization**
- Use for eCommerce with a physical location

Example: **onacoffee.com.au**, **intracbr.com.au**

```
import { defineLocalBusiness, defineWebPage, defineWebSite, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineLocalBusiness({
    name: 'Harlan\'s Hamburgers',
    address: {
      streetAddress: '123 Main St',
      addressLocality: 'Harlan',
      addressRegion: 'MA',
      postalCode: '01234',
      addressCountry: 'US',
    },
    image: 'https://emojiguide.org/images/emoji/n/3ep4zx1jztp0n.png',
  }),
  defineWebSite({/* ... */}),
  defineWebPage(),
])
```

## [How does identity connect to other Schema.org nodes?](#how-does-identity-connect-to-other-schemaorg-nodes)

Once set, your identity automatically populates these relationships:

| **Node** | **Property** |
| --- | --- |
| **Article** | `publisher`, `author` |
| **Product** | `brand` |
| **WebSite** | `publisher` |
| **WebPage** | `about` (home page only) |

## [Related Recipes](#related-recipes)

- **Blog Posts** - Article structured data
- **eCommerce** - Product structured data
- **Site Search** - Search action markup

Edit this page

Markdown For LLMs

**Did this page help you? **

**Custom Nodes** Create custom Schema.org types not in built-in helpers. Pass plain objects to useSchemaOrg() with TypeScript support via schema-dts. **Blog** Add Article/BlogPosting structured data with defineArticle(). Enable rich snippets for author, publish date, and thumbnails in search results.

**On this page **

- [Why does Schema.org identity matter for SEO?](#why-does-schemaorg-identity-matter-for-seo)
- [Which identity type should I choose?](#which-identity-type-should-i-choose)
- [How does identity connect to other Schema.org nodes?](#how-does-identity-connect-to-other-schemaorg-nodes)
- [Related Recipes](#related-recipes)