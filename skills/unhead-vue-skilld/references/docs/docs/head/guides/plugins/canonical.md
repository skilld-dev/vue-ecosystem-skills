---
title: "Canonical Plugin · Unhead"
meta:
  "og:description": "Auto-generate canonical URLs and convert relative paths to absolute. Required for og:image, twitter:image, and SEO canonical links."
  "og:title": "Canonical Plugin · Unhead"
  description: "Auto-generate canonical URLs and convert relative paths to absolute. Required for og:image, twitter:image, and SEO canonical links."
---

**Plugins**

# **Canonical Plugin**

Copy for LLMs

**Quick Answer:** The Canonical plugin automatically generates `<link rel="canonical">` tags and converts relative URLs to absolute URLs in your meta tags. Enable it with `CanonicalPlugin({ canonicalHost: 'https://mysite.com' })` in your head configuration.

## [Why Do I Need Absolute URLs in Meta Tags?](#why-do-i-need-absolute-urls-in-meta-tags)

The Canonical Plugin automatically converts relative URLs to absolute URLs in your meta tags, which is essential for:

- **Google SEO**: Requires absolute URLs for canonical links
- **Facebook**: Ignores relative image paths in Open Graph tags
- **Twitter**: Requires absolute URLs for Twitter Card images

## [What Tags Does the Plugin Transform?](#what-tags-does-the-plugin-transform)

The plugin transforms these tags automatically:

- `og:image` and `twitter:image` meta tags
- `og:url` meta tag
- `rel="canonical"` link tag

Before

```
<meta property="og:image" content="/images/hero.jpg">
```

After

```
<meta property="og:image" content="https://mysite.com/images/hero.jpg">
```

## [How Do I Set Up the Canonical Plugin?](#how-do-i-set-up-the-canonical-plugin)

Install the plugin in both your server & client entries:

Input

```
import { CanonicalPlugin } from 'unhead/plugins'

const head = createHead({
  plugins: [
    CanonicalPlugin({
      canonicalHost: 'https://mysite.com'
    })
  ]
})
```

## [What Are the Configuration Options?](#what-are-the-configuration-options)

Input

```
interface CanonicalPluginOptions {
  // Your site's domain (required)
  canonicalHost?: string
  // Optional: Custom function to transform URLs
  customResolver?: (path: string) => string
}
```

### [What Happens If I Don't Set canonicalHost?](#what-happens-if-i-dont-set-canonicalhost)

- If no `canonicalHost` is provided:
  - Client-side: Uses `window.location.origin`
  - SSR: Leaves URLs as-is (relative)

Always set `canonicalHost` explicitly for consistent behavior across environments.

### [How Do I Customize URL Resolution?](#how-do-i-customize-url-resolution)

Use `customResolver` to implement custom URL transformation logic:

Input

```
CanonicalPlugin({
  canonicalHost: 'https://mysite.com',
  customResolver: path => new URL(\`/cdn${path}\`, 'https://example.com').toString()
})
```

Example transformation:

Before

```
<meta property="og:image" content="/hero.jpg">
```

After

```
<meta property="og:image" content="https://mysite.com/cdn/hero.jpg">
```

## [How Do I Integrate with a CDN?](#how-do-i-integrate-with-a-cdn)

Point image assets to your CDN domain:

Input

```
CanonicalPlugin({
  canonicalHost: 'https://mysite.com',
  customResolver: (path) => {
    // Send image paths to CDN, keep other URLs on main domain
    if (path.match(/\.(jpg|png|webp|gif|svg)$/i))
      return \`https://cdn.mysite.com${path}\`
    return \`https://mysite.com${path}\`
  }
})
```

## [Related](#related)

- **Template Params** - Dynamic template parameters
- **Infer SEO Meta** - Auto-generate SEO tags

Edit this page

Markdown For LLMs

**Did this page help you? **

**Alias Sorting** Order head tags with before: and after: prefixes. More readable than numeric priorities for script loading and CSS dependencies. **Infer SEO Meta** Auto-generate og:title, og:description, and twitter:card from existing title and description. Reduce duplicate meta tag definitions.