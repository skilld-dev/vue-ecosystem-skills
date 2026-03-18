---
title: "useHead() · Unhead"
meta:
  "og:description": "Manage document head tags with useHead(). Set titles, meta tags, scripts, and styles with full TypeScript support and reactive updates."
  "og:title": "useHead() · Unhead"
  description: "Manage document head tags with useHead(). Set titles, meta tags, scripts, and styles with full TypeScript support and reactive updates."
---

**Composables**

# **useHead()**

Copy for LLMs

**Quick Start:**

```
import { useHead } from '@unhead/vue' // or your framework

useHead(unheadInstance, {
  title: 'Page Title',
  meta: [{ name: 'description', content: 'Page description' }]
})
```

The `useHead()` composable is for managing the document head. It provides a type-safe, reactive API to define, update, and remove head elements like title, meta tags, scripts, and more. It's the core composable used across all frameworks in the Unhead ecosystem.

```
import { useHead } from 'unhead'

const entry = useHead({
  title: 'My Page',
})
// update
entry.patch({ title: 'new Title' })
// remove
entry.dispose()
```

### [How It Works](#how-it-works)

The composable works by queuing your input to be resolved when the head is rendered:

1. It registers your head configuration in a queue
2. When the document head is being rendered (client-side or during SSR), all queued entries are:
  - Resolved (including any functions, promises or reactive values)
  - Deduplicated (removing redundant tags) - see **Handling Duplicates**
  - Sorted (based on tag priority) - see **Tag Positions**
  - Merged when appropriate
3. The resolved tags are then rendered to the document head

This queue-based approach enables powerful features like deduplication, async resolution, and priority-based rendering while maintaining optimal performance.

You won't know the final state of the head until the rendering is complete.

### [Reactivity Model](#reactivity-model)

`useHead()` provides reactivity through two main mechanisms:

1. **Framework Integration**: When used with frameworks it automatically integrates with the framework's reactivity system
2. **Manual API**: The returned `ActiveHeadEntry` object with `patch()` and `dispose()` methods lets you manually update or remove head entries

## [API Reference](#api-reference)

```
function useHead(input: UseHeadInput, options?: HeadEntryOptions): ActiveHeadEntry
```

### [Parameters](#parameters)

| **Parameter** | **Type** | **Required** | **Description** |
| --- | --- | --- | --- |
| `input` | `Head` | Yes | The head configuration object |
| `options` | `HeadEntryOptions` | No | Configuration options for the head entry |

### [Returns](#returns)

```
interface ActiveHeadEntry {
  /**
   * Update the head entry with new values
   */
  patch: (input: Partial<UseHeadInput>) => void
  /**
   * Remove the head entry
   */
  dispose: () => void
}
```

## [Input Schema](#input-schema)

The input object accepts the following properties:

```
interface Head<E extends MergeHead = SchemaAugmentations> {
  // Document title
  title?: string | Promise<string>

  // Title template (function or string with %s placeholder)
  titleTemplate?: string | null | ((title?: string) => string | null)

  // Template parameters for dynamic replacements
  templateParams?: { separator?: string } & Record<string, string | Record<string, string>>

  // HTML tag collections
  base?: Base<E['base']>
  link?: Link<E['link']>[]
  meta?: Meta<E['meta']>[]
  style?: (Style<E['style']> | string)[]
  script?: (Script<E['script']> | string)[]
  noscript?: (Noscript<E['noscript']> | string)[]

  // Element attributes
  htmlAttrs?: HtmlAttributes<E['htmlAttrs']>
  bodyAttrs?: BodyAttributes<E['bodyAttrs']>
}
```

The input is deeply resolved allowing you to provide any value as a function. This can be useful for lazily resolving values when the head tags are being rendered.

Lazy resolving values can improve performance for complex or computed values that aren't needed until the head is actually rendered.

```
import { useHead } from 'unhead'

const title = useMyTitle()
useHead(unheadInstance, {
  // just works
  title: () => 'Dynamic Title',
  meta: [
    () => ({
      name: 'description',
      content: () => \`Description for ${title.value}\`
    }),
  ]
})
```

