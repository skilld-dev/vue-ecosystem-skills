---
number: 431
title: How to dedupe tailwind classes in bodyAttrs?
category: Q&A
created: 2024-12-31
url: "https://github.com/unjs/unhead/discussions/431"
upvotes: 1
comments: 2
answered: false
---

# How to dedupe tailwind classes in bodyAttrs?

Hi,

I am using `unhead` as part of `nuxt@3`. Is there any way to dedupe tailwind classes when `useHead()` is used in both `app.vue` and in `pages/`?

Example:

> app.vue
```
useHead({
  bodyAttrs: {
    class: "bg-red-500",
  },
})
```

> pages/index.vue
```
useHead({
  bodyAttrs: {
    class: "bg-green-500",
  },
})
```


Ideally I would dedupe them with something like tw-merge to get `class="bg-green-500"` only in the final output.

Basically any approach for specifying __default__ `<body>` classes and __overrides__ for pages would be great.

Thanks :pray:

---

## Top Comments

**@harlan-zw** [maintainer]:

Hi, thanks for the question. The simplest way to solve this would be to conditionally add the class in your app.vue.

```ts
const route = useRoute()
useHead({
  bodyAttrs: {
    class: {
      "bg-red-500": () => route.path !== '/'
    }
  },
})
```

There is a more complicated way to solve this in where we can use the Unhead hooks to modify the resolved tags using tw-merge, this is a rough untested code sample of how you might do that

```ts
const head = injectHead()
head.hooks.hook('tags:afterResolve', (ctx) => {
  // collect all body classes
  const bodyClasses = ctx.tags.filter((tag) => tag.tag === 'bodyAttrs').flatMap((tag) => tag.props.class)
  // apply tw-merge
  const twClasses = twMerge(bodyClasses)
  // filter out non-merged classes
  for (const tag of ctx.tags) {
    if (tag.tag === 'bodyAttrs') {
      tag.props.class = twClasses
    }
  }
})
```...

**@chrisjansky**:

Hi @harlan-zw, sorry to necro this issue – the newly released unhead v2 as part of nuxt 3.16.2 breaks the `injectHead()` hook you have written: bodyClasses props.class return `''`.

Could you please provide any guidance how to make this behaviour work in the new version? Thanks  