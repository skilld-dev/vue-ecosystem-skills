# Offline documentation and API in the installed package

Quasar v2.33+ ships its documentation inside the npm package
(`dist/mcp/start/ai-agents.md:21`). Nothing needs to be fetched from quasar.dev.

## Documentation pages: `node_modules/quasar/dist/mcp/`

Markdown pages, one per topic, mirroring quasar.dev (`dist/mcp/meta.json`
indexes all 160 pages of 2.33.1 with `route`, `title`, `desc`, `keys`):

| Directory | Pages | Content |
| --- | --- | --- |
| `api/` | 152 | compact API page per component/plugin/directive |
| `vue-components/` | 72 | component guides |
| `quasar-plugins/` | 12 | plugin guides |
| `vue-directives/` | 11 | directive guides |
| `vue-composables/` | 13 | composable guides |
| `quasar-utils/` | 9 | util guides (date, colors, format, dom, scroll, ...) |
| `layout/` | 12 | layout and flexbox grid |
| `style/` | 11 | dark mode, spacing, typography, breakpoints, visibility |
| `options/` | 14 | i18n, icon sets, screen plugin, accessibility, RTL |
| `security/` | 1 | security dos and don'ts |
| `start/` | 5 | ai-agents, vite-plugin, umd, how-to-use-vue, browser support |

Since v2.33 the `dist/mcp/api/<Name>.md` pages inline the full prop, method,
event and slot tables in compact readable form. Guide pages under the other
directories still say "Not inlined here: call the `get_api` tool" for their API
section; for those, read the JSON descriptor instead.

Search examples (run in the project root):

```bash
rg -l "virtual-scroll" node_modules/quasar/dist/mcp
rg '"no-transition"' node_modules/quasar/dist/mcp/vue-components/tree.md
python3 -c "import json;print([p['route'] for p in json.load(open('node_modules/quasar/dist/mcp/meta.json'))['pages'] if 'QTable' in p['keys']])"
```

## API descriptors: `node_modules/quasar/dist/api/<Name>.json`

One JSON per component, plugin and directive (the full list is
`dist/transforms/api-list.json`; 152 entries: 123 components, 17 plugins, 11
directives, plus the internal `Brand` descriptor). Shape:

```json
{
  "type": "component",
  "meta": { "docsUrl": "..." },
  "injection": "$q.loading",
  "quasarConfOptions": { "definition": {} },
  "props": { "name": { "type": "Boolean", "default": "false", "desc": "...", "addedIn": "v2.28" } },
  "slots": {}, "events": {}, "methods": {}
}
```

- `props`, `slots`, `events`, `methods` are objects keyed by kebab-case name.
- `addedIn: "v2.XX"` marks APIs not present in older minors; guard version-
  specific advice with it. Nothing is marked `v2.33` yet (2.33.0/2.33.1 are
  fix-only releases).
- Plugin config goes through `quasarConfOptions.definition` (options accepted by
  `app.use(Quasar, { plugins: { X } })` / `$q.x.setDefaults`).

Read one member quickly:

```bash
python3 -c "import json;print(json.load(open('node_modules/quasar/dist/api/QSelect.json'))['props']['use-input'])"
```

## MCP server: `@quasar/mcp`

For MCP-capable agents, an MCP server serves the same docs for the exact
installed versions (`dist/mcp/start/ai-agents.md:4`, `:32-35`):

```json
{
  "mcpServers": {
    "quasar": { "command": "npx", "args": ["-y", "--fetch-retries=0", "@quasar/mcp@latest"] }
  }
}
```

Tools: `list_pages`, `search_docs`, `get_page`, `list_api`, `get_api`,
`check_updates` (`dist/mcp/start/ai-agents.md:99-104`). The update check runs in
the background at most once a day, never offline, and honors
`NO_UPDATE_NOTIFIER`.

Requirements: quasar UI v2.33+; `@quasar/app-vite` v3.9+ for the CLI pages
(`dist/mcp/start/ai-agents.md:9-10`). The server reads `node_modules` of the
project it is started in, works offline, and older quasar releases get `get_api`
only, no pages (`dist/mcp/start/ai-agents.md:109`). Official page:
https://quasar.dev/start/ai-agents
