---
url: /docs/utilities/presence.md
description: Manages mounting and unmounting of element with transition support.
---

# Presence

How is this component different from Vue Transition?

A: The biggest difference is it accepts css animation, and control the visibility of element.

Presence component provides enhanced control over element mounting/unmounting. It ensures animations and transitions complete before removing elements from the DOM, making it perfect for animated UI components.

## API Reference

Read our [Animation Guide](/docs/guides/animation) to learn more about implementing animations with Presence component.

## Example

```vue line=2,4,5
<template>
  <Presence :present="isVisible">
    <div
      :data-state="isVisible ? 'open' : 'closed'"
      class="data-[state=open]:animate-fadeIn data-[state=closed]:animate-fadeOut"
    >
      <slot />
    </div>
  </Presence>
</template>
```

### Force Mount

When you need to ensure content is always rendered regardless of the present state:

```vue
<template>
  <Presence v-slot="{ present }" :present="isVisible" :force-mount="true">
    <div>
      This content will always be rendered

      <div v-if="present">
        This content is hidden
      </div>
    </div>
  </Presence>
</template>
```
