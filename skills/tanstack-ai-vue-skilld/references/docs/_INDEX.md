---
total: 237
---

# Docs Index

## adapters (9)

- [Anthropic](./adapters/anthropic.md): The Anthropic adapter provides access to Claude models, including Claude Sonnet 4.5, Claude Opus 4.5, and more.
- [ElevenLabs](./adapters/elevenlabs.md): The ElevenLabs adapter provides realtime conversational voice AI for TanStack AI. Unlike text-focused adapters, the ElevenLabs adapter is voice-foc...
- [fal.ai](./adapters/fal.md): The fal.ai adapter provides access to 600+ models on the fal.ai platform for image generation and video generation. Unlike text-focused adapters, t...
- [Google Gemini](./adapters/gemini.md): The Google Gemini adapter provides access to Google's Gemini models, including text generation, image generation with both Imagen and Gemini native...
- [Grok (xAI)](./adapters/grok.md): The Grok adapter provides access to xAI's Grok models, including Grok 4.1, Grok 4, Grok 3, and image generation with Grok 2 Image.
- [Groq](./adapters/groq.md): The Groq adapter provides access to Groq's fast inference API, featuring the world's fastest LLM inference.
- [Ollama](./adapters/ollama.md): The Ollama adapter provides access to local models running via Ollama, allowing you to run AI models on your own infrastructure with full privacy a...
- [OpenAI](./adapters/openai.md): The OpenAI adapter provides access to OpenAI's models, including GPT-4o, GPT-5, image generation (DALL-E), text-to-speech (TTS), and audio transcri...
- [OpenRouter Adapter](./adapters/openrouter.md): OpenRouter is TanStack AI's first official AI partner and the recommended starting point for most projects. It provides access to 300+ models from ...

## advanced (7)

- [Extend Adapter](./advanced/extend-adapter.md): The extendAdapter utility allows you to extend existing adapter factories (like openaiText, anthropicText) with custom model names while maintainin...
- [Middleware](./advanced/middleware.md): Middleware lets you hook into every stage of the chat() lifecycle — from configuration to streaming, tool execution, usage tracking, and completion...
- [Multimodal Content](./advanced/multimodal-content.md): TanStack AI supports multimodal content in messages, allowing you to send images, audio, video, and documents alongside text to AI models that supp...
- [Observability](./advanced/observability.md): The @tanstack/ai package offers you an event client for observability and debugging purposes.
It's a fully type-safe decoupled event-driven system ...
- [Per-Model Type Safety](./advanced/per-model-type-safety.md): The AI SDK provides model-specific type safety for modelOptions. Each model's capabilities determine which model options are allowed, and TypeScrip...
- [Runtime Adapter Switching](./advanced/runtime-adapter-switching.md): Learn how to build interfaces where users can switch between LLM providers at runtime while maintaining full TypeScript type safety.
- [Tree-Shaking](./advanced/tree-shaking.md): TanStack AI is designed from the ground up for maximum tree-shakeability. The entire system—from activity functions to adapters—uses a functional, ...

## api (3)

- [@tanstack/ai-client](./api/ai-client.md): Framework-agnostic headless client for managing chat state and streaming.
- [@tanstack/ai-vue](./api/ai-vue.md): Vue composables for TanStack AI, providing convenient Vue 3 bindings for the headless client.
- [@tanstack/ai](./api/ai.md): The core AI library for TanStack AI.

## architecture (1)

- [Approval Flow Processing Architecture](./architecture/approval-flow-processing.md): The approval flow allows tools marked with needsApproval: true to pause
execution until the user explicitly approves or denies the action. This
cre...

## chat (5)

- [Agentic Cycle](./chat/agentic-cycle.md): The agentic cycle is the pattern where the LLM repeatedly calls tools, receives results, and continues reasoning until it can provide a final answe...
- [Connection Adapters](./chat/connection-adapters.md): Connection adapters handle the communication between your client and server for streaming chat responses. TanStack AI provides built-in adapters an...
- [Streaming](./chat/streaming.md): TanStack AI supports streaming responses for real-time chat experiences. Streaming allows you to display responses as they're generated, rather tha...
- [Structured Outputs](./chat/structured-outputs.md): Structured outputs allow you to constrain AI model responses to match a specific JSON schema, ensuring consistent and type-safe data extraction. Ta...
- [Thinking & Reasoning](./chat/thinking-content.md): Some models expose their internal reasoning as "thinking" content -- Claude with extended thinking, OpenAI o-series models with reasoning, and othe...

