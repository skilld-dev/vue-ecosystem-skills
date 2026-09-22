# useChat API

`useChat(options?)` from the root entry. Wraps `ChatClient` from `@tanstack/ai-client`; all state is `DeepReadonly<ShallowRef<T>>`, all cleanup via `onScopeDispose` (source: `src/use-chat.ts:42-56`).

## Options

`UseChatOptions` extends `ChatClientOptions` minus the internal `on*Change` callbacks (those become refs) minus `context` and `devtools` shape (source: `src/types.ts:80-109`):

- `connection`: connection adapter. `fetchServerSentEvents`, `fetchHttpStream`, `xhrServerSentEvents`, `stream`, `rpcStream`, `webSocket` are re-exported from this package.
- `fetcher`: direct async call instead of a stream transport (one of `connection` / `fetcher`; `connection` wins, source: `src/use-chat.ts:97-99`).
- `tools`: client tool array. Build with `clientTools(...)` for literal-union narrowing.
- `initialMessages?: Array<UIMessage>`
- `threadId?: string`: stable identity for persistence and resume. Auto-generated when omitted, which makes the chat ephemeral (source: `src/use-chat.ts:101-103`).
- `persistence: true | ChatPersistenceOption`: with a `threadId`, hydrates history on mount. Persistence helpers re-exported: `localStoragePersistence`, `sessionStoragePersistence`, `indexedDBPersistence`.
- `history?: ` older-message window config; pairs with `loadOlderMessages`.
- `live?: boolean`: `true` subscribes the shared session on mount and unsubscribes on dispose; toggle it reactively to subscribe/unsubscribe (source: `src/use-chat.ts:232-242`).
- `forwardedProps?:` client-controlled JSON sent as `RunAgentInput.forwardedProps`. Watched; changes sync to the client. Replaces deprecated `body` (merged into the same payload).
- `queue?: QueueConfig`: send-while-busy policy (`WhenBusy`, `QueueStrategy`, `QueueOption` types re-exported).
- `interrupts`: interrupt definitions array.
- `outputSchema`: standard-schema schema (Zod, Valibot, ArkType, JSON Schema). Type-only on the client; the server validates against its own `chat({ outputSchema })` (source: `src/types.ts:71-108`).
- `byok?: ByokClient`, `byokProvider?: () => ProviderId | undefined`.
- `initialResumeSnapshot`: seed interrupt resume state.
- Callbacks, all optional, all read at call time: `onResponse`, `onChunk`, `onFinish`, `onError`, `onCustomEvent`, `onInterruptStateChange`.
- `devtools?: AIDevtoolsDisplayOptions`: display options for TanStack AI Devtools. `framework: 'vue'` and `hookName` are injected for you (source: `src/use-chat.ts:138-143`).
- `streamProcessor?`: stream processing config.

## Return

State refs (read with `.value`): `messages`, `isLoading`, `error`, `status` (`ChatClientState`), `isSubscribed`, `connectionStatus`, `sessionGenerating` (shared-session generation, unlike request-local `isLoading`), `queue`, `runId`, `hasOlderMessages`, `interrupts`, `interruptErrors`, `resuming`, `partial`, `final` (source: `src/types.ts:142-301`).

Methods: `sendMessage(content, options?)`, `append(message)`, `reload()`, `stop()`, `clear()`, `setMessages(messages)`, `addToolResult({ toolCallId, tool, output, state?, errorText? })`, `addToolApprovalResponse({ id, approved })`, `cancelQueued(id)`, `loadOlderMessages()`, `resolveInterrupts(...)`, `cancelInterrupts()`, `retryInterrupts()`, `resumeInterruptsUnsafe(resume, state?)`.

Deprecated: `pendingInterrupts` (use `interrupts`), `resumeInterrupts` (use the bound interrupt methods or `resumeInterruptsUnsafe`) (source: `src/types.ts:213-237`).

`sendMessage` accepts a string or `MultimodalContent` (text, image, audio, video, document parts), and `SendMessageOptions` carries `{ whenBusy }` per-send queue overrides and `{ body }` per-call forwarded JSON (source: `src/types.ts:156-165`).

## Structured outputs

Pass `outputSchema` on the client for typed `partial` / `final` refs; they are absent from the return type when you omit it (source: `src/types.ts:111-140`).

- `partial: DeepPartial<T>`: live progressively-parsed object derived from the structured-output part on the latest assistant message after the latest user message. Reads `{}` between `sendMessage()` and the first chunk (source: `src/use-chat.ts:380-413`).
- `final: T | null`: `null` until that part's status is `complete`.
- Server route must pass the same schema to `chat({ outputSchema })`; the client schema is inference only.

```ts
const { partial, final, sendMessage } = useChat({
  connection: fetchServerSentEvents('/api/extract'),
  outputSchema: z.object({ name: z.string(), age: z.number() }),
})
```

## Interrupts and tool approval

- `interrupts` lists active interrupts; `resuming` is true while a resume is in flight.
- `resolveInterrupts(true | false)` resolves all; or pass a resolver function returning `undefined` per interrupt.
- For tool approval parts (`part.type === 'tool-call'`, `part.state === 'approval-requested'`), call `addToolApprovalResponse({ id: part.approval.id, approved })`. The id is the approval id, not the toolCallId (source: `src/types.ts:193-199`).
- `runId` tracks the in-flight run (one user message can produce several run ids when interrupts split it). Use it to correlate with your server (source: `src/types.ts:200-212`).

Official docs: https://tanstack.com/ai/latest/docs/api/ai-vue (Tool Approval example) and https://tanstack.com/ai/latest/docs/tools/tool-approval

## Lifecycle

- `onMounted`: `client.attach()` opens the tail connection, devtools mount, interrupt resume state syncs (source: `src/use-chat.ts:244-255`).
- `onScopeDispose`: `detach()` (keeps transcript and resume pointer), `unsubscribe()` if live else `stop()`, then `dispose()` (source: `src/use-chat.ts:259-269`).
- Delivery-durability resume is transparent: the resumable SSE adapter reattaches via the browser's native `Last-Event-ID`.
