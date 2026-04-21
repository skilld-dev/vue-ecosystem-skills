---
id: RealtimeAudioPart
title: RealtimeAudioPart
---

# Interface: RealtimeAudioPart

Defined in: packages/typescript/ai/src/realtime/types.ts:102

Audio content part in a realtime message

## Properties

### audioData?

```ts
optional audioData: ArrayBuffer;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:107

Raw audio data (optional, if stored)

***

### durationMs?

```ts
optional durationMs: number;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:109

Duration of the audio in milliseconds

***

### transcript

```ts
transcript: string;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:105

Transcription of the audio

***

### type

```ts
type: "audio";
```

Defined in: packages/typescript/ai/src/realtime/types.ts:103
