# Pointer events

https://docs.tresjs.org/api/events/pointer-events

Event system is built on `@pmndrs/pointer-events` (package.json:48). Events are auto-enabled on `TresCanvas`; no setup needed.

## Names

Exact DOM names (dist/tres.d.ts:379-381): `click`, `contextmenu`, `dblclick`, `pointerdown`, `pointerup`, `pointercancel`, `pointermove`, `pointerover`, `pointerout`, `pointerenter`, `pointerleave`, `wheel`, `lostpointercapture`.

In templates: `@click`, `@pointerdown`, `@pointerenter`, ... In kebab components: `@dblclick` (v5 removed the old `@pointer-down` dashed form).

## Hit rules since v5

- Raycasting drives hit testing; only the first intersected object fires the event (no bubbling through overlapping meshes). Handle overlapping interactive objects on a common parent (`TresGroup @click`).
- `pointerover`/`pointerout` bubble from children; `pointerenter`/`pointerleave` do not.
- `@pointermissed` on `TresCanvas` fires when a click hits no object (dist/tres.d.ts:334-347).

## Payload

Handlers receive a `TresPointerEvent` (a `PointerEvent<MouseEvent>` from `@pmndrs/pointer-events`, dist/tres.d.ts:382):

- `event.point`: world-space hit position
- `event.object`: hit Three.js object (mutate it directly: `e.object.material.color.set('red')`)
- `event.distance`, `event.face`, `event.uv`, `event.xy`

## Example

```vue
<script setup lang="ts">
function onClick(e) {
  e.object.material.color.set(Math.random() * 0xffffff)
}
</script>

<template>
  <TresCanvas @pointermissed="deselect">
    <TresMesh @click="onClick" @pointerenter="onEnter" @pointerleave="onLeave">
      <TresBoxGeometry />
      <TresMeshNormalMaterial />
    </TresMesh>
  </TresCanvas>
</template>
```

Only objects with a `raycast` method can receive events (`EventProps` gate, dist/tres.d.ts:486-489). `<primitive>` supports the same events.
