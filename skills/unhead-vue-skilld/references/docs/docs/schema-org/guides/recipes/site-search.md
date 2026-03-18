---
title: "Site Search · Unhead"
meta:
  "og:description": "Add SearchAction to WebSite schema with defineSearchAction(). Enable Google Sitelinks Searchbox for your site in search results."
  "og:title": "Site Search · Unhead"
  description: "Add SearchAction to WebSite schema with defineSearchAction(). Enable Google Sitelinks Searchbox for your site in search results."
---

**Recipes**

# **Site Search**

Copy for LLMs

If your site offers a search function, you may like to define markup to help Google understand it.

## [Useful Links](#useful-links)

- **Sitelinks Searchbox**
- **SearchAction | Yoast**

## [Define a Search Action](#define-a-search-action)

To provide a search action for your WebSite, you need to insert a SearchAction in `potentialAction`.

To make configuring this easier, the function `defineSearchAction` is provided.

Make sure that you set place `{search_term_string}` somewhere in your URL. This represents a query a user would be searching for.

This markup should go in your root Schema definition.

```
import { defineSearchAction, defineWebSite, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineWebSite({
    potentialAction: [
      defineSearchAction({
        target: '/search?q={search_term_string}'
      })
    ]
  })
])
```

## [Define your Search Results Page](#define-your-search-results-page)

Using your **WebPage** Schema, you can define the page as a search results page.

```
import { defineWebPage, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineWebPage({
    '@type': ['CollectionPage', 'SearchResultsPage'],
  })
])
```

## [Related Recipes](#related-recipes)

- **Setting Up Your Identity** - Define your organization
- **Breadcrumbs** - Navigation breadcrumbs
- **eCommerce** - Product structured data

Edit this page

Markdown For LLMs

**Did this page help you? **

**How To** Add HowTo structured data with defineHowTo(). Enable step-by-step rich snippets with images, supplies, and time estimates. **useSchemaOrg()** Add Schema.org structured data with useSchemaOrg(). Pass defineArticle(), defineProduct(), and other schema nodes for Google Rich Results.