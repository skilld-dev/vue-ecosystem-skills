# CLI reference

Source: `dist/index.js` (2.8.2). Corroborated with https://www.shadcn-vue.com/docs/cli.
Options marked **dist only** exist in 2.8.2 but not on the docs CLI page; the prepared source wins.

Run form: `pnpm dlx shadcn-vue@latest <command>` (also `npx shadcn-vue@latest`).

## init (alias: create)

Initializes the project: writes `components.json`, installs dependencies, adds the `cn` util, sets up CSS variables (`dist/index.js:1531`).

```bash
pnpm dlx shadcn-vue@latest init
pnpm dlx shadcn-vue@latest init -d          # defaults, no prompts
pnpm dlx shadcn-vue@latest init -p nova     # named preset
pnpm dlx shadcn-vue@latest create -t nuxt   # scaffold with template
```

Options (`dist/index.js:1531`):

| Option | Values / default |
| --- | --- |
| `-p, --preset [preset]` | named preset, encoded preset code, or preset URL |
| `-t, --template <template>` | `nuxt`, `vite`, `astro`, `laravel` |
| `--base <base>` | `reka` |
| `--style <style>` | visual style, see styles reference |
| `--icon-library <lib>` | `lucide`, `tabler`, `hugeicons`, `phosphor`, `remixicon` |
| `--font <font>` | font name, see styles reference |
| `-b, --base-color <color>` | base color |
| `-n, --name <name>` | new project name |
| `-d, --defaults` | use default configuration (false) |
| `-y, --yes` | skip confirmation (true) |
| `-f, --force` | overwrite existing configuration (false) |
| `-c, --cwd <cwd>` | working directory |
| `-s, --silent` | mute output (false) |
| `--src-dir` / `--no-src-dir` | use `src/` for new projects |
| `--css-variables` / `--no-css-variables` | CSS variables theming (true) |
| `--no-base-style` | skip the base style item |
| `--reinstall` / `--no-reinstall` | re-install existing UI components |
| `--rtl` / `--no-rtl` | RTL support |
| `--pointer` / `--no-pointer` | pointer cursor on buttons |

Without flags the CLI prompts interactively; "Custom" opens the preset builder at `https://shadcn-vue.com/create` (`dist/registry-hxzbzXMt.js:3290-3310`).

## add

Adds items and their dependencies (`dist/index.js:2007`). Bare names install from the default registry. Address forms:

| Form | Resolves to |
| --- | --- |
| `button` | default `@shadcn` registry item |
| `@acme/button` | item in a registry configured under `registries` |
| `https://acme.com/r/button.json` | registry item at that URL |
| `./button.json` | registry item on disk |
| `owner/repo/button` | item in the root `registry.json` of a public GitHub repo |
| `owner/repo/button#v1.0.0` | same, pinned to branch, tag, or commit |

Options: `-y` (skip confirm, false), `-o, --overwrite`, `-c, --cwd`, `-a, --all`, `-p, --path <path>`, `-s, --silent`, `--css-variables` / `--no-css-variables`, and **dist only**: `--dry-run` (preview without writing), `--diff [path]` (show diff for a file), `--view [path]` (show file contents).

No arguments opens an interactive component picker.

## apply

Applies a preset to an existing project (`dist/index.js:2196`). Accepts a named preset, an encoded preset code, or a preset URL, positional or via `--preset`. Options: `-y`, `-c`, `-s`.

Requires an initialized project; otherwise the CLI tells you to run `init` first. Applying overwrites UI components, fonts, and CSS variables, and re-installs every detected UI component. Commit or stash before continuing (`dist/index.js:2252-2260`).

## view

Shows item metadata and file contents before install (`dist/index.js:3088`). Accepts multiple names or URLs.

```bash
pnpm dlx shadcn-vue@latest view button card dialog
pnpm dlx shadcn-vue@latest view @acme/auth
```

## search (alias: list)

Fuzzy-searches registries (`dist/index.js:3037`). Registry args must be `@`-prefixed names or URLs. Options: `-c`, `-q, --query`, `-l, --limit` (100), `-o, --offset` (0).

```bash
pnpm dlx shadcn-vue@latest search @shadcn -q "dialog"
pnpm dlx shadcn-vue@latest search owner/repo    # list a GitHub registry
```

## docs

Fetches docs, API references, and usage examples for components (`dist/index.js:2551`). Options: `-c`, `-b, --base` (defaults to project base), `--json`.

```bash
pnpm dlx shadcn-vue@latest docs accordion
```

## info

Reports project setup (`dist/index.js:2597`). Options: `-c`, `--json`.

## diff

Compares an installed component against the registry (`dist/index.js:2446`). Options: `-y`, `-c`. **Dist only**; not on the docs CLI page.

```bash
pnpm dlx shadcn-vue@latest diff button
```

## migrate

Runs a code migration (`dist/index.js:3001`). Migrations at 2.8.2 (`dist/index.js:2987-2993`):

| Migration | Effect |
| --- | --- |
| `icons` | Rewrites UI components to a different icon library |
| `rtl` | Sets `rtl: true` in `components.json`, maps physical utilities to logical ones (`ml-4` to `ms-4`, `text-left` to `text-start`), adds `rtl:` variants (`space-x-4` to `space-x-4 rtl:space-x-reverse`) |

Options: `-c`, `-l, --list`, `-y`. Second argument is a file path or glob; default scope is the `ui` alias directory.

```bash
pnpm dlx shadcn-vue@latest migrate icons
pnpm dlx shadcn-vue@latest migrate rtl "src/components/ui/**"
```

## build

Builds registry JSON from `registry.json` (`dist/index.js:2406`). Arguments: `[registry]` path (default `./registry.json`). Options: `-o, --output` (default `./public/r`), `-c`.

See https://www.shadcn-vue.com/docs/registry/getting-started and https://www.shadcn-vue.com/docs/registry/registry-json.

## mcp

MCP server and configuration commands (`dist/index.js:2676`). `mcp init` writes client config; `--client` accepts `claude`, `cursor`, `vscode` (`dist/index.js:2620-2660`). Running `shadcn-vue mcp` alone starts the server over stdio.

Details: [MCP reference](./mcp.md).
