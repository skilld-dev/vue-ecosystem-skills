# File-based routing (Vue)

Conventions: https://tanstack.com/router/latest/docs/framework/vue/routing/file-naming-conventions

## Vite plugin

```ts
import { tanstackRouter } from '@tanstack/router-plugin/vite'

tanstackRouter({
  target: 'vue',          // required for Vue; plugin must come before vue()
  autoCodeSplitting: true,
  routesDirectory: './src/routes',
  generatedRouteTree: './src/routeTree.gen.ts',
  routeFileIgnorePrefix: '-',
  quoteStyle: 'single',
})
```

Verified against https://github.com/TanStack/router/blob/main/examples/vue/basic-file-based-sfc/vite.config.ts. Defaults and options: https://tanstack.com/router/latest/docs/framework/vue/api/file-based-routing

Import the generated tree in `src/main.ts`: `import { routeTree } from './routeTree.gen'`. Treat `routeTree.gen.ts` as generated: ignore it in lint/format, mark read-only in VS Code.

## Naming conventions (prepared README.md:47-79)

| Pattern | Meaning |
|---|---|
| `$param` | dynamic segment, e.g. `posts.$postId.ts` → `/posts/$postId` |
| `index` | index route of a directory, `/posts/index.ts` |
| `_layout` prefix | layout wrapping children, does not add a URL segment |
| `_` suffix | unnest: `posts_.$postId.edit.ts` → `/posts/$postId/edit` outside the `posts` layout |
| `(groupName)` dir | organization only, no URL impact |
| `.route.ts` | route config for a directory path (`blog.post.route.ts` or `blog/post/route.tsx`); configurable via `routeToken` |
| `-` prefix | file ignored by the generator |
| Unicode | supported (`대한민국.ts`) |

## Split-file convention for Vue

A route may split config from components (all optional; single `.tsx`/`.ts` files with inline components work too):

```
src/routes/
├── __root.ts                        # root config
├── __root.component.vue             # root layout (SFC)
├── __root.notFoundComponent.vue     # global 404
├── posts.ts                         # /posts config
├── posts.component.vue              # /posts layout
├── posts.index.component.vue        # /posts index
├── posts.$postId.ts                 # /posts/$postId config
├── posts.$postId.component.vue
├── posts.$postId.errorComponent.vue
└── posts_.$postId.edit.ts           # unnested edit route
```

Layout from the official example: https://github.com/TanStack/router/tree/main/examples/vue/basic-file-based-sfc/src/routes

## Automatic code splitting

`autoCodeSplitting: true` splits `component`, `pendingComponent`, `errorComponent`, `notFoundComponent`, and `loader` into separate chunks per route. Control grouping per route with `codeSplitGroupings` (e.g. `[['component'], ['errorComponent', 'notFoundComponent']]`) or globally via the plugin's `codeSplitting.defaultBehavior` / `splitBehavior`. Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/automatic-code-splitting

Notes:

- With SFC split files, the `.vue` components are naturally lazy; keep the loader in the route file — `FileRouteLoader`/separate loader files are deprecated (`src/fileRoute.ts:153`).
- `createLazyFileRoute(path)` mirrors `createFileRoute` for `.lazy.ts` files whose options load on demand.
- Route files may be `.ts`, `.tsx`, or paired with `.vue` files; JSX route files need `@vitejs/plugin-vue-jsx`.
- After renaming routes, the plugin regenerates `routeTree.gen.ts` on next dev/build run.
