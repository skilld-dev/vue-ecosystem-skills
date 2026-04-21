---
id: RealtimeTokenAdapter
title: RealtimeTokenAdapter
---

# Interface: RealtimeTokenAdapter

Defined in: packages/typescript/ai/src/realtime/types.ts:72

Adapter interface for generating provider-specific tokens

## Properties

### generateToken()

```ts
generateToken: () => Promise<RealtimeToken>;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:76

Generate an ephemeral token for client use

#### Returns

`Promise`\<[`RealtimeToken`](RealtimeToken.md)\>

***

### provider

```ts
provider: string;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:74

Provider identifier
