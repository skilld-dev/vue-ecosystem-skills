---
title: "Page Titles with Unhead · Unhead"
meta:
  "og:description": "Learn how to master page titles using useHead, title templates, and SEO best practices. Includes reactive titles, social sharing, and template params."
  "og:title": "Page Titles with Unhead · Unhead"
  description: "Learn how to master page titles using useHead, title templates, and SEO best practices. Includes reactive titles, social sharing, and template params."
---

**Core Concepts**

# **Page Titles with Unhead**

Copy for LLMs

**On this page **

- [Introduction](#introduction)
- [What is the title tag?](#what-is-the-title-tag)
- [Core Concepts](#core-concepts)
- [Dynamic Page Titles with useHead()](#dynamic-page-titles-with-usehead)
- [How do I add a site name to all titles?](#how-do-i-add-a-site-name-to-all-titles)
- [Common Use Cases](#common-use-cases)
- [Best Practices](#best-practices)
- [Key Takeaways](#key-takeaways)

## [Introduction](#introduction)

Page titles are crucial for SEO. They're your primary call-to-action in search results and help users understand your page's content and context.

**Quick Answer:** Use `useHead({ title: 'Your Title' })` for SSR-safe titles. Add `titleTemplate: '%s | Site Name'` for consistent branding across pages.

```
<head>
  <title>Mastering Titles · My App</title>
</head>
```

Page titles are often the first impression users have of your site in search results. Well-crafted titles can significantly improve click-through rates.

While setting page titles with Unhead is straightforward, certain scenarios can be tricky. Let's start with the essential patterns you should follow.

## [What is the title tag?](#what-is-the-title-tag)

The `<title>` tag displays text in browser tabs and typically appears as your page's heading in search engine results (SERPs).

When working with JavaScript frameworks, you might be tempted to set titles directly:

```
// ❌ Careful! This won't work in SSR
document.title = 'Home'
```

This approach has two major issues:

- It breaks during Server-Side Rendering (SSR)
- Search engines may not properly index your titles

New to SEO titles? Check out Google's guide on **Influencing your title links in search results**.

## [Core Concepts](#core-concepts)

Unhead provides a simple yet powerful API for managing page titles across different rendering contexts (SSR and CSR) that works with any JavaScript framework.

## [Dynamic Page Titles with `useHead()`](#dynamic-page-titles-with-usehead)

Now that we understand why direct title manipulation won't work, let's use Unhead's `useHead()` composable to set titles properly:

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  title: 'Home'
})
```

```
<head>
  <title>Home</title>
</head>
```

This single line creates an SSR-friendly title that search engines can read. The composable handles all the complexity of managing your document head in both client and server environments.

You can use this in any component and set any `<head>` tag you like.

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  title: 'Home',
  meta: [
    { name: 'description', content: 'Welcome to MyApp' }
  ]
})
```

Unhead will automatically dedupe title tags if you set them in multiple components. The last one to render will take precedence.

The `useHead()` API works the same way across all supported frameworks (Vue, React, Svelte, Solid, and Angular). The only difference is how reactivity is handled in each framework.

## [How do I add a site name to all titles?](#how-do-i-add-a-site-name-to-all-titles)

You may notice that most people set up their titles with a site name and a separator, this is seen as a best practice as it can help with brand recognition and SEO.

```
<head>
  <title>Home | MySite</title>
</head>
```

Creating your own title like this is simple using `useHead()` with a title template.

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  title: 'Home',
  titleTemplate: '%s | MySite'
})
```

```
<head>
  <title>Home | MySite</title>
</head>
```

**Template params** like `%s` act as placeholders that get replaced with your page title and separator.

### [Template Params](#template-params)

Template params are an opt-in feature make your tags more dynamic. You get `%s` and `%separator` built-in, and can add your own:

Input

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  title: 'Home',
  titleTemplate: '%s %separator %siteName',
  templateParams: {
    separator: '·',
    siteName: 'My Site'
  }
})
```

Output

```
<title>Home · My Site</title>
```

Template params work with all head tags, not just titles. This makes them powerful for reusing branded elements across your site.

Check out the **Template Params** guide to get started.

### [Resetting the Title Template](#resetting-the-title-template)

If you need to reset the title template for a specific page, you can pass `null` to the `titleTemplate` option.

```
<script lang="ts" setup>
import { useHead } from 'unhead'

useHead(unheadInstance, {
  title: 'Home',
  titleTemplate: null
})
</script>
```

```
<head>
  <title>Home</title>
</head>
```

Resetting the title template will remove any branding elements from your page title. Only do this for specific pages like the homepage where the full branding isn't needed.

### [Social Share Titles](#social-share-titles)

Social platforms use different meta tags for sharing titles.

In the above we can see the title "Nuxt: The Intuitive Vue Framework".

This title is set using the `twitter:title` meta tag and will fall back to the `og:title` meta tag if not set.

Remembering how to use the meta tags can be annoying, so we can use the `useSeoMeta()` composable to set these up.

```
import { useSeoMeta } from 'unhead'

useSeoMeta(unheadInstance, {
  titleTemplate: '%s | Health Tips',
  title: 'Why you should eat more broccoli',
  // og title is not effected by titleTemplate, we can use template params here if we need
  ogTitle: 'Hey! Health Tips - 10 reasons to eat more broccoli.',
  // explicit twitter title is only needed when we want to display something just for X
  twitterTitle: 'Hey X! Health Tips - 10 reasons to eat more broccoli.',
})
```

```
<head>
  <title>Why you should eat more broccoli | Health Tips</title>
  <meta property="og:title" content="Health Tips: 10 reasons to eat more broccoli." />
  <meta name="twitter:title" content="Hey X! Health Tips - 10 reasons to eat more broccoli." />
</head>
```

The `useSeoMeta` API is identical across all supported frameworks - Vue, React, Svelte, Solid, and Angular.

## [Common Use Cases](#common-use-cases)

Here are some practical examples for handling page titles in different scenarios.

### [Reactive Titles](#reactive-titles)

Titles can be reactive, updating when your component data changes. Here's how this works in different frameworks:

```
import { useHead } from 'unhead'
import { ref } from 'vue'

const productName = ref('Widget X')
const isLoading = ref(true)

useHead(unheadInstance, {
  title: () => isLoading.value
    ? 'Loading...'
    : \`Product: ${productName.value}\`
})
```

```
import { useHead } from 'unhead'
import { useState } from 'react'

function ProductPage() {
  const [productName, setProductName] = useState('Widget X')
  const [isLoading, setIsLoading] = useState(true)

  useHead({
    title: () => isLoading
      ? 'Loading...'
      : \`Product: ${productName}\`
  })

  return <div>Product Page</div>
}
```

```
import { useHead } from 'unhead'
import { createSignal } from 'solid-js'

function ProductPage() {
  const [productName, setProductName] = createSignal('Widget X')
  const [isLoading, setIsLoading] = createSignal(true)

  useHead({
    title: () => isLoading()
      ? 'Loading...'
      : \`Product: ${productName()}\`
  })

  return <div>Product Page</div>
}
```

### [Hierarchical Titles](#hierarchical-titles)

For nested pages like documentation, show hierarchy:

```
import { useHead } from 'unhead'

// Works in any framework
useHead(unheadInstance, {
  title: 'Installation',
  titleTemplate: '%s | Documentation | MyApp'
})
```

### [Language-Specific Titles](#language-specific-titles)

For multilingual sites:

```
import { useHead } from 'unhead'

// In a real app, you'd get this from your i18n library
const locale = 'en'

const titles = {
  en: 'Welcome',
  fr: 'Bienvenue',
  es: 'Bienvenido'
}

useHead(unheadInstance, {
  title: titles[locale] || titles.en,
  htmlAttrs: {
    lang: locale
  }
})
```

```
import { useHead } from 'unhead'
import { useTranslation } from 'react-i18n' // Example i18n library

function HomePage() {
  const { t, i18n } = useTranslation()

  useHead({
    title: t('home.title'),
    htmlAttrs: {
      lang: i18n.language
    }
  })

  return <div>Home Page</div>
}
```

## [Best Practices](#best-practices)

- Keep titles under 60 characters to avoid truncation in search results
- Put important keywords at the beginning of the title
- Make each page title unique across your site
- Use title templates for consistent branding
- Ensure titles accurately describe the page content

## [Key Takeaways](#key-takeaways)

- Use `useHead()` instead of `document.title` for SSR compatibility
- Set `titleTemplate` in your app entry for consistent branding
- Use `useSeoMeta()` for separate social sharing titles (og:title, twitter:title)
- Keep titles under 60 characters to avoid truncation in search results
- Use template params for dynamic site name and separator across all pages

Edit this page

Markdown For LLMs

**Did this page help you? **

**Starter Recipes** Copy-paste recipes for SEO setup, social sharing meta, favicon config, PWA tags, and blog post optimization. Ready-to-use Unhead patterns. **Tag Sorting & Placement** Control where head tags render with tagPosition (head, bodyOpen, bodyClose) and tagPriority for ordering. Optimize performance with Capo.js weights.

**On this page **

- [Introduction](#introduction)
- [What is the title tag?](#what-is-the-title-tag)
- [Core Concepts](#core-concepts)
- [Dynamic Page Titles with useHead()](#dynamic-page-titles-with-usehead)
- [How do I add a site name to all titles?](#how-do-i-add-a-site-name-to-all-titles)
- [Common Use Cases](#common-use-cases)
- [Best Practices](#best-practices)
- [Key Takeaways](#key-takeaways)