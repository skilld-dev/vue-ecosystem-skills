---
id: AfterToolCallInfo
title: AfterToolCallInfo
---

# Interface: AfterToolCallInfo

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:154

Outcome information provided to onAfterToolCall.

## Properties

### duration

```ts
duration: number;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:166

Duration of tool execution in milliseconds

***

### error?

```ts
optional error: unknown;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:169

***

### ok

```ts
ok: boolean;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:164

Whether the execution succeeded

***

### result?

```ts
optional result: unknown;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:168

The result (if ok) or error (if not ok)

***

### tool

```ts
tool: 
  | Tool<SchemaInput, SchemaInput, string>
  | undefined;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:158

The resolved tool definition

***

### toolCall

```ts
toolCall: ToolCall;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:156

The tool call that was executed

***

### toolCallId

```ts
toolCallId: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:162

ID of the tool call

***

### toolName

```ts
toolName: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:160

Name of the tool
