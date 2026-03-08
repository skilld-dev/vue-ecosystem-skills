---
title: "Vue Reactivity and Async Context · Unhead"
meta:
  "og:description": "Use refs, computed, and Pinia with useHead(). Handle async context in lifecycle hooks with injectHead() or effectScope()."
  "og:title": "Vue Reactivity and Async Context · Unhead"
  description: "Use refs, computed, and Pinia with useHead(). Handle async context in lifecycle hooks with injectHead() or effectScope()."
---

**Core Concepts**

# **Vue Reactivity and Async Context**

Copy for LLMs

**On this page **

- [Introduction](#introduction)
- [How Does Reactivity Work in Unhead?](#how-does-reactivity-work-in-unhead)
- [What Reactive Values Can I Use?](#what-reactive-values-can-i-use)
- [How Do I Handle Async Context?](#how-do-i-handle-async-context)
- [What Are the Best Practices?](#what-are-the-best-practices)
- [What Are Some Advanced Use Cases?](#what-are-some-advanced-use-cases)
- [Does Nuxt Handle This Differently?](#does-nuxt-handle-this-differently)
- [How Does Unhead Work Under the Hood?](#how-does-unhead-work-under-the-hood)

**Quick Answer:** In Vue, pass refs and computed values directly to `useHead()`. Changes are tracked automatically. Use `injectHead()` in composables outside components.

## [Introduction](#introduction)

Unhead integrates seamlessly with Vue's reactivity system, allowing you to create dynamic and responsive head tags that automatically update when your data changes. This guide explains how to effectively manage reactive head tags and handle asynchronous operations in your Vue applications.

## [How Does Reactivity Work in Unhead?](#how-does-reactivity-work-in-unhead)

When using any of the Unhead composables like `useHead()`, full reactivity is provided out of the box. All values support Vue's reactivity system, meaning your head tags will automatically update when reactive data changes.

Behind the scenes, Unhead uses Vue's provide/inject system for head instance management. When we call `useHead()`, it uses the Vue **inject** function to get the Unhead instance attached to the Vue application:

```
import { headSymbol } from '@unhead/vue'
import { inject } from 'vue'

function useHead(input) {
  const head = inject(headSymbol)
  head.push(input)
}
```

### [How Does Component Lifecycle Affect Head Tags?](#how-does-component-lifecycle-affect-head-tags)

Unhead integrates automatically with Vue's component lifecycle:

- When a component is unmounted, any head entries created by that component are automatically removed
- When a component is deactivated with keep-alive, its entries will be deactivated
- When a component is activated with keep-alive, its entries will be reactivated

This ensures your head tags stay in sync with your component's visibility state and prevents memory leaks when components are destroyed.

### [How Does Reactivity Differ Between Client and Server?](#how-does-reactivity-differ-between-client-and-server)

Reactivity behaves differently depending on the rendering context:

- **Server-Side Rendering (SSR)**: Values are resolved only when the tags are being rendered, usually after the app has finished rendering.
- **Client-Side Rendering (CSR)**: Any ref changes trigger a DOM update, making the head tags reactive after hydration.

## [What Reactive Values Can I Use?](#what-reactive-values-can-i-use)

Unhead works with all Vue reactive primitives:

```
import { useHead } from '@unhead/vue'
import { computed, ref } from 'vue'

// Create reactive state
const title = ref('My Site')
const description = ref('Welcome to my website')

// Use reactive values in head tags
useHead({
  // Direct ref
  title,
  meta: [
    // Computed getter (recommended for derived values)
    { name: 'description', content: () => description.value },
    // Using refs directly in objects
    { property: 'og:title', content: title }
  ],
  // Computed ref
  link: [computed(() => ({
    rel: 'canonical',
    href: \`https://example.com/products/${product.value.name}\`
  }))]
})
```

## [How Do I Handle Async Context?](#how-do-i-handle-async-context)

The `inject()` function keeps track of your Vue component instance, but after async operations within lifecycle hooks or nested functions, Vue can lose track of this context.

```
<script setup lang="ts">
import { useHead } from '@unhead/vue'
import { onMounted } from 'vue'

onMounted(async () => {
  await someAsyncOperation()
  // This will throw an error
  useHead({
    title: 'My Title'
  })
})
</script>
```

When trying to inject once Vue has lost the context, you'll receive an error from Unhead:

useHead() was called without provide context.

Let's explore several solutions to handle this problem effectively.

### [Solution 1: Use Top Level Await](#solution-1-use-top-level-await)

Vue's script setup handles async operations through **compile-time transforms** that preserve the component instance context. The Vue team devised an elegant solution for maintaining async context through these script setup transforms.

At the top level of script setup, context is automatically preserved:

```
<script setup lang="ts">
import { useHead } from '@unhead/vue'

// The compiler transforms this to preserve context
await someAsyncOperation()
useHead({
  title: 'My Title'
})
</script>
```

This is the simplest and most effective way to handle async operations in Vue. For a deeper understanding of how async context evolved in Vue's Composition API, check out Anthony Fu's **detailed exploration** of the topic.

### [Solution 2: Using `effectScope()`](#solution-2-using-effectscope)

The `effectScope()` API allows you to re-run a code block using the same component context:

```
<script setup lang="ts">
import { useHead } from '@unhead/vue'
import { effectScope, onMounted } from 'vue'

// Create an effect scope before any async operations
const scope = effectScope()

onMounted(async () => {
  const data = await fetchData()

  // Run all effects within this scope
  scope.run(() => {
    // All composables inside here will be properly cleaned up
    useHead({
      title: data.title,
      meta: [
        {
          name: 'description',
          content: data.description
        }
      ]
    })
  })
})
</script>
```

### [Solution 3: Using `injectHead()`](#solution-3-using-injecthead)

The `injectHead()` function lets us grab a reference to Unhead's instance before any async operations occur:

```
<script setup lang="ts">
import { injectHead, useHead } from '@unhead/vue'
import { onMounted } from 'vue'

// Store the head instance at setup time
const head = injectHead()

// For simple updates, we don't need to pass the head instance
useHead({
  title: 'My Site'
})

// Inside async functions, we must pass the head instance
async function updatePageHead(id: string) {
  const data = await fetchPage(id)

  // Pass head as an option to maintain context
  useHead({
    title: data.title,
    meta: [
      {
        name: 'description',
        content: data.description
      }
    ]
  }, { head }) // The head instance ensures the update works
}

// The same applies for lifecycle hooks
onMounted(async () => {
  const analyticsData = await loadAnalytics()

  useHead({
    script: [
      {
        // Analytics script injection after load
        children: analyticsData.scriptContent
      }
    ]
  }, { head })
})
</script>
```

The key idea is that `injectHead()` should be called at the top level of your component, before any async operations.

### [Solution 4: Using Reactive State (Recommended)](#solution-4-using-reactive-state-recommended)

The most elegant way to handle async head updates is to combine reactive state with `useHead()`:

```
<script setup lang="ts">
import { useHead } from '@unhead/vue'
import { computed, ref } from 'vue'

// Initialize your reactive state
const page = ref({
  title: 'Loading...',
  description: '',
  image: '/placeholder.jpg'
})

// Define head once with computed properties
useHead({
  // Title will automatically update when page.value.title changes
  title: computed(() => page.value.title),
  meta: [
    {
      name: 'description',
      content: computed(() => page.value.description)
    },
    {
      property: 'og:image',
      content: computed(() => page.value.image)
    }
  ]
})

// Your async operations just update the reactive state
async function loadPage(id: string) {
  const data = await fetchPage(id)
  // Head updates automatically when we update the ref
  page.value = {
    title: data.title,
    description: data.description,
    image: data.image
  }
}

// Works great with watchers too
watch(route, async () => {
  await loadPage(route.params.id)
})
</script>
```

This reactive state pattern aligns well with Vue's Composition API design and often results in cleaner, more maintainable code.

#### [Using with Pinia Store](#using-with-pinia-store)

You can also use this pattern with more complex state management:

```
<script setup lang="ts">
import { useHead } from '@unhead/vue'
import { storeToRefs } from 'pinia'
import { usePageStore } from '@/stores/page'

const store = usePageStore()
// Destructure with storeToRefs to maintain reactivity
const { title, description } = storeToRefs(store)

useHead({
  title, // Reactive store state automatically works
  meta: [
    {
      name: 'description',
      content: description
    }
  ]
})

// Now your store actions can update the head
await store.fetchPage(id)
</script>
```

## [What Are the Best Practices?](#what-are-the-best-practices)

### [Should I Use Refs or Computed Getters?](#should-i-use-refs-or-computed-getters)

For the best performance and clarity, prefer direct refs and computed getters:

```
// ✅ Good approach
const title = ref('Product Page')
const product = ref({ name: 'Widget' })

useHead({
  // Direct ref
  title,
  // Computed getter
  meta: [
    { property: 'og:title', content: () => \`${product.value.name} - ${title.value}\` }
  ]
})
```

### [Can I Use useHead Inside a Watcher?](#can-i-use-usehead-inside-a-watcher)

Avoid `useHead()` calls in watchers, as this creates new entries on each update:

```
// ❌ Bad approach: Creates multiple entries
watch(title, (newTitle) => {
  useHead({
    title: newTitle
  })
})

// ✅ Good approach: Updates existing entry
useHead({
  title // ref value updates automatically
})
```

### [How Can I Optimize Frequent Component Mounts?](#how-can-i-optimize-frequent-component-mounts)

When components are frequently mounted and unmounted, consider using Vue's built-in mechanisms like `v-if`/`v-show` or `<KeepAlive>` to optimize head tag management:

```
// Using keep-alive allows Unhead to optimize head updates
<KeepAlive>
  <component :is="currentView" />
</KeepAlive>
```

## [What Are Some Advanced Use Cases?](#what-are-some-advanced-use-cases)

### [How Do I Create Dynamic SEO Meta Tags?](#how-do-i-create-dynamic-seo-meta-tags)

```
import { useSeoMeta } from '@unhead/vue'
import { computed, ref } from 'vue'
import { useRoute } from 'vue-router'

export default {
  setup() {
    const route = useRoute()
    const product = ref(null)

    // Fetch data based on route
    fetchProduct(route.params.id).then((data) => {
      product.value = data
    })

    // SEO tags update automatically when product data is loaded
    useSeoMeta({
      title: () => product.value?.name || 'Loading...',
      description: () => product.value?.description || '',
      ogImage: () => product.value?.image || '/default.jpg',
    })
  }
}
```

### [Can I Use Multiple useHead Calls?](#can-i-use-multiple-usehead-calls)

You can use multiple `useHead()` calls in different components, and Unhead will handle merging them correctly:

```
// BaseLayout.vue
useHead({
  titleTemplate: '%s | My Site',
  meta: [
    { name: 'theme-color', content: '#ff0000' }
  ]
})

// ProductPage.vue
useHead({
  title: product.name,
  meta: [
    { name: 'description', content: product.description }
  ]
})
```

## [Does Nuxt Handle This Differently?](#does-nuxt-handle-this-differently)

When using Nuxt, you don't need to worry about managing async context for head updates. This is because Nuxt attaches Unhead directly to the Nuxt application instance which is globally accessible regardless of the async operation.

This allows you to use `useHead()` anywhere in your Nuxt application, including plugins, middleware, and layouts without worrying about context.

If you're using Nuxt, async context management is handled automatically by the framework, so you can focus on the reactive aspects of your head tags.

## [How Does Unhead Work Under the Hood?](#how-does-unhead-work-under-the-hood)

Under the hood, Unhead in Vue:

1. Uses Vue's provide/inject system for head instance management
2. Leverages `watchEffect` to track reactive dependencies
3. Integrates with Vue's component lifecycle hooks
4. Uses Vue's reactive resolver to unwrap refs and computed values

This implementation ensures seamless integration with Vue's reactivity system while maintaining performance and proper cleanup. If you're interested in the technical details of Vue's script setup implementation, check out the **Script Setup RFC**.

Edit this page

Markdown For LLMs

**Did this page help you? **

**Upgrade Guide** Learn how to migrate between Unhead versions for Vue users. **<Head> Component** Template-based head management with Head, Title, Meta, Link, Script components. Alternative to useHead() for Vue templates.

**On this page **

- [Introduction](#introduction)
- [How Does Reactivity Work in Unhead?](#how-does-reactivity-work-in-unhead)
- [What Reactive Values Can I Use?](#what-reactive-values-can-i-use)
- [How Do I Handle Async Context?](#how-do-i-handle-async-context)
- [What Are the Best Practices?](#what-are-the-best-practices)
- [What Are Some Advanced Use Cases?](#what-are-some-advanced-use-cases)
- [Does Nuxt Handle This Differently?](#does-nuxt-handle-this-differently)
- [How Does Unhead Work Under the Hood?](#how-does-unhead-work-under-the-hood)