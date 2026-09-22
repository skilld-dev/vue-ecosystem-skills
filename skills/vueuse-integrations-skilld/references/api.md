# API surface — @vueuse/integrations 15.0.0

Every entry below is verified against the prepared `dist/` type definitions and implementations. Import each from its submodule (`@vueuse/integrations/useX`) for tree-shaking; the root export re-exports everything (dist/index.d.ts:1-13).

## useAsyncValidator

Wrapper for `async-validator`. Peer: `async-validator@^4`.

```ts
import { useAsyncValidator } from '@vueuse/integrations/useAsyncValidator'

function useAsyncValidator(
  value: MaybeRefOrGetter<Record<string, any>>,
  rules: MaybeRefOrGetter<Rules>,
  options?: UseAsyncValidatorOptions,
): UseAsyncValidatorReturn & PromiseLike<UseAsyncValidatorReturn>
```

- Options (dist/useAsyncValidator.d.ts:22-38): `validateOption` (async-validator `ValidateOption`), `immediate` (default `true`; first validation runs immediately unless `manual`), `manual` (disable automatic revalidation on value/rule change).
- Return: `pass`, `isFinished` (ShallowRef), `errors`, `errorFields` (ComputedRef, empty defaults), `errorInfo` (ShallowRef of the raw error), `execute(): Promise<UseAsyncValidatorExecuteReturn>`.
- The whole return is thenable; awaiting resolves the shell after validation finishes (dist/useAsyncValidator.js:58-68).
- Rules are recompiled into a `Schema` whenever `rules` change (dist/useAsyncValidator.js:26).

Component: `UseAsyncValidator` with props `form`, `rules`, `options`; default slot receives the reactive return (dist/useAsyncValidator/component.d.ts:5-15).

## useAxios

Wrapper for `axios`. Peer: `axios@^1`.

Overloads (dist/useAxios.d.ts:96-104):

```ts
useAxios(url, config?, options?)                       // StrictUseAxiosReturn
useAxios(url, instance?, options?)                     // AxiosInstance instead of config
useAxios(url, config, instance, options?)
useAxios(config?)                                      // EasyUseAxiosReturn, no url yet
useAxios(instance?)
```

- Instance detection uses a `request` property check, not `instanceof` (dist/useAxios.js:21-29).
- `immediate` defaults to true only when a url string was passed (dist/useAxios.js:13-14). Without a url, nothing fires and `execute(url, config?)` is required.
- Return: `response` (ShallowRef), `data`, `isFinished`, `isLoading`, `isAborted`, `error`, `abort(message?)`, `cancel` (alias of `abort`), `isCanceled` (alias of `isAborted`), `execute`.
- `data` is `Ref<T>` when `initialData` is provided, otherwise `Ref<T | undefined>` (dist/useAxios.d.ts:12).
- Options (dist/useAxios.d.ts:54-95): `immediate`, `shallow` (default `true`), `abortPrevious` (default `true`), `onError`, `onSuccess`, `resetOnExecute` (default `false`), `onFinish`, `initialData`.
- Thenable: `await useAxios(...)` resolves the return object, rejects with the caught error value (dist/useAxios.js:62-68). `execute` returns the same thenable.
- `abort()` only acts while a request is loading (dist/useAxios.js:44-51).

## useChangeCase

Reactive wrapper for `change-case`. Peer: `change-case@^5`.

```ts
function useChangeCase(
  input: MaybeRef<string>, type: MaybeRefOrGetter<ChangeCaseType>, options?,
): WritableComputedRef<string>
function useChangeCase(
  input: MaybeRefOrGetter<string>, type: MaybeRefOrGetter<ChangeCaseType>, options?,
): ComputedRef<string>
```

- `ChangeCaseType` is any exported change-case function name ending in `Case` (`camelCase`, `snakeCase`, `paramCase`, ...) (dist/useChangeCase.d.ts:5-8).
- An invalid type throws `Invalid change case type` on read (dist/useChangeCase.js:18).
- Ref input gives a writable computed (assignment stores the raw value); getter input gives a read-only computed (dist/useChangeCase.js:21-30).
- Options are change-case `Options` (`locale`, `split`).

## useCookies

Wrapper for `universal-cookie`. Peer: `universal-cookie@^7 || ^8`.

```ts
function createCookies(req?: IncomingMessage): (dependencies?, options?, ) => CookiesReturn
function useCookies(dependencies?: string[] | null, options?, cookies?: Cookie): CookiesReturn
```

