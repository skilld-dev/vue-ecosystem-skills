---
id: ImagePart
title: ImagePart
---

# Interface: ImagePart\<TMetadata\>

Defined in: packages/typescript/ai/src/types.ts:189

Image content part for multimodal messages.

## Type Parameters

### TMetadata

`TMetadata` = `unknown`

Provider-specific metadata type (e.g., OpenAI's detail level)

## Properties

### metadata?

```ts
optional metadata: TMetadata;
```

Defined in: packages/typescript/ai/src/types.ts:194

Provider-specific metadata (e.g., OpenAI's detail: 'auto' | 'low' | 'high')

***

### source

```ts
source: ContentPartSource;
```

Defined in: packages/typescript/ai/src/types.ts:192

Source of the image content

***

### type

```ts
type: "image";
```

Defined in: packages/typescript/ai/src/types.ts:190
