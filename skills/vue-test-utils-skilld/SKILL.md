---
name: vue-test-utils-skilld
description: "ALWAYS use when writing code importing \"@vue/test-utils\". Consult for debugging, best practices, or modifying @vue/test-utils, vue/test-utils, vue test-utils, vue test utils, test-utils, test utils."
metadata:
  version: 2.4.6
  generated_at: 2026-04-20
  references_synced_at: 2026-04-20
---

# vuejs/test-utils `@vue/test-utils@2.4.6`
**Tags:** latest: 2.4.6, 2.0.0-alpha.0: 2.0.0-alpha.0, 2.0.0-alpha.1: 2.0.0-alpha.1

**References:** [Docs](./references/docs/_INDEX.md)
## API Changes

This section documents version-specific API changes — prioritize recent major/minor releases.

- BREAKING: `propsData` — v2 renamed to `props` for consistency with component definitions [source](./references/docs/migration/index.md)

- BREAKING: `createLocalVue` — removed in v2, use the `global` mounting option to install plugins, mixins, or directives [source](./references/docs/migration/index.md)

- BREAKING: `mocks` and `stubs` — moved into the `global` mounting option in v2 as they apply to all components [source](./references/docs/migration/index.md)

- BREAKING: `destroy()` — renamed to `unmount()` in v2 to match Vue 3 lifecycle naming [source](./references/docs/migration/index.md)

- BREAKING: `findAll().at()` — removed in v2; `findAll()` now returns a standard array of wrappers [source](./references/docs/migration/index.md)

- BREAKING: `createWrapper()` — removed in v2, use the `new DOMWrapper()` constructor for non-component elements [source](./references/docs/migration/index.md)

- BREAKING: `shallowMount` — v2 no longer renders default slot content for stubbed components by default [source](./references/docs/migration/index.md)

- BREAKING: `find()` — now only supports `querySelector` syntax; use `findComponent()` to locate Vue components [source](./references/docs/migration/index.md)

- BREAKING: `setSelected` and `setChecked` — removed in v2, functionality merged into `setValue()` [source](./references/docs/migration/index.md)

- BREAKING: `attachToDocument` — renamed to `attachTo` in v2 [source](./references/docs/migration/index.md)

- BREAKING: `emittedByOrder` — removed in v2, use `emitted()` instead [source](./references/docs/migration/index.md)

- NEW: `renderToString()` — added in v2.3.0 to support SSR testing [source](./references/releases/v2.3.0.md)

- NEW: `enableAutoUnmount()` / `disableAutoUnmount()` — replaces `enableAutoDestroy` in v2 [source](./references/docs/migration/index.md)

- DEPRECATED: `scopedSlots` — removed in v2 and merged into the `slots` mounting option [source](./references/docs/migration/index.md)

**Also changed:** `setValue()` and `trigger()` return `nextTick` · `slots` scope exposed as `params` in string templates · `is`, `isEmpty`, `isVueInstance`, `name`, `setMethods`, and `contains` removed

## Best Practices

- Always `await` methods that return `nextTick` (`trigger`, `setValue`, `setProps`, `setData`) to ensure DOM updates are processed before running assertions [source](./references/docs/guide/advanced/async-suspense.md)

```ts
// Preferred
await wrapper.find('button').trigger('click')
expect(wrapper.text()).toContain('Count: 1')

// Avoid — assertion runs before DOM update
wrapper.find('button').trigger('click')
expect(wrapper.text()).toContain('Count: 1')
```

- Prefer `get()` and `getComponent()` over `find()` and `findComponent()` when you expect the element to exist — they throw immediately if not found, providing clearer test failures [source](./references/docs/api/index.md)

- Use `flushPromises()` to resolve non-Vue asynchronous operations such as mocked API calls (axios) or external promise-based logic that Vue doesn't track [source](./references/docs/guide/advanced/async-suspense.md)

- Enable `enableAutoUnmount(afterEach)` in your test setup to automatically clean up wrappers after every test, preventing state pollution and memory leaks [source](./references/docs/api/index.md)

```ts
import { enableAutoUnmount } from '@vue/test-utils'
import { afterEach } from 'vitest'

enableAutoUnmount(afterEach)
```

- Wrap components with `async setup()` in a `<Suspense>` component within your test to correctly handle their asynchronous initialization [source](./references/docs/guide/advanced/async-suspense.md)

- Enable `config.global.renderStubDefaultSlot = true` when using `shallow` mounting to ensure content within default slots is rendered for verification [source](./references/docs/guide/advanced/stubs-shallow-mount.md)

- Prefer `mount()` with specific `global.stubs` over `shallow: true` to keep tests more production-like while still isolating specific complex child components [source](./references/docs/guide/advanced/stubs-shallow-mount.md)

- Use `global.provide` to pass data to components using `inject`, ensuring the component tree's dependency injection works as it does in production [source](./references/docs/guide/advanced/reusability-composition.md)

- Test complex composables by mounting a minimal `TestComponent` that calls the composable, allowing you to verify internal state via `wrapper.vm` [source](./references/docs/guide/advanced/reusability-composition.md)

```ts
const TestComponent = defineComponent({
  setup() {
    return { ...useMyComposable() }
  }
})
const wrapper = mount(TestComponent)
expect(wrapper.vm.someValue).toBe(true)
```

- Stub custom directives using the `vName` naming convention (e.g., `vTooltip: true`) in the `global.stubs` mounting option [source](./references/docs/guide/advanced/stubs-shallow-mount.md)
