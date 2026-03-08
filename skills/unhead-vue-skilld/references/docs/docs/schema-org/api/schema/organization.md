---
title: "Organization Schema - JSON-LD Guide & Examples · Unhead"
meta:
  "og:description": "Add Organization structured data with Unhead. JSON-LD examples for company identity, logo, sameAs social profiles, and Google Knowledge Panel setup."
  "og:title": "Organization Schema - JSON-LD Guide & Examples · Unhead"
  description: "Add Organization structured data with Unhead. JSON-LD examples for company identity, logo, sameAs social profiles, and Google Knowledge Panel setup."
---

**Schema**

# **Organization Schema - JSON-LD Guide & Examples**

Copy for LLMs

**On this page **

- [JSON-LD Example](#json-ld-example)
- [Schema.org Organization](#schemaorg-organization)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Examples](#examples)
- [Defaults](#defaults)
- [Resolves](#resolves)
- [Types](#types)
- [Related Schemas](#related-schemas)

Organization schema establishes your company or brand identity for search engines. It powers Google's Knowledge Panel, connects social profiles via `sameAs`, and serves as the publisher/author identity for other schema types like Article and LocalBusiness.

### [JSON-LD Example](#json-ld-example)

```
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Acme Corp",
  "url": "https://acme.com",
  "logo": "https://acme.com/logo.png",
  "sameAs": [
    "https://twitter.com/acme",
    "https://github.com/acme",
    "https://linkedin.com/company/acme"
  ],
  "contactPoint": {
    "@type": "ContactPoint",
    "telephone": "+1-800-555-0199",
    "contactType": "customer service"
  }
}
```

With Unhead, generate this using the `defineOrganization()` composable — see the [**API reference**](#schema-org-organization) below.

Use the **Schema.org Generator** to build your structured data visually.

## [Schema.org Organization](#schemaorg-organization)

- **Type**: `defineOrganization(input?: Organization)`Describes an organization (a company, business or institution). Most commonly used to identify the publisher of a WebSite.

## [Useful Links](#useful-links)

- **Organization - Schema.org**
- **Organization - Yoast**
- **Choose an Identity - Organization**

## [Required properties](#required-properties)

- **name** `string`The name of the business.

## [Recommended Properties](#recommended-properties)

- **logo** `SingleImageInput`Logo image url, can be relative to your site root.
- **sameAs** `string[]`An array of URLs that also belong to the Organization
- **telephone** `string`The telephone number of the organization.
- **email** `string`The email address of the organization.
- **foundingDate** `string`The date the organization was founded.

## [Examples](#examples)

### [Minimal](#minimal)

```
defineOrganization({
  name: 'My Site',
  logo: '/logo.png',
  sameAs: [
    'https://www.facebook.com/my-site',
    'https://twitter.com/my-site',
    'https://www.instagram.com/my-site',
    'https://www.youtube.com/my-site',
  ]
})
```

## [Defaults](#defaults)

- **@type**: `Organization`
- **@id**: `${canonicalHost}#identity`
- **url**: `canonicalHost`

## [Resolves](#resolves)

See **Global Resolves** for full context.

- address as `PostalAddress` object
- resolves string urls of `logo` into a `ImageObject` with the id of `#logo`

For example:

```
defineOrganization({
  name: 'Nuxt.js',
  logo: '/img/logo.png',
})
```

Will resolve the logo url into an ImageObject with the id of `#logo`

```
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@id": "https://nuxtjs.org/#logo",
      "@type": "ImageObject",
      "url": "https://nuxtjs.org/img/logo.png"
    },
    {
      "@id": "https://nuxtjs.org/#identity",
      "@type": "Organization",
      "name": "Nuxt.js",
      "logo": {
        "@id": "https://nuxtjs.org/#logo"
      }
    }
  ]
}
```

## [Types](#types)

```
/**
 * An organization such as a school, NGO, corporation, club, etc.
 */
export interface Organization extends Thing {
  /**
   * A reference-by-ID to an image of the organization's logo.
   *
   * - The image must be 112x112px, at a minimum.
   * - Make sure the image looks how you intend it to look on a purely white background
   * (for example, if the logo is mostly white or gray,
   * it may not look how you want it to look when displayed on a white background).
   */
  logo?: NodeRelation<ImageObject | string>
  /**
   * The site's home URL.
   */
  url?: string
  /**
   * The name of the Organization.
   */
  name: string
  /**
   * An array of URLs representing declared social/authoritative profiles of the organization
   * (e.g., a Wikipedia page, or Facebook profile).
   */
  sameAs?: Arrayable<string>
  /**
   * An array of images which represent the organization (including the logo ), referenced by ID.
   */
  image?: NodeRelations<ImageObject | string>
  /**
   * A reference-by-ID to an PostalAddress piece.
   */
  address?: NodeRelations<PostalAddress>
  /**
   * The telephone number of the organization.
   */
  telephone?: string
  /**
   * The email address of the organization.
   */
  email?: string
  /**
   * The date the organization was founded.
   */
  foundingDate?: string
}
```

## [Related Schemas](#related-schemas)

- **Person** - Organization members
- **LocalBusiness** - Physical locations

Edit this page

Markdown For LLMs

**Did this page help you? **

**Music Recording Schema** Use defineMusicRecording() to add MusicRecording structured data. Display song info with artist, album, and duration in search results. **Person Schema** Use definePerson() to add Person structured data. Establish author identity for articles and content with name, image, and social profile links.

**On this page **

- [JSON-LD Example](#json-ld-example)
- [Schema.org Organization](#schemaorg-organization)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Examples](#examples)
- [Defaults](#defaults)
- [Resolves](#resolves)
- [Types](#types)
- [Related Schemas](#related-schemas)