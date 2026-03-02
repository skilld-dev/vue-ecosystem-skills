---
number: 578
title: Use DOM Parser for transformHtmlTemplate
type: bug
state: closed
created: 2025-09-11
url: "https://github.com/unjs/unhead/issues/578"
reactions: 1
comments: 2
labels: "[bug]"
---

# Use DOM Parser for transformHtmlTemplate

### Environment

v24.4.0


### Reproduction

see:
https://github.com/littleboarx/unhead/blob/bug/dom-attrs/packages/unhead/test/unit/server/extractUnheadInputFromHtml.test.ts

### Describe the bug

test output:
AssertionError: expected { 'data-vue': true, …(2) } to deeply equal { 'data-vue-ssr-id': '12345678' }

### Additional context

Suggest a solution: use DOM parser instead of regex parser

### Logs

```sh

```

---

## Top Comments

**@harlan-zw** [maintainer]:

Thanks for the test case! I've pushed up a fix for the regex, I'd like to use a DOM Parser but I want to avoid any dependencies for now. So will consider this for the next major, will keep open to track that.

**@harlan-zw** [maintainer]:

Okay I changed my mind  walker is now implemented