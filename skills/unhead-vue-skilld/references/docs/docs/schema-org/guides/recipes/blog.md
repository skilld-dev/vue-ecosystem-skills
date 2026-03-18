---
title: "Schema.org for a Blog · Unhead"
meta:
  "og:description": "Add Article/BlogPosting structured data with defineArticle(). Enable rich snippets for author, publish date, and thumbnails in search results."
  "og:title": "Schema.org for a Blog · Unhead"
  description: "Add Article/BlogPosting structured data with defineArticle(). Enable rich snippets for author, publish date, and thumbnails in search results."
---

**Recipes**

# **Schema.org for a Blog**

Copy for LLMs

Use `defineArticle()` with `@type: 'BlogPosting'` to mark up blog posts. This enables rich snippets showing author, publish date, and article images in search results.

Schema.org Article markup helps Google display enhanced search results with author info, thumbnails, and publication dates - improving click-through rates.

## [Useful Links](#useful-links)

- **Article | Google Search Central**
- **Article Schema | Yoast**

## [How do I mark up a blog article?](#how-do-i-mark-up-a-blog-article)

The **defineArticle** function is provided to create Article Schema whilst handling relations for you.

Note that some fields may already be inferred, see **Schema.org Params**

```
import { defineArticle, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineArticle({
    // name and description can usually be inferred
    image: '/photos/16x9/photo.jpg',
    datePublished: new Date(2020, 1, 1),
    dateModified: new Date(2020, 1, 1),
  })
])
```

## [How do I specify the article type?](#how-do-i-specify-the-article-type)

Providing a type of Article can help clarify what kind of content the page is about.

The most common types are: `BlogPosting` and `NewsArticle`.

```
import { defineArticle, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineArticle({
    '@type': 'BlogPosting',
    // ...
  })
])
```

See the **Article Types** for the list of available types.

## [How do I add an author?](#how-do-i-add-an-author)

If the author of the article isn't the **site identity**, then you'll need to config the author or authors.

When defining a Person when an Article is present, it will automatically associate them as the author.

```
import { defineArticle, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineArticle({
    headline: 'My Article',
    author: [
      {
        name: 'John doe',
        url: 'https://johndoe.com',
      },
      {
        name: 'Jane doe',
        url: 'https://janedoe.com',
      },
    ]
  })
])
```

## [How do I mark up blog archive pages?](#how-do-i-mark-up-blog-archive-pages)

Assuming you have the `WebPage` and `WebSite` schema loaded in from a parent layout component, you can augment the `WebPage` type to better indicate the purpose of the page.

See **CollectionPage** for more information.

```
import { defineWebPage, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineWebPage({
    '@type': 'CollectionPage'
  }),
])
```

## [Expected JSON-LD Output](#expected-json-ld-output)

The above code generates JSON-LD like this:

```
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "BlogPosting",
      "@id": "https://example.com/blog/my-post/#article",
      "headline": "My Article",
      "image": "https://example.com/photos/16x9/photo.jpg",
      "datePublished": "2020-02-01T00:00:00.000Z",
      "dateModified": "2020-02-01T00:00:00.000Z",
      "author": [
        { "@type": "Person", "name": "John doe", "url": "https://johndoe.com" }
      ],
      "mainEntityOfPage": { "@id": "https://example.com/blog/my-post/" }
    }
  ]
}
```

## [Common Issues](#common-issues)

### [Missing `image` warning](#missing-image-warning)

Google requires at least one image for Article rich results. Always provide `image`.

### [`datePublished` format errors](#datepublished-format-errors)

Use JavaScript `Date` objects—Unhead handles ISO 8601 conversion automatically.

### [Author not showing](#author-not-showing)

If using site identity as author, ensure you've called `defineOrganization()` or `definePerson()` in your layout.

## [Related Recipes](#related-recipes)

- **Setting Up Your Identity** - Define your organization/person
- **Breadcrumbs** - Add navigation breadcrumbs
- **FAQ Page** - Add FAQ structured data

Edit this page

Markdown For LLMs

**Did this page help you? **

**Identity** Set up Organization, Person, or LocalBusiness as your site identity. Enable Google Knowledge Panel and connect content to E-E-A-T signals. **Breadcrumbs** Add BreadcrumbList structured data with defineBreadcrumb(). Display clickable navigation paths instead of URLs in Google search results.