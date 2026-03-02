---
number: 572
title: React SSR performance
type: bug
state: closed
created: 2025-08-15
url: "https://github.com/unjs/unhead/issues/572"
reactions: 5
comments: 1
labels: "[bug]"
---

# React SSR performance

### Environment

nodes 22.18.0
react 19.1.1
unhead 2.0.14

### Reproduction

if you tell me the best way to generate useful performance reproduction I'll gladly do it

### Describe the bug

we have fairly old school webpack react app, did migration from react-helmet to unhead according to migration guide, deployed it on prod and detected substantial latency increase for our ssr rendering (p50 90 to 160 ms). I don't know how unhead differs from react-helmet in terms of collecting tags, but I guess culprit is something in transformHtmlTemplate 

<img width="688" height="214" alt="Image" src="https://github.com/user-attachments/assets/545fe25e-9f08-44b5-8e74-5a1b9ab4f872" />

### Additional context

_No response_

### Logs

```sh

```

---

## Top Comments

**@harlan-zw** [maintainer]:

Thank you for this important issue and visibility on the performance.

You were right to suspect `transformHtmlTemplate`, this was the culprit, and further details are in https://github.com/unjs/unhead/pull/581.

Can you please try v2.0.15 and let me know how the performance improves? For large HTML pages, it should be about 10x faster.

I've also introduced `transformHtmlTemplateRaw`, it has the same signature but skips any pre-processing of the HTML. This is useful if you know the HTML will be pure (i.e not include possible duplicates & not include tags that need to be in a specific spot). F...