# Code Block Features

Source: shipped skill references and https://sli.dev/guide/syntax#code-blocks.
Feature options live in `{}` braces after the fence info string; generic render
options (height, maxHeight, lines) go in a second `{}` group.

## Line highlighting

Static:

````md
```ts {2,3}
function add(a: number, b: number) {
  return a + b
}
```
````

Click-based, `|` separates stages:

````md
```ts {2-3|5|all}
```
````

Special values: `hide` (block hidden), `none` (no highlight), `all`.
Use `{*}` as an empty placeholder when stacking option groups.

## Line numbers

Headmatter `lineNumbers: true` for all blocks, or per block:

````md
```ts {6,7}{lines:true,startLine:5}
```
````

## Scrollable code

````md
```ts {*}{maxHeight:'100px'}
```
````

Fixed Monaco height: `{height:'300px'}` or `{height:'auto'}`.

## TwoSlash

TypeScript types, errors, and hover info:

````md
```ts twoslash
const count = ref(0)
//            ^?
```
````

## Monaco editor

````md
```ts {monaco}
console.log('Hello')
```
````

Diff editor (split blocks with `~~~`):

````md
```ts {monaco-diff}
console.log('Original')
~~~
console.log('Modified')
```
````

Runnable (Run button, JS/TS only):

````md
```ts {monaco-run} {autorun:false}
console.log('Click play to run')
```
````

`{showOutputAt:'+1'}` reveals output on click. Other languages need custom
runners (`/custom/config-code-runners` in the docs).

## Imported snippets

```md
<<< @/snippets/snippet.js
<<< @/snippets/snippet.js#region-name
<<< @/snippets/snippet.js ts
<<< @/snippets/snippet.js {2,3|5}{lines:true}
<<< ./some-file.ts {monaco-write}
```

`@` is the project root. `{monaco-write}` links the editor to the file on disk.

## Code groups

Tabs around multiple blocks; requires `comark: true` in headmatter:

````md
::code-group

```sh [npm]
npm i @slidev/cli
```

```sh [pnpm]
pnpm add @slidev/cli
```

::
````

Titles auto-match icons (install `@iconify-json/vscode-icons`).
Custom icons: ```` ```js [npm ~i-uil:github~] ```` plus a UnoCSS safelist entry.

## Magic Move

Morphs between consecutive code blocks on click. Wrapper needs four backticks:

`````md
````md magic-move
```js
console.log(`Step ${1}`)
```
```js
console.log(`Step ${1 + 1}`)
```
````
`````

With highlighting:

`````md
````md magic-move {at:4, lines: true}
```js {*|1|2-5}
```
````
`````

Duration via headmatter `magicMoveDuration`; easing/stagger via `shiki.magicMove`.
