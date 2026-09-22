# Mutations

`useMutation`, `mutationOptions`, `useMutationState`, and `useIsMutating` in `@tanstack/vue-query` 5.103.2. Guide: https://tanstack.com/query/latest/docs/framework/vue/guides/mutations

## `useMutation(options, queryClient?)`

`options` is a plain object, `MaybeRefDeep` (refs deep), or a getter re-evaluated on reactive change (`src/useMutation.ts:31-41, 249-252`). Result is `ToRefs` of the observer result plus three functions (`src/useMutation.ts:53-68`):

- `mutate(variables, perCallCallbacks?)` — fire and track via state; swallows rejection, so pass `onError` per call or use the hook-level callback (`src/useMutation.ts:262-270`).
- `mutateAsync(variables)` — a real promise per invocation; use `Promise.allSettled` to survive independent failures (`src/useMutation.ts:171-229` examples).
- `reset()` — clears the observer result.

State fields are refs: `isPending.value`, `error.value` (`src/useMutation.ts:125-131` example).

Four generics: `TData`, `TError`, `TVariables`, `TOnMutateResult`. Whatever `onMutate` returns is passed to `onError`/`onSettled` as the third argument (`src/useMutation.ts:144-158`).

Per-call callbacks passed to `mutate` fire only for the latest call; hook-level callbacks fire for every mutation (`src/useMutation.ts:82-85`).

## `mutationOptions(options)`

Identity helper like `queryOptions`. The overload with a required `mutationKey` exists so the mutation can be found later by `useMutationState` filters; a no-key overload covers the rest. Getter overloads keep `mutationFn` reactive over props (`src/mutationOptions.ts:34-182`).

```ts
const createPostOptions = mutationOptions(() => ({
  mutationKey: ['posts', 'create'],
  mutationFn: (title: string) => createPost({ title, userId: props.userId }),
}))
const mutation = useMutation(createPostOptions)
```

## `useMutationState(options?, queryClient?)`

`Readonly<Ref<Array<TResult>>>` over the whole `MutationCache`, narrowed by `filters: MutationFilters` and shaped by `select` (`src/useMutationState.ts:196-227`). Each `mutate` call adds a cache entry for `gcTime` milliseconds; with `status: 'success'`, the last array item is the latest success (`src/useMutationState.ts:176-194`).

```ts
const savedPosts = useMutationState({
  filters: { mutationKey: ['posts'], status: 'success' },
  select: (mutation) => mutation.state.data,
})
```

## `useIsMutating(filters?, queryClient?)`

`Ref<number>` of pending mutations, built on `useMutationState` with `status: 'pending'` (`src/useMutationState.ts:53-79`). Use for app-wide saving indicators.

## Optimistic updates

Standard pattern from the source example (`src/useMutation.ts:134-168`):

```ts
const addMutation = useMutation({
  mutationFn: addTodo,
  onMutate: async (newTodo: string) => {
    await queryClient.cancelQueries({ queryKey: ['todos'] })
    const previousTodos = queryClient.getQueryData<Array<string>>(['todos'])
    queryClient.setQueryData<Array<string>>(['todos'], (old) => [...(old ?? []), newTodo])
    return { previousTodos } // -> onError's third arg
  },
  onError: (_err, _newTodo, onMutateResult) => {
    queryClient.setQueryData(['todos'], onMutateResult?.previousTodos)
  },
  onSettled: () => {
    queryClient.invalidateQueries({ queryKey: ['todos'] })
  },
})
```

Guide: https://tanstack.com/query/latest/docs/framework/vue/guides/optimistic-updates

## Paused mutations and offline

`networkMode: 'offlineFirst'` (default for mutations) pauses mutations while offline; they resume on reconnect. Key the mutation with `setMutationDefaults` so a persisted paused mutation can replay its `mutationFn` after reload. Guide: https://tanstack.com/query/latest/docs/framework/vue/guides/mutations#paused-mutations
