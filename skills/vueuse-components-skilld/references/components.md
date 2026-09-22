# Component catalog

Every public component export of `@vueuse/components` 15.0.0. Citations are paths inside the package (`dist/index.d.ts`, `dist/index.js`).

Two shapes:

- **Pure renderless**: renders only the default slot; scoped slot receives the reactive composable return. No wrapper element, no `as` prop.
- **Element wrapper**: renders `props.as || "div"`, uses it as the composable target, passes the scoped slot data. Supports `as`.

Unless noted, slot data equals the `reactive(...)` return of the matching `@vueuse/core` composable.

## On* event components

### OnClickOutside
Element wrapper (dist/index.js:5-17).
- Props: `as`, `options` (`Omit<OnClickOutsideOptions, 'controls'>`, dist/index.d.ts:5-7)
- Emits: `trigger` (DOM Event)
- Slot: default children of the rendered element; the element is the outside-click target
- `options` supports `ignore` (refs or CSS selectors) and `detectIframe` via the core `onClickOutside` options (dist/index.js:7-9; https://vueuse.org/onClickOutside/)

### OnLongPress
Element wrapper (dist/index.js:57-69).
- Props: `as`, `options` (`OnLongPressOptions`)
- Emits: `trigger` (PointerEvent)
- Slot: scoped, receives the full `onLongPress` return (`UseOnLongPressReturn`, dist/index.d.ts:32-34)
- v15 clears a pending long press on `pointercancel` (https://github.com/vueuse/vueuse/releases/tag/v15.0.0)

## Element wrapper components

| Component | Extra props beyond `as` | Slot data |
|---|---|---|
| `UseDraggable` | `storageKey`, `storageType`, plus all `UseDraggableOptions` (`initialValue`, `handle`, `axis`, `disabled`, `containerElement`, `onStart/onMove/onEnd`, ...) (dist/index.d.ts:157-168, dist/index.js:317-336) | `useDraggable` return: `x`, `y`, `style`, `isDragging`, ... |
| `UseElementBounding` | `immediate`, `reset`, `updateTiming`, `windowResize`, `windowScroll` (dist/index.js:348-355) | `width`, `height`, `top`, `right`, `bottom`, `left`, `x`, `y`, `update` |
| `UseElementOverflow` | `observeMutation` (bool or `MutationObserverInit`) (dist/index.js:397-416) | `{ isXOverflowed, isYOverflowed, stop, update }`; also emits `update` on each observer tick |
| `UseElementSize` | `width`, `height` (initial values), `box`, `window` (dist/index.js:623-646) | `{ width, height }` |
| `UseElementVisibility` | `once`, `rootMargin`, `scrollTarget`, `threshold`, `window`; always created with `controls: true` (dist/index.js:661-680) | `useElementVisibility` return with `isVisible` and controls |
| `UseFullscreen` | `autoExit`, `document` (dist/index.js:712-725) | `isFullscreen`, `enter`, `exit`, `toggle`, `isEnabled` |
| `UseMouseInElement` | `handleOutside`, `initialValue`, plus `UseMouse`-style options (dist/index.js:825-847) | `elementX`, `elementY`, `elementPosX`, `elementPosY`, `elementWidth`, `elementHeight`, `isOutside`, `stop`, ... |
| `UseMousePressed` | `capture`, `drag`, `initialValue`, `onPressed`, `onReleased`, `touch` (dist/index.js:857-878) | `pressed`, `x`, `y`, `sourceType` |
| `UsePointerLock` | `document` (dist/index.js:996-1005) | `isSupported`, `locked`, `element`, `triggerElement`, `lock`, `unlock` |
| `UseScreenSafeArea` | `top`, `right`, `bottom`, `left` booleans; renders safe-area padding styles (dist/index.js:1080-1102) | `{ top, right, bottom, left }` CSS values. Caveat: types declare `as` (dist/index.d.ts:548) but the runtime props array omits it (dist/index.js:1096-1101), so it always renders a `div` |

### UseImage
Element wrapper that renders `props.as || "img"` with all props as attributes when no default slot (dist/index.js:763-790).
- Props: the full `UseImageOptions` set (`src`, `srcset`, `sizes`, `alt`, `class`, `crossorigin`, `loading`, `width`, `height`, ...) plus `as`
- Slots: `#loading` and `#error` (receives the error value) take precedence while loading or failed; default slot receives `useImage` return (`isLoading`, `error`, ...)

### UseVirtualList
Renders its own container and wrapper divs, not an `as` element (dist/index.js:1190-1206).
- Props: `list` (required), `options` (required, `UseVirtualListOptions` such as `itemHeight`/`itemWidth`/`overscan`), `height` (string, default `"300px"`)
- Slot: default, scoped per item: `{ index, data, height }`... receives the `item` (`{ index, data }` per row; keep row height synced with `options.itemHeight`, https://vueuse.org/useVirtualList/)
- Exposes `scrollTo(index)` via `ref`
- No default slot renders the literal text `"Please set content!"` (dist/index.js:1198)

## Pure renderless components

| Component | Notable props | Slot data |
|---|---|---|
| `UseActiveElement` | `deep`, `triggerOnRemoval` | `{ element }` (dist/index.js:80-93) |
| `UseBattery` | `navigator` | full `useBattery` return |
| `UseBrowserLocation` | `window` | `useBrowserLocation` return |
| `UseClipboard` | `source`, `read`, `copiedDuring`, `legacy` | `{ copied, copy, isSupported, text }` |
| `UseColorMode` | full `UseColorModeOptions` (`modes`, `selector`, `attribute`, `storageKey`, ...) | `{ mode, system, store }` (dist/index.js:135-141) |
| `UseDark` | full `UseDarkOptions` (`valueDark`, `valueLight`, ...) | `{ isDark, toggleDark }` (dist/index.js:173-178) |
| `UseDeviceMotion` | `requestPermissions` | `useDeviceMotion` return (already reactive) |
| `UseDeviceOrientation` | `window` | full return |
| `UseDevicePixelRatio` | `window` | `{ pixelRatio }` |
| `UseDevicesList` | `constraints`, `onUpdated`, `requestPermissions` | `{ devices, videoInputs, audioInputs, ..., ensurePermissions, permissionGranted }` |
| `UseDocumentVisibility` | `document` | `{ visibility }` (dist/index.js:264-272) |
| `UseEyeDropper` | `initialValue` | `{ isSupported, open, sRGBHex }` |
| `UseGeolocation` | `immediate`, `enableHighAccuracy`, `timeout`, `maximumAge` | full return |
| `UseIdle` | `timeout` (required), `events`, `initialState`, `listenForVisibilityChange` | full `useIdle` return (`idle`, `lastActive`, `reset`) |
| `UseMouse` | `initialValue`, `touch`, `resetOnTouchEnds`, `type`, `target` | `{ x, y, sourceType }` |
| `UseNetwork` | `window` | full `useNetwork` return |
| `UseNow` | `scheduler` | `useNow` return with `controls: true` (dist/index.js:892-904) |
| `UseObjectUrl` | `object` (`Blob | MediaSource | undefined`) | the URL string; slot only renders when the URL exists (dist/index.js:906-915) |
| `UseOffsetPagination` | `total`, `page`, `pageSize`, `onPageChange`, `onPageSizeChange`, `onPageCountChange` | `{ currentPage, currentPageSize, pageCount, isFirstPage, isLastPage, prev, next }`; emits `page-change`, `page-size-change`, `page-count-change` (dist/index.js:918-951) |
| `UseOnline` | `window` | `{ isOnline }` (dist/index.js:954-962) |
| `UsePageLeave` | `window` | `{ isLeft }` (dist/index.js:965-973) |
| `UsePointer` | `target`: `'window'` (default) or `'self'`, `pointerTypes`, `initialValue` | full `usePointer` return (`x`, `y`, `pressure`, `tiltX`, `pointerType`, `isInside`, ...) |
| `UsePreferredColorScheme` | `window` | `{ colorScheme }` |
| `UsePreferredContrast` | `window` | `{ contrast }` |
| `UsePreferredDark` | `window` | `{ prefersDark }` |
| `UsePreferredLanguages` | `window` | `{ languages }` |
| `UsePreferredReducedMotion` | `window` | `{ motion }` |
| `UsePreferredReducedTransparency` | none | `{ transparency }` (dist/index.js:1063-1071) |
| `UseTimeAgo` | `time` (required, `Date | number | string`), `max`, `units`, `messages`, `rounding`, `scheduler` | `useTimeAgo` return with `controls: true` (dist/index.js:1149-1169) |
| `UseTimestamp` | `scheduler`, `callback`, `offset` | `useTimestamp` return with `controls: true` (dist/index.js:1172-1187) |
| `UseWindowFocus` | `window` | `{ focused }` (dist/index.js:1209-1217) |
| `UseWindowSize` | `initialWidth`, `initialHeight`, `listenOrientation`, `includeScrollbar`, `type` | `{ width, height }` |

Notes:

- `UseNow`, `UseTimeAgo`, `UseTimestamp` expose only `scheduler` for timing; the deprecated timer options were removed from core in v15 (https://github.com/vueuse/vueuse/releases/tag/v15.0.0).
- Boolean-returning single-value components wrap their value under a named key (`visibility`, `isOnline`, `isLeft`, `focused`, ...) instead of passing the raw ref.
