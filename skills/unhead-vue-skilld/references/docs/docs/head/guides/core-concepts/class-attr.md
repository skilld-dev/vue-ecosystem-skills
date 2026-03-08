---
title: "Class & Style Attributes · Unhead"
meta:
  "og:description": "Add classes and styles to html and body tags with htmlAttrs and bodyAttrs. Support for strings, arrays, objects, and reactive values."
  "og:title": "Class & Style Attributes · Unhead"
  description: "Add classes and styles to html and body tags with htmlAttrs and bodyAttrs. Support for strings, arrays, objects, and reactive values."
---

**Core Concepts**

# **Class & Style Attributes**

Copy for LLMs

**On this page **

- [How Do I Add Static Classes and Styles?](#how-do-i-add-static-classes-and-styles)
- [How Do I Add Dynamic Classes and Styles?](#how-do-i-add-dynamic-classes-and-styles)
- [Key Takeaways](#key-takeaways)
- [See Also](#see-also)

**Quick Answer:** Use `htmlAttrs` and `bodyAttrs` to set attributes on `<html>` and `<body>`. Classes can be strings, arrays, or objects. Example: `htmlAttrs: { class: 'dark-mode', lang: 'en' }`

When you need to style your page by adding classes or styles to the `<html>` or `<body>` tags, Unhead makes it easy by providing object and array support for the `class` and `style` attributes. This allows for both static and reactive styling.

## [How Do I Add Static Classes and Styles?](#how-do-i-add-static-classes-and-styles)

If your classes or styles aren't going to change, you can provide them as a string.

```
import { useHead } from 'unhead'

// useHead: /docs/head/api/composables/use-head
useHead(unheadInstance, {
  htmlAttrs: {
    class: 'my-class my-other-class',
    style: 'background-color: red; color: white;'
  }
})
```

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  bodyAttrs: {
    class: 'my-class my-other-class',
    style: 'background-color: red; color: white;'
  }
})
```

If you're server-side rendering static tags, you can make use of **Client-Only Tags**.

### [Can I Use Arrays for Classes and Styles?](#can-i-use-arrays-for-classes-and-styles)

Using manual separators for classes and styles can be a bit cumbersome, so Unhead allows you to use arrays for both.

```
import { useHead } from 'unhead'

useHead(unheadInstance, {
  htmlAttrs: {
    class: [
      'my-class',
      'my-other-class'
    ],
    style: [
      'background-color: red',
      'color: white'
    ],
  }
})
```

## [How Do I Add Dynamic Classes and Styles?](#how-do-i-add-dynamic-classes-and-styles)

For improved reactivity and merging support, you can provide the class as an object or an array.

### [How Do I Toggle Classes Conditionally?](#how-do-i-toggle-classes-conditionally)

When providing class as an object, the key should be the class name and the value determines whether the class should be added or not.

```
import { useHead } from 'unhead'

const colorMode = useColorMode()

useHead(unheadInstance, {
  htmlAttrs: {
    class: {
      // will be rendered when darkMode is true
      dark: () => colorMode.value === 'dark',
      // will be rendered when darkMode is false
      light: () => !colorMode.value === 'dark'
    }
  }
})
```

### [How Do I Apply Reactive Styles?](#how-do-i-apply-reactive-styles)

Similarly, styles can be defined reactively using an object:

```
import { useHead } from 'unhead'

const colorMode = useColorMode()

useHead(unheadInstance, {
  bodyAttrs: {
    style: {
      // conditional style that only applies when darkMode is true
      'background-color': () => colorMode.value === 'dark' ? 'rgba(0, 0, 0, 0.9)' : false,
      // reactive style that always applies with current value
      'font-size': () => fontSize.value,
    }
  }
})
```

## [Key Takeaways](#key-takeaways)

- Use `htmlAttrs` and `bodyAttrs` to set attributes on `<html>` and `<body>`
- Classes can be strings, arrays, or objects (like Vue's class binding)
- Styles can be strings or objects for type-safe CSS properties
- Use data attributes for JavaScript hooks and CSS selectors

## [See Also](#see-also)

- **useHead() API** - Full API reference
- **Bundle Optimizations** - Client-only attributes

Edit this page

Markdown For LLMs

**Did this page help you? **

**Tag Sorting & Placement** Control where head tags render with tagPosition (head, bodyOpen, bodyClose) and tagPriority for ordering. Optimize performance with Capo.js weights. **Inline Style & Scripts** Add inline scripts and styles with textContent and innerHTML. Security best practices for XSS prevention and performance optimization.

**On this page **

- [How Do I Add Static Classes and Styles?](#how-do-i-add-static-classes-and-styles)
- [How Do I Add Dynamic Classes and Styles?](#how-do-i-add-dynamic-classes-and-styles)
- [Key Takeaways](#key-takeaways)
- [See Also](#see-also)