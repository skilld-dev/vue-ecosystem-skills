---
name: tanstack-vue-table-skilld
description: "Headless UI for building powerful tables & datagrids for Vue. ALWAYS use when writing code importing \"@tanstack/vue-table\". Consult for debugging, best practices, or modifying @tanstack/vue-table, tanstack/vue-table, tanstack vue-table, tanstack vue table, table."
metadata:
  version: 8.21.3
  generated_at: 2026-04-20
  references_synced_at: 2026-04-20
---

# TanStack/table `@tanstack/vue-table@8.21.3`
**Tags:** beta: 8.0.0-beta.9, latest: 8.21.3, alpha: 9.0.0-alpha.33

**References:** [Docs](./references/docs/_INDEX.md)
## API Changes

This section documents version-specific API changes — prioritize recent major/minor releases.

- BREAKING: `useVueTable` — v8 changed from `useTable`, must be explicitly imported from `@tanstack/vue-table` [source](./references/docs/framework/vue/vue-table.md)

- BREAKING: `FlexRender` component — v8 replaced `.render()` methods with PascalCase `FlexRender` component in Vue templates [source](./references/docs/framework/vue/vue-table.md)

- BREAKING: `accessorKey` and `accessorFn` — v8 renamed `accessor` to `accessorKey` (string) or `accessorFn` (function) [source](./references/docs/guide/migrating.md)

- BREAKING: `header`, `cell`, `footer` — v8 renamed `Header`, `Cell`, `Footer` column properties to lowercase [source](./references/docs/guide/migrating.md)

- BREAKING: `enable*` options — v8 renamed all `disable*` options to `enable*` (e.g., `enableSorting`, `enableFiltering`) [source](./references/docs/guide/migrating.md)

- BREAKING: `getValue()` — v8 changed `value` prop to `getValue()` function in cell/header render contexts for performance [source](./references/docs/guide/migrating.md)

- DEPRECATED: `getHeaderProps`, `getCellProps`, `getRowProps` — v8 removed automatic prop getters; keys and handlers must be manual [source](./references/docs/guide/migrating.md)

- NEW: Reactive `data` support — v8.20.0 added support for passing Vue `ref` or `computed` directly to `data` option [source](./references/docs/framework/vue/guide/table-state.md)

- NEW: `sortUndefined: 'first' | 'last'` — v8.16.0 added explicit `'first'` and `'last'` string options to `sortUndefined` [source](./references/docs/api/features/sorting.md)

- NEW: `_features` option — v8.14.0 introduced `_features` for extending table instances with custom logic [source](./references/docs/guide/custom-features.md)

- NEW: `firstPage()`, `lastPage()` — v8.13.0 added explicit pagination navigation APIs [source](./references/docs/guide/pagination.md)

- NEW: `rowCount` option — v8.13.0 added `rowCount` to automatically calculate `pageCount` for manual pagination [source](./references/docs/guide/pagination.md)

- NEW: `rowPinning` — v8.12.0 added row pinning state and `getTopRows()`, `getBottomRows()`, `getCenterRows()` APIs [source](./references/docs/guide/row-pinning.md)

- BREAKING: `sortingFn` signature — v8 changed to return `number` (-1, 0, 1) and only takes 2 rows plus column ID [source](./references/docs/api/features/sorting.md)

**Also changed:** `columnVisibility` state new v8 · `columnPinning` new v8 · `resetPageIndex()` new v8.13.0 · `resetPageSize()` new v8.13.0 · `shallowRef` internally for Vue v8.20.0

## Best Practices

- Use `useVueTable` with reactive data directly — pass a `ref` or `computed` to the `data` option to enable automatic table updates without manual triggers [source](./references/docs/framework/vue/guide/table-state.md)

- Update data by replacing the array `.value` — since `shallowRef` is used internally for performance, the table only reacts to top-level array mutations (e.g., `data.value = [...]`) rather than `push` or `splice` [source](./references/docs/framework/vue/guide/table-state.md)

- Use `createColumnHelper` for type-safe definitions — provides the highest level of TypeScript inference for accessor, display, and grouping columns [source](./references/docs/guide/column-defs.md)

```ts
const columnHelper = createColumnHelper<Person>()
const columns = [
  columnHelper.accessor('firstName', { cell: info => info.getValue() })
]
```

- Prefer `initialState` over `state` for simple defaults — use this when you don't need to control state externally to avoid the overhead of manual synchronization [source](./references/docs/framework/vue/guide/table-state.md)

- Use getters in `state` for controlled reactivity — when hoisting state into your own refs, wrap them in getters to ensure `useVueTable` correctly tracks reactive changes [source](./references/docs/framework/vue/guide/table-state.md)

```ts
const sorting = ref<SortingState>([])
const table = useVueTable({
  state: {
    get sorting() { return sorting.value }
  }
})
```

- Use `FlexRender` for all dynamic templates — essential for correctly rendering cell, header, and footer templates (strings, components, or JSX) within the Vue lifecycle [source](./references/docs/framework/vue/vue-table.md)

- Import only required row models to optimize bundle size — only provide the specific models needed for your features (e.g., `getSortedRowModel`) to avoid including unnecessary logic [source](./references/docs/guide/row-models.md)

- Set `manual*` options to `true` for server-side operations — prevents redundant client-side processing when sorting, pagination, or filtering is handled by the backend [source](./references/docs/guide/sorting.md)

- Use `'first'` or `'last'` for undefined sorting priority — explicitly control where nullable or undefined values appear during sorting using the `sortUndefined` option [source](./references/docs/guide/sorting.md)

- Always provide a unique `id` for `accessorFn` columns — required for stable column identification and feature state (sorting/filtering) when not using a simple `accessorKey` [source](./references/docs/guide/column-defs.md)
