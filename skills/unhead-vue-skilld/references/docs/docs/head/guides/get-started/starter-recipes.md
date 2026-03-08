---
title: "Starter Recipes · Unhead"
meta:
  "og:description": "Copy-paste recipes for SEO setup, social sharing meta, favicon config, PWA tags, and blog post optimization. Ready-to-use Unhead patterns."
  "og:title": "Starter Recipes · Unhead"
  description: "Copy-paste recipes for SEO setup, social sharing meta, favicon config, PWA tags, and blog post optimization. Ready-to-use Unhead patterns."
---

**Get Started**

# **Starter Recipes**

Copy for LLMs

**On this page **

- [Introduction](#introduction)
- [How do I set up basic SEO tags?](#how-do-i-set-up-basic-seo-tags)
- [How do I add social sharing meta tags?](#how-do-i-add-social-sharing-meta-tags)
- [How do I optimize blog post meta tags?](#how-do-i-optimize-blog-post-meta-tags)
- [How do I configure favicons and theme colors?](#how-do-i-configure-favicons-and-theme-colors)
- [How do I set up PWA meta tags?](#how-do-i-set-up-pwa-meta-tags)
- [See Also](#see-also)

**Quick Answer:** Copy-paste these common head management patterns: basic SEO setup, social sharing meta, favicon configuration, and third-party script loading.

## [Introduction](#introduction)

Unhead is built to get you running as quickly as possible. This guide provides a collection of snippets to implement common use cases for tags in your `<head>`.

If you'd like to learn more about how specific tags work, check out **Zhead: Head Tag Database** for a comprehensive list of tags and their usage.

### [What are the default head tags?](#what-are-the-default-head-tags)

Unhead itself provides defaults for, these can be overriden by you if you need to.

- `<meta charset="utf-8">` - Ensures special characters are displayed correctly.
- `<meta name="viewport" content="width=device-width, initial-scale=1">` - Ensures your app is responsive and works on all devices.

## [How do I set up basic SEO tags?](#how-do-i-set-up-basic-seo-tags)

While SEO is a complex topic, this starter is just for essential tags to get you started. You may consider combining this with the [**Social Share**](#how-do-i-add-social-sharing-meta-tags) and [**Blog Posts**](#how-do-i-optimize-blog-post-meta-tags) sections for a more complete solution.

The `lang` attribute and the semantic tags `<title>` and `<meta name="description">` are used to inform search engines about the focus of your page.

While `<link rel="canonical">` and `<meta name="robots">` are used to inform search engines about how to index your page.

A misconfigured canonical URL will result in indexing issues. If you're new to SEO, please read the **Controlling Web Crawlers** guide.

```
import { useHead, useSeoMeta } from 'unhead'

// [useHead](/docs/head/api/composables/use-head) - general head tag management
// [useSeoMeta](/docs/head/api/composables/use-seo-meta) - type-safe SEO meta tags
useHead(unheadInstance, {
  htmlAttrs: { lang: 'en-US' }, // BCP 47 language code
  link: [{
    rel: 'canonical',
    href: 'https://www.example.com/product'
  }]
})

useSeoMeta(unheadInstance, {
  title: 'About Us',
  titleTemplate: '%s - Site',
  description: 'Learn about our awesome site.',
})
```

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  htmlAttrs: { lang: 'en-US' }, // BCP 47 language code
  title: 'About Us | Company',
  titleTemplate: '%s - Site',
  meta: [
    {
      name: 'description',
      content: 'Learn how to bake delicious, moist cupcakes with our easy-to-follow guide. Featuring tips and tricks for beginners.'
    },
    // disable indexing with robots 'noindex, nofollow'
    { name: 'robots', content: 'index, follow' }
  ],
  link: [
    {
      rel: 'canonical',
      href: 'https://www.example.com/product'
    }
  ]
})
```

### [What optional SEO tags should I add?](#what-optional-seo-tags-should-i-add)

There are several SEO tags that are generally used but their importance is debated. These tags are not required for SEO, but they can be useful in certain situations.

Please check the other sections for other **open graph** tags.

```
import { useSeoMeta } from 'unhead'

useSeoMeta(unheadInstance, {
  ogType: 'website',
  ogUrl: 'https://www.example.com/product', // should match canonical URL
  ogLocale: 'en_US',
  ogSiteName: 'My Site',
})
```

### [Quick tips](#quick-tips)

- Providing `<meta name="keywords">` is no longer recommended by Google.
- Try and avoid duplicate titles and descriptions across your site. If a page is serving the same content, use `<link rel="canonical">` to inform search engines about the preferred URL.

## [How do I add social sharing meta tags?](#how-do-i-add-social-sharing-meta-tags)

Social share tags are used to control how your page is displayed when shared on social media platforms. All social share tags are either prefixed as **Open Graph** or **Twitter** meta tags.

These tags are commonly duplicated from the existing semantic tags, however, fine-tuning them for each platform can improve the click-through rate of your links.

```
import { useSeoMeta } from 'unhead'

useSeoMeta(unheadInstance, {
  // title & descriptions
  ogTitle: 'My Awesome Product',
  ogDescription: 'Learn how to bake delicious, moist cupcakes with our easy-to-follow guide. Featuring tips and tricks for beginners.',
  twitterTitle: 'My Awesome Product',
  twitterDescription: 'Learn how to bake delicious, moist cupcakes with our easy-to-follow guide. Featuring tips and tricks for beginners.',
  // no longer explicitly used by X but may be useful for SEO
  twitterSite: '@example',
  twitterCreator: '@example',
  // og image
  ogImage: {
    url: 'https://example.com/og-image.jpg',
    width: 1200,
    height: 600,
    alt: 'My Awesome Product',
    type: 'image/png'
  },
  twitterImage: {
    url: 'https://example.com/twitter-image.jpg',
    width: 1200,
    height: 600,
    alt: 'My Awesome Product',
    type: 'image/png'
  },
  // twitter image (note: ogImage is used as a fallback so this is optional)
  twitterCard: 'summary_large_image', // or summary
  // used by Slack
  twitterLabel1: 'Price',
  twitterData1: '$50',
  twitterLabel2: 'Read Time',
  twitterData2: '10 min',
})
```

```
import { useSeoMeta } from 'unhead'

useSeoMeta(unheadInstance, {
  ogImage: [
    {
      url: 'https://www.example.com/image1.png',
      alt: 'My Awesome Product',
      width: 1200,
      height: 630,
      type: 'image/png'
    },
    {
      url: 'https://www.example.com/image2.png',
      alt: 'My Awesome Product',
      width: 1200,
      height: 630,
      type: 'image/png'
    }
  ]
})
```

### [Quick tips](#quick-tips-1)

- Most sites only need the `<meta name="twitter:card">` Twitter tag as the Open Graph tags are used as a fallback.
- Try and make titles and descriptions relevant in the context of people sharing your page.

## [How do I optimize blog post meta tags?](#how-do-i-optimize-blog-post-meta-tags)

Blog posts are a common use case for more advanced SEO tags. These tags can provide more semantic meaning to your page and help search engines understand the content of your page better.

Make sure to combine these tags with the [**SEO Starter**](#how-do-i-set-up-basic-seo-tags) and [**Social Share**](#how-do-i-add-social-sharing-meta-tags) sections for a more complete solution.

```
import { useSeoMeta } from 'unhead'

useSeoMeta(unheadInstance, {
  ogType: 'article',
  articlePublishedTime: '2023-04-01T12:00:00Z',
  articleModifiedTime: '2023-05-10T14:45:00Z',
  articleAuthor: 'John Doe',
  articleSection: 'Technology', // category
  articleTag: ['JavaScript'],
  twitterLabel1: 'Author',
  twitterData1: 'John Doe',
  twitterLabel2: 'Read Time',
  twitterData2: '10 min',
})

// link to previous and next posts
useHead(unheadInstance, {
  link: [
    { rel: 'prev', href: 'https://site.com/blog/previous' },
    { rel: 'next', href: 'https://site.com/blog/next' }
  ]
})
```

### [Quick tips](#quick-tips-2)

- Combine it with **BlogPosting** Schema.org to provide more semantic meaning to your page.

## [How do I configure favicons and theme colors?](#how-do-i-configure-favicons-and-theme-colors)

There are several tags you can use to control how your site is displayed in the browser. These tags are not required for SEO, but they can be useful in certain situations.

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  link: [
    { rel: 'icon', href: '/favicon.ico', sizes: 'any' },
    { rel: 'icon', href: '/favicon.svg', sizes: 'any', type: 'image/svg+xml' },
    { rel: 'apple-touch-icon', sizes: '180x180', href: '/apple-touch-icon.png' },
  ],
  meta: [
    // used on some mobile browsers
    { name: 'theme-color', content: '#0000FF' },
    // choose light or dark (or both, see Light + Dark Mode)
    { name: 'color-scheme', content: 'light dark' },
  ]
})
```

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  meta: [
    { name: 'theme-color', content: '#0000FF', media: '(prefers-color-scheme: light)' },
    { name: 'theme-color', content: '#000000', media: '(prefers-color-scheme: dark)' },
    { name: 'color-scheme', content: 'light dark' }
  ]
})
```

### [Quick tips](#quick-tips-3)

- Using a favicon.ico packed with multiple sizes is best practice. You can use **RealFaviconGenerator** to generate a favicon.ico file with multiple sizes.
- Using an SVG icon is useful, but it may cause issues with some browsers.

## [How do I set up PWA meta tags?](#how-do-i-set-up-pwa-meta-tags)

Progressive Web Apps (PWAs) are a set of best practices for building web apps that work offline and provide a native app-like experience.

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  link: [
    { rel: 'manifest', href: '/manifest.json' },
    { rel: 'apple-touch-icon', href: '/apple-touch-icon.png' }
  ],
  meta: [
    { name: 'viewport', content: 'width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=5, viewport-fit=cover' },
    { name: 'theme-color', content: '#0000FF' },
    { name: 'apple-mobile-web-app-capable', content: 'yes' },
    { name: 'apple-mobile-web-app-status-bar-style', content: 'default' }
  ]
})
```

## [See Also](#see-also)

- **Titles Guide** - Page title management
- **useHead() API** - Full API reference
- **useSeoMeta() API** - SEO meta tags

Edit this page

Markdown For LLMs

**Did this page help you? **

**Introduction to Unhead** Manage document head in SSR and CSR environments. Lazy DOM patching, TypeScript API, flat SEO meta, Schema.org support, and script loading. **Titles & Title Templates** Learn how to master page titles using useHead, title templates, and SEO best practices. Includes reactive titles, social sharing, and template params.

**On this page **

- [Introduction](#introduction)
- [How do I set up basic SEO tags?](#how-do-i-set-up-basic-seo-tags)
- [How do I add social sharing meta tags?](#how-do-i-add-social-sharing-meta-tags)
- [How do I optimize blog post meta tags?](#how-do-i-optimize-blog-post-meta-tags)
- [How do I configure favicons and theme colors?](#how-do-i-configure-favicons-and-theme-colors)
- [How do I set up PWA meta tags?](#how-do-i-set-up-pwa-meta-tags)
- [See Also](#see-also)