# Diagnostics (dev only)

Pinia 4 reports problems through Nostics diagnostics with codes `PINIA_R1001` to `PINIA_R1007` [dist/pinia.js:18-56]. They are dev-only: production builds drop the calls. Each message states why it fired and a fix; this file maps codes to action.

| Code | Trigger | Fix |
| --- | --- | --- |
| `PINIA_R1001` | `mapStores([useAuthStore, useCartStore])` array form | Pass stores as arguments: `mapStores(useAuthStore, useCartStore)`. The array form fails in production. |
| `PINIA_R1002` | A getter shares a name with a state property in the same store | Rename the getter or the state property. |
| `PINIA_R1003` | `state()` returned a class instance or other non-plain object | Return a plain object literal from `state()`. |
| `PINIA_R1004` | No pinia found in context; fell back to the global active pinia on the server | Call `useStore()` at the top of `setup()`, or pass the pinia instance explicitly outside components. Critical for SSR: the fallback leaks state across requests. |
| `PINIA_R1005` | HMR changed the store id | Keep the id stable across edits, or let the module reload as offered. |
| `PINIA_R1006` | A store property is not reactive, so `storeToRefs()` ignores it | Wrap intended state with `ref()`, `reactive()`, or `shallowRef()`. Wrap intentional non-reactive values with `markRaw()`. |
| `PINIA_R1007` | The same `$subscribe` callback registered twice | Subscriptions deduplicate by callback identity. Remove the old one with its returned function, or pass a new function. |

Each code links a docs page in its console output [dist/pinia.js:20-55].

## Related runtime errors that are not diagnostics

- `"getActivePinia()" was called but there was no active Pinia` — a store was used before `app.use(pinia)` in dev. Install the pinia first or pass the instance [dist/pinia.js:1309].
- `Store "x" is built using the setup syntax and does not implement $reset()` — setup stores have no generated `$reset`. Return your own [dist/pinia.js:1085-1087].
- `Pinia destroyed` — a store was created on a disposed pinia [dist/pinia.js:1029]. Recreate the pinia or stop disposing it.

Release context for the Nostics refactor: https://github.com/vuejs/pinia/releases/tag/v4.0.0
