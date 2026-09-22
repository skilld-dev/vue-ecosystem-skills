# New and changed components

## Drawer (2.10.0)

Release: https://github.com/unovue/reka-ui/releases/tag/v2.10.0. Docs: https://reka-ui.com/docs/components/drawer

Bottom/side sheet with swipe dismiss, snap points, nested drawers, and scroll locking.

```vue
<script setup lang="ts">
import {
  DrawerRoot, DrawerTrigger, DrawerPortal, DrawerOverlay, DrawerContent,
  DrawerTitle, DrawerDescription, DrawerHandle,
} from 'reka-ui'
import { ref } from 'vue'
const open = ref(false)
</script>

<template>
  <DrawerRoot v-model:open="open" swipe-direction="down" :snap-points="['148px', 0.5, 1]">
    <DrawerTrigger>Open</DrawerTrigger>
    <DrawerPortal>
      <DrawerOverlay />
      <DrawerContent>
        <DrawerHandle />
        <DrawerTitle>Settings</DrawerTitle>
        <DrawerDescription>Swipe down to dismiss.</DrawerDescription>
      </DrawerContent>
    </DrawerPortal>
  </DrawerRoot>
</template>
```

`DrawerRoot` props (prepared source `src/Drawer/DrawerRoot.vue:25-49`):

- `v-model:open`, `defaultOpen`
- `modal`: `true` (default, focus trap plus scroll lock), `'trap-focus'` (focus trap only, for side panels), or `false`
- `swipeDirection`: `'down'` default; also `up`, `left`, `right`
- `snapPoints`: fractions 0 to 1, pixel numbers above 1, or strings like `'148px'` / `'30rem'`
- `v-model:snapPoint`, `defaultSnapPoint`, `snapToSequentialPoints` (default `false`; snap one step at a time instead of nearest)
- `@update:open` receives `(value, details)` where `details.reason` is one of `swipe`, `escape-key`, `outside-press`, `click`, `cancel`, `trigger-press`, `close-press`

Other parts: `DrawerClose`, `DrawerSwipeArea`, `DrawerViewport`, `DrawerIndent`, `DrawerIndentBackground`. `initialFocus`, `finalFocus` on content were fixed in 2.10.5 (https://github.com/unovue/reka-ui/releases/tag/v2.10.5).

## Autocomplete (2.9.0)

Combobox-style filter input. Docs: https://reka-ui.com/docs/components/autocomplete

```vue
<script setup lang="ts">
import {
  AutocompleteRoot, AutocompleteInput, AutocompleteContent,
  AutocompleteViewport, AutocompleteItem, AutocompleteEmpty,
} from 'reka-ui'
</script>

<template>
  <AutocompleteRoot v-model="value">
    <AutocompleteInput placeholder="Search..." />
    <AutocompleteContent>
      <AutocompleteEmpty>No results.</AutocompleteEmpty>
      <AutocompleteViewport>
        <AutocompleteItem v-for="item in items" :key="item" :value="item">
          {{ item }}
        </AutocompleteItem>
      </AutocompleteViewport>
    </AutocompleteContent>
  </AutocompleteRoot>
</template>
```

Also `AutocompleteTrigger`, `AutocompleteCancel`, `AutocompleteGroup`, `AutocompleteLabel`, `AutocompleteItemIndicator`, `AutocompleteVirtualizer`. IME composition is handled (2.9.3, 2.10.2).

## Color primitives (2.9.0)

`ColorArea` (2D picker), `ColorSlider`, `ColorField` (text input), `ColorSwatch`, `ColorSwatchPicker`. Values use the exported color types (`HSBColor`, `RGBColor`, `HSLColor`) with `parseColor`, `colorToString`, and conversion helpers. Import them from the root entry, not an internal path.

```vue
<ColorSliderRoot v-model="color" orientation="horizontal">
  <ColorSliderTrack><ColorSliderThumb /></ColorSliderTrack>
</ColorSliderRoot>
```

## Month and Year pickers (2.9.0)

`MonthPicker*`, `YearPicker*`, `MonthRangePicker*`, `YearRangePicker*` follow the Calendar part shape: `Root`, `Header`, `Heading`, `Grid`, `Cell`, `CellTrigger`, `Next`, `Prev`, `GridBody`, `GridRow`. Selecting preserves the day and month of the current value (fixed in 2.9.6).

## TimeRangeField (2.9.0)

`TimeRangeFieldRoot` plus `TimeRangeFieldInput` for start/end time ranges; same segment editing as `TimeField`.

## Splitter, Tree, Stepper

Present before 2.9.0, recently extended:

- `Splitter`: `SplitterGroup`, `SplitterPanel`, `SplitterResizeHandle`; pixel sizing and constraints since 2.9.0; `data-state="collapsed"` on pixel-unit panels since 2.10.1 (https://github.com/unovue/reka-ui/releases/tag/v2.10.1)
- `Tree`: `TreeRoot`, `TreeItem`, `TreeVirtualizer`; `TreeItem` `disabled` since 2.10.0
- `Stepper`: `StepperRoot`, `StepperItem`, `StepperTrigger`, `StepperTitle`, `StepperDescription`, `StepperIndicator`, `StepperSeparator`; `StepperIndicator` renders a `span` by default since 2.10.4

## Changed props

- `CheckboxRoot` and `SwitchRoot`: `trueValue` / `falseValue` for custom boolean values (prepared source `src/Checkbox/CheckboxRoot.vue:27-31`); `CheckboxGroupRoot` groups multiple checkboxes under one `v-model`
- `DropdownMenuFilter`: filter input inside `DropdownMenuContent` (2.9.0)
- `TooltipProvider`: global tooltip content defaults (2.9.0)
- `DateFieldRoot`: `stepSnapping`, default `false` (prepared source `src/DateField/DateFieldRoot.vue:57`)
- `SelectRoot`: `nullableValue` hidden-input value for the empty selection (prepared source `src/Select/SelectRoot.vue:18`)
- `HoverCardRoot`: `enableTouch`, default `false` (prepared source `src/HoverCard/HoverCardRoot.vue:15`)
- `DialogRoot`: `unmountOnHide`, default `true` (prepared source `src/Dialog/DialogRoot.vue:20`)
- `Collapsible`, `Accordion`, `Dialog` expose `unmountOnHide`; `NumberField` has `focusOnClick`, `readonly`, and `stepSnapping`
