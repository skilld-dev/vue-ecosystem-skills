---
number: 375
title: How to register the Vue plugin correctly?
category: Q&A
created: 2024-08-07
url: "https://github.com/unjs/unhead/discussions/375"
upvotes: 4
comments: 3
answered: false
---

# How to register the Vue plugin correctly?

When using unhead in vue I get a warning in the console but setting the title works like expected:

```
[Vue warn]: inject() can only be used inside setup() or functional components.
Unhead is missing Vue context, falling back to shared context. This may have unexpected results.
```

There is a Q&A ( https://github.com/unjs/unhead/discussions/210 ) that suggests using `setHeadInjectionHandler(() => head)` but the official documentation ( https://unhead.unjs.io/setup/vue/installation#demos ) says I should use `app.use(head)`. I've tested both versions and both work. 

This is how I should do it (as far as I understand the documentation) and setting the title works like expected but I get the warning.
```
// accourding to documentation
import { createApp } from "vue";
import { createHead } from "@unhead/vue";
import App from "./App.vue";

const app = createApp(App);
const head = createHead();
app.use(head);
app.mount("#app");
```...

---

## Top Comments

**@harlan-zw** [maintainer] (+1):

The context issue is solved in v2 which is currently in alpha. There's a migration guide here: https://unhead-unjs-io.nuxt.dev/docs/migration

**@hackel**:

@harlan-zw Could you comment on what is going on here, and whether using `setHeadInjectionHandler` instead of `app.use` is indeed the correct solution?  Because it's undocumented, it feels like a workaround and there should be some other way to fix this issue.  Thank you!

**@firu11**:

Same here!
I'm unsure if that's a good practice but it gets the job done by removing the warning.