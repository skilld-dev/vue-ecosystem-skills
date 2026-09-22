# Schema and compiler

Core ships the schema *types* and the expression *compiler*; rendering lives
in `@formkit/vue` / `@formkit/react` (`FormKitSchemaContext`,
`dist/index.d.mts:318-325`).

## Schema node types

`FormKitSchemaNode` union (`dist/index.d.mts:331`):

| Type | Discriminator | Shape |
| --- | --- | --- |
| `FormKitSchemaDOMNode` | `$el` | `{ $el: 'div', attrs?, ...props }` |
| `FormKitSchemaComponent` | `$cmp` | `{ $cmp: 'MyComp', props?, ...props }` |
| `FormKitSchemaFormKit` | `$formkit` | sugar: `{ $formkit: 'text', ...inputProps }` |
| `FormKitSchemaTextNode` | — | plain string |
| `FormKitSchemaCondition` | `if` | `{ if, then, else? }` |

Common props on schema nodes (`FormKitSchemaProps`,
`dist/index.d.mts:243-250`): `children`, `key`, `if`, `for` (a
`FormKitListStatement` tuple `[value, key?, list]`), `bind`, `meta`.

Attribute values accept condition objects
(`FormKitSchemaAttributesCondition`: `{ if, then, else? }`,
`dist/index.d.mts:277-281`).

## Type guards and sugar

```ts
import { isDOM, isComponent, isConditional, isSugar, sugar } from '@formkit/core'

if (isSugar(node)) node = sugar(node)   // $formkit → $cmp: 'FormKit'
```

`sugar()` rewrites `{ $formkit: 'text', label: X }` into a
`FormKitSchemaComponent` with `props` spread and moves `if` / `for` /
`children` / `bind` up (`dist/index.mjs:1526-1551`). Guards:
`dist/index.d.mts:388-438`.

`FormKitSectionsSchema` maps section names to
`FormKitSchemaNodeExtension` values (partial nodes or `null` to unset) — the
shape input definitions accept for section overrides
(`dist/index.d.mts:333-378`).

## Compiler

`compile(expr)` parses a `$`-token expression into one function
(`dist/index.d.mts:2194-2217`):

```ts
const condition = compile("$name == 'bob'").provide((tokens) => {
  // tokens is the array of required token names, e.g. ['name']
  return { name: () => nameRef.value }  // every value MUST be a function
})
condition()  // false
```

Grammar (`dist/index.mjs:1574-1598,1701-1710`):

- Token references: `$foo`, nested `$foo.bar`, calls `$fn(...)`
  (parenthesized `$`-prefixed operands become function tokens; tails bind
  `this`, `dist/index.mjs:1552-1567`).
- Operators by precedence: `&& ||` → `== != === !== > < >= <=` →
  `+ -` → `* / %`.
- String literals in single or double quotes with `\` escapes
  (`dist/index.mjs:1660-1700`).
- A leading operator or trailing operator is a compile error (codes 103/104,
  `dist/index.mjs:1714-1719`).

Compiled output type is `FormKitCompilerOutput`: call with a tokens object to
evaluate; `.provide(callback)` injects token resolvers
(`dist/index.d.mts:2182-2192`).

In schema strings, `$:` prefixes mark compiled expressions; `expr.startsWith('$:')`
is stripped before parsing (`dist/index.mjs:1831`). The rendering adapter
supplies token values: `$_value` (live, non-debounced), `$value` (committed),
`$handlers`, `$attrs`, and node props directly (`$label`, `$type`, …)
(https://formkit.com/essentials/custom-inputs).
