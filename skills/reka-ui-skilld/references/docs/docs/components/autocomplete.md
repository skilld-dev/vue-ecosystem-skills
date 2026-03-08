---
url: /docs/components/autocomplete.md
description: >-
  An input with suggestions that allows free-form text entry. Unlike Combobox,
  the value is the input text itself rather than a selected item.
---

# Autocomplete

Alpha

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup lang="ts">
import {
  AutocompleteAnchor,
  AutocompleteArrow,
  AutocompleteCancel,
  AutocompleteContent,
  AutocompleteEmpty,
  AutocompleteGroup,
  AutocompleteInput,
  AutocompleteItem,
  AutocompleteLabel,
  AutocompletePortal,
  AutocompleteRoot,
  AutocompleteSeparator,
  AutocompleteTrigger,
  AutocompleteViewport,
} from 'reka-ui'
</script>

<template>
  <AutocompleteRoot>
    <AutocompleteAnchor>
      <AutocompleteInput />
      <AutocompleteTrigger />
      <AutocompleteCancel />
    </AutocompleteAnchor>

    <AutocompletePortal>
      <AutocompleteContent>
        <AutocompleteViewport>
          <AutocompleteEmpty />

          <AutocompleteItem />

          <AutocompleteSeparator />

          <AutocompleteGroup>
            <AutocompleteLabel />
            <AutocompleteItem />
          </AutocompleteGroup>
        </AutocompleteViewport>

        <AutocompleteArrow />
      </AutocompleteContent>
    </AutocompletePortal>
  </AutocompleteRoot>
</template>
```

## Autocomplete vs. Combobox

The Autocomplete component is similar to the [Combobox](/docs/components/combobox) but with a key difference:

| | Autocomplete | Combobox |
| --- | --- | --- |
| **`modelValue`** | The input text (`string`) | The selected item (`AcceptableValue`) |
| **Free-form text** | Yes — any text is valid | No — must select from the list |
| **`multiple`** | Not supported | Supported |
| **Input on blur** | Retains typed text by default | Resets to selected value by default |
| **Item selection** | Fills the input with the item's text value | Sets `modelValue` to the item's value |

Use **Autocomplete** when the user should be able to type anything with optional suggestions. Use **Combobox** when the user must pick from a predefined set of options.

## API Reference

### Root

Contains all the parts of an Autocomplete.

### Anchor

Used as an anchor if you set `AutocompleteContent`'s position to `popper`.

### Input

The input component to search through the autocomplete items. Typing updates the `modelValue` directly.

### Trigger

The button that toggles the Autocomplete Content.

### Cancel

The button that clears the input text and resets the value.

### Empty

Shown when none of the items match the query.

### Portal

When used, portals the content part into the `body`.

You need to set `position="popper"` for `AutocompleteContent` to make sure the position was automatically computed similar to `Popover` or `DropdownMenu`.

### Content

The component that pops out when the autocomplete is open.

### Viewport

The scrolling viewport that contains all of the items.

### Item

The component that contains the autocomplete items. When selected, the item's string value fills the input.

### Group

Used to group multiple items. Use in conjunction with `AutocompleteLabel` to ensure good accessibility via automatic labelling.

### Label

Used to render the label of a group. It won't be focusable using arrow keys.

### Separator

Used to visually separate items in the Autocomplete.

### Arrow

An optional arrow element to render alongside the content. This can be used to help visually link the trigger with the `AutocompleteContent`. Must be rendered inside `AutocompleteContent`. Only available when `position` is set to `popper`.

### Virtualizer

Virtual container to achieve list virtualization.

See the [virtualization guide](../guides/virtualization.md) for more general info on virtualization.

## Examples

### Basic usage

The `modelValue` is a string that reflects whatever the user types. Selecting an item fills the input with that item's text.

```vue
<script setup lang="ts">
import { AutocompleteContent, AutocompleteInput, AutocompleteItem, AutocompletePortal, AutocompleteRoot } from 'reka-ui'
import { ref } from 'vue'

const searchText = ref('')
const fruits = ['Apple', 'Banana', 'Orange', 'Grapes', 'Pineapple']
</script>

<template>
  <AutocompleteRoot v-model="searchText">
    <AutocompleteInput placeholder="Type a fruit..." />
    <AutocompletePortal>
      <AutocompleteContent>
        <AutocompleteItem
          v-for="fruit in fruits"
          :key="fruit"
          :value="fruit"
        >
          {{ fruit }}
        </AutocompleteItem>
      </AutocompleteContent>
    </AutocompletePortal>
  </AutocompleteRoot>
</template>
```

### Hide menu when empty

Use the `hideWhenEmpty` prop on `AutocompleteContent` to hide the menu when no items match the filter.

```vue
<template>
  <AutocompleteRoot v-model="searchText">
    <AutocompleteInput placeholder="Type a fruit..." />
    <AutocompletePortal>
      <AutocompleteContent hide-when-empty>
        <AutocompleteItem
          v-for="fruit in fruits"
          :key="fruit"
          :value="fruit"
        >
          {{ fruit }}
        </AutocompleteItem>
      </AutocompleteContent>
    </AutocompletePortal>
  </AutocompleteRoot>
</template>
```

### With form submission

The Autocomplete value is submitted as a regular text field in forms.

```vue
<script setup lang="ts">
import { AutocompleteContent, AutocompleteInput, AutocompleteItem, AutocompletePortal, AutocompleteRoot } from 'reka-ui'
import { ref } from 'vue'

const query = ref('')
const cities = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix']
</script>

<template>
  <form>
    <AutocompleteRoot v-model="query" name="city">
      <AutocompleteInput placeholder="Enter a city..." />
      <AutocompletePortal>
        <AutocompleteContent>
          <AutocompleteItem
            v-for="city in cities"
            :key="city"
            :value="city"
          >
            {{ city }}
          </AutocompleteItem>
        </AutocompleteContent>
      </AutocompletePortal>
    </AutocompleteRoot>
  </form>
</template>
```

## Accessibility

Adheres to the Combobox WAI-ARIA design pattern.

### Keyboard Interactions
