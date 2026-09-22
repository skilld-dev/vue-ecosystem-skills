# Testing

## Unit testing a store

Create a fresh pinia per test and make it active:

```ts
import { setActivePinia, createPinia } from 'pinia'
import { useCounterStore } from '../src/stores/counter'

beforeEach(() => {
  setActivePinia(createPinia())
})

it('increments', () => {
  const counter = useCounterStore()
  counter.increment()
  expect(counter.n).toBe(1)
})
```

`setActivePinia` sets the instance that bare `useStore()` calls resolve to [dist/pinia.js:70].

Plugins only run after the pinia is installed in an app. Use a fake app:

```ts
const app = createApp({})
beforeEach(() => {
  const pinia = createPinia().use(somePlugin)
  app.use(pinia)
  setActivePinia(pinia)
})
```

Dispose instances between complex tests with `disposePinia(pinia)` [dist/pinia.d.ts:589-595].

## Component tests: @pinia/testing 2.x

`createTestingPinia()` stubs every action as a spy by default:

```ts
import { mount } from '@vue/test-utils'
import { createTestingPinia } from '@pinia/testing'
import { useSomeStore } from '@/stores/myStore'

const wrapper = mount(Component, {
  global: { plugins: [createTestingPinia()] },
})

const store = useSomeStore()
store.someAction()
expect(store.someAction).toHaveBeenCalledTimes(1)
```

Options:
- `stubActions: false` runs the real implementations, still spied.
- `stubActions: ['increment', 'reset']` stubs only named actions; an empty array stubs none; a function `(name, store) => boolean` decides per action.
- `initialState: { counter: { n: 20 } }` patches state at store creation.
- `createSpy: vi.fn` when vitest `globals: true` is off, or for other frameworks.

Pass store plugins through the `plugins` option. Do not call `testingPinia.use()`; plugins added that way are not applied.

Getters stay live computed in tests. `store.double = 3` forces a value; set it back to `undefined` to restore computation.

Install: `npm i -D @pinia/testing`. Use 2.x with pinia 4 (https://github.com/vuejs/pinia/releases).

## How the testing bypass works

A testing pinia sets `_testing` on the instance. In `NODE_ENV === "test"`, `useStore()` ignores its pinia argument and uses the active testing pinia instead [dist/pinia.js:534-535,1307]. This is why `setActivePinia(createTestingPinia())` redirects bare `useStore()` calls in tests.

https://pinia.vuejs.org/cookbook/testing.html
