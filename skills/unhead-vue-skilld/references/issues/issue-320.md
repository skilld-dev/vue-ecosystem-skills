---
number: 320
title: useScript 'idle' requestIdleCallback Safari
type: other
state: closed
created: 2024-02-27
url: "https://github.com/unjs/unhead/issues/320"
reactions: 4
comments: 0
---

# useScript 'idle' requestIdleCallback Safari

### Environment

<img width="396" alt="image" src="https://github.com/unjs/unhead/assets/18575175/bc36b740-8659-4268-b40f-835be92ce888">


### Reproduction
```js
const { $script } = useScript({
      src: 'https://path.to/script.js',
      async: true
    }, { trigger: 'idle' })
```

### Describe the bug

Unfortunately `requestIdleCallback` https://caniuse.com/requestidlecallback is not supported by Safari so far and we need to use `setTimeout` as a fallback.

https://github.com/unjs/unhead/blob/main/packages/unhead/src/composables/useScript.ts#L123

<img width="680" alt="image" src="https://github.com/unjs/unhead/assets/18575175/fb606aaa-9c8e-46d8-ba0b-ed15667dbd46">


### Additional context

_No response_

### Logs

_No response_