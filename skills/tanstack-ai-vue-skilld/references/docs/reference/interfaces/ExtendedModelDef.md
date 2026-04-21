---
id: ExtendedModelDef
title: ExtendedModelDef
---

# Interface: ExtendedModelDef\<TName, TInput, TOptions\>

Defined in: packages/typescript/ai/src/extend-adapter.ts:21

Definition for a custom model to add to an adapter.

## Example

```typescript
const customModels = [
  createModel('my-custom-model', ['text', 'image']),
] as const
```

## Type Parameters

### TName

`TName` *extends* `string` = `string`

The model name as a literal string type

### TInput

`TInput` *extends* `ReadonlyArray`\<[`Modality`](../type-aliases/Modality.md)\> = `ReadonlyArray`\<[`Modality`](../type-aliases/Modality.md)\>

Array of supported input modalities

### TOptions

`TOptions` = `unknown`

Provider options type for this model

## Properties

### input

```ts
input: TInput;
```

Defined in: packages/typescript/ai/src/extend-adapter.ts:29

Supported input modalities for this model

***

### modelOptions

```ts
modelOptions: TOptions;
```

Defined in: packages/typescript/ai/src/extend-adapter.ts:31

Type brand for provider options - use `{} as YourOptionsType`

***

### name

```ts
name: TName;
```

Defined in: packages/typescript/ai/src/extend-adapter.ts:27

The model name identifier
