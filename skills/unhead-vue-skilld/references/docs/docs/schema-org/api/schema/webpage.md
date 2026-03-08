---
title: "WebPage Schema · Unhead"
meta:
  "og:description": "Use defineWebPage() to add WebPage structured data. Connect page content to your site hierarchy with automatic page type detection."
  "og:title": "WebPage Schema · Unhead"
  description: "Use defineWebPage() to add WebPage structured data. Connect page content to your site hierarchy with automatic page type detection."
---

**Schema**

# **WebPage Schema**

Copy for LLMs

**On this page **

- [Schema.org WebPage](#schemaorg-webpage)
- [Useful Links](#useful-links)
- [Recommended properties](#recommended-properties)
- [Defaults](#defaults)
- [Sub-Types](#sub-types)
- [Relation Transforms](#relation-transforms)
- [Resolves](#resolves)
- [Example](#example)
- [Types](#types)

## [Schema.org WebPage](#schemaorg-webpage)

- **Type**: `defineWebPage(input?: WebPage)`Describes a single page on a WebSite. Acts as a container for sub-page elements (such as Article).Acts as a connector from a page's content to the parent WebSite (and in turn, to the Organization).

## [Useful Links](#useful-links)

- **Schema.org WebPage**

## [Recommended properties](#recommended-properties)

- **name** `string`The title of the page.A name can be provided using route meta on the `title` key, see [**defaults**](#defaults).

## [Defaults](#defaults)

- **@type**: inferred from path, fallbacks to `WebPage`, see [**resolves**](#resolves)
- **@id**: `${canonicalUrl}#webpage`
- **url**: `canonicalUrl`
- **name**: `currentRouteMeta.title` _(see: **Schema.org Params**)_
- **isPartOf**: WebSite reference

Home page only

- **about**: Identity Reference
- **primaryImageOfPage**: Logo reference

## [Sub-Types](#sub-types)

- `AboutPage`
- `CheckoutPage`
- `CollectionPage`
- `ContactPage`
- `FAQPage`
- `ItemPage`
- `MedicalWebPage`
- `ProfilePage`
- `QAPage`
- `RealEstateListing`
- `SearchResultsPage`

## [Relation Transforms](#relation-transforms)

**WebPage**

- sets `potentialAction` to `ReadAction`
- sets `dateModified` to articles `dateModified`
- sets `datePublished` to articles `datePublished`

## [Resolves](#resolves)

- `dateModified` or `datePublished` can be resolved from Date objects

```
defineWebPage({
  // will resolve to ISO 8601 format
  datePublished: new Date(2020, 10, 1)
})
```

- providing a single string of `@type` which isn't `WebPage` will convert it to an array `TechArticle` -> `['WebPage', 'AboutPage']`

```
defineWebPage({
  // will be resolved as ['WebPage', 'AboutPage']
  '@type': 'AboutPage',
})
```

- @type based on last URL path-- `/about`, `/about-us` -> `AboutPage`-- `/search` -> `SearchResultsPage`-- `/checkout` -> `CheckoutPage`-- `/contact`, `/get-in-touch`, `/contact-us` -> `ContactPage`-- `/faq` -> `FAQPage`

## [Example](#example)

```
defineWebPage({
  name: 'Page Title',
  image: '/image.jpg',
})
```

## [Types](#types)

```
/**
 * A web page.
 * Every web page is implicitly assumed to be declared to be of type WebPage,
 * so the various properties about that webpage, such as breadcrumb may be used.
 */
type ValidSubTypes = 'WebPage' | 'AboutPage' | 'CheckoutPage' | 'CollectionPage' | 'ContactPage' | 'FAQPage' | 'ItemPage' | 'MedicalWebPage' | 'ProfilePage' | 'QAPage' | 'RealEstateListing' | 'SearchResultsPage'

/**
 * A web page.
 * Every web page is implicitly assumed to be declared to be of type WebPage,
 * so the various properties about that webpage, such as breadcrumb may be used.
 */
export interface WebPageSimple extends Thing {
  ['@type']?: Arrayable<ValidSubTypes>
  /**
   * The unmodified canonical URL of the page.
   */
  url?: string
  /**
   * The title of the page.
   */
  name?: string
  /**
   * The page's meta description content.
   */
  description?: string
  /**
   * A reference-by-ID to the WebSite node.
   */
  isPartOf?: NodeRelation<WebSite>
  /**
   * A reference-by-ID to the Organisation node.
   * Note: Only for the home page.
   */
  about?: NodeRelation<Organization>
  /**
   * A reference-by-ID to the author of the web page.
   */
  author?: NodeRelation<Person | string>
  /**
   * The language code for the page; e.g., en-GB.
   */
  inLanguage?: Arrayable<string>
  /**
   * The time at which the page was originally published, in ISO 8601 format; e.g., 2015-10-31T16:10:29+00:00.
   */
  datePublished?: ResolvableDate
  /**
   * The time at which the page was last modified, in ISO 8601 format; e.g., 2015-10-31T16:10:29+00:00.
   */
  dateModified?: ResolvableDate
  /**
   * A reference-by-ID to a node representing the page's featured image.
   */
  primaryImageOfPage?: NodeRelation<ImageObject | string>
  /**
   * A reference-by-ID to a node representing the page's breadrumb structure.
   */
  breadcrumb?: NodeRelation<BreadcrumbList>
  /**
   * An array of all videos in the page content, referenced by ID.
   */
  video?: NodeRelations<VideoObject>
  /**
   * A SpeakableSpecification object which identifies any content elements suitable for spoken results.
   */
  speakable?: unknown
  /**
   * The time at which the page was last reviewed, in ISO 8601 format.
   */
  lastReviewed?: string
  /**
   * An array of keywords describing the page.
   */
  keywords?: string[]
  /**
   * Potential actions for this web page.
   *
   * Note it's on by default for most page types.
   */
  potentialAction?: Arrayable<(ReadAction | unknown)>
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Video Schema** Use defineVideo() to add VideoObject structured data. Enable video rich snippets with thumbnails, duration, and upload date in Google search results. **WebSite Schema** Use defineWebSite() to add WebSite structured data. Establish your site identity and enable sitelinks search box in Google search results.

**On this page **

- [Schema.org WebPage](#schemaorg-webpage)
- [Useful Links](#useful-links)
- [Recommended properties](#recommended-properties)
- [Defaults](#defaults)
- [Sub-Types](#sub-types)
- [Relation Transforms](#relation-transforms)
- [Resolves](#resolves)
- [Example](#example)
- [Types](#types)