---
title: "Schema.org Params · Unhead"
meta:
  "og:description": "Configure site-wide defaults for Schema.org with host, inLanguage, currency, and trailingSlash. Automatically cascade to all schema nodes."
  "og:title": "Schema.org Params · Unhead"
  description: "Configure site-wide defaults for Schema.org with host, inLanguage, currency, and trailingSlash. Automatically cascade to all schema nodes."
---

**Core Concepts**

# **Schema.org Params**

Copy for LLMs

**Quick Answer:** Schema.org params configure site-wide defaults like `host`, `path`, `currency`, and `inLanguage`. Set them once and they're automatically applied to all schema nodes.

## [What Are Schema.org Params?](#what-are-schemaorg-params)

Params let you configure multiple Schema.org nodes at once, reducing boilerplate. Use the `schemaOrg` option on templateParams.

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  templateParams: {
    schemaOrg: {
      host: 'https://example.com',
      path: '/blog'
    }
  }
})
```

## [Which Params Are Available?](#which-params-are-available)

### [`tagPosition`](#tagposition)

- **type**: `string`
- **default**: `bodyClose`The position of the Schema.org script tag. This is useful if you want to load the script in the body of your page.

### [`host`](#host)

- **type**: `string`The production URL of your site. This allows the client to generate all URLs for you and is important to set correctly.

### [`path`](#path)

- **type**: `string`
- **default**: `window.location.pathname`The path of the current page. This allows the client to generate all URLs for you and is important to set correctly.

### [`inLanguage`](#inlanguage)

- **type**: `string`
- **default**: `en`Will set the `isLanguage` to this value for any Schema which uses it. Should be a valid language code, i.e `en-AU`

### [`trailingSlash`](#trailingslash)

- **type**: `boolean`
- **default**: `false`Whether to add a trailing slash to the URL. This is important for Google to understand the canonical URL of your page.

### [`currency`](#currency)

- **type**: `string`
- **default**: `undefined`Default currency for Product, Offer, and other commerce-related schemas. Use ISO 4217 format, e.g., `USD`, `EUR`, `GBP`.

## [How Do Params Cascade to Nodes?](#how-do-params-cascade-to-nodes)

When you set a param like `host` or `inLanguage`, it automatically applies to all Schema.org nodes that support that property. This means you define your site defaults once and every `defineWebPage`, `defineArticle`, `defineProduct`, etc. inherits them without repetition.

```
useHead(unheadInstance, {
  templateParams: {
    schemaOrg: {
      host: 'https://example.com',
      inLanguage: 'en-AU',
      currency: 'AUD'
    }
  }
})

// All schema nodes now use these defaults automatically
useSchemaOrg([
  defineWebPage(), // inherits host, inLanguage
  defineProduct({ name: 'Widget', offers: { price: 99 } }) // inherits currency
])
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Supported Nodes** Schema.org nodes for Google Rich Results with define* functions. Article, Product, Event, Recipe, FAQ, and 30+ more types with TypeScript validation. **Custom Nodes** Create custom Schema.org types not in built-in helpers. Pass plain objects to useSchemaOrg() with TypeScript support via schema-dts.