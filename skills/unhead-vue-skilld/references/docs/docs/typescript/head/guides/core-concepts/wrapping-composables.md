---
title: "Wrapping Composables · Unhead"
meta:
  "og:description": "Learn how to create custom head composables by wrapping useHead with your own defaults and context management."
  "og:title": "Wrapping Composables · Unhead"
  description: "Learn how to create custom head composables by wrapping useHead with your own defaults and context management."
---

**Core Concepts**

# **Wrapping Composables**

Copy for LLMs

**On this page **

- [Why wrap Unhead composables?](#why-wrap-unhead-composables)
- [How do I create a context for Unhead?](#how-do-i-create-a-context-for-unhead)
- [How do I wrap useHead with my context?](#how-do-i-wrap-usehead-with-my-context)

**Quick Answer:** Create custom composables by wrapping `useHead()` with your own defaults. Pass the `head` instance to reuse across your application.

## [Why wrap Unhead composables?](#why-wrap-unhead-composables)

When we create an Unhead instance, there is no context management built-in. What we mean by this, is we're not registering the instance to a global context, meaning you need to pass the instance.

This is by design, as Unhead is designed as frameworks handle this context management for you. However, if you're using Unhead in a non-framework environment, you may want to wrap the composables to manage the context.

The installation guide shows how to attach the head instance to the global window object:

```
import { useHead } from 'unhead'

// ❌ Not recommended
useHead(window.__UNHEAD__, {
  title: 'My Page',
})
```

However, this isn't ideal as we can no longer load multiple instances of our app on the same page and we need to manage the head instance ourselves.

## [How do I create a context for Unhead?](#how-do-i-create-a-context-for-unhead)

Each app or framework has its own way of managing context. If you're looking to create your own you should look at **unctx** for a simple context management solution

my-app-context.ts

```
import { createContext } from 'unctx'

const appCtx = createContext()

export const useMyApp = appCtx.use
```

main.ts

```
import { useMyApp } from './my-app-context'

// attach unhead to the app context
useMyApp().head = createHead()
```

## [How do I wrap useHead with my context?](#how-do-i-wrap-usehead-with-my-context)

Now that we have an app context, we can wrap the composables to use the context.

head.ts

```
import { useHead as baseUseHead } from 'unhead'
import { useMyApp } from './my-app-context'

export function useHead<T extends Unhead<any>>(unhead: T, input: Parameters<T['push']>[0], options?: HeadEntryOptions): ReturnType<T['push']> {
  const { head } = useMyApp()
  return baseUseHead(head, input)
}
```

```
import { useHead } from './head'

// ✅ Recommended
useHead({
  title: 'My Page',
})
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Upgrade Guide** Learn how to migrate between Unhead versions for TypeScript users. **Streaming** Stream head tags as async content resolves during server-side rendering

**On this page **

- [Why wrap Unhead composables?](#why-wrap-unhead-composables)
- [How do I create a context for Unhead?](#how-do-i-create-a-context-for-unhead)
- [How do I wrap useHead with my context?](#how-do-i-wrap-usehead-with-my-context)