- Return: `get(name, options?)`, `getAll(options?)`, `set(name, value, options?)`, `remove(name, options?)`, `addChangeListener(cb)`, `removeChangeListener(cb)` (dist/useCookies.d.ts:37-53).
- Options: `doNotParse` (default `false`; skip JSON parsing), `autoUpdateDependencies` (default `false`; every name passed to `get` joins the watch list) (dist/useCookies.js:28).
- Reactivity model: a `touches` counter increments when a change event affects a watched dependency; `get`/`getAll` read it to register as dependencies of your computed/effect (dist/useCookies.js:34-58). Pass `null` (or omitted) `dependencies` to watch all cookies; pass `[]` to watch none.
- SSR: use `createCookies(req)` so cookies come from request headers instead of `document` (dist/useCookies.js:11-17).

## useDrauu

Reactive instance for `drauu`. Peer: `drauu@^1 || ^0.4` (v15 range).

```ts
function useDrauu(target: MaybeComputedElementRef, options?: UseDrauuOptions): UseDrauuReturn
```

- `UseDrauuOptions = Omit<Drauu.Options, 'el'>`; the element comes from `target` (dist/useDrauu.d.ts:5).
- The target must be an `SVGSVGElement`; other elements are ignored (dist/useDrauu.js:79-80).
- Default brush: `{ color: 'black', size: 3, mode: 'draw', fill: 'transparent', arrowEnd: false, cornerRadius: 0 }` merged with `options.brush` (dist/useDrauu.js:25-34).
- Return: `drauuInstance`, `load(svg)`, `dump()`, `clear()`, `cancel()`, `undo()`, `redo()`, `canUndo`, `canRedo`, `brush` (reactive; changes sync to the instance), event hooks `onChanged`, `onCommitted`, `onStart`, `onEnd`, `onCanceled` (dist/useDrauu.d.ts:6-22).
- Instance is created (or recreated) whenever the resolved element changes, watcher flush `post` (dist/useDrauu.js:79-97).

## useFocusTrap

Reactive wrapper for `focus-trap`. Peer: `focus-trap@^7 || ^8`.

```ts
function useFocusTrap(
  target: MaybeRefOrGetter<Arrayable<MaybeRefOrGetter<string> | MaybeComputedElementRef>>,
  options?: UseFocusTrapOptions,
): UseFocusTrapReturn
```

- `UseFocusTrapOptions` extends focus-trap `Options` with `immediate` (activate right away) (dist/useFocusTrap.d.ts:5-10).
- Return: `hasFocus`, `isPaused` (ShallowRef), `activate(opts?)`, `deactivate(opts?)`, `pause()`, `unpause()` (dist/useFocusTrap.d.ts:11-46). There is no `updateContainerElements` on the return in v15.
- Target accepts selectors, element refs, component refs, arrays, or getters. Resolved elements are watched (`flush: 'post'`); on change the trap calls `updateContainerElements` internally, creating the trap on first non-empty value (dist/useFocusTrap.js:30-57).
- Deactivates automatically on scope dispose (dist/useFocusTrap.js:58).

Component: `UseFocusTrap` with prop `options`; renders default slot scoped with the reactive return (dist/useFocusTrap/component.d.ts:5-17). `ComponentUseFocusTrapOptions` is deprecated.

## useFuse

Fuzzy search with Fuse.js. Peer: `fuse.js@^7`.

```ts
function useFuse<DataItem>(
  search: MaybeRefOrGetter<string>,
  data: MaybeRefOrGetter<DataItem[]>,
  options?: MaybeRefOrGetter<UseFuseOptions<DataItem>>,
): UseFuseReturn<DataItem>
```

