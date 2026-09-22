# components.json

Source: `dist/index-BbVosT4_.d.ts:29-90` (`rawConfigSchema`). Corroborated with https://www.shadcn-vue.com/docs/components-json.

The file sits at the project root. It is required only for CLI use; copy-and-paste installs do not need it. Create it with `init`.

`$schema`: `https://shadcn-vue.com/schema.json`.

## Fields

| Field | Type | Notes |
| --- | --- | --- |
| `style` | string | Registry style id. 2.8.2 composes `reka-<style>` for the seven visual styles (`dist/registry-hxzbzXMt.js:492-496`); fallback id `new-york-v4` (`dist/transform-menu-CLNZ5vUh.js:4`). Docs still show the legacy `new-york` value. |
| `typescript` | boolean, default true | `false` adds components as JavaScript `.vue` files |
| `font` | string, optional | Body font name |
| `fontHeading` | string, optional | Heading font name |
| `iconLibrary` | string, optional | One of the five supported libraries |
| `rtl` | boolean, default false | RTL support |
| `pointer` | boolean | Pointer cursor on buttons |
| `menuColor` | `default` \| `inverted` \| `default-translucent` \| `inverted-translucent` | Menu styling |
| `menuAccent` | `subtle` \| `bold` | Menu accent |
| `tailwind.config` | string, optional | Tailwind config path. Leave blank on Tailwind v4. |
| `tailwind.css` | string | CSS entry that imports Tailwind |
| `tailwind.baseColor` | string | Default palette |
| `tailwind.cssVariables` | boolean, default true | `false` uses utility classes for theming |
| `tailwind.prefix` | string, optional | Utility prefix, e.g. `tw-` |
| `aliases.components` | string | e.g. `@/components` |
| `aliases.utils` | string | e.g. `@/lib/utils` |
| `aliases.ui` | string, optional | UI install directory, e.g. `@/app/ui` |
| `aliases.lib` | string, optional | e.g. `@/lib` |
| `aliases.hooks` | string, optional | |
| `aliases.composables` | string, optional | e.g. `@/composables` |
| `registries` | record, optional | Namespaced registries, see below |

The CLI combines `aliases` with `paths` from `tsconfig.json` or `jsconfig.json` to place files. If you use a `src/` directory, include it under `paths`.

## Example

```json
{
  "$schema": "https://shadcn-vue.com/schema.json",
  "style": "reka-vega",
  "typescript": true,
  "tailwind": {
    "config": "",
    "css": "assets/index.css",
    "baseColor": "neutral",
    "cssVariables": true,
    "prefix": ""
  },
  "iconLibrary": "lucide",
  "aliases": {
    "components": "@/components",
    "composables": "@/composables",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib"
  },
  "registries": {
    "@acme": "https://acme.com/r/{name}.json"
  }
}
```

## registries

Values are a URL template string, or an object with `url`, `params`, and `headers` (`dist/index-BbVosT4_.d.ts:81-90`). `{name}` is replaced with the item name. Header values support `${ENV_VAR}` interpolation; missing vars raise `MISSING_ENV_VARS` at fetch time.

```json
{
  "registries": {
    "@acme": "https://acme.com/r/{name}.json",
    "@internal": {
      "url": "https://internal.company.com/{name}.json",
      "headers": { "Authorization": "Bearer ${REGISTRY_TOKEN}" }
    }
  }
}
```

The builtin `@shadcn` namespace needs no configuration; it resolves to `https://shadcn-vue.com/r/styles/{style}/{name}.json` (`dist/transform-menu-CLNZ5vUh.js:445`).

See also https://www.shadcn-vue.com/docs/registry/getting-started and https://www.shadcn-vue.com/docs/mcp#configuring-registries.
