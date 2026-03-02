---
number: 394
title: Development Validation Plugin
type: feature
state: open
created: 2024-09-07
url: "https://github.com/unjs/unhead/issues/394"
reactions: 0
comments: 0
labels: "[enhancement, v2]"
---

# Development Validation Plugin

### Describe the feature

We should make a plugin that validates the final head output that the user provided and warn them about common issues. 

Some examples:
- using unknown meta tags (would catch incorrect usage of property / name for og tags)
- using unknown props (we allow them to fallthrough atm)
- non-absolute canonical
- non-absolute og images
- incorrectly formatted twitter handle https://github.com/unjs/unhead/issues/309
- https://github.com/unjs/unhead/issues/385

This would only run in development.

### Additional information

- [ ] Would you be willing to help implement this feature?