---
number: 126
title: "TypeError: Cannot read properties of undefined (reading 'hooks')"
category: Q&A
created: 2023-03-13
url: "https://github.com/unjs/unhead/discussions/126"
upvotes: 1
comments: 1
answered: true
---

# TypeError: Cannot read properties of undefined (reading 'hooks')

Hi there 🏻 ,

I hope you are fine.

I'm getting this error on my CI on a project using @vueuse/head, vitest and Vue. I'm not sure why I'm getting this message and I haven't taken the time to look into it yet, but I wonder if you've seen this problem before ?

```
Node: 16.19.1
npm: 8.19.3
@vueuse/head: 1.1.19
@unhead/dom: 1.1.21
vue: 3.2.47
vitest: 0.29.2
```

```
TypeError: Cannot read properties of undefined (reading 'hooks')
renderDOMHead ../../node_modules/@unhead/dom/dist/index.cjs:40:14
doDomUpdate ../../node_modules/@unhead/dom/dist/index.cjs:176:12
../../node_modules/@unhead/dom/dist/index.cjs:179:112
Object.<anonymous> ../../node_modules/@unhead/vue/dist/shared/vue.<sha>.cjs:70:61
runNextTicks node:internal/process/task_queues:61:5
processTimers node:internal/timers:499:9
```...

---

## Accepted Answer

**@harlan-zw** [maintainer]:

Hey @smarlhens 

Thanks for the issue :) 

Can you try upgrading to @unhead/dom 1.1.23, @vueuse/head 1.1.23 and see if you still have the issue?

Otherwise, can you share your code? It's not really clear how you have set up the package 