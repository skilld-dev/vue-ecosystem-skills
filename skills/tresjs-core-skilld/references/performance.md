# Performance

https://docs.tresjs.org/api/advanced/performance

## Render modes

`renderMode` on `TresCanvas` (dist/tres.d.ts:134-139):

- `always` (default): render every frame. Simplest, highest cost.
- `on-demand`: render only when reactive state changes or after `invalidate()`.
- `manual`: render only when `advance()` is called.

Get `invalidate` / `advance` from `useTres()`, `useLoop()` callbacks, or `useTresContext().renderer`.

```ts
const { scene, invalidate } = useTres()
scene.value.add(meshBuiltInJs)
invalidate() // required: plain mutations are invisible to reactivity
```

`fpsLimit` (5.8.0) caps the loop frequency for battery/CPU savings (dist/tres.d.ts:692-696).

## Reactivity

- Template refs to instances: `shallowRef`, never `ref`. Deep proxies on Three.js objects are slow and rarely useful.
- `shallowReactive` over `reactive` for grouped Three.js state.
- Mutate instance properties directly inside `useLoop` callbacks (`mesh.rotation.y += delta * 2`); do not funnel per-frame values through reactive props.
- Keep `args` stable: reactive `args` changes recreate the instance (geometry rebuild). Animate with props (`position`, `rotation`) or refs instead.
- `dpr` accepts `[min, max]` to clamp resolution on high-DPI devices (dist/tres.d.ts:279-283).

## Disposal

- Template-declared objects (`<TresMesh>` etc.) are disposed automatically on unmount.
- `<primitive :object>` does NOT dispose by default (protects shared objects). Options for the `dispose` prop: `'default'` (no disposal), `false`/`null` (disable), `true` (force), or a custom `(self) => void` function (dist/tres.d.ts:388, https://docs.tresjs.org/api/advanced/primitives).

```ts
onUnmounted(() => {
  geometry.dispose()
  material.dispose()
})
```

- Use the exported `dispose(object)` helper for whole subtrees (dist/tres.d.ts:654).

## Frame loop discipline

- Scale movement by `delta` (seconds) for refresh-rate independence.
- Order work with `onBeforeRender(cb, priority)`; lower runs earlier, default 0.
- Only take over with `useLoop().render(fn)` when you must (post-processing); then you own rendering and must call `notifySuccess()`.
- Post-processing alternative: `@tresjs/post-processing` package.

## Measuring

`renderer.info` (draw calls, geometries, textures) replaces the v4 context `performance` state. Watch `renderer.info.render.calls` in dev to catch draw call growth.
