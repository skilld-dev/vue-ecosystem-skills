# Migration v8 to v9

Condensed from the package-shipped migration skill (`skills/migrate-v8-to-v9/SKILL.md`); line citations point there unless noted. V9 is the current API; do not stop after renaming the composable.

Recommended order:

1. Replace `useVueTable` with `useTable`, preserving reactive inputs.
2. Define explicit features; move row models and registries into `tableFeatures`.
3. Update state reads, controlled ownership, and rendering.
4. Apply every shared API and type rename below.
5. Keep `stockFeatures` only as a temporary audit bridge.

## Construction and feature registration

| v8 | v9 |
| --- | --- |
| `useVueTable(options)` | `useTable(options)` |
| All features bundled | Required `features: tableFeatures({...})` |
| `getCoreRowModel()` option | Remove; core row model is automatic |
| `get*RowModel()` table options | `create*RowModel()` slots in `tableFeatures` |
| `sortingFns` table option | `sortFns` feature slot |
| `filterFns` / `aggregationFns` options | Same-named feature slots |
| Top-level `onStateChange` | Per-slice callbacks, external atoms, or `table.store.subscribe` |

(:44-54; row-model table :56-69)

## Vue state

- Pass a `ref`/`computed` as `data`; never `data.value` (:73).
- `table.getState().sorting` becomes `table.atoms.sorting.get()`; `table.store.get()` only for full snapshots (:74).
- Wrap atom reads in `computed` for template values (:75).
- Controlled refs need reactive state slices plus per-slice callbacks resolving value-or-function updaters (:77).
- External atoms come from `@tanstack/vue-store` via the `atoms` option; never provide both `atoms.pagination` and `state.pagination` (:79).

## Rendering

| v8 | v9 |
| --- | --- |
| `<FlexRender :render="cell.column.columnDef.cell" :props="cell.getContext()" />` | `<FlexRender :cell="cell" />` |
| Manual header/footer render props | `<FlexRender :header="header" />` / `:footer="footer"` |
| Repeated raw options | `tableOptions(...)` composition |
| Repeated table conventions | `createTableHook({ features, ... })` |

(:84-91; legacy shape still compiles, shorthand is the target)

## Instance methods

Row, cell, column, header, and related methods now live on shared prototypes and use `this`. Do not destructure, pass bare, or expect them in spreads, `Object.keys`, or JSON. Table methods are unaffected (:95-97).

## Logical column pinning

No `left`/`right` aliases in v9 (:99-120):

| old | new |
| --- | --- |
| `columnPinning.left` / `.right` | `.start` / `.end` |
| `column.pin('left' \| 'right')` | `column.pin('start' \| 'end')` |
| `getIsPinned() === 'left'` | `=== 'start'` |
| `row.getLeftVisibleCells()` | `getStartVisibleCells()` |
| `table.getLeftHeaderGroups()` | `getStartHeaderGroups()` |
| `getLeftFooterGroups()` | `getStartFooterGroups()` |
| `getLeftFlatHeaders()` | `getStartFlatHeaders()` |
| `getLeftLeafHeaders()` | `getStartLeafHeaders()` |
| `getLeftLeafColumns()` | `getStartLeafColumns()` |
| `getLeftVisibleLeafColumns()` | `getStartVisibleLeafColumns()` |
| `getLeftTotalSize()` | `getStartTotalSize()` |
| `column.getStart('left')` | `column.getStart('start')` |
| `column.getAfter('right')` | `column.getAfter('end')` |
| `column.getIndex('left' \| 'right')` | `column.getIndex('start' \| 'end')` |

Also rename the `getRight*` counterparts to `getEnd*`. Use CSS `inset-inline-start`/`inset-inline-end`; logical names do not set DOM direction. `columnResizeDirection` is unchanged (:120).

## Sizing, resizing, sorting, selection

- `enablePinning` splits into `enableColumnPinning` and `enableRowPinning` (:124).
- Interactive resizing needs `columnSizingFeature` plus `columnResizingFeature`; fixed sizing needs only the former (:125).
- `columnSizingInfo` -> `columnResizing`; `setColumnSizingInfo()` -> `setColumnResizing()`; `onColumnSizingInfoChange` -> `onColumnResizingChange` (:126-128).
- `sortingFn` -> `sortFn`; `sortingFns` -> `sortFns`; `getSortingFn()` -> `getSortFn()`; `getAutoSortingFn()` -> `getAutoSortFn()`; types `SortingFn`/`SortingFns` -> `SortFn`/`SortFns` (:132-138).
- `row._getAllCellsByColumnId()` -> `row.getAllCellsByColumnId()`; other `_`-prefixed internals removed, e.g. `_getPinnedRows`, `_getFacetedRowModel` (:139-141).
- `getIsSomeRowsSelected()` / `getIsSomePageRowsSelected()` now mean "at least one, including all"; indeterminate UI must also check `!getIsAllRowsSelected()` / `!getIsAllPageRowsSelected()` (:143).

## TypeScript

- Add `TFeatures` first: `ColumnDef<typeof features, Person>`, `Column<typeof features, Person>`, `Row<typeof features, Person>`, `Table<typeof features, Person>` (:147).
- `createColumnHelper<Person>()` -> `createColumnHelper<typeof features, Person>()`; use `columnHelper.columns([...])` for nested-array inference (:148).
- Use `StockFeatures` when configuring via `stockFeatures` (:149).
- `TableMeta`/`ColumnMeta` declaration merging must add `TFeatures` first; prefer per-table `tableMeta`/`columnMeta: metaHelper<...>()` slots (:150).
- Replace global `FilterFns`/`SortFns`/`AggregationFns`/`FilterMeta` augmentation with registry slots and `filterMeta: metaHelper<...>()`; registered keys become valid column-def strings (:151).
- `RowData` is restricted to records or arrays; prefer explicit object row types (:152).

## Checklist

- [ ] `useVueTable` replaced; refs/computed inputs stay reactive.
- [ ] Features, row models, and registries live in `tableFeatures`; core row model removed.
- [ ] State reads use atoms/computed or the store intentionally; `onStateChange` removed.
- [ ] External atom and controlled state ownership do not overlap.
- [ ] FlexRender shorthand adopted.
- [ ] Prototype methods, pinning, sizing/resizing, sorting, row, and selection changes audited.
- [ ] Helpers, types, meta, registries, and `RowData` use v9 shapes.
- [ ] Temporary `stockFeatures` usage has a removal plan.

(:172-181)
