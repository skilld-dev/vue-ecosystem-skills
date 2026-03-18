---
title: "What is Capo.js? Why HTML Head Tag Order Matters · Unhead"
meta:
  "og:description": "How HTML head tag ordering affects page load performance. Complete Capo.js weight reference, common mistakes, and how Unhead automates optimal ordering."
  "og:title": "What is Capo.js? Why HTML Head Tag Order Matters · Unhead"
  author: "Harlan Wilton"
  description: "How HTML head tag ordering affects page load performance. Complete Capo.js weight reference, common mistakes, and how Unhead automates optimal ordering."
---

**Guide**10 min read

# **What is Capo.js? Why HTML Head Tag Order Matters**

Harlan Wilton Published **Mar 5, 2026**

## [What is Capo.js?](#what-is-capojs)

**Capo.js** is a set of rules by **Rick Viscomi** (Chrome DevRel) defining the optimal order of HTML `<head>` tags for page load performance. Named after the guitar capo - it tunes your `<head>` by putting every tag in the right position.

Browsers parse `<head>` top-to-bottom. Wrong order means delayed rendering, unnecessary re-parsing, and slower LCP.

**Unhead implements Capo.js sorting automatically.** Every tag from `useHead()` is placed in optimal position - zero config.

## [Why order matters](#why-order-matters)

The HTML parser processes `<head>` sequentially:

- `<meta charset>` **after the title** → browser re-parses the document when it discovers a different encoding
- **Sync** `<script>` **before CSS** → blocks both rendering and stylesheet loading
- `<link rel="preconnect">` **after the resource it helps** → arrives too late to matter
- **Render-blocking resources before critical metadata** → delays the browser's understanding of the page

Bad order:

```
<head>
  <title>My Page</title>
  <script src="/app.js"></script>
  <link rel="stylesheet" href="/style.css">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link rel="preconnect" href="https://fonts.googleapis.com">
</head>
```

Problems: charset after title triggers re-parse, sync script blocks CSS, preconnect comes after the stylesheet that needs it.

With Capo.js ordering:

```
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>My Page</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="stylesheet" href="/style.css">
  <script src="/app.js"></script>
</head>
```

## [Complete Weight Reference](#complete-weight-reference)

Unhead implements all 14 Capo.js weight levels. Lower weight = placed first in `<head>`:

| **Priority** | **Weight** | **Tag** | **Why** |
| --- | --- | --- | --- |
| 1 | -30 | `<meta http-equiv="Content-Security-Policy">` | **The Preload Scanner Stall:** Must be first. Late CSP tags can **disable the Chromium preload scanner**, forcing resources to load sequentially. |
| 2 | -20 | `<meta charset>` | Encoding must be in first 1024 bytes |
| 3 | -15 | `<meta name="viewport">` | Prevents mobile layout shifts |
| 4 | -10 | `<base>` | Affects all relative URLs after it |
| 5 | 10 | `<title>` | First visible content in browser tab |
| 6 | 20 | `<link rel="preconnect">` | Early DNS + TLS for critical origins |
| 7 | 30 | `<script async>` | Fetch ASAP, non-blocking |
| 8 | 40 | `<style>` with `@import` | Render-blocking; must discover imports early |
| 9 | 50 | `<script src>` (sync) | Render-blocking but unavoidable |
| 10 | 60 | `<link rel="stylesheet">` / `<style>` | Render-blocking CSS |
| 11 | 70 | `<link rel="preload">` / `<link rel="modulepreload">` | Hints for soon-needed resources |
| 12 | 80 | `<script defer>` / `<script type="module">` | Non-blocking, post-parse execution |
| 13 | 90 | `<link rel="prefetch">` / `<link rel="dns-prefetch">` | Low-priority future navigation hints |
| 14 | 100 | Everything else | `<meta name="description">`, OG tags, JSON-LD |

### [Weight groups](#weight-groups)

**-30 to -10 (critical metadata)** must appear first - `<meta charset>` after 1024 bytes forces re-parsing, late viewport causes mobile layout shifts.

