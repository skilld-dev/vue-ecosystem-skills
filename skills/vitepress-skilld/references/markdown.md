# Markdown config

`MarkdownOptions` extends markdown-it options and is set under the `markdown`
key of the site config (`dist/node/index.d.ts:2044-2177`).

## Core options

| Option | Type / default | Notes |
| --- | --- | --- |
| `preConfig?: (md: MarkdownIt) => void` | Runs before VitePress plugins |
| `config?: (md: MarkdownIt) => void` | Runs after; standard extension point |
| `cache?: boolean` | Disable markdown cache (experimental) |
| `externalLinks?: Record<string, string>` | Attrs added to external links, e.g. `{ target: '_blank', rel: 'noreferrer' }` |
| `lineNumbers?: boolean`, default `false` | Line numbers in code blocks |
| `defaultHighlightLang?: string` | Fences without a lang use this |
| `codeCopyButtonTitle?: string`, default `'Copy Code'` | |
| `image.lazyLoading?: boolean`, default `false` | Native `<img loading="lazy">` |
| `gfmAlerts?: boolean`, default `true` | GitHub-flavored `> [!NOTE]` alerts |

Markdown-it base options (`html`, `linkify`, `typographer`, `breaks`,
`quotes`, `langPrefix`, `highlight`) pass through directly
(`dist/node/index.d.ts:1178-1238`).

## Syntax highlighting (shiki 2)

- `theme?: ThemeRegistrationAny | BuiltinTheme | { light; dark }`, e.g.
  `{ theme: { light: 'github-light', dark: 'github-dark' } }`
  (`dist/node/index.d.ts:2060-2071`).
- `languages?: LanguageInput[]`; `languageAlias?: Record<string, string>`,
  e.g. `{ 'my-lang': 'js' }`
  (`dist/node/index.d.ts:2076-2083`).
- `codeTransformers?: ShikiTransformer[]`
  (`dist/node/index.d.ts:2097`).
- `shikiSetup?: (shiki: Highlighter) => void | Promise<void>`; the option is
  `shikiSetup`, renamed from `shikijiSetup` in v1.0.0-rc.41
  (`dist/node/index.d.ts:2101`).

## Plugin options

| Option | For | Notes |
| --- | --- | --- |
| `anchor?: anchor.AnchorOptions` | markdown-it-anchor | `level`, `slugify`, `permalink`, `tabIndex` |
| `attrs?: { leftDelimiter?, rightDelimiter?, allowedAttributes?, disable? }` | markdown-it-attrs | |
| `emoji?: { defs?, enabled?, shortcuts? }` | markdown-it-emoji | |
| `frontmatter?: FrontmatterPluginOptions` | @mdit-vue/plugin-frontmatter | `grayMatterOptions`, `renderExcerpt` |
| `headers?: HeadersPluginOptions \| boolean` | @mdit-vue/plugin-headers | Extraction `level` default `[2, 3]`; off by default since 1.0.0-alpha.57 (`dist/node/index.d.ts:1757-1786`) |
| `sfc?: SfcPluginOptions` | @mdit-vue/plugin-sfc | `customBlocks` |
| `toc?: TocPluginOptions` | @mdit-vue/plugin-toc | Placeholder default `/^\[\[toc\]\]$/i` |
| `component?: ComponentPluginOptions` | @mdit-vue/plugin-component | `blockTags`, `inlineTags` |
| `container?: ContainerOptions` | markdown-it-container | Labels: `infoLabel`, `noteLabel`, `tipLabel`, `warningLabel`, `dangerLabel`, `detailsLabel`, `importantLabel`, `cautionLabel` |
| `math?: boolean \| any`, default `false` | markdown-it-mathjax3 | Requires installing `markdown-it-mathjax3` (optional peer, `package.json:155-162`) |

## Extension examples

```ts
import { defineConfig } from 'vitepress'

export default defineConfig({
  markdown: {
    theme: { light: 'github-light', dark: 'github-dark' },
    lineNumbers: true,
    config(md) {
      md.use(someMarkdownItPlugin)
    }
  }
})
```

Programmatic renderer:

```ts
import { createMarkdownRenderer } from 'vitepress'
const md = await createMarkdownRenderer(srcDir)
```

Experimental; signature at `dist/node/index.d.ts:2183`. Call
`disposeMdItInstance()` to drop the shared cached instance
(`dist/node/index.d.ts:2179`).

## Markdown file conventions

- Vue syntax works in `.md`: interpolation, directives, `<script setup>`
  (https://vitepress.dev/guide/using-vue).
- Escape raw mustaches with `v-pre` on an element or inline code.
- Custom containers: `::: tip` / `info` / `warning` / `danger` / `details`.
- Code groups: ```` ```group ``` fences or `<code-group>`; file tabs via
  `@[code](./file.ts)` imports (https://vitepress.dev/guide/markdown).

Official guide: https://vitepress.dev/guide/markdown
