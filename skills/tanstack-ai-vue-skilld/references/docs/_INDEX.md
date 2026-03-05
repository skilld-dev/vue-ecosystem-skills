---
total: 227
---

# Docs Index

## adapters (7)

- [Anthropic](./adapters/anthropic.md): The Anthropic adapter provides access to Claude models, including Claude Sonnet 4.5, Claude Opus 4.5, and more.
- [fal.ai](./adapters/fal.md): The fal.ai adapter provides access to 600+ models on the fal.ai platform for image generation and video generation. Unlike text-focused adapters, t...
- [Google Gemini](./adapters/gemini.md): The Google Gemini adapter provides access to Google's Gemini models, including text generation, image generation with both Imagen and Gemini native...
- [Grok (xAI)](./adapters/grok.md): The Grok adapter provides access to xAI's Grok models, including Grok 4.1, Grok 4, Grok 3, and image generation with Grok 2 Image.
- [Ollama](./adapters/ollama.md): The Ollama adapter provides access to local models running via Ollama, allowing you to run AI models on your own infrastructure with full privacy a...
- [OpenAI](./adapters/openai.md): The OpenAI adapter provides access to OpenAI's models, including GPT-4o, GPT-5, image generation (DALL-E), text-to-speech (TTS), and audio transcri...
- [OpenRouter Adapter](./adapters/openrouter.md): The OpenRouter adapter provides access to 300+ AI models from various providers through a single unified API, including models from OpenAI, Anthrop...

## api (2)

- [@tanstack/ai-client](./api/ai-client.md): Framework-agnostic headless client for managing chat state and streaming.
- [@tanstack/ai](./api/ai.md): The core AI library for TanStack AI.

## community-adapters (5)

- [Cencori](./community-adapters/cencori.md): The Cencori adapter provides access to 14+ AI providers (OpenAI, Anthropic, Google, xAI, and more) through a unified interface with built-in securi...
- [Cloudflare](./community-adapters/cloudflare.md): The Cloudflare adapter provides access to Cloudflare Workers AI models and AI Gateway for routing requests to OpenAI, Anthropic, Gemini, Grok, and ...
- [Decart](./community-adapters/decart.md): The Decart adapter provides access to Decart's image and video generation models.
- [Community Adapters Guide](./community-adapters/guide.md): This guide explains how to create and contribute community adapters for the TanStack AI ecosystem.
- [Soniox](./community-adapters/soniox.md): The Soniox adapter provides access to Soniox transcription models.

## getting-started (3)

- [Devtools](./getting-started/devtools.md): TanStack Devtools is a unified devtools panel for inspecting and debugging TanStack libraries, including TanStack AI. It provides real-time insight...
- [Overview](./getting-started/overview.md): TanStack AI is a lightweight, type-safe SDK for building production-ready AI experiences. Its framework-agnostic core provides type-safe tool/funct...
- [Quick Start](./getting-started/quick-start.md): Get started with TanStack AI in minutes. This guide will walk you through creating a simple chat application using the React integration and OpenAI...

## guides (20)

