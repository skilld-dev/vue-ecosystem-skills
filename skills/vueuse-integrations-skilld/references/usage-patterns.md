# Usage patterns and gotchas — @vueuse/integrations 15.0.0

## useAxios

One-off request; the return is thenable:

```ts
const { data, error } = await useAxios('/api/posts')
```

Manual trigger with abort of the in-flight request (default `abortPrevious: true`):

```ts
const { execute, abort, isLoading } = useAxios('/api/posts', {}, { immediate: false })
async function refresh() {
  await execute()            // same url
  await execute('/api/other') // new url
}
```

Shared config through an axios instance:

```ts
const api = axios.create({ baseURL: 'https://api.example.com' })
const { data } = useAxios<User[]>('/users', api, { initialData: [] })
```

- `resetOnExecute: true` resets `data` to `initialData` before each execution (dist/useAxios.js:59-61).
- Without `initialData`, `data` stays `undefined` until success; guard renders on `isFinished`/`isLoading`.
- Do not pass `immediate: true` to a no-url call; `execute` errors with `ERR_INVALID_URL` when no url is resolvable (dist/useAxios.js:73-77).

## useIDBKeyval

Object form (v15):

```ts
const { data: settings, isFinished, set } = useIDBKeyval('settings', { theme: 'dark' })

// reactive writes; deep watch persists nested mutations
settings.value.theme = 'light'

// await an explicit write
await set({ theme: 'system' })
```

- Disable cross-tab sync for private values: `useIDBKeyval('key', 0, { listenToStorageChanges: false })` (dist/useIDBKeyval.js:60).
- Custom codec for dates:

```ts
useIDBKeyval<Date>('seen', new Date(), {
  serializer: {
    read: raw => new Date(raw as string),
    write: value => value.toISOString(),
  },
})
```

- `writeDefaults: false` skips persisting the initial value for absent keys (dist/useIDBKeyval.js:26-29).
- Large immutable data: `shallow: true` avoids deep watching; use `set()` for writes.

## useSortable

List follows the DOM automatically; keep the list as a plain ref of objects keyed by id:

```ts
const list = ref([{ id: 1 }, { id: 2 }])
useSortable(listRef, list, {
  handle: '.handle',
  animation: 150,
})
```

