---
total: 70
---

# Docs Index

- [Component-oriented](./index.md)

## .ja/api (6)

- [Components](./.ja/api/component.md): BaseFormat Props for Components that is offered Vue I18n
- [Composition API](./.ja/api/composition.md): Composer interfaces
- [Directives](./.ja/api/directive.md): Translation Directive (v-t)
- [General](./.ja/api/general.md): Vue I18n factory
- [Component Injections](./.ja/api/injection.md): Component Custom Properties for Vue I18n
- [Legacy API](./.ja/api/legacy.md): Signature:

## .ja/ecosystem (3)

- [Third-party integrations](./.ja/ecosystem/integrations.md)
- [Official tooling](./.ja/ecosystem/official.md): vue-cli-plugin-i18n is officially provided as the Vue CLI Plugin.
- [Third-party tooling](./.ja/ecosystem/tools.md): Nuxt I18n (@nuxtjs/i18n) fully integrates Vue I18n for Nuxt 3 (v8 and higher).

## .ja/guide/advanced (9)

- [Component Interpolation](./.ja/guide/advanced/component.md): Sometimes, we need to localize with a locale message that was included in a HTML tag or component. For example:
- [Composition API](./.ja/guide/advanced/composition.md): The introduction of setup and Vue’s Composition API open up new possibilities. But to be able to get the full potential out of Vue I18n, we will ne...
- [Custom Directive](./.ja/guide/advanced/directive.md): You can translate not only with $t, but also with the v-t custom directive.
- [Messages Functions](./.ja/guide/advanced/function.md): Vue I18n recommends using the string base on list, named, and literal format as locale messages when translating messages.
- [Lazy loading](./.ja/guide/advanced/lazy.md): Loading all of your localization files at once is overkill and unnecessary.
- [Optimization](./.ja/guide/advanced/optimization.md): As described in "installation" section, Vue I18n offer the following two built ES modules for Bundler.
- [Single file components](./.ja/guide/advanced/sfc.md): If you are building Vue component or Vue application using single file components, you can manage the locale messages with using i18n custom block.
- [TypeScript Support](./.ja/guide/advanced/typescript.md): :::tip Supported Versions
:new: 9.2+
:::
- [Web components](./.ja/guide/advanced/wc.md): :::tip Supported Versions
:new: 9.2+
:::

## .ja/guide/essentials (7)

- [日時フォーマット](./.ja/guide/essentials/datetime.md): 日時を各地域のフォーマットでローカライズできます。
- [フォールバック](./.ja/guide/essentials/fallback.md): fallbackLocale: '<lang>'を指定することで、希望する言語の翻訳がない場合にどの言語を使用するかを選択することができます。
- [ローカルスコープベースのローカライゼーション](./.ja/guide/essentials/local.md): スコープとロケールの変更で示したように、Vue I18nには、グローバルスコープとローカルスコープという2つのスコープの概念があります。
- [数フォーマット](./.ja/guide/essentials/number.md): 定義したフォーマットに従って数をローカライズできます。
- [複数化](./.ja/guide/essentials/pluralization.md): メッセージをローカライズするには、いくつかの言語で複数形をサポートする必要があります。
- [スコープとロケールの変更](./.ja/guide/essentials/scope.md): Vue I18nは、ロケールの切り替え、ロケールメッセージと呼ばれる各言語のメッセージ、日時や数の名前付きフォーマットなどのi18n機能を提供するリソースを管理します。これらは、VueI18nインスタンスで管理されます。
- [メッセージフォーマット構文](./.ja/guide/essentials/syntax.md): Vue I18nでは、メッセージフォーマット構文を使って、UIに表示するメッセージをローカライズすることができます。Vue I18nのmessagesは、様々な機能の構文を持つ補間やメッセージです。

## .ja/guide (1)

- [はじめよう](./.ja/guide/index.md): :::tip 備考
このガイド内のコードサンプルではES6を使用します。

## .ja/guide/migration (4)

- [Breaking Changes](./.ja/guide/migration/breaking.md): Most of the APIs offered in Vue I18n v9 (for Vue 3) strive to maintain compatibility, to ease the pain of migration from v8 (for Vue 2). But there ...
- [New Features](./.ja/guide/migration/features.md): Vue I18n v9 offers not only Vue 3 support, but this version also is included new features.
- [Migration from Vue 2](./.ja/guide/migration/vue2.md): vue-i18n-bridge is a bridge to make the upgrade as easy as possible between vue-i18n@v8.26.1 or later and vue-i18n@v9.x.
- [Migration in Vue 3](./.ja/guide/migration/vue3.md): Vue I18n supports both styles which are Legacy API mode and Composiyion API mode. Legacy API mode is Options API style, and Composition API mode su...

## .ja (4)

- [index](./.ja/index.md)
- [インストール](./.ja/installation.md): https://unpkg.com/vue-i18n@9
- [イントロダクション](./.ja/introduction.md): :::tip 備考
Vue I18n v8.xに知見があり、Vue I18n v9の新機能について知りたい場合、マイグレーションガイドをご覧ください。
:::
- [Documentation for v8.x](./.ja/v8-docs.md)

## api (1)

- [Component Injections](./api/injection.md): Component Custom Properties for Vue I18n

## ecosystem (3)

- [Third-party integrations](./ecosystem/integrations.md)
- [Official tooling](./ecosystem/official.md): vue-cli-plugin-i18n is officially provided as the Vue CLI Plugin.
- [Third-party tooling](./ecosystem/tools.md): <a href="https://loccy.dev" target="blank" rel="noopener">Loccy</a> is a VS Code extension designed to address common challenges in i18n workflows ...

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
