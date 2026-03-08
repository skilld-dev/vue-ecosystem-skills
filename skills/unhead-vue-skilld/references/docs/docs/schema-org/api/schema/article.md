---
title: "Article Schema - JSON-LD Guide & Examples · Unhead"
meta:
  "og:description": "Implement Article structured data with Unhead. JSON-LD examples for BlogPosting, NewsArticle, TechArticle with datePublished and author markup."
  "og:title": "Article Schema - JSON-LD Guide & Examples · Unhead"
  description: "Implement Article structured data with Unhead. JSON-LD examples for BlogPosting, NewsArticle, TechArticle with datePublished and author markup."
---

**Schema**

# **Article Schema - JSON-LD Guide & Examples**

Copy for LLMs

**On this page **

- [JSON-LD Example](#json-ld-example)
- [Schema.org Article](#schemaorg-article)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Defaults](#defaults)
- [Sub-Types](#sub-types)
- [Relation Transforms](#relation-transforms)
- [Resolves](#resolves)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)

Article schema identifies written content like blog posts, news articles, and technical documentation. It helps search engines understand authorship, publish dates, and content type for rich results in Google Search.

### [JSON-LD Example](#json-ld-example)

```
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "How to Build a REST API with Node.js",
  "image": "https://example.com/photos/api-guide.jpg",
  "datePublished": "2026-01-15T08:00:00+00:00",
  "dateModified": "2026-02-20T10:30:00+00:00",
  "author": {
    "@type": "Person",
    "name": "Jane Smith",
    "url": "https://example.com/authors/jane"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Dev Blog",
    "logo": {
      "@type": "ImageObject",
      "url": "https://example.com/logo.png"
    }
  }
}
```

With Unhead, generate this using the `defineArticle()` composable — see the [**API reference**](#schema-org-article) below.

Use the **Schema.org Generator** to build your structured data visually.

## [Schema.org Article](#schemaorg-article)

- **Type**: `defineArticle(input?: Article)`Describes an `Article` on a `WebPage`.

## [Useful Links](#useful-links)

- **Article - Schema.org**
- **Article Schema Markup - Google Search Central**
- **Article - Yoast**
- **Recipe: Blog**

## [Required properties](#required-properties)

- **headline** `string`Name of the articleA name can be provided using route meta on the `title` key, see [**defaults**](#defaults).
- **image** `Arrayable<string|ImageObject>`Link a primary image or a collection of images to used to the article.A single image URL can be provided using route meta on the `image` key, see [**defaults**](#defaults).
- **author** `AuthorInput` (conditional)If the author of the article is not your identity (see **Choosing an identity**) you will need to provide authors manually.The registered author is moved to a root Schema node, resolving the field as reference to a **Person**.

## [Recommended Properties](#recommended-properties)

- **@type** [**sub-types**](#sub-types)Select the most appropriate type for your content for the article.

## [Defaults](#defaults)

- **@type**: `Article`
- **@id**: `${canonicalUrl}#article`
- **headline**: `currentRouteMeta.title` _(see: **Schema.org Params**)_
- **image**: `currentRouteMeta.image` _(see: **Schema.org Params**)_
- **description**: `currentRouteMeta.description` _(see: **Schema.org Params**)_
- **inLanguage**: `options.defaultLanguage` _(see: **Schema.org Params**)_
- **datePublished**: `currentRouteMeta.datePublished` _(see: **Schema.org Params**)_
- **dateModified**: `currentRouteMeta.dateModified` _(see: **Schema.org Params**)_
- **publisher**: Identity Reference
- **author**: Identity Reference
- **isPartOf**: WebPage Reference
- **mainEntityOfPage**: WebPage Reference

## [Sub-Types](#sub-types)

- `AdvertiserContentArticle`
- `NewsArticle`
- `BlogPosting`
- `Report`
- `SatiricalArticle`
- `ScholarlyArticle`
- `SocialMediaPosting`
- `TechArticle`

## [Relation Transforms](#relation-transforms)

**WebPage**

- sets default `potentialAction` to `ReadAction`
- sets default `dateModified` to articles `dateModified`
- sets default `datePublished` to articles `datePublished`
- sets default `primaryImageOfPage` to articles first image

## [Resolves](#resolves)

See **Global Resolves** for full context.

- `headline` will be cut to a maximum length of 110 without breaking words.
- `thumbnailUrl` will be set to the first image
- `dateModified` or `datePublished` can be resolved from Date objects

```
defineArticle({
  // will resolve to ISO 8601 format
  datePublished: new Date(2024, 0o5, 29)
})
```

- providing a single string of `@type` which isn't `Article` will convert it to an array `TechArticle` -> `['Article', 'TechArticle']`

```
defineArticle({
  // will be resolved as ['Article', 'TechArticle']
  '@type': 'TechArticle',
})
```

## [Examples](#examples)

See the **blog** recipe for more examples.

### [Minimal](#minimal)

```
defineArticle({
  headline: 'Article Title',
  image: '/articles/article-title-image.jpg',
  // using identity as the author
})
```

### [Route Meta](#route-meta)

Add type support for using the routes meta.

```
defineArticle()
```

### [Complete](#complete)

```
defineArticle({
  headline: 'Article Title',
  description: 'Article description',
  image: '/articles/article-title-image.jpg',
  datePublished: new Date(2024, 0o5, 29),
  dateModified: new Date(2024, 0o5, 29),
  // attaching an author when the identity is an organization
  author: {
    name: 'Harlan Wilton',
    url: 'https://harlanzw.com',
  }
})
```

## [Types](#types)

```
type ValidArticleSubTypes = 'Article' | 'BlogPosting' | 'AdvertiserContentArticle' | 'NewsArticle' | 'Report' | 'SatiricalArticle' | 'ScholarlyArticle' | 'SocialMediaPosting' | 'TechArticle'

export interface ArticleSimple extends Thing {
  ['@type']?: Arrayable<ValidArticleSubTypes>
  /**
   * The headline of the article (falling back to the title of the WebPage).
   * Headlines should not exceed 110 characters.
   */
  headline?: string
  /**
   * A summary of the article (falling back to the page's meta description content).
   */
  description?: string
  /**
   * A reference-by-ID to the WebPage node.
   */
  isPartOf?: IdReference
  /**
   * The time at which the article was originally published, in ISO 8601 format; e.g., 2015-10-31T16:10:29+00:00.
   */
  datePublished?: ResolvableDate
  /**
   * The time at which the article was last modified, in ISO 8601 format; e.g., 2015-10-31T16:10:29+00:00.
   */
  dateModified?: ResolvableDate
  /**
   * A reference-by-ID to the author of the article.
   */
  author?: NodeRelations<Identity>
  /**
   * A reference-by-ID to the publisher of the article.
   */
  publisher?: NodeRelations<Identity>
  /**
   * An array of all videos in the article content, referenced by ID.
   */
  video?: NodeRelations<VideoObject>
  /**
   * An image object or referenced by ID.
   * - Must be at least 696 pixels wide.
   * - Must be of the following formats+file extensions: .jpg, .png, .gif ,or .webp.
   *
   * Must have markup of it somewhere on the page.
   */
  image?: NodeRelations<ImageObject | string>
  /**
   * An array of references by ID to comment pieces.
   */
  comment?: NodeRelations<Comment>
  /**
   * A thumbnail image relevant to the Article.
   */
  thumbnailUrl?: string
  /**
   * An integer value of the number of comments associated with the article.
   */
  commentCount?: number
  /**
   * An integer value of the number of words in the article.
   */
  wordCount?: number
  /**
   * An array of keywords which the article has (e.g., ["cats","dogs","cake"]).
   */
  keywords?: string[]
  /**
   * An array of category names which the article belongs to (e.g., ["cats","dogs","cake"]).
   */
  articleSection?: string[]
  /**
   * The language code for the article; e.g., en-GB.
   */
  inLanguage?: string
  /**
   * A SpeakableSpecification object which identifies any content elements suitable for spoken results.
   */
  speakable?: unknown
  /**
   * The year from which the article holds copyright status.
   */
  copyrightYear?: string
  /**
   * A reference-by-ID to the Organization or Person who holds the copyright.
   */
  copyrightHolder?: NodeRelations<Identity>
  /**
   * The body text of the article.
   */
  articleBody?: string
  /**
   * The subject matter of the article.
   */
  about?: string
}
```

## [Related Schemas](#related-schemas)

- **Person** - Article author
- **Organization** - Publisher
- **Breadcrumb** - Article navigation

Edit this page

Markdown For LLMs

**Did this page help you? **

**useSchemaOrg()** Add Schema.org structured data with useSchemaOrg(). Pass defineArticle(), defineProduct(), and other schema nodes for Google Rich Results. **Book Schema** Use defineBook() to add Book structured data. Enable rich results with book editions, ISBN, author, and purchase actions in Google search.

**On this page **

- [JSON-LD Example](#json-ld-example)
- [Schema.org Article](#schemaorg-article)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Defaults](#defaults)
- [Sub-Types](#sub-types)
- [Relation Transforms](#relation-transforms)
- [Resolves](#resolves)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)