---
number: 646
title: How do I unset schema.org `primaryImageOfPage` on my web page?
category: General
created: 2026-01-19
url: "https://github.com/unjs/unhead/discussions/646"
upvotes: 1
comments: 0
answered: false
---

# How do I unset schema.org `primaryImageOfPage` on my web page?

I have defined a schema.org organization for my website. When I define a web page (no matter if it is a homepage or not), it inherits the `logo` from the organization as `primaryImageOfPage`. I would like to avoid this, and instead have no primary image defined for the page. It seems like once this value is inherited, the only way to get rid of it is to define a different image. But there is no suitable image for this page, and the logo is not suitable either. Is there a way to unset the `primaryImageOfPage` of my web page? None of the `undefined`, `null`, `false`, `0`, or `''` have worked for me.

I am using VueJs and the latest `unhead` v2.1.2