- [Agentic Cycle](./guides/agentic-cycle.md): The agentic cycle is the pattern where the LLM repeatedly calls tools, receives results, and continues reasoning until it can provide a final answe...
- [Client Tools](./guides/client-tools.md): Client tools execute in the browser, enabling UI updates, local storage access, and browser API interactions. Unlike server tools, client tools don...
- [Connection Adapters](./guides/connection-adapters.md): Connection adapters handle the communication between your client and server for streaming chat responses. TanStack AI provides built-in adapters an...
- [Extending Adapters with Custom Models](./guides/extend-adapter.md): The extendAdapter utility allows you to extend existing adapter factories (like openaiText, anthropicText) with custom model names while maintainin...
- [Image Generation](./guides/image-generation.md): TanStack AI provides support for image generation through dedicated image adapters. This guide covers how to use the image generation functionality...
- [Migration Guide](./guides/migration.md): This guide helps you migrate from the previous version of TanStack AI to the latest version. The major changes focus on improved tree-shaking, clea...
- [Multimodal Content](./guides/multimodal-content.md): TanStack AI supports multimodal content in messages, allowing you to send images, audio, video, and documents alongside text to AI models that supp...
- [Observability](./guides/observability.md): The @tanstack/ai package offers you an event client for observability and debugging purposes.
It's a fully type-safe decoupled event-driven system ...
- [Per-Model Type Safety](./guides/per-model-type-safety.md): The AI SDK provides model-specific type safety for modelOptions. Each model's capabilities determine which model options are allowed, and TypeScrip...
- [Runtime Adapter Switching](./guides/runtime-adapter-switching.md): Learn how to build interfaces where users can switch between LLM providers at runtime while maintaining full TypeScript type safety.
- [Server Tools](./guides/server-tools.md): Server tools execute automatically when called by the LLM. They have full access to server resources like databases, APIs, and environment variables.
- [Streaming](./guides/streaming.md): TanStack AI supports streaming responses for real-time chat experiences. Streaming allows you to display responses as they're generated, rather tha...
- [Structured Outputs](./guides/structured-outputs.md): Structured outputs allow you to constrain AI model responses to match a specific JSON schema, ensuring consistent and type-safe data extraction. Ta...
- [Text-to-Speech](./guides/text-to-speech.md): TanStack AI provides support for text-to-speech generation through dedicated TTS adapters. This guide covers how to convert text into spoken audio ...
- [Tool Approval Flow](./guides/tool-approval.md): The tool approval flow allows you to require user approval before executing sensitive tools, giving users control over actions like sending emails,...
- [Tool Architecture](./guides/tool-architecture.md): The TanStack AI tool system provides a powerful, flexible architecture for enabling AI agents to interact with external systems:
- [Tools](./guides/tools.md): Tools (also called "function calling") allow AI models to interact with external systems, APIs, or perform computations. TanStack AI provides an is...
- [Transcription](./guides/transcription.md): TanStack AI provides support for audio transcription (speech-to-text) through dedicated transcription adapters. This guide covers how to convert sp...
- [Tree-Shaking](./guides/tree-shaking.md): TanStack AI is designed from the ground up for maximum tree-shakeability. The entire system—from activity functions to adapters—uses a functional, ...
- [Video Generation](./guides/video-generation.md): TanStack AI provides experimental support for video generation through dedicated video adapters. Unlike image generation, video generation is an as...

## protocol (3)

- [AG-UI Event Definitions](./protocol/chunk-definitions.md): TanStack AI implements the AG-UI (Agent-User Interaction) Protocol, an open, lightweight, event-based protocol that standardizes how AI agents conn...
- [HTTP Stream Protocol](./protocol/http-stream-protocol.md): HTTP streaming with newline-delimited JSON (NDJSON) is a simpler protocol than SSE that sends one JSON object per line. It's useful when:
- [Server-Sent Events (SSE) Protocol](./protocol/sse-protocol.md): Server-Sent Events (SSE) is a standard HTTP-based protocol for server-to-client streaming. It provides:

## reference/classes (8)

- [BatchStrategy](./reference/classes/BatchStrategy.md): Defined in: activities/chat/stream/strategies.ts:34
- [CompositeStrategy](./reference/classes/CompositeStrategy.md): Defined in: activities/chat/stream/strategies.ts:68
- [ImmediateStrategy](./reference/classes/ImmediateStrategy.md): Defined in: activities/chat/stream/strategies.ts:12
- [PartialJSONParser](./reference/classes/PartialJSONParser.md): Defined in: activities/chat/stream/json-parser.ts:25
- [PunctuationStrategy](./reference/classes/PunctuationStrategy.md): Defined in: activities/chat/stream/strategies.ts:22
- [StreamProcessor](./reference/classes/StreamProcessor.md): Defined in: activities/chat/stream/processor.ts:127
- [ToolCallManager](./reference/classes/ToolCallManager.md): Defined in: activities/chat/tools/tool-calls.ts:48
- [WordBoundaryStrategy](./reference/classes/WordBoundaryStrategy.md): Defined in: activities/chat/stream/strategies.ts:57

## reference/functions (34)

