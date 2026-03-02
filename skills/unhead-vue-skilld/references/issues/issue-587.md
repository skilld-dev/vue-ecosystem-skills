---
number: 587
title: Missing head information when using Vue head mixin
type: bug
state: closed
created: 2025-10-08
url: "https://github.com/unjs/unhead/issues/587"
reactions: 2
comments: 3
labels: "[bug]"
---

# Missing head information when using Vue head mixin

### Environment

Latest version (2.0.18) introduces bug where `head()` option for Options API is not applied to application.

### Reproduction

https://stackblitz.com/edit/github-1ftqrmwn-1lrqz8w8?file=src%2FApp.vue

### Describe the bug

When viewing reproduction URL, page title "foo" and alert window "1" should be displayed, but nothing is rendered (both on client and on server).

### Additional context

It seems like `useHead` is missing from mixin export: https://cdn.jsdelivr.net/npm/@unhead/vue@2.0.18/dist/shared/vue.CgTRvX2j.mjs

It’s present in source file: https://github.com/unjs/unhead/blob/main/packages/vue/src/VueHeadMixin.ts#L15-L18

Could this be erased with server side effects optimization?

### Logs

```sh

```

---

## Top Comments

**@harlan-zw** [maintainer]:

Thank you for reporting this and the reproduction. It's a shame I didn't have any tests that would have detected this but it seems like the tree shaking performance change I did was too aggresive.

It seems to be fixed with v2.0.19.


**@niksy** (+1):

It works now, thanks!

**@zweizeichen**:

Probably the same as #586 