# Plugins

A plugin is a function passed to `pinia.use()`. It can add properties, state, and options, wrap methods, and intercept actions [dist/pinia.d.ts:573-581].

```ts
interface PiniaPlugin {
  (context: PiniaPluginContext): Partial<PiniaCustomProperties & PiniaCustomStateProperties> | void
}
```

Context fields [dist/pinia.d.ts:552-569]: `pinia`, `app`, `store`, `options` (the options passed to `defineStore`, with `actions` always materialized [dist/pinia.d.ts:465-472]).

## Basics

```ts
function secretPlugin() {
  return { secret: 'the cake is a lie' }
}
pinia.use(secretPlugin)
```

- Return an object so devtools tracks the new properties automatically. Setting props on `store` works, but then add keys to `store._customProperties` in dev mode for devtools.
- Plugins apply only to stores created after the plugin is added and after the pinia is installed in an app [dist/pinia.js:836-839].
- Stores are `reactive()`, so returned refs unwrap automatically.

## Adding state

State must live in `store.$state` for SSR serialization and devtools, and on `store` for access. Set both, sharing one ref:

```ts
import { ref, toRef } from 'vue'

pinia.use(({ store }) => {
  if (!(('hasError') in store.$state)) {
    store.$state.hasError = ref(false)
  }
  store.hasError = toRef(store.$state, 'hasError')
})
```

Do not return the value; it would appear twice in devtools. `$reset()` does not reset plugin state unless you override `$reset` in the returned object. https://pinia.vuejs.org/core-concepts/plugins.html

## External, non-reactive values

Wrap routers, class instances, and library objects with `markRaw()` before assigning:

```ts
import { markRaw } from 'vue'
pinia.use(({ store }) => {
  store.router = markRaw(router)
})
```

A returned plain non-reactive object reports `PINIA_R1006` in dev [dist/pinia.js:1285-1291].

## Custom store options

```ts
defineStore('search', { actions: { ... }, debounce: { searchContacts: 300 } })
defineStore('search', () => { ... }, { debounce: { searchContacts: 300 } })

pinia.use(({ options, store }) => {
  if (options.debounce) {
    return Object.keys(options.debounce).reduce((acc, name) => {
      acc[name] = debounce(store[name], options.debounce[name])
      return acc
    }, {} as Record<string, unknown>)
  }
})
```

## TypeScript: module augmentation

New store properties:

```ts
declare module 'pinia' {
  export interface PiniaCustomProperties {
    router: Router
  }
}
```

New state properties:

```ts
declare module 'pinia' {
  export interface PiniaCustomStateProperties<S> {
    hasError: boolean
  }
}
```

New options, keyed by the store's actions:

```ts
declare module 'pinia' {
  export interface DefineStoreOptionsBase<S, Store> {
    debounce?: Partial<Record<keyof StoreActions<Store>, number>>
  }
}
```

When using the generics, name them exactly as in the source: `Id`, `S`, `G`, `A`, `SS` [dist/pinia.d.ts:349-353,401].

## Nuxt

Register plugins on the nuxt pinia instance:

```ts
export default defineNuxtPlugin(({ $pinia }) => {
  $pinia.use(MyPiniaPlugin)
})
```

https://pinia.vuejs.org/core-concepts/plugins.html
