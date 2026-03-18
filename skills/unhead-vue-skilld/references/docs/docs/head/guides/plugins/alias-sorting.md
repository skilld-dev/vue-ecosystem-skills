---
title: "Alias Sorting · Unhead"
meta:
  "og:description": "Order head tags with before: and after: prefixes. More readable than numeric priorities for script loading and CSS dependencies."
  "og:title": "Alias Sorting · Unhead"
  description: "Order head tags with before: and after: prefixes. More readable than numeric priorities for script loading and CSS dependencies."
---

**Plugins**

# **Alias Sorting**

Copy for LLMs

**Quick Answer:** The Alias Sorting plugin lets you control head tag order using readable `before:` and `after:` prefixes instead of arbitrary numbers. Use `tagPriority: 'before:script:analytics'` to place a script before another.

## [What Is Alias Sorting?](#what-is-alias-sorting)

The Alias Sorting plugin lets you control tag order using descriptive `before:` and `after:` prefixes instead of numerical priorities.

## [Why Use Aliases Instead of Numbers?](#why-use-aliases-instead-of-numbers)

Numerical priorities become hard to maintain as your application grows:

- Numbers are arbitrary and their meaning isn't clear
- You need to know all existing priorities to insert a new tag
- Changing one priority might require updating many others

Aliases make tag ordering more intuitive and maintainable with declarative relationships between tags.

## [How Do I Set Up Alias Sorting?](#how-do-i-set-up-alias-sorting)

Add the plugin to your Unhead configuration:

Input

```
import { createHead } from 'unhead'
import { AliasSortingPlugin } from 'unhead/plugins'

const head = createHead({
  plugins: [
    AliasSortingPlugin()
  ]
})
```

## [How Do I Use Alias Sorting?](#how-do-i-use-alias-sorting)

### [Basic Ordering](#basic-ordering)

Use `before:` or `after:` with the tag type and key:

Input

```
useHead(unheadInstance, {
  // First script
  script: [{
    key: 'analytics',
    src: '/analytics.js'
  }],
})

useHead(unheadInstance, {
  // This will render before analytics.js
  script: [{
    src: '/critical.js',
    tagPriority: 'before:script:analytics'
  }]
})
```

Output

```
<script src="/critical.js"></script>
<script src="/analytics.js"></script>
```

### [What Is the Alias Format?](#what-is-the-alias-format)

The format is: `{before|after}:{tagName}:{key}`

For example:

- `before:script:analytics` - Place before the analytics script
- `after:meta:description` - Place after the description meta tag
- `before:link:styles` - Place before the styles link tag

### [Multiple Dependencies](#multiple-dependencies)

You can order multiple tags relative to each other:

Input

```
useHead(unheadInstance, {
  script: [
    {
      key: 'third',
      src: '/c.js',
      tagPriority: 'after:script:second'
    },
    {
      key: 'second',
      src: '/b.js',
      tagPriority: 'after:script:first'
    },
    {
      key: 'first',
      src: '/a.js'
    }
  ]
})
```

Output

```
<script src="/a.js"></script>
<script src="/b.js"></script>
<script src="/c.js"></script>
```

### [Can I Combine Aliases with Numeric Priorities?](#can-i-combine-aliases-with-numeric-priorities)

Yes. Alias sorting works alongside numeric priorities. The plugin will preserve the numeric priority of the referenced tag:

Input

```
useHead(unheadInstance, {
  script: [
    {
      key: 'high-priority',
      src: '/important.js',
      tagPriority: 0
    },
    {
      src: '/also-important.js',
      tagPriority: 'before:script:high-priority'
      // Will inherit priority 0 and render first
    }
  ]
})
```

## [Common Use Cases](#common-use-cases)

### [How Do I Load Critical CSS First?](#how-do-i-load-critical-css-first)

Ensure critical CSS is loaded before other stylesheets:

Input

```
useHead(unheadInstance, {
  link: [
    {
      key: 'main-css',
      rel: 'stylesheet',
      href: '/css/main.css'
    },
    {
      key: 'critical-css',
      rel: 'stylesheet',
      href: '/css/critical.css',
      tagPriority: 'before:link:main-css'
    }
  ]
})
```

### [How Do I Control Script Loading Order?](#how-do-i-control-script-loading-order)

Control the execution sequence of dependent scripts:

Input

```
useHead(unheadInstance, {
  script: [
    {
      key: 'jquery',
      src: '/js/jquery.js'
    },
    {
      key: 'plugin',
      src: '/js/jquery-plugin.js',
      tagPriority: 'after:script:jquery' // Ensure jQuery loads first
    },
    {
      key: 'app',
      src: '/js/app.js',
      tagPriority: 'after:script:plugin' // Load app.js last
    }
  ]
})
```

## [Best Practices](#best-practices)

- Use meaningful keys that describe the tag's purpose
- Keep dependencies simple - avoid complex chains
- Consider using numeric priorities for critical tags
- Document your tag ordering strategy for your team

During hydration (SSR or page switches), tags may not reorder to avoid content flashing. The plugin respects this behavior.

## [Related](#related)

- **Tag Positions** - Control tag ordering

Edit this page

Markdown For LLMs

**Did this page help you? **

**Template Params** Dynamic placeholders like %s and %siteName in head tags. Define site name, separator, and custom variables for consistent branding. **Canonical Plugin** Auto-generate canonical URLs and convert relative paths to absolute. Required for og:image, twitter:image, and SEO canonical links.