## code-mode (4)

- [Showing Code Mode in the UI](./code-mode/client-integration.md): You have Code Mode working on your server — the LLM writes and executes TypeScript, and you get results back. But your users see nothing while the ...
- [Code Mode Isolate Drivers](./code-mode/code-mode-isolates.md): Isolate drivers provide the secure sandbox runtimes that Code Mode uses to execute generated TypeScript. All drivers implement the same IsolateDriv...
- [Code Mode with Skills](./code-mode/code-mode-with-skills.md): Skills extend Code Mode with a persistent library of reusable TypeScript snippets. When the LLM writes a useful piece of code — say, a function tha...
- [Code Mode](./code-mode/code-mode.md): Code Mode lets an LLM write and execute TypeScript programs inside a secure sandbox. Instead of making one tool call at a time, the model writes a ...

## community-adapters (6)

- [Cencori](./community-adapters/cencori.md): The Cencori adapter provides access to 14+ AI providers (OpenAI, Anthropic, Google, xAI, and more) through a unified interface with built-in securi...
- [Cloudflare](./community-adapters/cloudflare.md): The Cloudflare adapter provides access to Cloudflare Workers AI models and AI Gateway for routing requests to OpenAI, Anthropic, Gemini, Grok, and ...
- [Decart](./community-adapters/decart.md): The Decart adapter provides access to Decart's image and video generation models.
- [Community Adapters Guide](./community-adapters/guide.md): This guide explains how to create and contribute community adapters for the TanStack AI ecosystem.
- [Mynth](./community-adapters/mynth.md): The Mynth adapter provides access to Mynth image generation models through TanStack AI. It is a community adapter for generateImage() with typed mo...
- [Soniox](./community-adapters/soniox.md): The Soniox adapter provides access to Soniox transcription models.

## getting-started (5)

- [Devtools](./getting-started/devtools.md): TanStack Devtools is a unified devtools panel for inspecting and debugging TanStack libraries, including TanStack AI. It provides real-time insight...
- [Overview](./getting-started/overview.md): TanStack AI is a lightweight, type-safe SDK for building production-ready AI experiences. Its framework-agnostic core provides type-safe tool/funct...
- [Quick Start: Server Only](./getting-started/quick-start-server.md): You have a Node.js backend and want to add AI capabilities. By the end of this guide, you'll have a working chat endpoint powered by TanStack AI an...
- [Quick Start: Vue](./getting-started/quick-start-vue.md): You have a Vue 3 app and want to add AI chat. By the end of this guide, you'll have a streaming chat component powered by TanStack AI and OpenAI.
- [Quick Start: React](./getting-started/quick-start.md): Get started with TanStack AI in minutes. This guide will walk you through creating a simple chat application using the React integration and OpenAI...

## media (7)

- [Generation Hooks](./media/generation-hooks.md): TanStack AI provides framework hooks for every generation type: image, speech, transcription, summarization, and video. Each hook connects to a ser...
- [Generations](./media/generations.md): TanStack AI provides a unified pattern for non-chat AI activities: image generation, text-to-speech, transcription, summarization, and video genera...
- [Image Generation](./media/image-generation.md): TanStack AI provides support for image generation through dedicated image adapters. This guide covers how to use the image generation functionality...
- [Realtime Voice Chat](./media/realtime-chat.md): TanStack AI provides a complete realtime voice chat system for building voice-to-voice AI interactions. The realtime API supports multiple provider...
- [Text-to-Speech](./media/text-to-speech.md): TanStack AI provides support for text-to-speech generation through dedicated TTS adapters. This guide covers how to convert text into spoken audio ...
- [Transcription](./media/transcription.md): TanStack AI provides support for audio transcription (speech-to-text) through dedicated transcription adapters. This guide covers how to convert sp...
- [Video Generation](./media/video-generation.md): TanStack AI provides experimental support for video generation through dedicated video adapters. Unlike image generation, video generation is an as...

## migration (1)

- [Migration Guide](./migration/migration.md): This guide helps you migrate from the previous version of TanStack AI to the latest version. The major changes focus on improved tree-shaking, clea...

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
- [StreamProcessor](./reference/classes/StreamProcessor.md): Defined in: activities/chat/stream/processor.ts:128
- [ToolCallManager](./reference/classes/ToolCallManager.md): Defined in: activities/chat/tools/tool-calls.ts:83
- [WordBoundaryStrategy](./reference/classes/WordBoundaryStrategy.md): Defined in: activities/chat/stream/strategies.ts:57

