# CLI Reference

All commands verified against `dist/cli.mjs` and `dist/export-LauAJGMx.mjs` in `@slidev/cli` 53.0.0.
Every command accepts the positional `entry` (default `slides.md`) and `--theme, -t` to override the theme.
The parser is strict (`yargs` `.strict()`): unknown flags fail.

## `slidev [entry]` — dev server

| Flag | Default | Description |
|------|---------|-------------|
| `--port, -p` | 3030 | Server port; if taken, picks another in 3030-4000 |
| `--open, -o` | false | Open in browser |
| `--remote [password]` | off | Listen on public host, enable remote control; value becomes the password |
| `--tunnel` | false | Cloudflare Quick Tunnel; requires `--remote` |
| `--bind` | 0.0.0.0 | Listen address in remote mode |
| `--base` | `/` | Base URL; must start and end with `/` |
| `--log` | warn | `error` \| `warn` \| `info` \| `silent` |
| `--force, -f` | false | Ignore optimizer cache and re-bundle |
| `--inspect` | false | Enable Vite inspect plugin at `/__inspect/` |
| `--theme, -t` | - | Override theme |

```bash
slidev --port 8080 --open
slidev --remote mypassword --tunnel
slidev --base /talks/my-talk/
```

Terminal shortcuts while the server runs (TTY only): `r` restart, `o` open,
`e` edit entry (`$EDITOR` or `code`), `q` quit, `c` QR code (remote mode only).

Printed URLs in dev: slides at `/`, presenter at `/presenter/`,
overview at `/overview/`, browser exporter at `/export/`,
MCP endpoint at `http://localhost:<port>/__mcp` (dev mode, unless `mcp: false`).

Auto-restart triggers (`dist/cli.mjs`):

- Headmatter change of: `monaco`, `routerMode`, `fonts`, `css`, `mdc`, `editor`, `theme`, `seoMeta`.
- Enabling KaTeX or Monaco features.
- Watched files added/changed/removed: `setup/shiki.ts`, `setup/katex.ts`,
  `setup/preparser.ts`, `setup/transformers.ts`, `setup/unocss.ts`,
  `setup/vite-plugins.ts`, `uno.config.ts`, `unocss.config.ts`,
  `vite.config.{js,ts,mjs,mts}`.

## `slidev build [entry..]` — hostable SPA

| Flag | Default | Description |
|------|---------|-------------|
| `--out, -o` | dist | Output dir |
| `--base` | - | Base URL for subpath deploys |
| `--download, -d` | false | Add "download as PDF" button |
| `--without-notes` | false | Exclude speaker notes |
| `--router-mode` | - | `hash` \| `history` \| `memory`; hash suits GitHub Pages, memory keeps slide number out of the URL |
| `--inspect` | false | Vite inspect plugin |
| Export flags | - | All flags from `slidev export` below |

```bash
slidev build --base /my-repo/ --download
slidev build talks/a.md talks/b.md   # one output subdir per entry
```

## `slidev export [entry..]` — export deck

Formats: `pdf` (default), `png`, `pptx`, `pptx-editable`, `md`.

| Flag | Default | Description |
|------|---------|-------------|
| `--output` | `slides` | Output path (without extension for pages) |
| `--format` | pdf | Output format |
| `--timeout` | 30000 | Print page render timeout, ms |
| `--wait` | 0 | Extra wait before capture, ms |
| `--wait-until` | networkidle | `networkidle` \| `load` \| `domcontentloaded` \| `none` |
| `--range` | all | Page ranges, e.g. `"1,4-5,6"` |
| `--dark` | false | Export dark theme |
| `--with-clicks, -c` | false (true for pptx formats) | One page per click step |
| `--with-toc` | false | PDF outline |
| `--per-slide` | false | Render slide by slide; breaks cross-slide links and TOC; not supported with `pptx-editable` |
| `--scale` | 1 | Image scale factor |
| `--omit-background` | false | PNG without browser background |
| `--executable-path` | bundled | Custom browser executable |

```bash
slidev export --format pptx
slidev export --format png --range 1-5 --omit-background
slidev export --timeout 60000 --wait 2000   # slow-rendering slides
```

Requires `playwright-chromium`. In CI also run `npx playwright install chromium`.
Alternative without the CLI exporter: start the dev server and use the
browser exporter at `http://localhost:<port>/export/`.

## `slidev export-notes [entry..]` — notes PDF

Flags: `--output` (default `<entry basename>-export-notes`, or `<exportFilename>-notes`),
`--timeout` (30000), `--wait` (0).

## `slidev format [entry..]`

Parses, prettifies, and saves the slides markdown in place.

## `slidev mcp [entry]`

MCP server over stdio for AI agents, operating on files directly, no dev server.
See [mcp.md](mcp.md).

## `slidev theme eject [entry]`

Copies the current theme into a local dir (default `theme`, flag `--dir`),
excludes `node_modules` and `.git`, and rewrites the first slide's `theme`
frontmatter to the local path. Fails for theme `none` and for already-ejected
themes (theme values containing `/`).

## npm script usage

```json
{
  "scripts": {
    "dev": "slidev",
    "build": "slidev build",
    "export": "slidev export"
  }
}
```

Pass flags through npm with `--`:

```bash
npm run dev -- --port 8080 --open
```

Booleans: `--open` sets true, `--no-open` sets false.

Install globally: `npm i -g @slidev/cli`.
