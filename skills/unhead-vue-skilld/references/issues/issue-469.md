---
number: 469
title: "Reopen issue #433 Trailing slash on schema @id despite trailingSlash: false"
type: bug
state: closed
created: 2025-01-27
url: "https://github.com/unjs/unhead/issues/469"
reactions: 2
comments: 1
labels: "[bug]"
---

# Reopen issue #433 Trailing slash on schema @id despite trailingSlash: false

### Environment

unhead 1.11.13
ufo 1.5.4
Node v20.15.0

### Reproduction

Use parameter trailingSlash: false and function useSchemaOrg without custom node id.

### Describe the bug

I want to reopen issue #433

Also I found question with similar issue on google support
https://support.google.com/webmasters/thread/170261979/does-adding-a-trailing-slash-to-a-non-trailing-slash-url-in-newsarticle-schema-confuse-google?hl=en

### Additional context

_No response_

### Logs

```sh

```

---

## Top Comments

**@harlan-zw** [maintainer]:

Hi, thanks for opening this issue again. On checking the logic again, you are right in that it shouldn't be appending the `/` at the end; this was a side effect of the URL util library that's used internally.

I've updated the logic for Unhead v2.