# Migrating v4 to v5

Official guide: https://docs.tresjs.org/getting-started/upgrade-guide

## ESM-only

`require('@tresjs/core')` no longer works. Use `import`. Ensure `"type": "module"` in package.json.

## useLoader

```ts
// v4 (Promise)
const gltf = await useLoader(GLTFLoader, url)
// v5 (reactive state)
const { state: gltf, isLoading, error, progress } = useLoader(GLTFLoader, url)
```

Reactive paths, `extensions` (DRACO etc.), and `load(path)` are new. `useTexture` moved to `@tresjs/cientos`.

## Pointer events

- `@pointer-down` becomes `@pointerdown` (native DOM names).
- Only the first intersected object fires; `useTresEventManager` was removed.
- Overlapping interactives: handle on a shared parent or `@pointermissed` on the canvas.

## Context

- `useTresContext().camera` is now a manager object, not the camera. Easy path: `const { camera } = useTres()`.
- `renderer` is readonly; `performance` state removed from context (use `renderer.instance.info`).
- `invalidate` and `advance` come from `useTres()` / `useTresContext().renderer`.

## Removed composables

| v4 | v5 replacement |
|---|---|
| `useRenderLoop().onLoop` | `useLoop().onBeforeRender` / `@loop` on canvas |
| `useCamera` | `useTres().camera` |
| `useTresReady` | `@ready` event on `TresCanvas` |
| `useSeek` / `seekByName` | `useGraph(object).nodes` |
| `useRaycaster` | pointer events on components |
| `useTresEventManager` | built-in `@pmndrs/pointer-events` system |
| `useLogger` | `logError` / `logWarning` utils |

## TresCanvas props

WebGL context props (`alpha`, `antialias`, `depth`, `stencil`, `logarithmicDepthBuffer`, `preserveDrawingBuffer`, `powerPreference`, `failIfMajorPerformanceCaveat`) are readonly after mount. Set them statically. `shadows`, `clearColor`, `clearAlpha`, `toneMapping`, `shadowMapType`, `toneMappingExposure`, `outputColorSpace`, `renderMode`, `dpr` stay reactive.

## Versions after 5.0

- 5.1.0: kebab-case components (`<tres-mesh>`).
- 5.2.0: `TresCanvasProps`, `TresCanvasEmits`, `TresCanvasInstance` exported types.
- 5.3.0: `customRendererOptions.primitivePrefix`; `useForwardPropsEmits` integrated.
- 5.5.0: `TresCanvasContext` exported (bring your own canvas).
- 5.7.0: three `<r179` supported (`Clock` fallback).
- 5.8.0: `fpsLimit`.
- 5.9.0: `TresPortal`, `isWebGPU` flag, `isWebGPURenderer` guard, WebGL `shadowMapType` default now `PCFShadowMap`.

History: https://github.com/Tresjs/tres/blob/main/packages/core/CHANGELOG.md