## reference/functions (35)

- [chat](./reference/functions/chat.md): Defined in: activities/chat/index.ts:1341
- [combineStrategies](./reference/functions/combineStrategies.md): Defined in: activities/chat/agent-loop-strategies.ts:79
- [convertMessagesToModelMessages](./reference/functions/convertMessagesToModelMessages.md): Defined in: activities/chat/messages.ts:63
- [convertSchemaToJsonSchema](./reference/functions/convertSchemaToJsonSchema.md): Defined in: activities/chat/tools/schema-converter.ts:199
- [createChatOptions](./reference/functions/createChatOptions.md): Defined in: activities/chat/index.ts:185
- [createImageOptions](./reference/functions/createImageOptions.md): Defined in: activities/generateImage/index.ts:244
- [createModel](./reference/functions/createModel.md): Defined in: extend-adapter.ts:61
- [createReplayStream](./reference/functions/createReplayStream.md): Defined in: activities/chat/stream/processor.ts:1495
- [createSpeechOptions](./reference/functions/createSpeechOptions.md): Defined in: activities/generateSpeech/index.ts:181
- [createSummarizeOptions](./reference/functions/createSummarizeOptions.md): Defined in: activities/summarize/index.ts:254
- [createTranscriptionOptions](./reference/functions/createTranscriptionOptions.md): Defined in: activities/generateTranscription/index.ts:199
- [createVideoOptions](./reference/functions/createVideoOptions.md): Defined in: activities/generateVideo/index.ts:481
- [detectImageMimeType](./reference/functions/detectImageMimeType.md): Defined in: utils.ts:17
- [extendAdapter](./reference/functions/extendAdapter.md): Defined in: extend-adapter.ts:166
- [generateImage](./reference/functions/generateImage.md): Defined in: activities/generateImage/index.ts:167
- [generateMessageId](./reference/functions/generateMessageId.md): Defined in: activities/chat/messages.ts:434
- [generateSpeech](./reference/functions/generateSpeech.md): Defined in: activities/generateSpeech/index.ts:119
- [generateTranscription](./reference/functions/generateTranscription.md): Defined in: activities/generateTranscription/index.ts:134
- [generateVideo](./reference/functions/generateVideo.md): Defined in: activities/generateVideo/index.ts:221
- [getVideoJobStatus](./reference/functions/getVideoJobStatus.md): Defined in: activities/generateVideo/index.ts:381
- [maxIterations](./reference/functions/maxIterations.md): Defined in: activities/chat/agent-loop-strategies.ts:20
- [modelMessagesToUIMessages](./reference/functions/modelMessagesToUIMessages.md): Defined in: activities/chat/messages.ts:362
- [modelMessageToUIMessage](./reference/functions/modelMessageToUIMessage.md): Defined in: activities/chat/messages.ts:303
- [normalizeToUIMessage](./reference/functions/normalizeToUIMessage.md): Defined in: activities/chat/messages.ts:411
- [parsePartialJSON](./reference/functions/parsePartialJSON.md): Defined in: activities/chat/stream/json-parser.ts:56
- [realtimeToken](./reference/functions/realtimeToken.md): Defined in: realtime/index.ts:33
- [streamToText](./reference/functions/streamToText.md): Defined in: stream-to-response.ts:23
- [summarize](./reference/functions/summarize.md): Defined in: activities/summarize/index.ts:147
- [toHttpResponse](./reference/functions/toHttpResponse.md): Defined in: stream-to-response.ts:247
- [toHttpStream](./reference/functions/toHttpStream.md): Defined in: stream-to-response.ts:175
- [toolDefinition](./reference/functions/toolDefinition.md): Defined in: activities/chat/tools/tool-definition.ts:187
- [toServerSentEventsResponse](./reference/functions/toServerSentEventsResponse.md): Defined in: stream-to-response.ts:124
- [toServerSentEventsStream](./reference/functions/toServerSentEventsStream.md): Defined in: stream-to-response.ts:49
- [uiMessageToModelMessages](./reference/functions/uiMessageToModelMessages.md): Defined in: activities/chat/messages.ts:98
- [untilFinishReason](./reference/functions/untilFinishReason.md): Defined in: activities/chat/agent-loop-strategies.ts:41

