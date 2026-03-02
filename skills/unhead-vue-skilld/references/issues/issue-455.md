---
number: 455
title: Retreive head data
type: feature
state: open
created: 2025-01-10
url: "https://github.com/unjs/unhead/issues/455"
reactions: 4
comments: 2
labels: "[enhancement]"
---

# Retreive head data

### Describe the feature

Currently, if I set the title in my Pages using `useSeoMeta()` or `useHead()`.
I have no way of accessing this value inside my Layouts.
```html
// pages/index.vue
<script setup>
useSeoMeta({
    title: () => t('Internationalization'),
});
</script>
```

To work around this, I use `definePageMeta`.
But this requires me to move my translations to the global scope.
```html
// pages/index.vue
<script setup>
definePageMeta({
    title: 'Internationalization',
});
useSeoMeta({
    title: () => $t('Internationalization'),
});
</script>
```
```html
// layouts/default.vue
<template>
    <div>
        <h1>{{ $t($route.meta.title) }}</h1>
    </div>
</template>
```

Maybe `useHead()` with no arguments should return the `head` object like so...

---

## Top Comments

**@harlan-zw** [maintainer]:

The specific issue in why the head data can't just be retrieved immediately is that it's resolved async after the component tree is finished updating. If it was to give you all of the data that was rendered it could lead to recursive reactivity issues or just triggering flashes of the title.

The solution you have here is good, Nuxt Scripts exports a similar function to use the title but for the context of analytic reporting.

Not too sure how else to solve this at the Unhead level while it's async (running it sync will be a big performance loss and lead to reactivity issues).

...

**@mrleblanc101**:

My current workaround.
I created a custom `useTitle()` composable:
```js
export default function (title: string) {
    const state = useState('state', () => '');

    if (title) {
        state.value = title;

        useSeoMeta({
            title,
        });
    }

    return { title: state };
}
```
So in my page I do:
```js
<script lang="ts" setup>
useTitle(t('My Page Title'));
</script>
```

And in my AppHeader, I do:
```html
<script lang="ts" setup>
const { title } = useTitle()
</script>

<template>
    <header>
        ...
        <h1>{{ title }}</h1>
        ...
    </header>
</template>
```...