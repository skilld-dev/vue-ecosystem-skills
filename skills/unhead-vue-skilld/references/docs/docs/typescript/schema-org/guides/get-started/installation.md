---
title: "Install Unhead Schema.org · Unhead"
meta:
  "og:description": "Add Schema.org to TypeScript apps with @unhead/schema-org. Setup defineWebSite(), defineWebPage() for Google Rich Results."
  "og:title": "Install Unhead Schema.org · Unhead"
  description: "Add Schema.org to TypeScript apps with @unhead/schema-org. Setup defineWebSite(), defineWebPage() for Google Rich Results."
---

**Get Started**

# **Install Unhead Schema.org**

Copy for LLMs

## [Demos](#demos)

Vite SPA Vite + Vite SSR

## [Setup](#setup)

1. Install `@unhead/schema-org` dependency to your project:

```
yarn add -D @unhead/schema-org
```

```
npm install -D @unhead/schema-org
```

```
pnpm add -D @unhead/schema-org
```

1. Configure the Schema.org params

At a minimum you should provide a **host**.

```
import { UnheadSchemaOrg } from '@unhead/schema-org'

useHead({
  templateParams: {
    schemaOrg: {
      host: 'https://example.com',
    }
  }
})
```

See the **Schema.org Params** for all options you can pass on `schemaOrg`.

### [3. Add Site Schema.org](#_3-add-site-schemaorg)

```
useSchemaOrg([
  // @todo Select Identity: http://unhead.unjs.io/schema-org/recipes/identity
  defineWebSite({
    name: 'My Awesome Website',
  }),
  defineWebPage(),
])
```

## [Recommended: Tree-shaking for SSR](#recommended-tree-shaking-for-ssr)

If you're using Vite SSR, it's highly recommended to add the **Unhead tree-shaking plugin**.

This will remove the `@unhead/schema-org` dependency from your client bundle, and only include it in your server bundle.

@unhead/schema-org

```
import UnheadVite from '@unhead/addons/vite'
import { defineConfig } from 'vite'

export default defineConfig({
  plugins: [
    UnheadVite(),
  ]
})
```

## [Optional: Auto-Imports](#optional-auto-imports)

If you're using Vite with **unplugin-vue-components** or **unplugin-auto-import**, you can optionally configure automatic imports.

Modify your `vite.config.ts` to get the auto-imports.

```
import { schemaAutoImports, SchemaOrgResolver } from '@unhead/schema-org'

export default defineConfig({
  plugins: [
    // ...
    Components({
      // ...
      resolvers: [
        // auto-import schema-org components
        SchemaOrgResolver(),
      ],
    }),
    AutoImport({
      // ...
      imports: [
        // auto-import schema-org composables
        {
          '@unhead/schema-org': schemaAutoImports,
        },
      ],
    }),
  ]
})
```

```
import { schemaAutoImports, SchemaOrgResolver } from '@unhead/schema-org/vue'

export default defineConfig({
  plugins: [
    // ...
    Components({
      // ...
      resolvers: [
        // auto-import schema-org components
        SchemaOrgResolver(),
      ],
    }),
    AutoImport({
      // ...
      imports: [
        // auto-import schema-org composables
        {
          '@unhead/schema-org/vue': schemaAutoImports,
        },
      ],
    }),
  ]
})
```

## [Next Steps](#next-steps)

Your app is now serving basic Schema.org, congrats! 

The next steps are:

1. Choose an **Identity**
2. Set up your pages for **Schema.org Params**
3. Then feel free to follow some recipes:

- **Breadcrumbs**
- **FAQ Page**
- **Site Search**

Edit this page

Markdown For LLMs

**Did this page help you? **

**Streaming** Stream head tags as async content resolves during server-side rendering **Installation** Set up Unhead in Vue with createHead() and app.use(). Full SSR support with transformHtmlTemplate(). Works with Vue 3 and Vite.