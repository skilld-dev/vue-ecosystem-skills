---
title: "Template Params Plugin · Unhead"
meta:
  "og:description": "Dynamic placeholders like Template Params Plugin and Unhead in head tags. Define site name, separator, and custom variables for consistent branding."
  "og:title": "Template Params Plugin · Unhead"
  description: "Dynamic placeholders like Template Params Plugin and Unhead in head tags. Define site name, separator, and custom variables for consistent branding."
---

**Plugins**

# **Template Params Plugin**

Copy for LLMs

**On this page **

- [What Are Template Params?](#what-are-template-params)
- [How Do I Set Up Template Params?](#how-do-i-set-up-template-params)
- [What Built-in Params Are Available?](#what-built-in-params-are-available)
- [Which Separator Should I Use?](#which-separator-should-i-use)
- [How Do Template Params Work with Meta Tags?](#how-do-template-params-work-with-meta-tags)
- [How Do I Use Template Params in Scripts?](#how-do-i-use-template-params-in-scripts)
- [Common Use Cases](#common-use-cases)
- [Related](#related)

**Quick Answer:** Template params let you use placeholders like `%s` and `%siteName` in your head tags. Configure them with `templateParams: { siteName: 'My Site', separator: '·' }` in `useHead()`.

## [What Are Template Params?](#what-are-template-params)

The Template Params plugin lets you define variables that can be used across your meta tags. While you could use functions for dynamic content, template params work better with SSR and avoid hydration issues.

## [How Do I Set Up Template Params?](#how-do-i-set-up-template-params)

Add the plugin to your Unhead configuration:

Input

```
import { createHead } from 'unhead'
import { TemplateParamsPlugin } from 'unhead/plugins'

const head = createHead({
  plugins: [
    TemplateParamsPlugin()
  ]
})
```

## [What Built-in Params Are Available?](#what-built-in-params-are-available)

Unhead includes two built-in template params:

| **Token** | **Description** |
| --- | --- |
| `%s` | The current page title |
| `%separator` | Smart separator (defaults to \|) |

The `%separator` is intelligent - it only appears between content and removes itself when:

- The title is empty
- Multiple separators would appear next to each other

Input

```
useHead(unheadInstance, {
  title: 'Home',
  titleTemplate: '%s %separator %siteName',
  templateParams: {
    separator: '—', // Use an em dash instead of |
    siteName: 'MySite'
  }
})
```

Output

```
<title>Home — MySite</title>
```

## [Which Separator Should I Use?](#which-separator-should-i-use)

For better readability, consider these separator alternatives:

Input

```
// Choose a more readable separator
useHead(unheadInstance, {
  templateParams: {
    separator: '—' // Em dash
    // Other options: '-' (hyphen), '•' (bullet), '·' (middot), '❤️' (heart)
  }
})
```

## [How Do Template Params Work with Meta Tags?](#how-do-template-params-work-with-meta-tags)

Template params work seamlessly with **SEO meta tags** and social sharing:

Input

```
useHead(unheadInstance, {
  templateParams: {
    siteName: 'MyApp',
    separator: '·'
  },
  title: 'Home',
  meta: [
    { name: 'description', content: 'Welcome to %siteName - where we make awesome happen' },
    { property: 'og:title', content: 'Home %separator %siteName' },
    { property: 'og:description', content: 'Check out %siteName today!' }
  ]
})
```

Output

```
<head>
  <title>Home · MyApp</title>
  <meta name="description" content="Welcome to MyApp - where we make awesome happen">
  <meta property="og:title" content="Home · MyApp">
  <meta property="og:description" content="Check out MyApp today!">
</head>
```

## [How Do I Use Template Params in Scripts?](#how-do-i-use-template-params-in-scripts)

### [Enable for Script and Other Tags](#enable-for-script-and-other-tags)

For tags using `innerHTML` or `textContent`, add `processTemplateParams: true`:

Input

```
useHead(unheadInstance, {
  templateParams: { name: 'My App' },
  script: [
    {
      innerHTML: { name: '%name' },
      type: 'application/json',
      processTemplateParams: true
    }
  ]
})
```

Output

```
<script type="application/json">{ "name": "My App" }</script>
```

### [How Do I Disable Template Processing?](#how-do-i-disable-template-processing)

Add `processTemplateParams: false` to skip template processing:

Input

```
useHead(unheadInstance, {
  title: 'Hello %name',
  templateParams: { name: 'World' },
}, {
  processTemplateParams: false,
})
```

Output

```
<title>Hello %name</title>
```

## [Common Use Cases](#common-use-cases)

### [How Do I Maintain Brand Consistency?](#how-do-i-maintain-brand-consistency)

Maintain consistent branding across your site:

Input

```
// In your site setup
const head = createHead({
  plugins: [
    TemplateParamsPlugin()
  ]
})

// Define global template params
head.push({
  templateParams: {
    brand: 'ProductName™',
    tagline: 'The best solution for your needs',
    separator: '—'
  }
})

// In page components
useHead(unheadInstance, {
  title: 'Features',
  titleTemplate: '%s %separator %brand',
  meta: [
    { name: 'description', content: '%brand: %tagline' }
  ]
})
```

### [Can I Use Nested Objects in Template Params?](#can-i-use-nested-objects-in-template-params)

Use nested objects for more structured data:

Input

```
useHead(unheadInstance, {
  templateParams: {
    site: {
      name: 'My Site',
      url: 'https://example.com',
    },
    separator: '·',
    subPage: null
  },
  title: 'My Page',
  titleTemplate: '%s %separator %subPage %separator %site.name',
  meta: [
    {
      name: 'description',
      content: 'Welcome to %site.name.',
    },
    {
      property: 'og:site_name',
      content: '%site.name',
    },
    {
      property: 'og:url',
      content: '%site.url/my-page',
    },
  ],
})
```

Output

```
<head>
<title>My Page · My Site</title>
<meta name="description" content="Welcome to My Site.">
<meta property="og:site_name" content="My Site">
<meta property="og:url" content="https://example.com/my-page">
</head>
```

## [Related](#related)

- **Canonical Plugin** - Auto-generate canonical URLs
- **Infer SEO Meta** - Auto-generate SEO tags

Edit this page

Markdown For LLMs

**Did this page help you? **

**Build Plugins** Vite and Webpack plugins for Unhead. Tree-shake server composables, transform useSeoMeta, save ~3kb in production bundles. **Alias Sorting** Order head tags with before: and after: prefixes. More readable than numeric priorities for script loading and CSS dependencies.

**On this page **

- [What Are Template Params?](#what-are-template-params)
- [How Do I Set Up Template Params?](#how-do-i-set-up-template-params)
- [What Built-in Params Are Available?](#what-built-in-params-are-available)
- [Which Separator Should I Use?](#which-separator-should-i-use)
- [How Do Template Params Work with Meta Tags?](#how-do-template-params-work-with-meta-tags)
- [How Do I Use Template Params in Scripts?](#how-do-i-use-template-params-in-scripts)
- [Common Use Cases](#common-use-cases)
- [Related](#related)