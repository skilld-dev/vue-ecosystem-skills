---
number: 650
title: "TypeError: Cannot set properties of undefined (setting 'value')"
type: bug
state: open
created: 2026-01-29
url: "https://github.com/unjs/unhead/issues/650"
reactions: 0
comments: 0
labels: "[bug]"
---

# TypeError: Cannot set properties of undefined (setting 'value')

### Environment

```
node v24.13.0

"dependencies": {
    "@unhead/vue": "^2.1.2",
    "unhead": "^2.1.2",
    "vue": "^3.5.27"
  }
```

### Reproduction

```
<script setup>
import {useScript} from '@unhead/vue';

useScript({
  src: 'https://example.com/script.js',
}, {
  trigger: 'client'
});
</script>

<template>
  <h1>useScript bug reproduction</h1>
  <p>Check the browser console for: TypeError: Cannot set properties of undefined (setting 'value')</p>
</template>
```

### Describe the bug

trigger: "client" causes script.load() to fire synchronously during useScript initialization, which triggers the "script:updated" hook before _statusRef is assigned to the script object.

### Additional context

I'm far from understanding what's going on, but Claude insists it's a bug

### Logs

```sh

...