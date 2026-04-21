---
id: ProcessorResult
title: ProcessorResult
---

# Interface: ProcessorResult

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:70

Result from processing a stream

## Properties

### content

```ts
content: string;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:71

***

### finishReason?

```ts
optional finishReason: string | null;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:74

***

### thinking?

```ts
optional thinking: string;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:72

***

### toolCalls?

```ts
optional toolCalls: ToolCall[];
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:73
