---
name: vue-test-utils-skilld
description: ALWAYS use when writing, debugging, or reviewing code that imports "@vue/test-utils" or mentions vue test-utils, VTU, mount, shallowMount, findComponent, wrapper queries, or migrating from Vue Test Utils v1. Provides the current API surface, mounting options, wrapper methods, and testing recipes for @vue/test-utils 2.5.1 on Vue 3.
---

# @vue/test-utils 2.5.1 (Vue 3)

Prepared source: `input/source`, version 2.5.1 (`package.json:3`).
Requires Vue 3.x and `@vue/compiler-dom` 3.x as peers; `@vue/server-renderer` 3.x is an optional peer needed only for `renderToString` (`package.json:73-81`).
Test-runner agnostic (Vitest, Jest, others). Needs a browser-like DOM environment (jsdom or happy-dom).

Install: `npm install @vue/test-utils --save-dev`

## Quick start

```ts
import { mount } from '@vue/test-utils'
import Counter from './Counter.vue'

test('increments', async () => {
  const wrapper = mount(Counter, { props: { start: 1 } })
  await wrapper.find('button').trigger('click')
  expect(wrapper.text()).toContain('2')
})
```

## Public API surface

Exports from `dist/src/index.d.ts:13`:

| Export | Kind | Use |
|---|---|---|
| `mount` | function | Mount a component, returns `VueWrapper` (`dist/src/mount.d.ts:17`) |
| `shallowMount` | function | Same as `mount` with all child components stubbed (`dist/src/mount.d.ts:22`) |
| `renderToString` | function | SSR-render a component to a string, `Promise<string>` (`dist/src/renderToString.d.ts:4`) |
| `flushPromises` | function | Await pending non-Vue promises (mocked API calls, timers) (`dist/src/utils/flushPromises.d.ts:1`) |
| `enableAutoUnmount(hook)` | function | Unmount all wrappers via a test hook (`dist/src/utils/autoUnmount.d.ts:4`) |
| `disableAutoUnmount` | function | Stop auto unmounting (`dist/src/utils/autoUnmount.d.ts:3`) |
| `VueWrapper` | class | Wrapper around a mounted component instance (`dist/src/vueWrapper.d.ts:5`) |
| `DOMWrapper` | class | Wrapper around a DOM element; `new DOMWrapper(document.body)` (`dist/src/domWrapper.d.ts:4`) |
| `RouterLinkStub` | component | Stub for `<router-link>` (`dist/src/components/RouterLinkStub.d.ts:1`) |
| `config` | object | Shared default mount options and wrapper plugins (`dist/src/config.d.ts:32`) |
| `createWrapperError` | function | Internal; produces the error wrapper returned by `find` misses |

## Core rules

