# API surface

All facts verified against the prepared package source (vue@3.6.0-beta.17) or official documentation.

## Entry points

Defined in `package.json:19-71`:

| Import | Condition | File |
|---|---|---|
| `vue` | import (default) | `dist/vue.runtime.esm-bundler.js` (runtime-only, bundlers) |
| `vue` | import, node | `index.mjs` |
| `vue` | require | `index.js` -> `dist/vue.cjs(.prod).js` by `NODE_ENV` |
| `vue/server-renderer` | import / require | `server-renderer/index.mjs` / `index.js` (re-exports `@vue/server-renderer`) |
| `vue/compiler-sfc` | import / require / browser | `compiler-sfc/index.mjs` / `index.js` / `index.browser.mjs` (re-exports `@vue/compiler-sfc`) |
| `vue/jsx-runtime`, `vue/jsx-dev-runtime` | any | `jsx-runtime/index.mjs` / `index.js` |
| `vue/jsx` | any | `jsx.d.ts` (global JSX namespace registration) |
| `vue/dist/*` | any | `dist/*` |

The main module re-exports everything from `@vue/runtime-dom` and `@vue/runtime-vapor` (`dist/vue.d.ts:4-5`), so VDOM and Vapor APIs share one import specifier.

## Which dist file (from `README.md`)

**No bundler, `<script src>`:** `vue(.runtime).global(.prod).js` (IIFE, exposes `Vue`). `vue.global.js` includes the template compiler; `vue.runtime.global.js` does not.

**No bundler, `<script type="module">`:** `vue(.runtime).esm-browser(.prod).js`. A Vapor browser build also exists: `vue.runtime-with-vapor.esm-browser.prod.js` in this version's `dist/`.

**Bundler (default):** `vue.runtime.esm-bundler.js`. Prod/dev branches guarded by `process.env.NODE_ENV`; not minified; imports `@vue/*` packages that must all resolve to the same version.

**Bundler + runtime template compilation:** alias `vue` to `vue.esm-bundler.js`, which exports a working `compile`. The runtime-only build's `compile` warns and returns a no-op (`dist/vue.runtime.esm-bundler.js:17-21`).

**Node SSR:** `vue.cjs(.prod).js` via `require()`; the right file is picked by `NODE_ENV`.

## Bundler feature flags

Replace at compile time for tree-shaking ([official reference](https://vuejs.org/api/compile-time-flags.html)):

- `__VUE_OPTIONS_API__` (default `true`)
- `__VUE_PROD_DEVTOOLS__` (default `false`)
- `__VUE_PROD_HYDRATION_MISMATCH_DETAILS__` (default `false`)

## compiler-sfc in Node

The CJS entry first imports `register-ts.js`, which calls `@vue/compiler-sfc`'s `registerTS(() => require('typescript'))` when `require` exists (`compiler-sfc/register-ts.js:1-3`). Effect: in Node CJS with TypeScript installed, SFC type-only features work without manual registration. In ESM or browser builds, call `registerTS` yourself if you need the TypeScript-dependent paths.

## JSX

- `vue/jsx-runtime` exports `jsx`, `jsxs`, `jsxDEV`, `Fragment` (`jsx-runtime/index.d.ts:8`); use with `jsxImportSource: "vue"` and `jsx: "react-jsx"`.
- `import 'vue/jsx'` registers the deprecated global `JSX` namespace (`jsx.d.ts:5-20`). Since 3.4 this is opt-in.

## Export catalog

Verified against the export list of `dist/vue.runtime-with-vapor.esm-browser.prod.js`. Grouped; internal-looking helpers omitted.

**App and components:** `createApp`, `createSSRApp`, `createVaporApp`, `createVaporSSRApp`, `defineComponent`, `defineAsyncComponent`, `defineCustomElement`, `defineSSRCustomElement`, `defineVaporComponent`, `defineVaporAsyncComponent`, `defineVaporCustomElement`, `defineVaporSSRCustomElement`, `isVaporComponent`.

**Compiler macros (SFC):** `defineProps`, `defineEmits`, `defineSlots`, `defineExpose`, `defineOptions`, `defineModel`, `withDefaults`.

**Reactivity:** `ref`, `shallowRef`, `isRef`, `unref`, `toRef`, `toRefs`, `toValue`, `customRef`, `triggerRef`, `reactive`, `shallowReactive`, `readonly`, `shallowReadonly`, `isReactive`, `isReadonly`, `isProxy`, `isShallow`, `toRaw`, `markRaw`, `computed`, `effect`, `effectScope`, `EffectScope`, `getCurrentScope`, `onScopeDispose`, `ReactiveEffect`, `getCurrentWatcher`.

**Watch:** `watch`, `watchEffect`, `watchPostEffect`, `watchSyncEffect`, `onWatcherCleanup`.

**Lifecycle:** `onMounted`, `onBeforeMount`, `onUpdated`, `onBeforeUpdate`, `onBeforeUnmount`, `onUnmounted`, `onActivated`, `onDeactivated`, `onErrorCaptured`, `onRenderTracked`, `onRenderTriggered`, `onServerPrefetch`.

**Dependency injection:** `provide`, `inject`, `hasInjectionContext`.

**Helpers:** `useSlots`, `useAttrs`, `useCssModule`, `useCssVars`, `useId`, `useModel`, `useTemplateRef`, `useHost`, `useShadowRoot`, `useSSRContext`, `useVaporCssVars`, `useAsyncComponentState`.

**Lazy hydration (3.5+):** `hydrateOnVisible`, `hydrateOnIdle`, `hydrateOnInteraction`, `hydrateOnMediaQuery`.

**Render function / VDOM:** `h`, `createVNode`, `cloneVNode`, `mergeProps`, `openBlock`, `createBlock`, `createElementBlock`, `createElementVNode`, `createTextVNode`, `createCommentVNode`, `createStaticVNode`, `createSlots`, `withCtx`, `withDirectives`, `withKeys`, `withModifiers`, `withMemo`, `renderSlot`, `renderList`, `resolveComponent`, `resolveDynamicComponent`, `resolveDirective`, `resolveFilter`, `isVNode`, `normalizeClass`, `normalizeStyle`, `toDisplayString`, `toHandlers`, `compile`.

**Built-ins:** `Transition`, `TransitionGroup`, `KeepAlive`, `Teleport`, `Suspense`, plus Vapor counterparts `VaporTransition`, `VaporTransitionGroup`, `VaporKeepAlive`, `VaporTeleport`, `VaporSlot`, `VaporFragment`.

**Directives:** `vModelText`, `vModelCheckbox`, `vModelRadio`, `vModelSelect`, `vModelDynamic`, `vShow`, `withVaporDirectives`, `withVaporModifiers`, `withVaporKeys`.

**SSR:** `renderToString` and friends live in `vue/server-renderer`, not the main entry. The main entry also exports `initDirectivesForSSR` and `ssrContextKey`.

**Vapor runtime helpers:** `vaporInteropPlugin`, `renderEffect`, `delegate`, `delegateEvents`, `on`, `createFor`, `createForSlots`, `createIf`, `createSelector`, `createDynamicComponent`, `applyVShow`, `applyDynamicModel`, `applyTextModel` / `applyCheckboxModel` / `applyRadioModel` / `applySelectModel`, `setTemplateRefBinding`, `getDefaultValue`.
