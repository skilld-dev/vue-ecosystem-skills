---
title: "Does Head Tag Order Actually Affect Performance? Original Research · Unhead"
meta:
  "og:description": "We ran 120 controlled benchmarks with real network throttling and analyzed 10.7 million origins from CrUX to measure the actual performance impact of HTML head tag ordering."
  "og:title": "Does Head Tag Order Actually Affect Performance? Original Research · Unhead"
  author: "Harlan Wilton"
  description: "We ran 120 controlled benchmarks with real network throttling and analyzed 10.7 million origins from CrUX to measure the actual performance impact of HTML head tag ordering."
---

**Research**12 min read

# **Does Head Tag Order Actually Affect Performance? Original Research**

Harlan Wilton Published **Mar 5, 2026**



**Nuxt** auto-sorts `<head>` tags via **Capo.js weights** and scores **44% good LCP across 88K CrUX origins**. **Shopify** does zero head optimization and scores 87%. The framework doing the most work on head ordering has the worst LCP. That gap isn't explained by ordering - it's TTFB, JavaScript payload, hydration cost.

So does head tag ordering matter? We ran 120 controlled benchmarks to find out.

## [What We Tested](#what-we-tested)

We built static test pages with four `<head>` orderings:

- **Optimal** - Capo.js order (`<meta charset>`, viewport, `<title>`, preconnects, async scripts, sync scripts, stylesheets, deferred scripts, meta)
- **Common-bad** - Typical mistakes: charset after title, preconnects after stylesheets, sync scripts before CSS
- **Random** - Shuffled tags
- **Worst** - Reverse Capo.js order (deferred scripts first, charset last)

Each ordering was tested at three complexity levels - minimal (8 tags), medium (15 tags), and heavy (36 tags including GTM, multiple stylesheets, preloads, and full social meta). All pages loaded Google Fonts; heavy pages also loaded GTM.

We used **Chrome DevTools Protocol (CDP) network throttling** (not Lighthouse simulated throttling) at two profiles: fast-4g (1.44 Mbps, 150ms RTT) and slow-3g (400 Kbps, 400ms RTT). Each configuration ran 5 times in headless Chromium via Puppeteer - 120 page loads total.

Lighthouse's default "simulated" throttling does not model byte-level HTML parsing. It loads the document instantly from localhost and applies a mathematical model to the results _after_ the fact. Because the preload scanner "sees" all tags instantly in this model, tag ordering has zero effect on simulated scores. CDP throttling forces the browser to wait for bytes to arrive over the wire, triggering the real-world behavior of the preload scanner and resource scheduler.

## [Results](#results)

Median First Contentful Paint:

| **Complexity** | **Throttle** | **Optimal** | **Common-Bad** | **Random** | **Worst** | **Max Delta** |
| --- | --- | --- | --- | --- | --- | --- |
| Minimal | fast-4g | 460ms | 456ms | 456ms | 464ms | +4ms (1%) |
| Medium | fast-4g | 468ms | 468ms | 468ms | 468ms | 0ms |
| Heavy | fast-4g | 496ms | 488ms | 504ms | 528ms | **+32ms (6%)** |
| Minimal | slow-3g | 984ms | 992ms | 992ms | 980ms | +8ms (1%) |
| Medium | slow-3g | 1068ms | 1040ms | 1068ms | 1080ms | +12ms (1%) |
| Heavy | slow-3g | 1228ms | 1228ms | 1228ms | 1440ms | **+212ms (17%)** |

### [The DCL Paradox](#the-dcl-paradox)

While FCP and LCP suffer under "Worst" ordering, **DOMContentLoaded (DCL)** often improves. In our heavy + fast-4g test, "Worst" ordering achieved a DCL of 522ms compared to "Optimal" at 533ms.

This happens because the browser discovers and finishes downloading deferred scripts (placed at the top in "Worst" order) earlier. While this improves the DCL timestamp, it's a "false" optimization: it steals bandwidth from the sync scripts needed for the initial paint.

One edge case we identified in research but excluded from the 120-run matrix is the **CSP Meta Stall**. Placing a `<meta http-equiv="Content-Security-Policy">` tag deep in the head (or after any scripts) can cause the Chromium Preload Scanner to **stall or disable itself entirely**. This forces the browser to load resources sequentially, which can add seconds to the load time regardless of other ordering.

Worst-case ordering on a heavy page over slow-3g costs **212ms (17%) of FCP**. On simple pages or fast connections, the difference is noise - under 12ms.

Head ordering matters on heavy pages over slow connections. Everywhere else, it's irrelevant.

## [The Mechanism: Sync Script Starvation](#the-mechanism-sync-script-starvation)

The 212ms gap isn't CSS. Google Fonts finishes at the same time in both orderings - within 0.7ms.

