---
id: ImageGenerationResult
title: ImageGenerationResult
---

# Interface: ImageGenerationResult

Defined in: packages/typescript/ai/src/types.ts:1218

Result of image generation

## Properties

### id

```ts
id: string;
```

Defined in: packages/typescript/ai/src/types.ts:1220

Unique identifier for the generation

***

### images

```ts
images: GeneratedImage[];
```

Defined in: packages/typescript/ai/src/types.ts:1224

Array of generated images

***

### model

```ts
model: string;
```

Defined in: packages/typescript/ai/src/types.ts:1222

Model used for generation

***

### usage?

```ts
optional usage: object;
```

Defined in: packages/typescript/ai/src/types.ts:1226

Token usage information (if available)

#### inputTokens?

```ts
optional inputTokens: number;
```

#### outputTokens?

```ts
optional outputTokens: number;
```

#### totalTokens?

```ts
optional totalTokens: number;
```
