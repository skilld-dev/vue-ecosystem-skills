---
name: tanstack-ai-vue-skilld
description: "Vue hooks for TanStack AI. ALWAYS use when writing code importing \"@tanstack/ai-vue\". Consult for debugging, best practices, or modifying @tanstack/ai-vue, tanstack/ai-vue, tanstack ai-vue, tanstack ai vue, ai."
metadata:
  version: 0.6.7
  generated_at: 2026-03-18
  references_synced_at: 2026-03-18
---

# TanStack/ai `@tanstack/ai-vue`

> Vue hooks for TanStack AI

**Version:** 0.6.7 (Mar 2026)
**Deps:** @tanstack/ai-client@0.7.2
**Tags:** latest: 0.6.7 (Mar 2026)
## API Changes

This section documents version-specific API changes for @tanstack/ai-vue v0.6.1 (current v0.x series). This library is pre-1.0 — all v0.x releases are in scope.

- BREAKING: Monolithic adapter factories removed — `openai()`, `anthropic()`, etc. replaced by activity-specific functions: `openaiText('gpt-5.2')`, `openaiSummarize('gpt-5-mini')`, `openaiImage('dall-e-3')`, etc. Model name is now passed to the adapter factory, not to `chat()`. [source](./references/docs/guides/migration.md:L21)

- BREAKING: `model` parameter removed from `chat()` — model is now embedded in the adapter argument (e.g., `adapter: openaiText('gpt-5.2')` instead of `adapter: openai(), model: 'gpt-4'`). Passing `model` at the call site is silently ignored. [source](./references/docs/guides/migration.md:L50)

- BREAKING: Nested `options` object flattened — `chat({ options: { temperature, maxTokens, topP } })` must be changed to `chat({ temperature, maxTokens, topP })`. Nested options are silently discarded. [source](./references/docs/guides/migration.md:L151)

- BREAKING: `providerOptions` renamed to `modelOptions` — `chat({ providerOptions: { ... } })` must be updated to `chat({ modelOptions: { ... } })`. Silently ignored if not updated. [source](./references/docs/guides/migration.md:L191)

- BREAKING: `toResponseStream` renamed to `toServerSentEventsStream` and now returns `ReadableStream` instead of `Response` — must manually create `new Response(stream, { headers })`. `AbortController` is now a separate parameter: `toServerSentEventsStream(stream, abortController)`. [source](./references/docs/guides/migration.md:L244)

- BREAKING: `embedding()` function removed — embeddings support eliminated entirely. Use provider SDKs directly or vector DB native embedding APIs. [source](./references/docs/guides/migration.md:L318)

- BREAKING: `chat({ as: 'promise' })` replaced by separate `chatCompletion()` function — `as` option removed from `chat()`. `chat({ as: 'stream' })` is now just `chat()`. `chat({ as: 'response' })` is now `chat()` + `toServerSentEventsStream()`. [source](./references/releases/CHANGELOG.md:L310)

- NEW: `useChat` returns `status` reactive ref — tracks lifecycle as `'ready' | 'submitted' | 'streaming' | 'error'`. Previously there was no generation lifecycle state. [source](./references/releases/@tanstack/ai-vue@0.4.0.md:L11)

- NEW: `sendMessage()` accepts `MultimodalContent` object — `sendMessage({ content: [{ type: 'text', content: '...' }, { type: 'image', source: { type: 'url', value: '...' } }] })` enables image/audio/video/document content alongside text. Added in v0.5.0. [source](./references/releases/@tanstack/ai-vue@0.5.0.md:L10)

- NEW: `agentLoopStrategy` parameter replaces bare `maxIterations: number` — use `agentLoopStrategy: maxIterations(5)`, `untilFinishReason(['stop'])`, or `combineStrategies([...])`. Old `maxIterations` number is converted automatically but deprecated. [source](./references/releases/CHANGELOG.md:L263)

- NEW: `toolDefinition({ name, description, inputSchema, outputSchema?, needsApproval? })` — creates isomorphic tool definitions. Call `.server(fn)` for server-side execution or `.client(fn)` for client-side execution. Replaces ad-hoc tool objects. [source](./references/docs/api/ai.md:L74)

