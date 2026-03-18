---
title: "Unhead: Full Stack Head Manager · Unhead"
meta:
  "og:description": "Manage document head in SSR and CSR environments. Lazy DOM patching, TypeScript API, flat SEO meta, Schema.org support, and script loading."
  "og:title": "Unhead: Full Stack Head Manager · Unhead"
  description: "Manage document head in SSR and CSR environments. Lazy DOM patching, TypeScript API, flat SEO meta, Schema.org support, and script loading."
---

**Get Started**

# **Unhead: Full Stack Head Manager**

## [What is head manager?](#what-is-head-manager)

Adding tags in your `<head>` is one of the fundamental tasks in web development. Whether it be setting a page title using `<title>` or loading in a JavaScript framework using `<script>` tags.

While setting tags in a HTML document is dead simple, JavaScript frameworks have moved us well away from the days of pure HTML into a world of fully dynamic client-side pages and server-side rendering.

Modern JavaScript applications need to render code outside the app entry (typically `<div id="app"></div>`) in both a server-rendered and client-rendered environment.

The role of the "head manager" is then to manage the tags in the `<head>` and all tags outside the app entry.

```
<!DOCTYPE html>
<html>  
  <head>
    
  </head>
  <body> 
    
    <div id="app"></div> 
    
  </body>
</html>
```

## [Introducing Unhead](#introducing-unhead)

Unhead was built as a universal head manager for JavaScript applications. Initially allowing frameworks such as Vue and Nuxt, to offload the complex work of managing the head to a standalone library.

While many frameworks themselves implement solutions for managing the above tags, it can be difficult to maintain for the diverse ways tags can be inserted into the document.

As Unhead is a dedicated library it can innovate on the head management developer experience, providing an ecosystem of plugins and integrations that can be used across all frameworks.

## [Innovating on Head Management](#innovating-on-head-management)

- **Lazy DOM Patching** - A tiny DOM diffing engine that only updates what changed, avoiding full page re-renders
- **Fully Typed API** - TypeScript-first with inline MDN documentation for every tag and attribute
- **Flat SEO Meta** - Manage 100+ meta tags without nested objects using `useSeoMeta()`
- **Schema.org Support** - Generate structured data with full TypeScript support via `useSchemaOrg()`
- **Script API** - Load third-party scripts with proxied APIs, triggers, and performance controls using `useScript()`
- **SSR + CSR** - First-class support for server-side rendering with seamless client hydration
- **Framework Agnostic** - Works with Vue, React, Svelte, Solid, Angular, or vanilla TypeScript

## [Next Steps](#next-steps)

Now that you understand what Unhead does, get started with your framework:

- **Vue Installation**
- **React Installation**
- **Svelte Installation**
- **Solid Installation**
- **Angular Installation**
- **TypeScript (Vanilla)**

Or explore the core concepts:

- **Page Titles** - Master title management
- **Tag Positions** - Control tag ordering
- **Loading Scripts** - Efficient script loading

Edit this page

Markdown For LLMs

**Did this page help you? **

**Overview** Framework-agnostic library for managing HTML head tags. Titles, meta tags, scripts, and structured data with SSR support for Vue, React, Svelte, Solid, Angular. **Starter Recipes** Copy-paste recipes for SEO setup, social sharing meta, favicon config, PWA tags, and blog post optimization. Ready-to-use Unhead patterns.