---
name: tanstack-ai-vue-skilld
description: Use when writing or debugging Vue code that imports @tanstack/ai-vue. Covers useChat, createChatHook, the generation composables (image, audio, speech, video, transcription, summarize), useAudioRecorder, useByok, useWebMCPTools, and the @tanstack/ai-vue/ui and /byok subpaths. Provides current API shapes, reactive-state rules, and version limits for @tanstack/ai-vue 0.24.x.
---

# @tanstack/ai-vue

Vue 3 composables for TanStack AI streaming chat, structured outputs, and media generation. Wraps the headless `@tanstack/ai-client` classes (`ChatClient`, `GenerationClient`, `VideoGenerationClient`) in reactive state.

- Version documented: `0.24.3` (source: `package.json:3`)
- Peer deps: `vue >=3.5.0`, `@tanstack/ai ^0.58.0`; runtime deps: `@tanstack/ai-client ^0.33.2`, `@tanstack/markdown ^0.0.13` (source: `package.json:55-62`)
- Entry points: `.` (main), `./ui` (headless chat UI factory), `./byok` (bring-your-own-key) (source: `package.json:23-36`)
- Official docs: https://tanstack.com/ai/latest/docs/api/ai-vue and https://tanstack.com/ai/latest/docs/getting-started/quick-start-vue
- Install: `pnpm add @tanstack/ai @tanstack/ai-vue @tanstack/ai-openai` (plus a provider adapter; server-side chat comes from `@tanstack/ai`)

## Core rules

1. Every composable must run inside a component setup or effect scope. Cleanup is automatic via `onScopeDispose`; the scope owns the connection (source: `src/use-chat.ts:259-269`).
2. All reactive state is `DeepReadonly<ShallowRef<T>>`. Read with `.value` in script AND template. Never reassign; use the returned methods (`setMessages`, `clear`, `reset`) (source: `src/use-chat.ts:425-457`).
3. Pass a `connection` adapter (for example `fetchServerSentEvents('/api/chat')`, re-exported from this package) or a `fetcher`. Generation hooks throw `useGeneration requires either a connection or fetcher option` without one (source: `src/use-generation.ts:272-274`).
4. `useChat` builds one `ChatClient` per call. Changing `connection` (or other transport identity) requires a remount or a changed `key` prop; `body`, `forwardedProps`, `context`, and `queue` are watched and synced live (source: `src/types.ts:77-79`, `src/use-chat.ts:212-230`).
5. Callback options (`onChunk`, `onFinish`, `onError`, ...) are read through the options object at call time, so reactive or mutated options propagate without recreating the client (source: `src/use-chat.ts:85-91`).
6. Prefer `forwardedProps` over `body`; `body` is deprecated but still merged into the same wire payload (source: `src/use-chat.ts:207-209`).

## Quick start: streaming chat

Server (Express or any backend returning TanStack AI SSE):

```ts
import { chat, toServerSentEventsResponse } from '@tanstack/ai'
import { openaiText } from '@tanstack/ai-openai'

app.post('/api/chat', async (req, res) => {
  const stream = chat({ adapter: openaiText('gpt-4o'), messages: req.body.messages })
  const response = toServerSentEventsResponse(stream)
  // pipe response.body to res
})
```

Client component:

```vue
<script setup lang="ts">
import { ref } from 'vue'
import { useChat, fetchServerSentEvents } from '@tanstack/ai-vue'

const input = ref('')
const { messages, sendMessage, isLoading } = useChat({
  connection: fetchServerSentEvents('/api/chat'),
})

function handleSubmit() {
  if (input.value.trim() && !isLoading.value) {
    sendMessage(input.value)
    input.value = ''
  }
}
</script>

<template>
  <div v-for="message in messages.value" :key="message.id">
    <div v-for="(part, idx) in message.parts" :key="idx">
      <p v-if="part.type === 'text'">{{ part.content }}</p>
    </div>
  </div>
  <form @submit.prevent="handleSubmit">
    <input v-model="input" :disabled="isLoading.value" />
    <button type="submit">Send</button>
  </form>
</template>
```

Source: official quick start, https://tanstack.com/ai/latest/docs/getting-started/quick-start-vue

## Typed tools

Define tools once with `toolDefinition()` from `@tanstack/ai`, implement `.client(fn)` in components, and wrap them in `clientTools()` (re-exported here from `@tanstack/ai-client`) so `part.name`, `part.input`, and `part.output` narrow without `as const`. Client tools execute automatically; there is no `onToolCall` option. Derive message types with `createChatClientOptions` + `InferChatMessages` (both re-exported). Source: https://tanstack.com/ai/latest/docs/api/ai-vue

