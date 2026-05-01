---
category: Watch
alias: pausableWatch
---

# watchPausable

Pausable watch

::: info
This function will be removed in future version.
:::

::: tip

Pausable Watcher has been added to Vue since 3.5, use `const { stop, pause, resume } = watch(watchSource, callback)` instead.

:::

## Usage

Use as normal the `watch`, but return extra `pause()` and `resume()` functions to control.

```ts
import { watchPausable } from '@vueuse/core'
import { nextTick, shallowRef } from 'vue'

const source = shallowRef('foo')

const { stop, pause, resume } = watchPausable(
  source,
  v => console.log(`Changed to ${v}``

## Type Declarations

```ts
export interface WatchPausableReturn extends Pausable {
  stop: WatchStopHandle
}
export type WatchPausableOptions<Immediate> =
  WatchWithFilterOptions<Immediate> & PausableFilterOptions
/** @deprecated Use Vue's built-in `watch` instead. This function will be removed in future version. */
export declare function watchPausable<
  T,
  Immediate extends Readonly<boolean> = false,
>(
  source: WatchSource<T>,
  cb: WatchCallback<T, Immediate extends true ? T | undefined : T>,
  options?: WatchPausableOptions<Immediate>,
): WatchPausableReturn
/** @deprecated Use Vue's built-in `watch` instead. This function will be removed in future version. */
export declare function watchPausable<
  T extends Readonly<MultiWatchSources>,
  Immediate extends Readonly<boolean> = false,
>(
  sources: [...T],
  cb: WatchCallback<MapSources<T>, MapOldSources<T, Immediate>>,
  options?: WatchPausableOptions<Immediate>,
): WatchPausableReturn
/** @deprecated Use Vue's built-in `watch` instead. This function will be removed in future version. */
export declare function watchPausable<
  T extends object,
  Immediate extends Readonly<boolean> = false,
>(
  source: T,
  cb: WatchCallback<T, Immediate extends true ? T | undefined : T>,
  options?: WatchPausableOptions<Immediate>,
): WatchPausableReturn
/** @deprecated Use Vue's built-in `watch` instead. This function will be removed in future version. */
export declare const pausableWatch: typeof watchPausable
```
