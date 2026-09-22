# Search params

Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/search-params

## Validation

```ts
import { z } from 'zod'

const route = createFileRoute('/posts')({
  validateSearch: z.object({
    page: z.number().int().min(1).default(1),
    sort: z.enum(['new', 'top']).default('new'),
  }),
})
```

Forms also work as validators:

```ts
validateSearch: (input: Record<string, unknown>) => {
  const page = Number(input.page ?? 1)
  return { page: Number.isFinite(page) ? page : 1 }
}
```

- Input vs output types differ when defaults/fallbacks exist: `input` is partial (what a URL may carry), `output` is complete (what components read). Type `SearchSchemaInput` marks input-side values, e.g. `<Link search={{ page: undefined }}>` must remain assignable (`src/index.tsx:39`).
- Validation adapters for schema libraries provide the same input/output split: `@tanstack/zod-adapter`, `@tanstack/valibot-adapter`, `@tanstack/arktype-adapter`; `createSerializationAdapter` is the base (`src/index.tsx:22`).
- With Zod, prefer `fallback(z.number(), 1)` over `.catch()`; `.catch()` widens the type to `unknown` and breaks link prop inference.

## Reading and writing

```ts
const search = useSearch({ from: '/posts' }) // Ref, search.value.page
const navigate = useNavigate({ from: '/posts' })
navigate({ to: '.', search: (prev) => ({ ...prev, page: prev.page + 1 }) })
```

- `search` in `navigate`/`Link` may be an object or an updater receiving the current search of the target route.
- Zod `SearchParamError` throws when a param cannot be parsed to the schema type (`src/index.tsx:271`).

## Transforming with `search.middlewares`

Replaces deprecated `preSearchFilters`/`postSearchFilters`. Each middleware: `({ search, next }) => search`:

```ts
import { retainSearchParams, stripSearchParams } from '@tanstack/vue-router'

const layoutRoute = createFileRoute('/posts')({
  validateSearch: schema,
  search: {
    middlewares: [
      retainSearchParams(['filter']),   // keep on descendant navigations
      stripSearchParams(defaults),      // remove keys equal to defaults
    ],
  },
})
```

Middlewares run for all descendant links; removes manual `search: (prev) => ({...prev, ...})` spreading. Docs: https://tanstack.com/router/latest/docs/framework/vue/api/router/RouteOptionsType

## Complex types in URLs

Default serialization handles primitives; for arrays/objects/dates use `parseSearchWith`/`stringifySearchWith` with e.g. `superjson`, or a serialization adapter — https://tanstack.com/router/latest/docs/framework/vue/guide/custom-search-param-serialization

## Sharing search across routes

Put `validateSearch` on a layout route (or use `context` + middlewares) and read it from children with `useSearch({ from: layoutPath, strict: false })`. How-to: https://tanstack.com/router/latest/docs/framework/vue/how-to/share-search-params-across-routes