- NEW: `@tanstack/ai-client` package — `ChatClient` class provides framework-agnostic headless chat state management with `sendMessage()`, `reload()`, `stop()`, `clear()`, `addToolResult()`, `addToolApprovalResponse()` methods. [source](./references/releases/CHANGELOG.md:L26)

- NEW: Connection adapter factories — `fetchServerSentEvents(url, options?)`, `fetchHttpStream(url, options?)`, `stream(fn)` from `@tanstack/ai-client`. Pass to `useChat({ connection: fetchServerSentEvents('/api/chat') })` instead of `url: '/api/chat'`. [source](./references/releases/CHANGELOG.md:L203)

- NEW: `extendAdapter(factory, customModels)` + `createModel(name, modalities)` — adds custom/fine-tuned model names to existing adapter factories with full type inference. Avoids `as const` casts. [source](./references/docs/reference/functions/extendAdapter.md:L1)

**Also changed:** `clientTools(...tools)` NEW (typed tool array, discriminated union narrowing) · `createChatClientOptions(options)` NEW · `InferChatMessages<T>` NEW · `toServerSentEventsResponse(stream, init?)` NEW (returns `Response`) · `toHttpStream(stream)` NEW · `toHttpResponse(stream)` NEW · `assertMessages({ adapter }, messages)` NEW (type-level assertion) · `ThinkingStreamChunk` NEW (chunk type for model reasoning)

## Best Practices

- `useChat` returns `DeepReadonly<ShallowRef<T>>` refs — never reassign `messages` directly; use `setMessages()` for manual updates. Changing `connection` or `body` options recreates the underlying `ChatClient`, requiring a component remount or a `key` prop change to take effect

- Use `status` (added v0.4.0) instead of `isLoading` for granular lifecycle control — `status.value` tracks `'ready' | 'submitted' | 'streaming' | 'error'`, enabling distinct UI states for submission vs. active streaming [source](./references/releases/@tanstack/ai-vue@0.4.0.md:L11)

- Pass client tool arrays through `clientTools()` instead of `as const` — eliminates the need for const assertion while enabling full discriminated union narrowing on `part.name`, `part.input`, and `part.output` in message iteration [source](./references/docs/api/ai-client.md#clienttoolstools)

- Wrap `useChat` options with `createChatClientOptions()` and derive message types using `InferChatMessages<typeof chatOptions>` — this propagates tool types through the entire message type, making `part.name` a literal union and `part.input`/`part.output` typed from Zod schemas [source](./references/docs/api/ai-client.md#createchatclientoptionsoptions)

- Define tools with `toolDefinition()` in a shared file, then call `.server()` in route handlers and `.client()` in Vue components — passing the bare definition to `chat()` signals the client will execute it, while passing `.server()` output executes it server-side automatically [source](./references/docs/guides/tools.md#isomorphic-tool-architecture)

- Use Zod schemas (v4.2+) over raw JSON Schema for `inputSchema`/`outputSchema` in `toolDefinition()` and `chat({ outputSchema })` — JSON Schema infers `any` for tool inputs/outputs and `unknown` for structured output return types, losing all downstream type safety [source](./references/docs/guides/tools.md#schema-options)

- Set `agentLoopStrategy: maxIterations(n)` explicitly when tools are present — the default is 5 iterations, which is too low for multi-step agentic workflows; use `untilFinishReason('stop')` to exit as soon as the model finishes without hitting the limit [source](./references/docs/api/ai.md#maxiterationscount)

- Subscribe to `aiEventClient` with `{ withEventTarget: true }` in production code — without this third argument the client only emits to the devtools event bus (absent in production builds); the flag also dispatches to the current `EventTarget` for application-level observability [source](./references/docs/guides/observability.md#client-events)

- Prefer `fetchServerSentEvents` over `fetchHttpStream` for client connections — SSE provides automatic reconnection; pass URL and options as functions (not static values) when headers like `Authorization` must be re-evaluated on every request [source](./references/docs/guides/connection-adapters.md#dynamic-values)

- Use `extendAdapter(baseFactory, [createModel('model-name', ['text', 'image'])])` to add TypeScript types for fine-tuned models or OpenAI-compatible proxies — this adds the model to the adapter's allowed type union with zero runtime overhead while preserving all original factory config parameters [source](./references/docs/guides/extend-adapter.md#basic-usage)
