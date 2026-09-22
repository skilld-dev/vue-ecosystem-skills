# Registries and programmatic API

## Item addressing

Every `add`, `view`, and `docs` argument resolves through one address parser (`dist/registry-hxzbzXMt.js:1870-1891`, `dist/registry/index.d.ts:4-23`). Order: URL, local file, `@namespace/item`, GitHub, then default registry.

| Form | Scheme | Notes |
| --- | --- | --- |
| `https://host/r/button.json` | `url` | Fetched directly |
| `./button.json` | `file` | Read from disk |
| `@acme/button` | `namespace` | `acme` must exist under `registries` in `components.json` |
| `owner/repo/button` | `github` | Public repo with root `registry.json` |
| `owner/repo/button#v1.2.0` | `github` | `#ref` pins branch, tag, or commit |
| `button` | `shadcn` | Default registry, current style |

GitHub details (https://www.shadcn-vue.com/docs/registry/getting-started#install-from-github):

- Item names may contain slashes: `owner/repo/forms/login` is the item named `forms/login`.
- All files of one item come from one commit; a moving branch cannot yield a half-updated component.
- Repos must be public; `git ls-remote` resolves the default branch, so git is required.
- Absolute paths and `..` escapes in `files[].path` and `target` are rejected. This is a guard, not a sandbox. Registry items can declare npm dependencies, so install only from sources you trust.

## Registry item file types

`registryItemFileSchema` (`dist/index-BbVosT4_.d.ts:522-552`) discriminates on `type`:

- `registry:file`, `registry:page`: require `target`.
- `registry:lib`, `registry:block`, `registry:component`, `registry:ui`, `registry:hook`, `registry:composable`, `registry:theme`, `registry:style`, `registry:item`, `registry:base`, `registry:font`, `registry:example`, `registry:internal`: optional `target`.

Schemas: https://shadcn-vue.com/schema/registry.json and https://shadcn-vue.com/schema/registry-item.json.

## Errors

`shadcn-vue/registry` exports typed error classes (`dist/registry/index.d.ts:70-177`). Base class `RegistryError` carries `code`, `statusCode`, `context`, `suggestion`. Codes: `NETWORK_ERROR`, `NOT_FOUND`, `UNAUTHORIZED`, `FORBIDDEN`, `FETCH_ERROR`, `NOT_CONFIGURED`, `INVALID_CONFIG`, `MISSING_ENV_VARS`, `LOCAL_FILE_ERROR`, `SOURCE_FILE_ERROR`, `PARSE_ERROR`, `VALIDATION_ERROR`, `UNKNOWN_ERROR`.

Specific classes include `RegistryItemNotFoundError`, `RegistryNotConfiguredError`, `RegistryMissingEnvironmentVariablesError`, `RegistryValidationError`, `RegistryFetchError`. `MISSING_ENV_VARS` fires when a configured registry header references an unset env var.

## Programmatic API

Export map (`package.json:27-59`):

| Entry | Exports |
| --- | --- |
| `shadcn-vue` | Registry fetch helpers: `getRegistry`, `getRegistryItems`, `getShadcnRegistryIndex`, `getRegistryStyles`, `getRegistryBaseColors`, `getRegistryFonts`, `getRegistryIconLibraries`, `getRegistryPresets`, `getRegistryPreset`, `resolveTree`, `resolveRegistryItems`, `fetchTree`, `getItemTargetPath` (`dist/index.d.ts:1-2`) |
| `shadcn-vue/registry` | `resolveItemAddress`, `resolveGitHubRegistrySource`, `fetchGitHubRegistryItem`, `fetchGitHubRegistryCatalog`, `searchRegistries`, `getRegistriesIndex`, plus the error classes |
| `shadcn-vue/schema` | Zod schemas: `registryItemSchema`, `registrySchema`, `rawConfigSchema`, `configSchema`, `presetSchema`, `registryItemFileSchema`, `searchResultsSchema`, `workspaceConfigSchema` and more (`dist/schema/index.d.ts:2`) |
| `shadcn-vue/utils` | `createStyleMap`, `transformStyle`, `transformIcons`, `transformMenu` (`dist/utils/index.d.ts:36`) |
| `shadcn-vue/icons` | `iconLibraries` map with packages, import strings, and usage per library (`dist/icons/index.d.ts:2-43`) |
| `shadcn-vue/preset` | `encodePreset`, `decodePreset`, `isPresetCode`, `isValidPreset`, `generateRandomPreset`, `PRESET_*` vocabularies (`dist/preset/index.d.ts:36`) |
| `shadcn-vue/mcp` | `server`, a configured MCP `Server` instance (`dist/mcp/index.d.ts:38`) |
| `shadcn-vue/tailwind.css` | Base CSS: accordion and collapsible keyframes for the `@theme inline` block (`dist/tailwind.css`) |

Example:

```ts
import { resolveItemAddress, getRegistryItems } from 'shadcn-vue/registry'

const address = resolveItemAddress('@acme/button')
// { scheme: 'namespace', namespace: 'acme', item: 'button' }

const [item] = await getRegistryItems(['button'], { useCache: true })
```

`getRegistryItems` accepts `config` (partial `Config`) and `useCache` (`dist/api-FMEhYJfG.d.ts:170`).
