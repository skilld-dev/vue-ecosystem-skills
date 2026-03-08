---
title: "Theming | Unovis"
meta:
  "og:description": "Create a data visualization theme for your project"
  "og:title": "Theming | Unovis"
  description: "Create a data visualization theme for your project"
---

## CSS Variables [](#css-variables "Direct link to CSS Variables")

### Overview [](#overview "Direct link to Overview")

In addition to configuration properties, our components also rely on CSS variables to supply the values of various SVG attributes such as `fill`, `stroke`, `opacity`, etc. You can override these variables to further customize your _Unovis_ components.

Every variable has the following naming convention: `--vis` + _label_ + _attribute_. For example, the variable named `--vis-area-cursor` would apply to the Area component's cursor property.

Note that while our variables follow this convention, it does not guarantee that the value you wish to override is available. Be sure to check the corresponding doc page of the component you want to customize to see the available CSS variables.

### Basic Example [](#basic-example "Direct link to Basic Example")

Variables can be overridden in your CSS style declarations. Consider the default configuration for sankey, which looks like this:

Loading...

Now consider the following style declaration. After adding `custom-sankey` to the container element of the _Sankey_ component, we will see the following result:

Loading...

Loading...

### Dark Theme Usage [](#dark-theme-usage "Direct link to Dark Theme Usage")

Our library offers dark theme support which takes effect when the class `theme-dark` is added to the document's `body` element. Every component has a dark version of each color variable labeled with the prefix `--vis-dark`. You can opt not to override these if you want to use our default dark theme values, or override them like so:

Loading...

## Global Variables [](#global-variables "Direct link to Global Variables")

The majority of our variables exist on a component level, but there are a few global CSS variables:

Loading...

note

