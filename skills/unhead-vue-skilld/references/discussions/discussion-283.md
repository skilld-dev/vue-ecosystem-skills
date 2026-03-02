---
number: 283
title: Using Nuxt composables in unhead composables (e.g. useSeoMeta)
category: Q&A
created: 2023-11-30
url: "https://github.com/unjs/unhead/discussions/283"
upvotes: 2
comments: 1
answered: true
---

# Using Nuxt composables in unhead composables (e.g. useSeoMeta)

I was using some Nuxt composables within `useSeoMeta` to set some meta data, for the sake of the example shortened as follows:

```typescript
  useSeoMeta({
    title: () => useRoute().meta['title'] as string,
  })
  ```
  
  ... which worked fine with `unhead@1.7.4`.
  
Starting with `unhead@1.8x` Nuxt did throw the infamous `A composable that requires access to the Nuxt instance was called outside of a plugin, Nuxt hook, Nuxt middleware, or Vue setup function.` 500 error.
  
I'm currently stuck to unhead version `1.7.4` because of this. Does anybody know how to come around this error? Does this have to do with computed getters? Or jit changes in `1.8.x`? Maybe you can help, @harlan-zw?

---

## Accepted Answer

**@harlan-zw** [maintainer]:

Hi @riddla, with v1.8 Unhead no longer uses a shared context, which was causing issues when parallel requests came in.

To avoid this issue is quite simple and is a pattern you may use elsewhere for this issue.

```ts
// collect the refs / reactive elements first
const route = useRoute()
useSeoMeta({
   // then use within the functions
    title: () => route.meta['title'] as string,
})
```

Let me know if you have any further questions on it.