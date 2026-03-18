---
title: "WebSite Schema · Unhead"
meta:
  "og:description": "Use defineWebSite() to add WebSite structured data. Establish your site identity and enable sitelinks search box in Google search results."
  "og:title": "WebSite Schema · Unhead"
  description: "Use defineWebSite() to add WebSite structured data. Establish your site identity and enable sitelinks search box in Google search results."
---

**Schema**

# **WebSite Schema**

Copy for LLMs

## [Schema.org WebSite](#schemaorg-website)

- **Type**: `defineWebSite(input?: WebSite)`Describes a WebSite. Parent to WebPage.

## [Useful Links](#useful-links)

- **Schema.org WebSite**

## [Required properties](#required-properties)

- **name** `string`The title of the page.A name can be provided using route meta on the `title` key, see [**defaults**](#defaults).

## [Defaults](#defaults)

- **@type**: `WebSite`
- **@id**: `${canonicalHost}#website`
- **url**: `canonicalHost`
- **inLanguage**: `options.defaultLanguage` _(see: **user Config**)_
- **publisher**: Identity reference

## [Example](#example)

```
defineWebSite({
  name: 'My Site',
})
```

## [Types](#types)

```
/**
 * A WebSite is a set of related web pages and other items typically served from a single web domain and accessible via URLs.
 */
export interface WebSiteSimple extends Thing {
  /**
   * The site's home URL (excluding a trailing slash).
   */
  url?: string
  /**
   * The name of the website.
   */
  name: string
  /**
   * A description of the website (e.g., the site's tagline).
   */
  description?: string
  /**
   * The date the website was first published.
   */
  datePublished?: string
  /**
   * The date the website was last modified.
   */
  dateModified?: string
  /**
   * A reference-by-ID to the Organization which publishes the WebSite
   * (or an array of Organization and Person in the case that the website represents an individual).
   */
  publisher?: NodeRelations<Identity>
  /**
   * A SearchAction object describing the site's internal search.
   */
  potentialAction?: Arrayable<(SearchAction | unknown)>
  /**
   * The language code for the WebSite; e.g., en-GB.
   * If the website is available in multiple languages, then output an array of inLanguage values.
   */
  inLanguage?: Arrayable<string>
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**WebPage Schema** Use defineWebPage() to add WebPage structured data. Connect page content to your site hierarchy with automatic page type detection.