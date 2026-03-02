---
id: TTSResult
title: TTSResult
---

# Interface: TTSResult

Defined in: types.ts:1108

Result of text-to-speech generation.

## Properties

### audio

```ts
audio: string;
```

Defined in: types.ts:1114

Base64-encoded audio data

***

### contentType?

```ts
optional contentType: string;
```

Defined in: types.ts:1120

Content type of the audio (e.g., 'audio/mp3')

***

### duration?

```ts
optional duration: number;
```

Defined in: types.ts:1118

Duration of the audio in seconds, if available

***

### format

```ts
format: string;
```

Defined in: types.ts:1116

Audio format of the generated audio

***

### id

```ts
id: string;
```

Defined in: types.ts:1110

Unique identifier for the generation

***

### model

```ts
model: string;
```

Defined in: types.ts:1112

Model used for generation