- Options: `fuseOptions` (`IFuseOptions`, deep-watched; the `Fuse` instance is recreated on change), `resultLimit`, `matchAllWhenSearchEmpty` (return all items with `refIndex` instead of searching) (dist/useFuse.d.ts:5-9, dist/useFuse.js:5-15).
- Data changes call `setCollection` and `triggerRef` so `fuse` consumers update (dist/useFuse.js:16-19; fix landed in v14.4.0, https://github.com/vueuse/vueuse/pull/5479).
- Return: `fuse` (ShallowRef of the instance), `results` (ComputedRef of `FuseResult<DataItem>[]`).

## useIDBKeyval

Wrapper for `idb-keyval`. Peer: `idb-keyval@^6`. Breaking in v15: returns an object, syncs across tabs.

```ts
function useIDBKeyval<T>(
  key: IDBValidKey,
  initialValue: MaybeRefOrGetter<T>,
  options?: UseIDBOptions<T>,
): UseIDBKeyvalReturn<T> // { data: RemovableRef<T>, isFinished, isSupported, set }
```

- Options (dist/useIDBKeyval.d.ts:9-45): `flush` (default `'pre'`), `deep` (default `true`), `shallow` (default `false`), `onError` (default logs to `console.error`), `writeDefaults` (default `true`; persist initial value when the key is absent), `listenToStorageChanges` (default `true`; v15 BroadcastChannel sync), `serializer` (`{ read, write }`, identity by default), `window`.
- Setting `data.value` to `null` deletes the key and broadcasts the delete (dist/useIDBKeyval.js:40-42,68).
- `set(value)` writes without triggering the internal watcher twice and resolves after the IDB write (dist/useIDBKeyval.js:77-82).
- `isSupported` reflects `BroadcastChannel` availability, which gates tab sync (dist/useIDBKeyval.js:18,60).

## useJwt

Wrapper for `jwt-decode`. Peer: `jwt-decode@^4`.

```ts
function useJwt<Payload = JwtPayload, Header = JwtHeader, Fallback = null>(
  encodedJwt: MaybeRefOrGetter<string>,
  options?: UseJwtOptions<Fallback>,
): { header: ComputedRef<Header | Fallback>, payload: ComputedRef<Payload | Fallback> }
```

- Options: `fallbackValue` (default `null`) returned when decoding throws, `onError(error)` called with the decode exception (dist/useJwt.d.ts:4-15, dist/useJwt.js:10-18).
- Decoding is not verification; `jwt-decode` only reads claims.

## useNProgress

Reactive wrapper for `nprogress`. Peer: `nprogress@^0.2`.

```ts
function useNProgress(
  currentProgress?: MaybeRefOrGetter<number | null | undefined>,
  options?: UseNProgressOptions,
): UseNProgressReturn
```

- `UseNProgressOptions = Partial<NProgressOptions>` passed to `nprogress.configure` (dist/useNProgress.js:16).
- Return: `isLoading` (writable computed: `true` starts, `false` completes; reads as `progress < 1`), `progress` (Ref), `start`, `done(force?)`, `remove` (dist/useNProgress.d.ts:5-11).
- Wraps the global `nprogress` singleton; `nprogress.set` is patched so all setters update `progress` (dist/useNProgress.js:17-21). `remove()` runs on scope dispose.

## useQRCode

Wrapper for `qrcode`. Peer: `qrcode@^1.5`.

```ts
function useQRCode(
  text: MaybeRefOrGetter<string>,
  options?: QRCode.QRCodeToDataURLOptions,
): ShallowRef<string>
```

- Returns a data-URL string ref, `''` until the first async render resolves; renders only on the client (dist/useQRCode.js:12-19).
- Options are `toDataURL` options: `margin`, `width`, `color.dark`, `color.light`, `errorCorrectionLevel`.

## useSortable

Wrapper for `sortablejs`. Peer: `sortablejs@^1`.

```ts
function useSortable<T>(selector: string, list: MaybeRef<T[]>, options?): UseSortableReturn
function useSortable<T>(el: MaybeRefOrGetter<MaybeElement>, list: MaybeRef<T[]>, options?): UseSortableReturn
```

- `UseSortableOptions` extends `Sortable.Options` with `document` (ConfigurableDocument) and `watchElement` (default `false`) (dist/useSortable.d.ts:21-35).
- Return: `start()`, `stop()` (destroy), `option(name, value?)` getter/setter (dist/useSortable.d.ts:5-20).
- Default `onUpdate` calls `moveArrayElement(list, e.oldIndex, e.newIndex, e)` so the array follows the DOM; user-supplied `onUpdate` replaces it (dist/useSortable.js:14-16,23-27).
- `watchElement: true` watches the resolved element (`flush: 'post'`, immediate) and reinitializes on change; it does nothing for string selectors (dist/useSortable.js:37-43).
- Helpers: `insertNodeAt(parent, element, index)`, `removeNode(node)`, `moveArrayElement(list, from, to, e?)` (dist/useSortable.js:65-91). With `e` passed, the DOM move Sortable made is reverted and re-applied after the array settles inside `nextTick`.

Component: `UseSortable` with props `modelValue`, `options`; slot scoped with the reactive return (dist/useSortable/component.d.ts:5-14).

## Root exports

`dist/index.d.ts` re-exports all composables plus helpers `createCookies`, `insertNodeAt`, `moveArrayElement`, `removeNode`, and every interface listed above. Prefer submodule imports anyway.
