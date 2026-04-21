---
id: ProcessorState
title: ProcessorState
---

# Interface: ProcessorState

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:80

Current state of the processor

## Properties

### content

```ts
content: string;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:81

***

### done

```ts
done: boolean;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:86

***

### finishReason

```ts
finishReason: string | null;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:85

***

### thinking

```ts
thinking: string;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:82

***

### toolCallOrder

```ts
toolCallOrder: string[];
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:84

***

### toolCalls

```ts
toolCalls: Map<string, InternalToolCallState>;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/types.ts:83
