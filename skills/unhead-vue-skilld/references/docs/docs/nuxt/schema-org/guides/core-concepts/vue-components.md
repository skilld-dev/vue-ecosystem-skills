---
title: "Vue Components · Unhead"
meta:
  "og:description": "Schema.org Vue components API (deprecated). Use composables like useSchemaOrg() instead for better TypeScript support."
  "og:title": "Vue Components · Unhead"
  description: "Schema.org Vue components API (deprecated). Use composables like useSchemaOrg() instead for better TypeScript support."
---

**Core Concepts**

# **Vue Components**

Copy for LLMs

**On this page **

- [Headless - Attributes](#headless-attributes)
- [Headless - Slots](#headless-slots)
- [Rendered Default slot](#rendered-default-slot)

 Using the components API is no longer recommended. You should use the composables for better developer experience.

Each Schema has a component that can be used to configure Schema.

Each component implements the same logic and there are multiple ways to define your components.

## [Headless - Attributes](#headless-attributes)

Any attribute passed on the component will be forwarded to the Schema.

For fields which are prefixed with `@`, such as `@type` and `@id`, you can simply omit the `@`.

For example, to set a page name and type:

```
<template>
  
  <SchemaOrgWebPage type="AboutPage" name="About Us" />
</template>
```

## [Headless - Slots](#headless-slots)

Alternatively to providing attributes on the prop, you are also able to provide the data through slots which use the same name as the attribute.

- Only supports shallow text nodes

For example, we can generate a FAQ Question with the following:

```
<template>
  <SchemaOrgQuestion>
    <template #name>
      What is the capital of Australia?
    </template>
    <template #acceptedAnswer>
      Canberra
    </template>
  </SchemaOrgQuestion>
</template>
```

## [Rendered Default slot](#rendered-default-slot)

If you want to render the markup and want full customisation, you can provide a default slot. The slot props will be the resolved node.

```
<template>
  <SchemaOrgQuestion>
    
    <template #name>
      {{ question }}
    </template>
    <template #acceptedAnswer>
      <div v-html="answer" />
    </template>
    
    <h2>
      {{ question }}
    </h2>
    <div v-html="answer" />
  </SchemaOrgQuestion>
</template>
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Installation** Add Schema.org structured data to Nuxt apps with the nuxt-schema-org module. Enable Google Rich Results for your pages. **Installation** Set up Unhead in React with UnheadProvider and useHead() hook. Drop-in replacement for react-helmet with SSR support.

**On this page **

- [Headless - Attributes](#headless-attributes)
- [Headless - Slots](#headless-slots)
- [Rendered Default slot](#rendered-default-slot)