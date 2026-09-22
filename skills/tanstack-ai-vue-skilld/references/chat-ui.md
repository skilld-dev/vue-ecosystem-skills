# Chat UI: `@tanstack/ai-vue/ui`

The `/ui` subpath ships as raw source (`src/ui.ts` points at `.vue`/`.ts` files in `src/chat-ui/`), so it is type-checked against the consumer's tsconfig and needs `@vitejs/plugin-vue` (or equivalent) in the build (source: `package.json:28-31`).

## createChatHook (UI variant)

From `@tanstack/ai-vue/ui`. Binds chat options and UI widgets once at module scope; returns `{ useAppChat, ui, useChatContext }` (source: `src/chat-ui/create-chat-hook.ts:36-64`).

```ts
import { createChatHook } from '@tanstack/ai-vue/ui'

export const { useAppChat, ui, useChatContext } = createChatHook({
  options: chatOptions, // same options object shape as useChat
  components: { layout, message, input },
  partsComponents: { text: TextPart, fallback: FallbackPart },
  toolsComponents: { getProducts: GetProductsTool },
  interruptsComponents: { generic: { fallback: InterruptCard } },
})
```

- Pass instance overrides (`threadId`, `live`, `forwardedProps`, `body`, `initialMessages`) into `useAppChat()`; widgets and tools stay on the factory.
- Pass `ui` into `UIChat`. Part and interrupt widgets receive props; do not read those from context.

Component config shape (source: `src/chat-ui/create-ui.ts:100-151`):

- `components` (chrome): `layout` (required), `message` (required), `input?`, `queue?`.
- `partsComponents`: map of part-type keys (`text`, `thinking`, ...) to components, plus optional `fallback`.
- `toolsComponents`: map of tool name to component; required per tool name when tools are named (typed).
- `interruptsComponents`: `{ tools?: { [toolName]?: Component }, generic: { [interruptId]?: Component, fallback?: Component } }`; `generic` is required when interrupts are named.
- `context?: ChatUIContextConfig`: custom injection keys for cross-file widgets or nested chat trees.

The layout component receives four slots: `messages`, `interrupts`, `queue`, `input` (source: `src/chat-ui/create-ui.ts:621-642`).

## Renderless components

For custom composition, all exported from the subpath (source: `src/chat-ui/create-ui.ts:414-643`):

- `UIProvider` (props `ui`, `chat`, `components?`): provides the chat instance and component registry.
- `UIChat` (props `ui`, `chat`, `components?`): `UIProvider` + your `layout` with the standard slots wired.
- `UIMessages` (prop `ui`): renders one `UIMessage` per message; scoped slot `{ messages }`.
- `UIMessage` (props `ui`, `message`, `interrupts?`): renders the message component with an automatic parts slot.
- `UIPart` (props `ui`, `part`): renders a single part through the registry.
- `UIInterrupts` / `UIInterrupt` / `UIQueue`: interrupt list, single interrupt card, queued-message list with `cancelQueued` bound per item.

`createChatUI(options, config)` builds the `UIDescriptor` (injection keys + context composables) when you need the registry without the bound hook. `createChatHookContexts()` creates fresh injection keys for widget files that cannot import the factory result, or for nested chats needing isolated providers (source: `src/chat-ui/create-ui.ts:305-405`).

Widgets thrown outside a provider fail with `Chat UI components must be wrapped in UIProvider or UIChat.` (source: `src/chat-ui/create-ui.ts:246-254`).

## Prop types for widgets

Exported from the subpath (source: `src/chat-ui/types.ts`): `ThinkingPartProps` (`content`, `class?`, `isComplete?`) and `TextPartProps` (`content`, `role?`, `class?`, `userClass?`, `assistantClass?`, `extensions?`, `highlighter?`). `TextPartProps.highlighter` output is inserted as trusted HTML; use only a highlighter that escapes source text, for example `createTanStackMarkdownHighlighter` from `@tanstack/highlight/markdown` (source: `src/chat-ui/types.ts:89-111`).

Tool widgets receive `part`, optional `result`, optional approval `interrupt` (`ToolProps`); interrupt widgets receive `interrupt` (`InterruptProps`) (source: `src/chat-ui/create-ui.ts:64-83`).

## Deprecated prebuilt components

`Chat`, `ChatInput`, `ChatMessage`, `ChatMessages`, `ThinkingPart`, `TextPart`, `ToolApproval`, and the old `useChatContext`/`CHAT_KEY` context are deprecated since 0.3.0 with removal planned for 1.0.0. Migrate to `createChatHook()` from `@tanstack/ai-vue/ui` (source: `src/chat-ui/chat.vue:2`, `src/chat-ui/types.ts:5-113`, `src/chat-ui/use-chat-context.ts:8`). The old `@tanstack/ai-vue-ui` package name is also deprecated in favor of these subpaths (source: `README.md:259`).
