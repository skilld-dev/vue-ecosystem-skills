---
name: slidev-cli-skilld
description: Build, present, and ship Slidev decks with @slidev/cli. Use when scaffolding a Slidev project, writing or editing slides.md Markdown decks, running the dev server, adding code highlighting, animations, layouts, or Vue components, exporting to PDF/PPTX/PNG/Markdown, building a hostable SPA, or driving slides through the built-in MCP server.
---

# Slidev CLI (`@slidev/cli` v53.0.0)

Markdown slides for developers, built on Vite, Vue 3, UnoCSS, and Shiki.
Verified against the prepared `@slidev/cli` 53.0.0 package source.

## Environment limits

- Node.js >= 22.12.0 (`package.json` `engines`).
- CLI export to PDF/PNG/PPTX needs an optional peer dependency:
  `npm i -D playwright-chromium` (`package.json` `peerDependencies`, marked optional).
- `vite-plugin-pwa` is an optional peer dependency for PWA output.

## Quick start

```bash
npm init slidev        # scaffold a project (README.md); pnpm create slidev also works
npm run dev            # dev server on http://localhost:3030
npm run build          # static SPA into dist/
npm run export         # PDF into the project root
```

In a scaffolded project, `dev`/`build`/`export` scripts wrap the `slidev` bin.
Run the bin directly after `npm i -g @slidev/cli`, or with `npx`.

Verify: after `dev`, slides load at `http://localhost:3030`.
After `export`, the PDF exists in the project root.

## Commands

| Task | Command |
|------|---------|
| Dev server | `slidev [entry]` (entry defaults to `slides.md`) |
| Build SPA | `slidev build [entry..]` |
| Export deck | `slidev export [entry..]` |
| Export notes | `slidev export-notes [entry..]` |
| Format markdown | `slidev format [entry..]` |
| MCP server (stdio) | `slidev mcp [entry]` |
| Eject theme | `slidev theme eject [entry]` |

Full flags and defaults: [references/cli.md](references/cli.md)

## Smallest working deck

```md
---
theme: default
title: My Talk
transition: slide-left
---

# First slide

Content

---

# Second slide

<!--
Presenter notes: the last HTML comment of a slide.
-->
```

- `---` separates slides; blank lines around it.
- The first frontmatter block is the headmatter (deck config).
- Later blocks are per-slide frontmatter.

## Key rules

- Dev server default port is 3030; if taken, Slidev picks another in 3030-4000 (`dist/cli.mjs` port logic).
- `--tunnel` requires `--remote` (`dist/cli.mjs`).
- `--per-slide` is rejected with `--format pptx-editable` (`dist/export-LauAJGMx.mjs`).
- `slidev export` prints a pointer to the browser exporter; when the dev server runs, visit `http://localhost:<port>/export/` to export from the browser (`dist/cli.mjs`).
- Editing slides programmatically: prefer the built-in MCP tools over raw text edits; they handle compound `---` separators and hot-reload. See [references/mcp.md](references/mcp.md).
- Magic Move code animation needs a four-backtick wrapper fence. See [references/code-blocks.md](references/code-blocks.md).

## References

| Topic | File |
|-------|------|
| CLI commands, flags, defaults, shortcuts | [references/cli.md](references/cli.md) |
| Markdown syntax: slides, notes, imports, diagrams | [references/syntax.md](references/syntax.md) |
| Headmatter and per-slide frontmatter keys | [references/config.md](references/config.md) |
| Code blocks: highlighting, Monaco, Magic Move, snippets | [references/code-blocks.md](references/code-blocks.md) |
| Click animations, motion, transitions, markers, drawing | [references/animations.md](references/animations.md) |
| Built-in components, layouts, global context | [references/components-layouts.md](references/components-layouts.md) |
| Export formats, build output, hosting | [references/exporting.md](references/exporting.md) |
| MCP server for AI agents | [references/mcp.md](references/mcp.md) |

## Common workflows

New deck, iterate, export PDF:

```bash
npm init slidev
slidev                       # dev server, edit slides.md, check localhost:3030
npm i -D playwright-chromium # once, for CLI export
slidev export --with-clicks  # PDF including click steps
```

Agent editing a live deck:

```bash
slidev &                     # dev server
# connect MCP client to http://localhost:3030/__mcp
# use slidev-list-slides / slidev-update-slide / slidev-insert-slide
```

Static site for GitHub Pages:

```bash
slidev build --base /<repo-name>/ --download
```

## Resources

- Documentation: https://sli.dev
- Syntax guide: https://sli.dev/guide/syntax
- Theme gallery: https://sli.dev/resources/theme-gallery
