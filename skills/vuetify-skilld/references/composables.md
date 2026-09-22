# Public composables

All are named exports of the `vuetify` entry point (`lib/composables/index.js:1`). Each must be called inside a component `setup` context.

## useTheme

```js
const theme = useTheme()
theme.name.value        // active theme name
theme.current.value.colors.primary
theme.change('dark')    // switch to a named theme
theme.toggle()          // light <-> dark
theme.cycle(['light', 'dark', 'custom'])
theme.global.name.value // global (non-scoped) theme name
```

Instance surface: `change`, `cycle`, `toggle`, `isDisabled`, `isSystem`, `themes`, `name`, `current`, `computedThemes`, `styles`, `global` (`lib/composables/theme.d.ts:45`).

## useDisplay

```js
const { mobile, name, width, height, platform, xs, smAndUp, mdAndDown } = useDisplay()
// name.value: 'xs' | 'sm' | 'md' | 'lg' | 'xl' | 'xxl'
// mobile is driven by display.mobileBreakpoint (number or breakpoint name)
```

All flags are refs (`xs`...`xxl`, `smAndUp`...`xlAndDown`, `smAndDown`...`xlAndDown`), plus `width`, `height`, `mobile`, `mobileBreakpoint`, `platform` (`lib/composables/display.d.ts:44`). Thresholds and mobileBreakpoint are configurable, see [configuration.md](./configuration.md).

## useDate

```js
const date = useDate()
date.format('2010-04-13', 'fullDateWithWeekday') // "Tuesday, April 13, 2010"
date.parseISO('2024-01-01T00:00:00Z')            // adapter date
date.toISO(date.date())                          // ISO string
date.isSameDay(a, b); date.addDays(d, 3)
```

Built-in format keys include `fullDate`, `normalDateWithWeekday`, `keyboardDate`, `fullTime24h`, `monthAndYear` (https://vuetifyjs.com/features/dates/). Pickers and `VDateInput` exchange native `Date` objects; use `parseISO`/`toISO` at the boundary. Adapter surface in `lib/composables/date/date.d.ts:23`.

## useLocale / useRtl

```js
const { current, t, n, format } = useLocale()  // t translates component messages
const { isRtl } = useRtl()
```

Locale messages come from `vuetify/locale` plus any `locale.messages` config.

## useGoTo

```js
const goTo = useGoTo()
await goTo(0)                 // scroll to top
await goTo('#target', { duration: 300, easing: 'easeInOutCubic' })
```

## useDefaults

```js
const defaults = useDefaults(['VBtn'])  // resolved defaults for a component, incl. global config
```

Read (not set) the merged defaults that apply to a component in the current `VDefaultsProvider` scope.

## useLayout

Returns registered layout items and rects; used with `VLayout`, `VAppBar`, `VNavigationDrawer`, `VMain` (`lib/composables/layout.js`).

## useHotkey

```js
useHotkey('cmd+s', (e) => save(e))       // cmd = Command on Mac, Control elsewhere
useHotkey('ctrl+shift+k', openPanel, {
  event: 'keydown',       // default keydown
  inputs: true,           // ignore keystrokes in inputs when false
  preventDefault: true,
  sequenceTimeout: 1000,  // for multi-key sequences like 'g d'
})
```

Signature: `useHotkey(keys: MaybeRef<string | undefined>, callback, options?) => () => void`; the return value unregisters the hotkey (`lib/composables/hotkey/hotkey.d.ts:6`). Key aliases include `cmd` -> mod (`lib/composables/hotkey/key-aliases.js:10`). Prefer `cmd` over hardcoding `ctrl` for cross-platform apps.

## useMask

Input mask support used by `VMaskInput` (labs) (`lib/composables/mask/`). Returns mask parsing helpers for controlled inputs.
