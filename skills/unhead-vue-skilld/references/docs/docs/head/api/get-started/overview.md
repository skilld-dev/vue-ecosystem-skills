---
title: "Overview · Unhead"
meta:
  "og:description": "Unhead API reference for useHead(), useSeoMeta(), useScript() composables and DOM/SSR rendering hooks. Full TypeScript support."
  "og:title": "Overview · Unhead"
  description: "Unhead API reference for useHead(), useSeoMeta(), useScript() composables and DOM/SSR rendering hooks. Full TypeScript support."
---

**Get Started**

# **Overview**

**On this page **

- [What composables are available?](#what-composables-are-available)
- [What hooks can I use?](#what-hooks-can-i-use)

**Quick Reference:** The main composables are `useHead()` for general head management, `useSeoMeta()` for SEO tags, and `useScript()` for script loading. All return an entry with `patch()` and `dispose()` methods.

## [What composables are available?](#what-composables-are-available)

**useHead()**

The main composable for managing head tags.

useHead()

**useHeadSafe()**

XSS-safe head management for user-generated content.

useHeadSafe()

**useSeoMeta()**

A composable for managing SEO-related tags.

useSeoMeta()

**useScript()**

A composable for loading and managing external scripts.

useScript()

## [What hooks can I use?](#what-hooks-can-i-use)

### [Entry Hooks](#entry-hooks)

- **entries:updated** - Called when entries have been updated
- **entries:resolve** - Called when entries need to be resolved to tags
- **entries:normalize** - Called when an entry is being normalized to tags

### [How do I hook into tag resolution?](#how-do-i-hook-into-tag-resolution)

- **tag:normalise** - Called when a tag is being normalized
- **tags:beforeResolve** - Called before tags are resolved for rendering
- **tags:resolve** - Called when tags are being resolved for rendering
- **tags:afterResolve** - Called after tags have been resolved

### [How do I hook into DOM rendering?](#how-do-i-hook-into-dom-rendering)

- **dom:beforeRender** - Called before rendering to the DOM (synchronous)

### [How do I hook into server-side rendering?](#how-do-i-hook-into-server-side-rendering)

- **ssr:beforeRender** - Called before server-side rendering
- **ssr:render** - Called during server-side rendering
- **ssr:rendered** - Called after server-side rendering

### [How do I hook into script loading?](#how-do-i-hook-into-script-loading)

- **script:updated** - Called when a script instance is updated

Edit this page

Markdown For LLMs

**Did this page help you? **

**Infer SEO Meta** Auto-generate og:title, og:description, and twitter:card from existing title and description. Reduce duplicate meta tag definitions. **useHead()** Manage document head tags with useHead(). Set titles, meta tags, scripts, and styles with full TypeScript support and reactive updates.

**On this page **

- [What composables are available?](#what-composables-are-available)
- [What hooks can I use?](#what-hooks-can-i-use)