---
category: Browser
---

# useScreenOrientation

Reactive Screen Orientation API. It provides web developers with information about the user's current screen orientation.

## Usage

```ts
import { useScreenOrientation } from '@vueuse/core'

const {
  isSupported,
  orientation,
  angle,
  lockOrientation,
  unlockOrientation,
} = useScreenOrientation()
```

To lock the orientation, you can pass an OrientationLockType to the lockOrientation function:

```ts
import { useScreenOrientation } from '@vueuse/core'

const {
  isSupported,
  orientation,
  angle,
  lockOrientation,
  unlockOrientation,
} = useScreenOrientation()

lockOrientation('portrait-primary')
```

and then unlock again, with the following:

```ts
import { useScreenOrientation } from '@vueuse/core'

const { unlockOrientation } = useScreenOrientation()
// ---cut---
unlockOrientation()
```

Accepted orientation types are one of `"landscape-primary"`, `"landscape-secondary"`, `"portrait-primary"`, `"portrait-secondary"`, `"any"`, `"landscape"`, `"natural"` and `"portrait"`.

Screen Orientation API MDN

## Type Declarations

```ts
export type OrientationType =
  | "portrait-primary"
  | "portrait-secondary"
  | "landscape-primary"
  | "landscape-secondary"
export type OrientationLockType =
  | "any"
  | "natural"
  | "landscape"
  | "portrait"
  | "portrait-primary"
  | "portrait-secondary"
  | "landscape-primary"
  | "landscape-secondary"
export interface ScreenOrientation extends EventTarget {
  lock: (orientation: OrientationLockType) => Promise<void>
  unlock: () => void
  readonly type: OrientationType
  readonly angle: number
  addEventListener: (
    type: "change",
    listener: (this: this, ev: Event) => any,
    useCapture?: boolean,
  ) => void
}
export interface UseScreenOrientationOptions extends ConfigurableWindow {}
export interface UseScreenOrientationReturn extends Supportable {
  orientation: ShallowRef<OrientationType | undefined>
  angle: ShallowRef<number>
  lockOrientation: (type: OrientationLockType) => Promise<void>
  unlockOrientation: () => void
}
/**
 * Reactive screen orientation
 *
 * @see https://vueuse.org/useScreenOrientation
 *
 * @__NO_SIDE_EFFECTS__
 */
export declare function useScreenOrientation(
  options?: UseScreenOrientationOptions,
): UseScreenOrientationReturn
```
