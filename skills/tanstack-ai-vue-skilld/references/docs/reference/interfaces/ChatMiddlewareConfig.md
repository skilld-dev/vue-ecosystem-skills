---
id: ChatMiddlewareConfig
title: ChatMiddlewareConfig
---

# Interface: ChatMiddlewareConfig

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:105

Chat configuration that middleware can observe or transform.
This is a subset of the chat engine's effective configuration
that middleware is allowed to modify.

## Properties

### maxTokens?

```ts
optional maxTokens: number;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:111

***

### messages

```ts
messages: ModelMessage<
  | string
  | ContentPart<unknown, unknown, unknown, unknown, unknown>[]
  | null>[];
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:106

***

### metadata?

```ts
optional metadata: Record<string, unknown>;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:112

***

### modelOptions?

```ts
optional modelOptions: Record<string, unknown>;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:113

***

### systemPrompts

```ts
systemPrompts: string[];
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:107

***

### temperature?

```ts
optional temperature: number;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:109

***

### tools

```ts
tools: Tool<SchemaInput, SchemaInput, string>[];
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:108

***

### topP?

```ts
optional topP: number;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:110
