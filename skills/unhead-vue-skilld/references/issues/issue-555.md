---
number: 555
title: "Can not override `twitter:card` using `useServerSeoMeta`"
type: bug
state: open
created: 2025-06-06
url: "https://github.com/unjs/unhead/issues/555"
reactions: 0
comments: 0
labels: "[bug]"
---

# Can not override `twitter:card` using `useServerSeoMeta`

### Environment

Node js: 22.14.0
@nuxtjs/seo": ^3.0.3
nuxt: ^3.17.4

### Reproduction

-

### Describe the bug


I am using @nuxt/seo module, it has SEO utils enabled on it. by default. On SEO utils, it is using `InferSeoMetaPlugin` plugin.
Although it is configurable from options to override the twitterCard ( not from nuxt seo utils but it is not related to this issue here ), however if I want to change it in a specific page for example using useServerSeoMeta:
```
useServerSeoMeta({ twitterCard: "summary" })
```
In inspect of the browser the generated tag is still `summary_large_image` the default one.
`<meta name="twitter:card" content="summary_large_image">`


### Additional context

...