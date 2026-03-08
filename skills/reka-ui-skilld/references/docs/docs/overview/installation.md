---
url: /docs/overview/installation.md
---
# Installation

A quick tutorial to walk through installing the packages, as well as the supported plugins.

## Installing the package

## Nuxt modules

Reka UI offers Nuxt modules support.

In `nuxt.config.ts`, simply add `reka-ui/nuxt` into the modules, and it will auto-imports all the components for you.

```ts
export default defineNuxtConfig({
  modules: ['reka-ui/nuxt'],
})
```

## unplugin-vue-components

Reka UI also has resolver for the popular unplugin-vue-components.

In `vite.config.ts`, import `reka-ui/resolver`, and configure as such and it will auto-imports all the components from Reka UI.

```ts{2,10 }
import Components from 'unplugin-vue-components/vite'
import RekaResolver from 'reka-ui/resolver'

export default defineConfig({
  plugins: [
    vue(),
    Components({
      dts: true,
      resolvers: [
        RekaResolver()

        // RekaResolver({
        //   prefix: '' // use the prefix option to add Prefix to the imported components
        // })
      ],
    }),
  ],
})
```
