---
total: 39
---

# Docs Index

## api (6)

- [Components](./api/component.md): BaseFormat Props for Components that is offered Vue I18n
- [Composition API](./api/composition.md): Composer interfaces
- [Directives](./api/directive.md): Translation Directive (v-t)
- [General](./api/general.md): Vue I18n factory
- [Component Injections](./api/injection.md): Component Custom Properties for Vue I18n
- [Legacy API](./api/legacy.md): Signature:

## ecosystem (2)

- [Official tooling](./ecosystem/official.md): vue-cli-plugin-i18n is officially provided as the Vue CLI Plugin.
- [Third-party tooling](./ecosystem/tools.md): Loccy is a VS Code extension designed to address common challenges in i18n workflows for Vue projects. It helps you easily find and update translat...

## guide/advanced (11)

- [Component Interpolation](./guide/advanced/component.md): Sometimes, we need to localize with a locale message that was included in a HTML tag or component. For example:
- [Composition API](./guide/advanced/composition.md): The introduction of setup and Vue’s Composition API opens up new possibilities. But to be able to get the full potential out of Vue I18n, we will n...
- [Custom Directive](./guide/advanced/directive.md): :::danger NOTE
v-t will be deprecated at v11, and will be dropped at v12. This section is for those who are still using v10.
:::
- [Custom Message Format](./guide/advanced/format.md): :::tip Supported Versions
:new: 9.3+
:::
- [Messages Functions](./guide/advanced/function.md): Vue I18n recommends using the string base on list, named, and literal format as locale messages when translating messages.
- [Lazy loading](./guide/advanced/lazy.md): Loading all of your localization files at once is overkill and unnecessary.
- [Small size subset of Vue I18n](./guide/advanced/lite.md): petite-vue-i18n is an alternative distribution of Vue I18n, which provides only minimal features.
- [Optimization](./guide/advanced/optimization.md): As described in "Different Distribution files" section, Vue I18n offer the following two built ES modules for Bundler.
- [Single file components](./guide/advanced/sfc.md): If you are building Vue component or Vue application using single file components, you can manage the locale messages using i18n custom block.
- [TypeScript Support](./guide/advanced/typescript.md): :::tip Supported Versions
:new: 9.2+
:::
- [Web components](./guide/advanced/wc.md): :::tip Supported Versions
:new: 9.2+
:::

## guide/essentials (8)

- [Datetime Formatting](./guide/essentials/datetime.md): You can localize the datetime with your definition formats.
- [Fallbacking](./guide/essentials/fallback.md): fallbackLocale: '<lang>' to choose which language to use when your preferred language lacks a translation.
- [Local Scope Based Localization](./guide/essentials/local.md): In 'Scope and Locale Changing’, Vue I18n has two scope concepts, global scope and local scope.
- [Number Formatting](./guide/essentials/number.md): You can localize the number with your definition formats.
- [Pluralization](./guide/essentials/pluralization.md): To localize the message, you might need to support the pluralization for some languages.
- [Scope and Locale Changing](./guide/essentials/scope.md): Vue I18n manages resources to offer i18n features, including locale switching, each language messages called locales messages, and named format for...
- [Getting started](./guide/essentials/started.md): Creating a global application with Vue + Vue I18n is dead simple. With Vue.js, we are already composing our application with components. When addin...
- [Message Format Syntax](./guide/essentials/syntax.md): Vue I18n can use message format syntax to localize the messages to be displayed in the UI. Vue I18n messages are interpolations and messages with v...

## guide/extra (2)

- [Different Distribution files](./guide/extra/dist.md): In the dist/ directory of the npm package you will find many different builds of Vue I18n. Here is an overview of which dist file should be used de...
- [Documentation for v8.x](./guide/extra/v8-docs.md)

## guide (3)

- [Installation](./guide/installation.md): ::: code-group
- [What is Vue I18n?](./guide/introduction.md): :::tip NOTE
If you would like to know more about the maintenance status of each version of Vue I18n, please see here.
:::
- [Maintenance Status](./guide/maintenance.md): Vue I18n and related intlify packages has a lifecycle.

## guide/integrations (1)

- [Nuxt 3 integration](./guide/integrations/nuxt3.md): We recommend using Nuxt I18n (@nuxtjs/i18n) to use Vue I18n with Nuxt 3 with advanced features such as localized routing, SEO tags and more.

## guide/migration (6)

- [Breaking Changes in v9](./guide/migration/breaking.md): Most of the APIs offered in Vue I18n v9 (for Vue 3) strive to maintain compatibility, to ease the pain of migration from v8 (for Vue 2). But there ...
- [Breaking Changes in v10](./guide/migration/breaking10.md): Reason: CSP problems can be solved and dynamic resources can be supported
- [Breaking Changes in v11](./guide/migration/breaking11.md): The Legacy API mode was the API mode compatible with v8 for Vue 2. When v9 was released, the Legacy API was provided to smooth the migration from v...
- [New Features in v9](./guide/migration/features.md): Vue I18n v9 offers not only Vue 3 support, but this version also is included new features.
- [Migration from Vue 2](./guide/migration/vue2.md): :::danger NOTE
vue-i18n-bridge will not be provided in v10 due to Vue 2 EOL. v9.13 will be the last version.
:::
- [Migration in Vue 3](./guide/migration/vue3.md): Vue I18n supports both styles which are Legacy API mode and Composition API mode. Legacy API mode is Options API style, and Composition API mode su...
