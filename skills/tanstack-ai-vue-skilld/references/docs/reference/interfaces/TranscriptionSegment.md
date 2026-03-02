---
id: TranscriptionSegment
title: TranscriptionSegment
---

# Interface: TranscriptionSegment

Defined in: types.ts:1151

A single segment of transcribed audio with timing information.

## Properties

### confidence?

```ts
optional confidence: number;
```

Defined in: types.ts:1161

Confidence score (0-1), if available

***

### end

```ts
end: number;
```

Defined in: types.ts:1157

End time of the segment in seconds

***

### id

```ts
id: number;
```

Defined in: types.ts:1153

Unique identifier for the segment

***

### speaker?

```ts
optional speaker: string;
```

Defined in: types.ts:1163

Speaker identifier, if diarization is enabled

***

### start

```ts
start: number;
```

Defined in: types.ts:1155

Start time of the segment in seconds

***

### text

```ts
text: string;
```

Defined in: types.ts:1159

Transcribed text for this segment
