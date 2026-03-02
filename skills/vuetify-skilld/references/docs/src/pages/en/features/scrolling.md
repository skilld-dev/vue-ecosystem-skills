---
meta:
  title: Programmatic scrolling
  description: Handle scrolling within your application by using the goTo function
  keywords: programmatic scrolling, vuetify goto, goto
related:
  - /directives/scroll/
  - /features/application-layout/
  - /components/slide-groups/
features:
  github: /composables/goto.ts
  label: 'E: goto'
  report: true
---

# Programmatic scrolling

Handle scrolling within your application by using the **goTo** function.

<PageFeatures />

<PromotedEntry />

## Usage

The **goTo** method takes two parameters **target** and **options**. **target** can be either a pixel offset from the top of the page, a valid css selector, or an element reference. **options** is an object that includes **duration**, **easing**, **container**, and **offset**.

<ExamplesExample file="scroll/usage" />

## API

| Directive | Description |
| - | - |
| [useGoTo](/api/use-go-to/) | The useGoTo composable |

<ApiInline hide-links />


