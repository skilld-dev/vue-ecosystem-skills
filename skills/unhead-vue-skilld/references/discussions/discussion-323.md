---
number: 323
title: useScript compatibility with CSP
category: General
created: 2024-03-07
url: "https://github.com/unjs/unhead/discussions/323"
upvotes: 1
comments: 5
answered: false
---

# useScript compatibility with CSP

Hi all

`useScript` is an absolutely fantastic way to embed 3rd-party external scripts in a Nuxt application.

I'm opening this discussion as a contributor to the Nuxt-Security module. We try to contribute to safer Nuxt applications by allowing users to deploy their websites with Strict CSP (Content Security Policy).

### CSP Limitations

One thing that gets in our way with `useScript` is the fact that it inserts `onload` inline event handlers, as in : https://github.com/unjs/unhead/blob/main/packages/unhead/src/plugins/eventHandlers.ts#L12

CSP disallows the insertion of inline event handlers, as explained in MDN docs on CSP:

@harlan-zw : FYI I managed to get a POC running of what I had in mind
The POC is based on Cloudflare Turnstile with Strict CSP

- An example of CSP rejecting the inline event handlers:  https://stackblitz.com/edit/nuxt-starter-d1f3pg?file=app.vue
  You can see that the Captcha is not loaded, and the console says that CSP rejected the inline event handler

- A POC with CSP passing with `addEventListener` : https://stackblitz.com/edit/nuxt-starter-fa6ach?file=app.vue
  You can see that the Captcha loads correctly. The `addEventListener` was correctly bound to the script tag. I was not abl...

**@vejja**:

Thanks @harlan-zw for your answer. 

From my perspective I can see that you are inserting `this.dataset.onload = true` on the `onload` inline event handler of the script. This is the only line of code that gets blocked by CSP, the rest is fine (i.e. modifying the `data-xxx` attributes is perfectly OK for CSP).

As for the extra weight and globals, this is obviously an issue. Do you think that having a simple option to deactivate the insertion of the inline event handlers would be an issue? In a Nuxt world, maybe it could then become my own responsibility to bind `addEventListener` to the s...