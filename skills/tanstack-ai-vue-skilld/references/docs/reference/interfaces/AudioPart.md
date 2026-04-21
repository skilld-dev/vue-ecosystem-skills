---
id: AudioPart
title: AudioPart
---

# Interface: AudioPart\<TMetadata\>

Defined in: packages/typescript/ai/src/types.ts:201

Audio content part for multimodal messages.

## Type Parameters

### TMetadata

`TMetadata` = `unknown`

Provider-specific metadata type

## Properties

### metadata?

```ts
optional metadata: TMetadata;
```

Defined in: packages/typescript/ai/src/types.ts:206

Provider-specific metadata (e.g., format, sample rate)

***

### source

```ts
source: ContentPartSource;
```

Defined in: packages/typescript/ai/src/types.ts:204

Source of the audio content

***

### type

```ts
type: "audio";
```

Defined in: packages/typescript/ai/src/types.ts:202
