# Mutations

`@pinia/colada` 1.4.5 mutation API. Types: `dist/index.d.mts:1188-1570`.

Docs: https://pinia-colada.esm.dev/guide/mutations.md

## `useMutation(options)`

```ts
const { mutate, mutateAsync, isLoading, data, error, variables, reset }
  = useMutation({
    onMutate(vars) { return { context: true } },  // declare before `mutation`
    mutation: (vars, context) => patchContact(vars),
    async onSettled(_data, _error, vars) {
      await queryCache.invalidateQueries({ key: ['contacts', vars.id], exact: true })
    },
  })
```

### Options

| Option | Notes |
| --- | --- |
| `mutation` | `(vars, context) => Promise<TData>`, required (`dist/index.d.mts:1397`) |
| `key` | optional `EntryKey` or `(vars) => EntryKey`; needed to find the mutation later via `mutationCache.getEntries()` (`dist/index.d.mts:1403`) |
| `onMutate` | runs first; return value becomes `context` for all later hooks; awaited if it returns a promise. Place it before `mutation` so `TContext` is inferred (`dist/index.d.mts:1410-1438`) |
| `onSuccess(data, vars, context)` | runs after the request succeeds |
| `onError(error, vars, context)` | context properties from `onMutate` may be `undefined` here if `onMutate` threw (`dist/index.d.mts:1451-1464`) |
| `onSettled(data, error, vars, context)` | runs last in both outcomes |
| `gcTime` | default `60_000`; `false` disables collection (`dist/index.d.mts:1381`) |
| `meta` | stored on the entry for plugins (added 1.1.0) |

Global hooks and extra context can be injected app-wide by augmenting
`UseMutationGlobalContext` and returning values from a global `onMutate`
(`dist/index.d.mts:1204-1222`).

### Return values

`state`, `status`, `asyncStatus`, `data`, `error`, `isLoading`, `variables`
(last vars passed), `mutate`, `mutateAsync`, `reset` (`dist/index.d.mts:1223-1272`).

- `mutate(vars)` returns void and never rejects; use it in templates.
- `mutateAsync(vars)` returns `Promise<TData>` and rejects on error.
- With `TVars = void`, both take no arguments.

## `defineMutation` and `defineMutationOptions`

`defineMutation` mirrors `defineQuery`: options form and setup form, reusable
across components (`dist/index.d.mts:1510-1532`):

```ts
const useCreateTodo = defineMutation(() => {
  const todoText = ref('')
  const { data, mutate, ...rest } = useMutation({
    mutation: () => createTodo(todoText.value),
  })
  return { ...rest, createTodo: mutate, todo: data, todoText }
})
```

`defineMutationOptions` (added 1.2.0) tags the mutation key with `TData` for
type-safe cache access, same as `defineQueryOptions`
(`dist/index.d.mts:1554-1569`). Pass its result directly:
`useMutation(setupOptions(params))`.

## Invalidating queries after a mutation

The standard flow: await invalidation in `onSettled` so the mutation stays
loading until related queries refetched:

```ts
useMutation({
  mutation: patchContact,
  async onSettled(_d, _e, { id }) {
    await queryCache.invalidateQueries({ key: ['contacts', id], exact: true })
  },
})
```

Invalidation details: [query-cache.md](./query-cache.md).

## Optimistic updates

Update the cache in `onMutate`, roll back in `onError`. Complete pattern
(https://pinia-colada.esm.dev/guide/optimistic-updates.md):

```ts
const queryCache = useQueryCache()

const { mutate } = useMutation({
  mutation: (contactInfo: ContactInfo) => patchContact(contactInfo),
  onMutate(contactInfo) {
    const oldContact = queryCache.getQueryData<Contact>(['contact', contactInfo.id])!
    const newContact = { ...oldContact, ...contactInfo }
    queryCache.setQueryData(['contact', newContact.id], newContact)
    // stop in-flight queries from overwriting the optimistic value
    queryCache.cancelQueries({ key: ['contact', newContact.id] })
    return { oldContact, newContact }
  },
  onSettled(_d, _e, vars, { newContact }) {
    if (newContact)
      queryCache.invalidateQueries({ key: ['contact', newContact.id] })
  },
  onError(err, contactInfo, { newContact, oldContact }) {
    // roll back only if the cache still holds our optimistic value
    if (newContact === queryCache.getQueryData(['contact', contactInfo.id]))
      queryCache.setQueryData(['contact', contactInfo.id], oldContact)
  },
})
```

Rules of thumb:

- Check the cached value matches the optimistic one before rolling back;
  another mutation may have updated the cache meanwhile.
- Type-safe keys come from `defineQueryOptions` key factories; then
  `getQueryData` needs no manual type argument.
- For UI-level optimism (mutation collocated with the query), render
  `variables` while `isLoading` instead of touching the cache.
- If the mutation lives elsewhere, give it a `key` and read its state via
  `useMutationCache().getEntries({ key })`.
