---
title: "Options API · Unhead"
meta:
  "og:description": "Use the head() option in Vue components with VueHeadMixin. Access component data and computed properties for reactive head tags."
  "og:title": "Options API · Unhead"
  description: "Use the head() option in Vue components with VueHeadMixin. Access component data and computed properties for reactive head tags."
---

**Core Concepts**

# **Options API**

Copy for LLMs

**On this page **

- [What is the Options API for Unhead?](#what-is-the-options-api-for-unhead)
- [How Do I Set Up the Options API?](#how-do-i-set-up-the-options-api)
- [How Do I Use the head() Option?](#how-do-i-use-the-head-option)

**Quick Answer:** Use the `head()` option in Vue components to define head tags. It receives the component instance as `this`, allowing access to data and computed properties.

## [What is the Options API for Unhead?](#what-is-the-options-api-for-unhead)

While using the composition API with Unhead is encouraged, the options API is still supported as opt-in for those that prefer it.

## [How Do I Set Up the Options API?](#how-do-i-set-up-the-options-api)

To use the options API, you need to install the mixin `VueHeadMixin` with Vue.

The mixin is exported by both the client and server entry files of Unhead, `@unhead/vue/client` and `@unhead/vue/server` respectively and you'll need to install it for both depending on if you server render or not.

```
import { createApp } from './main'
import { createHead, VueHeadMixin } from '@unhead/vue/client'

const { app } = createApp()
const head = createHead()
app.use(head)
app.mixin(VueHeadMixin)

app.mount('#app')
```

```
import { createApp } from './main'
import { createHead, VueHeadMixin } from '@unhead/vue/server'

const { app } = createApp()
const head = createHead()
app.use(head)
app.mixin(VueHeadMixin)

app.mount('#app')
```

## [How Do I Use the head() Option?](#how-do-i-use-the-head-option)

Pass your head data to the `head` property in your component options.

```
<script>
export default {
  data() {
    return {
      title: 'Hello World'
    }
  },
  head() {
    return {
      title: this.title,
    }
  }
}
</script>
```

Any data provided follows the same **Vue Reactivity** that `useHead()` provides.

You can alternative provide a plain object to the `head` property.

```
<script>
export default {
  // or a plain object
  head: {
    title: 'Hello World'
  }
}
</script>
```

Unhead will automatically handle mixin merging for you.

Edit this page

Markdown For LLMs

**Did this page help you? **

**<Head> Component** Template-based head management with Head, Title, Meta, Link, Script components. Alternative to useHead() for Vue templates. **Pause DOM Rendering** Pause Unhead DOM updates during route transitions. Use dom:beforeRender hook with Vue Suspense for smoother page loads.

**On this page **

- [What is the Options API for Unhead?](#what-is-the-options-api-for-unhead)
- [How Do I Set Up the Options API?](#how-do-i-set-up-the-options-api)
- [How Do I Use the head() Option?](#how-do-i-use-the-head-option)