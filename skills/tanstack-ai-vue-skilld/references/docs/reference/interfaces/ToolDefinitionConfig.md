---
id: ToolDefinitionConfig
title: ToolDefinitionConfig
---

# Interface: ToolDefinitionConfig\<TInput, TOutput, TName\>

Defined in: packages/typescript/ai/src/activities/chat/tools/tool-definition.ts:90

Tool definition configuration

## Type Parameters

### TInput

`TInput` *extends* [`SchemaInput`](../type-aliases/SchemaInput.md) = [`SchemaInput`](../type-aliases/SchemaInput.md)

### TOutput

`TOutput` *extends* [`SchemaInput`](../type-aliases/SchemaInput.md) = [`SchemaInput`](../type-aliases/SchemaInput.md)

### TName

`TName` *extends* `string` = `string`

## Properties

### description

```ts
description: string;
```

Defined in: packages/typescript/ai/src/activities/chat/tools/tool-definition.ts:96

***

### inputSchema?

```ts
optional inputSchema: TInput;
```

Defined in: packages/typescript/ai/src/activities/chat/tools/tool-definition.ts:97

***

### lazy?

```ts
optional lazy: boolean;
```

Defined in: packages/typescript/ai/src/activities/chat/tools/tool-definition.ts:100

***

### metadata?

```ts
optional metadata: Record<string, unknown>;
```

Defined in: packages/typescript/ai/src/activities/chat/tools/tool-definition.ts:101

***

### name

```ts
name: TName;
```

Defined in: packages/typescript/ai/src/activities/chat/tools/tool-definition.ts:95

***

### needsApproval?

```ts
optional needsApproval: boolean;
```

Defined in: packages/typescript/ai/src/activities/chat/tools/tool-definition.ts:99

***

### outputSchema?

```ts
optional outputSchema: TOutput;
```

Defined in: packages/typescript/ai/src/activities/chat/tools/tool-definition.ts:98
