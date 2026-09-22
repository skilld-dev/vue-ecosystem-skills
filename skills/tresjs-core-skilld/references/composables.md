# Composables

Source of truth: `dist/tres.d.ts`. All `useTres*`/`useLoop` composables only work in components under a `TresCanvas` (context is injected).

## useTres

Simplified context for app code (dist/tres.d.ts:574-606). Returns:

- `scene: ShallowRef<TresScene>`, `sizes` (`width`, `height`, `pixelRatio`, `aspectRatio`)
- `renderer: TresRenderer` (the `WebGLRenderer` or WebGPU `Renderer` instance directly)
- `camera: ComputedRef<Camera | undefined>` (the active camera)
- `controls`, `extend`, `events`
- `invalidate()` (schedule a render in `on-demand` mode), `advance()` (render one frame in `manual` mode)

Prefer this over `useTresContext` unless you write library code.

## useTresContext

Full internal context (dist/tres.d.ts:350-376):

- `camera` is the camera manager: `activeCamera`, `cameras`, `registerCamera`, `deregisterCamera`, `setActiveCamera` (dist/tres.d.ts:85-107)
- `renderer` is the renderer manager with `loop`, `instance`, `advance`, `onReady`, `onRender`, `onError`, `invalidate`, `canBeInvalidated`, `mode`, `replaceRenderFunction`, `error` (dist/tres.d.ts:303-332)
- `isWebGPU: ComputedRef<boolean>` (since 5.9.0) reflects whether the renderer instance is a WebGPU `Renderer`, including its WebGL2 fallback (dist/tres.d.ts:357-365)
- `scene`, `sizes`, `controls`, `events`, `extend`

Error handling: renderer failures surface as `TresRendererError` with `code: 'INITIALIZATION_FAILED'` (dist/tres.d.ts:124-130); listen via `@error` on the canvas or `renderer.onError`.

## useLoop

(dist/tres.d.ts:608-621)

- `onBeforeRender(cb, priority?)` and `onRender(cb, priority?)`: cb receives `{ delta, elapsed, renderer, camera, scene, sizes, controls, events, extend, invalidate, advance }`. Priority default 0; higher numbers run later in the same frame. Returns `{ off }` to unregister.
- `render(fn)`: replaces the render function entirely (post-processing, multi-pass). `fn` gets only `notifySuccess`; pull renderer/scene/camera from `useTres()`. Always call `notifySuccess()`, even when you skipped rendering.
- `stop()`, `start()`, `isActive`.

`delta` and `elapsed` are seconds. On the canvas component itself, use `@before-loop` / `@loop` instead.

## useLoader

(dist/tres.d.ts:17-65)

```ts
function useLoader<T, Shallow extends boolean = false>(
  Loader: LoaderProto<T>,
  path: MaybeRef<string>,
  options?: TresLoaderOptions<T, Shallow>,
): UseLoaderReturn<T, Shallow>
```

- Return: `UseAsyncStateReturn<T, [string], Shallow>` plus `load(path)` and `progress: { loaded, total, percentage }`. So `state`, `isLoading`, `error` come from VueUse `useAsyncState`.
- `options.extensions(loader)`: configure DRACO, KTX2, Meshopt (dist/tres.d.ts:19-33).
- `options.manager`: shared `LoadingManager` across loads.
- `path` is reactive: assigning a new ref value reloads.
- Any Three.js loader with `load`/`loadAsync` works: `GLTFLoader`, `FBXLoader`, `TextureLoader`, ...
- `useTexture` is NOT in core since v5; it lives in `@tresjs/cientos`.

## useGraph

`useGraph(object: MaybeRef<TresObject | undefined>): ComputedRef<TresObjectMap | undefined>` (dist/tres.d.ts:564-565). Returns `nodes`, `materials`, `meshes` name maps plus optional `scene`. The idiomatic way to pull named parts out of a loaded GLTF instead of v4 `useSeek`.

```ts
const { state: model } = useLoader(GLTFLoader, url)
const { nodes, materials } = useGraph(computed(() => model.value?.scene))
// nodes.value['Octane_Octane_Body_0'], materials.value['Paint']
```

## Manager composables (library authors)

- `useCameraManager({ sizes })`: what `TresCanvas` uses for camera registration and switching (dist/tres.d.ts:81-122).
- `useRendererManager({ scene, canvas, options, fpsLimit, contextParts })`: renderer creation, RAF loop, invalidation, error hooks (dist/tres.d.ts:296-332).
- `useTresContextProvider(args)`: create a context to provide yourself (dist/tres.d.ts:369-375). `INJECTION_KEY` is `"useTres"` (dist/tres.d.ts:368).
- `useCameraManager` uses shallow refs internally since 5.9.0 (fix #1453, https://github.com/Tresjs/tres/blob/main/packages/core/CHANGELOG.md).

## Utilities

- Type guards: `isObject3D`, `isMesh`, `isCamera`, `isOrthographicCamera`, `isPerspectiveCamera`, `isColor`, `isColorRepresentation`, `isLayers`, `isBufferGeometry`, `isMaterial`, `isLight`, `isFog`, `isScene`, `isGroup`, `isVectorLike`, `isCopyable`, `isClassInstance`, `isTresCamera`, `isTresObject`, `isTresPrimitive`, `isTresInstance`, `isWebGLRenderer`, `isWebGPURenderer` (dist/tres.d.ts:972-1232). https://docs.tresjs.org/api/utils/type-guards
- `dispose(object)`: dispose an Object3D subtree programmatically (dist/tres.d.ts:654).
- `buildGraph(object)`: non-reactive graph map behind `useGraph` (dist/tres.d.ts:511-524).
- `createTimer()`: unified `Timer`/`Clock` abstraction, r179+ uses `Timer` with Page Visibility support (dist/tres.d.ts:954-970).
- `normalizeColor`, `normalizeVectorFlexibleParam`: prop value normalization (dist/tres.d.ts:656-668).
- `extend(catalogue)`: register extra constructors for template use (dist/tres.d.ts:872-874).
- `templateCompilerOptions`: Vue compiler options marking `Tres*` tags as custom elements (dist/tres.d.ts:670-677).
- `registerTresDevtools(app, tres)`, `DevtoolsMessenger` on `window.__TRES__DEVTOOLS__` (dist/tres.d.ts:876-932).
