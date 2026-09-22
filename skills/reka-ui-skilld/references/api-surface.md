# API surface

Version 2.10.5 (prepared source `package.json:4`). ESM and CJS builds ship for every entry point (prepared source `package.json:32-62`).

## Entry points

| Import | Purpose |
| --- | --- |
| `reka-ui` | All public components, utilities, and types |
| `reka-ui/namespaced` | Grouped parts, for example `Dialog.Root` |
| `reka-ui/nuxt` | Nuxt module with auto-import and prefix options |
| `reka-ui/resolver` | `unplugin-vue-components` resolver |
| `reka-ui/date` | Date helpers: `createMonth`, `createYearGrid`, `getWeekNumber`, `parseStringToDateValue`, comparison predicates, and more |
| `reka-ui/constant` | The `components` and `utilities` name maps used by tooling |
| `reka-ui/internal` | Unstable `Menu` internals; may change without semver (prepared source `src/internal.ts:1-7`) |

Peer dependency: `vue >= 3.4.0`. Key direct dependencies: `@floating-ui/dom`, `@floating-ui/vue`, `@internationalized/date`, `@internationalized/number`, `@tanstack/vue-virtual`, `@vueuse/core`.

## Components

Root parts are named `XxxRoot`; the part families below come from the prepared source constant map (`dist/constant.d.ts`) and `src/index.ts:1-131`.

Accordion, AlertDialog, AspectRatio, Autocomplete, Avatar, Calendar, Checkbox (incl. `CheckboxGroupRoot`), Collapsible, ColorArea, ColorField, ColorSlider, ColorSwatch, ColorSwatchPicker, Combobox, ContextMenu, DateField, DatePicker, DateRangeField, DateRangePicker, Dialog, Drawer, DropdownMenu (incl. `DropdownMenuFilter`), Editable, HoverCard, Label, Listbox, Menubar, MonthPicker, MonthRangePicker, NavigationMenu, NumberField, Pagination, PinInput, Popover, Presence, Progress, RadioGroup, RangeCalendar, Rating, RovingFocus (utilities), ScrollArea, Select, Separator, Slider, Splitter, Stepper, Switch, Tabs (incl. `TabsIndicator`), TagsInput, TimeField, TimeRangeField, Toast, Toggle, ToggleGroup, Toolbar, Tooltip, Tree (incl. `TreeVirtualizer`), Viewport, VisuallyHidden, YearPicker, YearRangePicker, ConfigProvider, FocusScope, Primitive, Slot.

Notable part sets:

- Drawer: `Root`, `Trigger`, `Portal`, `Overlay`, `Content`, `Close`, `Title`, `Description`, `Handle`, `SwipeArea`, `Viewport`, `Indent`, `IndentBackground`
- Autocomplete: `Root`, `Input`, `Anchor`, `Empty`, `Trigger`, `Cancel`, `Group`, `Label`, `Content`, `Viewport`, `Virtualizer`, `Item`, `ItemIndicator`, `Separator`, `Arrow`, `Portal`
- Tree: `Root`, `Item`, `Virtualizer`
- Stepper: `Root`, `Item`, `Trigger`, `Description`, `Title`, `Indicator`, `Separator`
- Color: `ColorAreaRoot/Area/Thumb`, `ColorFieldRoot/Input`, `ColorSliderRoot/Track/Thumb`, `ColorSwatchPickerRoot/Item/ItemSwatch/ItemIndicator`, `ColorSwatch`

## Utilities

Exported from the root (prepared source `src/index.ts:49-68`):

`createContext`, `useBodyScrollLock`, `useDateFormatter`, `useDirection`, `useEmitAsProps`, `useFilter`, `useForwardExpose`, `useForwardProps`, `useForwardPropsEmits`, `useId`, `useLocale`, `useStateMachine`, `withDefault`

Color helpers (prepared source `src/index.ts:69-98`): `parseColor`, `colorToHex` / `colorToHsb` / `colorToHsl` / `colorToRgb` / `colorToString`, `convertToHsb` / `convertToHsl` / `convertToRgb`, `getAreaGradient`, `getSliderGradient`, `getChannelRange`, `setChannelValue(s)`, `isValidColor`, `normalizeColor`, plus the `Color`, `ColorChannel`, `ColorFormat`, `ColorSpace`, `HSBColor`, `HSLColor`, `RGBColor` types.

Shared types (prepared source `src/index.ts:99-109`): `AcceptableValue`, `DataOrientation`, `Direction`, `FormFieldProps`, `GenericComponentInstance`, `ScrollBodyOption`, `SingleOrMultipleProps`, `SingleOrMultipleType`, `StringOrNumber`, `DateRange`, `DateValue`, `TimeValue`, `Formatter`, `SegmentPart`.

`Primitive`, `Slot`, `AsTag`, and `PrimitiveProps` power the `asChild` pattern (prepared source `src/index.ts:40`). `ReferenceElement` is re-exported from `@floating-ui/vue` (prepared source `src/index.ts:129-131`).

Component docs index: https://reka-ui.com/docs/components/accordion
