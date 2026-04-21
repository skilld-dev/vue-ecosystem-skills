---
id: StreamProcessorOptions
title: StreamProcessorOptions
---

# Interface: StreamProcessorOptions

Defined in: packages/typescript/ai/src/activities/chat/stream/processor.ts:99

Options for StreamProcessor

## Properties

### chunkStrategy?

```ts
optional chunkStrategy: ChunkStrategy;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/processor.ts:100

***

### events?

```ts
optional events: StreamProcessorEvents;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/processor.ts:102

Event-driven handlers

***

### initialMessages?

```ts
optional initialMessages: UIMessage[];
```

Defined in: packages/typescript/ai/src/activities/chat/stream/processor.ts:109

Initial messages to populate the processor

***

### jsonParser?

```ts
optional jsonParser: object;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/processor.ts:103

#### parse()

```ts
parse: (jsonString) => any;
```

##### Parameters

###### jsonString

`string`

##### Returns

`any`

***

### recording?

```ts
optional recording: boolean;
```

Defined in: packages/typescript/ai/src/activities/chat/stream/processor.ts:107

Enable recording for replay testing