- [chat](./reference/functions/chat.md): Defined in: activities/chat/index.ts:1196
- [combineStrategies](./reference/functions/combineStrategies.md): Defined in: activities/chat/agent-loop-strategies.ts:79
- [convertMessagesToModelMessages](./reference/functions/convertMessagesToModelMessages.md): Defined in: activities/chat/messages.ts:63
- [convertSchemaToJsonSchema](./reference/functions/convertSchemaToJsonSchema.md): Defined in: activities/chat/tools/schema-converter.ts:199
- [createChatOptions](./reference/functions/createChatOptions.md): Defined in: activities/chat/index.ts:154
- [createImageOptions](./reference/functions/createImageOptions.md): Defined in: activities/generateImage/index.ts:205
- [createModel](./reference/functions/createModel.md): Defined in: extend-adapter.ts:61
- [createReplayStream](./reference/functions/createReplayStream.md): Defined in: activities/chat/stream/processor.ts:1124
- [createSpeechOptions](./reference/functions/createSpeechOptions.md): Defined in: activities/generateSpeech/index.ts:150
- [createSummarizeOptions](./reference/functions/createSummarizeOptions.md): Defined in: activities/summarize/index.ts:273
- [createTranscriptionOptions](./reference/functions/createTranscriptionOptions.md): Defined in: activities/generateTranscription/index.ts:150
- [createVideoOptions](./reference/functions/createVideoOptions.md): Defined in: activities/generateVideo/index.ts:317
- [detectImageMimeType](./reference/functions/detectImageMimeType.md): Defined in: utils.ts:17
- [extendAdapter](./reference/functions/extendAdapter.md): Defined in: extend-adapter.ts:166
- [generateImage](./reference/functions/generateImage.md): Defined in: activities/generateImage/index.ts:149
- [generateMessageId](./reference/functions/generateMessageId.md): Defined in: activities/chat/messages.ts:436
- [generateSpeech](./reference/functions/generateSpeech.md): Defined in: activities/generateSpeech/index.ts:103
- [generateTranscription](./reference/functions/generateTranscription.md): Defined in: activities/generateTranscription/index.ts:105
- [generateVideo](./reference/functions/generateVideo.md): Defined in: activities/generateVideo/index.ts:177
- [getVideoJobStatus](./reference/functions/getVideoJobStatus.md): Defined in: activities/generateVideo/index.ts:217
- [maxIterations](./reference/functions/maxIterations.md): Defined in: activities/chat/agent-loop-strategies.ts:20
- [modelMessagesToUIMessages](./reference/functions/modelMessagesToUIMessages.md): Defined in: activities/chat/messages.ts:364
- [modelMessageToUIMessage](./reference/functions/modelMessageToUIMessage.md): Defined in: activities/chat/messages.ts:305
- [normalizeToUIMessage](./reference/functions/normalizeToUIMessage.md): Defined in: activities/chat/messages.ts:413
- [parsePartialJSON](./reference/functions/parsePartialJSON.md): Defined in: activities/chat/stream/json-parser.ts:56
- [streamToText](./reference/functions/streamToText.md): Defined in: stream-to-response.ts:23
- [summarize](./reference/functions/summarize.md): Defined in: activities/summarize/index.ts:146
- [toHttpResponse](./reference/functions/toHttpResponse.md): Defined in: stream-to-response.ts:247
- [toHttpStream](./reference/functions/toHttpStream.md): Defined in: stream-to-response.ts:175
- [toolDefinition](./reference/functions/toolDefinition.md): Defined in: activities/chat/tools/tool-definition.ts:185
- [toServerSentEventsResponse](./reference/functions/toServerSentEventsResponse.md): Defined in: stream-to-response.ts:124
- [toServerSentEventsStream](./reference/functions/toServerSentEventsStream.md): Defined in: stream-to-response.ts:49
- [uiMessageToModelMessages](./reference/functions/uiMessageToModelMessages.md): Defined in: activities/chat/messages.ts:98
- [untilFinishReason](./reference/functions/untilFinishReason.md): Defined in: activities/chat/agent-loop-strategies.ts:41

## reference (1)

- [@tanstack/ai](./reference/index.md)

## reference/interfaces (113)

