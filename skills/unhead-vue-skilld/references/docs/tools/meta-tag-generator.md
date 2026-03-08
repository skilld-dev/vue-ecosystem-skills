---
title: "Meta Tag Generator - Generate useSeoMeta Code · Unhead"
meta:
  "og:description": "Generate SEO meta tags as useSeoMeta() composable code. Preview Google SERP and social cards."
  "og:title": "Meta Tag Generator | Unhead"
  description: "Free meta tag generator for Vue, React, Nuxt, and more. Generate useSeoMeta() code with live SERP and social card preview."
---

# **Meta Tag Generator**

Generate useSeoMeta() code for Vue, React, Nuxt, and more. Preview how your page will look in search results and social shares.

**Quick Start**

**Title**28/60

Title is short (aim for 50-60 characters)

**Description**111/160

**Site Name**

**Locale**

**OG Title**

Leave empty to use page title

**OG Description**

Leave empty to use page description

**OG Image URL**

Recommended: 1200x630px

**Image Alt**

**Width**

**Height**

**OG Type**

**OG URL**

Article metadata helps search engines and social platforms understand your content better.

**Published Date**

**Modified Date**

**Author**

Author name or profile URL

**Section**

Category or section name

**Tags**

Comma-separated keywords

**Author**

Page author name

**Canonical URL**

**Robots**

**Theme Color**

Browser UI color

**Color Scheme**

**App Name**

PWA application name

**Facebook App ID**

### **Google Preview **

Example Blog

https://example.com/blog/build-better-web-apps

### How to Build Better Web Apps | Example Blog

Master modern web development with our comprehensive guide to building performant applications.

### **Social Card Preview **



Example Blog

**How to Build Better Web Apps | Example Blog**

Master modern web development with our comprehensive guide to building performant applications.

Twitter/X uses Open Graph tags as fallback. Configure Twitter-specific overrides below.

**Card Type**

**Twitter Image**

Override OG image for Twitter (different aspect ratio)

**Site @handle**

**Creator @handle**

**Generated Code**

```
import { useSeoMeta } from 'unhead'

useSeoMeta({
  title: 'How to Build Better Web Apps',
  description: 'Learn the best practices for building modern, performant web applications with the latest frameworks and tools.',
  author: 'John Doe',
  colorScheme: 'light dark',
  themeColor: '#1a1a2e',
  ogTitle: 'How to Build Better Web Apps | Example Blog',
  ogDescription: 'Master modern web development with our comprehensive guide to building performant applications.',
  ogImage: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=1200&h=630&fit=crop',
  ogImageAlt: 'Code on a computer screen showing JavaScript',
  ogImageWidth: 1200,
  ogImageHeight: 630,
  ogType: 'article',
  ogUrl: 'https://example.com/blog/build-better-web-apps',
  ogSiteName: 'Example Blog',
  ogLocale: 'en_US',
  articlePublishedTime: '2024-01-15T09:00:00Z',
  articleModifiedTime: '2024-01-20T14:30:00Z',
  articleAuthor: 'https://example.com/authors/john-doe',
  articleSection: 'Technology',
  articleTag: 'javascript, web development, best practices',
  twitterCard: 'summary_large_image',
  twitterSite: '@exampleblog',
  twitterCreator: '@johndoe',
  twitterImage: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=1200&h=600&fit=crop',
  twitterLabel1: 'Reading time',
  twitterData1: '5 min read',
  twitterLabel2: 'Written by',
  twitterData2: 'John Doe',
  robots: 'index, follow, max-image-preview:large',
})
```

## **Why Use useSeoMeta?**

The useSeoMeta composable provides a type-safe, flat API for setting meta tags. Unlike manually writing meta tags, it handles all the complexity for you.

**Type-safe**Full TypeScript support with auto-completion

**XSS-safe**Values are properly escaped

**SSR-ready**Works seamlessly with server-side rendering

**Flat API**No nested objects - just set properties directly

## **Meta Tag Best Practices**

### **Title Tag **

- Keep under 60 characters
- Front-load important keywords
- Make each page title unique

### **Description **

- Keep under 160 characters
- Include a call to action
- Match search intent

### **Open Graph **

- Use 1200x630px images
- Always set og:title and og:description
- Include og:url for canonical sharing

### **Twitter Cards **

- Use summary_large_image for articles
- Include @handle for attribution
- Test with Twitter Card Validator

## **Learn More**

  

### **Discover More Tools **

<h4>**OG Image Generator**</h4>Design and generate beautiful Open Graph images for your website. OG Image Generator <h4>**Schema.org Generator**</h4>Build structured data for articles, products, and more. Schema.org Generator <h4>**Capo.js Head Analyzer**</h4>Analyze your HTML head tag order for optimal page load performance. Capo.js Head Analyzer

**Was this tool helpful? **

Your feedback helps us improve