## [Options](#options)

The `options` parameter allows you to configure the behavior of the head entry:

```
export interface HeadEntryOptions {
  // Whether to process template parameters in the input
  // - Requires the TemplateParams plugin
  processTemplateParams?: boolean

  // Priority of tags for determining render order
  tagPriority?: number | 'critical' | 'high' | 'low' | \`before:${string}\` | \`after:${string}\`

  // Where to position tags in the document
  tagPosition?: 'head' | 'bodyClose' | 'bodyOpen'

  // Custom head instance
  head?: Unhead
}
```

Setting any of these will apply that rule to all tags within the entry. For example if we want to push several meta tags with low priority, we can do:

Learn more about using **Tag Priorities** and **Template Parameters** in their dedicated guides.

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  meta: [
    { name: 'description', content: 'fallback description' },
    { name: 'author', content: 'fallback author' }
  ]
}, {
  tagPriority: 'low'
})
```

The `tagPriority` option is particularly useful for controlling render order when you have multiple head entries that might contain similar tags.

## [Reactivity](#reactivity)

### [Manual Control](#manual-control)

For more granular control, you can use the returned API:

```
import { useHead } from 'unhead'

// Create the head entry
const headControl = useHead({
  title: 'Initial Title'
})

// Later update specific fields
headControl.patch({
  title: 'Updated Title',
  meta: [
    { name: 'description', content: 'New description' }
  ]
})

// Remove the entry entirely when needed
headControl.dispose()
```

**Use cases for manual control:**

- Updating head after asynchronous data loading
- Conditional changes based on user interactions
- Managing head from global state
- Creating temporary modifications

For framework-specific reactivity details, see the guides for each specific framework.

## [Security Considerations](#security-considerations)

The `useHead()` function applies minimal sanitization to improve developer experience.**Do not** use this function with untrusted or third-party input. It cannot guarantee safety when handling unknown content.

For XSS protection, either:

1. Sanitize your input before passing it to `useHead()`
2. Use the safer alternatives:
  - **useSeoMeta()** for SEO metadata
  - **useHeadSafe()** for general head management

## [TypeScript](#typescript)

Import types directly from your framework's package:

```
import type { ActiveHeadEntry, Head, HeadEntryOptions } from '@unhead/vue'

// Type your head input
const headConfig: Head = {
  title: 'My Page',
  meta: [{ name: 'description', content: 'Page description' }]
}

// Type your entry options
const options: HeadEntryOptions = {
  tagPriority: 'high'
}

const entry: ActiveHeadEntry = useHead(headConfig, options)
```

For custom type extensions, augment the `Head` interface:

```
declare module '@unhead/schema' {
  interface Head {
    customProperty?: string
  }
}
```

## [Common Mistakes](#common-mistakes)

### [Using reactive values incorrectly](#using-reactive-values-incorrectly)

```
// ❌ Wrong - loses reactivity
const title = ref('My Title')
useHead(unheadInstance, { title: title.value })

// ✅ Correct - pass the ref directly
useHead(unheadInstance, { title })
```

### [Calling useHead in async code](#calling-usehead-in-async-code)

```
// ❌ Wrong - may execute outside component context
async function loadData() {
  const data = await fetchData()
  useHead({ title: data.title }) // Context may be lost
}

// ✅ Correct - set up head first, update reactively
const data = ref(null)
useHead(unheadInstance, { title: () => data.value?.title ?? 'Loading...' })
async function loadData() {
  data.value = await fetchData()
}
```

### [Forgetting to dispose manual entries](#forgetting-to-dispose-manual-entries)

```
// ❌ Memory leak if called multiple times
function showModal() {
  useHead({ title: 'Modal Open' })
}

