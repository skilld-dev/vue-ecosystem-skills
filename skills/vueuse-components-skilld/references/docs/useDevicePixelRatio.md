---
category: Sensors
---

# useDevicePixelRatio

Reactively track `window.devicePixelRatio`

> NOTE: there is no event listener for `window.devicePixelRatio` change. So this function uses `Testing media queries programmatically (window.matchMedia)` applying the same mechanism as described in this example.

## Usage

```ts
import { useDevicePixelRatio } from '@vueuse/core'

const { pixelRatio } = useDevicePixelRatio()
```

## Component Usage

```vue
<template>
  <UseDevicePixelRatio v-slot="{ pixelRatio }">
    Pixel Ratio: {{ pixelRatio }}
  </UseDevicePixelRatio>
</template>
```

## Type Declarations

```ts
export interface UseDevicePixelRatioOptions extends ConfigurableWindow {}
export interface UseDevicePixelRatioReturn {
  pixelRatio: Readonly<ShallowRef<number>>
  stop: WatchStopHandle
}
/**
 * Reactively track `window.devicePixelRatio`.
 *
 * @see https://vueuse.org/useDevicePixelRatio
 *
 * @__NO_SIDE_EFFECTS__
 */
export declare function useDevicePixelRatio(
  options?: UseDevicePixelRatioOptions,
): UseDevicePixelRatioReturn
```
