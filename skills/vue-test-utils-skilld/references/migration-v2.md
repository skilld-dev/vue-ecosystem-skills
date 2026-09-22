# Migration: v1 -> v2, and 2.5.x changes

Official migration guide: https://test-utils.vuejs.org/migration/

## Mounting options

| v1 | v2 |
|---|---|
| `propsData` | `props` (alias still works, deprecated: `dist/src/types.d.ts:33-35`) |
| `localVue` + `createLocalVue` | removed; use `global.plugins`, `global.mixins`, `global.directives` |
| `mocks`, `stubs`, `provide`, `mixins`, `plugins`, `components`, `directives` | nested under `global` |
| `attachToDocument` | `attachTo` (Element or CSS selector) |
| `scopedSlots` | removed; use `slots` for everything |
| `context`, `listeners`, `parentComponent` | removed |

## Wrapper methods

| v1 | v2 |
|---|---|
| `destroy()` | `unmount()` |
| `setChecked()`, `setSelected()` | merged into `setValue()` |
| `emittedByOrder` | `emitted()` |
| `contains()` | `find(...).exists()` |
| `is()`, `isEmpty()`, `isVueInstance()`, `name()`, `setMethods()` | removed |
| `createWrapper(el)` | `new DOMWrapper(el)` |
| `findAll(...).at(i)` | `findAll(...)[i]`; returns a plain array |
| `find(NameSelector)` for components | `findComponent(Component \| { name } \| { ref } \| css)`; `find()` is CSS-only |
| `findAllComponents({ ref })` | unsupported; use `data-test` attributes and CSS selectors |
| `enableAutoDestroy` | `enableAutoUnmount(afterEach)` (since 2.0.0-rc.16) |

## Behavioral changes to watch

- `shallowMount` no longer renders default slot content of stubbed components. Restore with `config.global.renderStubDefaultSlot = true`.
- `shallowMount` stub tags are kebab-case: `hello-world-stub`, not `helloworld-stub`.
- String slot templates read scoped data from `params`: `slots: { default: '<p>{{ params.id }}</p>' }`.
- In string slot templates, `props` no longer refers to slot scope.
- `trigger()` and `setValue()` return `nextTick`; v1 returned synchronously in some paths.

## 2.5.x

- 2.5.0 (breaking): class components (vue-class-component style) are no longer supported. Convert to `defineComponent`, plain options, or `<script setup>`. https://github.com/vuejs/test-utils/pull/2904
- 2.5.0: mounting two wrappers no longer freezes re-rendering of the first root component. https://github.com/vuejs/test-utils/pull/2890
- 2.5.0: `emitted()` history for child components is cleared on their unmount. https://github.com/vuejs/test-utils/pull/2898
- 2.5.0: `<summary>` element behavior corrected in `trigger`. https://github.com/vuejs/test-utils/pull/2806
- 2.5.1: `config` is shared across CJS and ESM builds. https://github.com/vuejs/test-utils/releases/tag/v2.5.1

## 2.4.x late fixes

- 2.4.11: `setData()` correct for components using both `setup()` and `data()`; `GlobalMountOptions` type exported; spec-compliant `event.code` on `keydown`/`keyup`. https://github.com/vuejs/test-utils/releases/tag/v2.4.11
- 2.4.2: `text()` trims whitespace between elements: `<span>A </span><span>B</span>` reads `AB`. https://github.com/vuejs/test-utils/releases/tag/v2.4.2

## 2.2.0 - 2.3.0 additions

- 2.2.0: `html({ raw: true })`; directive stubs via `vName` keys; array argument to `setValue` for multiselects. https://github.com/vuejs/test-utils/releases/tag/v2.2.0
- 2.3.0: `renderToString` for SSR tests. https://github.com/vuejs/test-utils/releases/tag/v2.3.0
