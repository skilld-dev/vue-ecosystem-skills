---
url: /docs/components/navigation-menu.md
description: A collection of links for navigating websites.
---

# Navigation Menu

## Features

## Installation

Install the component from your command line.

## Anatomy

Import all parts and piece them together.

```vue
<script setup lang="ts">
import {
  NavigationMenuContent,
  NavigationMenuIndicator,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuRoot,
  NavigationMenuSub,
  NavigationMenuTrigger,
  NavigationMenuViewport,
} from 'reka-ui'
</script>

<template>
  <NavigationMenuRoot>
    <NavigationMenuList>
      <NavigationMenuItem>
        <NavigationMenuTrigger />
        <NavigationMenuContent>
          <NavigationMenuLink />
        </NavigationMenuContent>
      </NavigationMenuItem>

      <NavigationMenuItem>
        <NavigationMenuLink />
      </NavigationMenuItem>

      <NavigationMenuItem>
        <NavigationMenuTrigger />
        <NavigationMenuContent>
          <NavigationMenuSub>
            <NavigationMenuList />
            <NavigationMenuViewport />
          </NavigationMenuSub>
        </NavigationMenuContent>
      </NavigationMenuItem>

      <NavigationMenuIndicator />
    </NavigationMenuList>

    <NavigationMenuViewport />
  </NavigationMenuRoot>
</template>
```

## API Reference

### Root

Contains all the parts of a navigation menu.

### Sub

Signifies a submenu. Use it in place of the root part when nested to create a submenu.

### List

Contains the top level menu items.

### Item

A top level menu item, contains a link or trigger with content combination.

### Trigger

The button that toggles the content.

### Content

Contains the content associated with each trigger.

### Link

A navigational link.

### Indicator

An optional indicator element that renders below the list, is used to highlight the currently active trigger.

### Viewport

An optional viewport element that is used to render active content outside of the list.

## Examples

### Vertical

You can create a vertical menu by using the `orientation` prop.

```vue line=16
<script setup lang="ts">
import {
  NavigationMenuContent,
  NavigationMenuIndicator,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuRoot,
  NavigationMenuSub,
  NavigationMenuTrigger,
  NavigationMenuViewport,
} from 'reka-ui'
</script>

<template>
  <NavigationMenuRoot orientation="vertical">
    <NavigationMenuList>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item one</NavigationMenuTrigger>
        <NavigationMenuContent>Item one content</NavigationMenuContent>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item two</NavigationMenuTrigger>
        <NavigationMenuContent>Item Two content</NavigationMenuContent>
      </NavigationMenuItem>
    </NavigationMenuList>
  </NavigationMenuRoot>
</template>
```

### Flexible layouts

