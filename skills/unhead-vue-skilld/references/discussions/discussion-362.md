---
number: 362
title: getActiveHead vs injectHead (Vue)
category: Q&A
created: 2024-06-28
url: "https://github.com/unjs/unhead/discussions/362"
upvotes: 1
comments: 1
answered: true
---

# getActiveHead vs injectHead (Vue)

Install unhead
```typescript
import { createHead } from '@unhead/vue'

const head = createHead()
app.use(head)
```

Comp.vue
```html
<script setup lang="ts">
import { onServerPrefetch } from 'vue'
import { getActiveHead } from 'unhead'

const head = getActiveHead()

onServerPrefetch(() => {
  console.log(head) // undefined
})
</script>
```

```html
<script setup lang="ts">
import { onServerPrefetch } from 'vue'
import { injectHead } from '@unhead/vue'

const head = injectHead()

onServerPrefetch(() => {
  console.log(head) // { plugins: [...], ... }
})
</script>
```

The docs states: https://unhead.unjs.io/api/core/get-active-head

But `injectHead` is not mentioned.

Is injectHead for Vue the way to go?

---

## Accepted Answer

**@harlan-zw** [maintainer]:

Hey, thanks for the discussion.

If you're using Vue, you should always use `@unhead/vue` functions over `unhead` functions. While using `getActiveHead()` does work, it returns shared cross-request instance of unhead, where `injectHead()` is bound to the Vue context.

This will likely break in v2 so better to stick to `injectHead()`.

I'll leave this open as a reminder to improve the docs around this.