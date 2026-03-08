---
title: "The State of <head> in 2026: 660,000 Sites Audited · Unhead"
meta:
  "og:description": "We analyzed 660,000+ sites across 8 frameworks to answer: is your framework shipping a complete <head>? The results are worse than expected."
  "og:title": "The State of <head> in 2026: 660,000 Sites Audited · Unhead"
  author: "Harlan Wilton"
  description: "We analyzed 660,000+ sites across 8 frameworks to answer: is your framework shipping a complete <head>? The results are worse than expected."
---

**Research**22 min read

# **The State of <head> in 2026: 660,000 Sites Audited**

Harlan Wilton Published **Mar 5, 2026**

**On this page **

- [What We Measured](#what-we-measured)
- [Framework Scorecard](#framework-scorecard)
- [The Description Problem](#the-description-problem)
- [The Social Sharing Gap](#the-social-sharing-gap)
- [What Streaming Drops](#what-streaming-drops)
- [Head-Breakers: The Silent Parser Bug](#head-breakers-the-silent-parser-bug)
- [Duplicate & Conflicting Tags](#duplicate-conflicting-tags)
- [Third-Party Head Pollution](#third-party-head-pollution)
- [Why Heads Break](#why-heads-break)
- [Does Any of This Affect Performance?](#does-any-of-this-affect-performance)
- [What's Next](#whats-next)
- [How Unhead Addresses This](#how-unhead-addresses-this)
- [Method](#method)

37.5% of **Angular** sites show a different title after JavaScript runs than what the server sent. 68% are missing a `<meta name="description">` entirely.

We queried HTTP Archive (Feb 2026) and CrUX (Jan 2026) across **660,000+ desktop origins** and 8 frameworks. Most frameworks ship incomplete `<head>` tags, the causes vary, and the frameworks with the "best" heads don't have the best performance.

## [What We Measured](#what-we-measured)

Head tags only work if they're in the HTML before JavaScript runs. Social crawlers (Twitter, Facebook, LinkedIn, Slack, Discord) never execute JS. Googlebot does, but with a delay - meaning incorrect initial tags can persist in search results for hours to days.

We used **Wappalyzer** detection in **HTTP Archive** to identify frameworks across 660,000+ desktop origins, then measured everything from basic tag presence to structural issues like head-breakers and duplicate tags. The full method is in the [**Method**](#method) section. We start with three core health metrics.

## [Framework Scorecard](#framework-scorecard)

For each origin we checked three things: does the `<title>` change after JS runs (indicating incomplete SSR), is a `<title>` present in raw HTML at all, and is a `<meta name="description">` present in raw HTML?

**Under 5% title change** (Qwik, Remix, Astro): all three resolve head data before sending any HTML. Qwik blocks at the loader level. Remix's `meta()` export is synchronous. Astro resolves everything in page-level frontmatter. They trade flexibility for correctness.

**5-15%** (Next.js, Nuxt, Gatsby): these support async head data with fallback mechanisms - Next.js patches with late-streamed `<script>` tags, Nuxt holds `</head>` open, Gatsby pre-renders at build time. The 9-14% failure rate comes from sites that misuse or skip these mechanisms.

**Over 15%** (**SvelteKit**, Angular): SvelteKit flushes `<head>` immediately - late data is gone. Angular's number comes from its SPA heritage: most Angular apps set titles client-side via the `Title` service, which runs after hydration.

## [The Description Problem](#the-description-problem)

Titles get attention, but **descriptions are worse across every framework**. Even Astro - the most complete - is missing descriptions on 11.9% of origins. Angular hits 68.2%.

Developers treat descriptions as optional. Frameworks don't warn when a page ships without one. CMS integrations populate titles but leave descriptions empty. Unlike a missing title (which shows as a blank browser tab), a missing description fails silently.

But descriptions directly affect search click-through rates. Google uses `<meta name="description">` as the snippet text. Without one, Google pulls a random sentence from the page body - usually a poor choice.

Consider treating a missing `<meta name="description">` as a build warning, not a silent omission.

## [The Social Sharing Gap](#the-social-sharing-gap)

Titles and descriptions are only half the story. Social platforms don't use `<meta name="description">` - they use Open Graph tags. And Open Graph completeness is worse than everything above.

The Open Graph Protocol requires four tags: `og:title`, `og:type`, `og:image`, and `og:url`. But `og:image` is the one that breaks social cards. Without it:

- **Twitter/X** shows a text-only card with lower engagement
- **Facebook** renders a gray placeholder
- **LinkedIn** shows a bare link with a generic icon
- **Slack and Discord** show no image preview
- **iMessage** shows a plain URL with no rich preview

From our **HTTP Archive** queries, only **~48% of desktop pages** include an `og:image`. Over half the web ships broken social cards.

The reason is obvious: `og:title` can be auto-populated from `<title>`. `og:description` can fall back to `<meta name="description">`. But `og:image` requires an actual image URL - there's no fallback, and CMS integrations that auto-populate text fields can't auto-generate an image.

None of these social crawlers execute JavaScript. Twitterbot, facebookexternalhit, LinkedInBot, Slackbot, Discordbot - they all parse raw HTML with aggressive timeouts (3–5 seconds). If your OG tags come from client-side rendering, they don't exist.

Frameworks that provide structured SEO APIs (`useSeoMeta()`, `generateMetadata()`) show better OG completeness because the API surfaces `ogImage` as a named field. When the right thing is easy, developers do it.

## [What Streaming Drops](#what-streaming-drops)

Even when tags are set correctly on the server, streaming can lose them. We sampled 10,000 Next.js pages and compared tag presence in chunked (streaming) vs non-chunked responses:

Titles and descriptions survive streaming. **JSON-LD drops 66%**. Canonical URLs drop 18%.

JSON-LD powers rich results - review stars, recipe cards, FAQ accordions, product prices. If your structured data comes from async data (product API, CMS), streaming frameworks flush `<head>` before it's ready.

Missing canonicals mean Google guesses which URL variant is authoritative. On sites with query params, pagination, or locales, this creates duplicate content. See our **streaming SSR research** for how each framework handles this.

## [Head-Breakers: The Silent Parser Bug](#head-breakers-the-silent-parser-bug)

Beyond missing tags, there are tags that are _present but displaced_. A "head-breaker" is any non-metadata element inside `<head>` that forces the browser to implicitly close `</head>` and start `<body>`. Per the **WHATWG HTML parsing spec**, only `<meta>`, `<title>`, `<link>`, `<style>`, `<script>`, `<base>`, `<template>`, and `<noscript>` are allowed. Everything else, `<div>`, `<img>`, `<iframe>`, `<a>`, triggers an implicit end tag.

When a head-breaker fires, the browser parses every tag after it as body content. The browser still applies stylesheets found after the break, but Chromium downgrades their network priority from `Highest` to `High`. On throttled connections, this delay is measurable: moving a critical `<link>` above a head-breaking `<img>` can **cost up to ~200ms of FCP on throttled connections**.

The top offenders from HTTP Archive:

- **`<img>` (29%)**: tracking pixels from analytics and ad platforms injected into `<head>` via third-party snippets
- **`<div>` (11%)**: malformed template output, WordPress plugin injection, or SSR hydration artifacts
- **`<noscript>` with flow content**: GTM's `<noscript><iframe>` pattern is documented to go in `<body>`, but developers routinely place it in `<head>`. With scripting disabled (some SEO crawlers), this breaks the head.

Chrome's preload scanner continues scanning after a head-breaker - it doesn't stop discovering resources. But the main thread parser has already switched to body mode, and resource prioritization follows. The practical impact: your `<link rel="canonical">` and `<meta name="robots">` tags end up in the DOM's `<body>`, where some crawlers ignore them.

## [Duplicate & Conflicting Tags](#duplicate-conflicting-tags)

Component-based architecture makes duplicate head tags a structural problem. Multiple components call `useHead()`, nested layouts each set a `<title>`, and plugins inject their own meta tags. Without deduplication, the HTML ships with conflicts.

From our HTTP Archive queries, ~3% of mobile pages have multiple `<title>` elements. ~3.5% have duplicate `<meta name="description">` tags. These numbers are low because most frameworks handle the easy cases. The dangerous duplicates are subtler:

**Conflicting canonicals** are the worst. **Google Search Central** explicitly states: if multiple `<link rel="canonical">` tags point to different URLs, Google ignores all of them. Your link equity splits, tracking parameters get indexed, and duplicate content filters activate. This commonly happens when a CMS plugin and a framework layout both inject canonicals.

**Conflicting robots directives** follow a **"most restrictive wins" rule**. If one `<meta name="robots">` says `index` and another says `noindex`, the page is treated as `noindex`. The same applies when `<meta name="robots">` conflicts with an `X-Robots-Tag` HTTP header - the stricter directive wins regardless of location.

How frameworks handle deduplication:

| **Framework** | **Strategy** | **Risk** |
| --- | --- | --- |
| **Nuxt / Unhead** | Key-based dedup by `name`/`property`; last wins | Low - automatic |
| **Next.js** | Shallow merge; page overrides layout | Low - built-in |
| **SvelteKit** | Additive, `<svelte:head>` blocks concatenate | **High**, duplicate titles ship |
| **Angular** | `addTag()` appends; must use `updateTag()` manually | **High**: appends by default |
| **WordPress** | Theme + Yoast + page builder all inject | **High**: plugin conflicts |

## [Third-Party Head Pollution](#third-party-head-pollution)

The biggest source of head-breakers and displaced tags? Third-party scripts.

Per **Web Almanac 2025**, **92% of pages** include third-party JavaScript. On commercial sites using GTM with GA4, Facebook Pixel, and Hotjar, the ratio of third-party to first-party tags in `<head>` is typically **3:1**. A standard GTM container adds 8–12 tags to `<head>` after execution.

This matters for three reasons:

**Parser blocking.** A/B testing tools (Optimizely, VWO) require synchronous `<script>` tags in `<head>` to prevent flicker. These block the parser until fetched and executed - every millisecond of latency delays CSS discovery.

**Ordering destruction.** Unhead and Capo.js can sort first-party tags optimally on the server. But the moment third-party JavaScript runs `document.head.appendChild()`, that ordering is gone. GTM injecting a sync script before your stylesheets delays CSS parsing regardless of your server-side ordering.

**Head-breaker injection.** Third-party snippets are the primary source of the [**head-breakers**](#head-breakers-the-silent-parser-bug) described above - tracking pixels and misplaced GTM snippets that force the browser to close `</head>` early.

Instead of GTM injecting 10 scripts into the browser, server-side tagging sends one request to a GTM server that fans out to GA4, Facebook, etc. This eliminates head pollution and is the single most impactful change for sites with heavy analytics.

## [Why Heads Break](#why-heads-break)

The sections above each describe a symptom. But these causes don't act alone - they compound. Here are the four root causes behind 660,000 origins of incomplete heads:

1. **Client-side head setting.** The framework renders a shell, then JavaScript sets tags after hydration. Angular (37.5% title mismatch) and Gatsby (13.9%) are the primary offenders. Social crawlers never see the JS-set tags.
2. **Async data not awaited.** The developer doesn't `await` CMS or API data before the framework flushes `<head>`. Affects Next.js, Nuxt, and SvelteKit - the 9–14% failure rate in the [**scorecard**](#framework-scorecard) comes from this.
3. **First-flush head loss.** Streaming frameworks flush `<head>` for fast TTFB. Late-arriving data, JSON-LD, canonicals, OG tags, [**gets dropped**](#what-streaming-drops). SvelteKit (17.2% missing title) and Solid Start are most affected.
4. **CMS and plugin gaps.** The framework is fine, but the CMS doesn't populate all fields. This drives the [**description problem**](#the-description-problem), the [**OG image gap**](#the-social-sharing-gap), and many [**duplicate tag conflicts**](#duplicate--conflicting-tags) from competing plugins.

A site running a streaming framework with a CMS that doesn't populate descriptions, a GTM container injecting tracking pixels, and multiple plugins setting canonicals hits all four at once.

## [Does Any of This Affect Performance?](#does-any-of-this-affect-performance)

After all this, the natural question: if complete `<head>` tags are so important, frameworks with better heads should have better Core Web Vitals. They don't.

| **Framework** | **Origins** | **FCP Good** | **LCP Good** | **CLS Good** | **INP Good** |
| --- | --- | --- | --- | --- | --- |
| **Astro** | 13,851 | **44.9%** | **44.9%** | 50.1% | **52.9%** |
| **SvelteKit** | 6,996 | 42.3% | 41.8% | 50.8% | 51.1% |
| **Angular** | 97,938 | 40.3% | 37.4% | **54.9%** | 51.7% |
| **Gatsby** | 9,763 | 39.6% | 37.1% | 44.8% | 44.9% |
| **Next.js** | 209,395 | 38.2% | 36.9% | 46.5% | 46.4% |
| **Nuxt** | 66,097 | 37.3% | 36.4% | 47.8% | 47.6% |
| **Remix** | 4,316 | 33.6% | 35.5% | 46.9% | 48.1% |
| **Qwik** | 270 | 30.1% | 29.5% | 35.5% | 38.3% |

The correlation is inverted. Angular - worst head completeness - has the **best CLS** at 54.9%. Qwik and Remix - best heads - have the worst FCP/LCP.

- **Angular's CLS**: mature enterprise apps with stable layouts, not head management
- **Astro leads FCP/LCP**: ships zero JS by default, not because it blocks the head
- **Qwik's numbers**: 270 origins, skewed toward complex early-adopter apps
- **Remix at 33.6% FCP**: data-heavy server apps with round-trips, not static marketing sites

Compare frameworks against platforms that do zero head optimization:

Shopify scores 87% good LCP with no head optimization at all. Nuxt, which auto-sorts tags via Capo.js, delays `</head>` for async data, and deduplicates by key, scores 44%. The gap is TTFB (534ms vs 989ms) and architecture, not head management. See our **Capo.js performance research** for the full analysis.

The factors that dominate CWV, JS payload, image optimization, TTFB, hosting infrastructure, have nothing to do with whether `<title>` was in the initial HTML. Head completeness doesn't show up in Lighthouse. The real cost is SEO: wrong Google snippets, broken social cards, missed rich results.

## [What's Next](#whats-next)

Only 2.8% of Next.js pages in our sample used chunked transfer encoding, but **65% of new framework projects** in 2026 enable streaming by default. Next.js 16 defaults to Partial Pre-Rendering, React Server Components push streaming by design, and ~12% of projects already ship `<head>` tags that end up in the body due to late-streamed injection. See our **streaming SSR research** for the full breakdown.

Head completeness will get worse before it gets better. The frameworks pulling ahead, Nuxt 4's delayed `</head>`, Next.js's bot detection, and the new **Interop 2026 `<link rel="expect">`** standard, are solving problems most developers don't know they have.

## [How Unhead Addresses This](#how-unhead-addresses-this)

Unhead is the head manager used by **Nuxt**, available standalone for any framework. It addresses every issue in this audit:

```
// One call sets title, description, OG, and Twitter tags
useSeoMeta({
  title: 'My Page',
  description: 'Page description',
  ogImage: '/social-card.png',
  twitterCard: 'summary_large_image',
})
```

- **SSR-first:** `useHead()` runs on server and client - tags are always in the initial HTML
- **Async-aware:** holds `</head>` open until all pending entries resolve; v3 adds `Suspense` awareness and `<link rel="expect">` support
- **Streaming-safe:** `createStreamableHead()` delays head completion without blocking the body; `tagPriority: 'critical'` prevents streaming from dropping JSON-LD or canonicals
- **No head-breakers:** only outputs valid metadata elements - no `<div>` or `<img>` in `<head>`
- **Automatic deduplication:** key-based dedup by `name`, `property`, or custom `key` - multiple `useHead()` calls produce exactly one tag per key
- **Capo.js ordering:** `<meta charset>` always first, then viewport, title, preconnects, stylesheets - in the order Chrome's preload scanner expects

## [Method](#method)

- **Dataset:** **HTTP Archive Feb 2026** desktop crawl, 660,000+ origins
- **Performance:** CrUX Jan 2026
- **Protocol:** HTTP/3 (QUIC) is the majority protocol supporting these streams.
- **Detection:** Wappalyzer technology signatures
- **Metrics:** `title_changed_on_render` (WebPageTest custom metric), `<title>` and `<meta name="description">` presence in raw response
- **OG analysis:** `og:title`, `og:description`, `og:image`, `og:url`, `twitter:card` presence in raw response
- **Head-breakers:** Non-metadata elements (`<div>`, `<img>`, `<iframe>`, `<a>`) detected in raw `<head>` HTML; corroborated by **Web Almanac 2025 SEO** (10.1% of desktop sites contain invalid head elements)
- **Duplicate detection:** Multiple `<title>`, `<meta name="description">`, and `<link rel="canonical">` tags counted per origin via regex on response bodies
- **Streaming sample:** 10,000 Next.js pages, first 5,000 bytes analyzed
- **CWV thresholds:** FCP < 1.8s, LCP < 2.5s, CLS < 0.1, INP < 200ms (Google standard)
- **Limitations:** Wappalyzer detection is imperfect. Qwik sample (393 origins) too small for confidence. Chunked sample (45 pages) is directional only. CWV reflects the population, not the framework's capability. Third-party tag counts reflect post-execution DOM snapshots; server-rendered HTML has fewer tags. OG adoption statistics from Web Almanac may differ from framework-specific HTTP Archive queries.

**Did this page help you? **

**Capo.js Performance** **Streaming SSR SEO**

**On this page **

- [What We Measured](#what-we-measured)
- [Framework Scorecard](#framework-scorecard)
- [The Description Problem](#the-description-problem)
- [The Social Sharing Gap](#the-social-sharing-gap)
- [What Streaming Drops](#what-streaming-drops)
- [Head-Breakers: The Silent Parser Bug](#head-breakers-the-silent-parser-bug)
- [Duplicate & Conflicting Tags](#duplicate-conflicting-tags)
- [Third-Party Head Pollution](#third-party-head-pollution)
- [Why Heads Break](#why-heads-break)
- [Does Any of This Affect Performance?](#does-any-of-this-affect-performance)
- [What's Next](#whats-next)
- [How Unhead Addresses This](#how-unhead-addresses-this)
- [Method](#method)