---
id: TranscriptionResult
title: TranscriptionResult
---

# Interface: TranscriptionResult

Defined in: packages/typescript/ai/src/types.ts:1400

Result of audio transcription.

## Properties

### duration?

```ts
optional duration: number;
```

Defined in: packages/typescript/ai/src/types.ts:1410

Duration of the audio in seconds

***

### id

```ts
id: string;
```

Defined in: packages/typescript/ai/src/types.ts:1402

Unique identifier for the transcription

***

### language?

```ts
optional language: string;
```

Defined in: packages/typescript/ai/src/types.ts:1408

Language detected or specified

***

### model

```ts
model: string;
```

Defined in: packages/typescript/ai/src/types.ts:1404

Model used for transcription

***

### segments?

```ts
optional segments: TranscriptionSegment[];
```

Defined in: packages/typescript/ai/src/types.ts:1412

Detailed segments with timing, if available

***

### text

```ts
text: string;
```

Defined in: packages/typescript/ai/src/types.ts:1406

The full transcribed text

***

### words?

```ts
optional words: TranscriptionWord[];
```

Defined in: packages/typescript/ai/src/types.ts:1414

Word-level timestamps, if available
