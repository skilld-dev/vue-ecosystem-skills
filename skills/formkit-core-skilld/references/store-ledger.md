# Store and ledger

## Messages

Each node owns a `FormKitStore`: a proxied map of `FormKitMessage` objects
keyed by message key (`dist/index.d.mts:118-136`). Messages are immutable
(`Readonly<FormKitMessageProps>`, `dist/index.d.mts:70-75`):

| Prop | Type | Meaning |
| --- | --- | --- |
| `key` | string | unique id; also the property name on the store |
| `type` | string | category, e.g. `validation`, `error`, `ui`, `state` |
| `value` | string/number/boolean | display content |
| `blocking` | boolean | blocks form submission |
| `visible` | boolean | shown to users |
| `meta` | object | arbitrary metadata; `messageKey` and `i18nArgs` steer i18n |

`createMessage(conf?, node?)` fills defaults: `blocking: false`,
`key: token()`, `meta: {}`, `type: 'state'`, `visible: true`
(`dist/index.d.mts:152-171`).

## Store traps

`FormKitStoreTraps` (`dist/index.d.mts:142-150`):

```ts
node.store.set(message)                 // add or replace by key
node.store.remove(key)                  // remove one
node.store.filter((m) => ..., type?)    // remove non-matching of type
node.store.reduce(reducer, initial)     // fold over messages
node.store.apply(messages, clear?)      // bulk, with optional child routing
node.store.release()                    // internal: drop child listeners
node.store.touch()                      // internal
```

Read/write cycle:

```ts
import { createMessage, createNode } from '@formkit/core'

const node = createNode()
node.store.set(createMessage({ key: 'clickHole', value: 'Click 100 times.' }))
node.store.clickHole.value   // 'Click 100 times.'
```

Setting, changing, or removing messages emits `message-added`,
`message-updated`, `message-removed` — all bubble, so `.deep` listeners on an
ancestor see subtree changes.

## apply() and child routing

`apply()` accepts either a flat `FormKitMessage[]` (applied locally) or a
`FormKitInputMessages` map where keys are child addresses
(`dist/index.d.mts:77-85,143`). Messages for children that do not exist yet
are buffered in `_m` and flushed when the matching `child.deep` event fires
(`dist/index.mjs:333-357`). This is how `setErrors` targets nested inputs
before they mount.

## Ledger

The ledger counts messages matching a condition across a subtree
(`dist/index.d.mts:180-192`). It wires `message-added.deep` /
`message-removed.deep` listeners at init (`dist/index.mjs:368-372`) and merges
child counters when children attach.

```ts
// establish a counter (returns a promise resolving after the initial count)
await node.ledger.count('visible', (m) => m.visible)

node.ledger.value('visible')     // current count
await node.ledger.settled('visible')  // resolves when the count returns to 0
```

Counters emit events you can watch instead of polling:

```ts
node.on('count:visible', ({ payload }) => { ... })
node.on('settled:blocking', () => { ... })
```

Condition shorthand: pass a string (a `type` such as `'validation'`) instead
of a predicate — `parseCondition` expands it (`dist/index.mjs:408-411`).

Conventions:

- The validation plugin registers the `blocking` counter; forms query it to
  decide submitability (https://formkit.com/essentials/architecture#ledger).
- `node.ledger.count()` propagates the counter to existing children
  recursively, so register it once on the root (or any ancestor)
  (`dist/index.mjs:401-404`).
- `settled(name)` returns an already-resolved promise for unknown counter
  names (`dist/index.mjs:374-376`) — a typo silently never waits.
