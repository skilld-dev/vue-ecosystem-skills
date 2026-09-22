---
name: shadcn-vue-skilld
description: Use when adding, configuring, or debugging shadcn-vue in a Vue or Nuxt project. Covers shadcn-vue CLI commands (init, add, apply, view, search, docs, info, diff, migrate, build, mcp), components.json, styles, presets, fonts, icon libraries, registries, the MCP server, and the programmatic API. Gives exact flags and config keys for shadcn-vue 2.8.2.
---

# shadcn-vue

Version: `shadcn-vue@2.8.2` (prepared source `package.json:4`; npm `latest` dist-tag, checked 2026-09-22).
Stack: Vue 3.5+, `reka-ui` ^2.10.1, Tailwind CSS ^4.3.2 (`package.json:68,88,91`). One base: `reka`.
Run the CLI with `pnpm dlx shadcn-vue@latest <command>` (or `npx`, `npm exec`, `bunx`).

## What it does

The CLI copies component source files into your project and installs their npm dependencies.
You own the copied code. Edit `components/ui/**` freely; re-running `add` with `-o, --overwrite` replaces your edits.

## Core workflow

```bash
# New or existing project: write components.json, install deps, set up CSS
pnpm dlx shadcn-vue@latest init

# Add components (also: URL, local file, @namespace/item, owner/repo/item)
pnpm dlx shadcn-vue@latest add button card dialog

# Preview without writing, then install
pnpm dlx shadcn-vue@latest add sidebar --dry-run
pnpm dlx shadcn-vue@latest add sidebar

# Usage docs and examples for a component
pnpm dlx shadcn-vue@latest docs button
```

## Rules that prevent bugs

- Item names resolve in this order: URL, local file, `@namespace/item`, `owner/repo/item[#ref]`, then plain name in the default registry (`dist/registry-hxzbzXMt.js:1870-1891`, https://www.shadcn-vue.com/docs/cli#add).
- Preset names have no prefix in 2.8.x: `vega`, `nova`, `maia`, `lyra`, `mira`, `luma`, `sera` (`dist/registry-hxzbzXMt.js:3141-3244`). Older docs and the 2.6.x baseline used `reka-vega` style names; those fail now. See [changes](./references/changes-2.7-2.8.md).
- `toast` and `toaster` are deprecated; use `sonner` (`dist/transform-menu-CLNZ5vUh.js:446-454`).
- `lucide-vue-next` is the legacy icon package; current lucide package is `@lucide/vue` (`dist/transform-menu-CLNZ5vUh.js:457`, `dist/icons/index.d.ts:3-10`). Run `migrate icons` to switch libraries.
- Registry style ids stay prefixed: the `vega` style fetches from `reka-vega` (`dist/registry-hxzbzXMt.js:492-496`). Fallback style id is `new-york-v4`.
- `apply <preset>` rewrites UI components, fonts, and CSS variables. Commit first; the CLI warns the same (`dist/index.js:2252-2254`).
- Registry env: `SHADCN_VUE_URL` and `REGISTRY_URL` override the default `https://shadcn-vue.com/r` (`dist/transform-menu-CLNZ5vUh.js:2-3`). Use for local registry testing.
- Builtin namespace is `@shadcn` (`dist/transform-menu-CLNZ5vUh.js:445`). Third-party namespaces must be configured in `components.json` under `registries`.

## Command map

| Command | Purpose | Key options |
| --- | --- | --- |
| `init` (alias `create`) | Set up project, write `components.json` | `-p <preset>`, `-t <template>`, `--style`, `--icon-library`, `--font`, `-b <base-color>`, `-d`, `--silent` |
| `add` | Install items | `-o`, `-a`, `-p <path>`, `--dry-run`, `--diff`, `--view` |
| `apply` | Apply a preset to an existing project | `-y` |
| `view` | Inspect items before install | `-c <cwd>` |
| `search` (alias `list`) | Fuzzy search registries (`@name` args) | `-q`, `-l`, `-o` |
| `docs` | Component docs and examples | `--json`, `-b <base>` |
| `info` | Project setup report | `--json` |
| `diff` | Compare installed item against registry | `-y` |
| `migrate` | `icons` or `rtl` migration | `-l`, `[path]` |
| `build` | Build `registry.json` into registry JSON | `-o <path>` |
| `mcp init` | Write MCP client config | `--client claude\|cursor\|vscode` |

Full flags: [cli reference](./references/cli.md).

## Configuration

`components.json` at project root drives everything. Key fields: `style`, `typescript`, `tailwind.css`, `tailwind.baseColor`, `aliases`, `iconLibrary`, `rtl`, `pointer`, `menuColor`, `menuAccent`, `registries`.
Full schema and examples: [components-json reference](./references/components-json.md).

## Styles and presets

Seven named presets (`vega` to `sera`), eight valid styles in encoded preset codes (adds `rhea`), five icon libraries, 24 fonts. Details and tables: [styles reference](./references/styles-and-presets.md).

## Programmatic API

Import from `shadcn-vue`, `shadcn-vue/registry`, `shadcn-vue/schema`, `shadcn-vue/utils`, `shadcn-vue/icons`, `shadcn-vue/preset`, `shadcn-vue/mcp`, `shadcn-vue/tailwind.css` (`package.json:27-59`).
Exports and error classes: [registries reference](./references/registries.md#programmatic-api).

## References

- [CLI reference](./references/cli.md)
- [components.json](./references/components-json.md)
- [Styles and presets](./references/styles-and-presets.md)
- [Registries and programmatic API](./references/registries.md)
- [MCP server](./references/mcp.md)
- [Changes in 2.7 and 2.8](./references/changes-2.7-2.8.md)