- `await` every method that returns a promise: `trigger`, `setValue`, `setProps`, `setData`, `renderToString`, `flushPromises`. Without `await`, assertions run before the DOM updates.
- Use `get()` / `getComponent()` when the element must exist; they throw on miss. Use `find()` / `findComponent()` only when absence is a valid outcome; they return an error wrapper whose `exists()` is `false`.
- `find()` accepts CSS selectors only. To locate a child component use `findComponent(Component)`, `findComponent({ name: 'Foo' })`, `findComponent({ ref: 'foo' })`, or a CSS selector.
- Register `enableAutoUnmount(afterEach)` once in test setup to prevent state leaks between tests.
- Use `flushPromises()` for promises Vue does not track (mocked HTTP clients, `setTimeout`).
- `wrapper.vm` only reliably exposes what the component exposes: options-API state, `defineExpose()` bindings (since 2.5.0, PR #2927), or `setup()` return values.

```ts
import { enableAutoUnmount } from '@vue/test-utils'
import { afterEach } from 'vitest'

enableAutoUnmount(afterEach)
```

## Version notes: 2.4.10 -> 2.5.1

- BREAKING (2.5.0): class component support removed. Mount Vue components defined with `defineComponent`, options objects, or `<script setup>` SFCs. https://github.com/vuejs/test-utils/releases/tag/v2.5.0
- Fix (2.5.0): `emitted()` history of child components is cleared when they unmount. Assert events before unmounting. https://github.com/vuejs/test-utils/pull/2898
- Fix (2.5.0): `defineExpose` bindings are visible on `findComponent(...).vm`. https://github.com/vuejs/test-utils/pull/2927
- Fix (2.4.11): `setData()` works correctly for components mixing `setup()` and `data()`. https://github.com/vuejs/test-utils/releases/tag/v2.4.11
- Fix (2.4.11): `trigger('keydown')` sets a spec-compliant `event.code`. https://github.com/vuejs/test-utils/pull/2850
- Type (2.4.11): `GlobalMountOptions` is exported. https://github.com/vuejs/test-utils/pull/2851

## Earlier v2 milestones still relevant

- `renderToString` added in 2.3.0 for SSR testing. https://github.com/vuejs/test-utils/releases/tag/v2.3.0
- `html({ raw: true })`, directive stubs (`vName: true`), and array `setValue` for multiselect added in 2.2.0. https://github.com/vuejs/test-utils/releases/tag/v2.2.0
- `enableAutoUnmount` / `disableAutoUnmount` replaced v1 `enableAutoDestroy`. https://github.com/vuejs/test-utils/releases/tag/v2.0.0-rc.16
- `propsData` still works but is deprecated; use `props` (`dist/src/types.d.ts:33-35`).
- `stubs` accepts a record (`{ Foo: true }`) or an array of names (`['Foo']`) (`dist/src/types.d.ts:80`).

## Migrating from v1 (Vue 2)

Full table: [migration reference](./references/migration-v2.md), official guide https://test-utils.vuejs.org/migration/

- `propsData` -> `props`; `createLocalVue` removed -> `global.plugins` / `global.mixins`
- `mocks`, `stubs`, `provide`, `directives` moved under `global`
- `destroy()` -> `unmount()`; `findAll().at(i)` -> `findAll()[i]` (returns an array)
- `createWrapper()` removed -> `new DOMWrapper(el)`
- `setChecked` / `setSelected` removed -> merged into `setValue`
- `find()` no longer finds components by name; use `findComponent`
- `shallowMount` no longer renders default slot content of stubs; restore with `config.global.renderStubDefaultSlot = true`
- Removed: `is`, `isEmpty`, `isVueInstance`, `name`, `setMethods`, `contains`, `scopedSlots` (merged into `slots`)

## Best practices

- Prefer `mount` with targeted `global.stubs` over `shallowMount`. Shallow tests assert structure, not behavior, and stubbed children hide real interactions. https://test-utils.vuejs.org/guide/advanced/stubs-shallow-mount
- If you do stub broadly, set `config.global.renderStubDefaultSlot = true` so default slot content of stubs still renders (`dist/src/types.d.ts:125-131`).
- Stub directives with the `vName` key: `global.stubs: { vTooltip: true }` or pass a replacement directive object.
- `<transition>` and `<transition-group>` are stubbed by default (`dist/src/types.d.ts:120-124`); custom transition stubs are supported.
- Pass inject values through `global.provide`, matching production injection. For typed injection keys, wrap the key: `provide: { [injectionKey as symbol]: value }`.
- Test composables by mounting a minimal host component and reading state from `wrapper.vm`.
- Wrap components with `async setup()` in a `<Suspense>` host before mounting.
- For `<Teleport>`, either stub it (`global.stubs: { teleport: true }`) or create the target element in `beforeEach` and query it with `document.querySelector`. https://test-utils.vuejs.org/guide/advanced/teleport
- Use `RouterLinkStub` when testing around `<router-link>` without installing a router: `global.stubs: { 'router-link': RouterLinkStub }`.

## References

- [Mounting options and config](./references/mounting-options.md): every `mount` / `shallowMount` / `renderToString` option, `global.*`, and the `config` object.
- [Wrapper API](./references/wrapper-api.md): every `VueWrapper` / `DOMWrapper` method with signatures.
- [Migration v1 -> v2](./references/migration-v2.md): full option and method mapping plus 2.5.x changes.
- [Testing recipes](./references/recipes.md): forms, `v-model`, emitted events, router, Vuex/Pinia, Suspense, Teleport, SSR.
