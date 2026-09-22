---
name: formkit-core-skilld
description: Use whenever writing, debugging, or reviewing code that imports @formkit/core — FormKit's framework-agnostic core (node trees, values, events, hooks, message stores, ledgers, config, schema types, expression compiler). Provides correct 2.1.x API signatures, common-task examples, behavioral rules, and version limits.
---

# @formkit/core 2.1.2

Framework-agnostic core of FormKit. Every input, group, list, and form is a
`FormKitNode` in a tree. Vue and React adapters (`@formkit/vue`,
`@formkit/react`) render these nodes; input types, validation, and i18n live in
sibling packages, not here. Scope this Skill to `@formkit/core` imports only.

- Package: `@formkit/core@2.1.2`, ESM (`"type": "module"`) with CJS fallback,
  plus a `development` condition build (`package.json:8-21`).
- Sole dependency: `@formkit/utils@^2.1.2` (`package.json:38-40`).
- Docs: https://formkit.com/essentials/architecture
- API reference: https://formkit.com/api-reference/core

## When to use another package

| Need | Package |
| --- | --- |
| `<FormKit>` components, `defaultConfig`, `createInput` | `@formkit/vue` / `@formkit/react` |
| Input type definitions (`text`, `select`…) | `@formkit/inputs` |
| Validation rules | `@formkit/validation` |
| Locale messages | `@formkit/i18n` |
| Schema *rendering* | `@formkit/vue` (types + compiler are here) |

## Public API

Runtime exports (`dist/index.mjs:1919`): `bfs`, `clearErrors`, `compile`,
`createClasses`, `createConfig`, `createMessage`, `createNode`,
`createPlaceholder`, `createValue`, `deregister`, `error`, `errorHandler`,
`generateClassList`, `getNode`, `isComponent`, `isConditional`, `isDOM`,
`isList`, `isNode`, `isPlaceholder`, `isSugar`, `names`, `register`, `reset`,
`resetCount`, `resetRegistry`, `setErrors`, `stopWatch`, `submitForm`,
`sugar`, `use`, `useIndex`, `valueInserted`, `valueMoved`, `valueRemoved`,
`warn`, `warningHandler`, `watchRegistry`, `FORMKIT_VERSION` — plus ~70 public
types (`dist/index.d.mts:2329`).

## Common tasks

### Create a node tree

```ts
import { createNode } from '@formkit/core'

const email = createNode({ name: 'email' })
const form = createNode({
  type: 'group',            // 'input' (default) | 'group' | 'list'
  children: [email, createNode({ name: 'password' })],
})
form.at('email')            // → the email node
```

Group values are objects keyed by child `name`; list values are arrays keyed
by child index (`dist/index.mjs:714-723`). Full option table:
[node API](./references/node-api.md).

### Set a value and await settlement

```ts
await email.input('sam@example.com')  // debounced, async commit
email.value                            // committed value
```

Never assign `node.value = x` directly. `input()` debounces (default 20 ms on
input nodes, `dist/index.mjs:1255-1267`), then commits through the `commit`
hook (`dist/index.mjs:759-765`). `await node.settled` resolves when the whole
subtree finished committing (`dist/index.d.mts:1856-1860`).

### Listen to events (and clean up)

```ts
const receipt = form.on('commit.deep', ({ payload }) => { ... })
// later:
form.off(receipt)
```

`.deep` catches events bubbling from descendants (`dist/index.mjs:47-53`).
`on()` returns a receipt; always pass it to `off()`. Core event table:
[events and hooks](./references/events-hooks.md).

### Register hook middleware

```ts
node.hook.commit((value, next) => next(transform(value)))
```

Middleware signature is `(payload, next) => next(payload)`; hooks:
`classes`, `commit`, `error`, `setErrors`, `init`, `input`, `message`,
`prop`, `text`, `schema` (`dist/index.d.mts:579-600`). Register inside plugins
for reuse.

### Write a plugin

```ts
import { createNode } from '@formkit/core'
import type { FormKitPlugin } from '@formkit/core'

const colorize: FormKitPlugin = (node) => {
  node.props.color = node.type === 'group' ? 'yellow' : 'teal'
  // return false to stop inheritance by children
}
createNode({ type: 'group', plugins: [colorize], children: [createNode()] })
```