Unless overridden explicitly, `--vis-color-main` corresponds to the first color in the default [color palette](#color-palette)

## Label Styling [](#label-styling "Direct link to Label Styling")

### Font [](#font "Direct link to Font")

The font for labels across all of our components is defined by the `--vis-font-family` variable. The default font, Inter, is not imported by default, but you can easily import it yourself from Google Fonts.

To use a different font, simply redefine the `--vis-font-family` CSS variable:

Loading...

Loading...

### Large Sizing [](#large-sizing "Direct link to Large Sizing")

A common theming scenario is the "large size" theme, for when you want larger font sizes for the labels in your charts. We offer two variations in the form of css classes that you can import directly from `@unovis/ts`:

```
import { styleLargeSize } from '@unovis/ts' // ~1.3x largerimport { styleExtraLargeSize } from '@unovis/ts' // 2x larger
```

Just add either one to your container's class list to the effects. Consider the following example of a labeled _Scatter_ chart:

#### `className: styleLargeSize`[](#classname-stylelargesize "Direct link to classname-stylelargesize")

#### `className: styleExtraLargeSize`[](#classname-styleextralargesize "Direct link to classname-styleextralargesize")

note

When using this theme, the following components have caveats:

- **Scatter**: If the `labelPosition` property is set to `Position.Center`, point labels will try fit to the point's size. In this case, you will instead need to update the `pointSize` property to render larger labels.
- **Timeline** Additionally, you may need to adjust the `rowHeight` property to accommodate larger labels.

## Color Palette [](#color-palette "Direct link to Color Palette")

Many of our components use the default color palette for visualizations. You can import the array of hex values directly from `unovis/ts`:

```
import { colors, colorsDark } from '@unovis/ts'
```

The dark theme palette is slightly different from the regular one. These colors are also defined directly in our CSS variables, labeled `--vis-color0`, `--vis-dark-color0`, `--vis-color1`, `--vis-dark-color1`, etc. The full palette looks like this:

#### Light [](#light "Direct link to Light")

Loading...

#### Dark [](#dark "Direct link to Dark")

Loading...

#### Palette Editor [](#palette-editor "Direct link to Palette Editor")

You can tweak and preview your desired palette using the example _StackedBar_ component below. If you like the result, just copy and paste the corresponding style declaration in the dropdown below.

tip

Alternatively, you can provide a custom color palette in _global scope_ using the `UNOVIS_COLORS` variable:

```
window.UNOVIS_COLORS = [...]// orglobalThis.UNOVIS_COLORS = [...]
```

This needs to be done before the library is imported, i.e. in your top level JS file or HTML.

## Applying Patterns [](#applying-patterns "Direct link to Applying Patterns")

When `document.body` has the class `theme-patterns` we automatically apply patterns of two types:

### Fill Patterns [](#fill-patterns "Direct link to Fill Patterns")

For solid shapes (most cases). You can customize fill patterns by assigning the corresponding CSS to a SVG `mask` reference.

The fill pattern palette looks like:

Loading...

<details>

<summary>Default CSS Variables:</summary>



```
--vis-pattern-fill0: var(--vis-pattern-fill-stripes-diagonal);--vis-pattern-fill1: var(--vis-pattern-fill-dots);--vis-pattern-fill2: var(--vis-pattern-fill-stripes-vertical);--vis-pattern-fill3: var(--vis-pattern-fill-crosshatch);--vis-pattern-fill4: var(--vis-pattern-fill-waves);--vis-pattern-fill5: var(--vis-pattern-fill-circles);
```

</details>

### Line Patterns [](#line-patterns "Direct link to Line Patterns")

For the _Line_ component and when _BulletLegend_'s `bulletShape` property is set to `"line"`. You can customize these patterns by assigning any combination of the following variable types:

- Prefixed `--vis-pattern-marker`: accepts SVG defs containings `marker` elements
- Variables with the prefix `--vis-pattern-dasharray` to a valid value for the stroke-dasharray property. The default palette looks like:

Loading...

<details>

<summary>Default CSS Variables:</summary>



```
--vis-pattern-marker0: var(--vis-pattern-marker-circle);--vis-pattern-marker1: var(--vis-pattern-marker-triangle);--vis-pattern-dasharray1: 9 1;--vis-pattern-marker2: var(--vis-pattern-marker-diamond);--vis-pattern-dasharray2: 2;--vis-pattern-marker3: var(--vis-pattern-marker-arrow);--vis-pattern-dasharray3: 2 3 8 3;--vis-pattern-marker4: var(--vis-pattern-marker-square);--vis-pattern-dasharray4: 6;--vis-pattern-marker5: var(--vis-pattern-marker-star);--vis-pattern-dasharray5: 1 6;
```

</details>

### Summary [](#summary "Direct link to Summary")

To override default patterns use the following table for reference.

| CSS Variable Prefix | Type | Accepted Value | Example |
| --- | --- | --- | --- |
| `--vis-pattern-fill` | Fill | SVG `mask` from a `<defs>` element | `url(#my-pattern-fill)` |
| `--vis-pattern-marker` | Line | SVG `marker` from a `<defs>` element | `url(#my-line-marker)` |
| `--vis-pattern-dasharray` | Line | CSS stroke-dasharray property | `5 10` |

## Bordered Segments [](#bordered-segments "Direct link to Bordered Segments")

For charts with multiple data layers, it might be preferable to have a visual separation of elements. You can do this by manipulating the `stroke` and `stroke-width` variables to create a bordered segment effect.

For the following components, the `stroke` property by default is either `none` or the same color as its fill. You can tweak the variables accordingly to create the desired effect:

```
:root  {  --stroke: #fff;  --stroke-dark: #292b34;  /* Area */  --vis-area-stroke-width: 1px;  --vis-area-stroke: var(--stroke);  --vis-dark-area-stroke: var(--stroke-dark);  /* Donut */  --vis-donut-segment-stroke-width: 1px;  /* StackedBar */  --vis-stacked-bar-stroke-width: 1px;  --vis-stacked-bar-stroke: var(--stroke);  --vis-dark-stacked-bar-stroke: var(--stroke-dark);  /* Timeline */  --vis-timeline-line-stroke-width: 1px;}
```

#### Area

Loading...

#### Donut

Loading...

#### Stacked Bar

Loading...

#### Timeline

Loading...