## reference (1)

- [@tanstack/ai](./reference/index.md)

## reference/interfaces (98)

- [AbortInfo](./reference/interfaces/AbortInfo.md): Defined in: activities/chat/middleware/types.ts:258
- [AfterToolCallInfo](./reference/interfaces/AfterToolCallInfo.md): Defined in: activities/chat/middleware/types.ts:154
- [AgentLoopState](./reference/interfaces/AgentLoopState.md): Defined in: types.ts:604
- [AudioPart](./reference/interfaces/AudioPart.md): Defined in: types.ts:175
- [AudioVisualization](./reference/interfaces/AudioVisualization.md): Defined in: realtime/types.ts:200
- [BaseAGUIEvent](./reference/interfaces/BaseAGUIEvent.md): Defined in: types.ts:752
- [ChatMiddleware](./reference/interfaces/ChatMiddleware.md): Defined in: activities/chat/middleware/types.ts:308
- [ChatMiddlewareConfig](./reference/interfaces/ChatMiddlewareConfig.md): Defined in: activities/chat/middleware/types.ts:105
- [ChatMiddlewareContext](./reference/interfaces/ChatMiddlewareContext.md): Defined in: activities/chat/middleware/types.ts:26
- [ChunkRecording](./reference/interfaces/ChunkRecording.md): Defined in: activities/chat/stream/types.ts:91
- [ChunkStrategy](./reference/interfaces/ChunkStrategy.md): Defined in: activities/chat/stream/types.ts:33
- [ClientTool](./reference/interfaces/ClientTool.md): Defined in: activities/chat/tools/tool-definition.ts:24
- [ContentPartDataSource](./reference/interfaces/ContentPartDataSource.md): Defined in: types.ts:116
- [ContentPartUrlSource](./reference/interfaces/ContentPartUrlSource.md): Defined in: types.ts:136
- [CustomEvent](./reference/interfaces/CustomEvent.md): Defined in: types.ts:944
- [DefaultMessageMetadataByModality](./reference/interfaces/DefaultMessageMetadataByModality.md): Defined in: types.ts:1254
- [DocumentPart](./reference/interfaces/DocumentPart.md): Defined in: types.ts:199
- [ErrorInfo](./reference/interfaces/ErrorInfo.md): Defined in: activities/chat/middleware/types.ts:268
- [ExtendedModelDef](./reference/interfaces/ExtendedModelDef.md): Defined in: extend-adapter.ts:21
- [FinishInfo](./reference/interfaces/FinishInfo.md): Defined in: activities/chat/middleware/types.ts:240
- [GeneratedImage](./reference/interfaces/GeneratedImage.md): Defined in: types.ts:1039
- [ImageAdapter](./reference/interfaces/ImageAdapter.md): Defined in: activities/generateImage/adapter.ts:33
- [ImageGenerationOptions](./reference/interfaces/ImageGenerationOptions.md): Defined in: types.ts:1020
- [ImageGenerationResult](./reference/interfaces/ImageGenerationResult.md): Defined in: types.ts:1051
- [ImagePart](./reference/interfaces/ImagePart.md): Defined in: types.ts:163
- [InternalToolCallState](./reference/interfaces/InternalToolCallState.md): Defined in: activities/chat/stream/types.ts:21
- [IterationInfo](./reference/interfaces/IterationInfo.md): Defined in: activities/chat/middleware/types.ts:179
- [JSONParser](./reference/interfaces/JSONParser.md): Defined in: activities/chat/stream/json-parser.ts:12
- [JSONSchema](./reference/interfaces/JSONSchema.md): Defined in: types.ts:25
- [MessagesSnapshotEvent](./reference/interfaces/MessagesSnapshotEvent.md): Defined in: types.ts:917
- [ModelMessage](./reference/interfaces/ModelMessage.md): Defined in: types.ts:262
- [ProcessorResult](./reference/interfaces/ProcessorResult.md): Defined in: activities/chat/stream/types.ts:69
- [ProcessorState](./reference/interfaces/ProcessorState.md): Defined in: activities/chat/stream/types.ts:79
- [RealtimeAudioPart](./reference/interfaces/RealtimeAudioPart.md): Defined in: realtime/types.ts:102
- [RealtimeError](./reference/interfaces/RealtimeError.md): Defined in: realtime/types.ts:290
- [RealtimeEventPayloads](./reference/interfaces/RealtimeEventPayloads.md): Defined in: realtime/types.ts:251
- [RealtimeImagePart](./reference/interfaces/RealtimeImagePart.md): Defined in: realtime/types.ts:136
- [RealtimeMessage](./reference/interfaces/RealtimeMessage.md): Defined in: realtime/types.ts:157
- [RealtimeSessionConfig](./reference/interfaces/RealtimeSessionConfig.md): Defined in: realtime/types.ts:30
- [RealtimeTextPart](./reference/interfaces/RealtimeTextPart.md): Defined in: realtime/types.ts:94
- [RealtimeToken](./reference/interfaces/RealtimeToken.md): Defined in: realtime/types.ts:58
- [RealtimeTokenAdapter](./reference/interfaces/RealtimeTokenAdapter.md): Defined in: realtime/types.ts:72
- [RealtimeTokenOptions](./reference/interfaces/RealtimeTokenOptions.md): Defined in: realtime/types.ts:82
- [RealtimeToolCallPart](./reference/interfaces/RealtimeToolCallPart.md): Defined in: realtime/types.ts:115
- [RealtimeToolResultPart](./reference/interfaces/RealtimeToolResultPart.md): Defined in: realtime/types.ts:127
- [ResponseFormat](./reference/interfaces/ResponseFormat.md): Defined in: types.ts:520
- [RunErrorEvent](./reference/interfaces/RunErrorEvent.md): Defined in: types.ts:797
- [RunFinishedEvent](./reference/interfaces/RunFinishedEvent.md): Defined in: types.ts:780
- [RunStartedEvent](./reference/interfaces/RunStartedEvent.md): Defined in: types.ts:769
- [ServerTool](./reference/interfaces/ServerTool.md): Defined in: activities/chat/tools/tool-definition.ts:13
- [StateDeltaEvent](./reference/interfaces/StateDeltaEvent.md): Defined in: types.ts:935
- [StateSnapshotEvent](./reference/interfaces/StateSnapshotEvent.md): Defined in: types.ts:926
- [StepFinishedEvent](./reference/interfaces/StepFinishedEvent.md): Defined in: types.ts:900
- [StepStartedEvent](./reference/interfaces/StepStartedEvent.md): Defined in: types.ts:889
- [StreamProcessorEvents](./reference/interfaces/StreamProcessorEvents.md): Defined in: activities/chat/stream/processor.ts:56
- [StreamProcessorOptions](./reference/interfaces/StreamProcessorOptions.md): Defined in: activities/chat/stream/processor.ts:99
- [SummarizationOptions](./reference/interfaces/SummarizationOptions.md): Defined in: types.ts:993
- [SummarizationResult](./reference/interfaces/SummarizationResult.md): Defined in: types.ts:1001
- [SummarizeAdapter](./reference/interfaces/SummarizeAdapter.md): Defined in: activities/summarize/adapter.ts:28
- [TextAdapter](./reference/interfaces/TextAdapter.md): Defined in: activities/chat/adapter.ts:52
- [TextCompletionChunk](./reference/interfaces/TextCompletionChunk.md): Defined in: types.ts:980
- [TextMessageContentEvent](./reference/interfaces/TextMessageContentEvent.md): Defined in: types.ts:822
- [TextMessageEndEvent](./reference/interfaces/TextMessageEndEvent.md): Defined in: types.ts:835
- [TextMessageStartEvent](./reference/interfaces/TextMessageStartEvent.md): Defined in: types.ts:811
- [TextOptions](./reference/interfaces/TextOptions.md): Defined in: types.ts:630
- [TextPart](./reference/interfaces/TextPart.md): Defined in: types.ts:278
- [ThinkingPart](./reference/interfaces/ThinkingPart.md): Defined in: types.ts:308
- [Tool](./reference/interfaces/Tool.md): Defined in: types.ts:390
- [ToolCall](./reference/interfaces/ToolCall.md): Defined in: types.ts:87
- [ToolCallArgsEvent](./reference/interfaces/ToolCallArgsEvent.md): Defined in: types.ts:861
- [ToolCallEndEvent](./reference/interfaces/ToolCallEndEvent.md): Defined in: types.ts:874
- [ToolCallHookContext](./reference/interfaces/ToolCallHookContext.md): Defined in: activities/chat/middleware/types.ts:123
- [ToolCallPart](./reference/interfaces/ToolCallPart.md): Defined in: types.ts:284
- [ToolCallStartEvent](./reference/interfaces/ToolCallStartEvent.md): Defined in: types.ts:844
- [ToolConfig](./reference/interfaces/ToolConfig.md): Defined in: types.ts:505
- [ToolDefinition](./reference/interfaces/ToolDefinition.md): Defined in: activities/chat/tools/tool-definition.ts:107
- [ToolDefinitionConfig](./reference/interfaces/ToolDefinitionConfig.md): Defined in: activities/chat/tools/tool-definition.ts:90
- [ToolDefinitionInstance](./reference/interfaces/ToolDefinitionInstance.md): Defined in: activities/chat/tools/tool-definition.ts:45
- [ToolExecutionContext](./reference/interfaces/ToolExecutionContext.md): Defined in: types.ts:353
- [ToolPhaseCompleteInfo](./reference/interfaces/ToolPhaseCompleteInfo.md): Defined in: activities/chat/middleware/types.ts:194
- [ToolResultPart](./reference/interfaces/ToolResultPart.md): Defined in: types.ts:300
- [TranscriptionAdapter](./reference/interfaces/TranscriptionAdapter.md): Defined in: activities/generateTranscription/adapter.ts:24
- [TranscriptionOptions](./reference/interfaces/TranscriptionOptions.md): Defined in: types.ts:1183
- [TranscriptionResult](./reference/interfaces/TranscriptionResult.md): Defined in: types.ts:1233
- [TranscriptionSegment](./reference/interfaces/TranscriptionSegment.md): Defined in: types.ts:1203
- [TranscriptionWord](./reference/interfaces/TranscriptionWord.md): Defined in: types.ts:1221
- [TTSAdapter](./reference/interfaces/TTSAdapter.md): Defined in: activities/generateSpeech/adapter.ts:24
- [TTSOptions](./reference/interfaces/TTSOptions.md): Defined in: types.ts:1142
- [TTSResult](./reference/interfaces/TTSResult.md): Defined in: types.ts:1160
- [UIMessage](./reference/interfaces/UIMessage.md): Defined in: types.ts:327
- [UsageInfo](./reference/interfaces/UsageInfo.md): Defined in: activities/chat/middleware/types.ts:227
- [VADConfig](./reference/interfaces/VADConfig.md): Defined in: realtime/types.ts:8
- [VideoAdapter](./reference/interfaces/VideoAdapter.md): Defined in: activities/generateVideo/adapter.ts:35
- [VideoGenerationOptions](./reference/interfaces/VideoGenerationOptions.md): Defined in: types.ts:1076
- [VideoJobResult](./reference/interfaces/VideoJobResult.md): Defined in: types.ts:1097
- [VideoPart](./reference/interfaces/VideoPart.md): Defined in: types.ts:187
- [VideoStatusResult](./reference/interfaces/VideoStatusResult.md): Defined in: types.ts:1109
- [VideoUrlResult](./reference/interfaces/VideoUrlResult.md): Defined in: types.ts:1125

