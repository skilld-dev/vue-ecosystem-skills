---
number: 615
title: "[Vue] Can't synchronise head title with analytics tools"
type: bug
state: open
created: 2025-12-16
url: "https://github.com/unjs/unhead/issues/615"
reactions: 0
comments: 0
labels: "[bug]"
---

# [Vue] Can't synchronise head title with analytics tools

### Environment

"@unhead/vue": "^2.0.19"
"vite": "^7.2.7"
"vue": "^3.5.25"

### Reproduction

Hi! First of all thanks for creating this great library

Now, I'm having a hard time synchronising the update of the page title with the initialisation of analytics solutions such as Amplitude.
The issue is that as soon as an analytics monitoring is initialised, it will capture the default page title of index.html.

Example App.vue:
```js
<template>
    <RouterView/> 
</template>



...