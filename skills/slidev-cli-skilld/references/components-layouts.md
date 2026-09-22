# Components, Layouts, and Global Context

Source: shipped skill references and https://sli.dev/builtin/.

## Built-in layouts

Set with per-slide `layout:` frontmatter.

| Layout | Purpose |
|--------|---------|
| `default` | Standard slide |
| `cover` / `intro` / `end` | Cover, intro, closing slides |
| `center` / `section` / `statement` / `fact` / `quote` | Centered and display slides |
| `full` / `none` | Fullscreen content / no styling |
| `two-cols` | Two columns via `::right::` slot |
| `two-cols-header` | Header plus `::left::` and `::right::` slots |
| `image` / `image-left` / `image-right` | `image:` frontmatter prop |
| `iframe` / `iframe-left` / `iframe-right` | `url:` frontmatter prop |

Slots: layouts load from Slidev defaults, then theme, then addons, then
`./layouts/`; later sources override earlier ones.

Custom layout `layouts/two-areas.vue`:

```vue
<template>
  <div class="slidev-layout two-areas">
    <div class="top"><slot name="top" /></div>
    <div class="bottom"><slot /></div>
  </div>
</template>
```

Usage: `::top::` and `::default::` blocks in the slide.

## Built-in components

Auto-imported; no import statements needed. Custom components in
`./components/` are auto-imported too.

Navigation and meta:

```md
<Link to="5">Go to slide 5</Link>
<Link to="intro">Use a routeAlias</Link>
Slide <SlideCurrentNo /> of <SlidesTotal />
<Toc maxDepth="2" columns="2" />
<TitleRenderer no="3" />
```

`Toc` props: `columns`, `maxDepth`/`minDepth`,
`mode` (`all` | `onlyCurrentTree` | `onlySiblings`).

Animation helpers: `<VClick>`, `<VClicks>`, `<VAfter>`, `<VSwitch>`
(see [animations.md](animations.md)).

Drawing and layout:

```md
<Arrow x1="10" y1="10" x2="100" y2="100" color="#953" two-way />
<VDragArrow />
<Transform :scale="0.5"><BigTable /></Transform>
<AutoFitText :max="200" :min="50" modelValue="Hello" />
<VDrag pos="myElement">Draggable; positions in dragPos frontmatter</VDrag>
```

Media:

```md
<Youtube id="dQw4w9WgXcQ" />
<Tweet id="1390115482657726468" />
<SlidevVideo v-click autoplay controls>
  <source src="/video.mp4" type="video/mp4" />
</SlidevVideo>
```

`Tweet` accepts `id` or a full `x.com`/`twitter.com` URL; `id` wins.

Conditional:

```md
<LightOrDark>
  <template #dark>Dark content</template>
  <template #light>Light content</template>
</LightOrDark>

<RenderWhen context="presenter">Presenter only</RenderWhen>
```

`RenderWhen` contexts: `main`, `visible`, `print`, `slide`, `overview`,
`presenter`, `previewNext`.

## Global context

Template variables in slides and components:

```md
Page {{ $page }} of {{ $nav.total }}
Layout: {{ $frontmatter.layout }}
Clicks: {{ $clicks }}
Title: {{ $slidev.configs.title }}
```

`$nav`: `currentPage`, `currentLayout`, `total`, `isPresenter`,
`next()`, `prev()`, `nextSlide()`, `prevSlide()`, `go(n)`.

`$renderContext`: `'slide'`, `'overview'`, `'presenter'`, `'previewNext'`.

```md
<span @click="$slidev.nav.next">Click to advance</span>
```

Composables from `@slidev/client`: `useNav`, `useDarkMode`,
`useIsSlideActive`, `useSlideContext`, `onSlideEnter`, `onSlideLeave`.

```ts
import { onSlideEnter, onSlideLeave } from '@slidev/client'

onSlideEnter((to, from) => startAnimation())
onSlideLeave((to, from) => cleanup())
```

Use `onSlideEnter`/`onSlideLeave` instead of `onMounted`/`onUnmounted`:
slide component instances persist across visits.
