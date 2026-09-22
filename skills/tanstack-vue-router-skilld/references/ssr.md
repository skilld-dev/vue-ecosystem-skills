# SSR

Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/ssr

## Entry points

- `@tanstack/vue-router/ssr/server`: `RouterServer` (http handler component), `renderRouterToString(router)`, `renderRouterToStream(router)`, `defaultRenderHandler`, `defaultStreamHandler`, plus `dehydrateRouter`/router-core server utilities (`src/ssr/server.ts:1-6`)
- `@tanstack/vue-router/ssr/client`: `RouterClient` (`src/ssr/client.ts:1`)

## Server

```ts
import { createRouter } from '@tanstack/vue-router'
import { renderRouterToString } from '@tanstack/vue-router/ssr/server'

const router = createRouter({ routeTree, ssr: true })
// per request:
router.update({ context: { auth } })
const html = await renderRouterToString(router)
```

Streaming uses `renderRouterToStream` with deferred loader values (see `references/data-loading.md`); `defaultStreamHandler`/`defaultRenderHandler` wire common Node http shapes. Handlers accept `{ req, res, router }`.

## Document shell components

Root route component for SSR apps:

```tsx
import { Html, HeadContent, Body, Outlet, Scripts } from '@tanstack/vue-router'

function RootComponent() {
  return (
    <Html>
      <head>
        <HeadContent />
      </head>
      <Body>
        <Outlet />
        <Scripts />
      </Body>
    </Html>
  )
}
```

- `<Html>`, `<Body>` — html/body tags with hydration-safe attributes
- `<HeadContent>` — renders route `head()` output: meta, links, styles (`src/HeadContent.tsx`)
- `<Scripts>`, `<ScriptOnce>` — script injection; `ScriptOnce` for one-shot inline scripts
- `<Asset>` — preload/preload-module/link tags for build assets (streaming SSR)
- `<ClientOnly>` — renders `fallback` until mounted; use for browser-only widgets, or set `ssr: false` on a route (`src/Match.tsx:67-80`)
- `headers` route option sets HTTP response headers; `scripts()` injects script tags

Head guide: https://tanstack.com/router/latest/docs/framework/vue/guide/document-head-management

## Client hydration

```ts
import { createRouter } from '@tanstack/vue-router'
import { RouterClient } from '@tanstack/vue-router/ssr/client'
import { routeTree } from './routeTree.gen'

const router = createRouter({ routeTree })
const client = new RouterClient(router)
// then mount <RouterProvider :router="router" />; hydration reuses dehydrated loader data
```

## Behavior notes

- Server render is single-pass: hooks skip store subscriptions during SSR (`src/useRouterState.tsx:39-51`, `src/useMatch.tsx:79-97`); do not expect watcher-driven updates on the server.
- Routes with `ssr: false` render the pending component until hydration; `'data-only'` skips rendering HTML but ships loader data.
- `isbot` is a runtime dependency of the package for bot detection in handlers (`package.json:65`).
- History on the server: pass `createMemoryHistory({ initialEntries: [url] })` when constructing the request router.
