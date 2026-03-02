---
id: ImageGenerationResult
title: ImageGenerationResult
---

# Interface: ImageGenerationResult

Defined in: types.ts:999

Result of image generation

## Properties

### id

```ts
id: string;
```

Defined in: types.ts:1001

Unique identifier for the generation

***

### images

```ts
images: GeneratedImage[];
```

Defined in: types.ts:1005

Array of generated images

***

### model

```ts
model: string;
```

Defined in: types.ts:1003

Model used for generation

***

### usage?

```ts
optional usage: object;
```

Defined in: types.ts:1007

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