Conditional rendering needs `watchElement: true` (added in v14.2.0, https://github.com/vueuse/vueuse/issues/5189):

```ts
useSortable(el, list, { watchElement: true })
```

Custom `onUpdate` (replaces the default array move):

```ts
import { moveArrayElement } from '@vueuse/integrations/useSortable'

useSortable(el, list, {
  onUpdate: (e) => {
    moveArrayElement(list, e.oldIndex, e.newIndex, e)
    nextTick(() => {
      // array and DOM are settled; run post-move logic here
    })
  },
})
```

- `moveArrayElement` reorders the array inside `nextTick`; read the moved array in a `nextTick` callback, not inline (dist/useSortable.js:84-90).
- Pausing interaction without destroying: `option('disabled', true)`; `stop()` destroys the instance, `start()` recreates it from the current element.
- String selectors never re-resolve after `stop()`; element refs do when `watchElement` is on.

## useFocusTrap

Modal with `v-if`:

```ts
const target = useTemplateRef<HTMLElement>('modal')
const { activate, deactivate } = useFocusTrap(target)

async function open() {
  show.value = true
  await nextTick() // trap created by the post-flush watcher once the element exists
  activate()
}
```

Or let the component handle mount and cleanup:

```vue
<script setup>
import { UseFocusTrap } from '@vueuse/integrations/useFocusTrap/component'
</script>

<template>
  <UseFocusTrap v-if="show" :options="{ immediate: true }">
    <div class="modal" tabindex="-1">...</div>
  </UseFocusTrap>
</template>
```

- Do not call `activate()` before the element renders; the trap does not exist yet (dist/useFocusTrap.js:39).
- `deactivate()` runs automatically on scope dispose (dist/useFocusTrap.js:58).
- User-triggered escape/back-compat keys belong in focus-trap `Options` (`escapeDeactivates`, `allowOutsideClick`), not in wrapper code.

## useCookies

Reactive reads with an explicit dependency list:

```ts
const { get } = useCookies(['token'])
const token = computed(() => get('token'))
```

Let `get` grow the watch list itself:

```ts
const { get } = useCookies(['token'], { autoUpdateDependencies: true })
// get('theme') now also triggers updates when 'theme' changes
```

SSR (Node request headers):

```ts
// server plugin / entry
const cookies = createCookies(req)
// component setup
const { get } = cookies(['session'])
```

- `get` reactivity works through a change listener plus a `touches` counter; it only updates when a watched cookie actually changes value (dist/useCookies.js:35-39,75-79).
- In Nuxt, import `useCookies` explicitly; Nuxt auto-imports its own `useCookie` (singular) which is a different API.
- Write options: `set(name, value, { maxAge, path, secure, sameSite, expires })` — same shape as universal-cookie.

## useFuse

```ts
const search = ref('')
const { results } = useFuse(search, items, {
  fuseOptions: { keys: ['title', 'author.name'] },
  resultLimit: 10,
  matchAllWhenSearchEmpty: true, // show all while the box is empty
})
```

- Results are `FuseResult[]`: read `result.item` for the datum, `result.refIndex` for its position in the source array (dist/useFuse.js:22-30).
- Changing `fuseOptions` reactively rebuilds the index; changing `data` reuses it via `setCollection`.

## useChangeCase

```ts
const input = ref('hello world')
const camel = useChangeCase(input, 'camelCase') // 'helloWorld'
camel.value = 'foo bar'                          // input becomes 'foo bar'

// read-only over a getter
const slug = useChangeCase(() => title.value, 'paramCase')
```

- Switch `type` reactively: `useChangeCase(input, computed(() => kind.value))` (dist/useChangeCase.js:16-20).
- Invalid types throw at read time, so validate user-supplied type strings first.

## useDrauu

```ts
const svg = useTemplateRef<SVGSVGElement>('pad')
const { brush, undo, redo, clear, canUndo, canRedo, dump, load, onCommitted } = useDrauu(svg, {
  brush: { color: 'red', size: 5 },
})

brush.value.mode = 'line'    // reactive; syncs to the instance
brush.value.color = '#0f0'

onCommitted(({ node }) => saveSnapshot(dump()))
```

- Target any element other than `<svg>` and no instance is created (dist/useDrauu.js:79-80).
- `dump()`/`load()` exchange SVG strings; persist them elsewhere.

## useJwt

```ts
const token = ref<string>()
const { payload } = useJwt(token, {
  fallbackValue: { sub: '' } as JwtPayload,
  onError: err => console.warn('bad token', err),
})
```

`payload`/`header` recompute whenever the token string changes; expired or malformed tokens yield `fallbackValue`, they do not throw.

## useNProgress

```ts
const { isLoading, progress, remove } = useNProgress(0, { trickle: true })

watch(route, () => { isLoading.value = true })
watch(pageData, () => { isLoading.value = false })
```

- Setting `isLoading = true` calls `start()`; `false` calls `done()` (dist/useNProgress.js:12-15).
- `progress` accepts `null` (reset), `0..1` values, and syncs both directions with patched `nprogress.set` (dist/useNProgress.js:17-24).
- One instance is enough per app; `nprogress` is a singleton and concurrent `useNProgress` calls share its DOM bar.

## useQRCode

```ts
const url = ref('https://vueuse.org')
const qr = useQRCode(url, { margin: 2, width: 256, color: { dark: '#000', light: '#fff' } })
```

- The ref starts as `''`; await `watchEffect`/`until(qr).toBe(...)` or bind with `v-if="qr"` (dist/useQRCode.js:14-18).
- Generation is async and client-only; render placeholder markup on the server.

## useAsyncValidator

```ts
const form = reactive({ name: '', age: 18 })
const rules: Rules = {
  name: { required: true, message: 'Name required' },
  age: [{ type: 'number', min: 18 }, { type: 'integer', message: 'Integer only' }],
}

// automatic: revalidates on every form/rules change
const { pass, errors } = useAsyncValidator(form, rules)

// manual: run on submit only
const { execute } = useAsyncValidator(form, rules, { manual: true })
async function submit() {
  const { pass, errorFields } = await execute()
  if (pass) send()
}
```

- Component form:

```vue
<UseAsyncValidator :form="form" :rules="rules" v-slot="{ pass, errors }">
  <input v-model="form.name">
  <span v-if="!pass">{{ errors?.[0]?.message }}</span>
</UseAsyncValidator>
```

- `errors` defaults to `[]` and `errorFields` to `{}`; check `pass` first (dist/useAsyncValidator.js:18-25).
