# Options API usage (map helpers)

Use stores in components without `setup()`. Spread the helpers into `computed` or `methods`.

## mapState: read state and getters

```ts
import { mapState } from 'pinia'
import { useCounterStore } from '../stores/counter'

export default {
  computed: {
    ...mapState(useCounterStore, ['count', 'double']),
    ...mapState(useCounterStore, {
      myCount: 'count',
      triple: (store) => store.count * 3,
    }),
  },
}
```

Object values may be a key name or a function receiving the store. Functions needing `this` must be method shorthand; `this` is untyped there. `mapState` results are read-only. https://pinia.vuejs.org/cookbook/options-api.html

## mapWritableState: writable state

```ts
import { mapWritableState } from 'pinia'

export default {
  computed: {
    ...mapWritableState(useCounterStore, ['count']),
    ...mapWritableState(useCounterStore, { myCount: 'count' }),
  },
}
```

Read-only getters error on write; include only state keys. Writable computed getters from setup stores are writable here too [dist/pinia.d.ts:852]. You do not need this for mutating arrays in place; `mapState` values still expose array methods.

## mapActions

```ts
import { mapActions } from 'pinia'

export default {
  methods: {
    ...mapActions(useCounterStore, ['increment']),
    ...mapActions(useCounterStore, { more: 'increment' }),
  },
}
```

Arguments pass through to the action.

## mapStores: whole stores

```ts
import { mapStores } from 'pinia'
import { useUserStore } from '../stores/user'
import { useCartStore } from '../stores/cart'

export default {
  computed: {
    ...mapStores(useUserStore, useCartStore),
  },
  created() {
    this.userStore // id "user"
    this.cartStore // id "cart"
  },
}
```

Pass stores as separate arguments. Passing an array reports `PINIA_R1001` in dev because it fails in production [dist/pinia.js:1373-1377].

The suffix defaults to `Store`: `useUserStore` becomes `this.userStore`. Change it globally before use:

```ts
setMapStoreSuffix('')
```

With TypeScript, declare the suffix once:

```ts
declare module 'pinia' {
  export interface MapStoresCustomization {
    suffix: 'Store'
  }
}
```

[dist/pinia.d.ts:662-685]. `mapGetters` is a deprecated alias of `mapState`; use `mapState` [dist/pinia.d.ts:787-790].
