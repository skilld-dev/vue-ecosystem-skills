---
title: "Unhead · Full stack <head> package"
meta:
  "og:description": "Unhead is the any-framework document head manager built for performance and delightful developer experience."
  "og:title": "Unhead · Full stack <head> package"
  description: "Unhead is the any-framework document head manager built for performance and delightful developer experience."
---

# **The ***full stack*** **<head>** package for **any framework**. **

Unhead wraps your document template, improving reactive SSR JavaScript framework SEO and performance.

**Get Started ** ** Install Unhead **

### ** Titles that just work**

```
useHead({
  title: 'Hello World',
  titleTemplate: '%s %separator My App',
})
// Hello World - My App
```

### ** DOM Events**

```
useHead({
  script: [{
    src: '/script.js',
    onload: () => alert('woo'),
  }],
})
```

### ** Classes and styles however you like**

```
useHead({
  bodyAttrs: {
    // use strings
    style: 'background-color: #343434',
    // arrays
    class: ['dark', 'overflow'],
  },
  htmlAttrs: {
    // objects
    style: {
      backgroundColor: 'white',
      color: 'black',
    },
    // computed boolean objects
    class: {
      dark: () => Date.now() % 2 === 0,
    },
  },
})
```

```
useHead({
  title: 'Subscribe now!',
  htmlAttrs: {
    class: { dark: true, light: false }
  },
  bodyAttrs: {
    'style': { overflow: 'hidden' },
    'data-modal': true,
  },
  link: [{
    rel: 'preload',
    href: 'https://3p.com/subscribe.js',
    as: 'script',
  }],
})
```

<!DOCTYPEhtml><htmlclass="light"><head><title>Hello World</title></head><body></body></html>

Component Not Mounted

### **Flat SEO Meta**

Was it `<meta property` or `<meta name`? Who can remember, just use `useSeoMeta()`.

```
useSeoMeta({
  ogType: 'article',
  author: 'Harlan Wilton',
  articleAuthor: ['Harlan Wilton'],
  articlePublishedTime: '2024-01-01',
  articleModifiedTime: '2024-01-01',
  twitterData1: 'Harlan Wilton',
  twitterLabel1: 'Author',
  twitterData2: '10 min',
  twitterLabel2: 'Read Time',
})
```

### **Schema.org Graphs**

Rich result optimized Schema.org graphs without the `application/ld+json`.

```
useSchemaOrg([
  definePerson({
    name: 'Harlan Wilton',
    sameAs: [
      'https://github.com/harlan-zw',
    ],
    url: 'https://harlanzw.com',
  }),
  defineArticle({
    headline: 'Hello World',
    datePublished: '2024-01-01',
  }),
])
```

### Optimized Head tag ordering

Unhead ships with a default head tag order that is optimized for SEO and performance.

<head><scriptdefersrc="defer-script.js"><scriptsrc="sync-script.js"><linkrel="modulepreload"href="modulepreload.js"><scriptsrc="async-script.js"async><linkrel="preload"href="preload.js"><linkrel="stylesheet"href="sync-styles.css"><title>title</title><linkrel="preconnect"href="https://example.com"><linkrel="dns-prefetch"href="https://example.com"><linkrel="prefetch"href="https://example.com"><linkrel="prerender"href="https://example.com"><metaname="description"content="description"><metaname="viewport"content="width=device-width, initial-scale=1.0"></head>

**Enable Capo.js**

 

### **A **`<script>`** for full stack javascript**

Better developer experience, performance and privacy.

```
const script = useScript({
  src: 'https://js.cdn/tracker.js',
}, {
  trigger: useOnIdle()
})
script.onError((error) => { /* uh oh */ })
// proxy function calls for when the script is loaded
script.proxy.track('foo')
// or just use onLoaded
script.onLoaded((api) => {
  api.track('bar')
})
```

```
<link fetchpriority="low" as="script" crossorigin="anonymous" referrerpolicy="no-referrer" href="https://js.cdn/tracker.js" rel="preload">
```

```
<script data-onload="" data-onerror="" defer="" fetchpriority="low" crossorigin="anonymous" referrerpolicy="no-referrer" src="https://js.cdn/tracker.js"></script>
```

### ** Optimized Client Bundles**

```
// Unhead tags are built to tree-shake, it just works
if (import.meta.server) {
  useHead({
    meta: [{
      name: 'description',
      content: 'Hello World',
    }],
    script: [{
      innerHTML: 'console.log("Hello World")',
    }],
  })
}
```

## **Unhead Principals **

**Full Featured Developer Experience**

Full featured modules that do everything you expect and more.

**Optimized for Performance**

Optional utils are tree shakable, keeping a small core and allowing for a minimal bundle size.

**Extensible**

Internally powered by hookable to allow for full customisatin over output.

## **Up To Date. Always. **

Unhead was started at the end of 2022 and has received continuous bug fixes and feature improvements from the community.



2.1K

Commits

203

Issues Closed

53

Contributors

**213K downloads**per day, on average

Unhead is used and trusted by thousands of developers and companies around the world.

7.5M

Downloads/ month

1200

Total Stars

## **Funded by the community **

Unhead is completely free and open-source due to the generous support of the community.

**Become a sponsor **

**Top Sponsors **

**Gold Sponsors **

**Backers **