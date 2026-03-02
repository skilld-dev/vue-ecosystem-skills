---
number: 210
title: How to use with Vue context ?
category: Q&A
created: 2023-09-04
url: "https://github.com/unjs/unhead/discussions/210"
upvotes: 1
comments: 2
answered: true
---

# How to use with Vue context ?

Hi there 🏻 

I hope you are well. Thanks for your job on this library.

I am using this library along `testing-library/vue` and `vitest` to run some tests but since 1.5.0 I'm getting a lot of warnings (`Unhead is missing Vue context, falling back to shared context. This may have unexpected results.`) as described in the release note.
Edit: not only on test but also at runtime I am getting a lot of warnings.

How I use it currently alongside `testing-library/vue`:

<details>

<summary>head.ts</summary>

```typescript
import { createHead } from '@unhead/vue';

export const head = createHead();
```
</details>

<details>

<summary>main.ts</summary>

```typescript
import { head }  from './composables/head';

app.use(head);
```...

---

## Accepted Answer

Hi there 👋🏻 

using [1.5.2](https://github.com/unjs/unhead/releases/tag/v1.5.2) `setHeadInjectionHandler` seems to be fixing the issue: 
<details>

<summary>head.ts</summary>

```typescript
import { createHead } from '@unhead/vue';

export const head = createHead();
```
</details>

<details>

<summary>main.ts</summary>

```diff
import { head }  from './composables/head';

- app.use(head);
+ setHeadInjectionHandler(() => head)
```
</details>

<details>

<summary>any-component.vue</summary>

```vue
<script setup lang="ts">
  import { useHead } from '@unhead/vue';

  useHead({
    meta: [{ name: 'description', content: 'This is the best description ever' }],
  });
</script>
```
</details>

<details>

<summary>any-component.test.ts</summary>

```diff
import type { RenderOptions, RenderResult } from '@testing-library/vue';
import { render } from '@testing-library/vue';
import Component from 'path/to/components/any-component.vue';
import { head }  from 'path/to/composables/head';

describe('any-component.vue', () => {
  let mountOptions: RenderOptions;

  beforeEach(() => {
-    mountOptions = {
-      global: {
-        plugins: [head],
-      },
-    };
+    setHeadInjectionHandler(() => head)
+    mountOptions = {};
  });

  it('my super test', () => {
    render(Component, mountOptions);

   // [...]
  });
});
```...