```vue
<script setup lang="ts">
import { useChat, fetchServerSentEvents, clientTools } from '@tanstack/ai-vue'
import { updateUIDef } from './tool-definitions'

const updateUI = updateUIDef.client((input) => {
  notification.value = input.message
  return { success: true }
})

const { messages, sendMessage } = useChat({
  connection: fetchServerSentEvents('/api/chat'),
  tools: clientTools(updateUI),
})
</script>
```

## Shared chat hook

`createChatHook(options)` (root entry) binds options at module scope and returns a `useChat` composable. Override only `threadId`, `live`, `forwardedProps`, `body`, and `initialMessages` per instance; `tools`, `interrupts`, and `outputSchema` stay on the factory options. Rename at the call site if it clashes with the imported `useChat` (source: `src/create-chat-hook.ts:28-45`).

```ts
const { useChat: useAppChat } = createChatHook(chatOptions)
const chat = useAppChat({ threadId: 'support-1' })
```

## Generation composables

All follow one pattern: pass `connection` or `fetcher`, call `generate(input)`, read reactive state.

| Composable | Input type | Result type | Extras |
| --- | --- | --- | --- |
| `useGeneration` | custom `TInput` | custom `TResult` | base composable for custom types |
| `useGenerateImage` | `ImageGenerateInput` | `ImageGenerationResult` | |
| `useGenerateAudio` | `AudioGenerateInput` | `AudioGenerationResult` | |
| `useGenerateSpeech` | `SpeechGenerateInput` | `TTSResult` | |
| `useTranscription` | `TranscriptionGenerateInput` | `TranscriptionResult` | |
| `useSummarize` | `SummarizeGenerateInput` | `SummarizationResult` | |
| `useGenerateVideo` | `VideoGenerateInput` | `VideoGenerateResult` | `jobId`, `videoStatus`, `onJobCreated`, `onStatusUpdate` |

Common return: `generate`, `result`, `isLoading`, `error`, `status`, `stop`, `reset`, `runId`. Details, transforms, and persistence: [references/generation-composables.md](./references/generation-composables.md)

`stop()` only aborts the local stream. It does not stop work already running on the provider; use `runId` against your own endpoint to cancel or poll (source: `src/use-generation.ts:124-131`).

## Chat UI (`@tanstack/ai-vue/ui`)

Build chat interfaces with `createChatHook` from the `/ui` subpath (not the deprecated prebuilt components `Chat`, `ChatInput`, `ChatMessage`, `ChatMessages`, `ToolApproval`, deprecated since 0.3.0, removal planned for 1.0.0). The subpath also exports renderless `UIChat`, `UIProvider`, `UIMessages`, `UIMessage`, `UIPart`, `UIInterrupts`, `UIQueue`, and `createChatUI` / `createChatHookContexts`. This subpath ships as raw `.ts`/`.vue` source, so it is type-checked against your tsconfig (source: `package.json:28-31`, `src/ui.ts:2-33`, `src/chat-ui/types.ts:5`).

Guide: [references/chat-ui.md](./references/chat-ui.md)

## BYOK and WebMCP

- `useByok(client)` turns a `ByokClient` into a reactive `ByokSnapshot`; build the client with `defineByok`, `ByokClient`, `passkeyStorage`, and friends from the `/byok` subpath. Keys travel in `x-byok-*` headers, never the request body (source: `src/use-byok.ts:5-14`, `src/use-generation.ts:35-38`).
- `useWebMCPTools([searchProducts])` registers executable client tools with WebMCP for the current scope; disposal unregisters them (source: `src/use-web-mcp-tools.ts:27-55`).

Guide: [references/byok-and-webmcp.md](./references/byok-and-webmcp.md)

## Troubleshooting

- State not updating in templates: these are `ShallowRef`s. Use `isLoading.value` inside templates too.
- `useChat` ignored an option change: transport identity (`connection`, `threadId` persistence shape) is fixed per instance. Remount or change the component `key` (source: `src/types.ts:77-79`).
- Approval response rejected: `addToolApprovalResponse` takes the approval id (`part.approval.id`), not the tool call id (source: `src/types.ts:193-199`).
- Hydrated nothing on reload: persistence requires a stable `threadId`; without one the client mints an id after mount and the chat stays ephemeral (source: `src/use-chat.ts:101-103`).

## References

- [useChat API](./references/use-chat.md): options, full return shape, structured outputs, interrupts, queue, live mode, resume.
- [Generation composables](./references/generation-composables.md): `useGeneration` and the six specialized hooks, `onResult` transforms, persistence, `useAudioRecorder`.
- [Chat UI](./references/chat-ui.md): the `/ui` subpath, factory config, renderless components, migration off deprecated components.
- [BYOK and WebMCP](./references/byok-and-webmcp.md): the `/byok` subpath, `useByok`, `useWebMCPTools`.
