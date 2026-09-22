# Navigation and links

## `<Link>`

```vue
<Link
  to="/posts/$postId"
  :params="{ postId: 42 }"
  :search="{ page: 2 }"
  active-options="{ exact: false, includeSearch: false }"
  preload="intent"
>
  Post
</Link>
```

- Scoped slot exposes `{ isActive }`: `<Link to="/about" v-slot="{ isActive }"><span :class="{ on: isActive }"/></Link>` (`src/link.tsx:918`)
- When active: `data-status="active"` and `aria-current="page"` are set (`src/link.tsx:522-525`); `activeProps` defaults to `{ class: 'active' }` (`src/link.tsx:477`); `class`/`style` merge with base props.
- Relative `to` resolves against `from` (default: current route); `to="."` stays put.
- `reloadDocument`, `replace`, `target`, `disabled`, `state`, `hash`, `mask` (route masking), `resetScroll`, `startTransition`, `viewTransition`, `ignoreBlocker` are supported props (`src/link.tsx:858-886`).
- External URLs (with a scheme) render as plain anchors; protocols not in `router.options.protocolAllowlist` are blocked (`src/link.tsx:537-586`).
- Modifier keys (`meta/alt/ctrl/shift`), non-`_self` targets, and `button !== 0` fall through to the browser default (`src/link.tsx:316-358`).

Props docs: https://tanstack.com/router/latest/docs/framework/vue/api/router/linkComponent

## Programmatic navigation

```ts
const navigate = useNavigate({ from: '/posts' })
navigate({ to: '/posts/$postId', params: { postId: '123' }, search: true }) // search:true keeps current search
router.history.back() / router.history.go(-1) // history control
```

`NavigateOptions`: `to`, `params`, `search`, `hash`, `state`, `replace`, `resetScroll`, `hashScrollIntoView`, `startTransition`, `viewTransition`, `ignoreBlocker`, `mask`, `reloadDocument` — https://tanstack.com/router/latest/docs/framework/vue/api/router/NavigateOptionsType

## Reusable targets

```ts
const postLink = linkOptions({ to: '/posts/$postId', params: { postId: '123' } })
```

`linkOptions` validates `to`/`params`/`search` at definition time and the result spreads into `<Link>`, `navigate()`, and `redirect()`. Bare literals infer `to` as `string` and defer errors — https://tanstack.com/router/latest/docs/framework/vue/guide/link-options

## Custom link components

```ts
import { createLink } from '@tanstack/vue-router'
import { defineComponent, h } from 'vue'

const BaseLink = defineComponent({
  setup(props, { attrs, slots }) {
    return () => h('a', { ...attrs, class: 'base-link' }, slots.default?.())
  },
})
export const StyledLink = createLink(BaseLink)
```

`createLink` passes router props down and forwards the default slot with `{ isActive }` (`src/link.tsx:846-856`). Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/custom-link

## Preloading

Per-link `preload: 'intent' | 'viewport' | 'render' | false`, `preloadDelay` (ms), `preloadIntentProximity`. Router defaults: `defaultPreload`, `defaultPreloadDelay` (default 50 ms), `defaultPreloadMaxAge` (preloaded data dropped after 30 s), `defaultPreloadStaleTime` (30 s), `defaultPreloadGcTime` (30 min). Viewport preload uses an intersection observer (`src/link.tsx:250-301`). Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/preloading

## Navigation blocking

```ts
const blocker = useBlocker({
  shouldBlockFn: ({ current, next }) => dirty.value,
  withResolver: true, // default false
})
if (blocker.value.status === 'blocked') {
  // blocker.value.proceed() allows, .reset() cancels
}
```

`shouldBlockFn` receives `{ current, next, action }` (routeId, fullPath, pathname, params, search per side) and may be async. `enableBeforeUnload` (default true) also guards tab close. Navigating away from a 404 is always allowed (`src/useBlocker.tsx:176-263`). The `<Block>` component wraps the same API with a scoped slot receiving the resolver. Guide: https://tanstack.com/router/latest/docs/framework/vue/guide/navigation-blocking
