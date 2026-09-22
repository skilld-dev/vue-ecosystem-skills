# Exporting, Building, and Hosting

Source: shipped skill references, `dist/cli.mjs`, `dist/export-LauAJGMx.mjs`,
and https://sli.dev/guide/exporting.

## Two exporters

- Browser exporter: run the dev server, open `http://localhost:<port>/export/`,
  pick format and options, download. Gated by headmatter `browserExporter`
  (`true` | `'dev'` | `'build'`, not `false`).
- CLI exporter: `slidev export`. Requires `playwright-chromium`
  (`npm i -D playwright-chromium`); in CI also `npx playwright install chromium`.

Full CLI flags and defaults: [cli.md](cli.md).

## Formats

| Format | Result |
|--------|--------|
| `pdf` | One PDF, default |
| `png` | One image per slide (`--range` to subset) |
| `pptx` | PowerPoint, each slide an image; `--with-clicks` defaults to true for pptx |
| `pptx-editable` | PowerPoint with native shapes and selectable text |
| `md` | Markdown output |

`pptx-editable` caveats: SVG (including Mermaid), canvas, iframes, KaTeX
formulas, gradients, and CSS filters stay pictures; slides that cannot be
rebuilt fall back to image export individually; fonts are named, not embedded;
`--per-slide` is not supported.

Speaker notes PDF: `slidev export-notes`.

## Troubleshooting exports

- Missing content: `--wait 3000 --timeout 60000`.
- Wrong global-layer state: use `--per-slide`, or `slide-top.vue` instead of `global-top.vue`.
- Broken emoji in CI: install an emoji font on the build machine.

## Headmatter export config

```yaml
---
exportFilename: my-presentation
download: true             # PDF download button in built SPA
export:
  format: pdf
  timeout: 30000
  withClicks: false
  withToc: false
---
```

## Building

```bash
slidev build --base /<repo-name>/ --download --out dist
```

- Output is a static SPA in `dist/`.
- `--base` (or headmatter `base`) for subpath deploys; must start and end with `/`.
- `--router-mode hash` for hosts without rewrites; `memory` for kiosk decks.
- `--without-notes` strips speaker notes.
- Multiple entries build into one subdir per entry.

## Hosting

GitHub Pages workflow (`.github/workflows/deploy.yml`):

```yaml
name: Deploy
on:
  push:
    branches: [main]
permissions:
  contents: read
  pages: write
  id-token: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 'lts/*'
      - run: npm install
      - run: npm run build -- --base /${{ github.event.repository.name }}/
      - uses: actions/configure-pages@v4
      - uses: actions/upload-pages-artifact@v3
        with:
          path: dist
      - uses: actions/deploy-pages@v4
```

Netlify `netlify.toml`:

```toml
[build]
  publish = 'dist'
  command = 'npm run build'

[[redirects]]
  from = '/*'
  to = '/index.html'
  status = 200
```

Vercel `vercel.json`:

```json
{ "rewrites": [{ "source": "/(.*)", "destination": "/index.html" }] }
```

Docker: `docker run --rm -it -v ${PWD}:/slidev -p 3030:3030 tangramor/slidev:latest`.
