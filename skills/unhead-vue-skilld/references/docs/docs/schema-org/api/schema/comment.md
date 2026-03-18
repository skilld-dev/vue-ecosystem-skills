---
title: "Comment Schema · Unhead"
meta:
  "og:description": "Use defineComment() to add Comment structured data. Connect user comments to articles and blog posts with author and date information."
  "og:title": "Comment Schema · Unhead"
  description: "Use defineComment() to add Comment structured data. Connect user comments to articles and blog posts with author and date information."
---

**Schema**

# **Comment Schema**

Copy for LLMs

## [Schema.org Comment](#schemaorg-comment)

- **Type**: `defineComment(input?: Comment)`Describes a comment. Usually in the context of an Article or a WebPage.

## [Useful Links](#useful-links)

- **Comment - Schema.org**
- **Comment - Yoast**
- **Recipe: Blog**

## [Required properties](#required-properties)

- **text** `string`Content of the comment

## [Recommended Properties](#recommended-properties)

- **author** `Person`The registered author is moved to a root Schema node, resolving the field as reference to a **Person**.

## [Defaults](#defaults)

- **@type**: `Comment`
- **@id**: `${canonicalUrl}#/schema/comment/${hash(node)}`
- **about**: Article reference

## [Resolves](#resolves)

- `author` will be resolved as root nodes and referenced

## [Examples](#examples)

See the **blog** recipe for more examples.

### [Minimal](#minimal)

```
defineComment({
  text: 'This is really cool!',
  author: {
    name: 'Harlan Wilton',
    url: 'https://harlanzw.com',
  }
})
```

## [Types](#types)

```
export interface CommentSimple extends Thing {
  /**
   * The textual content of the comment, stripping HTML tags.
   */
  text: string
  /**
   *  A reference by ID to the parent Article (or WebPage, when no Article is present).
   */
  about?: IdReference
  /**
   * A reference by ID to the Person who wrote the comment.
   */
  author: NodeRelation<Person>
  /**
   * The date and time the comment was created.
   */
  dateCreated?: string
  /**
   * The date and time the comment was last modified.
   */
  dateModified?: string
  /**
   * The number of upvotes the comment has received.
   */
  upvoteCount?: number
  /**
   * The number of downvotes the comment has received.
   */
  downvoteCount?: number
}
```

## [Related Schemas](#related-schemas)

- **Person** - Comment author
- **Article** - Commented content

Edit this page

Markdown For LLMs

**Did this page help you? **

**Breadcrumb Schema** Use defineBreadcrumb() to add BreadcrumbList structured data. Display clickable navigation paths in Google search results for better user experience. **Course Schema** Use defineCourse() to add Course structured data. Enable rich results for educational courses with provider, description, and course details.