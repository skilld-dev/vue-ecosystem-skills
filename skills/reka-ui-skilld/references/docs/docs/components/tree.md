---
url: /docs/components/tree.md
description: >-
  A tree view widget displays a hierarchical list of items that can be expanded
  or collapsed to show or hide their child items, such as in a file system
  navigator.
---

# Tree

Alpha

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup>
import { TreeItem, TreeRoot, TreeVirtualizer } from 'reka-ui'
</script>

<template>
  <TreeRoot>
    <TreeItem />

    
    <TreeVirtualizer>
      <TreeItem />
    </TreeVirtualizer>
  </TreeRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a tree.

### Item

The item component.

### Virtualizer

Virtual container to achieve list virtualization.

## Examples

### Selecting multiple items

The `Tree` component allows you to select multiple items. You can enable this by providing an array of values instead of a single value and set `multiple="true"`.

```vue line=12,17-18
<script setup lang="ts">
import { TreeRoot } from 'reka-ui'
import { ref } from 'vue'

const people = [
  { id: 1, name: 'Durward Reynolds' },
  { id: 2, name: 'Kenton Towne' },
  { id: 3, name: 'Therese Wunsch' },
  { id: 4, name: 'Benedict Kessler' },
  { id: 5, name: 'Katelyn Rohan' },
]
const selectedPeople = ref([people[0], people[1]])
</script>

<template>
  <TreeRoot
    v-model="selectedPeople"
    multiple
  >
    ...
  </TreeRoot>
</template>
```

### Virtual List

Rendering a long list of item can slow down the app, thus using virtualization would significantly improve the performance.

See the [virtualization guide](../guides/virtualization.md) for more general info on virtualization.

```vue line=8-15
<script setup lang="ts">
import { TreeItem, TreeRoot, TreeVirtualizer } from 'reka-ui'
import { ref } from 'vue'
</script>

<template>
  <TreeRoot :items>
    <TreeVirtualizer
      v-slot="{ item }"
      :text-content="(opt) => opt.name"
    >
      <TreeItem v-bind="item.bind">
        {{ person.name }}
      </TreeItem>
    </TreeVirtualizer>
  </TreeRoot>
</template>
```

### With Checkbox

Some `Tree` component might want to show `toggled/indeterminate` checkbox. We can change the behavior of the `Tree` component by using a few props and `preventDefault` event.

We set `propagateSelect` to `true` because we want the parent checkbox to select/deselect it's descendants. Then, we add a checkbox that triggers `select` event.

```vue line=10-11,17-25,27-30
<script setup lang="ts">
import { TreeItem, TreeRoot } from 'reka-ui'
import { ref } from 'vue'
</script>

<template>
  <TreeRoot
    v-slot="{ flattenItems }"
    :items
    multiple
    propagate-select
  >
    <TreeItem
      v-for="item in flattenItems"
      :key="item._id"
      v-bind="item.bind"
      v-slot="{ handleSelect, isSelected, isIndeterminate }"
      @select="(event) => {
        if (event.detail.originalEvent.type === 'click')
          event.preventDefault()
      }"
      @toggle="(event) => {
        if (event.detail.originalEvent.type === 'keydown')
          event.preventDefault()
      }"
    >
      <Icon
        v-if="item.hasChildren"
        icon="radix-icons:chevron-down"
      />

      <button
        tabindex="-1"
        @click.stop
        @change="handleSelect"
      >
        <Icon
          v-if="isSelected"
          icon="radix-icons:check"
        />
        <Icon
          v-else-if="isIndeterminate"
          icon="radix-icons:dash"
        />
        <Icon
          v-else
          icon="radix-icons:box"
        />
      </button>

      <div class="pl-2">
        {{ item.value.title }}
      </div>
    </TreeItem>
  </TreeRoot>
</template>
```

### Nested Tree Node

The default example shows flatten tree items and nodes, this enables [Virtualization](/docs/components/tree.html#virtual-list) and custom feature such as Drag & Drop easier. However, you can also build it to have nested DOM node.

In `Tree.vue`,

```vue
<script setup lang="ts">
import { TreeItem } from 'reka-ui'

interface TreeNode {
  title: string
  icon: string
  children?: TreeNode[]
}

withDefaults(defineProps<{
  treeItems: TreeNode[]
  level?: number
}>(), { level: 0 })
</script>

<template>
  <li
    v-for=" tree in treeItems"
    :key="tree.title"
  >
    <TreeItem
      v-slot="{ isExpanded }"
      as-child
      :level="level"
      :value="tree"
    >
      <button>…</button>

      <ul v-if="isExpanded && tree.children">
        <Tree
          :tree-items="tree.children"
          :level="level + 1"
        />
      </ul>
    </TreeItem>
  </li>
</template>
```

In `CustomTree.vue`

```vue
<template>
  <TreeRoot
    :items="items"
    :get-key="(item) => item.title"
  >
    <Tree :tree-items="items" />
  </TreeRoot>
</template>
```

### Custom children schema

By default, `<TreeRoot />` expects you to provide the list of node's children by passing a list of `children` for every node. You can override that by providing the `getChildren` prop.

If the node doesn't have any children, `getChildren` should return `undefined` instead of an empty array.

```vue line=22
<script setup lang="ts">
import { TreeRoot } from 'reka-ui'
import { ref } from 'vue'

interface FileNode {
  title: string
  icon: string
}

interface DirectoryNode {
  title: string
  icon: string
  directories?: DirectoryNode[]
  files?: FileNode[]
}
</script>

<template>
  <TreeRoot
    :items="items"
    :get-key="(item) => item.title"
    :get-children="(item) => (!item.files) ? item.directories : (!item.directories) ? item.files : [...item.directories, ...item.files]"
  >
    ...
  </TreeRoot>
</template>
```

### Draggable/Sortable Tree

For more complex draggable `Tree` component, in this example we will be using pragmatic-drag-and-drop, as the core package for handling dnd.

Stackblitz Demo

## Accessibility

Adheres to the Tree WAI-ARIA design pattern.

### Keyboard Interactions
