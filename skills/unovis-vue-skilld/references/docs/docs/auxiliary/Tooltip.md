---
title: "Tooltip | Unovis"
meta:
  "og:description": "Basic Configuration"
  "og:title": "Tooltip | Unovis"
  description: "Basic Configuration"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The _Tooltip_ component allows you to add informative text when hovering over a chart element. It can work within both XYContainer and SingleContainer, or as a standalone component.

Here is a minimal _Tooltip_ configuration alongside a _StackedBar_ chart:

Loading...

## Triggers [](#triggers "Direct link to Triggers")

The `triggers` property allows a _Tooltip_ component to display custom content for a given CSS selector.

It accepts an object of the following type:

```
typeof triggers = {  [selector: string]: (    datum: T,    i: number,    els: Element[]  ) => string | HTMLElement | null | void}
```

Where the key _selector_ is the CSS class, and the value is a callback function that returns the content.

#### Selectors [](#selectors "Direct link to Selectors")

For Unovis components, you can import selectors from `@unovis/ts` and use them as keys in the `triggers` object.

```
import { StackedBar } from '@unovis/ts'const triggers = {  [StackedBar.selectors.bar]: /* Your callback function*/}
```

#### Trigger function [](#trigger-function "Direct link to Trigger function")

The arguments of the callback can be used to customize the string content or custom HTML element:

- `datum`: the data point associated with the hovered element
- `i`: the datum's array index
- `els`: an array of all elements with the selector

tip

Returning `null` will hide the tooltip, while returning nothing or `undefined` will show the tooltip but won't render anything.

You can use this behavior to make _Tooltip_ work with Portals (e.g. `createPortal` in React), when you want to render your custom tooltip component into Unovis's _Tooltip_.

#### Example: Multiple Triggers [](#example-multiple-triggers "Direct link to Example: Multiple Triggers")

Consider a composite XY chart with a _StackedBar_, _Line_, and _Scatter_ components. You can define a different trigger function for individual component selectors.

```
import { Line, Scatter, StackedBar } from '@unovis/ts'const triggers = {  [StackedBar.selectors.bar]: d => \`${d.y1}<br/>${d.y2}<br/>${d.y3}\`,  [Scatter.selectors.point]: d => \`${(d.y1 + d.y2 + d.y3) / 3}\`,  [Line.selectors.line]: () => 'Average value'}
```

Loading...

## Position [](#position "Direct link to Position")

### Horizontal Placement [](#horizontal-placement "Direct link to Horizontal Placement")

Loading...

Loading...

### Vertical Placement [](#vertical-placement "Direct link to Vertical Placement")

Loading...

Loading...

### Horizontal Shift [](#horizontal-shift "Direct link to Horizontal Shift")

Shift the tooltip horizontally by setting the `horizontalShift` property. Works only with `horizontalPlacement` set to `Position.Left` or `Position.Right`.

Loading...

### Vertical Shift [](#vertical-shift "Direct link to Vertical Shift")

Shift the tooltip vertically by setting the `verticalShift` property. Works only with `verticalPlacement` set to `Position.Top` or `Position.Bottom`.

Loading...

## Follow Cursor [](#follow-cursor "Direct link to Follow Cursor")

By default, the _Tooltip_ will follow the cursor when hovering over the chart elements. If you want the tooltip to be anchored to the hovered element, you can set the `followCursor` property to `false`.

Loading...

## Hoverable Content [](#hoverable-content "Direct link to Hoverable Content")

_Tooltip_'s content will become hoverable when you set the `allowHover` property to `true`. This will keep the content in view when hovering over the tooltip itself. This can be useful for interacting with text, links, or other elements in the tooltip. If you want to disable this behavior, you can set the `allowHover` property to `false`.

Here is an example with a _Line_ chart a clickable link on hover:

Loading...

## Display Delays [](#display-delays "Direct link to Display Delays")

You can control when the tooltip appears and disappears by setting delay timers:

- `showDelay`: Adds a delay in milliseconds before the tooltip appears
- `hideDelay`: Adds a delay in milliseconds before the tooltip disappears

This is useful for preventing tooltip flicker when users quickly move their mouse across multiple elements, or to ensure the tooltip stays visible long enough to be read.

Loading...

## Manual Configuration [](#manual-configuration "Direct link to Manual Configuration")

