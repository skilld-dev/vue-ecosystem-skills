---
title: "<Head> Component · Unhead"
meta:
  "og:description": "Template-based head management with Head, Title, Meta, Link, Script components. Alternative to useHead() for Vue templates."
  "og:title": "<Head> Component · Unhead"
  description: "Template-based head management with Head, Title, Meta, Link, Script components. Alternative to useHead() for Vue templates."
---

**Core Concepts**

# **<Head> Component**

Copy for LLMs

**On this page **

- [What is the Head component?](#what-is-the-head-component)
- [How do I use the Head component?](#how-do-i-use-the-head-component)

**Quick Answer:** Use `<Head>`, `<Title>`, `<Meta>`, `<Link>`, and `<Script>` components for template-based head management. Import from `@unhead/vue/components`.

## [What is the Head component?](#what-is-the-head-component)

The Unhead Vue package exports a `<Head>` component that can be used to manage your head tags.

While it's recommended to use the `useHead()` composable as it offers a more flexible API with full TypeScript support, the `<Head>` component may make more sense for your project.

## [How do I use the Head component?](#how-do-i-use-the-head-component)

The component takes any child elements that you would normally put in your actual `<head>` and renders them with Unhead.

```
<script lang="ts" setup>
import { Head } from '@unhead/vue/components'
</script>

<template>
  <Head>
    <title>My awesome site</title>
    <meta name="description" content="My awesome site description">
  </Head>
</template>
```

When the head component is unmounted, it will remove all the tags that were added.

Edit this page

Markdown For LLMs

**Did this page help you? **

**Context & Reactivity** Use refs, computed, and Pinia with useHead(). Handle async context in lifecycle hooks with injectHead() or effectScope(). **Options API** Use the head() option in Vue components with VueHeadMixin. Access component data and computed properties for reactive head tags.

**On this page **

- [What is the Head component?](#what-is-the-head-component)
- [How do I use the Head component?](#how-do-i-use-the-head-component)