**10-20 (content & connections):** `<title>` for the browser tab, `<link rel="preconnect">` to establish connections before they're needed.

**30-60 (render-blocking resources):** `<script async>` gets discovered early for fetching. Sync `<script>` and `<link rel="stylesheet">` in their optimal relative order.

**70-100 (deferred & hints):** `<link rel="preload">`, `<script defer>`, `<link rel="prefetch">`, and everything else. These don't affect initial rendering.

## [Common Mistakes](#common-mistakes)

### [The "Head-Breaker"](#the-head-breaker)

A common mistake is placing an invalid tag (like `<img>` or `<iframe>`) inside the `<head>`. The browser's DOM builder implicitly closes the `<head>` and moves everything after the invalid tag to the `<body>`.

According to the **Web Almanac 2025**, invalid head markup remains a significant issue for **22% of all mobile pages**. This "breaks" SEO and performance because the parser discovers critical meta tags and styles too late.

### [Charset after the title](#charset-after-the-title)

```

<title>My Page</title>
<meta charset="utf-8">


<meta charset="utf-8">
<title>My Page</title>
```

The **HTML spec** requires `<meta charset>` within the first 1024 bytes. Content before it may trigger re-parsing.

### [CSS before preconnects](#css-before-preconnects)

```

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter">
<link rel="preconnect" href="https://fonts.googleapis.com">


<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter">
```

### [Sync scripts blocking CSS](#sync-scripts-blocking-css)

```

<script src="/analytics.js"></script>
<link rel="stylesheet" href="/style.css">


<link rel="stylesheet" href="/style.css">
<script src="/analytics.js"></script>
```

Better - make analytics async:

```
<script async src="/analytics.js"></script>
<link rel="stylesheet" href="/style.css">
```

### [Preloads after what they preload](#preloads-after-what-they-preload)

```

<link rel="stylesheet" href="/style.css">
<link rel="preload" href="/font.woff2" as="font" crossorigin>


<link rel="preload" href="/font.woff2" as="font" crossorigin>
<link rel="stylesheet" href="/style.css">
```

## [Automatic Sorting with Unhead](#automatic-sorting-with-unhead)

Every `useHead()` call produces Capo.js-ordered output:

```
import { useHead } from 'unhead'

useHead({
  meta: [
    { charset: 'utf-8' }, // weight: -20
    { name: 'viewport', content: 'width=device-width' }, // weight: -15
    { name: 'description', content: 'My page' }, // weight: 100
  ],
  title: 'My Page', // weight: 10
  link: [
    { rel: 'preconnect', href: 'https://fonts.googleapis.com' }, // weight: 20
    { rel: 'stylesheet', href: '/style.css' }, // weight: 60
  ],
})
```

Unhead sorts the output by weight regardless of input order.

### [Custom priority](#custom-priority)

Override the default ordering with `tagPriority`:

```
useHead({
  script: [
    {
      src: '/critical-polyfill.js',
      tagPriority: 'critical', // -8 offset (higher priority)
    },
    {
      src: '/analytics.js',
      tagPriority: 'low', // +2 offset (lower priority)
    },
  ],
})
```

Priority aliases (applied as offsets to the tag's calculated weight):

- `'critical'` - subtracts 8 from weight
- `'high'` - subtracts 1
- `'low'` - adds 2
- Any number - exact weight override

Relative positioning with `before:` and `after:` prefixes:

```
useHead({
  script: [
    {
      src: '/my-script.js',
      tagPriority: 'before:script:analytics',
    },
  ],
})
```

## [Check Your Site](#check-your-site)

Capo AnalyzerPaste HTML or enter a URL to get instant feedback on your head tag ordering, with specific suggestions for improvement.

For the measured performance impact of head tag ordering, including the **"Nuxt Paradox"** where automatic ordering isn't enough to fix slow LCP, see **Does Head Tag Order Affect Performance?**. For how streaming SSR interacts with head management, see **Streaming SSR SEO**.

**Did this page help you? **

**Capo.js Performance**