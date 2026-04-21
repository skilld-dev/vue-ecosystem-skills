---
id: VADConfig
title: VADConfig
---

# Interface: VADConfig

Defined in: packages/typescript/ai/src/realtime/types.ts:8

Voice activity detection configuration

## Properties

### prefixPaddingMs?

```ts
optional prefixPaddingMs: number;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:12

Audio to include before speech detection (ms)

***

### silenceDurationMs?

```ts
optional silenceDurationMs: number;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:14

Silence duration to end turn (ms)

***

### threshold?

```ts
optional threshold: number;
```

Defined in: packages/typescript/ai/src/realtime/types.ts:10

Sensitivity threshold (0.0-1.0)
