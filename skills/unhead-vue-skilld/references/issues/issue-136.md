---
number: 136
title: Duplicated script tags after hydration when using the nonce attribute
type: other
state: closed
created: 2023-03-22
url: "https://github.com/unjs/unhead/issues/136"
reactions: 5
comments: 1
---

# Duplicated script tags after hydration when using the nonce attribute

### Environment

- Node v18
- Vue v3.2.47

### Reproduction

https://stackblitz.com/edit/unhead-duplicated-script-nonce?file=app.vue

### Describe the bug

When using `useHead` with SSR, adding the `nonce` attribute on scripts causes the script to be injected twice in the page head.

```js
useHead({
  script: [
    {
      nonce: 'nonce-8IBTHwOdqNKAWeKl7plt8g==',
      innerHTML: "console.log('will log twice')",
    },
  ],
});
```

Adding the `key`, `vmid` or `hid` attribute does not prevent duplication because of this issue https://github.com/unjs/unhead/issues/135. 

So currently my workaround is to use the server-only mode (`useHead(input, { mode: 'server' })`) in combination with the `key` attribute.

### Additional context

For security reasons, the `nonce` attribute is hidden by the browser. So `$el.getAttribute('nonce')` returns an empty string, which breaks the Tag Deduping logic.

### Logs

_No response_

---

## Top Comments

**@harlan-zw** [maintainer]:

This appears to be fixed as we don't allow duplicate tag content in one of the more recent updates.