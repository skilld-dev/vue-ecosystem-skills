---
name: vueuse-integrations-skilld
description: Integration wrappers for utility libraries in @vueuse/integrations v15. ALWAYS use when writing code importing "@vueuse/integrations" or any of its composables (useAxios, useSortable, useFocusTrap, useCookies, useIDBKeyval, useFuse, useChangeCase, useDrauu, useJwt, useNProgress, useQRCode, useAsyncValidator). Consult for debugging, best practices, or modifying @vueuse/integrations, vueuse integrations, vueuse.
---

# @vueuse/integrations 15.0.0

Add-on to VueUse: reactive wrappers for 12 utility libraries. Requires Vue (`^3.5.0`) and ships `@vueuse/core` + `@vueuse/shared` 15.0.0 as dependencies (package.json:55-70,108-111). ESM-only since v13. Node >= 22 since v15 (package.json:52-54).

## References

- [Full API surface](./references/api.md) — every export, signature, option, and default, verified against `dist/`.
- [Usage patterns](./references/usage-patterns.md) — per-function recipes and gotchas.
- [Migration v14 to v15](./references/migration-v14-to-v15.md) — breaking changes and update steps.

## Install

```bash
npm i @vueuse/integrations
```

Each wrapper needs its own optional peer dependency installed, otherwise the import fails at runtime:

| Composable | Peer dependency |
|---|---|
| `useAsyncValidator` | `async-validator@^4` |
| `useAxios` | `axios@^1` |
| `useChangeCase` | `change-case@^5` |
| `useCookies` | `universal-cookie@^7 || ^8` |
| `useDrauu` | `drauu@^1 || ^0.4` |
| `useFocusTrap` | `focus-trap@^7 || ^8` |
| `useFuse` | `fuse.js@^7` |
| `useIDBKeyval` | `idb-keyval@^6` |
| `useJwt` | `jwt-decode@^4` |
| `useNProgress` | `nprogress@^0.2` |
| `useQRCode` | `qrcode@^1.5` |
| `useSortable` | `sortablejs@^1` |

Source: package.json:55-69.

## Import rule: use submodules

Import from per-function submodules for tree-shaking (README.md:33-42):

```ts
// Preferred
import { useAxios } from '@vueuse/integrations/useAxios'

// Avoid
import { useAxios } from '@vueuse/integrations'
```

Components import from `/component` subpaths:

```ts
import { UseFocusTrap } from '@vueuse/integrations/useFocusTrap/component'
import { UseSortable } from '@vueuse/integrations/useSortable/component'
import { UseAsyncValidator } from '@vueuse/integrations/useAsyncValidator/component'
```

Alias exports were deprecated in v14.0.0; use the original names (https://github.com/vueuse/vueuse/issues/5009).

## v15 breaking changes (from v14)

1. `useIDBKeyval` returns an object `{ data, isFinished, isSupported, set }`, not a ref (dist/useIDBKeyval.d.ts:46-51). `const count = useIDBKeyval('k', 0)` no longer compiles; destructure `data` instead.
2. `useIDBKeyval` syncs across tabs via `BroadcastChannel` by default; disable with `listenToStorageChanges: false` (dist/useIDBKeyval.js:60-76, https://github.com/vueuse/vueuse/pull/5338).
3. Node.js 20 dropped; requires Node >= 22 (https://github.com/vueuse/vueuse/releases/tag/v15.0.0).
4. `drauu` peer range widened to `^1 || ^0.4` (https://github.com/vueuse/vueuse/pull/5595).

Details and migration code: [migration reference](./references/migration-v14-to-v15.md).

## Quick examples

### useAxios

```ts
import { useAxios } from '@vueuse/integrations/useAxios'

// Awaits the whole result; rejects on error
const { data, error } = await useAxios('/api/posts')

// Manual trigger without firing immediately
const { execute } = useAxios('/api/posts', { method: 'GET' }, { immediate: false })

// Typed data via initialData (data becomes Ref<T> instead of Ref<T | undefined>)
const { data } = useAxios<User[]>('/api/users', undefined, { initialData: [] })
```

`execute()` accepts `url`, `config`, or both. Default options: `immediate` (true only when a url string is passed), `shallow: true`, `abortPrevious: true`, `resetOnExecute: false` (dist/useAxios.js:13-17,35).

### useIDBKeyval

```ts
import { useIDBKeyval } from '@vueuse/integrations/useIDBKeyval'

const { data: count, set } = useIDBKeyval('my-count', 0)
count.value++          // watched, persisted automatically
await set(10)          // explicit write, resolves after the IDB transaction
count.value = null     // deletes the key
```

### useSortable

```ts
import { useSortable } from '@vueuse/integrations/useSortable'

const list = ref(['a', 'b', 'c'])
const { start, stop, option } = useSortable(el, list, {
  watchElement: true, // reinitialize when el appears/disappears (v-if)
})
```

The default `onUpdate` handler moves the array element for you (dist/useSortable.js:14-16). Pass your own `onUpdate` to override; use `moveArrayElement(list, from, to, e)` for manual moves.

### useFocusTrap

```ts
import { useFocusTrap } from '@vueuse/integrations/useFocusTrap'

const target = useTemplateRef<HTMLElement>('modal')
const { activate, deactivate, hasFocus } = useFocusTrap(target, { immediate: true })

async function open() {
  show.value = true
  await nextTick() // wait for v-if to render the element
  activate()
}
```

Container element changes are tracked automatically; the returned object is `{ hasFocus, isPaused, activate, deactivate, pause, unpause }` with no `updateContainerElements` (dist/useFocusTrap.js:37-66).

### useCookies

```ts
import { useCookies } from '@vueuse/integrations/useCookies'

const { get, set, remove } = useCookies(['token'], { autoUpdateDependencies: true })
```

For SSR, build the composable from the request with `createCookies(req)` (dist/useCookies.d.ts:4-9). In Nuxt, import explicitly to avoid clashing with Nuxt's `useCookie`.

### useFuse

```ts
import { useFuse } from '@vueuse/integrations/useFuse'

const search = ref('')
const { results } = useFuse(search, data, {
  fuseOptions: { keys: ['title'] },
  resultLimit: 10,
  matchAllWhenSearchEmpty: true,
})
```

### Remaining wrappers

```ts
useChangeCase('hello world', 'camelCase')   // writable computed; type must match a change-case *Case export
useDrauu(svgEl, { brush: { color: 'red' } }) // target must be an <svg> element
useJwt(token)                                // { header, payload } with fallbackValue on decode error
useNProgress()                               // { isLoading, progress, start, done, remove }
useQRCode('https://vueuse.org')              // ShallowRef<string> of a data URL
useAsyncValidator(form, rules, { manual: true }) // thenable; { pass, errors, execute }
```

See [usage patterns](./references/usage-patterns.md) before writing non-trivial code with `useDrauu`, `useNProgress`, `useQRCode`, or `useAsyncValidator`.

## Environment limits

- Vue `^3.5.0` peer (package.json:68).
- ESM-only; no CommonJS build since v13.0.0 (https://github.com/vueuse/vueuse/releases/tag/v13.0.0).
- Node >= 22 (package.json:53).
- `useQRCode` renders only in the browser (`isClient` guard, dist/useQRCode.js:16).
- `useIDBKeyval` tab sync needs `BroadcastChannel`; `isSupported` reports it (dist/useIDBKeyval.js:18).
