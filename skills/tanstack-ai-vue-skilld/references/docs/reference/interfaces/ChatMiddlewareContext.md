---
id: ChatMiddlewareContext
title: ChatMiddlewareContext
---

# Interface: ChatMiddlewareContext

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:26

Stable context object passed to all middleware hooks.
Created once per chat() invocation and shared across all hooks.

## Properties

### abort()

```ts
abort: (reason?) => void;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:42

Abort the chat run with a reason

#### Parameters

##### reason?

`string`

#### Returns

`void`

***

### accumulatedContent

```ts
accumulatedContent: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:86

Accumulated text content for the current iteration

***

### chunkIndex

```ts
chunkIndex: number;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:38

Running count of chunks yielded so far

***

### context

```ts
context: unknown;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:44

Opaque user-provided value from chat() options

***

### conversationId?

```ts
optional conversationId: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:32

Conversation identifier, if provided by the caller

***

### createId()

```ts
createId: (prefix) => string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:93

Generate a unique ID with the given prefix

#### Parameters

##### prefix

`string`

#### Returns

`string`

***

### currentMessageId

```ts
currentMessageId: string | null;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:84

Current assistant message ID (changes per iteration)

***

### defer()

```ts
defer: (promise) => void;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:50

Defer a non-blocking side-effect promise.
Deferred promises do not block streaming and are awaited
after the terminal hook (onFinish/onAbort/onError).

#### Parameters

##### promise

`Promise`\<`unknown`\>

#### Returns

`void`

***

### hasTools

```ts
hasTools: boolean;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:79

Whether tools are configured

***

### iteration

```ts
iteration: number;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:36

Current agent loop iteration (0-indexed)

***

### messageCount

```ts
messageCount: number;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:77

Number of messages at the start of the request

***

### messages

```ts
messages: readonly ModelMessage<
  | string
  | ContentPart<unknown, unknown, unknown, unknown, unknown>[]
  | null>[];
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:91

Current messages array (read-only view)

***

### model

```ts
model: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:57

Model identifier (e.g., 'gpt-4o')

***

### modelOptions?

```ts
optional modelOptions: Record<string, unknown>;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:72

Provider-specific model options

***

### options?

```ts
optional options: Record<string, unknown>;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:70

Flattened generation options (temperature, topP, maxTokens, metadata)

***

### phase

```ts
phase: ChatMiddlewarePhase;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:34

Current lifecycle phase

***

### provider

```ts
provider: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:55

Provider name (e.g., 'openai', 'anthropic')

***

### requestId

```ts
requestId: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:28

Unique identifier for this chat request

***

### signal?

```ts
optional signal: AbortSignal;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:40

Abort signal from the chat request

***

### source

```ts
source: "client" | "server";
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:59

Source of the chat invocation — always 'server' for server-side chat

***

### streamId

```ts
streamId: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:30

Unique identifier for this stream

***

### streaming

```ts
streaming: boolean;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:61

Whether the chat is streaming

***

### systemPrompts

```ts
systemPrompts: string[];
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:66

System prompts configured for this chat

***

### toolNames?

```ts
optional toolNames: string[];
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:68

Names of configured tools, if any
