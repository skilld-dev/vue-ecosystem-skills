---
number: 435
title: `title` in `useHead` composable, when a function/computed, should be allowed to return `undefined`
type: bug
state: closed
created: 2025-01-03
url: "https://github.com/unjs/unhead/issues/435"
reactions: 1
comments: 1
labels: "[bug]"
---

# `title` in `useHead` composable, when a function/computed, should be allowed to return `undefined`

### Environment

```json
"@unhead/vue": "1.11.14"
```

### Reproduction

https://stackblitz.com/edit/vitejs-vite-qt6hy722

### Describe the bug

`useHead`/`useSeoMeta`'s `title` supports passing a function or a Vue composable. As the types suggest, the return type should be `string | null`.

However, if `undefined` is returned, the behavior differs from returning an empty string or `null`, and is desirable in my case. I have a component `A`, which declares a page title and renders a component `B`. I'd like `B` to also declare a page title, but conditionally. My first attempt was to use the following code:

```ts
// Component B
useHead({
  title: () => {
    if (condition) return 'Actual title';
    return ''; // I meant here "Please use parent component title"
  }
});
```

...

---

## Top Comments

**@harlan-zw** [maintainer] (+1):

Thanks for the detailed issue, I agree with your suggestion. 

PRs welcome otherwise will take a look when I have a chance.