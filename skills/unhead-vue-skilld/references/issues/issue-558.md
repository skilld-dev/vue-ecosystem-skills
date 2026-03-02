---
number: 558
title: (React) Title and other metadata are not unset when component unmounts
type: bug
state: open
created: 2025-07-03
url: "https://github.com/unjs/unhead/issues/558"
reactions: 0
comments: 2
labels: "[bug]"
---

# (React) Title and other metadata are not unset when component unmounts

### Environment

Issue is observed in both of the following environments:

## Stackblitz env:
```
> node --version
v20.19.1
```
Vite: v7.0.1
React: 19.1.0

## My env:
Node v22.8
React 18.2.0
Vite 5.1.0

### Reproduction

https://stackblitz.com/edit/vitejs-vite-ijas5txg?file=src%2FApp.tsx

### Repro steps: 
1. The app is initially rendering the `<Page2>` element, which does not set any `<meta>` tags. 
2. Observe the `<head>` of the rendered app. Observe that the `title` tag is set to the fallback title "Example fallback" and there is a description `<meta>` tag with content "some description" as configured in the `init` parameter of the `createHead` function. (Expected)
3.  Click the button labeled "Page 1" to mount the `<Page1>` component. Observe that the title and description are updated ...

---

## Top Comments

**@harlan-zw** [maintainer]:

Thanks for this detailed issue. This was an Unhead bug,  I've pushed up a fix in v2.0.12 which looks to fix it here https://stackblitz.com/edit/vitejs-vite-nqsjcyrq?file=package.json

LMK if you have any other ikssues 

**@petrovmiroslav**:

sorry guys, but the issue's still there in React 18. https://stackblitz.com/edit/vitejs-vite-ssp6wmnr?file=src%2FApp.tsx