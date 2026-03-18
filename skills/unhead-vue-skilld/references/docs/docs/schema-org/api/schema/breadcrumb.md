---
title: "Breadcrumb Schema · Unhead"
meta:
  "og:description": "Use defineBreadcrumb() to add BreadcrumbList structured data. Display clickable navigation paths in Google search results for better user experience."
  "og:title": "Breadcrumb Schema · Unhead"
  description: "Use defineBreadcrumb() to add BreadcrumbList structured data. Display clickable navigation paths in Google search results for better user experience."
---

**Schema**

# **Breadcrumb Schema**

Copy for LLMs

## [Schema.org Breadcrumb](#schemaorg-breadcrumb)

- **Type**: `defineBreadcrumb(input?: Breadcrumb)`Describes an `Breadcrumb` on a `WebPage`.

## [Useful Links](#useful-links)

- **BreadcrumbList - Schema.org**
- **Breadcrumb Schema Markup - Google Search Central**
- **Breadcrumb - Yoast**
- **Recipe: Breadcrumbs**

## [Required properties](#required-properties)

- **itemListElement**An array of `ListItem` objects, representing the position of the current page in the site hierarchy.

## [Examples](#examples)

### [Minimal](#minimal)

```
defineBreadcrumb({
  itemListElement: [
    { name: 'Home', item: '/' },
    { name: 'Blog', item: '/blog' },
    { name: 'My Article' },
  ],
})
```

## [Defaults](#defaults)

- **@type**: `BreadcrumbList`
- **@id**: `${canonicalUrl}#breadcrumb`

## [Relation Transforms](#relation-transforms)

**WebPage**

- sets default `breadcrumb` to this node

## [Resolves](#resolves)

- `itemListElement.position` is computed for each list element

## [Types](#types)

```
/**
 * A BreadcrumbList is an ItemList consisting of a chain of linked Web pages,
 * typically described using at least their URL and their name, and typically ending with the current page.
 */
export interface BreadcrumbSimple extends ItemList {}
```

## [Related Schemas](#related-schemas)

- **ItemList** - List structure
- **Article** - Article navigation
- **Product** - Product navigation

Edit this page

Markdown For LLMs

**Did this page help you? **

**Book Schema** Use defineBook() to add Book structured data. Enable rich results with book editions, ISBN, author, and purchase actions in Google search. **Comment Schema** Use defineComment() to add Comment structured data. Connect user comments to articles and blog posts with author and date information.