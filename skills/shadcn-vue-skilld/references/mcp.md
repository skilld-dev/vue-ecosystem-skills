# MCP server

Source: `dist/mcp-C5R50TEt.js:63-117` (tool list), `dist/index.js:2620-2660` (clients), `dist/index.js:2696` (`mcp init`). Corroborated with https://www.shadcn-vue.com/docs/mcp.

## Setup

```bash
pnpm dlx shadcn-vue@latest mcp init --client claude
```

`--client` accepts `claude` (writes `.mcp.json`), `cursor` (`.cursor/mcp.json`), `vscode` (`.vscode/mcp.json`). Without `--client` the CLI prompts.

Manual config, any client:

```json
{ "mcpServers": { "shadcnVue": { "command": "npx", "args": ["shadcn-vue@latest", "mcp"] } } }
```

Codex needs a manual `~/.codex/config.toml` entry; the CLI cannot update it. Opencode config lives in `opencode.json` under `mcp.shadcnVue`.

Restart the client after config changes.

## Tools

| Tool | Input | Purpose |
| --- | --- | --- |
| `get_project_registries` | none | Registry names configured in `components.json` |
| `list_items_in_registries` | `registries[]`, `limit?`, `offset?` | List items |
| `search_items_in_registries` | `registries[]`, `query`, `limit?`, `offset?` | Fuzzy search names and descriptions |
| `view_items_in_registries` | `items[]` (e.g. `['@shadcn/button']`) | Item detail with file contents |
| `get_item_examples_from_registries` | `registries[]`, `query` | Full demo code; query patterns like `button-demo`, `card example` |
| `get_add_command_for_items` | `items[]` | Ready-to-run `add` command |
| `get_audit_checklist` | none | Post-generation verification checklist |

Most tools require a `components.json`; without one they return an error telling you to initialize the project first. Configure extra registries in `components.json` under `registries`; use `get_item_examples_from_registries` after finding an item, since `view_items_in_registries` does not return examples.

## Namespaces

Default namespace: `@shadcn`. Add more in `components.json`:

```json
{ "registries": { "@acme": "https://acme.com/r/{name}.json" } }
```

Private registries authenticate through header env vars such as `${REGISTRY_TOKEN}`; define them in `.env.local`.
