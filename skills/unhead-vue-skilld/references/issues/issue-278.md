---
number: 278
title: tag.innerHTML.replace is not a function
type: other
state: closed
created: 2023-11-21
url: "https://github.com/unjs/unhead/issues/278"
reactions: 2
comments: 2
---

# tag.innerHTML.replace is not a function

### Environment

Nuxt 3.8.2, Node v18, MacOS

### Reproduction

I think the issue is pretty straightforward, but I will try to create a reproduction if it's not clear enough.

### Describe the bug

For some reason, nuxt is generating a style tag with innerHTML: true and not a string, so unhead crashes when running the XSS plugin. This causes the whole app to crash with `tag.innerHTML.replace is not a function`.

When debugging, here's what the `tag` that the XSS plugin tries to process sometimes looks like:
```js
{
  tag: 'style',
  props: { 'data-hid': '1e484d8' },
  innerHTML: true,
  _e: 11,
  _p: 11268,
  key: 'island-style-QCbg7GUfFJ',
  _d: 'style:island-style-QCbg7GUfFJ',
  _h: '1e484d8'
}
```
```js
{ tag: 'style', props: {}, innerHTML: true, _e: 1, _p: 1024 }
```...