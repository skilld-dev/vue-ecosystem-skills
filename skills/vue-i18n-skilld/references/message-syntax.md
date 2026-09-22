# Message format syntax

Locale message syntax for `t`, `$t`, and the interpolation components.

## Named interpolation

```json
{ "greeting": "hi, {name}!" }
```

```js
t('greeting', { name: 'Kyoko' })
```

## List interpolation

Zero-based positional placeholders:

```json
{ "order": "item {0} added to {1}" }
```

```js
t('order', ['book', 'cart'])
```

## Pluralization

Pipe-separated forms; the plural rule for the active locale picks a branch (default English rule: `0` and `1` map to the first form).

```json
{ "apple": "no apples | one apple | {count} apples" }
```

```js
t('apple', 2)                       // "one apple"
t('apple', 3, { count: 3 })         // "3 apples"
t('apple', { count: 3 }, 3)         // named args first, choice second
```

Implicit values `n` and `count` are available in plural messages when passed as named args.

The v8 modulo syntax (`%s`, `%d`) was removed in v10: https://vue-i18n.intlify.dev/guide/migration/breaking10.html#drop-modulo-syntax

## Linked messages

Reference another message with `@:key`:

```json
{
  "name": "Kyoko",
  "greeting": "hi, @:name!"
}
```

Modifier form `@.modifier:key`; built-in modifiers are `upper`, `lower`, `capitalize`; add custom ones via the `modifiers` option. Linked with interpolation: `@:{'message.key'}`.

## Special characters

- Literal `{` / `}`: `{'{'` and `{'}'`
- Literal `@`: `{'@'}`
- Literal `|`: `{'|'}`

## HTML in messages

Messages may contain HTML when rendered with `v-html`, but vue-i18n warns (`warnHtmlMessage`, default `true`) because message content is usually not trusted. Prefer plain text plus component interpolation with `<i18n-t>`.

Set `escapeParameter: true` to HTML-escape interpolation parameters when the translated string is rendered as HTML (XSS safeguard, dist/vue-i18n.d.ts:892-898): https://vue-i18n.intlify.dev/guide/essentials/syntax.html#using-the-escapeparameter-option

## Message functions

A message value can be a function instead of a string, for full control (returning a VNode is supported in Composition mode):

```json
{ "fn": "item {0} added" }
```

```js
messages: { en: { fn: (ctx) => ctx.named('items') } }
```

Docs: https://vue-i18n.intlify.dev/guide/advanced/function.html

Docs: https://vue-i18n.intlify.dev/guide/essentials/syntax.html, https://vue-i18n.intlify.dev/guide/essentials/pluralization.html