- [AgentLoopState](./reference/interfaces/AgentLoopState.md): Defined in: types.ts:599
- [AIDevtoolsEventMap](./reference/interfaces/AIDevtoolsEventMap.md): Defined in: event-client.ts:431
- [AudioPart](./reference/interfaces/AudioPart.md): Defined in: types.ts:173
- [BaseAGUIEvent](./reference/interfaces/BaseAGUIEvent.md): Defined in: types.ts:746
- [ChunkRecording](./reference/interfaces/ChunkRecording.md): Defined in: activities/chat/stream/types.ts:73
- [ChunkStrategy](./reference/interfaces/ChunkStrategy.md): Defined in: activities/chat/stream/types.ts:33
- [ClientCreatedEvent](./reference/interfaces/ClientCreatedEvent.md): Defined in: event-client.ts:392
- [ClientErrorChangedEvent](./reference/interfaces/ClientErrorChangedEvent.md): Defined in: event-client.ts:406
- [ClientLoadingChangedEvent](./reference/interfaces/ClientLoadingChangedEvent.md): Defined in: event-client.ts:399
- [ClientMessagesClearedEvent](./reference/interfaces/ClientMessagesClearedEvent.md): Defined in: event-client.ts:413
- [ClientReloadedEvent](./reference/interfaces/ClientReloadedEvent.md): Defined in: event-client.ts:419
- [ClientStoppedEvent](./reference/interfaces/ClientStoppedEvent.md): Defined in: event-client.ts:426
- [ClientTool](./reference/interfaces/ClientTool.md): Defined in: activities/chat/tools/tool-definition.ts:24
- [ContentPartDataSource](./reference/interfaces/ContentPartDataSource.md): Defined in: types.ts:114
- [ContentPartUrlSource](./reference/interfaces/ContentPartUrlSource.md): Defined in: types.ts:134
- [CustomEvent](./reference/interfaces/CustomEvent.md): Defined in: types.ts:921
- [DefaultMessageMetadataByModality](./reference/interfaces/DefaultMessageMetadataByModality.md): Defined in: types.ts:1230
- [DocumentPart](./reference/interfaces/DocumentPart.md): Defined in: types.ts:197
- [ExtendedModelDef](./reference/interfaces/ExtendedModelDef.md): Defined in: extend-adapter.ts:21
- [GeneratedImage](./reference/interfaces/GeneratedImage.md): Defined in: types.ts:1015
- [ImageAdapter](./reference/interfaces/ImageAdapter.md): Defined in: activities/generateImage/adapter.ts:33
- [ImageGenerationOptions](./reference/interfaces/ImageGenerationOptions.md): Defined in: types.ts:996
- [ImageGenerationResult](./reference/interfaces/ImageGenerationResult.md): Defined in: types.ts:1027
- [ImagePart](./reference/interfaces/ImagePart.md): Defined in: types.ts:161
- [ImageRequestCompletedEvent](./reference/interfaces/ImageRequestCompletedEvent.md): Defined in: event-client.ts:270
- [ImageRequestStartedEvent](./reference/interfaces/ImageRequestStartedEvent.md): Defined in: event-client.ts:260
- [ImageUsage](./reference/interfaces/ImageUsage.md): Defined in: event-client.ts:30
- [ImageUsageEvent](./reference/interfaces/ImageUsageEvent.md): Defined in: event-client.ts:279
- [InternalToolCallState](./reference/interfaces/InternalToolCallState.md): Defined in: activities/chat/stream/types.ts:21
- [JSONParser](./reference/interfaces/JSONParser.md): Defined in: activities/chat/stream/json-parser.ts:12
- [JSONSchema](./reference/interfaces/JSONSchema.md): Defined in: types.ts:25
- [ModelMessage](./reference/interfaces/ModelMessage.md): Defined in: types.ts:260
- [ProcessorResult](./reference/interfaces/ProcessorResult.md): Defined in: activities/chat/stream/types.ts:51
- [ProcessorState](./reference/interfaces/ProcessorState.md): Defined in: activities/chat/stream/types.ts:61
- [ResponseFormat](./reference/interfaces/ResponseFormat.md): Defined in: types.ts:515
- [RunErrorEvent](./reference/interfaces/RunErrorEvent.md): Defined in: types.ts:791
- [RunFinishedEvent](./reference/interfaces/RunFinishedEvent.md): Defined in: types.ts:774
- [RunStartedEvent](./reference/interfaces/RunStartedEvent.md): Defined in: types.ts:763
- [ServerTool](./reference/interfaces/ServerTool.md): Defined in: activities/chat/tools/tool-definition.ts:13
- [SpeechRequestCompletedEvent](./reference/interfaces/SpeechRequestCompletedEvent.md): Defined in: event-client.ts:301
- [SpeechRequestStartedEvent](./reference/interfaces/SpeechRequestStartedEvent.md): Defined in: event-client.ts:290
- [SpeechUsageEvent](./reference/interfaces/SpeechUsageEvent.md): Defined in: event-client.ts:313
- [StateDeltaEvent](./reference/interfaces/StateDeltaEvent.md): Defined in: types.ts:912
- [StateSnapshotEvent](./reference/interfaces/StateSnapshotEvent.md): Defined in: types.ts:903
- [StepFinishedEvent](./reference/interfaces/StepFinishedEvent.md): Defined in: types.ts:890
- [StepStartedEvent](./reference/interfaces/StepStartedEvent.md): Defined in: types.ts:879
- [StreamProcessorEvents](./reference/interfaces/StreamProcessorEvents.md): Defined in: activities/chat/stream/processor.ts:54
- [StreamProcessorOptions](./reference/interfaces/StreamProcessorOptions.md): Defined in: activities/chat/stream/processor.ts:97
- [SummarizationOptions](./reference/interfaces/SummarizationOptions.md): Defined in: types.ts:969
- [SummarizationResult](./reference/interfaces/SummarizationResult.md): Defined in: types.ts:977
- [SummarizeAdapter](./reference/interfaces/SummarizeAdapter.md): Defined in: activities/summarize/adapter.ts:28
- [SummarizeRequestCompletedEvent](./reference/interfaces/SummarizeRequestCompletedEvent.md): Defined in: event-client.ts:239
- [SummarizeRequestStartedEvent](./reference/interfaces/SummarizeRequestStartedEvent.md): Defined in: event-client.ts:231
- [SummarizeUsageEvent](./reference/interfaces/SummarizeUsageEvent.md): Defined in: event-client.ts:249
- [TextAdapter](./reference/interfaces/TextAdapter.md): Defined in: activities/chat/adapter.ts:52
- [TextChunkContentEvent](./reference/interfaces/TextChunkContentEvent.md): Defined in: event-client.ts:102
- [TextChunkDoneEvent](./reference/interfaces/TextChunkDoneEvent.md): Defined in: event-client.ts:140
- [TextChunkErrorEvent](./reference/interfaces/TextChunkErrorEvent.md): Defined in: event-client.ts:149
- [TextChunkThinkingEvent](./reference/interfaces/TextChunkThinkingEvent.md): Defined in: event-client.ts:131
- [TextChunkToolCallEvent](./reference/interfaces/TextChunkToolCallEvent.md): Defined in: event-client.ts:111
- [TextChunkToolResultEvent](./reference/interfaces/TextChunkToolResultEvent.md): Defined in: event-client.ts:122
- [TextCompletionChunk](./reference/interfaces/TextCompletionChunk.md): Defined in: types.ts:956
- [TextMessageContentEvent](./reference/interfaces/TextMessageContentEvent.md): Defined in: types.ts:816
- [TextMessageCreatedEvent](./reference/interfaces/TextMessageCreatedEvent.md): Defined in: event-client.ts:85
- [TextMessageEndEvent](./reference/interfaces/TextMessageEndEvent.md): Defined in: types.ts:829
- [TextMessageStartEvent](./reference/interfaces/TextMessageStartEvent.md): Defined in: types.ts:805
- [TextMessageUserEvent](./reference/interfaces/TextMessageUserEvent.md): Defined in: event-client.ts:97
- [TextOptions](./reference/interfaces/TextOptions.md): Defined in: types.ts:625
- [TextPart](./reference/interfaces/TextPart.md): Defined in: types.ts:276
- [TextRequestCompletedEvent](./reference/interfaces/TextRequestCompletedEvent.md): Defined in: event-client.ts:70
- [TextRequestStartedEvent](./reference/interfaces/TextRequestStartedEvent.md): Defined in: event-client.ts:59
- [TextUsageEvent](./reference/interfaces/TextUsageEvent.md): Defined in: event-client.ts:157
- [ThinkingPart](./reference/interfaces/ThinkingPart.md): Defined in: types.ts:306
- [TokenUsage](./reference/interfaces/TokenUsage.md): Defined in: event-client.ts:24
- [Tool](./reference/interfaces/Tool.md): Defined in: types.ts:388
- [ToolCall](./reference/interfaces/ToolCall.md): Defined in: types.ts:87
- [ToolCallArgsEvent](./reference/interfaces/ToolCallArgsEvent.md): Defined in: types.ts:851
- [ToolCallEndEvent](./reference/interfaces/ToolCallEndEvent.md): Defined in: types.ts:864
- [ToolCallPart](./reference/interfaces/ToolCallPart.md): Defined in: types.ts:282
- [ToolCallStartEvent](./reference/interfaces/ToolCallStartEvent.md): Defined in: types.ts:838
- [ToolConfig](./reference/interfaces/ToolConfig.md): Defined in: types.ts:500
- [ToolDefinition](./reference/interfaces/ToolDefinition.md): Defined in: activities/chat/tools/tool-definition.ts:105
- [ToolDefinitionConfig](./reference/interfaces/ToolDefinitionConfig.md): Defined in: activities/chat/tools/tool-definition.ts:89
- [ToolDefinitionInstance](./reference/interfaces/ToolDefinitionInstance.md): Defined in: activities/chat/tools/tool-definition.ts:44
- [ToolExecutionContext](./reference/interfaces/ToolExecutionContext.md): Defined in: types.ts:351
- [ToolResultPart](./reference/interfaces/ToolResultPart.md): Defined in: types.ts:298
- [ToolsApprovalRequestedEvent](./reference/interfaces/ToolsApprovalRequestedEvent.md): Defined in: event-client.ts:170
- [ToolsApprovalRespondedEvent](./reference/interfaces/ToolsApprovalRespondedEvent.md): Defined in: event-client.ts:181
- [ToolsCallCompletedEvent](./reference/interfaces/ToolsCallCompletedEvent.md): Defined in: event-client.ts:198
- [ToolsCallUpdatedEvent](./reference/interfaces/ToolsCallUpdatedEvent.md): Defined in: event-client.ts:217
- [ToolsInputAvailableEvent](./reference/interfaces/ToolsInputAvailableEvent.md): Defined in: event-client.ts:188
- [ToolsResultAddedEvent](./reference/interfaces/ToolsResultAddedEvent.md): Defined in: event-client.ts:209
- [TranscriptionAdapter](./reference/interfaces/TranscriptionAdapter.md): Defined in: activities/generateTranscription/adapter.ts:24
- [TranscriptionOptions](./reference/interfaces/TranscriptionOptions.md): Defined in: types.ts:1159
- [TranscriptionRequestCompletedEvent](./reference/interfaces/TranscriptionRequestCompletedEvent.md): Defined in: event-client.ts:334
- [TranscriptionRequestStartedEvent](./reference/interfaces/TranscriptionRequestStartedEvent.md): Defined in: event-client.ts:324
- [TranscriptionResult](./reference/interfaces/TranscriptionResult.md): Defined in: types.ts:1209
- [TranscriptionSegment](./reference/interfaces/TranscriptionSegment.md): Defined in: types.ts:1179
- [TranscriptionUsageEvent](./reference/interfaces/TranscriptionUsageEvent.md): Defined in: event-client.ts:344
- [TranscriptionWord](./reference/interfaces/TranscriptionWord.md): Defined in: types.ts:1197
- [TTSAdapter](./reference/interfaces/TTSAdapter.md): Defined in: activities/generateSpeech/adapter.ts:24
- [TTSOptions](./reference/interfaces/TTSOptions.md): Defined in: types.ts:1118
- [TTSResult](./reference/interfaces/TTSResult.md): Defined in: types.ts:1136
- [UIMessage](./reference/interfaces/UIMessage.md): Defined in: types.ts:325
- [VideoAdapter](./reference/interfaces/VideoAdapter.md): Defined in: activities/generateVideo/adapter.ts:35
- [VideoGenerationOptions](./reference/interfaces/VideoGenerationOptions.md): Defined in: types.ts:1052
- [VideoJobResult](./reference/interfaces/VideoJobResult.md): Defined in: types.ts:1073
- [VideoPart](./reference/interfaces/VideoPart.md): Defined in: types.ts:185
- [VideoRequestCompletedEvent](./reference/interfaces/VideoRequestCompletedEvent.md): Defined in: event-client.ts:367
- [VideoRequestStartedEvent](./reference/interfaces/VideoRequestStartedEvent.md): Defined in: event-client.ts:355
- [VideoStatusResult](./reference/interfaces/VideoStatusResult.md): Defined in: types.ts:1085
- [VideoUrlResult](./reference/interfaces/VideoUrlResult.md): Defined in: types.ts:1101
- [VideoUsageEvent](./reference/interfaces/VideoUsageEvent.md): Defined in: event-client.ts:381

