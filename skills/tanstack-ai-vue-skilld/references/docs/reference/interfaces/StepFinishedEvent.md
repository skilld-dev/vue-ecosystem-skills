---
id: StepFinishedEvent
title: StepFinishedEvent
---

# Interface: StepFinishedEvent

Defined in: packages/typescript/ai/src/types.ts:969

Emitted when a thinking/reasoning step finishes.

@ag-ui/core provides: `stepName`
TanStack AI adds: `model?`, `stepId?` (deprecated alias), `delta?`, `content?`

## Extends

- `StepFinishedEvent`

## Indexable

```ts
[k: string]: unknown
```

## Properties

### content?

```ts
optional content: string;
```

Defined in: packages/typescript/ai/src/types.ts:980

Full accumulated thinking content (TanStack AI internal)

***

### delta?

```ts
optional delta: string;
```

Defined in: packages/typescript/ai/src/types.ts:978

Incremental thinking content (TanStack AI internal)

***

### model?

```ts
optional model: string;
```

Defined in: packages/typescript/ai/src/types.ts:971

Model identifier for multi-model support

***

### ~~stepId?~~

```ts
optional stepId: string;
```

Defined in: packages/typescript/ai/src/types.ts:976

#### Deprecated

Use `stepName` instead (from @ag-ui/core spec).
Kept for backward compatibility.
