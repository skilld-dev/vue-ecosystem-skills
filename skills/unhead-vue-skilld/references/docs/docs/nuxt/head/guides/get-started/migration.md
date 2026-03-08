---
title: "Upgrade Guide · Unhead"
meta:
  "og:description": "Learn how to migrate between Unhead versions in Nuxt."
  "og:title": "Upgrade Guide · Unhead"
  description: "Learn how to migrate between Unhead versions in Nuxt."
---

**Get Started**

# **Upgrade Guide**

Copy for LLMs

**On this page **

- [Migrate to v3 (from v2)](#migrate-to-v3-from-v2)
- [Migrate to v2 (from v1)](#migrate-to-v2-from-v1)

## [Migrate to v3 (from v2)](#migrate-to-v3-from-v2)

Unhead v3 removes all deprecated APIs and focuses on performance improvements.

Nuxt handles most Unhead integration automatically. Most Nuxt users will only be affected by the legacy property name changes.

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

 Impact Level: Medium

If you're using `@unhead/schema-org` directly (not through `nuxt-schema-org`), the plugin exports have changed:

```
- import { SchemaOrgUnheadPlugin } from '@unhead/schema-org/vue'
+ import { UnheadSchemaOrg } from '@unhead/schema-org/vue'
```

If you're using the `nuxt-schema-org` module, no changes are needed.

### [Server Composables Removed](#server-composables-removed)

 Impact Level: Low

The `useServerHead`, `useServerHeadSafe`, and `useServerSeoMeta` composables have been removed.

```
- useServerSeoMeta({ description: 'My description' })
+ useSeoMeta({ description: 'My description' })
```

If you need server-only head management:

```
if (import.meta.server) {
  useHead({ title: 'Server Only' })
}
```

### [Hooks](#hooks)

 Impact Level: Low

If you're using Unhead hooks directly:

- `init` hook removed
- `dom:renderTag` hook removed
- `dom:rendered` hook removed
- `dom:beforeRender` is now synchronous
- `renderDOMHead` is now synchronous

---

## [Migrate to v2 (from v1)](#migrate-to-v2-from-v1)

As of Nuxt 3.16, Unhead v2 is the default version.

### [Nuxt v4 Migration](#nuxt-v4-migration)

The best resource for managing the migration is the official **Nuxt v4 migration guide**.

### [Key Changes](#key-changes)

Most v2 changes are handled automatically by Nuxt:

- Client/server subpath exports - Nuxt configures these automatically
- Implicit context - Nuxt manages Vue context integration
- Template params & plugins - Nuxt includes necessary plugins

For the full list of changes, check out the **Vue Upgrade Guide**.

Edit this page

Markdown For LLMs

**Did this page help you? **

**Installation** Unhead is built into Nuxt 3. Use useHead(), useSeoMeta(), and useScript() directly in components. Zero configuration required. **Context & Reactivity** Use refs and computed with useHead() in Nuxt. Handle async context with injectHead() and effectScope(). Automatic reactivity for head tags.

**On this page **

- [Migrate to v3 (from v2)](#migrate-to-v3-from-v2)
- [Migrate to v2 (from v1)](#migrate-to-v2-from-v1)