## reference/type-aliases (29)

- [AgentLoopStrategy](./reference/type-aliases/AgentLoopStrategy.md): Defined in: types.ts:620
- [AGUIEvent](./reference/type-aliases/AGUIEvent.md): Defined in: types.ts:932
- [AGUIEventType](./reference/type-aliases/AGUIEventType.md): Defined in: types.ts:721
- [AIAdapter](./reference/type-aliases/AIAdapter.md): Defined in: activities/index.ts:149
- [AnyClientTool](./reference/type-aliases/AnyClientTool.md): Defined in: activities/chat/tools/tool-definition.ts:55
- [AnyImageAdapter](./reference/type-aliases/AnyImageAdapter.md): Defined in: activities/generateImage/adapter.ts:67
- [AnySummarizeAdapter](./reference/type-aliases/AnySummarizeAdapter.md): Defined in: activities/summarize/adapter.ts:65
- [AnyTextAdapter](./reference/type-aliases/AnyTextAdapter.md): Defined in: activities/chat/adapter.ts:98
- [AnyTranscriptionAdapter](./reference/type-aliases/AnyTranscriptionAdapter.md): Defined in: activities/generateTranscription/adapter.ts:54
- [AnyTTSAdapter](./reference/type-aliases/AnyTTSAdapter.md): Defined in: activities/generateSpeech/adapter.ts:52
- [AnyVideoAdapter](./reference/type-aliases/AnyVideoAdapter.md): Defined in: activities/generateVideo/adapter.ts:81
- [ConstrainedContent](./reference/type-aliases/ConstrainedContent.md): Defined in: types.ts:253
- [ConstrainedModelMessage](./reference/type-aliases/ConstrainedModelMessage.md): Defined in: types.ts:341
- [ContentPart](./reference/type-aliases/ContentPart.md): Defined in: types.ts:212
- [ContentPartForInputModalitiesTypes](./reference/type-aliases/ContentPartForInputModalitiesTypes.md): Defined in: types.ts:229
- [ContentPartSource](./reference/type-aliases/ContentPartSource.md): Defined in: types.ts:155
- [InferSchemaType](./reference/type-aliases/InferSchemaType.md): Defined in: types.ts:84
- [InferToolInput](./reference/type-aliases/InferToolInput.md): Defined in: activities/chat/tools/tool-definition.ts:67
- [InferToolName](./reference/type-aliases/InferToolName.md): Defined in: activities/chat/tools/tool-definition.ts:62
- [InferToolOutput](./reference/type-aliases/InferToolOutput.md): Defined in: activities/chat/tools/tool-definition.ts:78
- [InputModalitiesTypes](./reference/type-aliases/InputModalitiesTypes.md): Defined in: types.ts:332
- [MessagePart](./reference/type-aliases/MessagePart.md): Defined in: types.ts:311
- [ModalitiesArrayToUnion](./reference/type-aliases/ModalitiesArrayToUnion.md): Defined in: types.ts:246
- [Modality](./reference/type-aliases/Modality.md): Defined in: types.ts:108
- [SchemaInput](./reference/type-aliases/SchemaInput.md): Defined in: types.ts:77
- [StreamChunk](./reference/type-aliases/StreamChunk.md): Defined in: types.ts:952
- [StreamChunkType](./reference/type-aliases/StreamChunkType.md): Defined in: types.ts:740
- [ToolCallState](./reference/type-aliases/ToolCallState.md): Defined in: types.ts:6
- [ToolResultState](./reference/type-aliases/ToolResultState.md): Defined in: types.ts:16

## reference/variables (2)

- [aiEventClient](./reference/variables/aiEventClient.md): Defined in: event-client.ts:495
- [defaultJSONParser](./reference/variables/defaultJSONParser.md): Defined in: activities/chat/stream/json-parser.ts:49
