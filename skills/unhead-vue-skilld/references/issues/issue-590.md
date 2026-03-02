---
number: 590
title: Tag priority Nuxt 4
type: bug
state: open
created: 2025-10-16
url: "https://github.com/unjs/unhead/issues/590"
reactions: 0
comments: 1
labels: "[bug]"
---

# Tag priority Nuxt 4

### Environment

Node v22 nuxt v4

### Reproduction

Minimal example
https://nuxt-pinia-pet.vercel.app/
https://github.com/ni-marchuk/nuxt_pinia_pet

Example from my working production project

<img width="576" height="627" alt="Image" src="https://github.com/user-attachments/assets/c14f204d-a2a9-4c46-a071-494a7734d5c7" />

### Describe the bug

I updated to Nuxt 4 and am using useSeoMeta. My meta tags are placed after styles, some scripts, modulepreload links, and favicon. I really need to raise them to the very top, the requirements of an SEO specialist. What should I do, help me?


### Additional context

_No response_

### Logs

```sh

```

---

## Top Comments

**@Barbapapazes** [maintainer]:

Hey, 

> the requirements of an SEO specialist

Do you have some documentation about it? really curious to learn why!