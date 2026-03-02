---
number: 547
title: Documentation is incorrect for Vue 3 with options API
type: bug
state: closed
created: 2025-05-02
url: "https://github.com/unjs/unhead/issues/547"
reactions: 1
comments: 6
labels: "[bug]"
---

# Documentation is incorrect for Vue 3 with options API

### Environment

The following appears to make unhead available for Vue 3 with the options API.

main.js

```
import { createApp, ref } from "vue";
import { createHead, VueHeadMixin } from '@unhead/vue/client'
import App from "./App.vue";

const app = createApp(App);
const head = createHead()
app.use(head)
app.mixin(VueHeadMixi
```

### Reproduction

Instructions on this page fail for multiple reasons (https://unhead.unjs.io/docs/vue/head/guides/core-concepts/options-api)

* createHead is not exported in @unhead/vue, but it is in @unhead/vu/client
* The instructions never reference "head" after creation, so it is a fatal compilation error.

### Describe the bug

Instructions in docs are incorrect:

https://unhead.unjs.io/docs/vue/head/guides/core-concepts/options-api


...

---

## Top Comments

**@harlan-zw** [maintainer]:

Hi, thanks for pointing this out. This looks like it wasn't updated for the recent v2 major version.

I've pushed up some changes to the docs, hopefully it's clearer now.

**@harlan-zw** [maintainer]:

Hm possibly you visited the site before it deployed, check the commit

**@harlan-zw** [maintainer]:

Possibly a caching issue? Or have I missed something from your issue

