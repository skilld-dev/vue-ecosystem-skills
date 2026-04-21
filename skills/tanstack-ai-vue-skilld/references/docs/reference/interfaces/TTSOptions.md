---
id: TTSOptions
title: TTSOptions
---

# Interface: TTSOptions\<TProviderOptions\>

Defined in: packages/typescript/ai/src/types.ts:1309

Options for text-to-speech generation.
These are the common options supported across providers.

## Type Parameters

### TProviderOptions

`TProviderOptions` *extends* `object` = `object`

## Properties

### format?

```ts
optional format: "mp3" | "opus" | "aac" | "flac" | "wav" | "pcm";
```

Defined in: packages/typescript/ai/src/types.ts:1317

The output audio format

***

### model

```ts
model: string;
```

Defined in: packages/typescript/ai/src/types.ts:1311

The model to use for TTS generation

***

### modelOptions?

```ts
optional modelOptions: TProviderOptions;
```

Defined in: packages/typescript/ai/src/types.ts:1321

Model-specific options for TTS generation

***

### speed?

```ts
optional speed: number;
```

Defined in: packages/typescript/ai/src/types.ts:1319

The speed of the generated audio (0.25 to 4.0)

***

### text

```ts
text: string;
```

Defined in: packages/typescript/ai/src/types.ts:1313

The text to convert to speech

***

### voice?

```ts
optional voice: string;
```

Defined in: packages/typescript/ai/src/types.ts:1315

The voice to use for generation
