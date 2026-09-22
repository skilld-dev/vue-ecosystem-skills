# API surface

Every public export of pinia 4.0.3 [dist/pinia.js:1491, dist/pinia.d.ts:955]. Types are exported alongside the runtime values.

## Instances

```ts
createPinia(): Pinia
disposePinia(pinia: Pinia): void
setActivePinia(pinia: Pinia | undefined): Pinia | undefined
getActivePinia(): Pinia | undefined
```

- `createPinia()` builds the root instance: app installer, `state` ref, plugin list, store registry [dist/pinia.d.ts:494-536].
- `disposePinia()` stops the effect scope and removes state, plugins, and stores. The instance cannot be reused [dist/pinia.d.ts:589-595, dist/pinia.js:857-863]. Use it in tests or multi-pinia apps.
- `getActivePinia()` injects the app-provided pinia when an injection context exists, else returns the module-level active pinia [dist/pinia.js:74-78].
- `piniaSymbol` is the injection key, exported for testing and hosts like Storybook. Internal, may break in a minor [dist/pinia.d.ts:537-548].

The `Pinia` interface: `install`, `state: Ref<Record<string, StateTree>>`, `use(plugin)`, plus internal `_p`, `_a`, `_e`, `_s` [dist/pinia.d.ts:494-536].

## Defining stores

```ts
defineStore(id, options)        // option store
defineStore(id, storeSetup, options?)  // setup store, setup receives { action }
```

Overloads at [dist/pinia.d.ts:645,653]. Returns `StoreDefinition` for option stores, `SetupStoreDefinition` for setup stores [dist/pinia.d.ts:327-345,660]. Both carry `$id` and act as `useStore(pinia?, hot?)` functions.

## Store instance members

Added by Pinia to every store [dist/pinia.d.ts:207-289]:

| Member | Purpose |
| --- | --- |
| `$id` | store id string |
| `$state` | reactive state; setter runs `$patch` [dist/pinia.js:1207-1216] |
| `$patch(obj \| fn)` | grouped mutation; fn must be synchronous [dist/pinia.d.ts:217-225] |
| `$reset()` | option stores only; setup stores throw in dev [dist/pinia.js:1085-1087] |
| `$subscribe(cb, opts?)` | state subscription [dist/pinia.d.ts:240-242] |
| `$onAction(cb, detached?)` | action listener [dist/pinia.d.ts:279] |
| `$dispose()` | stop the store scope, remove from registry; state stays in `pinia.state.value` until deleted by hand [dist/pinia.d.ts:280-289] |

## Hydration controls

```ts
skipHydrate<T>(obj: T): T
shouldHydrate(obj: any): boolean
```

`skipHydrate` marks an object so SSR hydration skips it [dist/pinia.js:984-986]. `shouldHydrate` reports the marker; it respects the marker on non-plain objects too since v4.0.0 [dist/pinia.js:993-995]. See [ssr](./ssr.md).

## Map helpers (Options API)

```ts
mapStores(...stores)
mapState(useStore, keys | keyMapper)
mapWritableState(useStore, keys | keyMapper)
mapActions(useStore, keys | keyMapper)
setMapStoreSuffix(suffix)
```

[dist/pinia.d.ts:685-884]. `mapGetters` is a deprecated alias of `mapState` [dist/pinia.d.ts:787-790]. Details in [options-api](./options-api.md).

## Refs and HMR

```ts
storeToRefs(store): StoreToRefs<SS>
acceptHMRUpdate(initialUseStore, hot): (newModule) => any
```

- `storeToRefs` [dist/pinia.d.ts:909-918, dist/pinia.js:1475-1489].
- `acceptHMRUpdate` returns a no-op in production builds [dist/pinia.js:908-909]. If a hot module changes the store id, it reports `PINIA_R1005` and calls `hot.invalidate()` [dist/pinia.js:917-924].

## Setup store helpers

`SetupStoreHelpers` exposes `action(fn, name?)` [dist/pinia.d.ts:628-638]. It wraps a function so `$onAction` sees it when the store calls it internally [dist/pinia.js:1099-1142]. Advanced use only.

## Key public types

From [dist/pinia.d.ts]:
- `Store<Id, S, G, A>` [317], `StoreGeneric` [323], `StoreDefinition` [327], `SetupStoreDefinition` [660]
- `StateTree` [11], `MutationType` enum [21-42]
- `SubscriptionCallback` / `SubscriptionCallbackMutation*` [67-108]
- `StoreOnActionListener` / `StoreOnActionListenerContext` [114-146]
- `Pinia`, `PiniaPlugin`, `PiniaPluginContext` [494-581]
- `PiniaCustomProperties` [349], `PiniaCustomStateProperties` [353], `DefineStoreOptionsBase` [401], `DefineStoreOptions` [406], `DefineSetupStoreOptions` [454], `DefineStoreOptionsInPlugin` [465]
- Extractors for plugin typing: `StoreState<SS>` [627], `StoreGetters<SS>` [622], `StoreActions<SS>` [617], `StoreToRefs<SS>` [909], `MapStoresCustomization` [669]

The `Pinia` instance is exposed on components as `$pinia` via `ComponentCustomProperties` [dist/pinia.d.ts:938-952].

Official API reference: https://pinia.vuejs.org/core-concepts/