// ✅ Store and dispose when done
let modalHead: ActiveHeadEntry | null = null
function showModal() {
  modalHead = useHead({ title: 'Modal Open' })
}
function hideModal() {
  modalHead?.dispose()
  modalHead = null
}
```

## [Choosing the Right Composable](#choosing-the-right-composable)

| **Composable** | **Use When** |
| --- | --- |
| `useHead()` | General head management, scripts, links, full control |
| `useSeoMeta()` | SEO meta tags only - simpler API, type-safe keys |
| `useHeadSafe()` | Working with untrusted/user-provided input |
| `useScript()` | Loading third-party scripts with lifecycle control |

Start with `useSeoMeta()` for SEO tags - it's simpler and prevents mistakes. Use `useHead()` when you need scripts, links, or advanced features.

## [Common Questions](#common-questions)

### [How do I update the title dynamically?](#how-do-i-update-the-title-dynamically)

Use a reactive value or the `patch()` method:

```
const entry = useHead({ title: 'Initial' })
entry.patch({ title: 'Updated Title' })
```

### [How do I remove head tags?](#how-do-i-remove-head-tags)

Call `dispose()` on the returned entry:

```
const entry = useHead({ title: 'Temporary' })
entry.dispose() // removes all tags from this entry
```

## [Advanced Examples](#advanced-examples)

### [Title Template](#title-template)

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  titleTemplate: title => \`${title} - My Site\`,
  title: 'Home Page'
})
// Results in: "Home Page - My Site"
```

For more details on title templates, see the **Titles guide**.

### [Combining Multiple Head Entries](#combining-multiple-head-entries)

```
import { useHead } from 'unhead'

// Global site defaults
useHead(unheadInstance, {
  titleTemplate: '%s | My Website',
  meta: [
    { name: 'og:site_name', content: 'My Website' }
  ]
})

// Page-specific entries (will be merged with globals)
useHead(unheadInstance, {
  title: 'Product Page',
  meta: [
    { name: 'description', content: 'This product is amazing' }
  ]
})
```

This pattern is commonly used to implement layouts with defaults and page-specific overrides.

### [Async Data Loading](#async-data-loading)

```
import { useHead } from 'unhead'
import { computed, ref } from 'vue'

// Initial setup
const data = ref(null)
const loading = ref(true)
const error = ref(null)

const headControl = useHead({
  title: computed(() => data.value
    ? \`${data.value.name} - Product\`
    : loading.value
      ? 'Loading...'
      : 'Product Not Found')
})

// Fetch data and update head
async function fetchProduct(id) {
  try {
    loading.value = true
    data.value = await api.getProduct(id)
  }
  catch (err) {
    error.value = err
  }
  finally {
    loading.value = false
  }
}
```

This pattern works well with data fetching libraries and state management solutions.

### [Priority-Based Tag Ordering](#priority-based-tag-ordering)

```
import { useHead } from 'unhead'

// Critical meta tags (early in <head>)
useHead(unheadInstance, {
  meta: [
    { charset: 'utf-8' },
    { name: 'viewport', content: 'width=device-width, initial-scale=1' }
  ]
}, { tagPriority: 'critical' })

// Default priority tags (middle of <head>)
useHead(unheadInstance, {
  meta: [
    { name: 'description', content: 'My website description' }
  ]
})

// Low priority tags (end of <head>)
useHead(unheadInstance, {
  meta: [
    { name: 'author', content: 'Jane Doe' }
  ]
}, { tagPriority: 'low' })
```

## [Common Use Cases](#common-use-cases)

Here are some common use cases for `useHead()`:

- Setting page-specific metadata for SEO (consider using **useSeoMeta()** for a more convenient API)
- Managing document title and favicon (see **Titles guide**)
- Adding external scripts and stylesheets (consider using **useScript()** for scripts)
- Setting Open Graph and Twitter card tags

For ready-to-use implementations of common patterns, see our **Starter Recipes**.

Edit this page

Markdown For LLMs

**Did this page help you? **

**Overview** Unhead API reference for useHead(), useSeoMeta(), useScript() composables and DOM/SSR rendering hooks. Full TypeScript support. **useHeadSafe()** Safely manage head tags with XSS protection using useHeadSafe(). Sanitize untrusted user input for titles, meta tags, and other head elements.