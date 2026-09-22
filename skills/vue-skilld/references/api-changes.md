# API changes, 3.4 through 3.6.0-beta.17

Citations: official release blog posts and the vuejs/core changelog. For every 3.6 pre-release detail, the source of record is [CHANGELOG.md on the `minor` branch](https://github.com/vuejs/core/blob/minor/CHANGELOG.md).

## 3.6 line (through beta.17)

- NEW (experimental): `createVaporApp()`, `createVaporSSRApp()`, `vaporInteropPlugin`, `defineVaporComponent()`, `defineVaporAsyncComponent()`, `defineVaporCustomElement()`, `defineVaporSSRCustomElement()`, `isVaporComponent()`, `<script setup vapor>`. All exported from the main `vue` entry (`dist/vue.d.ts:4-5`). See [Vapor Mode](./vapor-mode.md).
- NEW: `renderEffect()`, Vapor runtime helpers (`delegate`, `on`, `createFor`, `createIf`, `applyVShow`, model appliers), and Vapor built-ins (`VaporTransition`, `VaporKeepAlive`, `VaporTeleport`, `VaporSlot`); visible in the export list of `dist/vue.runtime-with-vapor.esm-browser.prod.js`.
- Changed: `@vue/reactivity` rebuilt on alien-signals; better performance and memory, no API changes ([rc.1 notes](https://github.com/vuejs/core/releases/tag/v3.6.0-rc.1)).
- NEW in beta.11: template compiler resolves slot prop bindings as components ([#13573](https://github.com/vuejs/core/pull/13573)).
- NEW in beta.11: static template hydration fast path ([#14752](https://github.com/vuejs/core/pull/14752)).
- NEW in beta.15: `compilerOptions.eventDelegation` disables Vapor event delegation ([#14924](https://github.com/vuejs/core/pull/14924)). Removed again in rc.2 in favor of the opt-in `.delegate` modifier ([rc.2 notes](https://github.com/vuejs/core/releases/tag/v3.6.0-rc.2)).
- Beta.11 to beta.17 otherwise consist of Vapor compiler/runtime stabilization, HMR and custom element fixes ([beta.17 entry](https://github.com/vuejs/core/releases/tag/v3.6.0-beta.17)).

## 3.5 ([release blog](https://blog.vuejs.org/posts/vue-3-5))

- NEW `useId()`: stable SSR/client-unique IDs for forms and accessibility.
- NEW `useTemplateRef(key)`: preferred over name-matched plain refs; supports dynamic ref IDs.
- NEW `onWatcherCleanup(fn)`: cleanup inside `watch`/`watchEffect` callbacks; callable from nested functions, unlike the `onCleanup` parameter.
- NEW lazy hydration: `hydrateOnVisible()`, `hydrateOnIdle()`, `hydrateOnInteraction()`, `hydrateOnMediaQuery()` passed as `defineAsyncComponent({ hydrate })`.
- STABLE reactive props destructure: `const { count = 0 } = defineProps<{ count?: number }>()` replaces `withDefaults`.
- NEW `<Teleport defer>`: mounts after the current render cycle so the target can be rendered by the same tree.
- NEW `data-allow-mismatch` attribute suppresses hydration mismatch warnings.
- NEW `useHost()` / `useShadowRoot()` for custom elements.

## 3.4 ([release blog](https://blog.vuejs.org/posts/vue-3-4))

- STABLE `defineModel()`: declares the prop and returns a mutable ref; replaces manual `defineProps` + `emit('update:modelValue')`.
- NEW `v-bind` same-name shorthand: `:id` for `:id="id"`.
- BREAKING: Reactivity Transform (`$ref`, `$computed`, `$()`) removed. Migrate to plain APIs or Vue Macros.
- BREAKING: `@vnodeXXX` listeners are now a compiler error; use `@vue:mounted` etc.
- BREAKING: global `JSX` namespace no longer registered; set `jsxImportSource: "vue"` or import `vue/jsx`.
- BREAKING: `app.config.unwrapInjectedRef` removed; `inject()` always unwraps refs.
- BREAKING: `v-is` directive removed; use the special `is="vue:Name"` prop.
- Perf: `watch` callbacks now trigger only once per flush, and computed properties trigger effects only when their value reference changes.
