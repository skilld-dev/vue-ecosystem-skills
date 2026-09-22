# Testing recipes

Common tasks with the smallest working code. All APIs verified against `@vue/test-utils` 2.5.1.

## Events and user interaction

```ts
const wrapper = mount(Component)

await wrapper.find('button').trigger('click')
await wrapper.find('input').trigger('keydown.enter', { key: 'Enter' })

expect(wrapper.emitted('submit')).toHaveLength(1)
expect(wrapper.emitted('submit')![0]).toEqual([{ name: 'foo' }])
```

Key and modifier events: `keydown.ctrl.enter` sets `ctrlKey` and `code` (`dist/src/constants/dom-events.d.ts:46-47`).

## Forms and v-model

`setValue` covers text inputs, textareas, checkboxes, radios, selects, and multiselects.

```ts
await wrapper.find('input[type="text"]').setValue('hello')
await wrapper.find('input[type="checkbox"]').setValue(true)
await wrapper.find('select').setValue('option-value')
await wrapper.find('select[multiple]').setValue(['a', 'b'])
```

Component-level `v-model` (props in, `update:modelValue` out):

```ts
const wrapper = mount(CustomInput, {
  props: { modelValue: 'initial' }
})

await wrapper.find('input').setValue('new')
expect(wrapper.emitted('update:modelValue')![0]).toEqual(['new'])

await wrapper.setProps({ modelValue: 'other' })
```

## Slots

```ts
mount(Card, {
  slots: {
    default: '<div>card body</div>',
    header: ({ title }) => h('h2', title),   // scoped slot as function
    footer: MyFooterComponent
  }
})
```

Scoped slot props are exposed as `params` inside string templates: `'{{ params.item.name }}'`.

## Props, data, provide

```ts
mount(UserList, {
  props: { userIds: [1, 2] },
  data: () => ({ loading: false }),
  global: {
    provide: { [userKey as symbol]: fakeUser },
    mocks: { $t: (k: string) => k }
  }
})
```

## Composables

Mount a minimal host and read results from `wrapper.vm`.

```ts
const useCounter = () => {
  const count = ref(0)
  const inc = () => count.value++
  return { count, inc }
}

const Host = defineComponent({
  setup() {
    return { ...useCounter() }
  },
  template: '<button @click="inc">{{ count }}</button>'
})

const wrapper = mount(Host)
await wrapper.find('button').trigger('click')
expect(wrapper.vm.count).toBe(1)
```

For composables used by multiple components, prefer integration tests through those components.

## Async setup and Suspense

`mount` throws if the component's `setup()` is `async`. Wrap in Suspense.

```ts
const Host = defineComponent({
  components: { AsyncComp },
  template: '<Suspense><AsyncComp /></Suspense>'
})

const wrapper = mount(Host)
await flushPromises()
```

Read the async component's state through `wrapper.findComponent(AsyncComp).vm`; the host wrapper's own `vm` is empty. https://test-utils.vuejs.org/guide/advanced/async-suspense

## Router

Two approaches; pick one per test.

Stub the link, mock the injected globals:

```ts
mount(NavBar, {
  global: {
    stubs: { 'router-link': RouterLinkStub },
    mocks: { $route: { path: '/' } }
  }
})
```

Or install a real router:

```ts
const router = createRouter({
  history: createMemoryHistory(),
  routes: [{ path: '/', component: Home }]
})
mount(App, { global: { plugins: [router] } })
await router.isReady()
```

## Vuex / Pinia

Vuex is a plugin; state flows through `global.plugins`.

```ts
const store = createStore({ state: () => ({ count: 1 }), mutations, getters })
mount(App, { global: { plugins: [store] } })
```

For Pinia, `global: { plugins: [createTestingPinia()] }` from `@pinia/testing`.

## Teleport

```ts
// Option 1: stub it
mount(NavBar, { global: { stubs: { teleport: true } } })

// Option 2: provide a target and query the document
beforeEach(() => {
  const el = document.createElement('div')
  el.id = 'modal'
  document.body.appendChild(el)
})

const wrapper = mount(NavBar, { attachTo: document.body })
expect(document.querySelector('#modal .signup')).toBeTruthy()
wrapper.unmount()
```

`attachTo` cases must call `unmount()` (or rely on `enableAutoUnmount`) to detach.

## SSR

```ts
import { renderToString } from '@vue/test-utils'

const html = await renderToString(App, { props: { id: 1 } })
expect(html).toContain('<div>')
```

Requires the optional `@vue/server-renderer` peer dependency (`package.json:73-81`).

## Element visibility and focus

`isVisible()` needs no attachment for `v-show` and CSS `display: none`, but layout-driven visibility and `document.activeElement` assertions need `attachTo`:

```ts
const div = document.createElement('div')
document.body.appendChild(div)

const wrapper = mount(Menu, { attachTo: div })
expect(wrapper.find('input').element).toBe(document.activeElement)

wrapper.unmount() // also removes the attached tree
```