### Container [](#container "Direct link to Container")

By default the _Tooltip_ will be added to the same DOM element where your chart is located. It will also be constrained to stay within the dimensions of that element. That's not always convenient (for example when you have a sparkline chart and you need the tooltip to be displayed above it) so there's a way to set the container element manually by using the `container` property. In the most cases you might want to set `container` to `document.body`.

Loading...

### Components [](#components "Direct link to Components")

Similarly, you can manually define the components a _Tooltip_ interacts with using the `components` property. By default they will be passed from your chart's container (like _XYContainer_), but if you want to use _Tooltip_ independently you can do that!

```
const tooltip = new Tooltip({  components: [components],  ...tooltipConfig,})
```

### Custom Class Name [](#custom-class-name "Direct link to Custom Class Name")

In rare cases you might want to add a custom class name to the _Tooltip_ component. You can do that by using the `className` property.

### Controls [](#controls "Direct link to Controls")

You can manually define the behavior of your _Tooltip_ with the following methods:

- `hide()`: hides the tooltip from view
- `render(content: string | HTMLElement | null | void)`: renders the value of `content` in the tooltip
- `place({x: number, y: number})`: anchors the tooltip to the coordinate `(x,y)`
- `placeByElement(element: SVGElement | HTMLElement)`: anchors the tooltip to the SVG or HTML element
- `show(content: HTMLElement | string, pos: {x: number, y: number})`: a shortcut to `render` and `place`. Shows the value of `content` at the coordinate `(x,y)`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
import { VisTooltip, VisTooltipRef } from '@unovis/react'function Tooltip() {  const [toggled, setToggled] = React.useState(false)  const tooltip = React.useRef<VisTooltipRef>(null)    function toggleTooltip() {    if (toggled) {        tooltip.hide()    } else {        tooltip.show("👋 I'm a tooltip", { x: 0, y: 0 })    }    setToggled(!toggled)  }  return (<>    <button onClick={toggleTooltip}>Toggle</button>    <VisTooltip ref={tooltip}/>  </>)}
```

```
@ElementRef('tooltip') tooltiptoggled = falsetoggleTooltip() {  if (toggled) {    tooltip.hide()  } else {    tooltip.show("👋 I'm a tooltip", { x: 0, y: 0 })  }  toggled = !toggled}
```

```
<vis-tooltip #tooltip></vis-tooltip><button (click)="toggleTooltip">Toggle</button>
```

```
<script lang='ts'>  import { VisTooltip } from '@unovis/svelte'  let toggled    function toggleTooltip() {    if (toggled) {        tooltip.hide()    } else {        tooltip.show("👋 I'm a tooltip", { x: 0, y: 0 })    }    toggled = !toggled  }</script><button onClick={toggleTooltip}>Toggle</button><VisTooltip bind:this={tooltip}/>
```

```

```

```

```

```
const tooltip = new Tooltip()let toggled = falsefunction toggleTooltip() {  if (toggled) {    tooltip.hide()  } else {    tooltip.show("👋 I'm a tooltip", { x: 0, y: 0 })  }  toggled = !toggled}document.getElementById("btn").addEventListener('click', toggleTooltip)
```

Loading...

## Attributes [](#attributes "Direct link to Attributes")

The `attributes` property allows you to set custom DOM attributes to _Tooltip_'s _div_ element. It can be useful when you need to refer to your tooltip by using a CSS selector.

Loading...

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Tooltip_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.visualization-container-div {  --vis-tooltip-background-color: '#3f3f3f';  --vis-tooltip-text-color: '#fefefe';}
```

Loading...

<details>

<summary>All supported CSS variables</summary>



```
--vis-tooltip-background-color: rgba(255, 255, 255, 0.95);--vis-tooltip-border-color: #e5e9f7;--vis-tooltip-text-color: #000;--vis-tooltip-shadow-color: rgba(172, 179, 184, 0.35);--vis-tooltip-backdrop-filter: none;--vis-tooltip-padding: 10px 15px; /* Dark Theme */--vis-dark-tooltip-background-color: rgba(30,30,30, 0.95);--vis-dark-tooltip-text-color: #e5e9f7;--vis-dark-tooltip-border-color: var(--vis-color-grey);--vis-dark-tooltip-shadow-color: rgba(0,0,0, 0.95);
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |