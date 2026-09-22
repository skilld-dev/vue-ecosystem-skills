# Wrapper API

`mount` returns a `VueWrapper`; `find` / `findAll` return `DOMWrapper`s. Both extend `BaseWrapper`, so element queries and DOM assertions are shared (`dist/src/baseWrapper.d.ts:9`). Official reference: https://test-utils.vuejs.org/api/

## VueWrapper (dist/src/vueWrapper.d.ts:5-32)

| Member | Signature | Notes |
|---|---|---|
| `vm` | `get vm(): VM` | Component public instance. Options-API state, `setup()` returns, and `defineExpose()` bindings (2.5.0, PR #2927) |
| `element` | `get element(): VM['$el']` | Root DOM node |
| `props` | `props(): VM['$props']`, `props(key)` | Props passed to the component |
| `emitted` | `emitted(): Record<string, unknown[][]>`, `emitted(name)` | Event history. `{ submit: [[payload]] }`. Child history clears on unmount (2.5.0, PR #2898) |
| `setProps` | `setProps(props: Partial<VM['$props']>): Promise<void>` | Update props; await it |
| `setData` | `setData(data): Promise<void>` | Update `data()` / reactive state; works for components mixing `setup()` and `data()` (2.4.11, PR #2846) |
| `setValue` | `setValue(value, prop?) | Promise<void>` | Sets a prop-driven `v-model` from the wrapper level |
| `unmount` | `unmount(): void` | Unmount and detach. Replaces v1 `destroy()` |
| `getCurrentComponent` | `getCurrentComponent(): ComponentInternalInstance` | Internal instance of the mounted component |

## DOMWrapper (dist/src/domWrapper.d.ts:4-20)

| Member | Notes |
|---|---|
| `setValue(value?)` | Sets element value and triggers `input` / `change`. Handles text inputs, textareas, checkboxes and radios via `checked`, selects via `selected`; arrays select multiple options in a `multiple` select (2.2.0, PR #1825). Returns `nextTick` |
| `element` | The wrapped DOM node |

Construct one directly for elements outside the mounted tree: `new DOMWrapper(document.body)` (`dist/src/domWrapper.d.ts:6`).

## Shared queries (dist/src/baseWrapper.d.ts:15-63)

| Method | Returns | Throws on miss |
|---|---|---|
| `find(selector)` | `DOMWrapper` | No; error wrapper, `exists() === false` |
| `findAll(selector)` | `DOMWrapper[]` | No; empty array |
| `findComponent(selector)` | `VueWrapper` or `DOMWrapper` for functional components | No |
| `findAllComponents(selector)` | Array | No |
| `get(selector)` | `DOMWrapper` | Yes |
| `getComponent(selector)` | `VueWrapper` | Yes |

Component selectors: the imported component, `{ name: 'Foo' }`, `{ ref: 'foo' }` (direct children only), or a CSS selector that matches the component's root element. `ref` selectors are not supported in `findAllComponents` (https://test-utils.vuejs.org/migration/).

## Shared assertions and actions

| Member | Signature | Notes |
|---|---|---|
| `text` | `text(): string` | Text content, whitespace trimmed between elements |
| `html` | `html(options?: { raw?: boolean }): string` | Formatted by default via js-beautify; `raw: true` returns the unformatted string (2.2.0, PR #1827) (`dist/src/baseWrapper.d.ts:42-44`) |
| `classes` | `classes(): string[]`, `classes(name): boolean` | |
| `attributes` | `attributes(): Record<string, string>`, `attributes(key): string \| undefined` | |
| `exists` | `exists(): boolean` | |
| `isVisible` | `isVisible(): boolean` | False when the element or an ancestor is hidden via `display: none`, or `v-show` is false |
| `trigger` | `trigger(eventString, options?): Promise<void>` | Event names may carry modifiers: `click.left`, `keydown.enter`, `keyup.ctrl.enter`. Options set event properties (`code`, `key`, `keyCode`, custom). `keydown` / `keyup` set a spec-compliant `event.code` (2.4.11, PR #2850). Awaits `nextTick` (`dist/src/baseWrapper.d.ts:67-68`, `dist/src/constants/dom-events.d.ts:46-47`) |

## Utilities

- `flushPromises(): Promise<unknown>` drains the microtask/macrotask queues; use after mocked API calls before asserting (`dist/src/utils/flushPromises.d.ts:1`).
- `enableAutoUnmount(hook)` / `disableAutoUnmount()`: register `enableAutoUnmount(afterEach)` once per suite (`dist/src/utils/autoUnmount.d.ts:3-4`).
- `RouterLinkStub`: minimal `<router-link>` replacement accepting `to` and `custom` props (`dist/src/components/RouterLinkStub.d.ts`).
- `createWrapperError(type)`: constructs the error wrapper a failed `find` returns (`dist/src/errorWrapper.d.ts:1`). Prefer `get()` in tests instead of using this directly.
