# MCP Server for AI Agents

Source: `dist/cli.mjs`, `dist/stdio-BcdFsXyc.mjs`, tool names verified in
`dist/serve-DzvJFv6v.mjs`; behavior from the shipped skill reference.

Slidev ships a built-in MCP (Model Context Protocol) server that exposes
structured tools to read, edit, reorder, and navigate a deck. Prefer these
tools over raw text edits for slide-level operations: they handle Slidev's
compound `---` separators correctly and hot-reload the running presentation.

## Two modes

HTTP (dev server running, streamable transport):

```
http://localhost:<port>/__mcp
```

```bash
claude mcp add --transport http slidev http://localhost:3030/__mcp
```

Stdio (no dev server; operates on files directly, so no live navigation):

```bash
slidev mcp [entry]
```

Disable the server with `mcp: false` in headmatter.

## Tools

| Tool | Description |
|------|-------------|
| `slidev-get-info` | Deck overview: entry, title, slide count, markdown files, server URL, current position |
| `slidev-list-slides` | All slides with number, title, layout, source file |
| `slidev-get-slide` | Full source of one slide: frontmatter, content, note |
| `slidev-update-slide` | Update content, note, and/or frontmatter of a slide |
| `slidev-insert-slide` | Insert a new slide after an existing one |
| `slidev-remove-slide` | Remove a slide |
| `slidev-move-slide` | Move a slide before/after another to reorder the deck |
| `slidev-goto-slide` | Navigate the live presentation to a slide (HTTP mode only) |

## Behavior

- Slides are addressed by rendered 1-based numbers, as shown in the presentation.
- Edits are saved to the markdown files; a running dev server hot-reloads instantly.
- The first slide of the entry file cannot be removed or moved: its frontmatter is the deck headmatter.
- Slides imported via `src:` are edited in their own file; moves cannot cross files.

## Agent workflow

1. Start the dev server: `slidev` (port defaults to 3030).
2. Connect the MCP client to `http://localhost:3030/__mcp`.
3. `slidev-list-slides` to see the deck; `slidev-get-slide` before editing.
4. Edit with `slidev-update-slide` / `slidev-insert-slide` / `slidev-remove-slide` / `slidev-move-slide`.
5. Verify visually at `http://localhost:3030`.
