# API surface: @vueuse/core 15.0.0

Inventory of every public export in the prepared package
(`dist/index.d.ts`, the `types` entry per `package.json:34`). Function groups
follow the official docs categories ([vueuse.org/functions](https://vueuse.org/functions)).
Functions provided by `@vueuse/shared` are re-exported (`dist/index.d.ts:3`) and
listed separately in [shared-api.md](./shared-api.md).

## State

`useAsyncState` · `useDebouncedRefHistory` · `useLocalStorage` ·
`useManualRefHistory` · `useRefHistory` · `useSessionStorage` · `useStorage` ·
`useStorageAsync` · `useThrottledRefHistory`

## Elements

`useActiveElement` · `useDocumentVisibility` · `useDraggable` · `useDropZone` ·
`useElementBounding` · `useElementOverflow` (new, v14.4.0) · `useElementSize` ·
`useElementVisibility` · `useIntersectionObserver` · `useMouseInElement` ·
`useMutationObserver` · `useParentElement` · `useResizeObserver` ·
`useCurrentElement` · `useWindowFocus` · `useWindowScroll` · `useWindowSize`

## Browser

`useBluetooth` · `useBreakpoints` · `useBroadcastChannel` ·
`useBrowserLocation` · `useClipboard` · `useClipboardItems` · `useColorMode` ·
`useCssSupports` · `useCssVar` · `useDark` · `useEventListener` ·
`useEyeDropper` · `useFavicon` · `useFileDialog` · `useFileSystemAccess` ·
`useFullscreen` · `useGamepad` · `useImage` · `useLiveAnnouncer` (new, v15) ·
`useMediaControls` · `useMediaQuery` · `useMemory` · `useObjectUrl` ·
`usePerformanceObserver` · `usePermission` · `usePreferredColorScheme` ·
`usePreferredContrast` · `usePreferredDark` · `usePreferredLanguages` ·
`usePreferredReducedMotion` · `usePreferredReducedTransparency` ·
`useScreenOrientation` · `useScreenSafeArea` · `useScriptTag` · `useShare` ·
`useSSRWidth` · `useStyleTag` · `useTextareaAutosize` · `useTextDirection` ·
`useTitle` · `useUrlSearchParams` · `useVibrate` · `useWakeLock` ·
`useWebMCP` (new, v15) · `useWebNotification` · `useWebWorker` ·
`useWebWorkerFn`

## Sensors

`onClickOutside` · `onElementRemoval` · `onKeyStroke` (+ aliases `onKeyDown`,
`onKeyPressed`, `onKeyUp`) · `onLongPress` · `onStartTyping` · `useBattery` ·
`useDeviceMotion` · `useDeviceOrientation` · `useDevicePixelRatio` ·
`useDevicesList` · `useDisplayMedia` · `useElementByPoint` · `useElementHover` ·
`useFocus` · `useFocusWithin` · `useFps` · `useGeolocation` · `useIdle` ·
`useInfiniteScroll` · `useKeyModifier` · `useMagicKeys` · `useMouse` ·
`useMousePressed` · `useNavigatorLanguage` · `useNetwork` · `useOnline` ·
`usePageLeave` · `useParallax` · `usePointer` · `usePointerLock` ·
`usePointerSwipe` · `useScroll` · `useScrollLock` · `useSpeechRecognition` ·
`useSpeechSynthesis` · `useSwipe` · `useTextSelection` · `useUserMedia`

## Network

`useEventSource` · `useFetch` · `createFetch` · `useWebSocket`

## Animation

`useAnimate` · `useNow` · `useRafFn` · `useTimestamp` · `useTransition` ·
`transition` · `executeTransition` (deprecated) · `TransitionPresets`

## Time

`useCountdown` · `useTemporalNow` (new, v15) · `useTimeAgo` ·
`useTimeAgoIntl` · `formatTimeAgo` · `formatTimeAgoIntl` ·
`formatTimeAgoIntlParts`

## Component

`computedInject` · `createReusableTemplate` · `createTemplatePromise` ·
`useMounted` · `useTemplateRefsList` · `useVirtualList` · `useVModel` ·
`useVModels`

## Reactivity and utilities

`computedAsync` (alias `asyncComputed`) · `createUnrefFn` · `unrefElement` ·
`useAsyncQueue` · `useBase64` · `useCached` · `useCloned` ·
`useConfirmDialog` · `useCycleList` · `useEventBus` · `useMemoize` ·
`useOffsetPagination` · `usePrevious` · `useSorted` · `useStepper` ·
`useSupported` · `useTimeoutPoll`

## Utility values

- Breakpoints presets: `breakpointsAntDesign`, `breakpointsBootstrapV5`,
  `breakpointsElement`, `breakpointsMasterCss`, `breakpointsPrimeFlex`,
  `breakpointsQuasar`, `breakpointsSematic`, `breakpointsTailwind`,
  `breakpointsVuetifyV2`, `breakpointsVuetifyV3`, `breakpointsVuetify`
  (deprecated alias of V2, `dist/index.d.ts:758-762`).
- Globals: `defaultWindow`, `defaultDocument`, `defaultNavigator`,
  `defaultLocation` (`dist/index.d.ts:200-203`).
- SSR handlers: `getSSRHandler`, `setSSRHandler`, `provideSSRWidth`,
  `useSSRWidth`, `customStorageEventName`.
- Serialization: `StorageSerializers` (pick one when a `useStorage` default is
  `null`; see [best practices](./best-practice.md)).
- Misc helpers: `isFocusedElementEditable`, `isTypedCharValid`,
  `mapGamepadToXbox360Controller`, `cloneFnJSON`.

## Configuration interfaces (accepted across many options objects)

- `ConfigurableWindow`, `ConfigurableDocument`,
  `ConfigurableDocumentOrShadowRoot`, `ConfigurableNavigator`,
  `ConfigurableLocation`: injectable `window` / `document` / `navigator` /
  `location` for iframes and tests
  ([guide](https://vueuse.org/config.html)).
- `ConfigurableScheduler` (`dist/index.d.ts:212-217`): `scheduler?: (cb) => Pausable`;
  since v15 the only way to drive `useCountdown`, `useNow`, `useTimestamp`,
  `useTimeAgo`, `useTimeAgoIntl`, `useTemporalNow`, `useElementByPoint`,
  `useMemory`, `useVibrate`, and `useWebSocket` `heartbeat`.
- `ConfigurableDeepRefs` (`dist/index.d.ts:204-211`): `deepRefs?: boolean`,
  default `true`, will flip to `false` in the next major.

## Notable signature shapes (from `dist/index.d.ts`)

- `useCssSupports(property, value, options?)` or
  `useCssSupports(conditionText, options?)` (`dist/index.d.ts:1334-1335`).
- `useOffsetPagination(options)` without `total` returns the infinity-page
  variant without `isLastPage` (`dist/index.d.ts:3778-3780`).
- `usePermission(desc, { controls: true })` returns
  `{ state, query }` (`dist/index.d.ts:3885-3886`).
- `useVirtualList().scrollTo(index, { behavior, block, inline })`
  (`dist/index.d.ts:5346-5353`, options added in v14.4.0).
- `useElementVisibility(el, { controls: true })` returns
  `{ isVisible, stop, ... }` (`dist/index.d.ts:2134-2138`).
- `useWebSocket` heartbeat messages accept reactive
  `string | ArrayBuffer | Blob` (`dist/index.d.ts:5623-5651`).