Plugins are inherited by descendants and run once per node. Attach
`plugin.library` to define custom input types via `node.define()`.

### Store a message; count with the ledger

```ts
import { createMessage, createNode } from '@formkit/core'

const node = createNode()
node.store.set(createMessage({ key: 'limit', value: 'Too many!' }))
node.store.limit.value                       // 'Too many!'
node.ledger.count('visible', (m) => m.visible)
node.on('count:visible', ({ payload }) => console.log(payload))
```

Details: [store and ledger](./references/store-ledger.md).

### Reach a node by id

```ts
import { createNode, getNode, watchRegistry, stopWatch } from '@formkit/core'

const node = createNode({ props: { id: 'manufacturer' } }) // root nodes register
getNode('manufacturer')                    // FormKitNode | undefined
const receipt = watchRegistry('manufacturer', (e) => { ... })
stopWatch(receipt)
```

Root nodes (or nodes with `props.alias`) register automatically
(`dist/index.d.mts:2220-2228`). Details:
[registry and helpers](./references/registry-helpers.md).

### Set errors, reset, submit

```ts
import { setErrors, clearErrors, reset, submitForm } from '@formkit/core'

setErrors('myForm', 'Server rejected', { email: ['Already taken'] })
reset('myForm', { email: '' })   // resetTo becomes the new initial value
clearErrors('myForm', true)      // true clears children too
submitForm('myForm')             // dispatches a submit DOM event
```

### Compile a schema expression

```ts
import { compile } from '@formkit/core'

const condition = compile("$name == 'bob'").provide((tokens) => {
  return { name: () => nameRef.value }   // each token must return a function
})
condition()  // false
```

Operators: `&& || == != === !== > < >= <= + - * / %` (`dist/index.mjs:1574-1598`).
Schema node types and guards: [schema and compiler](./references/schema-compiler.md).

## Behavioral rules that prevent bugs

- Read config through `node.props`, not `node.config`; explicit props and
  parent config are merged into props (`dist/index.d.mts:729-792`).
- Setting a root config property emits `config:{prop}` on the origin and
  `prop` / `prop:{prop}` on every inheriting node that does not override it
  (`dist/index.mjs:1283-1289`).
- `group` nodes require object values, `list` nodes require arrays; violations
  throw error 107 / 108 (`dist/index.mjs:745-757`).
- Messages are immutable (`Readonly<FormKitMessageProps>`,
  `dist/index.d.mts:70-75`); replace via `store.set()`, never mutate.
- `node.walk()` traverses the subtree without the node itself and is expensive;
  reserve it for rare lifecycle moments (`dist/index.d.mts:1885-1890`).
- Avoid two same-`name` siblings under one parent; if unavoidable, sync them
  with `config.mergeStrategy = { fieldName: 'synced' }`
  (`dist/index.d.mts:721-725`).
- `node.root` traverses on every read; do not call it in hot paths
  (`dist/index.d.mts:1840-1843`).
- Replace core error handling by registering middleware on the exported
  `errorHandler` / `warningHandler` dispatchers (`dist/index.d.mts:2151-2157`).

## Version limits

- Written against `@formkit/core@2.1.2` (published 2026-07-24).
- 2.x changes since 2.0.0 are bug fixes in reset, registry cleanup, and the
  compiler; no core API breaks. See
  [API changes](./references/api-changes.md).
- `FORMKIT_VERSION` is a build-time placeholder (`"__FKV__"`) in the prepared
  source; do not branch on it (`dist/index.d.mts:2321-2327`).

## References

- [Node API](./references/node-api.md) — creation, types, traps, value flow, settlement, traversal
- [Events and hooks](./references/events-hooks.md) — emitter, receipts, `.deep`, event table, hook middleware
- [Store and ledger](./references/store-ledger.md) — messages, `createMessage`, counters
- [Config, props, plugins](./references/config-props-plugins.md) — inheritance, `createConfig`, `mergeStrategy`, libraries
- [Schema and compiler](./references/schema-compiler.md) — schema node types, guards, `sugar()`, `compile()`
- [Registry and helpers](./references/registry-helpers.md) — `getNode`, `setErrors`, `reset`, `submitForm`, error codes
- [API changes](./references/api-changes.md) — 2.0.0 → 2.1.2
