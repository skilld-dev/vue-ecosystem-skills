---
name: reka-ui-skilld
description: Vue port of Radix UI Primitives (headless, accessible, unstyled). ALWAYS use when writing code that imports "reka-ui" or "reka-ui/namespaced", building components with Reka UI primitives, or debugging and reviewing Reka UI usage. Provides version-specific API rules, composition patterns, and styling guidance.
---

# Reka UI `reka-ui@2.10.5`

Unstyled, accessible component primitives for Vue 3. Requires `vue >= 3.4.0`
(prepared source `package.json:87-89`). Docs: https://reka-ui.com

## References

- [API surface](./references/api-surface.md): entry points, every component part, utilities.
- [Composition](./references/composition.md): `asChild`, prop forwarding, context injection, controlled state.
- [Styling and animation](./references/styling-animation.md): `data-state`, `--reka-` CSS variables, `force-mount` with `<Transition>`.
- [New and changed components](./references/components-new.md): Drawer, Autocomplete, Color primitives, Month/Year pickers, and version-specific prop changes.
- [Integrations](./references/integrations.md): namespaced entry, Nuxt module, component resolver, dates with `@internationalized/date`, virtualization.

## Setup

```bash
pnpm add reka-ui   # or npm / yarn / bun
```

```vue
<script setup lang="ts">
import { DialogRoot, DialogTrigger, DialogPortal, DialogOverlay, DialogContent, DialogTitle } from 'reka-ui'
</script>

<template>
  <DialogRoot>
    <DialogTrigger>Edit profile</DialogTrigger>
    <DialogPortal>
      <DialogOverlay />
      <DialogContent>
        <DialogTitle>Edit profile</DialogTitle>
      </DialogContent>
    </DialogPortal>
  </DialogRoot>
</template>
```

## API changes (2.10.x and 2.9.x)

Prioritized recent releases. Baseline skill covered up to 2.9.7.

- NEW `Drawer` primitive (2.10.0): swipe dismiss, snap points, nested drawers. Parts: `DrawerRoot/Trigger/Portal/Overlay/Content/Close/Title/Description/Handle/SwipeArea/Viewport/Indent/IndentBackground` (prepared source `src/Drawer/`). Release: https://github.com/unovue/reka-ui/releases/tag/v2.10.0
- NEW `ConfigProvider` `teleportTo` prop: global default teleport target (prepared source `src/ConfigProvider/ConfigProvider.vue:45`)
- NEW `DialogRoot` `unmountOnHide` prop, default `true`; set `false` to keep content mounted when hidden (prepared source `src/Dialog/DialogRoot.vue:20`)
- NEW `SelectRoot` `nullableValue` prop for a hidden-input value representing the empty selection (prepared source `src/Select/SelectRoot.vue:18`)
- NEW `HoverCardRoot` `enableTouch` prop, default `false` (prepared source `src/HoverCard/HoverCardRoot.vue:15`)
- NEW `DateFieldRoot` `stepSnapping` prop, default `false` (prepared source `src/DateField/DateFieldRoot.vue:57`)
- NEW `TreeItem` `disabled` prop (2.10.0): https://github.com/unovue/reka-ui/releases/tag/v2.10.0
- NEW `TabsIndicator` exposes `--reka-tabs-indicator-size`, `--reka-tabs-indicator-thickness`, `--reka-tabs-indicator-position` CSS variables (prepared source `src/Tabs/TabsIndicator.vue:73-75`)
- Better type inference for `useEmitAsProps` and `useForwardPropsEmits` (2.10.0)
- NEW `Autocomplete` component (2.9.0), a Combobox-style input with its own `Autocomplete*` part family. Docs: https://reka-ui.com/docs/components/autocomplete
- NEW Color primitives (2.9.0): `ColorArea*`, `ColorField*`, `ColorSlider*`, `ColorSwatch`, `ColorSwatchPicker*`, plus color parse/convert utilities exported from the root
- NEW `TimeRangeField` (2.9.0): `TimeRangeFieldRoot`, `TimeRangeFieldInput`
- NEW Month and Year pickers (2.9.0): `MonthPicker*`, `YearPicker*` and `MonthRangePicker*`, `YearRangePicker*` families
- NEW `CheckboxRoot`/`SwitchRoot` custom boolean values: `trueValue` and `falseValue` props replace the fixed `true`/`false` (prepared source `src/Checkbox/CheckboxRoot.vue:27-31`)
- NEW `DropdownMenuFilter` part for searchable dropdown menus (2.9.0)
- NEW `Splitter` pixel sizing and constraints (2.9.0)
- NEW global tooltip content configuration via `TooltipProvider` (2.9.0)
- Menu internals exported from `reka-ui/internal`; unstable, may change without semver (prepared source `src/internal.ts:1-7`)

