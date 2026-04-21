---
id: VideoPart
title: VideoPart
---

# Interface: VideoPart\<TMetadata\>

Defined in: packages/typescript/ai/src/types.ts:213

Video content part for multimodal messages.

## Type Parameters

### TMetadata

`TMetadata` = `unknown`

Provider-specific metadata type

## Properties

### metadata?

```ts
optional metadata: TMetadata;
```

Defined in: packages/typescript/ai/src/types.ts:218

Provider-specific metadata (e.g., duration, resolution)

***

### source

```ts
source: ContentPartSource;
```

Defined in: packages/typescript/ai/src/types.ts:216

Source of the video content

***

### type

```ts
type: "video";
```

Defined in: packages/typescript/ai/src/types.ts:214
