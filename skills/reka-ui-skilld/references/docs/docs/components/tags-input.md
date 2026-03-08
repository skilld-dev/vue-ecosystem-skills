---
url: /docs/components/tags-input.md
description: 'Tags input render tags inside an input, followed by an actual text input.'
---

# Tags Input

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { TagsInputClear, TagsInputInput, TagsInputItem, TagsInputItemDelete, TagsInputItemText, TagsInputRoot } from 'reka-ui'
</script>

<template>
  <TagsInputRoot>
    <TagsInputItem>
      <TagsInputItemText />
      <TagsInputItemDelete />
    </TagsInputItem>

    <TagsInputInput />
    <TagsInputClear />
  </TagsInputRoot>
</template>
```

## API Reference

### Root

Contains all the tags input component parts.

### Item

The component that contains the tag.

### ItemText

The textual part of the tag. Important for accessibility.

### ItemDelete

The button that delete the associate tag.

### Input

The input element for the tags input.

### Clear

The button that remove all tags.

## Examples

### Paste behavior

You can automatically add tags on paste by passing the `add-on-paste` prop.

```vue line=8
<script setup lang="ts">
import { TagsInputInput, TagsInputItem, TagsInputItemDelete, TagsInputItemText, TagsInputRoot } from 'reka-ui'
</script>

<template>
  <TagsInputRoot
    v-model="modelValue"
    add-on-paste
  >
    …
  </TagsInputRoot>
</template>
```

### Multiple delimiters

You can pass `RegExp` as `delimiter` to allow multiple characters to trigger addition of a new tag. When `add-on-paste` is passed it will be also used to split tags for `@paste` event.

```vue line=4-5,11
<script setup lang="ts">
import { TagsInputInput, TagsInputItem, TagsInputItemDelete, TagsInputItemText, TagsInputRoot } from 'reka-ui'

// split by space, comma, semicolon, tab, or newline
const delimiter = /[ ,;\t\n\r]+/
</script>

<template>
  <TagsInputRoot
    v-model="modelValue"
    :delimiter="delimiter"
    add-on-paste
  >
    …
  </TagsInputRoot>
</template>
```

## Accessibility

### Keyboard Interactions
