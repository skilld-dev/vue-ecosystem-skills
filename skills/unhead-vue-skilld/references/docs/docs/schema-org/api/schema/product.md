---
title: "Product Schema · Unhead"
meta:
  "og:description": "Use defineProduct() to add Product structured data for e-commerce. Enable rich snippets with pricing, reviews, and availability in Google search results."
  "og:title": "Product Schema · Unhead"
  description: "Use defineProduct() to add Product structured data for e-commerce. Enable rich snippets with pricing, reviews, and availability in Google search results."
---

**Schema**

# **Product Schema**

Copy for LLMs

## [Schema.org Product](#schemaorg-product)

- **Type**: `defineProduct(input?: Product)`Describes an `Product` on a `WebPage`.

## [Useful Links](#useful-links)

- **Product - Schema.org**
- **Product Schema Markup - Google Search Central**
- **Product - Yoast**
- **Recipe: eCommerce**

## [Required properties](#required-properties)

- **name** `string`The name of the product. Provided via route meta key `title` or `name` manually.
- **image** `Arrayable<ImageInput>`Link a primary image or a collection of images to used to the product

## [Recommended Properties](#recommended-properties)

- **offers** `OfferInput[]`Add **Offer** properties.

## [Defaults](#defaults)

- **@type**: `Product`
- **@id**: `${canonicalUrl}#product`
- **name**: `currentRouteMeta.title` _(see: **Schema.org Params**)_
- **image**: `currentRouteMeta.image` _(see: **Schema.org Params**)_
- **description**: `currentRouteMeta.description` _(see: **Schema.org Params**)_
- **brand**: id reference of the identity
- **mainEntityOfPage** id reference of the web page

## [Resolves](#resolves)

See **Global Resolves** for full context.

- `image`'s are resolved to absolute

## [Examples](#examples)

### [Minimal Example](#minimal-example)

```
defineProduct({
  name: 'Guide To Vue.js',
  image: '/vuejs-book.png',
})
```

### [Other Example](#other-example)

```
defineProduct({
  name: 'test',
  image: '/product.png',
  offers: [
    { price: 50 },
  ],
  aggregateRating: {
    ratingValue: 88,
    bestRating: 100,
    ratingCount: 20,
  },
  review: [
    {
      name: 'Awesome product!',
      author: {
        name: 'Harlan Wilton',
      },
      reviewRating: {
        ratingValue: 5,
      },
    },
  ],
})
```

## [Types](#types)

```
/**
 * Any offered product or service.
 * For example: a pair of shoes; a concert ticket; the rental of a car;
 * a haircut; or an episode of a TV show streamed online.
 */
export interface ProductSimple extends Thing {
  /**
   * The name of the product.
   */
  name: string
  /**
   * A reference-by-ID to one or more imageObject's which represent the product.
   * - Must be at least 696 pixels wide.
   * - Must be of the following formats+file extensions: .jpg, .png, .gif ,or .webp.
   */
  image: NodeRelations<ImageObject | string>
  /**
   *  An array of references-by-ID to one or more Offer or aggregateOffer pieces.
   */
  offers?: NodeRelations<Offer | number>
  /**
   *  A reference to an Organization piece, representing brand associated with the Product.
   */
  brand?: NodeRelation<Organization>
  /**
   * A reference to an Organization piece which represents the seller/merchant.
   */
  seller?: NodeRelation<Organization>
  /**
   * A text description of the product.
   */
  description?: string
  /**
   * An array of references-by-id to one or more Review pieces.
   */
  review?: NodeRelations<Review>
  /**
   * A merchant-specific identifier for the Product.
   */
  sku?: string
  /**
   * The Global Trade Item Number (GTIN) of the product.
   */
  gtin?: string
  /**
   * The Manufacturer Part Number (MPN) of the product.
   */
  mpn?: string
  /**
   * The condition of the product (e.g., New, Used, Refurbished).
   */
  itemCondition?: string
  /**
   * An AggregateRating object.
   */
  aggregateRating?: NodeRelation<AggregateRating>
  /**
   * An AggregateOffer object.
   */
  aggregateOffer?: NodeRelation<AggregateOffer>
  /**
   * A reference to an Organization piece, representing the brand which produces the Product.
   */
  manufacturer?: NodeRelation<Organization>
}
```

## [Related Schemas](#related-schemas)

- **Organization** - Product brand/manufacturer
- **Breadcrumb** - Product navigation
- **ItemList** - Product lists

Edit this page

Markdown For LLMs

**Did this page help you? **

**Podcast Series Schema** Use definePodcastSeries() to add PodcastSeries structured data. Enable podcast rich results with show info, host, and RSS feed link. **Question Schema** Use defineQuestion() to add FAQ structured data. Enable FAQ rich snippets with expandable Q&A directly in Google search results.