Earlier breaking changes still relevant when touching older code:

- `radix-vue` renamed to `reka-ui`; CSS variables use `--reka-` prefix and data attributes use `data-reka-`. Migration: https://reka-ui.com/docs/guides/migration
- Combobox refactor: `filterFunction` prop removed; `searchTerm` and `displayValue` moved from Root to `ComboboxInput` (migration guide above)
- `Checkbox`, `Toggle`, `MenuCheckboxItem` use standard `v-model` instead of `v-model:checked` / `v-model:pressed` (migration guide above)
- `PaginationRoot` `itemsPerPage` is required (migration guide above)
- `weekStartsOn` on Calendar/DatePicker is locale-independent since 2.8.0: https://github.com/unovue/reka-ui/releases/tag/v2.8.0

Release index: https://github.com/unovue/reka-ui/releases

## Best practices

- Compose with `asChild`: render a Reka primitive as your own element or component while keeping behavior and accessibility (https://reka-ui.com/docs/guides/composition)

```vue
<TooltipTrigger asChild>
  <MyButton>Hover me</MyButton>
</TooltipTrigger>
```

- Build wrappers with `useForwardPropsEmits` so all props and emits pass through to the primitive (https://reka-ui.com/docs/utilities/use-forward-props-emits)

```ts
const props = defineProps<AccordionRootProps>()
const emits = defineEmits<AccordionRootEmits>()
const forwarded = useForwardPropsEmits(props, emits)
// <AccordionRoot v-bind="forwarded">
```

- Wrap the app in `ConfigProvider` to set `dir` (RTL), `locale`, `scrollBody`, and a `teleportTo` default (https://reka-ui.com/docs/utilities/config-provider)

```vue
<ConfigProvider dir="rtl" :scroll-body="false">
  <App />
</ConfigProvider>
```

- Use `useForwardExpose` in fragment (multi-root) components so template refs return the target DOM element (https://reka-ui.com/docs/utilities/use-forward-expose)

```ts
const { forwardRef } = useForwardExpose()
// <div :ref="forwardRef">...</div>
```

- Style states via `data-state` attributes instead of toggling classes; use `:deep()` for teleported content in scoped styles (https://reka-ui.com/docs/guides/styling)

```css
.AccordionItem[data-state="open"] { border-bottom-width: 2px; }
```

- Animate with `<Transition>` by adding `force-mount` to content parts and controlling unmount yourself (https://reka-ui.com/docs/guides/animation)

```vue
<Transition name="fade">
  <DialogContent force-mount>...</DialogContent>
</Transition>
```

- Virtualize long lists with `ComboboxVirtualizer`, `ListboxVirtualizer`, `AutocompleteVirtualizer`, or `TreeVirtualizer`; give the scroll container a fixed height (https://reka-ui.com/docs/guides/virtualization)

```vue
<ComboboxViewport class="max-h-80 overflow-y-auto">
  <ComboboxVirtualizer :options="items" :estimate-size="25" v-slot="{ option }">
    <ComboboxItem :value="option">{{ option.label }}</ComboboxItem>
  </ComboboxVirtualizer>
</ComboboxViewport>
```

- Access internal primitive state from custom children with `injectXContext` functions such as `injectAccordionRootContext` (https://reka-ui.com/docs/guides/inject-context)

- `useId` from Reka UI resolves in order: a passed deterministic id, the `ConfigProvider` `useId` source, Vue's native `useId` (Vue 3.5+), then a counter fallback (prepared source `src/shared/useId.ts:26-34`). On Nuxt with Vue below 3.5, pass Nuxt's `useId` through `ConfigProvider` to avoid hydration id mismatches (https://reka-ui.com/docs/guides/server-side-rendering)

- Date and time components take `DateValue` and `TimeValue` objects from `@internationalized/date` (a direct dependency), never raw strings (https://reka-ui.com/docs/guides/dates)

## Common gotchas

- Every part must sit under its Root; most components also need `*Content` inside a `*Portal` or `Teleport` for correct stacking.
- `Presence` `forceMount` renders content regardless of open state; handle visibility yourself, for example with `:hidden` (https://reka-ui.com/docs/utilities/presence).
- Hidden form fields use the part's `name` and `value` props; `SelectRoot` also accepts `nullableValue` for the empty state.
- Import from `reka-ui` for tree-shaking, or `reka-ui/namespaced` for grouped parts like `Dialog.Root`; see [Integrations](./references/integrations.md).