## reference/type-aliases (37)

- [AgentLoopStrategy](./reference/type-aliases/AgentLoopStrategy.md): Defined in: types.ts:625
- [AGUIEvent](./reference/type-aliases/AGUIEvent.md): Defined in: types.ts:955
- [AGUIEventType](./reference/type-aliases/AGUIEventType.md): Defined in: types.ts:726
- [AIAdapter](./reference/type-aliases/AIAdapter.md): Defined in: activities/index.ts:149
- [AnyClientTool](./reference/type-aliases/AnyClientTool.md): Defined in: activities/chat/tools/tool-definition.ts:56
- [AnyImageAdapter](./reference/type-aliases/AnyImageAdapter.md): Defined in: activities/generateImage/adapter.ts:67
- [AnySummarizeAdapter](./reference/type-aliases/AnySummarizeAdapter.md): Defined in: activities/summarize/adapter.ts:65
- [AnyTextAdapter](./reference/type-aliases/AnyTextAdapter.md): Defined in: activities/chat/adapter.ts:98
- [AnyTranscriptionAdapter](./reference/type-aliases/AnyTranscriptionAdapter.md): Defined in: activities/generateTranscription/adapter.ts:54
- [AnyTTSAdapter](./reference/type-aliases/AnyTTSAdapter.md): Defined in: activities/generateSpeech/adapter.ts:52
- [AnyVideoAdapter](./reference/type-aliases/AnyVideoAdapter.md): Defined in: activities/generateVideo/adapter.ts:81
- [BeforeToolCallDecision](./reference/type-aliases/BeforeToolCallDecision.md): Defined in: activities/chat/middleware/types.ts:143
- [ChatMiddlewarePhase](./reference/type-aliases/ChatMiddlewarePhase.md): Defined in: activities/chat/middleware/types.ts:15
- [ConstrainedContent](./reference/type-aliases/ConstrainedContent.md): Defined in: types.ts:255
- [ConstrainedModelMessage](./reference/type-aliases/ConstrainedModelMessage.md): Defined in: types.ts:343
- [ContentPart](./reference/type-aliases/ContentPart.md): Defined in: types.ts:214
- [ContentPartForInputModalitiesTypes](./reference/type-aliases/ContentPartForInputModalitiesTypes.md): Defined in: types.ts:231
- [ContentPartSource](./reference/type-aliases/ContentPartSource.md): Defined in: types.ts:157
- [InferSchemaType](./reference/type-aliases/InferSchemaType.md): Defined in: types.ts:84
- [InferToolInput](./reference/type-aliases/InferToolInput.md): Defined in: activities/chat/tools/tool-definition.ts:68
- [InferToolName](./reference/type-aliases/InferToolName.md): Defined in: activities/chat/tools/tool-definition.ts:63
- [InferToolOutput](./reference/type-aliases/InferToolOutput.md): Defined in: activities/chat/tools/tool-definition.ts:79
- [InputModalitiesTypes](./reference/type-aliases/InputModalitiesTypes.md): Defined in: types.ts:334
- [MessagePart](./reference/type-aliases/MessagePart.md): Defined in: types.ts:313
- [ModalitiesArrayToUnion](./reference/type-aliases/ModalitiesArrayToUnion.md): Defined in: types.ts:248
- [Modality](./reference/type-aliases/Modality.md): Defined in: types.ts:110
- [RealtimeErrorCode](./reference/type-aliases/RealtimeErrorCode.md): Defined in: realtime/types.ts:280
- [RealtimeEvent](./reference/type-aliases/RealtimeEvent.md): Defined in: realtime/types.ts:238
- [RealtimeEventHandler](./reference/type-aliases/RealtimeEventHandler.md): Defined in: realtime/types.ts:269
- [RealtimeMessagePart](./reference/type-aliases/RealtimeMessagePart.md): Defined in: realtime/types.ts:147
- [RealtimeMode](./reference/type-aliases/RealtimeMode.md): Defined in: realtime/types.ts:191
- [RealtimeStatus](./reference/type-aliases/RealtimeStatus.md): Defined in: realtime/types.ts:181
- [SchemaInput](./reference/type-aliases/SchemaInput.md): Defined in: types.ts:77
- [StreamChunk](./reference/type-aliases/StreamChunk.md): Defined in: types.ts:976
- [StreamChunkType](./reference/type-aliases/StreamChunkType.md): Defined in: types.ts:746
- [ToolCallState](./reference/type-aliases/ToolCallState.md): Defined in: types.ts:6
- [ToolResultState](./reference/type-aliases/ToolResultState.md): Defined in: types.ts:16

## reference/variables (1)

- [defaultJSONParser](./reference/variables/defaultJSONParser.md): Defined in: activities/chat/stream/json-parser.ts:49

## tools (6)

- [Client Tools](./tools/client-tools.md): Client tools execute in the browser, enabling UI updates, local storage access, and browser API interactions. Unlike server tools, client tools don...
- [Lazy Tool Discovery](./tools/lazy-tool-discovery.md): When an application has many tools, sending all tool definitions to the LLM on every request wastes tokens and can degrade response quality. Lazy t...
- [Server Tools](./tools/server-tools.md): Server tools execute automatically when called by the LLM. They have full access to server resources like databases, APIs, and environment variables.
- [Tool Approval Flow](./tools/tool-approval.md): The tool approval flow allows you to require user approval before executing sensitive tools, giving users control over actions like sending emails,...
- [Tool Architecture](./tools/tool-architecture.md): The TanStack AI tool system provides a powerful, flexible architecture for enabling AI agents to interact with external systems:
- [Tools](./tools/tools.md): Tools (also called "function calling") allow AI models to interact with external systems, APIs, or perform computations. TanStack AI provides an is...
