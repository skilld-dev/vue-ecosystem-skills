---
id: ModelMessage
title: ModelMessage
---

# Interface: ModelMessage\<TContent\>

Defined in: packages/typescript/ai/src/types.ts:288

## Type Parameters

### TContent

`TContent` *extends* `string` \| `null` \| [`ContentPart`](../type-aliases/ContentPart.md)[] = `string` \| `null` \| [`ContentPart`](../type-aliases/ContentPart.md)[]

## Properties

### content

```ts
content: TContent;
```

Defined in: packages/typescript/ai/src/types.ts:295

***

### name?

```ts
optional name: string;
```

Defined in: packages/typescript/ai/src/types.ts:296

***

### role

```ts
role: "user" | "assistant" | "tool";
```

Defined in: packages/typescript/ai/src/types.ts:294

***

### toolCallId?

```ts
optional toolCallId: string;
```

Defined in: packages/typescript/ai/src/types.ts:298

***

### toolCalls?

```ts
optional toolCalls: ToolCall[];
```

Defined in: packages/typescript/ai/src/types.ts:297
