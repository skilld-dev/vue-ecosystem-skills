# Patterns and recipes

Working examples for common `@tanstack/vue-store` tasks in Vue 3 `<script setup>`. Store creation APIs come from the core re-export (`src/index.ts:1`).

## Shared store in a plain module

The documented sharing pattern: instantiate outside components, import anywhere ([Vue quick start](https://tanstack.com/store/latest/docs/framework/vue/quick-start)).

```ts
// store.ts
import { createStore } from '@tanstack/vue-store'

export const store = createStore({ dogs: 0, cats: 0 })

export function updateState(animal: 'dogs' | 'cats') {
  store.setState((state) => ({ ...state, [animal]: state[animal] + 1 }))
}
```

```vue
<!-- Display.vue -->
<script setup>
import { useSelector } from '@tanstack/vue-store'
import { store } from './store'

const props = defineProps({ animal: String })
const count = useSelector(store, (state) => state[props.animal])
</script>

<!-- Re-renders only when state[props.animal] changes -->
<template>
  <div>{{ animal }}: {{ count }}</div>
</template>
```

## Read and write one atom

```vue
<script setup>
import { createAtom, useAtom } from '@tanstack/vue-store'

const countAtom = createAtom(0) // module scope in real code
const [count, setCount] = useAtom(countAtom)
</script>

<template>
  <button @click="setCount((prev) => prev + 1)">{{ count }}</button>
</template>
```

## Actions factory with `_useStore`

```ts
import { createStore } from '@tanstack/vue-store'

export const petStore = createStore({ cats: 0 }, ({ setState }) => ({
  addCat: () => setState((s) => ({ ...s, cats: s.cats + 1 })),
  reset: () => setState({ cats: 0 }),
}))
```

```vue
<script setup>
import { _useStore } from '@tanstack/vue-store'
import { petStore } from './store'

const [cats, { addCat, reset }] = _useStore(petStore, (s) => s.cats)
</script>
```

## Derived state

```ts
import { createStore, useSelector } from '@tanstack/vue-store'

const counter = createStore(0)
const doubled = createStore(() => counter.state * 2)          // ReadonlyStore
const history = createStore<Array<number>>([], (prev = []) => [...prev, counter.state]) // prev accumulates

// In a component
const d = useSelector(doubled)
```

## Async data with createAsyncAtom

```vue
<script setup>
import { createAsyncAtom, useSelector } from '@tanstack/vue-store'

const userAtom = createAsyncAtom(() => fetchUser()) // module scope in real code
const user = useSelector(userAtom)
</script>

<template>
  <p v-if="user.status === 'pending'">Loading…</p>
  <p v-else-if="user.status === 'error'">{{ user.error }}</p>
  <UserProfile v-else-if="user.status === 'done'" :user="user.data" />
</template>
```

## Batched updates

```ts
import { batch } from '@tanstack/vue-store'

batch(() => {
  counter.setState((n) => n + 1)
  otherStore.setState((s) => ({ ...s, updated: true }))
})
// Subscribers notified once, with final state
```

## Subscribing outside components

```ts
import { createStore } from '@tanstack/vue-store'

const store = createStore({ count: 0 })
const { unsubscribe } = store.subscribe((state) => console.log(state.count))
```

## Choosing a compare function

| Selector returns | Compare to pass |
|---|---|
| Primitive, or a stable reference from state | none; default `===` is correct |
| Fresh object or array | `{ compare: shallow }` |
| `Date` | `shallow` compares timestamps; write a custom compare for other semantics |
| Deeply nested new objects | custom recursive compare, or select a narrower slice |

```ts
import { shallow, useSelector } from '@tanstack/vue-store'

const bad = useSelector(store, (s) => ({ a: s.a, b: s.b }))                    // updates every notification
const good = useSelector(store, (s) => ({ a: s.a, b: s.b }), { compare: shallow })
```
