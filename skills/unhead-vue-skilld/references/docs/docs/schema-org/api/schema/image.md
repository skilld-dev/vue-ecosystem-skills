---
title: "Image Schema · Unhead"
meta:
  "og:description": "Use defineImage() to add ImageObject structured data. Provide image metadata with captions, dimensions, and alt text for rich results."
  "og:title": "Image Schema · Unhead"
  description: "Use defineImage() to add ImageObject structured data. Provide image metadata with captions, dimensions, and alt text for rich results."
---

**Schema**

# **Image Schema**

Copy for LLMs

**On this page **

- [Schema.org Image](#schemaorg-image)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Defaults](#defaults)
- [Resolves](#resolves)
- [Examples](#examples)
- [Types](#types)

## [Schema.org Image](#schemaorg-image)

- **Type**: `defineImage(input?: Image)`

Describes an individual image (usually in the context of an embedded media object).

## [Useful Links](#useful-links)

- **ImageObject - Schema.org**
- **Image - Yoast**

## [Required properties](#required-properties)

- **url** `string`The URL of the image file (e.g., /images/cat.jpg).

## [Defaults](#defaults)

- **@type**: `ImageObject`
- **@id**: `${canonicalUrl}#/schema/image/${hash(image.url)}`
- **inLanguage**: `options.defaultLanguage` (only when caption is provided) _(see: **user Config**)_
- **contentUrl**: is set to `url`

## [Resolves](#resolves)

See **Global Resolves** for full context.

- `width` and `height` must be provided for either to be included

## [Examples](#examples)

### [Minimal](#minimal)

```
defineImage({
  url: '/cat.jpg',
})
```

## [Types](#types)

```
export interface ImageSimple extends Thing {
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
   * The name of the image.
   */
  name?: string
  /**
   * A description of the image.
   */
  description?: string
  /**
   * The file format or media type of the image (e.g., image/jpeg).
   */
  encodingFormat?: string
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**HowTo** Add HowTo structured data to your site with Unhead. Step-by-step JSON-LD examples, required properties, and Google rich result guidance. **ItemList** Add ItemList structured data with Unhead. JSON-LD examples for carousels, ranked lists, and product collections with Google rich result support.

**On this page **

- [Schema.org Image](#schemaorg-image)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Defaults](#defaults)
- [Resolves](#resolves)
- [Examples](#examples)
- [Types](#types)