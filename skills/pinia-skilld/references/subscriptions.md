# Subscriptions: $subscribe and $onAction

## Watch state: `$subscribe`

```ts
const unsubscribe = store.$subscribe((mutation, state) => {
  mutation.type    // 'direct' | 'patch object' | 'patch function'
  mutation.storeId // store id
  localStorage.setItem('cart', JSON.stringify(state))
})
```

- Fires once per `$patch` call, regardless of how many keys changed. A plain `watch()` on the state fires per change.
- `mutation.payload` exists only for the object form of `$patch` [dist/pinia.d.ts:75-82].
- `mutation.events` is dev-only debugger data [dist/pinia.d.ts:56-60].

Options (second argument) [dist/pinia.d.ts:240-242]:
- `{ detached: true }` keeps the subscription after the component unmounts. Without it, subscriptions added in `setup()` are disposed with the component's scope [dist/pinia.js:938-945].
- `watch` options pass through, including `flush`. With the default flush, a subscription runs once per `$patch`; `flush: 'sync'` runs it for every state change inside the patch too [dist/pinia.js:1051-1077,1161-1167].

Registering the same callback twice is a no-op the second time and reports `PINIA_R1007` in dev [dist/pinia.js:1155-1159]. Remove a subscription with the returned function before resubscribing.

## Intercept actions: `$onAction`

```ts
const remove = store.$onAction(({ name, store, args, after, onError }) => {
  const start = Date.now()
  after((result) => {
    console.log(`${name} finished in ${Date.now() - start}ms`)
  })
  onError((error) => {
    console.warn(`${name} failed`, error)
  })
})
```

- Runs before every action call [dist/pinia.d.ts:244-279].
- `after` receives the action return value; a returned Promise is unwrapped to its resolved value [dist/pinia.d.ts:114-137].
- `onError` fires when the action throws or its returned Promise rejects. A callback passed to `onError` may return `false` to catch the error and stop it from propagating [dist/pinia.d.ts:131-136].
- Pass `true` as the second argument to keep the listener after component unmount [dist/pinia.js:938-945].

## MutationType

`MutationType.direct`, `MutationType.patchObject`, `MutationType.patchFunction` [dist/pinia.d.ts:21-42]. Import the enum when switching on `mutation.type`.

## Watch everything

For the whole app state, watch the pinia instance instead of each store:

```ts
watch(
  pinia.state,
  (state) => { localStorage.setItem('piniaState', JSON.stringify(state)) },
  { deep: true },
)
```

https://pinia.vuejs.org/core-concepts/state.html#subscribing-to-the-state

## Plugin subscriptions

Plugins may call `store.$subscribe` and `store.$onAction` to add behavior like persistence [dist/pinia.js:938-945]. Prefer `detached: true` there so the watcher is not bound to a component scope.
