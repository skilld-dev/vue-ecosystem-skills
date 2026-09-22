---
name: tanstack-vue-query-skilld
description: "Hooks for managing, caching and syncing asynchronous and remote data in Vue. ALWAYS use when writing code importing \"@tanstack/vue-query\". Consult for debugging, best practices, or modifying @tanstack/vue-query, tanstack/vue-query, tanstack vue-query, tanstack vue query, query."
---

# @tanstack/vue-query@5.103.2

Async data hooks for Vue. Version 5.103.2, prepared source at `input/source`.
Peer deps: `vue ^2.6.0 || ^3.3.0`; Vue 2 needs `@vue/composition-api` (optional peer) (`package.json:56-59`).
Re-exports everything from `@tanstack/query-core` 5.103.2, so `keepPreviousData`, `skipToken`, `focusManager`, `onlineManager`, hydration utils, and observer classes import from `@tanstack/vue-query` directly (`src/index.ts:1`).

## Setup

Install the plugin once per app. It creates (or accepts) a `QueryClient`, provides it app-wide, and mounts/unmounts it (`src/vueQueryPlugin.ts:74-154`):

```ts
import { createApp } from 'vue'
import { QueryClient, VueQueryPlugin } from '@tanstack/vue-query'

const app = createApp(App)

// Option A: pass your own client (required for SSR — one fresh client per request)
const queryClient = new QueryClient()
app.use(VueQueryPlugin, { queryClient })

// Option B: let the plugin build one with your defaults
app.use(VueQueryPlugin, {
  queryClientConfig: { defaultOptions: { queries: { staleTime: 5 * 1000 } } },
})
```

`VueQueryPluginOptions`: `queryClient` or `queryClientConfig` (one or the other), `queryClientKey` (only when installing multiple clients), `clientPersister` + `clientPersisterOnSuccess` (persisted cache restore), `enableDevtoolsV6Plugin` (`src/vueQueryPlugin.ts:11-38`). The client is not mounted on the server (`src/vueQueryPlugin.ts:87-89`).

`useQueryClient(id?)` throws outside an injection context or without the plugin (`src/useQueryClient.ts:27-44`).

## Basic query

```vue
<script setup lang="ts">
import { ref } from 'vue'
import { useQuery } from '@tanstack/vue-query'

const postId = ref(1)
const { status, data, error, refetch } = useQuery({
  queryKey: ['post', postId],          // ref inside the key: tracked, no .value
  queryFn: () => fetchPost(postId.value),
})
</script>

<template>
  <span v-if="status === 'pending'">Loading...</span>
  <span v-else-if="status === 'error'">Error: {{ error!.message }}</span>
  <h1 v-else>{{ data!.title }}</h1>
</template>
```

## Basic mutation

```vue
<script setup lang="ts">
import { useMutation, useQueryClient } from '@tanstack/vue-query'

const queryClient = useQueryClient()
const addMutation = useMutation({
  mutationFn: addTodo,
  onSuccess: () => queryClient.invalidateQueries({ queryKey: ['todos'] }),
})

function onAdd() {
  addMutation.mutate('Item', {
    onError: (error) => console.error('Failed:', error),
  })
}
</script>

<template>
  <button @click="onAdd">Add</button>
</template>
```

`mutate` swallows rejection by design; per-call callbacks fire only for the latest call. Use `mutateAsync` for a promise per call (`src/useMutation.ts:262-270`).

## Rules that catch Vue developers

- **Returns are `Ref`s.** Every result field of `useQuery`/`useInfiniteQuery`/`useMutation` is a `Ref` (`data.value` in script, auto-unwrapped in template), except the functions `refetch`, `fetchNextPage`, `fetchPreviousPage`, `mutate`, `mutateAsync`, `reset`, plus `suspense()` (`src/useBaseQuery.ts:27-40`, `src/useMutation.ts:53-68`).
- **`useQueries` returns one `Ref`** of the whole result array (or the `combine` value), not a reactive array (`src/useQueries.ts:357-376`).
- **Never unwrap refs for the query key.** Put the `ref` itself into `queryKey` and read `.value` inside `queryFn` (`src/utils.ts:84-111`).
- **Only `queryKey` and `enabled` accept reactive getters.** A function anywhere else is the real callback (`queryFn`, `select`, ...). To make any option reactive, pass a whole-options getter `useQuery(() => ({ ... }))` (`src/queryOptions.ts:67-76`, `src/useQuery.ts:225-227`).
- **`initialData` is not reactive**; it is read once (`src/queryOptions.ts:136-148`).
- **Call composables in `setup()` or an `effectScope`.** Outside a scope, dev mode warns about memory leaks (`src/useBaseQuery.ts:82-88`).
- **Imperative fetches go through `queryClient.query()` / `queryClient.infiniteQuery()`.** `fetchQuery`, `prefetchQuery`, `fetchInfiniteQuery`, `prefetchInfiniteQuery`, `ensureQueryData` are deprecated and slated for removal (`src/queryClient.ts:251-253`, `src/queryClient.ts:311-313`).
- **Declare shared queries with `queryOptions()`** so the key carries its data type for `getQueryData`, `invalidateQueries`, and prefetch reuse (`src/queryOptions.ts:244-251`).

## Environment limits

- Prepared source: `@tanstack/vue-query` 5.103.2 with `@tanstack/query-core` 5.103.2 (`package.json:2,45`). Docs match v5; v4 APIs may appear in old examples.
- Vue 3.3+ for Vue 3; Vue 2.6+ with `@vue/composition-api`, or Vue 2.7 native (`package.json:52-59`).
- ESM-first dual build (`build/modern`, `build/legacy`); `sideEffects: false` (`package.json:21-35`).

## References

- [references/api.md](./references/api.md) — every export, its signature, and where it lives in the source.
- [references/reactivity.md](./references/reactivity.md) — refs, getters, `skipToken`, `queryOptions` getters, `shallow`.
- [references/query-client.md](./references/query-client.md) — Vue `QueryClient`, reactive args, invalidation timing, SSR, multiple clients.
- [references/mutations.md](./references/mutations.md) — mutations, `mutationOptions`, `useMutationState`, optimistic updates.
- [references/migration.md](./references/migration.md) — v5 breaking changes and version-specific rules since 5.90.

Official docs: https://tanstack.com/query/latest/docs/framework/vue/overview
