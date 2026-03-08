---
title: "entries:updated Hook · Unhead"
meta:
  "og:description": "Hook triggered when head entries change. Track title updates, log changes, and react to modifications in your head configuration."
  "og:title": "entries:updated Hook · Unhead"
  description: "Hook triggered when head entries change. Track title updates, log changes, and react to modifications in your head configuration."
---

**Hooks**

# **entries:updated Hook**

Copy for LLMs

**On this page **

- [Lifecycle Position](#lifecycle-position)
- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)

The `entries:updated` hook is called whenever the collection of head entries is modified, either by adding new entries, updating existing ones, or removing entries. This hook provides a way to react to changes in the application's head content.

## [Lifecycle Position](#lifecycle-position)

This is the first hook in the entry processing chain. It runs before `entries:resolve`.

## [Hook Signature](#hook-signature)

```
export interface Hook {
  'entries:updated': (ctx: Unhead<any>) => HookResult
}
```

### [Parameters](#parameters)

| **Name** | **Type** | **Description** |
| --- | --- | --- |
| `ctx` | `Unhead<any>` | The Unhead instance containing the updated entries |

### [Returns](#returns)

`HookResult` which is either `void` or `Promise<void>`

## [Usage Example](#usage-example)

```
import { createHead } from 'unhead'

const head = createHead({
  hooks: {
    'entries:updated': (head) => {
      // Log when entries are updated
      console.log('Head entries have been updated!')
      console.log(\`Current entry count: ${head.entries.size}\`)
    }
  }
})
```

## [Use Cases](#use-cases)

### [Tracking Head Changes](#tracking-head-changes)

You can use this hook to track and log changes to head entries throughout your application lifecycle:

```
import { defineHeadPlugin } from 'unhead'

export const headChangeTrackingPlugin = defineHeadPlugin({
  hooks: {
    'entries:updated': (head) => {
      // Get current timestamp
      const timestamp = new Date().toISOString()

      // Log the updated state
      console.log(\`[${timestamp}] Head entries updated:\`, [...head.entries.values()].map(entry => ({
        id: entry._i,
        input: entry.input
      })))
    }
  }
})
```

### [Triggering Side Effects](#triggering-side-effects)

The hook can be used to trigger side effects when head entries change:

```
import { defineHeadPlugin } from 'unhead'

export const headChangeReactionPlugin = defineHeadPlugin({
  hooks: {
    'entries:updated': (head) => {
      // Check if title has changed
      const titleEntry = [...head.entries.values()].find(entry =>
        entry.input && typeof entry.input === 'object' && 'title' in entry.input
      )

      if (titleEntry) {
        // Perform side effect when title changes
        notifyTitleChange(titleEntry.input.title)
      }
    }
  }
})

function notifyTitleChange(title) {
  // Custom notification logic
  console.log(\`Title changed to: ${title}\`)
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**useScript()** Load third-party scripts with useScript(). Smart defaults for performance, lazy loading triggers, and API proxying for analytics and widgets. **entries:resolve** Hook for processing head entries before tag conversion. Add global meta tags, extract analytics data, and modify tag collections.

**On this page **

- [Lifecycle Position](#lifecycle-position)
- [Hook Signature](#hook-signature)
- [Usage Example](#usage-example)
- [Use Cases](#use-cases)