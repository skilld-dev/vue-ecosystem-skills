---
url: /docs/components/pagination.md
description: Displays data in paged format and provides navigation between pages.
---

# Pagination

## Features

## Installation

Install the component from your command line.

### Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { PaginationEllipsis, PaginationFirst, PaginationLast, PaginationList, PaginationListItem, PaginationNext, PaginationPrev, PaginationRoot } from 'reka-ui'
</script>

<template>
  <PaginationRoot>
    <PaginationList v-slot="{ items }">
      <PaginationFirst />
      <PaginationPrev />
      <template v-for="(page, index) in items">
        <PaginationListItem
          v-if="page.type === 'page'"
          :key="index"
        />
        <PaginationEllipsis
          v-else
          :key="page.type"
          :index="index"
        >
          &#8230;
        </PaginationEllipsis>
      </template>
      <PaginationNext />
      <PaginationLast />
    </PaginationList>
  </PaginationRoot>
</template>
```

## API Reference

### Root

Contains all of the paginations parts.

### List

Used to show the list of pages. It also makes pagination accessible to assistive technologies.

### Item

Used to render the button that changes the current page.

### Ellipsis

Placeholder element when the list is long, and only a small amount of `siblingCount` was set and `showEdges` was set to `true`.

### First

Triggers that set the page value to 1

### Prev

Triggers that set the page value to the previous page

### Next

Triggers that set the page value to the next page

### Last

Triggers that set the page value to the last page

## Examples

### With ellipsis

You can add `PaginationEllipsis` as a visual cue for more previous and after items.

```vue line=10,14
<script setup lang="ts">
import { PaginationEllipsis, PaginationList, PaginationListItem, PaginationRoot } from 'reka-ui'
</script>

<template>
  <PaginationRoot>
    <PaginationList v-slot="{ items }">
      <template v-for="(page, index) in items">
        <PaginationListItem
          v-if="page.type === 'page'"
          :key="index"
        />
        <PaginationEllipsis
          v-else
          :key="page.type"
          :index="index"
        >
          &#8230;
        </PaginationEllipsis>
      </template>
    </PaginationList>
  </PaginationRoot>
</template>
```

### With first/last button

You can add `PaginationFirst` to allow user to navigate to first page, or `PaginationLast` to navigate to last page.

```vue line=8,10
<script setup lang="ts">
import { PaginationFirst, PaginationLast, PaginationList, PaginationListItem, PaginationRoot } from 'reka-ui'
</script>

<template>
  <PaginationRoot>
    <PaginationList>
      <PaginationFirst />
      ...
      <PaginationLast />
    </PaginationList>
  </PaginationRoot>
</template>
```

### Control page programmatically

You can control the current page by passing it a reactive value.

```vue line=6,10,11
<script setup lang="ts">
import { PaginationRoot } from 'reka-ui'
import { ref } from 'vue'
import { Select } from './custom-select'

const currentPage = ref(1)
</script>

<template>
  <Select v-model="currentPage" />
  <PaginationRoot v-model:page="currentPage">
    ...
  </PaginationRoot>
</template>
```

## Keyboard Interactions
