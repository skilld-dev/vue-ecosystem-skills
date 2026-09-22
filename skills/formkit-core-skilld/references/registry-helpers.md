# Registry and id-based helpers

## Registry

Only root nodes, or nodes with an explicit `props.alias`, are registered —
`register()` is idempotent otherwise (`dist/index.d.mts:2220-2228`).

| Export | Purpose |
| --- | --- |
| `register(node)` / `deregister(node)` | add/remove from the registry |
| `getNode<T>(id): FormKitNode<T> \| undefined` | lookup by id (`dist/index.d.mts:2246`) |
| `watchRegistry(id, callback): string` | fire when the id registers/unregisters; returns a receipt (`dist/index.d.mts:2254-2261`) |
| `stopWatch(receipt)` | remove a registry watcher (`dist/index.d.mts:2263-2266`) |
| `resetRegistry()` | deregister everything, drop watchers (`dist/index.d.mts:2248-2252`) |

Registration events are emitted on the registry's own emitter
(`dist/index.mjs:460-481`); `watchRegistry` is how you catch nodes created
later (SSR, lazy mounts). v2.1.2 fixed registry cleanup for parentless nodes
(GitHub release v2.1.2, **core**: "Remove parentless nodes").

Test hygiene: call `resetRegistry()` (and `resetCount()` for deterministic
names) between test cases.

## setErrors / clearErrors

Module-level helpers operate by node id:

```ts
setErrors('myForm', 'Wrong', { email: ['Taken'] })  // local + child errors
clearErrors('myForm', true)                         // clear children too
```

`ErrorMessages = string | string[] | Record<string, string | string[]>`
(`dist/index.d.mts:177`). Child errors route through `store.apply()` child
addressing, buffering until the target child exists. Node-level equivalents:
`node.setErrors(local, child?)`, `node.clearErrors(clearChildren?, sourceKey?)`
(`dist/index.d.mts:1855,1760`).

## reset

```ts
reset('myForm')               // back to props.initial
reset('myForm', { email: '' }) // explicit value becomes the new initial
reset(nodeOrId, resetTo?)
```

`reset()` accepts an id or a node (`dist/index.d.mts:2300-2311`). It pauses
the node's event emitter while restoring (`dist/index.mjs:580`), deep-applies
object reset values to children by address (`dist/index.mjs:583-594`), clears
`error` / `incomplete` ui messages, and recomputes `failing` state
(`dist/index.mjs:541-560`). v2.1.0 fixed: explicit reset values now apply to
all node types, buffered reset events survive, reset input hooks do not
double-fire, and reset preserves invalid state
(GitHub release v2.1.0, **core** fixes).

## submitForm

```ts
submitForm('myForm')            // document context
submitForm('myForm', shadowRoot) // custom root
```

Looks up `#myForm`; if it is an `HTMLFormElement`, dispatches a cancelable,
bubbling submit `Event`; otherwise warns code 151
(`dist/index.mjs:532-540`). It triggers the DOM event — the framework
adapter's submit handler does the rest.

## Errors, warnings, codes

```ts
import { error, warn, errorHandler, warningHandler } from '@formkit/core'
```

- `warn(code, data?)` dispatches through `warningHandler`; default middleware
  logs via `console.warn` (`dist/index.mjs:137-147`).
- `error(code, data?)` throws (`dist/index.mjs:148-150`) — its return type is
  `never`.
- Both handlers are `FormKitDispatcher<FormKitHandlerPayload>`; register
  middleware to customize reporting (`dist/index.d.mts:2141-2175`).

Documented core codes seen in source: 103/104 (compiler syntax,
`dist/index.mjs:1714-1719`), 107 (group value not an object,
`dist/index.mjs:751`), 108 (list value not an array,
`dist/index.mjs:754`), 151 (submitForm target missing,
`dist/index.mjs:539`).

## Class utilities

`createClasses(propertyKey, node, sectionClassList?)` normalizes a section's
class input (string, record, or `FormKitClasses` function) to
`Record<string, boolean>`; `generateClassList(node, property, ...lists)`
combines lists into a string or `null` (`dist/index.d.mts:445-471`). These
power the `classes` config/prop pipeline consumed by styling layers.
