# WebGPU (experimental)

https://docs.tresjs.org/api/advanced/web-gpu

TresJS supports the Three.js WebGPU renderer via the `renderer` prop on `TresCanvas` (dist/tres.d.ts:285-288). `TresRenderer = WebGLRenderer | Renderer` where `Renderer` comes from `three/webgpu` (dist/tres.d.ts:140).

## Setup

Pass a factory receiving `TresRendererSetupContext` (`sizes`, `scene`, `camera`, `canvas`, dist/tres.d.ts:290-295):

```vue
<script setup lang="ts">
import { TresCanvas } from '@tresjs/core'
import { WebGPURenderer } from 'three/webgpu'
import type { TresRendererSetupContext } from '@tresjs/core'

const createWebGPURenderer = (ctx: TresRendererSetupContext) =>
  new WebGPURenderer({
    canvas: toValue(ctx.canvas),
    alpha: true,
    antialias: true,
  })
</script>

<template>
  <TresCanvas :renderer="createWebGPURenderer">
    <TresPerspectiveCamera :position="[3, 3, 3]" />
    <!-- scene -->
  </TresCanvas>
</template>
```

Since 5.8.1 the custom renderer is reused per canvas across HMR updates (https://github.com/Tresjs/tres/blob/main/packages/core/CHANGELOG.md).

## Branching on renderer type

- `context.isWebGPU: ComputedRef<boolean>` from `useTresContext()` (since 5.9.0, dist/tres.d.ts:357-365).
- `isWebGPURenderer(value)` / `isWebGLRenderer(value)` type guards (dist/tres.d.ts:1204-1232).

Granularity matters: `isWebGPU` reflects the renderer instance, not the active backend. A `WebGPURenderer` on its WebGL2 fallback still reports `true`.

Capability consequences (dist/tres.d.ts:1206-1212):

- `NodeMaterial` (TSL) works on either WebGPU-renderer backend.
- GLSL `ShaderMaterial` works on neither under the WebGPU renderer.

## Defaults that differ under WebGPU

- `shadowMapType` defaults to `PCFSoftShadowMap` (vs `PCFShadowMap` on WebGL, changed in 5.9.0) (dist/tres.d.ts:250-255).
- `PCFSoftShadowMap` is deprecated on WebGL (three falls back to `PCFShadowMap`) but still supported on WebGPU (dist/tres.d.ts:248-251).

Browser support: Chrome/Edge stable (113+); Firefox and Safari behind flags. Treat WebGPU as progressive enhancement and feature-detect before choosing the factory.
