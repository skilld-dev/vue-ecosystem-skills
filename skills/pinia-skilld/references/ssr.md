# SSR

## One pinia per request

Create the pinia on the server per request and pass it explicitly to every `useStore()` call outside `setup()`:

```ts
const pinia = createPinia()
app.use(pinia)
const store = useStore(pinia)
```

Without the explicit instance, `useStore()` falls back to the module-level active pinia, which is shared across requests on the server. That risks leaking state between users; in dev it reports `PINIA_R1004` [dist/pinia.js:37-39,74-78]. https://pinia.vuejs.org/ssr/

## Hydration

- The client reuses the serialized server state from `pinia.state.value` [dist/pinia.js:1045-1048].
- Option stores with custom refs (for example `useLocalStorage`) can define a `hydrate(storeState, initialState)` option to rebuild those values on the client [dist/pinia.d.ts:425-448].
- Since v4.0.3, reactive Set and Map state is replaced on hydration instead of unioned, so items removed on the client stay removed (https://github.com/vuejs/pinia/releases, v4.0.3).

## skipHydrate

In setup stores, wrap state that must not be overwritten by the server value:

```ts
import { skipHydrate } from 'pinia'
import { useLocalStorage } from '@vueuse/core'

export const useMain = defineStore('main', () => {
  const user = useLocalStorage('user', 'bob')
  return { user: skipHydrate(user) }
})
```

`skipHydrate` marks the value; `shouldHydrate(obj)` reports whether a value will hydrate [dist/pinia.js:984-995, dist/pinia.d.ts:599-612]. Apply it only to state properties. https://pinia.vuejs.org/cookbook/composables.html

## Reading state during SSR

State changes made while rendering are captured because `pinia.state` is a single ref. Serialize it into the page, then restore it before the client app mounts:

```ts
// entry-server
const pinia = createPinia()
app.use(pinia)
renderToString(app) // stores fill pinia.state
return { state: pinia.state.value }

// entry-client
pinia.state.value = window.__INITIAL_STATE__
```

https://pinia.vuejs.org/ssr/

## Nuxt

Use the `@pinia/nuxt` module (1.x for pinia 4):

```ts
export default defineNuxtConfig({
  modules: ['@pinia/nuxt'],
})
```

The module creates the per-request pinia and handles hydration. https://pinia.vuejs.org/ssr/nuxt.html

## Common SSR mistakes

- Calling `useStore()` at module top level. The active pinia is not set yet; defer the call into a function.
- Calling `useOtherStore()` after an `await` in an async action. The active pinia may belong to another request. Call it before the `await`.
- Returning non-serializable state (class instances, functions) from setup stores. Use `skipHydrate` or `markRaw` as appropriate.
