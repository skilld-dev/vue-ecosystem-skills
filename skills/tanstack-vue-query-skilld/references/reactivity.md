# Reactivity model

How `@tanstack/vue-query` 5.103.2 tracks Vue reactive state. Official guide: https://tanstack.com/query/latest/docs/framework/vue/reactivity

## How options are resolved

Each composable wraps its options in a `computed`. On every re-evaluation it calls `cloneDeepUnref`, which deep-clones the options and unwraps every `ref` it meets (`src/utils.ts:84-111`, `src/useBaseQuery.ts:92-116`):

- Inside `queryKey`, getters are called too: `queryKey: ['post', () => id.value]` works, as do ref entries (`src/utils.ts:88-95`).
- `enabled` may be a ref, plain boolean, or getter; a getter is called during resolution (`src/useBaseQuery.ts:99-101`).
- Other options unwrap refs but keep functions as functions — a function is the callback itself, except in the whole-options-getter form below (`src/queryOptions.ts:67-76`).

## The three input styles

```ts
// 1. Plain object with reactive pieces
useQuery({
  queryKey: ['post', postId],            // ref tracked
  queryFn: () => fetchPost(postId.value),
  enabled: () => postId.value != null,   // getter tracked
})

// 2. Ref/computed of the whole options object
const options = computed(() => ({ queryKey: ['post', id.value], queryFn: ... }))
useQuery(options)

// 3. Whole-options getter: everything inside is re-evaluated on change
useQuery(() => ({
  queryKey: ['post', props.id],
  queryFn: () => fetchPost(props.id),
  staleTime: props.staleTime,            // reactive too, unlike style 1
}))
```

Style 3 is the only way to make `staleTime`, `retry`, `select`, or a `skipToken`-switching `queryFn` reactive, because a bare getter at those positions would be interpreted as the callback (`src/useQuery.ts:216-280`, `src/queryOptions.ts:74-82`). The `computed` re-runs the composable's options watcher with the new values (`src/useBaseQuery.ts:143-148`).

## Derived state and props

Property access on a `reactive` props object loses tracking when captured once. Use a `computed`, a getter entry in the key, or the whole-options getter (`src/useQuery.ts:140-143` uses `props.postId` in the key with an `enabled` getter; the reactivity guide recommends `computed(() => props.userId)`).

For wrappers, accept `MaybeRefOrGetter<T>` so callers can pass values, refs, or getters (`src/types.ts:39`):

```ts
function useUserProjects(userId: MaybeRefOrGetter<string>) {
  return useQuery({
    queryKey: ['projects', userId],
    queryFn: () => fetchProjects(toValue(userId)),
  })
}
```

## `skipToken` for conditional queries

Type-safe disabling without `!` assertions; `queryFn` is only called when not `skipToken`. Needs the whole-options-getter form so the switch re-evaluates (`src/useQuery.ts:253-280`):

```ts
useQuery(() => {
  const postId = props.postId
  return {
    queryKey: ['post', postId],
    queryFn: postId != null ? () => fetchPost(postId) : skipToken,
  }
})
```

`refetch` does nothing while `queryFn` is `skipToken`; use `enabled: false` if you must trigger manually (`src/useQuery.ts:256-258`). `queryFn` can also be a `computed`, never a bare getter (`src/useQuery.ts:257`).

## `queryOptions` getter overload

`queryOptions(() => ({ ... }))` returns a function (`src/queryOptions.ts:253-298`):

```ts
const postOptions = queryOptions(() => ({
  queryKey: ['post', postId.value],
  queryFn: () => fetchPost(postId.value),
}))

useQuery(postOptions)                      // pass the getter: stays reactive
queryClient.invalidateQueries(postOptions()) // call it: one-shot reads current values
```

`mutationOptions` and `infiniteQueryOptions` have the same getter overloads (`src/mutationOptions.ts:80-93`, `src/infiniteQueryOptions.ts:99-120`).

## Non-reactive pieces

- `initialData` is read once at observer creation and is not re-evaluated on ref changes (`src/queryOptions.ts:136-148`).
- `select` re-runs only when `data` changes or the `select` reference changes. An inline `select` in `setup()` is stable; one created inside a whole-options getter is recreated on each re-evaluation (`src/queryOptions.ts:78-82`).

## `shallow`

`shallow: true` (on query options, mutation options, or `useQueries`) keeps the result state `shallowReactive`/`shallowReadonly`, avoiding deep reactivity on large payloads (`src/types.ts:78-83`, `src/useBaseQuery.ts:120-122`, `src/useQueries.ts:476-478`).

## Scope requirements

Composables subscribe and dispose via `onScopeDispose`. Called outside `setup()`/`effectScope`, they leak and warn in dev (`src/useBaseQuery.ts:82-88`, `150-152`). Inside an injection context (e.g. router guards) they work, but must run in an `effectScope` (v5 change, see [migration.md](./migration.md)).