The actual mechanism is **sync script bandwidth contention**:

```

<head>
  <script defer src="/assets/js/lazy-components.js"></script>
  <script defer src="/assets/js/interactions.js"></script>
  
  <script src="/assets/js/vendor.js"></script>
  <script src="/assets/js/app.js"></script>
</head>
```

The preload scanner finds `<script defer>` tags first and starts downloading them. On a throttled connection, they consume bandwidth. When the parser finally discovers the parser-blocking sync scripts, they compete for the same constrained pipe.

Resource timing (heavy page, slow-3g):

| **Resource** | **Optimal** | **Worst** | **Change** |
| --- | --- | --- | --- |
| **vendor.js** (sync) | 515ms | 944ms | **+84% slower** |
| **app.js** (sync) | 543ms | 858ms | **+58% slower** |
| Google Fonts CSS | 658ms | 630ms | -4% (same) |
| interactions.js (defer) | 1058ms | 457ms | -57% (faster) |
| lazy-components.js (defer) | 1030ms | 429ms | -58% (faster) |

#### **Resource Loading Waterfall **

heavy page, slow-3g

Parser-blocking Stylesheet Deferred First paint possible

**Optimal ordering**** FASTER **

**Worst ordering**

**+466ms **

Delayed first paint

**-572ms **

Deferred scripts (wasted)

Wrong ordering lets deferred scripts "steal" bandwidth from critical resources. They finish faster, but **parser-blocking scripts are delayed by ~466ms**, pushing back the first paint.

In worst ordering, deferred scripts finish faster (they got a head start) but that's wasted priority - they don't block rendering. The parser is stuck waiting for vendor.js, which is stuck waiting for bandwidth.

Head tag ordering doesn't change how fast resources download. It changes **which resources get bandwidth first**. When non-blocking scripts steal priority from blocking ones, the parser stalls.

## [CrUX: 10.7 Million Origins](#crux-107-million-origins)

Benchmarks show ordering matters under specific conditions. CrUX data (Jan 2026, 10.7M mobile origins) tells a broader story about the real-world impact of head optimization compared to other performance factors.

The **Nuxt Paradox** is the strongest evidence that head ordering alone is not a dominant performance factor at population scale. Nuxt implements the "gold standard" of automatic head ordering, yet it lags behind platforms like Shopify that perform no such optimization. The gap is driven by **TTFB** and **hydration cost**: Shopify's edge network and server-rendered architecture provide a baseline performance that head ordering cannot overcome.

### [8-Month Trend](#_8-month-trend)

All three major frameworks were flat over the last 8 months. No framework-level optimization, including head ordering, has moved LCP at population scale. TTFB, image optimization, and JS payload size continue to dominate.

## [When It Matters](#when-it-matters)

While head ordering isn't a silver bullet, it is a critical optimization for specific scenarios.

Head tag ordering affects performance when: your head has **20+ tags** including sync and deferred scripts, your users are on **slow connections** (3G or degraded mobile), and you have **parser-blocking `<script>` tags**. Remove any one condition and the preload scanner neutralizes the difference.

On fast networks, resources download quickly regardless of discovery order. On simple pages, there aren't enough resources to create contention. Without sync scripts, nothing blocks the parser.

External CSS (like Google Fonts) is unaffected - the browser prioritizes render-blocking CSS at the network layer independent of HTML position.

## [How Unhead Handles This](#how-unhead-handles-this)

Unhead sorts tags using Capo.js weights automatically. Every `useHead()` call places sync scripts before deferred, preconnects before the resources they serve, `<meta charset>` and viewport first:

```
useHead({
  script: [
    { src: '/vendor.js' }, // weight: 50 (sync, placed early)
    { src: '/lazy.js', defer: true } // weight: 80 (deferred, placed late)
  ],
  link: [
    { rel: 'preconnect', href: 'https://fonts.googleapis.com' } // weight: 20
  ]
})
```

See **What is Capo.js?** for the complete weight reference.

Capo AnalyzerCheck your site's current head tag ordering with instant feedback and suggestions.

## [Reproduce This](#reproduce-this)

Benchmark test pages and Puppeteer scripts are in `test/capo-benchmarks`. Each test page uses identical external resources - only `<head>` tag order changes. Network throttling via CDP (`Network.emulateNetworkConditions`), not Lighthouse simulation.

CrUX data queried from BigQuery's public `chrome-ux-report` dataset, filtered by framework technology detection. All benchmark results are median values across 5 runs per configuration.

The State of <head> in 2026Head tag health across 660,000 sites - including the social sharing gap, head-breakers, and third-party pollution.

Streaming SSR &amp; SEOHow streaming SSR drops JSON-LD, canonicals, and OG tags - and the strategies each framework uses to prevent it.

**Did this page help you? **

**What is Capo.js?** **State of <head> 2026**