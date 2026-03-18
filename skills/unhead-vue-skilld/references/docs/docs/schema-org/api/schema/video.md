---
title: "Video Schema · Unhead"
meta:
  "og:description": "Use defineVideo() to add VideoObject structured data. Enable video rich snippets with thumbnails, duration, and upload date in Google search results."
  "og:title": "Video Schema · Unhead"
  description: "Use defineVideo() to add VideoObject structured data. Enable video rich snippets with thumbnails, duration, and upload date in Google search results."
---

**Schema**

# **Video Schema**

Copy for LLMs

## [Schema.org Video](#schemaorg-video)

- **Type**: `defineVideo(input?: Video)`Describes an individual video (usually in the context of an embedded media object).

## [Useful Links](#useful-links)

- **VideoObject - Schema.org**
- **Video - Yoast**

## [Required properties](#required-properties)

- **name** `string`The title of the video.Can be provided using route meta on the `title` key, see [**defaults**](#defaults).
- **description** `string`A description of the video (falling back to the caption, then to 'No description').Can be provided using route meta on the `description` key, see [**defaults**](#defaults).
- **thumbnail** `ImageObject`An image of the video thumbnail.Can be provided using route meta on the `image` key, see [**defaults**](#defaults).
- **thumbnailUrl** `string | string[]`A URL pointing to the video thumbnail image file. Follow the **thumbnail image guidelines**.
- **uploadDate** `string`The date the video was published, in ISO 8601 formatCan be provided using route meta on the `datePublished` key, see [**defaults**](#defaults).

## [Defaults](#defaults)

- **@type**: `VideoObject`
- **@id**: `${canonicalUrl}#/schema/video/${hash(image.url)}`
- **inLanguage**: `options.defaultLanguage` (only when caption is provided) _(see: **user Config**)_
- **contentUrl**: is set to `url`

## [Resolves](#resolves)

See **Global Resolves** for full context.

- `width` and `height` must be provided for either to be included

## [Example](#example)

```
defineVideo({
  name: 'My cool video',
  uploadDate: new Date(Date.UTC(2020, 10, 10)),
  url: '/image.png',
})
```

## [Types](#types)

```
export interface VideoSimple extends Thing {
  /**
   * The title of the video.
   */
  name?: string
  /**
   * A description of the video (falling back to the caption, then to 'No description').
   */
  description?: string
  /**
   * A reference-by-ID to an imageObject.
   */
  thumbnail?: NodeRelation<ImageObject>
  /**
   * A URL pointing to the video thumbnail image file. Follow the [thumbnail image guidelines](https://developers.google.com/search/docs/appearance/video#provide-a-high-quality-thumbnail).
   */
  thumbnailUrl?: Arrayable<string>
  /**
   * The date the video was published, in ISO 8601 format (e.g., 2020-01-20).
   */
  uploadDate?: ResolvableDate
  /**
   * Whether the video should be considered 'family friendly'
   */
  isFamilyFriendly?: boolean
  /**
   * The URL of the image file (e.g., /images/cat.jpg).
   */
  url: string
  /**
   * The fully-qualified, absolute URL of the image file (e.g., https://www.example.com/images/cat.jpg).
   * Note: The contentUrl and url properties are intentionally duplicated.
   */
  contentUrl?: string
  /**
   * A text string describing the image.
   * - Fall back to the image alt attribute if no specific caption field exists or is defined.
   */
  caption?: string
  /**
   * The height of the image in pixels.
   * - Must be used with width.
   */
  height?: number
  /**
   * The width of the image in pixels.
   * - Must be used with height.
   */
  width?: number
  /**
   * The language code for the textual content; e.g., en-GB.
   * - Only needed when providing a caption.
   */
  inLanguage?: string
  /**
   * The duration of the video in ISO 8601 format.
   */
  duration?: string
  /**
   * A URL pointing to a player for the video.
   */
  embedUrl?: string
  /**
   * The encoding format of the video.
   */
  encodingFormat?: string
  /**
   * A transcript of the video.
   */
  transcript?: string
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**TV Series Schema** Use defineTVSeries() to add TVSeries structured data. Enable rich results for TV shows with cast, creator, ratings, and season info. **WebPage Schema** Use defineWebPage() to add WebPage structured data. Connect page content to your site hierarchy with automatic page type detection.