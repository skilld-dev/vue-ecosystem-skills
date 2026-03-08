---
url: /docs/utilities/use-id.md
description: Generate random id
---

# useId

Vue 3.5 released an official client-server stable solution for `useId`.

## Usage

```ts
import { useId } from 'reka-ui'

const buttonId = useId() // reka-1
```

```ts
import { useId } from 'reka-ui'

const buttonId = useId('test-id') // test-id
```
