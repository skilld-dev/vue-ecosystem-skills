---
number: 513
title: `init` option of `createHead` doesn't apply initial title
type: bug
state: closed
created: 2025-03-06
url: "https://github.com/unjs/unhead/issues/513"
reactions: 1
comments: 1
labels: "[bug]"
---

# `init` option of `createHead` doesn't apply initial title

### Environment

@unhead/vue 2.0.0-rc.2
node v23.6.0

My app is using Hybridly, but I was able to reproduce on a Vite SPA on Stackblitz.

### Reproduction

https://stackblitz.com/edit/vitejs-vite-j1drwgle?file=src%2Fmain.js

### Describe the bug

I would like to have a default `titleTemplate` for all my pages, such as if I don't specify a title in a page, it will use the default one. In `@unhead/vue` v1. I am using it like this:

```ts
// v1
const head = createHead()
head.push({
	titleTemplate: (title) => `${title ?? ''} — Jetfly Group`.replace(/^ — /, ''),
})
vue.use(head)


// v2
vue.use(createHead({
	init: [
		{ titleTemplate: (title) => `${title ?? ''} — Jetfly Group`.replace(/^ — /, '') },
	],
}))
```

...

---

## Top Comments

**@harlan-zw** [maintainer]:

Thanks for the issue, it looks like the order of the `init` was causing it not to trigger a dom render on its own. This is now fixed in rc-7.