Use the `Viewport` part when you need extra control over where `Content` is rendered. This can be helpful when your design
requires an adjusted DOM structure or if you need flexibility to achieve [advanced animation](/docs/components/navigation-menu#advanced-animation).
Tab focus will be maintained automatically.

```vue line=26
<script setup lang="ts">
import {
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuList,
  NavigationMenuRoot,
  NavigationMenuTrigger,
  NavigationMenuViewport,
} from 'reka-ui'
</script>

<template>
  <NavigationMenuRoot>
    <NavigationMenuList>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item one</NavigationMenuTrigger>
        <NavigationMenuContent>Item one content</NavigationMenuContent>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item two</NavigationMenuTrigger>
        <NavigationMenuContent>Item two content</NavigationMenuContent>
      </NavigationMenuItem>
    </NavigationMenuList>

    
    <NavigationMenuViewport />
  </NavigationMenuRoot>
</template>
```

### With indicator

You can use the optional `Indicator` part to highlight the currently active `Trigger`, this is useful when you want to provide
an animated visual cue such as an arrow or highlight to accompany the `Viewport`.

```vue line=24
<script setup lang="ts">
import {
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuList,
  NavigationMenuRoot,
  NavigationMenuTrigger,
  NavigationMenuViewport,
} from 'reka-ui'
</script>

<template>
  <NavigationMenuRoot>
    <NavigationMenuList>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item one</NavigationMenuTrigger>
        <NavigationMenuContent>Item one content</NavigationMenuContent>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item two</NavigationMenuTrigger>
        <NavigationMenuContent>Item two content</NavigationMenuContent>
      </NavigationMenuItem>

      <NavigationMenuIndicator class="NavigationMenuIndicator" />
    </NavigationMenuList>

    <NavigationMenuViewport />
  </NavigationMenuRoot>
</template>
```

```css
/* styles.css */
.NavigationMenuIndicator {
  background-color: grey;
  position: absolute;
  transition: width, transform, 250ms ease;
}

.NavigationMenuIndicator[data-orientation="horizontal"] {
  left: 0;
  height: 3px;
  transform: translateX(var(--reka-navigation-menu-indicator-position));
  width: var(--reka-navigation-menu-indicator-size);
}
```

### With submenus

Create a submenu by nesting your `NavigationMenu` and using the `Sub` part in place of its `Root`.
Submenus work differently to `Root` navigation menus and are similar to [`Tabs`](/docs/components/tabs) in that one item should always be active, so be
sure to assign and set a `defaultValue`.

```vue line=7,23-34
<script setup lang="ts">
import {
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuList,
  NavigationMenuRoot,
  NavigationMenuSub,
  NavigationMenuTrigger,
  NavigationMenuViewport,
} from 'reka-ui'
</script>

<template>
  <NavigationMenuRoot>
    <NavigationMenuList>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item one</NavigationMenuTrigger>
        <NavigationMenuContent>Item one content</NavigationMenuContent>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item two</NavigationMenuTrigger>
        <NavigationMenuContent>
          <NavigationMenuSub default-value="sub1">
            <NavigationMenuList>
              <NavigationMenuItem value="sub1">
                <NavigationMenuTrigger>Sub item one</NavigationMenuTrigger>
                <NavigationMenuContent> Sub item one content </NavigationMenuContent>
              </NavigationMenuItem>
              <NavigationMenuItem value="sub2">
                <NavigationMenuTrigger>Sub item two</NavigationMenuTrigger>
                <NavigationMenuContent> Sub item two content </NavigationMenuContent>
              </NavigationMenuItem>
            </NavigationMenuList>
          </NavigationMenuSub>
        </NavigationMenuContent>
      </NavigationMenuItem>
    </NavigationMenuList>
  </NavigationMenuRoot>
</template>
```

### With client side routing

If you need to use the `RouterLink` component provided by your routing package then we recommend adding `asChild="true"` to `NavigationMenuLink`, or setting `as="RouterLink"`.
This will ensure accessibility and consistent keyboard control is maintained:

```vue line=12-14,19-21
<script setup lang="ts">
import { NavigationMenuItem, NavigationMenuList, NavigationMenuRoot } from 'reka-ui'

// RouterLink should be injected by default if using `vue-router`
</script>

<template>
  <NavigationMenuRoot>
    <NavigationMenuList>
      <NavigationMenuItem>
        <NavigationMenuLink as-child>
          <RouterLink to="/">
            Home
          </RouterLink>
          <NavigationMenuLink />
        </NavigationMenuLink>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <NavigationMenuLink
          :as="RouterLink"
          to="/about"
        >
          About
        </NavigationMenuLink>
      </NavigationMenuItem>
    </NavigationMenuList>
  </NavigationMenuRoot>
</template>
```

### Advanced animation

We expose `--reka-navigation-menu-viewport-[width|height]` and `data-motion['from-start'|'to-start'|'from-end'|'to-end']` attributes to allow you to animate `Viewport` size and `Content` position based on the enter/exit direction.

Combining these with `position: absolute;` allows you to create smooth overlapping animation effects when moving between items.

```vue line=17,23,29
<script setup lang="ts">
import {
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuList,
  NavigationMenuRoot,
  NavigationMenuTrigger,
  NavigationMenuViewport,
} from 'reka-ui'
</script>

<template>
  <NavigationMenuRoot>
    <NavigationMenuList>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item one</NavigationMenuTrigger>
        <NavigationMenuContent class="NavigationMenuContent">
          Item one content
        </NavigationMenuContent>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Item two</NavigationMenuTrigger>
        <NavigationMenuContent class="NavigationMenuContent">
          Item two content
        </NavigationMenuContent>
      </NavigationMenuItem>
    </NavigationMenuList>

    <NavigationMenuViewport class="NavigationMenuViewport" />
  </NavigationMenuRoot>
</template>
```

```css line=9-20,24,25
/* styles.css */
.NavigationMenuContent {
  position: absolute;
  top: 0;
  left: 0;
  animation-duration: 250ms;
  animation-timing-function: ease;
}
.NavigationMenuContent[data-motion="from-start"] {
  animation-name: enterFromLeft;
}
.NavigationMenuContent[data-motion="from-end"] {
  animation-name: enterFromRight;
}
.NavigationMenuContent[data-motion="to-start"] {
  animation-name: exitToLeft;
}
.NavigationMenuContent[data-motion="to-end"] {
  animation-name: exitToRight;
}

.NavigationMenuViewport {
  position: relative;
  width: var(--reka-navigation-menu-viewport-width);
  height: var(--reka-navigation-menu-viewport-height);
  transition: width, height, 250ms ease;
}

@keyframes enterFromRight {
  from {
    opacity: 0;
    transform: translateX(200px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes enterFromLeft {
  from {
    opacity: 0;
    transform: translateX(-200px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes exitToRight {
  from {
    opacity: 1;
    transform: translateX(0);
  }
  to {
    opacity: 0;
    transform: translateX(200px);
  }
}

@keyframes exitToLeft {
  from {
    opacity: 1;
    transform: translateX(0);
  }
  to {
    opacity: 0;
    transform: translateX(-200px);
  }
}
```

## Accessibility

Adheres to the `navigation` role requirements.

### Differences to menubar

`NavigationMenu` should not be confused with `menubar`, although this primitive shares the name `menu` in the colloquial sense to refer to a set of navigation links, it does not use the WAI-ARIA `menu` role.
This is because `menu` and `menubars` behave like native operating system menus most commonly found in desktop application windows, as such they feature complex functionality like composite focus management and first-character navigation.

These features are often considered unnecessary for website navigation and at worst can confuse users who are familiar with established website patterns.

See the W3C Disclosure Navigation Menu example for more information.

### Link usage and aria-current

It's important to use `NavigationMenuLink` for all navigational links within a menu, this not only applies to the main list
but also within any content rendered via `NavigationMenuContent`. This will ensure consistent keyboard interactions and accessibility
while also giving access to the `active` prop for setting `aria-current` and the active styles.
See [this example](/docs/components/navigation-menu#with-client-side-routing) for more information on usage with third party routing components.

### Keyboard Interactions
