# Integrations

## Namespaced entry

`reka-ui/namespaced` groups parts under a single import; useful to avoid long import lists:

```vue
<script setup lang="ts">
import { Dialog } from 'reka-ui/namespaced'
</script>

<template>
  <Dialog.Root>
    <Dialog.Trigger>Trigger</Dialog.Trigger>
  </Dialog.Root>
  <Dialog.Portal>
    <Dialog.Content>...</Dialog.Content>
  </Dialog.Portal>
</template>
```

Guide: https://reka-ui.com/docs/guides/namespaced-components. Prefer the root entry (`reka-ui`) when tree-shaking matters; both are first-class.

## Nuxt module

```ts
// nuxt.config.ts
export default defineNuxtConfig({
  modules: ['reka-ui/nuxt'],
})
```

Options: `components` (boolean or per-component map to disable auto-import) and `prefix` (prepared source `dist/nuxt/index.d.mts:4-7`).

Hydration: with Vue below 3.5, DOM ids can differ between server and client. Pass Nuxt's `useId` through `ConfigProvider` to keep ids stable (https://reka-ui.com/docs/guides/server-side-rendering). With Vue 3.5+, Reka UI's `useId` prefers Vue's native `useId` automatically (prepared source `src/shared/useId.ts:26-34`).

## unplugin-vue-components resolver

```ts
// vite.config.ts
import RekaUiResolver from 'reka-ui/resolver'

export default {
  plugins: [Components({ resolvers: [RekaUiResolver({ prefix: '' })] })],
}
```

Options: `prefix` for template component names, default `''` (prepared source `dist/resolver/index.d.mts:3-11`).

## Dates and times

Date pickers, calendars, and date fields use `DateValue` types from `@internationalized/date` (a direct dependency of reka-ui):

```ts
import { CalendarDate, today, getLocalTimeZone } from '@internationalized/date'

const value = ref(today(getLocalTimeZone()) as CalendarDate)
```

```vue
<DatePickerRoot v-model="value" />
```

`isDateUnavailable`, `minValue`, `maxValue` props take the same value types. `reka-ui/date` exports month/grid helpers such as `createMonth`, `createYearGrid`, and `getWeekNumber` for custom calendar layouts. Guide: https://reka-ui.com/docs/guides/dates

## Localization and direction

Set locale and `dir` (`'ltr'` / `'rtl'`) on `ConfigProvider`, or read them in setup with `useLocale()` and `useDirection()`. Formatting goes through `useDateFormatter()`. Number and filter behavior uses `useFilter()` with locale-aware `startsWith`, `endsWith`, and `contains` matchers. Guide: https://reka-ui.com/docs/guides/i18n

## Virtualization

`ComboboxVirtualizer`, `ListboxVirtualizer`, `AutocompleteVirtualizer`, and `TreeVirtualizer` wrap `@tanstack/vue-virtual`:

```vue
<ComboboxViewport class="max-h-80 overflow-y-auto">
  <ComboboxVirtualizer v-slot="{ option }" :options="items" :estimate-size="25">
    <ComboboxItem :value="option">{{ option.label }}</ComboboxItem>
  </ComboboxVirtualizer>
</ComboboxViewport>
```

The scroll container needs a bounded height. Guide: https://reka-ui.com/docs/guides/virtualization
