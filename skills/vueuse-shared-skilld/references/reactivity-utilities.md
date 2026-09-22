# Reactivity utilities, @vueuse/shared 15.0.0

## Controlled computed: `computedWithControl`

`computed` with explicit dependencies plus a manual `trigger()`; supports a
writable `{ get, set }` form (dist/index.js:37-71, dist/index.d.ts:22-35).

```ts
import { computedWithControl } from '@vueuse/shared'
import { ref } from 'vue'

const name = ref('vueuse')
const version = ref(15)

// recompute only when name changes, even if version is read inside
const label = computedWithControl(name, () => `v${version.value} of ${name.value}`)
label.trigger() // force recompute on demand
```

## Controlled ref: `refWithControl`

A ref with escape hatches around tracking and triggering
(dist/index.js:938-995):

- `get(tracking = true)` / `set(value, triggering = true)`
- `untrackedGet()` = `peek()`: read without collecting dependencies
- `silentSet(v)` = `lay(v)`: write without notifying
- options `onBeforeChange(value, old)` returning `false` vetoes the write;
  `onChanged(value, old)` runs synchronously after (dist/index.d.ts:622-635)

```ts
const num = refWithControl(0, { onBeforeChange: (v, o) => Math.abs(v - o) <= 5 })
num.lay(999)      // value changes, dependents do not re-run
num.peek()        // 999, without tracking
```

## Reset and default wrappers

- `refDefault(source, defaultValue)`: reading maps `null` / `undefined` to the
  default; writing stores into the source (dist/index.js:841-851).
- `refManualReset(default)`: `reset()` restores `toValue(default)`; the ref is
  shallow, so deep objects will not update nested UI; wrap values in
  `reactive` if needed (dist/index.js:860-882).
- `refAutoReset(default, afterMs = 10_000)`: each set schedules a reset
  (dist/index.js:773-797).

## Two-way sync: `syncRef`

Defaults `flush: 'sync'`, `immediate: true`, `direction: 'both'`, `deep: false`
(dist/index.js:1048-1049). Returns a `stop()` handle. When the two ref types
differ, `transform.ltr` / `transform.rtl` become required at the type level
(dist/index.d.ts:656-726).

```ts
syncRef(numRef, strRef, {
  direction: 'ltr',
  transform: { ltr: v => String(v) },
})
```

One-way alternative: `syncRefs(source, targets, options)` copies source to one
or many targets and returns a `WatchHandle` (dist/index.js:1084-1092).

## Normalization

- `toRef(getter)` -> readonly ref; `toRef(value)` -> `ref(value)`; the
  2-3 argument object/key form delegates to Vue's `toRef`
  (dist/index.js:290-297).
- `toRefs(objOrRef, { replaceRef = true })`: destructuring refs whose `set`
  replaces the source object with a copy (immutable-style updates). Pass
  `replaceRef: false` to mutate in place (dist/index.js:1102-1128).
- `toReactive(refOfObject)` -> reactive proxy that unwraps nested refs; safe
  for get/set/delete/has/ownKeys (dist/index.js:703-731).
- `reactiveComputed(fn)`: `toReactive(computed(fn))`; access computed members
  as plain properties (dist/index.js:737-739).

## Object views

`reactivePick(obj, ...keys | predicate)` and `reactiveOmit(obj, ...keys | key[] | predicate)`
return live subsets (dist/index.js:747-763). Keys may be spread across
arguments and arrays.

```ts
const pos = reactivePick(state, 'x', 'y')
const rest = reactiveOmit(state, ['x', 'y'])
```

## Reactify

`reactify(fn)` turns a plain function into one that accepts refs / getters and
returns a `ComputedRef` (dist/index.js:669-674). `computedGetter: false`
switches unwrapping from `toValue` to `unref` (getters then pass through
unwrapped). `reactifyObject(obj, keysOrOptions)` reactifies every function
member (dist/index.js:680-694).

```ts
const sqrt = reactify(Math.sqrt)
const c = sqrt(numRef) // ComputedRef<number>
```

## Composable ergonomics

- `makeDestructurable(obj, arr)`: return object that also destructures as the
  array; lets consumers pick `const { x } = useThing()` or
  `const [x] = useThing()` (dist/index.js:641-656).
- `extendRef(ref, extensions, { enumerable = false, unwrap = true })`: attach
  extra properties; ref-valued extensions become getter/setter pairs
  (dist/index.js:608-626).
- `createRef(value, deep)`: conditional deep/shallow construction
  (dist/index.js:258-261).
- `isDefined(v)`: `unref(v) != null` with type narrowing (dist/index.js:635-637).
- `get(r, key?)` / `set(ref | target, value | key, value?)`: terse access
  helpers useful in generic code (dist/index.js:629-632, 1003-1012).
