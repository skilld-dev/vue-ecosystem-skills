---
title: "Person Schema · Unhead"
meta:
  "og:description": "Use definePerson() to add Person structured data. Establish author identity for articles and content with name, image, and social profile links."
  "og:title": "Person Schema · Unhead"
  description: "Use definePerson() to add Person structured data. Establish author identity for articles and content with name, image, and social profile links."
---

**Schema**

# **Person Schema**

Copy for LLMs

**On this page **

- [Schema.org Person](#schemaorg-person)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Examples](#examples)
- [Defaults](#defaults)
- [Resolves](#resolves)
- [Types](#types)
- [Related Schemas](#related-schemas)

## [Schema.org Person](#schemaorg-person)

- **Type**: `definePerson(input?: Person)`Describes an individual person. Most commonly used to identify the author of a piece of content (such as an Article or Comment).

## [Useful Links](#useful-links)

- **Schema.org Person**
- **Choose an Identity - Person**

## [Required properties](#required-properties)

- **name** `string`The name of the person.

## [Recommended Properties](#recommended-properties)

- **image** `ImageInput`Avatar image url of the person
- **link** `string` or **sameAs** `string[]`Links that describe the person, for example their website or social accounts.

## [Examples](#examples)

### [Minimal](#minimal)

```
definePerson({
  name: 'Harlan Wilton',
  image: '/me.png',
})
```

## [Defaults](#defaults)

- **@type**: `Person`
- **@id**: `${canonicalHost}#identity`
- **url**: `canonicalHost`

## [Resolves](#resolves)

See **Global Resolves** for full context.

- resolves relative string urls of `image`
- omitting the `@id` attribute, will automatically set up the person to be the identity of the WebSite and author of any content.

## [Types](#types)

```
/**
 * A person (alive, dead, undead, or fictional).
 */
export interface PersonSimple extends Thing {
  /**
   * The full name of the Person.
   */
  name: string
  /**
   * The user bio, truncated to 250 characters.
   */
  description?: string
  /**
   * An array of URLs representing declared social/authoritative profiles of the person
   * (e.g., a Wikipedia page, or Facebook profile).
   */
  sameAs?: Arrayable<string>
  /**
   * An array of images which represent the person, referenced by ID.
   */
  image?: NodeRelations<ImageObject | string>
  /**
   * The URL of the users' profile page (if they're affiliated with the site in question),
   * or to their personal homepage/website.
   */
  url?: string
}
```

## [Related Schemas](#related-schemas)

- **Organization** - Person's employer
- **Article** - Articles by person

Edit this page

Markdown For LLMs

**Did this page help you? **

**Organization** Add Organization structured data with Unhead. JSON-LD examples for company identity, logo, sameAs social profiles, and Google Knowledge Panel setup. **Podcast Episode Schema** Use definePodcastEpisode() to add PodcastEpisode structured data. Enable podcast rich results with episode title, audio, and description.

**On this page **

- [Schema.org Person](#schemaorg-person)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Examples](#examples)
- [Defaults](#defaults)
- [Resolves](#resolves)
- [Types](#types)
- [Related Schemas](#related-schemas)