---
title: "Infer SEO Meta · Unhead"
meta:
  "og:description": "Auto-generate og:title, og:description, and twitter:card from existing title and description. Reduce duplicate meta tag definitions."
  "og:title": "Infer SEO Meta · Unhead"
  description: "Auto-generate og:title, og:description, and twitter:card from existing title and description. Reduce duplicate meta tag definitions."
---

**Plugins**

# **Infer SEO Meta**

Copy for LLMs

**On this page **

- [What Does This Plugin Do?](#what-does-this-plugin-do)
- [How Does the Output Look?](#how-does-the-output-look)
- [How Do I Set Up the Plugin?](#how-do-i-set-up-the-plugin)
- [What Options Can I Configure?](#what-options-can-i-configure)
- [How Do I Customize the OG Title?](#how-do-i-customize-the-og-title)
- [How Do I Disable Twitter Cards?](#how-do-i-disable-twitter-cards)
- [How Do I Format OG Descriptions?](#how-do-i-format-og-descriptions)
- [Related](#related)

**Quick Answer:** The Infer SEO Meta plugin automatically generates `og:title`, `og:description`, and `twitter:card` from your existing `title` and `description` tags, reducing duplicate meta tag definitions.

## [What Does This Plugin Do?](#what-does-this-plugin-do)

The Infer SEO Meta plugin automatically generates Open Graph and Twitter meta tags from your existing content:

- `og:title` - Inferred from your page title
- `og:description` - Inferred from your description meta
- `twitter:card` - Set automatically when using `og:image`

Use this plugin when you want to avoid duplicating your page title and description across Open Graph and Twitter meta tags. It's ideal for sites that need consistent social sharing metadata without manual repetition.

## [How Does the Output Look?](#how-does-the-output-look)

Input

```
useHead(unheadInstance, {
  title: 'My Page Title',
  meta: [
    { name: 'description', content: 'A description of my page' }
  ]
})
```

Output

```
<title>My Page Title</title>
<meta name="description" content="A description of my page">
<meta property="og:title" content="My Page Title">
<meta property="og:description" content="A description of my page">
```

## [How Do I Set Up the Plugin?](#how-do-i-set-up-the-plugin)

Add the plugin to your Unhead configuration:

Input

```
import { InferSeoMetaPlugin } from 'unhead/plugins'

const head = createHead({
  plugins: [
    InferSeoMetaPlugin()
  ]
})

// or

head.use(InferSeoMetaPlugin())
```

## [What Options Can I Configure?](#what-options-can-i-configure)

You can customize how the plugin transforms your content:

Input

```
export interface InferSeoMetaPluginOptions {
  /**
   * Transform the og title.
   *
   * @param title
   */
  ogTitle?: ((title: string) => string)
  /**
   * Transform the og description.
   *
   * @param description
   */
  ogDescription?: ((description: string) => string)
  /**
   * The twitter card to use.
   *
   * @default 'summary_large_image'
   */
  twitterCard?: false | 'summary' | 'summary_large_image' | 'app' | 'player'
}
```

## [How Do I Customize the OG Title?](#how-do-i-customize-the-og-title)

Remove site name suffix from Open Graph titles:

Input

```
import { InferSeoMetaPlugin } from 'unhead/plugins'

const head = createHead({
  plugins: [
    InferSeoMetaPlugin({
      ogTitle: title => title.replace('- My Site', '')
    })
  ]
})
```

## [How Do I Disable Twitter Cards?](#how-do-i-disable-twitter-cards)

If you don't want Twitter cards generated:

Input

```
InferSeoMetaPlugin({
  twitterCard: false
})
```

## [How Do I Format OG Descriptions?](#how-do-i-format-og-descriptions)

Append a call-to-action to your Open Graph descriptions:

Input

```
InferSeoMetaPlugin({
  ogDescription: description => \`${description} Learn more now!\`
})
```

## [Related](#related)

- **useSeoMeta()** - Manual SEO meta management
- **Template Params** - Dynamic template parameters

Edit this page

Markdown For LLMs

**Did this page help you? **

**Canonical Plugin** Auto-generate canonical URLs and convert relative paths to absolute. Required for og:image, twitter:image, and SEO canonical links. **Overview** Unhead API reference for useHead(), useSeoMeta(), useScript() composables and DOM/SSR rendering hooks. Full TypeScript support.

**On this page **

- [What Does This Plugin Do?](#what-does-this-plugin-do)
- [How Does the Output Look?](#how-does-the-output-look)
- [How Do I Set Up the Plugin?](#how-do-i-set-up-the-plugin)
- [What Options Can I Configure?](#what-options-can-i-configure)
- [How Do I Customize the OG Title?](#how-do-i-customize-the-og-title)
- [How Do I Disable Twitter Cards?](#how-do-i-disable-twitter-cards)
- [How Do I Format OG Descriptions?](#how-do-i-format-og-descriptions)
- [Related](#related)