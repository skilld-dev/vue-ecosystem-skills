# Node API

`FormKitNode` is a Proxy over `FormKitContext`; every "method" is a trap
(`dist/index.d.mts:608-691`). Detect real nodes with `isNode()` (checks
`__FKNode__`, `dist/index.d.mts:2007-2034`).

## Node types

`FormKitNodeType = 'input' | 'list' | 'group'` (`dist/index.d.mts:624`). These
are structural roles, not input types:

- `input` — leaf, any value type. Default.
- `group` — object value keyed by child `name`. `<FormKit type="form">` is one.
- `list` — array value; child names become indexes
  (`createName`, `dist/index.mjs:710-713`).

`createValue()` coerces initial values: group non-objects become `{}`, list
non-arrays become `[]` (`dist/index.mjs:714-723`). Later violations of these
shapes throw error 107 (group) or 108 (list) via `validateInput()`
(`dist/index.mjs:745-757`).

## createNode options

`FormKitOptions` is `Partial<FormKitContext>` plus (`dist/index.d.mts:1086-1126`):

| Option | Default | Notes |
| --- | --- | --- |
| `type` | `'input'` | structural type |
| `name` | `{type}_{n}` | counter resets with `resetCount()` |
| `value` | type default | initial committed value |
| `parent` | `null` | attach to a tree |
| `children` | `[]` | array or Set of nodes |
| `index` | — | explicit slot when added to a list |
| `config` | `{}` | inherited defaults exposed as props |
| `props` | `{}` | instance-level, not inherited |
| `plugins` | `[]` | inherited by descendants |
| `sync` | `false` | list nodes: keep child nodes in step with array value |

Auto-generated names collide across tests; call `resetCount()` between test
cases for deterministic naming (`dist/index.d.mts:2036-2041`).

## Trap inventory

Value and state (`dist/index.d.mts:1710-1891`):

- `value: V` (readonly) — committed value. Mutate only via `input()`.
- `input(value, async = true): Promise<unknown>` — set value; async commits
  debounce by `node.props.delay`.
- `isSettled: boolean`, `settled: Promise<unknown>` — subtree settlement.
- `disturb()` / `calm()` — internal disturbance counting; public but rarely
  needed outside adapters.
- `hydrate()`, `reset(value?)`, `destroy()`, `submit()`, `t(key)`.

Tree operations:

- `add(node, index?)` — attach a child (group/list only).
- `remove(node)` — detach a child.
- `parent`, `root`, `children`, `index`, `address`, `name`, `uid`.
- `at(address)` — dot-syntax or array path; special tokens `$root`,
  `$parent`, `$self`, plus `$root.find(value, property)` BFS
  (`dist/index.d.mts:1736-1743`). Example: `node.at('users.0.password')`,
  `node.at('$parent.$parent.0.email')`.
- `walk(callback, stopOnFalse?, skipSubtreeOnFalse?)` — subtree, excludes self.
- `each(callback)` — immediate children only.
- `find(selector, searcher?)` — string selector; `searcher` is a `FormKitNode`
  key or predicate (`FormKitSearchFunction`).
- `bfs(tree, searchValue, searchGoal?)` — standalone breadth-first search
  export (`dist/index.d.mts:2083-2094`).

Definition and extension:

- `define(definition)` — apply a `FormKitTypeDefinition` to this node.
- `extend(key, trap)` — add a custom trap (`node.{key}`).
- `addProps(props)` — promote strings from `props.attrs` to real props.
- `use(plugin, run?, library?)` — register plugin(s) on the subtree.
- `resetConfig()` — re-derive config from parent/root.

Errors:

- `setErrors(localErrors, childErrors?)`, `clearErrors(clearChildren?, sourceKey?)`.

## Value flow

1. `node.input(v)` runs the `input` hook and stores the result as the
   unsettled `_value` (`dist/index.mjs:724-725`).
2. Identical re-input on an `input` node short-circuits with a `commitRaw`
   event only (`dist/index.mjs:727-730`).
3. Async mode debounces via `setTimeout(commit, node.props.delay)`
   (`dist/index.mjs:732-739`); `input(v, false)` commits synchronously.
4. `commit()` runs the `commit` hook, assigns `context.value`, hydrates
   group/list children, emits `commitRaw` then `commit`, and calms
   (`dist/index.mjs:759-765`).
5. Child commits propagate upward through `partial()` which patches the
   parent's `_value` (`dist/index.mjs:766-782`).

`_value` is the pre-commit value; treat it as internal
(https://formkit.com/essentials/architecture#setting-values).

## Settlement

Each node tracks a disturbance count `_d`. `input()` disturbs; `commit()`
calms. The count propagates to the root, so `await root.settled` means every
input finished committing. `<FormKit type="form">` already awaits settlement
before calling `@submit` (https://formkit.com/essentials/architecture#value-settlement).

## Placeholders

List reordering inserts `FormKitPlaceholderNode` stand-ins (`__FKP: true`).
They are always settled and no-op `use()`. Filter with `isPlaceholder()`
before treating children as real nodes (`dist/index.d.mts:1897-1939`,
`dist/index.d.mts:2104-2110`). `isList()` narrows a context to a list shape
(`dist/index.d.mts:1996-2005`).
