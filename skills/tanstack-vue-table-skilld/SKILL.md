---
name: tanstack-vue-table-skilld
description: Use when writing, migrating, or debugging code that imports @tanstack/vue-table (TanStack Table v9 for Vue). Covers useTable with explicit tableFeatures, reactive ref/computed data, FlexRender rendering, atoms-based state, createTableHook conventions, and the v8-to-v9 breaking changes.
---

# @tanstack/vue-table 9.2.4

Headless table adapter for Vue 3. Re-exports all of `@tanstack/table-core` 9.2.4 plus Vue bindings: `useTable`, `FlexRender`, `flexRender`, `createTableHook` (`dist/index.d.ts:4-5`).

Environment limits: `vue >=3.2` peer dependency, Node >=20, runtime dep `@tanstack/store ^0.11.1` (`package.json:34-53`).

This Skill targets v9 only. Code using `useVueTable`, `getCoreRowModel()`, or `onStateChange` is v8; migrate it first with [Migration v8 to v9](./references/migration-v8-to-v9.md).

## Quick start

```vue
<script setup lang="ts">
import { ref } from 'vue'
import { FlexRender, tableFeatures, useTable } from '@tanstack/vue-table'

type Person = { name: string; age: number }
const features = tableFeatures({})
const columns = [
  { accessorKey: 'name', header: 'Name' },
  { accessorKey: 'age', header: 'Age' },
]
const data = ref<Person[]>([{ name: 'Ada', age: 36 }])
const table = useTable({ features, columns, data })
</script>

<template>
  <table>
    <thead>
      <tr v-for="group in table.getHeaderGroups()" :key="group.id">
        <th v-for="header in group.headers" :key="header.id">
          <FlexRender v-if="!header.isPlaceholder" :header="header" />
        </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="row in table.getRowModel().rows" :key="row.id">
        <td v-for="cell in row.getAllCells()" :key="cell.id">
          <FlexRender :cell="cell" />
        </td>
      </tr>
    </tbody>
  </table>
</template>
```

Source: `skills/getting-started/SKILL.md` (shipped in the package).

## Add features explicitly

Every feature beyond core must be registered, and each row-model slot follows its prerequisite feature in the same `tableFeatures` call. The core row model is automatic; there is no `getCoreRowModel()` option.

```ts
import {
  createSortedRowModel,
  rowSortingFeature,
  sortFn_alphanumeric,
  tableFeatures,
} from '@tanstack/vue-table'

const features = tableFeatures({
  rowSortingFeature,
  sortedRowModel: createSortedRowModel(),
  sortFns: { alphanumeric: sortFn_alphanumeric },
})
```

APIs are feature-gated: a missing `table.atoms.pagination` means `rowPaginationFeature` was not registered. Full feature and slot list: [API surface](./references/api.md).

## State in one place per slice

State is atom-based. Read it inside a tracked boundary (template, `computed`, `watch`, or `table.Subscribe`); a bare read is only a snapshot.

```ts
const pageIndex = computed(() => table.atoms.pagination.get().pageIndex)
```

Controlled slices need a reactive `state` plus the matching `on[State]Change` callback that resolves value-or-function updaters:

```ts
const pagination = ref<PaginationState>({ pageIndex: 0, pageSize: 20 })
const state = computed(() => ({ pagination: pagination.value }))
const onPaginationChange = (next: PaginationState | ((old: PaginationState) => PaginationState)) => {
  pagination.value = typeof next === 'function' ? next(pagination.value) : next
}
// pass state and onPaginationChange to useTable
```

Own each slice exactly once: internal default, `initialState`, external `atoms`, or `state` + callback. Never both `atoms.pagination` and `state.pagination`. `onStateChange` no longer exists; observe `table.store` instead. Details: [API surface](./references/api.md).

## Rules that prevent most bugs

1. Pass `data` as a `ref`/`computed`, never `data.value` (`dist/useTable.d.ts:13-19`). Update it by replacing the array (`.value = [...]`); in-place `push`/`splice` is not tracked because writable atoms use `shallowRef` (`dist/reactivity.js:50-52`).
2. Keep `features` and `columns` stable; do not rebuild arrays per render.
3. Render through `FlexRender` shorthand: `:cell`, `:header`, `:footer`. The legacy `:render`/`:props` form still compiles but is the migration target, not the default (`dist/FlexRender.d.ts:28-41`).
4. Never destructure or spread row/cell/column/header methods; they are prototype methods using `this`. Use `row.getValue('name')`, not `const read = row.getValue`.
5. In JSX, pass `table.Subscribe` its render function as the explicit `children` prop; Vue JSX children become slots (`dist/useTable.d.ts:9-11`).
6. For server-driven tables set the `manual*` option (`manualPagination: true`) and pass `rowCount`.
7. Optional `stockFeatures` bundles everything; use it only as a temporary audit bridge, not production.

## Common mistakes

- HIGH: renaming `useVueTable` to `useTable` while keeping `getSortedRowModel` options. Move row models and registries into `tableFeatures` (`skills/migrate-v8-to-v9/SKILL.md:156-159`).
- HIGH: `useTable({ data: data.value })` freezes one snapshot; pass `data` (`skills/getting-started/SKILL.md:85-99`).
- HIGH: reading `table.atoms.sorting.get()` outside a tracked boundary; wrap in `computed` (`skills/table-state/SKILL.md:104-116`).
- HIGH: assigning the updater function itself (`pagination.value = next`) instead of resolving it first (`skills/table-state/SKILL.md:146-161`).
- HIGH: `columnPinning.left`/`right` no longer exist; v9 uses `start`/`end` logical pinning (`skills/migrate-v8-to-v9/SKILL.md:99-120`).
- HIGH: `createColumnHelper<Person>()` now needs features first: `createColumnHelper<typeof features, Person>()` (`skills/migrate-v8-to-v9/SKILL.md:147-148`).

## Reusable app conventions

For app-wide table defaults, use `createTableHook({ features, tableComponents, cellComponents, headerComponents })` to get `useAppTable`, `createAppColumnHelper`, and typed context hooks (`dist/createTableHook.d.ts:136-153`). Export the context hook with an explicit type to avoid circular inference when registered components import the hook module (`skills/create-table-hook/SKILL.md:62-84`).

## Integrations

- TanStack Query: manual pagination with reactive keys, `rowCount`, computed data passthrough. [Integrations](./references/integrations.md)
- TanStack Virtual: virtualize `table.getRowModel().rows`, never the source array. [Integrations](./references/integrations.md)

## References

- [API surface](./references/api.md): exports, subpaths, `useTable`/`Subscribe` types, features and slots, atoms model.
- [Migration v8 to v9](./references/migration-v8-to-v9.md): full breaking-change map, pinning renames, TypeScript changes, checklist.
- [Integrations](./references/integrations.md): TanStack Query and TanStack Virtual composition patterns.

## Also in the package

The package ships its own agent skills under `skills/` (getting-started, table-state, migrate-v8-to-v9, create-table-hook, with-tanstack-query, with-tanstack-virtual) and mentions `npx @tanstack/intent@latest install` to wire them into coding agents (`README.md:70-78`). Verify exact APIs in the installed `node_modules/@tanstack/vue-table/dist/index.d.ts`; do not reconstruct v9 from v8 memory.
