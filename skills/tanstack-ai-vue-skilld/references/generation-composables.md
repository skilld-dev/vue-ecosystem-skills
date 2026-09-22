# Generation composables

## useGeneration(options)

Generic base composable for one-shot generation. `useGenerateImage`, `useGenerateAudio`, `useGenerateSpeech`, `useTranscription`, and `useSummarize` wrap it; use it directly for custom generation types (source: `src/use-generation.ts:133-154`).

Options (source: `src/use-generation.ts:28-98`):

- `connection?: ConnectConnectionAdapter` or `fetcher?: GenerationFetcher<TInput, TResult>`. Required pair; missing both throws (source: `src/use-generation.ts:271-275`).
- `body?`, `byok?`, `byokProvider?`, `devtools?`
- `persistence?: boolean` with `threadId?: string`: `threadId` is the stable scope name successive runs fill, required when persistence is set, and sent as the AG-UI thread id on the wire. Server-driven hydration repaints the last generation on mount; it never auto-starts a run (source: `src/use-generation.ts:42-63`).
- `hydrateGeneration?`, `joinRun?`: handlers for persistence when the connection does not carry its own (for example alongside `fetcher`); without `joinRun`, a restored `running` snapshot surfaces as an interrupted error (source: `src/use-generation.ts:65-77`).
- `onResult?`: transform hook. Return a non-null value to store it as the result; return `null` to keep the previous result; return nothing to store the raw result (source: `src/use-generation.ts:79-85`).
- `onError?`, `onProgress?(progress, message?)`, `onChunk?` (connection mode only).

Return: `generate(input)`, `result`, `isLoading`, `error`, `status` (`GenerationClientState`), `stop()`, `reset()`, `runId` (source: `src/use-generation.ts:106-131`).

`onResult` transforms the result type. The generic infers from the callback return, so the parameter stays typed even for an optional property; the pattern matches issue #848 in the repo (source: `src/use-generation.ts:155-175`).

```ts
const { generate, result } = useGeneration({
  connection: fetchServerSentEvents('/api/generate/custom'),
})
```

## Specialized composables

All accept the shared options (connection/fetcher, body, byok, devtools, persistence/threadId, hydrateGeneration/joinRun) plus `onResult` transform, `onError`, `onProgress`, `onChunk`. Each injects its own result reconstruction so a server-hydrated restore repaints `result` (source: each `use-generate-*.ts` file, `reconstructResult` wiring).

- `useGenerateImage`: `generate(input: ImageGenerateInput)`, result `ImageGenerationResult` (`result.images[i].url` or `b64Json`). Example: `src/use-generate-image.ts:86-111`.
- `useGenerateAudio`: `AudioGenerateInput` -> `AudioGenerationResult`, devtools `outputKind: 'audio'` (source: `src/use-generate-audio.ts:117`).
- `useGenerateSpeech`: `SpeechGenerateInput` -> `TTSResult` (text-to-speech).
- `useTranscription`: `TranscriptionGenerateInput` -> `TranscriptionResult`, devtools `outputKind: 'text'` (source: `src/use-transcription.ts:131`).
- `useSummarize`: `SummarizeGenerateInput` -> `SummarizationResult`.
- `useGenerateVideo`: job-based. Returns extra `jobId: ShallowRef<string | null>` and `videoStatus: ShallowRef<VideoStatusInfo | null>`; options add `onJobCreated(jobId)` and `onStatusUpdate(status)`. The composable creates a job, polls status, and resolves `result.url` on completion (source: `src/use-generate-video.ts:100-158`).

```vue
<script setup lang="ts">
import { useGenerateImage } from '@tanstack/ai-vue'
import { fetchServerSentEvents } from '@tanstack/ai-client'

const { generate, result, isLoading } = useGenerateImage({
  connection: fetchServerSentEvents('/api/generate/image'),
})
</script>
<template>
  <button @click="generate({ prompt: 'A sunset over mountains' })">Generate</button>
  <img v-for="(img, i) in result?.images" :key="i"
       :src="img.url || `data:image/png;base64,${img.b64Json}`" />
</template>
```

`stop()` aborts the local stream only. It does not stop the provider job; each `generate` call is one job tracked by `runId`, so pass `runId` to your own endpoint to cancel or poll (source: `src/use-generation.ts:124-131`). Generation hooks never auto-start on mount; persisted state is read-only for display (source: `src/use-generation.ts:289-293`).

Official overview: https://tanstack.com/ai/latest/docs/media/generation-hooks

## useAudioRecorder(options?)

Records an audio message. The resolved recording carries `.part` (pass to `useChat.sendMessage` as multimodal content) and `.base64` (for generation hooks) (source: `src/use-audio-recorder.ts:33-41`).

- Return: `recording`, `isRecording`, `isSupported` (boolean, not a ref), `start()`, `stop()`, `cancel()` (source: `src/use-audio-recorder.ts:19-31`).
- Two overloads: without `onComplete`, `recording` and `stop()` are the raw `AudioRecording`; the transforming overload requires `onComplete` (passing any other option without it stays on the raw overload, issue #1001) (source: `src/use-audio-recorder.ts:42-58`).
- Errors surface via `onError` and by `start()`/`stop()` rejecting; `stop()` rejects with `Recording cancelled` when `cancel()` (including scope disposal) ran first. Handle one channel, not both (source: `src/use-audio-recorder.ts:38-41`).

```ts
const { start, stop, isRecording, recording } = useAudioRecorder()
// then: sendMessage({ content: [{ type: 'text', content: 'Transcribe this' }, recording.value.part] })
```
