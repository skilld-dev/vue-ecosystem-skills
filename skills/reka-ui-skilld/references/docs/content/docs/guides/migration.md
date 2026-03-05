---
title: Migration - Radix Vue to Reka UI
description: This guide provides step-by-step instructions for developers transitioning their projects from Radix Vue to Reka UI.
---

# Migration - Radix Vue to Reka UI

<Description>
This guide provides step-by-step instructions for developers transitioning their projects from Radix Vue to Reka UI.
</Description>

## Installation

First and foremost, you need to install the latest `reka-ui`.

<InstallationTabs value="reka-ui" />

Congratulation!  Now that you've installed the above package, let's perform the migration! The first 2 steps are relatively simple. Just do a global search and replace for the following changes.

## Import Statement Changes

The primary change in imports is replacing `radix-vue` with `reka-ui`.

```vue
<script setup lang="ts">
import { TooltipPortal, TooltipRoot, TooltipTrigger } from 'radix-vue' // [!code --]
import { TooltipPortal, TooltipRoot, TooltipTrigger } from 'reka-ui' // [!code ++]
</script>
```

## Naming Convention Changes

CSS variable and data attributes names have been updated to use the `reka` prefix instead of `radix`.

```css
  --radix-accordion-content-width: 300px; /* [!code --] */
  --reka-accordion-content-width: 300px; /* [!code ++] */

  [data-radix-collection-item] {} /* [!code --] */
  [data-reka-collection-item] {} /* [!code ++] */
```

## Component Breaking Changes

### Combobox

- Remove `filter-function` props - `Combobox` has been refactored and improved to support better custom filtering. Read more.

  ```vue
  <template>
    <ComboboxRoot :filter-function="customFilter" />  
  </template>
  ```

- Replace `searchTerm` props of Root to Input's `v-model`
- Move `displayValue` props from Root to Input

  ```vue
  <template>
    <ComboboxRoot v-model:search-term="search" :display-value="(v) => v.name" /> 
    <ComboboxRoot>
      <ComboboxInput v-model="search" :display-value="(v) => v.name" /> 
    </ComboboxRoot>
  </template>
  ```

### Arrow

- Improve arrow polygon - Change the svg polygon to allow better styling.

### Form component

- Rename controlled state to `v-model` - Replace `v-model:checked`, `v-model:pressed` with more familiar API for form component.

```vue
<template>
  <CheckboxRoot v-model:checked="value" /> 
  <CheckboxRoot v-model="value" /> 
</template>
```

- Reposition `VisuallyHidden` - Previously, `VisuallyHidden` were positioned at the root node, causing style scoped to not be applied.

### Menu CheckboxItem

- Similar to the changes in form component, the API for binding `CheckboxItem` has been changed from `v-model:checked` to `v-model`.

```vue
<template>
  <DropdownMenuCheckboxItem v-model:checked="value" /> 
  <DropdownMenuCheckboxItem v-model="value" /> 

  <DropdownMenuCheckboxItem checked /> 
  <DropdownMenuCheckboxItem :model-value="true" /> 
</template>
```

### Pagination

- Required `itemsPerPage` prop - Instead of default `itemsPerPage` value, now it is required as to provide a more explicit hint about the page size.

  ```vue
  <template>
    <PaginationRoot :items-per-page="10" />  
  </template>
  ```

### Calendar

- Remove deprecated step prop - Use `prevPage/nextPage` props for greater control.

  ```vue
  <script setup lang="ts">
  function pagingFunc(date: DateValue, sign: -1 | 1) { // [!code ++]
    if (sign === -1) // [!code ++]
      return date.subtract({ years: 1 }) // [!code ++]
    return date.add({ years: 1 }) // [!code ++]
  } // [!code ++]
  </script>

  <template>
    <CalendarPrev step="year" /> 
    <CalendarPrev :prev-page="(date: DateValue) => pagingFunc(date, -1)" /> 

    <CalendarNext step="year" /> 
    <CalendarNext :next-page="(date: DateValue) => pagingFunc(date, 1)" /> 
  </template>
  ```

### Select

- `SelectValue` no longer render teleported element - Previous implementation of `SelectValue` will render the selected `SelectItem` via teleporting fragment. This causes SSR flickering, and it is unnecessarily computation.

  ```vue
  <template>
    <SelectValue>
       
    </SelectValue>
  </template>
  ```

### Presence

To have better supports for SSR content, we also modify the logic around the usage of `forceMount` for component that utilize Presence:

- `Accordion`
- `Collapsible`
- `Tabs`
- `NavigationMenu`

`forceMount` will now render the component eventhough the state is inactive. You are now required to handle the visibility logic of the component manually.

```vue
<template>
  <TabsRoot
    v-slot="{ modelValue }"
    default-value="tab1"
  >
    <TabsContent
      value="tab1"
      force-mount
      :hidden="modelValue !== 'tab1'"
    >
      …
    </TabsContent>
    <TabsContent
      value="tab2"
      force-mount
      :hidden="modelValue !== 'tab2'"
    >
      …
    </TabsContent>
  </TabsRoot>
</template>
```

## For Nuxt module users

If you are using Nuxt, you need to update your module import.


 ```ts
 // nuxt.config.ts
export default defineNuxtConfig({
   modules: [
     'radix-vue/nuxt', // [!code --]
     'reka-ui/nuxt', // [!code ++]
   ],
})
 ```
