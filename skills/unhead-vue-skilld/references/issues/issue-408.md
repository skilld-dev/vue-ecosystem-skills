---
number: 408
title: incorrect title then use string in quotes and tileTemplate
type: bug
state: closed
created: 2024-10-17
url: "https://github.com/unjs/unhead/issues/408"
reactions: 2
comments: 1
labels: "[bug]"
---

# incorrect title then use string in quotes and tileTemplate

### Environment

npm: 10.8.2
    "@unhead/vue": "^1.11.10",
    "vue": "^3.5.11",


### Reproduction

used option API on page:

  head(){  
    return {
      title: 'Text in "Quotes"',
      titleTemplate: '%s - myApp',
    }
  },


### Describe the bug

browser (Chrome Version 129.0.6668.100  )  display page title
Text in \"Quotes\" - myApp
expected:
Text in "Quotes" - myApp


### Additional context

_No response_

### Logs

_No response_

---

## Top Comments

**@harlan-zw** [maintainer]:

Thanks for flagging this, have pushed up a fix that will be available soon.