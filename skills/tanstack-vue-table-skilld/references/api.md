# API surface (v9.2.4)

All facts below are from the prepared package source. Paths are relative to the package root.

## Entry points (`package.json:26-32`)

| Import path | Provides |
| --- | --- |
| `@tanstack/vue-table` | all of `@tanstack/table-core` plus `useTable`, `FlexRender`, `FlexRenderCell`, `FlexRenderHeader`, `flexRender`, `createTableHook`, `VueTable`, `TableOptionsWithReactiveData`, `App*` types (`dist/index.d.ts:4-5`) |
| `@tanstack/vue-table/flex-render` | `FlexRender`, `FlexRenderCell`, `FlexRenderHeader`, `flexRender` only |
| `@tanstack/vue-table/static-functions` | re-export of table-core static functions (`dist/static-functions.d.ts:1`) |
| `@tanstack/vue-table/experimental-worker-plugin` | re-export of table-core experimental worker plugin (`dist/experimental-worker-plugin.d.ts:1`) |

Use the `/flex-render` subpath when a module only renders and should not pull the adapter.

## `useTable`

```ts
declare function useTable<TFeatures extends TableFeatures, TData extends RowData>(
  tableOptions: TableOptions<TFeatures, TData> | TableOptionsWithReactiveData<TFeatures, TData>
): VueTable<TFeatures, TData>
```

`dist/useTable.d.ts:32`. Every option accepts a Vue `ref`/`computed` (`MaybeRef`); the adapter unwraps inputs, watches them with synchronous flushing, and re-syncs options on change (`dist/useTable.d.ts:13-19`, `dist/useTable.js:49-51`). It also injects a `coreReactivityFeature` backing atoms with Vue `computed`/`shallowRef` (`dist/useTable.js:39-42`, `dist/reactivity.js:34-56`). Setup runs inside the current scope and auto-disposes (`dist/useTable.js:48`).

## `VueTable` and `Subscribe`

`VueTable` is `Table` plus a `Subscribe` component that creates a reactive render boundary; the child function reads only the atoms it needs (`dist/useTable.d.ts:5-12`).

```tsx
table.Subscribe({
  children: (atoms) => <span>{atoms.pagination.get().pageIndex + 1}</span>,
})
```

In Vue JSX the render function must be the explicit `children` prop; slot children do not work (`skills/table-state/SKILL.md:167-187`).

## `FlexRender` and `flexRender`

```vue
<FlexRender :cell="cell" />
<FlexRender :header="header" />
<FlexRender :footer="header" />
<!-- legacy, still compiles -->
<FlexRender :render="cell.column.columnDef.cell" :props="cell.getContext()" />
```

Props: `cell`, `header`, `footer` (shorthand) or `render` + `props` (legacy) (`dist/FlexRender.d.ts:42-60`). For custom markup in render functions, use `flexRender(cell.column.columnDef.cell, cell.getContext())` instead of `cell.getValue()` (`dist/FlexRender.d.ts:22-26`).

## Features and slots

`tableFeatures({...})` is required; APIs are feature-gated. Feature imports (`skills/migrate-v8-to-v9/SKILL.md:54`): `cellSelectionFeature`, `columnFilteringFeature`, `globalFilteringFeature`, `rowSortingFeature`, `rowPaginationFeature`, `rowSelectionFeature`, `rowExpandingFeature`, `rowPinningFeature`, `columnPinningFeature`, `columnVisibilityFeature`, `columnOrderingFeature`, `columnSizingFeature`, `columnResizingFeature`, `rowAggregationFeature`, `columnGroupingFeature`, `columnFacetingFeature`.

Row-model factories take no arguments; the slot must come after its prerequisite feature in the same call:

| Slot | Factory | Prerequisite feature |
| --- | --- | --- |
| `filteredRowModel` | `createFilteredRowModel()` | `columnFilteringFeature` |
| `sortedRowModel` | `createSortedRowModel()` | `rowSortingFeature` |
| `paginatedRowModel` | `createPaginatedRowModel()` | `rowPaginationFeature` |
| `expandedRowModel` | `createExpandedRowModel()` | `rowExpandingFeature` |
| `groupedRowModel` | `createGroupedRowModel()` | `columnGroupingFeature` |
| `facetedRowModel` | `createFacetedRowModel()` | `columnFacetingFeature` |
| `facetedMinMaxValues` | `createFacetedMinMaxValues()` | `columnFacetingFeature` |
| `facetedUniqueValues` | `createFacetedUniqueValues()` | `columnFacetingFeature` |

Source: `skills/migrate-v8-to-v9/SKILL.md:56-69`.

Registries are sibling slots: `sortFns: { alphanumeric: sortFn_alphanumeric }`, `filterFns: { includesString: filterFn_includesString }`, `aggregationFns: { sum: aggregationFn_sum }`. Import individual built-ins and register only what your columns reference; the full registry objects still work but bundle every built-in (`skills/migrate-v8-to-v9/SKILL.md:69`).

Aggregation is independent from grouping: register `rowAggregationFeature` for aggregation APIs, add `columnGroupingFeature` only for grouped rows (`skills/migrate-v8-to-v9/SKILL.md:54`).

## Atoms and store

- `table.baseAtoms`: internal writable atoms created from resolved initial state. Escape hatch only.
- `table.atoms`: readonly derived atoms for the active owner of each registered slice.
- `table.store`: combined readonly flat store; `table.store.get()` for a full snapshot or debug output.

Source: `skills/table-state/SKILL.md:25-29`.

Atom reads become reactive only inside templates, `computed`, `watch`, or `table.Subscribe` (`skills/table-state/SKILL.md:29`). Prefer narrow atom reads (`table.atoms.sorting.get()`) over full-store reads. Update state with feature methods (`setSorting`, `nextPage`, `toggleSelected`, `toggleVisibility`); feature resets like `resetSorting()`/`resetPagination()` use `table.initialState` unless passed `true` for the feature default (`skills/table-state/SKILL.md:92-100`).

Slice types (`PaginationState`, `SortingState`, ...) are exported from table-core via the main entry; `TableState<typeof features>` is the complete feature-inferred state type (`skills/table-state/SKILL.md:100`).

## `createTableHook`

```ts
const hook = createTableHook({ features, tableComponents, cellComponents, headerComponents })
// hook.useAppTable, hook.createAppColumnHelper, hook.useTableContext,
// hook.useCellContext, hook.useHeaderContext, hook.appFeatures
```

`dist/createTableHook.d.ts:68-102,153`. Returns an `AppVueTable` extended with `AppTable`, `AppCell`, `AppHeader`, `AppFooter` wrapper components, registered `tableComponents`, and a context-bound `FlexRender` (`dist/createTableHook.d.ts:61-67`). The typed context exists only below the corresponding wrapper (`skills/create-table-hook/SKILL.md:104-120`). Export `useTableContext` with an explicit return type to break circular inference when registered components import the hook module (`skills/create-table-hook/SKILL.md:62-84`).

## Official documentation

- Adapter overview and exports: https://github.com/TanStack/table/blob/master/docs/framework/vue/vue-table.md
- Docs site: https://tanstack.com/table
