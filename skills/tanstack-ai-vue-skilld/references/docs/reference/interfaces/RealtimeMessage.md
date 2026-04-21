---
id: RealtimeMessage
title: RealtimeMessage
---

# Interface: RealtimeMessage

Defined in: packages/typescript/ai/src/realtime/types.ts:157

A message in a realtime conversation

## Properties

### audioId?

```ts
optional audioId: string;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:169

Reference to audio buffer if stored

***

### durationMs?

```ts
optional durationMs: number;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:171

Duration of the audio in milliseconds

***

### id

```ts
id: string;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:159

Unique message identifier

***

### interrupted?

```ts
optional interrupted: boolean;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:167

Whether this message was interrupted

***

### parts

```ts
parts: RealtimeMessagePart[];
```

Defined in: packages/typescript/ai/src/realtime/types.ts:165

Content parts of the message

***

### role

```ts
role: "user" | "assistant";
```

Defined in: packages/typescript/ai/src/realtime/types.ts:161

Message role

***

### timestamp

```ts
timestamp: number;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:163

Timestamp when the message was created
