---
url: /docs/utilities/use-direction.md
description: Access the current direction
---

# useDirection

## Usage

```ts
import { useDirection } from 'reka-ui'

// With ConfigProvider setup as follows
// <ConfigProvider dir="rtl">
const locale = useDirection() // rtl
```

```ts
import { useDirection } from 'reka-ui'

// With ConfigProvider setup as follows
// <ConfigProvider dir="rtl">
const locale = useDirection('ltr') // ltr
```
