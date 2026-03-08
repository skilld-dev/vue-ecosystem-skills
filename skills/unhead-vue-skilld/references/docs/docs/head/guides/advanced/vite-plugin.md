---
title: "Build Optimization Plugins · Unhead"
meta:
  "og:description": "Vite and Webpack plugins for Unhead. Tree-shake server composables, transform useSeoMeta, save ~3kb in production bundles."
  "og:title": "Build Optimization Plugins · Unhead"
  description: "Vite and Webpack plugins for Unhead. Tree-shake server composables, transform useSeoMeta, save ~3kb in production bundles."
---

**Advanced**

# **Build Optimization Plugins**

Copy for LLMs

**On this page **

- [What Do the Build Plugins Do?](#what-do-the-build-plugins-do)
- [How Do I Install the Build Plugins?](#how-do-i-install-the-build-plugins)
- [How Do I Configure the Plugin?](#how-do-i-configure-the-plugin)
- [What Options Are Available?](#what-options-are-available)
- [How Do I Verify the Plugin Is Working?](#how-do-i-verify-the-plugin-is-working)
- [How Do I Use With Different Frameworks?](#how-do-i-use-with-different-frameworks)
- [What Are Best Practices?](#what-are-best-practices)
- [Why Isn't It Working?](#why-isnt-it-working)
- [See Also](#see-also)

**Quick Answer:** The Unhead Vite plugin enables build-time optimizations like tree-shaking server-only code and transforming `useSeoMeta()` for smaller bundles. Install with `UnheadVite()` in your Vite config.

## [What Do the Build Plugins Do?](#what-do-the-build-plugins-do)

Unhead provides official build plugins for Vite and Webpack that help optimize your application bundle size through automatic transformations and optimizations.

While these plugins are optional, they're highly recommended for production applications to ensure optimal performance and bundle size.

The build plugins perform several important optimizations:

- Transform `useSeoMeta` calls into raw `useHead()` calls (~3kb savings)
- Apply tree-shaking optimizations specific to Unhead

## [How Do I Install the Build Plugins?](#how-do-i-install-the-build-plugins)

First, install the addons package that contains the build plugins:

```
pnpm add -D @unhead/addons
```

```
yarn add -D @unhead/addons
```

```
npm install -D @unhead/addons
```

## [How Do I Configure the Plugin?](#how-do-i-configure-the-plugin)

### [Vite](#vite)

Add the Unhead Vite plugin to your `vite.config.ts` file:

```
import UnheadVite from '@unhead/addons/vite'
import { defineConfig } from 'vite'

export default defineConfig({
  plugins: [
    UnheadVite(),
  ],
})
```

### [Webpack](#webpack)

Add the Unhead Webpack plugin to your webpack configuration:

```
import { UnheadWebpack } from '@unhead/addons/webpack'

export default {
  plugins: [
    UnheadWebpack(),
  ],
}
```

## [What Options Are Available?](#what-options-are-available)

The build plugins accept configuration options to customize their behavior:

```
UnheadVite({
  // Options here
})
```

| **Option** | **Type** | **Default** | **Description** |
| --- | --- | --- | --- |
| `transformSeoMeta` | `boolean` | `true` | Transform `useSeoMeta` calls to `useHead()` |

## [How Do I Verify the Plugin Is Working?](#how-do-i-verify-the-plugin-is-working)

To verify that the plugin is working correctly, you can:

1. Check your production bundle size before and after adding the plugin
2. Inspect the transformed code in your build output
3. Monitor client-side performance metrics

## [How Do I Use With Different Frameworks?](#how-do-i-use-with-different-frameworks)

When using Unhead with a framework, make sure to add the plugin to your build configuration:

```
// No configuration needed - Nuxt configures the plugin automatically
```

```
import UnheadVite from '@unhead/addons/vite'
// vite.config.ts
import vue from '@vitejs/plugin-vue'

export default {
  plugins: [
    vue(),
    UnheadVite(),
  ],
}
```

```
import UnheadVite from '@unhead/addons/vite'
// vite.config.ts
import react from '@vitejs/plugin-react'

export default {
  plugins: [
    react(),
    UnheadVite(),
  ],
}
```

### [Can I Disable Specific Transformations?](#can-i-disable-specific-transformations)

You can customize the plugin's behavior based on your needs:

```
UnheadVite({
  // Disable useSeoMeta transformation if you prefer to keep it
  transformSeoMeta: false,
})
```

## [What Are Best Practices?](#what-are-best-practices)

- Add the plugin early in your development process
- Keep the default options for most use cases
- Add the plugin fairly late in your plugin chain to ensure it can transform all Unhead code
- Verify bundle size improvements after adding the plugin

## [Why Isn't It Working?](#why-isnt-it-working)

- If optimizations aren't applied, check that the plugin is correctly configured
- If you see unexpected behavior, try disabling specific optimizations
- For framework-specific issues, check the framework documentation for Unhead integration

## [See Also](#see-also)

- **Bundle Optimizations** - Client-only tags
- **Template Params** - Dynamic parameters
- **useHead() API** - Full API reference

Edit this page

Markdown For LLMs

**Did this page help you? **

**Bundle Optimizations** Reduce bundle size with client-only and server-only tags. Use mode option or import.meta guards for SSR/CSR optimization. **Template Params** Dynamic placeholders like %s and %siteName in head tags. Define site name, separator, and custom variables for consistent branding.

**On this page **

- [What Do the Build Plugins Do?](#what-do-the-build-plugins-do)
- [How Do I Install the Build Plugins?](#how-do-i-install-the-build-plugins)
- [How Do I Configure the Plugin?](#how-do-i-configure-the-plugin)
- [What Options Are Available?](#what-options-are-available)
- [How Do I Verify the Plugin Is Working?](#how-do-i-verify-the-plugin-is-working)
- [How Do I Use With Different Frameworks?](#how-do-i-use-with-different-frameworks)
- [What Are Best Practices?](#what-are-best-practices)
- [Why Isn't It Working?](#why-isnt-it-working)
- [See Also](#see-also)