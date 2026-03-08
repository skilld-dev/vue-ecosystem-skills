---
url: /docs/utilities/use-locale.md
description: Access the current locale
---

# useLocale

## Usage

```ts
import { useLocale } from 'reka-ui'

// With ConfigProvider setup as follows
// <ConfigProvider locale="fr-FR">
const locale = useLocale() // fr-FR
```

```ts
import { useLocale } from 'reka-ui'

// With ConfigProvider setup as follows
// <ConfigProvider locale="fr-FR">
const locale = useLocale('en-US') // en-US
```
