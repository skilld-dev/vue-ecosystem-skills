---
id: TranscriptionSegment
title: TranscriptionSegment
---

# Interface: TranscriptionSegment

Defined in: types.ts:1179

A single segment of transcribed audio with timing information.

## Properties

### confidence?

```ts
optional confidence: number;
```

Defined in: types.ts:1189

Confidence score (0-1), if available

***

### end

```ts
end: number;
```

Defined in: types.ts:1185

End time of the segment in seconds

***

### id

```ts
id: number;
```

Defined in: types.ts:1181

Unique identifier for the segment

***

### speaker?

```ts
optional speaker: string;
```

Defined in: types.ts:1191

Speaker identifier, if diarization is enabled

***

### start

```ts
start: number;
```

Defined in: types.ts:1183

Start time of the segment in seconds

***

### text

```ts
text: string;
```

Defined in: types.ts:1187

Transcribed text for this segment
