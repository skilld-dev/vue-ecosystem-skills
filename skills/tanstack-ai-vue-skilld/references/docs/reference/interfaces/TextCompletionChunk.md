---
id: TextCompletionChunk
title: TextCompletionChunk
---

# Interface: TextCompletionChunk

Defined in: types.ts:956

## Properties

### content

```ts
content: string;
```

Defined in: types.ts:959

***

### finishReason?

```ts
optional finishReason: "length" | "stop" | "content_filter" | null;
```

Defined in: types.ts:961

***

### id

```ts
id: string;
```

Defined in: types.ts:957

***

### model

```ts
model: string;
```

Defined in: types.ts:958

***

### role?

```ts
optional role: "assistant";
```

Defined in: types.ts:960

***

### usage?

```ts
optional usage: object;
```

Defined in: types.ts:962

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
