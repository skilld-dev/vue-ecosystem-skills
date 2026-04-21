---
id: RealtimeToken
title: RealtimeToken
---

# Interface: RealtimeToken

Defined in: packages/typescript/ai/src/realtime/types.ts:58

Token returned by the server for client authentication

## Properties

### config

```ts
config: RealtimeSessionConfig;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:66

Session configuration embedded in the token

***

### expiresAt

```ts
expiresAt: number;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:64

Token expiration timestamp (ms since epoch)

***

### provider

```ts
provider: string;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:60

Provider identifier

***

### token

```ts
token: string;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:62

The ephemeral token value
