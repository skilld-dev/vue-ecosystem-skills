# Stores: state, getters, actions

## Option stores

```ts
export const useStore = defineStore('storeId', {
  state: () => ({ count: 0, items: [] as Item[] }),
  getters: { double: (state) => state.count * 2 },
  actions: {
    increment() {
      this.count++
    },
  },
})
```

- `state` must be an arrow function returning a fresh plain object. Class instances trigger `PINIA_R1003` [dist/pinia.js:1294].
- Declare every state key in `state()`, even `undefined` initial values. Keys added later do not become reactive. https://pinia.vuejs.org/core-concepts/state.html
- For empty lists or unloaded data, cast: `items: [] as Item[]`, `user: null as User | null`.
- Option stores support `$reset()` [dist/pinia.js:1079-1084].

## Setup stores

```ts
export const useStore = defineStore('storeId', ({ action }) => {
  const count = ref(0)
  const items = ref<Item[]>([])
  const double = computed(() => count.value * 2)
  function increment() { count.value++ }
  return { count, items, double, increment }
})
```

- Refs and reactives become state, computeds become getters, functions become actions [dist/pinia.js:1178-1202].
- Return all state. Hidden state breaks SSR, devtools, and plugins.
- `$reset()` throws on setup stores in dev [dist/pinia.js:1085-1087]. Return your own `$reset`:
  ```ts
  const count = ref(0)
  function $reset() { count.value = 0 }
  return { count, $reset }
  ```
- The `{ action }` helper parameter tracks internal helper functions with `$onAction` [dist/pinia.d.ts:628-638]. Rarely needed.
- Custom options for plugins go in the third argument:
  ```ts
  defineStore('search', () => { ... }, { debounce: { searchContacts: 300 } })
  ```

## Getters

- Prefer arrow functions receiving `state`; return types are inferred.
- To use other getters or `this`, write a method and annotate the return type explicitly:
  ```ts
  getters: {
    double: (state) => state.count * 2,
    doublePlusOne(): number {
      return this.double + 1
    },
  }
  ```
- A getter name colliding with a state name triggers `PINIA_R1002` [dist/pinia.js:1010-1013].
- Writable computed returned from a setup store stays writable on the store, in `storeToRefs()`, and in `mapWritableState` [dist/pinia.d.ts:313,852].

## Actions

- Actions can be async. `this` is the store instance.
- Like composables, they can use any Vue or third-party composable.
- Errors propagate to the caller; `$onAction` listeners observe them via `onError`.

## Mutating state

```ts
store.count++
store.$patch({ count: 1, name: 'x' })
store.$patch((state) => {
  state.items.push({ name: 'shoes', quantity: 1 })
})
```

- `$patch` groups changes into one devtools entry.
- The function form must be synchronous [dist/pinia.d.ts:219-225]. Use it for arrays, Maps, and Sets; the object form merges them recursively [dist/pinia.js:964-975].
- `store.$state = newObj` does not replace state; it patches [dist/pinia.js:1207-1216].
- You cannot replace the whole `pinia.state.value[store.$id]` and keep reactivity; patch instead. https://pinia.vuejs.org/core-concepts/state.html

## Composing stores

Call other stores inside actions or setup:

```ts
const useUserStore = defineStore('user', () => { ... })

export const useCartStore = defineStore('cart', () => {
  const user = useUserStore()
  // ...
})
```

In async actions that reference another store, call `useOtherStore()` before any `await`. After an `await` the active pinia can differ on the server, returning the wrong instance. https://pinia.vuejs.org/cookbook/composing-stores.html

## Hot module replacement

```ts
const useUser = defineStore('user', () => { ... })

if (import.meta.hot) {
  import.meta.hot.accept(acceptHMRUpdate(useUser, import.meta.hot))
}
```

[dist/pinia.d.ts:920-935]. Works in Vite-like environments; production builds no-op it [dist/pinia.js:908-909]. Changing the store id during HMR reports `PINIA_R1005` and reloads the module [dist/pinia.js:917-924]. https://pinia.vuejs.org/cookbook/hot-module-replacement.html
