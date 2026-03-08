---
url: /docs/utilities/use-date-formatter.md
description: >-
  Creates a wrapper around the `DateFormatter`, which is an improved version of
  the Intl.DateTimeFormat API, that is used internally by the various date
  builders to easily format dates in a consistent way.
---

# useDateFormatter

More information on the DateFormatter here.

## Usage

```vue
<script setup lang="ts">
import type { DateValue } from '@internationalized/date'
import type { Ref } from 'vue'
import { CalendarDate, getLocalTimeZone } from '@internationalized/date'
import { toDate, useDateFormatter } from 'reka-ui'
import { ref } from 'vue'

const value = ref(new CalendarDate(1995, 8, 18)) as Ref<DateValue>
// provide the locale
const formatter = useDateFormatter('en')
</script>

<template>
  <span>
    
    {{ formatter.custom(value.toDate(getLocalTimeZone()), { month: 'short' }) }}
  </span>
</template>
```
