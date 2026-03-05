---
id: RunErrorEvent
title: RunErrorEvent
---

# Interface: RunErrorEvent

Defined in: types.ts:791

Emitted when an error occurs during a run.

## Extends

- [`BaseAGUIEvent`](BaseAGUIEvent.md)

## Properties

### error

```ts
error: object;
```

Defined in: types.ts:796

Error details

#### code?

```ts
optional code: string;
```

#### message

```ts
message: string;
```

***

### model?

```ts
optional model: string;
```

Defined in: types.ts:750

Model identifier for multi-model support

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`model`](BaseAGUIEvent.md#model)

***

### rawEvent?

```ts
optional rawEvent: unknown;
```

Defined in: types.ts:752

Original provider event for debugging/advanced use cases

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`rawEvent`](BaseAGUIEvent.md#rawevent)

***

### runId?

```ts
optional runId: string;
```

Defined in: types.ts:794

Run identifier (if available)

***

### timestamp

```ts
timestamp: number;
```

Defined in: types.ts:748

#### Inherited from

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`timestamp`](BaseAGUIEvent.md#timestamp)

***

### type

```ts
type: "RUN_ERROR";
```

Defined in: types.ts:792

#### Overrides

[`BaseAGUIEvent`](BaseAGUIEvent.md).[`type`](BaseAGUIEvent.md#type)
