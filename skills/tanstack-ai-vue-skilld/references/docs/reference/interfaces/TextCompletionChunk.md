---
id: TextCompletionChunk
title: TextCompletionChunk
---

# Interface: TextCompletionChunk

Defined in: packages/typescript/ai/src/types.ts:1147

## Properties

### content

```ts
content: string;
```

Defined in: packages/typescript/ai/src/types.ts:1150

***

### finishReason?

```ts
optional finishReason: "length" | "stop" | "content_filter" | null;
```

Defined in: packages/typescript/ai/src/types.ts:1152

***

### id

```ts
id: string;
```

Defined in: packages/typescript/ai/src/types.ts:1148

***

### model

```ts
model: string;
```

Defined in: packages/typescript/ai/src/types.ts:1149

***

### role?

```ts
optional role: "assistant";
```

Defined in: packages/typescript/ai/src/types.ts:1151

***

### usage?

```ts
optional usage: object;
```

Defined in: packages/typescript/ai/src/types.ts:1153

#### completionTokens

```ts
completionTokens: number;
```

#### promptTokens

```ts
promptTokens: number;
```

#### totalTokens

```ts
totalTokens: number;
```
