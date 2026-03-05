---
id: InferToolInput
title: InferToolInput
---

# Type Alias: InferToolInput\<T\>

```ts
type InferToolInput<T> = T extends object ? TInput extends StandardJSONSchemaV1<infer TInferred, unknown> ? TInferred : TInput extends JSONSchema ? unknown : unknown : unknown;
```

Defined in: activities/chat/tools/tool-definition.ts:67

Extract the input type from a tool (inferred from Standard JSON Schema, or `unknown` for plain JSONSchema)

## Type Parameters

### T

`T`
