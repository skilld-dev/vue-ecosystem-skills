---
title: "Pause DOM Rendering · Unhead"
meta:
  "og:description": "Pause Unhead DOM updates during route transitions. Use dom:beforeRender hook with Vue Suspense for smoother page loads."
  "og:title": "Pause DOM Rendering · Unhead"
  description: "Pause Unhead DOM updates during route transitions. Use dom:beforeRender hook with Vue Suspense for smoother page loads."
---

**Core Concepts**

# **Pause DOM Rendering**

Copy for LLMs

**On this page **

Pausing the DOM rendering is useful for when you want to ensure your page is fully loaded before updating tags.

In Vue, this is especially useful when you're using `<Suspense>`.

```
import { createHead, renderDOMHead } from 'unhead/client'

const head = createHead()

let pauseDOMUpdates = true
head.hooks.hook('dom:beforeRender', (context) => {
  context.shouldRender = !pauseDOMUpdates
})

// When your app is ready
loadPage().then(() => {
  pauseDOMUpdates = false
  // triggers the dom update
  renderDOMHead(head)
})
```

```
import { createHead } from '@unhead/vue'
import { renderDOMHead } from 'unhead/client'
import { useRouter } from 'vue-router'

const head = createHead()

let pauseDOMUpdates = true
head.hooks.hook('dom:beforeRender', (context) => {
  context.shouldRender = !pauseDOMUpdates
})

// start pausing DOM updates when route changes (trigger immediately)
useRouter().beforeEach(() => {
  pauseDOMUpdates = true
})
// watch for new route before unpausing dom updates (triggered after suspense resolved)
useRouter().afterEach(() => {
  // only if we have paused (clicking on a link to the current route triggers this)
  if (pauseDOMUpdates) {
    pauseDOMUpdates = false
    renderDOMHead(head)
  }
})
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Options API** Use the head() option in Vue components with VueHeadMixin. Access component data and computed properties for reactive head tags. **Streaming** Stream head tags as async components resolve during Vue SSR