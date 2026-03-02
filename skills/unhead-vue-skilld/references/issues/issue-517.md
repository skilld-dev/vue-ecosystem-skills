---
number: 517
title: v2 breaks vue Style component inside Head component in Nuxt v3.16
type: bug
state: open
created: 2025-03-08
url: "https://github.com/unjs/unhead/issues/517"
reactions: 1
comments: 4
labels: "[bug]"
---

# v2 breaks vue Style component inside Head component in Nuxt v3.16

### Environment

Nuxt v3.16 / unhead v2

### Describe the bug

Up to Nuxt 3.15.4, this used to work as expected in the `default.vue` layout component:

```html
<template lang="html">
  <Head>
    <Style children="body { background: red }" />
  </Head>
</template>
```

Nuxt v3.16 breaks this due to unhead v2. Even switching `children` to `textContent` doesn't fix it, I need to deploy an additional awkward workaround for it to work again, using `<component :is="'style'">`:

```html
<template lang="html">
  <Head>
    <component :is="'Style'" textContent="body { background: red }" />
  </Head>
</template>
```


---

## Top Comments

**@harlan-zw** [maintainer]:

Hi, i'll look at getting this fixed as I think I accidently did drop the `children` support for Nuxt 3.16 (on head components).

The workaround would be to place the CSS within the tag, this is what the tests are setup for.

```html
<Style>body { background: red }</Style>
```

Alternatively just use 

```ts
useHead({ style: ['body { background: red }'] })
```

**@lehni**:

The main issue is not the fact that `children` is not supported anymore, it's that I suddenly can't use `Style` inside `Head` anymore. I need to use the weird ` <component :is="'Style'"/>` workaround… Do you have an idea why this is happening?

Your suggestion also only works for me, if I write it as:

`<component :is="'Style'">body { background: red }</component>`

**@lehni**:

And if I use `<component :is="'Style'">body { background: red }</component>` instead of `<component :is="'Style'" textContent="body { background: red }" />` I get hydration mismatch warnings: `[Vue warn]: Hydration node mismatch`