# BYOK and WebMCP

## useByok(client)

From the root entry. Takes a `ByokClient` instance and returns a reactive `DeepReadonly<ShallowRef<ByokSnapshot>>` that updates on every keyring change and unsubscribes on scope dispose (source: `src/use-byok.ts:5-14`).

```ts
import { useByok } from '@tanstack/ai-vue'
import { ByokClient } from '@tanstack/ai-vue/byok'

const client = new ByokClient({ /* storage, provider registry */ })
const snapshot = useByok(client)
```

## The `/byok` subpath

Re-exports the BYOK toolkit from `@tanstack/ai-client/byok` (source: `src/byok.ts:1-25`):

- Classes and factories: `ByokClient`, `defineByok`, `defineByokProvider`.
- Storage: `passkeyStorage`, `memoryStorage`, `defaultByokStorage`, `isPasskeyStorageSupported`, `PasskeyStorageOptions`.
- Crypto: `encryptKeyring`, `decryptKeyring`, `deriveAesKey`, `EMPTY_BYOK_SNAPSHOT`.
- Types: `ByokSnapshot`, `ByokProvider`, `ByokProviderInit`, `ByokPrompt`, `DefineByokOptions`, `KeyPreview`, `KeyStatus`, `Keyring`, `KeyringStorage`.

## Wiring BYOK into hooks

Both `useChat` and every generation composable accept `byok?: ByokClient` and `byokProvider?: () => ProviderId | undefined`. Keys travel in `x-byok-*` request headers, never the body. `byokProvider` is a getter: if it returns a slug only that key is sent; if no slug resolves (`byokProvider`, then `body.provider`), generation throws (source: `src/use-generation.ts:35-38`).

```ts
const { generate, result } = useGenerateImage({
  connection: fetchServerSentEvents('/api/generate/image'),
  byok: client,
  byokProvider: () => selectedProvider.value,
})
```

## useWebMCPTools(tools, options?)

From the root entry. Registers executable client tools with WebMCP for the current Vue scope; scope disposal aborts registration and removes every tool registered by the call (source: `src/use-web-mcp-tools.ts:27-55`).

```ts
useWebMCPTools([searchProducts], {
  onError: (error) => console.error('WebMCP registration failed', error),
})
```

- `tools`: the executable client tools to expose (build with `clientTools` or individual `.client()` implementations).
- `options`: `RegisterWebMCPToolsOptions` minus `signal` (managed internally) plus `onError?: (error: unknown) => void` for async registration failures (source: `src/use-web-mcp-tools.ts:9-16`).
- Options are optional when the inferred options type is empty (conditional tuple parameter, source: `src/use-web-mcp-tools.ts:18-24`).
