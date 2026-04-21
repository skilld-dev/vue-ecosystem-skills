---
id: AbortInfo
title: AbortInfo
---

# Interface: AbortInfo

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:258

Information passed to onAbort.

## Properties

### duration

```ts
duration: number;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:262

Duration until abort in milliseconds

***

### reason?

```ts
optional reason: string;
```

Defined in: packages/typescript/ai/src/activities/chat/middleware/types.ts:260

The reason for the abort, if provided
