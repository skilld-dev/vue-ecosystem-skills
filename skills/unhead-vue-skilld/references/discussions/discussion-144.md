---
number: 144
title: Delay?
category: Q&A
created: 2023-04-09
url: "https://github.com/unjs/unhead/discussions/144"
upvotes: 2
comments: 2
answered: false
---

# Delay?

I'm using this but its nearly unusuable with the extreme delay. Is there a reason it feels like nearly 200-300 ms before the title updates? I'm using a brand new vite created app, with no ajax calls, just static templates.

The template will resolve far before the title tag updates.

This also makes templates unusuable because if i override the template in Home, it shows " - CompanyName" for quite awhile before showing "CompanyName". Its minor but i feel like that shouldnt even be a problem to begin with and looks janky

I'm open to ideas .. .maybe I'm misusing the library.

---

## Top Comments

**@harlan-zw** [maintainer]:

Hey @9mm, thanks for the discussion thread.

The DOM render has a delay set on it to give time for any child components to mount. This provides better performance (less DOM writing) and avoids title flashes.

The default delay is set to:
- wait 10ms (mostly arbituary)
- wait for nextTick

Not really sure why you'd be getting 200-300ms delays unless your nextTick is also being delayed for some reason. This package is used in Nuxt and as far as I'm aware the issue doesn't exist there. 

I did some benchmarks on a Vue Vite SSR setup and got around 20ms update time for a simple counter. ...

**@julisch94**:

Could my issue be related to that timeout as well? https://github.com/unjs/unhead/issues/244

My Playwright tests are flaky because the meta tags don't update reliably. Or is there a way to wait for the update?