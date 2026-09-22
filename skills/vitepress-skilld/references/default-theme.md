# Default theme config

`DefaultTheme.Config` from `types/default-theme.d.ts:12-166`. Set via the
`themeConfig` key of the site config.

## Top-level options

| Option | Type | Notes |
| --- | --- | --- |
| `logo` | `ThemeableImage` | `string`, `{ src, alt }`, or `{ light, dark }` |
| `logoLink` | `string \| { link, rel, target }` | Overrides logo link |
| `siteTitle` | `string \| false` | Defaults to `config.title` |
| `outline` | `Outline \| Outline['level'] \| false` | Level default `2`; `'deep'` = `[2, 6]` |
| `outlineTitle` | deprecated | Use `outline.label` |
| `nav` | `NavItem[]` | See below |
| `sidebar` | `Sidebar` | See below |
| `aside` | `boolean \| 'left'`, default `true` | Right-side outline |
| `editLink` | `EditLink` | `pattern: string \| ((payload: PageData) => string)`, `text?` |
| `lastUpdated` | `LastUpdatedOptions` | `text?`, `formatOptions?: Intl.DateTimeFormatOptions & { forceLocale? }` |
| `lastUpdatedText` | deprecated | Use `lastUpdated.text` |
| `docFooter` | `{ prev?: string \| boolean; next?: string \| boolean }` | |
| `socialLinks` | `SocialLink[]` | `{ icon: string \| { svg }, link, ariaLabel? }` |
| `footer` | `{ message?, copyright? }` | Hidden when sidebar and no hero present |
| `search` | `{ provider: 'local'; options?: LocalSearchOptions } \| { provider: 'algolia'; options: AlgoliaSearchOptions }` | |
| `algolia` | deprecated | Use `search` |
| `carbonAds` | `{ code, placement }` | |
| `i18nRouting` | `boolean`, default `true` | `/foo` → `/locale/foo` on locale change |
| `externalLinkIcon` | `boolean`, default `false` | Show icon on external links |
| `notFound` | `NotFoundOptions` | `title`, `quote`, `linkLabel`, `linkText`, `code` |

Label options: `darkModeSwitchLabel`, `lightModeSwitchTitle`,
`darkModeSwitchTitle`, `sidebarMenuLabel`, `returnToTopLabel`,
`langMenuLabel`, `skipToContentLabel`
(`types/default-theme.d.ts:100-132`).

## Nav

`NavItem` variants (`types/default-theme.d.ts:170-206`):

- `{ text, link, activeMatch?, rel?, target?, noIcon? }`
- `{ text?, items }` where items nest `{ text, link }` or component items
  `{ component, props? }`.
- `activeMatch` is a regex string, not a `RegExp`, for serializability.

## Sidebar

`Sidebar = SidebarItem[] | SidebarMulti`
(`types/default-theme.d.ts:235-239`). `SidebarMulti` maps a path prefix to
either `SidebarItem[]` or `{ items: SidebarItem[]; base: string }`.

`SidebarItem` (`types/default-theme.d.ts:241-278`): `text?`, `link?`,
`items?`, `collapsed?`, `base?`, `docFooterText?`, `rel?`, `target?`.

- Nested children live under `items` (renamed from `children` in v1.0.0).
- `collapsed: true` means collapsible and collapsed; `false` means
  collapsible and expanded; unset means not collapsible.

```ts
themeConfig: {
  sidebar: {
    '/guide/': [
      {
        text: 'Guide',
        base: '/guide/',
        collapsed: false,
        items: [{ text: 'Intro', link: 'intro' }]
      }
    ]
  }
}
```

## Search

### Local (`provider: 'local'`)

`LocalSearchOptions` (`types/default-theme.d.ts:392-456`):

- `detailedView?: boolean | 'auto'` (default `'auto'`);
  `disableDetailedView` is deprecated.
- `disableQueryPersistence?: boolean`.
- `translations?: LocalSearchTranslations`,
  `locales?: Record<string, Partial<LocalSearchOptions>>`.
- `miniSearch.options` / `miniSearch.searchOptions`: minisearch tuning.
- `miniSearch._splitIntoSections?: (path, html) => sections generator`:
  replaces the default page splitter; async generators enable worker-thread
  parallelism.
- `_render?: (src, env, md) => Awaitable<string>`: transform content before
  indexing; return `''` to skip a page. With a custom `_render`, handle
  `frontmatter.search === false` yourself
  (https://vitepress.dev/reference/default-theme-search#local-search-options).

```ts
themeConfig: {
  search: {
    provider: 'local',
    options: {
      _render(src, env, md) {
        if (env.frontmatter?.search === false) return ''
        return md.render(src, env)
      }
    }
  }
}
```

### Algolia (`provider: 'algolia'`)

`AlgoliaSearchOptions extends DocSearchProps` with per-locale `locales`
(`types/default-theme.d.ts:458-466`, `types/docsearch.d.ts`).

## Home page frontmatter

Homepage features, hero, and testimonials are configured in `index.md`
frontmatter (`features`, `hero`), not `themeConfig`
(https://vitepress.dev/reference/default-theme-home-page). Home components
`VPHomeHero`, `VPHomeFeatures` are extendable via slots
(https://vitepress.dev/guide/extending-default-theme).

## Composables and components

`useSidebar(): DocSidebar` exposes `isOpen`, `sidebar`, `sidebarGroups`,
`hasSidebar`, `hasAside`, `leftAside`, `isSidebarEnabled`, `open`, `close`,
`toggle` (`types/default-theme.d.ts:283-294`).
`useLocalNav(): DocLocalNav` exposes `headers`, `hasLocalNav`
(`types/default-theme.d.ts:369-381`).

Badge in markdown: `<Badge type="tip" text="Since v1.6" />` with types
`tip | info | warning | danger`
(https://vitepress.dev/reference/default-theme-badge).

Official reference: https://vitepress.dev/reference/default-theme-config
