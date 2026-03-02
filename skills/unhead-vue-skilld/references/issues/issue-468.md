---
number: 468
title: "Feat: parse metadata for the html"
type: docs
state: open
created: 2025-01-26
url: "https://github.com/unjs/unhead/issues/468"
reactions: 0
comments: 0
labels: "[documentation, enhancement]"
---

# Feat: parse metadata for the html

### Describe the feature

Currently, we can set the `title`/`description` fields for HTML, so is it possible to parse and return the current `title`/`description` and other fields?

For example：

#### set
```
useSeoMeta({
  title: 'Page',
  description: 'test'
})
```

#### get
```
const metadata = useSeoMeta()

console.log(metadata)
// {
//   title: 'Page',
//   description: 'test'
// }
```




### Additional information

- [ ] Would you be willing to help implement this feature?