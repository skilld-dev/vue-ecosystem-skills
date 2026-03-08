---
title: "ItemList Schema - JSON-LD Guide & Examples · Unhead"
meta:
  "og:description": "Add ItemList structured data with Unhead. JSON-LD examples for carousels, ranked lists, and product collections with Google rich result support."
  "og:title": "ItemList Schema - JSON-LD Guide & Examples · Unhead"
  description: "Add ItemList structured data with Unhead. JSON-LD examples for carousels, ranked lists, and product collections with Google rich result support."
---

**Schema**

# **ItemList Schema - JSON-LD Guide & Examples**

Copy for LLMs

**On this page **

- [JSON-LD Example](#json-ld-example)
- [Schema.org ItemList](#schemaorg-itemlist)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Types](#types)
- [Related Schemas](#related-schemas)

ItemList schema represents an ordered or unordered list of items. Google uses it to display carousel rich results for recipes, products, courses, and other list-based content.

### [JSON-LD Example](#json-ld-example)

```
{
  "@context": "https://schema.org",
  "@type": "ItemList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "url": "https://example.com/best-phones/iphone"
    },
    {
      "@type": "ListItem",
      "position": 2,
      "url": "https://example.com/best-phones/pixel"
    },
    {
      "@type": "ListItem",
      "position": 3,
      "url": "https://example.com/best-phones/galaxy"
    }
  ]
}
```

With Unhead, generate this using the `defineItemList()` composable — see the [**API reference**](#schema-org-itemlist) below.

Use the **Schema.org Generator** to build your structured data visually.

## [Schema.org ItemList](#schemaorg-itemlist)

- **Type**: `defineItemList(input?: ItemList)`

A list of items of any sort. Mainly used for breadcrumbs and carousels.

## [Useful Links](#useful-links)

- **ItemList - Schema.org**
- **Carousel - Google**

## [Required properties](#required-properties)

- **itemListElement** `ListItem`The item list elements.

## [Types](#types)

```
export interface ItemListSimple extends Thing {
  /**
   * Resolved item list
   */
  itemListElement: NodeRelations<ListItem>
  /**
   * Type of ordering (e.g. Ascending, Descending, Unordered).
   *
   * @default undefined
   */
  itemListOrder?: 'Ascending' | 'Descending' | 'Unordered'
  /**
   * The number of items in an ItemList.
   * Note that some descriptions might not fully describe all items in a list (e.g., multi-page pagination);
   * in such cases, the numberOfItems would be for the entire list.
   *
   * @default undefined
   */
  numberOfItems?: number
}
```

## [Related Schemas](#related-schemas)

- **Breadcrumb** - Navigation lists
- **Product** - Product lists
- **Article** - Article lists

Edit this page

Markdown For LLMs

**Did this page help you? **

**Image Schema** Use defineImage() to add ImageObject structured data. Provide image metadata with captions, dimensions, and alt text for rich results. **JobPosting** Implement JobPosting structured data with Unhead. JSON-LD examples, required fields for Google Jobs, salary markup, and validation tips.

**On this page **

- [JSON-LD Example](#json-ld-example)
- [Schema.org ItemList](#schemaorg-itemlist)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Types](#types)
- [Related Schemas](#related-schemas)