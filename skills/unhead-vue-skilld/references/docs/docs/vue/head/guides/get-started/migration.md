---
title: "Upgrade Guide · Unhead"
meta:
  "og:description": "Learn how to migrate between Unhead versions for Vue users."
  "og:title": "Upgrade Guide · Unhead"
  description: "Learn how to migrate between Unhead versions for Vue users."
---

**Get Started**

# **Upgrade Guide**

Copy for LLMs

**On this page **

- [Migrate to v3 (from v2)](#migrate-to-v3-from-v2)
- [Migrate to v2 (from v1)](#migrate-to-v2-from-v1)

## [Migrate to v3 (from v2)](#migrate-to-v3-from-v2)

Unhead v3 removes all deprecated APIs and focuses on performance improvements. This guide covers the breaking changes for Vue users.

Nuxt users should not be affected by most of these changes as Nuxt handles the integration automatically.

### [Legacy Property Names](#legacy-property-names)

 Impact Level: High

The `DeprecationsPlugin` that automatically converted legacy property names has been removed. You must update your head entries to use the current property names.

**`children` → `innerHTML`**

```
useHead({
  script: [{
-   children: 'console.log("hello")',
+   innerHTML: 'console.log("hello")',
  }]
})
```

**`hid` / `vmid` → `key`**

```
useHead({
  meta: [{
-   hid: 'description',
+   key: 'description',
    name: 'description',
    content: 'My description'
  }]
})
```

**`body: true` → `tagPosition: 'bodyClose'`**

```
useHead({
  script: [{
    src: '/script.js',
-   body: true,
+   tagPosition: 'bodyClose',
  }]
})
```

### [Schema.org Plugin](#schemaorg-plugin)

 Impact Level: High

The `PluginSchemaOrg` and `SchemaOrgUnheadPlugin` exports have been removed. Use `UnheadSchemaOrg` instead.

```
- import { PluginSchemaOrg } from '@unhead/schema-org/vue'
+ import { UnheadSchemaOrg } from '@unhead/schema-org/vue'

const head = createHead({
  plugins: [
-   PluginSchemaOrg()
+   UnheadSchemaOrg()
  ]
})
```

### [Server Composables Removed](#server-composables-removed)

 Impact Level: Medium-High

The `useServerHead`, `useServerHeadSafe`, and `useServerSeoMeta` composables have been removed. Use the standard composables instead.

```
- import { useServerHead, useServerSeoMeta } from '@unhead/vue'
+ import { useHead, useSeoMeta } from '@unhead/vue'

- useServerHead({ title: 'My Page' })
+ useHead({ title: 'My Page' })

- useServerSeoMeta({ description: 'My description' })
+ useSeoMeta({ description: 'My description' })
```

If you need server-only head management, use conditional logic:

```
if (import.meta.server) {
  useHead({ title: 'Server Only' })
}
```

### [Vue Legacy Exports Removed](#vue-legacy-exports-removed)

 Impact Level: Medium

The `/legacy` export path has been removed from `@unhead/vue`.

```
- import { createHead } from '@unhead/vue/legacy'
+ import { createHead } from '@unhead/vue/client'
// or for SSR
+ import { createHead } from '@unhead/vue/server'
```

**`createHeadCore` Removed**

```
- import { createHeadCore } from '@unhead/vue'
+ import { createHead } from '@unhead/vue/server'
// or for client
+ import { createHead } from '@unhead/vue/client'
```

### [Core API Changes](#core-api-changes)

 Impact Level: Medium

**`headEntries()` → `entries` Map**

```
- const entries = head.headEntries()
+ const entries = [...head.entries.values()]
```

**`mode` Option Removed**

The `mode` option on head entries has been removed.

```
useHead({
  title: 'My Page',
- }, { mode: 'server' })
+ })
```

### [Hooks](#hooks)

 Impact Level: Low

The following hooks have been removed:

- `init` - No longer needed
- `dom:renderTag` - DOM rendering is now synchronous
- `dom:rendered` - Use code after `renderDOMHead()` instead

The `dom:beforeRender` hook is now synchronous and `renderDOMHead` no longer returns a Promise:

```
- await renderDOMHead(head, { document })
+ renderDOMHead(head, { document })
```

The SSR hooks (`ssr:beforeRender`, `ssr:render`, `ssr:rendered`) are now synchronous and `renderSSRHead` no longer returns a Promise:

```
- const head = await renderSSRHead(head)
+ const head = renderSSRHead(head)
```

### [Other Removed APIs](#other-removed-apis)

- `resolveUnrefHeadInput` - Reactive resolution now happens automatically
- `setHeadInjectionHandler` - Head injection is handled automatically
- `DeprecationsPlugin` - Update property names directly instead

### [Type Changes](#type-changes)

 Impact Level: Low

```
- import type { Head, MetaFlatInput } from '@unhead/vue'
+ import type { HeadTag, MetaFlat } from '@unhead/vue'
```

---

## [Migrate to v2 (from v1)](#migrate-to-v2-from-v1)

With the release of Unhead v2, we now have first-class support for other frameworks. This section covers the v1 to v2 migration for Vue users.

### [Client / Server Subpath Exports](#client-server-subpath-exports)

 Impact Level: Critical

Nuxt should not be affected by this change.

** Breaking Changes:**

- `createServerHead()` and `createHead()` exports from `unhead` are removed

The path where you import `createHead` from has been updated to be a subpath export.

**Client bundle:**

```
-import { createHead } from '@unhead/vue'
+import { createHead } from '@unhead/vue/client'
import { createApp } from 'vue'

const app = createApp()
const head = createHead()
app.use(head)
```

**Server bundle:**

```
-import { createServerHead } from '@unhead/vue'
+import { createHead } from '@unhead/vue/server'
import { createApp } from 'vue'

const app = createApp()

-const head = createServerHead()
+const head = createHead()

app.use(head)
```

### [Removed Implicit Context](#removed-implicit-context)

 Impact Level: Critical

Nuxt should not be affected by this change.

** Breaking Changes:**

- `setHeadInjectionHandler()` is removed
- Error may be thrown when using `useHead()` after async operations

The implicit context implementation kept a global instance of Unhead available so that you could use the `useHead()` composables anywhere in your application.

In v2, the core composables no longer have access to the Unhead instance. Instead, you must pass the Unhead instance to the composables if you'd like to use Unhead in a non-Vue context.

Vue Context Lost

```
<script setup lang="ts">
// In Vue this happens in lifecycle hooks where we have async operations.
onMounted(async () => {
  await fetchSomeData()
  useHead({
    title: 'This will not work'
  })
})
</script>
```

If you're getting errors on your `useHead()` about context, check the **Reactivity and Async Context** guide.

### [Removed `vmid`, `hid`, `children`, `body`](#removed-vmid-hid-children-body)

 Impact Level: High

For legacy support with Vue Meta we allowed end users to provide deprecated properties: `vmid`, `hid`, `children` and `body`.

You must update these properties to the appropriate replacement or remove them. See the [**v3 migration section**](#legacy-property-names) for the replacements.

### [Opt-in Template Params & Tag Alias Sorting](#opt-in-template-params-tag-alias-sorting)

 Impact Level: High

To reduce the bundle size and improve performance, we've moved the template params and tag alias sorting to optional plugins.

```
import { AliasSortingPlugin, TemplateParamsPlugin } from '@unhead/vue/plugins'

createHead({
  plugins: [TemplateParamsPlugin, AliasSortingPlugin]
})
```

### [Vue 2 Support](#vue-2-support)

 Impact Level: Critical

Unhead v2 no longer supports Vue v2. If you're using Vue v2, you will need to lock your dependencies to the latest v1 version of Unhead.

### [Promise Input Support](#promise-input-support)

 Impact Level: Medium

If you have promises as input they will no longer be resolved, either await the promise before passing it along or register the optional promises plugin.

```
import { createHead } from '@unhead/vue/client'
import { PromisePlugin } from '@unhead/vue/plugins'

const unhead = createHead({
  plugins: [PromisePlugin]
})
```

### [Updated `useScript()`](#updated-usescript)

 Impact Level: High

** Breaking Changes:**

- Script instance is no longer augmented as a proxy and promise
- `script.proxy` is rewritten for simpler, more stable behavior
- `stub()` and runtime hook `script:instance-fn` are removed

**Replacing promise usage**

```
const script = useScript()

-script.then(() => console.log('loaded')
+script.onLoaded(() => console.log('loaded'))
```

**Replacing proxy usage**

```
const script = useScript('..', {
  use() { return { foo: [] } }
})

-script.foo.push('bar')
+script.proxy.foo.push('bar')
```

### [Tag Sorting Updated](#tag-sorting-updated)

 Impact Level: Low

**Capo.js** sorting is now the default. You can opt-out:

```
createHead({
  disableCapoSorting: true,
})
```

### [Default SSR Tags](#default-ssr-tags)

 Impact Level: Low

When SSR Unhead will now insert important default tags for you:

- `<meta charset="utf-8">`
- `<meta name="viewport" content="width=device-width, initial-scale=1">`
- `<html lang="en">`

```
import { createHead } from '@unhead/vue/server'

// disable when creating the head instance
createHead({
  disableDefaults: true,
})
```

Or override the defaults:

```
import { useHead } from '@unhead/vue'

useHead({
  htmlAttrs: {
    lang: 'fr'
  }
})
```

### [CJS Exports Removed](#cjs-exports-removed)

 Impact Level: Low

CommonJS exports have been removed in favor of ESM only.

```
-const { useHead } = require('@unhead/vue')
+import { useHead } from '@unhead/vue'
```

### [Deprecated `@unhead/schema`](#deprecated-unheadschema)

 Impact Level: Low

The `@unhead/schema` package is deprecated. Import from `@unhead/vue/types` instead.

```
-import { HeadTag } from '@unhead/schema'
+import { HeadTag } from '@unhead/vue/types'
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Installation** Set up Unhead in Vue with createHead() and app.use(). Full SSR support with transformHtmlTemplate(). Works with Vue 3 and Vite. **Context & Reactivity** Use refs, computed, and Pinia with useHead(). Handle async context in lifecycle hooks with injectHead() or effectScope().

**On this page **

- [Migrate to v3 (from v2)](#migrate-to-v3-from-v2)
- [Migrate to v2 (from v1)](#migrate-to-v2-from-v1)