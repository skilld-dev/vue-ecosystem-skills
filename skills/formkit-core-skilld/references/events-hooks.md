# Events and hooks

## Event shape

Listeners receive one `FormKitEvent` (`dist/index.d.mts:35-41`):

```ts
{
  payload: any,                  // event data
  name: string,                  // matches node.on() name
  bubble: boolean,               // whether it bubbles to parents
  origin: FormKitNode,           // emitting node
  meta?: Record<string, unknown>
}
```

## on / off / receipts

```ts
const receipt = node.on('input', ({ payload }) => console.log(payload))
node.off(receipt)
```

- `on(name, listener, pos?)` returns a receipt string; `pos` is `'push'`
  (default) or `'unshift'` (`dist/index.d.mts:1821-1828`).
- Assign `listener.receipt = 'my-shared'` before `on()` to share one receipt
  across listeners; a single `off('my-shared')` removes them all
  (`dist/index.d.mts:1468-1489`).
- Always remove listeners in teardown; receipts are the only handle.

## The .deep modifier

Events bubble by default but listeners only fire for events emitted by the
same node. Append `.deep` to the event name to also catch events bubbling
from descendants (`dist/index.mjs:47-53`):

```ts
form.on('created.deep', ({ payload: child }) => console.log(child.name))
```

`.deep` is not a separate event name; the emitter splits on `.`
(`dist/index.mjs:63-64`).

## Emitting

```ts
node.emit('myEvent', payload)          // bubbles
node.emit('myEvent', payload, false)   // local only
```

Signature `emit(event, payload?, bubble?, meta?)`
(`dist/index.d.mts:1789-1790`). Emitting custom events from plugins is a
supported pattern (https://formkit.com/essentials/architecture#emitting-events).

## Emitter pause / play

The internal emitter supports `pause(node?)` / `play(node?)` to buffer events
— used by `reset()` so resets do not spam listeners
(`dist/index.mjs:90-104`). v2.1.0 fixed buffered reset events being dropped
(GitHub release v2.1.0, **core**: "Preserve buffered reset events").

## Core events

Official table (https://formkit.com/essentials/architecture#core-events):
`commit`, `commitRaw` (emitted in `commit()`, `dist/index.mjs:762-763`),
`config:{property}`, `count:{property}`, `child`, `childRemoved`, `created`,
`defined`, `destroying`, `dom-input-event`, `input`, `message-added`,
`message-removed`, `message-updated`, `mounted`, `prop`, `prop:{propName}`,
`reset`, `settled`, `settled:{counterName}`, `unsettled:{counterName}`,
`text`.

Config changes cascade: setting a config prop on a node emits
`config:{prop}` there and `prop` / `prop:{prop}` on every inheriting node
that does not override it (`dist/index.mjs:1283-1289`).

## Hooks

Hooks are `FormKitDispatcher` middleware chains, auto-created on first access
via a Proxy (`dist/index.mjs:690-696`). Payload types in
`FormKitHooks` (`dist/index.d.mts:579-600`):

| Hook | Payload | Fires |
| --- | --- | --- |
| `input` | any | every `node.input()`, pre-debounce |
| `commit` | any | value committed to the tree |
| `init` | `FormKitNode` | node created, before `createNode()` returns |
| `message` | `FormKitMessage` | message being set on `node.store` |
| `prop` | `{ prop, value }` | any prop assignment |
| `text` | `FormKitTextFragment` | user-facing string, pre-display |
| `classes` | `{ property, classes }` | class list computed, pre-string |
| `schema` | schema node array/condition | schema assignment |
| `error` | string | thrown error processing |
| `setErrors` | `{ localErrors, childErrors? }` | explicit errors set |
| `submit` | `Record<string, any>` | form submit passing validation; modify cloned values |

Middleware pattern (`dist/index.d.mts:8-19`):

```ts
node.hook.prop((payload, next) => {
  if (payload.prop === 'label') payload.value = String(payload.value).trim()
  return next(payload)
})
```

Rules:

- Always `return next(payload)`; skipping `next` breaks the chain.
- Register middleware once per concern; dispatcher order is registration
  order. `unshift` exists on dispatchers for priority middleware
  (`dist/index.d.mts:14-19`).
- The most common registration site is inside a plugin so every node in a
  tree gets the middleware (https://formkit.com/essentials/architecture#hook-middleware).

`commitRaw` is an event, not a hook; it fires alongside `commit` before
bubble processing (`dist/index.mjs:728,762`).
