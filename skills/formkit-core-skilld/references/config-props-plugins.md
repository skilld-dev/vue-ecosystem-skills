# Config, props, plugins

## Config inheritance

`node.config` is a Proxy. Lookups fall through: own value → parent chain →
`rootConfig` → `defaultConfig` (`dist/index.mjs:1249-1269`). Writes emit
`config:{prop}` on the node and propagate `prop` / `prop:{prop}` events to
all descendants that do not override the prop (`dist/index.mjs:1283-1289`).

Read resolved values from `node.props`, not `node.config`. `props` merges
explicit instance props over inherited config
(`dist/index.d.mts:729-792`):

```ts
const child = createNode({ props: { flavor: 'cherry' } })
const parent = createNode({
  type: 'group',
  config: { size: 'large', flavor: 'grape' },
  children: [child],
})
child.props.size    // 'large'  (inherited)
child.props.flavor  // 'cherry' (own prop wins)
```

This is also how locale changes propagate: setting `config.locale` on a root
emits `prop:locale` down the tree.

## Standard config keys

`FormKitConfig` (`dist/index.d.mts:698-727`):

- `delimiter` — address separator, default `'.'`. Change it if input names
  contain dots.
- `rootClasses(sectionKey, node)` — base class layer; `false` disables.
- `classes` — per-section overrides applied after `rootClasses`.
- `rootConfig` — link to the global root config object.
- `mergeStrategy` — map of child name → `'synced'`.

`delay` (debounce ms) defaults to `20` for input nodes when nothing is
inherited (`dist/index.mjs:1255-1267`).

## createConfig (root config)

```ts
import { createConfig } from '@formkit/core'

const rootConfig = createConfig({ delimiter: '/' })
```

The returned `FormKitRootConfig` is a Proxy; assigning any property notifies
every registered node via `configChange` (`dist/index.mjs:511-529`), which
emits `config:{prop}` plus `prop` events unless the node overrides the prop
(`dist/index.mjs:502-510`). v2.1.2 hardened repeated config removal during
teardown (GitHub release v2.1.2, **core**: "Guard repeated config removal").

## mergeStrategy

Two same-`name` children under one parent normally fight over one value slot.
`mergeStrategy` syncs them:

```ts
createNode({
  type: 'group',
  config: { mergeStrategy: { my_radio: 'synced' } },
})
```

Only `'synced'` exists in 2.1.x (`dist/index.d.mts:721-725`). Prefer unique
names; treat this as a fallback for template-constrained cases. Synced nodes
also affect `input()` short-circuiting (`dist/index.mjs:727`).

## Plugins

A plugin is a function receiving a node; it is inherited by descendants and
executed once per node (`dist/index.d.mts:558-561`):

```ts
const myPlugin: FormKitPlugin = (node) => {
  if (node.type === 'group') node.props.color = 'yellow'
  else node.props.color = 'teal'
  return false // omit: returning false stops inheritance by children
}
```

Register via `createNode({ plugins: [myPlugin] })` or `node.use(myPlugin)`
(runs on the subtree). `use(plugin, run?, library?)` flags control immediate
execution (`dist/index.d.mts:1880-1884`).

## Libraries and define

Input types ship from sibling packages; core only provides the mechanism.
Assign a `library` function to a plugin to define types by inspecting
`node.props.type`:

```ts
const euroInputs = () => {}
euroInputs.library = (node) => {
  if (node.props.type === 'italy') {
    node.define({
      type: 'input',
      family: 'text',
      schema: [{ $el: 'input', attrs: { onInput: '$handlers.DOMInput' } }],
    })
  }
}
```

`FormKitTypeDefinition` fields (`dist/index.d.mts:501-543`): `type`
(required), `family`, `forceTypeProp`, `props` (pseudo props), `schema` or
`component`, `library`, `features`, `schemaMemoKey`.

`node.addProps(props)` moves matching keys from `props.attrs` to top-level
props — pseudo props accept `string[]` or a definition map with
`default` / `boolean` / `getter` / `setter`
(`dist/index.d.mts:1944-1960`).
