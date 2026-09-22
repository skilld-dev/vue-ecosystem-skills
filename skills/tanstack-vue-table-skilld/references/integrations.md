# Integrations

Patterns condensed from the package-shipped composition skills (`skills/with-tanstack-query/SKILL.md`, `skills/with-tanstack-virtual/SKILL.md`); citations point there.

## TanStack Query (server-side pagination)

Name each client- and server-owned processing stage first. Keep query dependencies reactive, pass results through as computed refs, and let the table run in manual mode.

```ts
import { computed, ref } from 'vue'
import { keepPreviousData, useQuery } from '@tanstack/vue-query'
import {
  rowPaginationFeature,
  tableFeatures,
  useTable,
} from '@tanstack/vue-table'

const pagination = ref({ pageIndex: 0, pageSize: 20 })
const query = useQuery(() => ({
  queryKey: ['people', pagination.value.pageIndex, pagination.value.pageSize],
  queryFn: () =>
    fetch(
      `/api/people?page=${pagination.value.pageIndex}&size=${pagination.value.pageSize}`,
    ).then((r) => r.json()),
  placeholderData: keepPreviousData,
}))
const data = computed(() => query.data.value?.rows ?? [])
const rowCount = computed(() => query.data.value?.rowCount ?? 0)
const state = computed(() => ({ pagination: pagination.value }))
const table = useTable({
  features: tableFeatures({ rowPaginationFeature }),
  columns,
  data,
  rowCount,
  manualPagination: true,
  state,
  onPaginationChange: (next) => {
    pagination.value =
      typeof next === 'function' ? next(pagination.value) : next
  },
})
```

(`skills/with-tanstack-query/SKILL.md:22-56`)

Rules:

- Read refs inside the Vue Query options function; include every manual filter/sort/page input in the query key. A value captured outside the options function is not a dependency (`:70-87`).
- Expose query fields as `computed` refs. A local `ref` copy of query data drifts from later cache results; add a local ref only for an explicit editing workflow with a cache-write policy (`:89-105`).
- With `manualPagination: true`, pass `rowCount` so page counts come from the server; one returned page cannot tell the table how many pages exist (`:107-123`).

## TanStack Virtual

Virtual consumes final table models; it is not registered in `tableFeatures`.

```ts
import { computed, ref } from 'vue'
import { useVirtualizer } from '@tanstack/vue-virtual'

const scrollElement = ref<HTMLElement | null>(null)
const rows = computed(() => table.getRowModel().rows)
const rowVirtualizer = useVirtualizer(
  computed(() => ({
    count: rows.value.length,
    getScrollElement: () => scrollElement.value,
    estimateSize: () => 34,
    getItemKey: (index) => rows.value[index]!.id,
    overscan: 5,
  })),
)
const virtualRows = computed(() => rowVirtualizer.value.getVirtualItems())
const totalSize = computed(() => rowVirtualizer.value.getTotalSize())
```

(`skills/with-tanstack-virtual/SKILL.md:26-42`)

Rules:

- Pass computed options to `useVirtualizer`; a plain options snapshot does not resync the virtual range with Vue's current model (`:60-74`).
- Virtualize `table.getRowModel().rows` for rows and `table.getVisibleLeafColumns()` for columns, never the source `data` array; source arrays skip filtering, sorting, expansion, and pagination (`:76-94`).
- Virtual provides measurements only. Own the layout yourself: bounded scroll container with a positioning context, a spacer sized by `getTotalSize()`, transformed items, and any sticky headers (`:96-112`).
- Infinite fetching: fetch near the last virtual item only while `totalFetched < serverRowCount` and no request is active. With manual sorting the server must return sorted order, and a sort change normally resets pages (`:54-56`).
