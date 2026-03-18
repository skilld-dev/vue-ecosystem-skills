---
title: "Components · Unhead"
meta:
  "og:description": "Use Nuxt built-in Head, Title, Meta, Link, Script components. Template-based head management with no imports required."
  "og:title": "Components · Unhead"
  description: "Use Nuxt built-in Head, Title, Meta, Link, Script components. Template-based head management with no imports required."
---

**Core Concepts**

# **Components**

Copy for LLMs

**Quick Answer:** Nuxt includes built-in `<Head>`, `<Title>`, `<Meta>`, `<Link>`, and `<Script>` components. No imports needed - just use them in your templates.

## [What head components are available in Nuxt?](#what-head-components-are-available-in-nuxt)

Nuxt exports several Vue components that can be used to manage your head tags.

While it's recommended to use the `useHead()` composable as it offers a more flexible API with full TypeScript support, the Vue component may make more sense for your project.

## [How do I use head components?](#how-do-i-use-head-components)

For full usage instructions please refer to the **Nuxt documentation**.

```
<script setup lang="ts">
const title = ref('Hello World')
</script>

<template>
  <div>
    <Head>
      <Title>{{ title }}</Title>
      <Meta name="description" :content="title" />
      <Style type="text/css" children="body { background-color: green; }" />
    </Head>

    <h1>{{ title }}</h1>
  </div>
</template>
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Context & Reactivity** Use refs and computed with useHead() in Nuxt. Handle async context with injectHead() and effectScope(). Automatic reactivity for head tags. **Installation** Add Schema.org structured data to Nuxt apps with the nuxt-schema-org module. Enable Google Rich Results for your pages.