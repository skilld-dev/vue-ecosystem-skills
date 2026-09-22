# Components

Source of truth: `dist/tres.d.ts` (types), https://docs.tresjs.org/api/components/tres-canvas

## TresCanvas

Creates the Three.js environment: canvas, scene, renderer, render loop, context, event system, disposal. Sizes to its parent element by default; `window-size` fills the viewport (dist/tres.d.ts:686-691).

### Readonly props (WebGL context, set once)

`antialias` (default true), `alpha` (default false), `depth` (true), `stencil` (true), `logarithmicDepthBuffer` (false), `preserveDrawingBuffer` (false), `powerPreference` ('default'), `premultipliedAlpha` (true), `failIfMajorPerformanceCaveat` (false), `precision` ('highp') (dist/tres.d.ts:141-206).

Changing these at runtime does nothing without recreating the renderer. Decide them before mount (device detection, etc.).

### Reactive props

- `clearColor` (ColorRepresentation), `clearAlpha` (0-1)
- `shadows` (default false), `shadowMapType` (default `PCFShadowMap` on WebGL, `PCFSoftShadowMap` on WebGPU since 5.9.0, dist/tres.d.ts:250-255)
- `toneMapping` (default `ACESFilmicToneMapping`, dist/tres.d.ts:243-245), `toneMappingExposure` (1), `outputColorSpace`
- `renderMode`: `'always' | 'on-demand' | 'manual'` (dist/tres.d.ts:134-139, 272-278)
- `dpr`: number or `[min, max]` range (dist/tres.d.ts:279-283)
- `windowSize` (default false)
- `fpsLimit` (since 5.8.0, default undefined = unlimited, dist/tres.d.ts:692-696)
- `useLegacyLights` (deprecated, dist/tres.d.ts:257-260)

### Other props

- `camera`: custom `TresCamera` instance; otherwise a default `PerspectiveCamera` is created (dist/tres.d.ts:682-685)
- `renderer`: `(ctx: TresRendererSetupContext) => TresRenderer` factory for a custom WebGL or WebGPU renderer (dist/tres.d.ts:285-288). See [webgpu.md](./webgpu.md).
- `enableProvideBridge`: default true, lets Vue `provide`/`inject` cross the TresJS renderer boundary (dist/tres.d.ts:697-703)
- `customRendererOptions.primitivePrefix`: string prefix so `<primitive>` becomes e.g. `<myprimitive>`; avoids tag collisions (dist/tres.d.ts:622-625, 705-708)

### Events (ContextEmits, dist/tres.d.ts:709-716)

- `@ready` (TresContext): context initialized. Replaces v4 `useTresReady`.
- `@render` (TresContext), `@before-loop` / `@loop` (TresContextWithClock): per-frame hooks usable directly on the canvas.
- `@error` (Error): renderer init or runtime failure.
- `@pointermissed` (TresPointerEvent): click hit no object.
- All 13 pointer event names (`@click`, `@pointerdown`, ...) exist on the canvas too (dist/tres.d.ts:379-381).

### Exposed

`context` (TresContext | undefined) and `dispose()` via template ref (dist/tres.d.ts:778-781).

```ts
const canvasRef = ref<TresCanvasInstance>()
onUnmounted(() => canvasRef.value?.dispose())
```

## TresCanvasContext

Same props and events as `TresCanvas`, but you provide the `<canvas>` element via the required `canvas` prop and own sizing/styling yourself. Advanced use: host frameworks that own the canvas. Exported since 5.5.0 (dist/tres.d.ts:679-768). https://docs.tresjs.org/api/components/tres-context

```vue
<canvas ref="canvasRef" class="h-full w-full">
  <TresCanvasContext v-if="canvasRef" :canvas="canvasRef">
    <TresPerspectiveCamera :position="[3, 3, 3]" />
  </TresCanvasContext>
</canvas>
```

## TresPortal

New in 5.9.0. Reparents declarative children into any `Object3D`/`Scene` target; a thin wrapper over Vue `<Teleport>`, children stay reactive. Props: `to` (Object3D, required), `disabled` (boolean, default false renders children in place) (dist/tres.d.ts:852-858).

- Structural only: `attach` inside the portal resolves against the target (`<TresColor attach="background" />` sets the target scene's background).
- It does not override the injected scene context: `useTres().scene` still returns the main scene. Provide your own context if slot children must target the portal scene.
- Rendering the target scene is your job (e.g. to a texture via FBO).
- Building block of `MeshPortalMaterial` in `@tresjs/cientos`.

https://docs.tresjs.org/api/components/tres-portal

## UseLoader component

Renderless wrapper around `useLoader` for template-driven loading. Props: `loader`, `path`, `manager`, `extensions`; emits `loaded`, `error`. Scoped slot receives `{ state, isLoading, error }` (dist/tres.d.ts:526-560). `extensions` was added to the component in 5.8.1 (https://github.com/Tresjs/tres/blob/main/packages/core/CHANGELOG.md).

```vue
<UseLoader :loader="TextureLoader" path="/textures/brick.jpg" v-slot="{ state, isLoading }">
  <TresMesh v-if="state">
    <TresBoxGeometry />
    <TresMeshStandardMaterial :map="state" />
  </TresMesh>
</UseLoader>
```

## Default export

The package default export is the Vue plugin (`app.use(...)`) (dist/tres.d.ts:1241). Registering it manually is rarely needed with `TresCanvas`.
