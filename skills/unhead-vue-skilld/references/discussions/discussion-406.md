---
number: 406
title: titleTemplate over the whole page
category: Q&A
created: 2024-10-07
url: "https://github.com/unjs/unhead/discussions/406"
upvotes: 1
comments: 2
answered: false
---

# titleTemplate over the whole page

Hello, I'm wondering if I'm doing something wrong. I would like to make sure that I always set a title in my page components and that this title automatically gets ‘| MySiteName’ added at the end.

For example on my contact component I write 

```
<script setup>
import { useHead } from ‘@unhead/vue’;
useHead({
    title: ‘Contact’,
});
</script>
```

But my title is set as ‘Contact | MySiteName’. 

I already found something about titleTemplates here https://unhead.unjs.io/usage/guides/title-template but it does not seems to work.

I tried to set it in my App.vue like:

```
<script setup>
import { useHead } from ‘@unhead/vue’;
useHead({
    titleTemplate: ‘%s | MySiteName’,
});
</script>
```

but it still just uses 'Contact' without my template.

I also tried t...

---

## Top Comments

**@harlan-zw** [maintainer]:

Hi, this is the correct usage. Could you try and make a reproduction of the issue? https://stackblitz.com/edit/vitejs-vite-uijgqa?file=package.json

**@rickhaer** (+1):

Hi @harlan-zw, thanks for your answer. I started recreating this issue in stackblitz based on my code. It actually worked in stackblitz and after checking on my local machine again, it also worked there too ... so this can be marked as done! Thanks anyways :)