# CLI

Binary `vitepress` (`bin/vitepress.js` → `dist/node/cli.js`). Commands are
parsed with minimist; the first positional is the command, the second is the
root directory (`dist/node/cli.js:411-415`).

## Commands

### `vitepress dev [root]`

Dev server; defaults to the current directory. The `dev` keyword is optional
when using the current directory (`dist/node/cli.js:417`).

| Flag | Effect |
| --- | --- |
| `--open [path]` | Open browser on startup |
| `--port <port>` | Port to listen on |
| `--base <path>` | Public base path, default `/` |
| `--cors` | Enable CORS |
| `--strictPort` | Exit if the port is taken |
| `--force` | Re-bundle deps; mapped to `optimizeDeps.force` (`dist/node/cli.js:418-421`) |

### `vitepress build [root]`

Static build, output to `<root>/.vitepress/dist` by default.

| Flag | Effect |
| --- | --- |
| `--mpa` | MPA mode without hydration (experimental) |
| `--base <path>` | Public base path |
| `--target <target>` | Transpile target, default `modules` |
| `--outDir <dir>` | Output dir relative to cwd |
| `--minify [minifier]` | `boolean \| terser \| esbuild`, default `esbuild` |
| `--assetsInlineLimit <n>` | Base64 inline threshold in bytes, default `4096` |

### `vitepress preview [root]` (alias: `vitepress serve [root]`)

Serves the production build locally (`dist/node/cli.js:472`). Flags:
`--base <path>`, `--port <port>`.

### `vitepress init [root]`

Interactive setup wizard (`dist/node/cli.js:454-456`). `ScaffoldThemeType`
choices: default theme, default theme + customization, custom theme
(`dist/node/index.d.ts:2475-2489`).

Unknown commands exit with `unknown command "<command>"` and status 1
(`dist/node/cli.js:482-484`).

## Dev server shortcuts

Bound only when stdin is a TTY and not in CI (`dist/node/cli.js:315-317`):

| Key | Action |
| --- | --- |
| `r` | Restart server (clears markdown and dep caches) |
| `u` | Show server URL |
| `o` | Open in browser |
| `c` | Clear console |
| `q` | Quit |
| `h` | Show help |

(`dist/node/cli.js:353-398`)

## Typical package.json scripts

```json
{
  "scripts": {
    "docs:dev": "vitepress dev",
    "docs:build": "vitepress build",
    "docs:preview": "vitepress preview"
  }
}
```

(https://vitepress.dev/guide/getting-started)

## Compatibility notes

- Node.js 18+ (https://vitepress.dev/guide/getting-started).
- VitePress v1 errors when running under `rolldown-vite`; use VitePress v2
  for that (`dist/node/cli.js:438-444`).
- Debug with `DEBUG=vitepress:*` (`dist/node/cli.js:400-402`) and
  `NODE_OPTIONS='--inspect-brk'` for the dev server.

Official reference: https://vitepress.dev/reference/cli
