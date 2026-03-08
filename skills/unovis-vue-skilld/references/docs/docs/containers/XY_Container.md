---
title: "XY Container | Unovis"
meta:
  "og:description": "Learn how to use XY Container"
  "og:title": "XY Container | Unovis"
  description: "Learn how to use XY Container"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

_XY Container_ is designed as a container that manages multiple _XY Components_ at once, along with optional X and Y axes, tooltip, and crosshair. Here is an example of a common configuration: one _XY Component_ alongside two _Axis_ components:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer data={data}>  <VisStackedBar x={x} y={y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

template.html

```
<vis-xy-container [data]="data">  <vis-stacked-bar [x]="x" [y]="y"></vis-stacked-bar>  <vis-axis type="x"></vis-axis>  <vis-axis type="y"></vis-axis></vis-xy-container>
```

component.svelte

```
<VisXYContainer {data}>  <VisStackedBar {x} {y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

component.vue

```
<VisXYContainer :data="data">  <VisStackedBar :x="x" :y="y" />  <VisAxis type="x" />  <VisAxis type="y" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer data={data}>  <VisStackedBar x={x} y={y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  components: [new StackedBar({ x, y })],   xAxis: new Axis({ type: "x" }),   yAxis: new Axis({ type: "y" })}, data)
```

Loading...

## Multiple XY Components [](#multiple-xy-components "Direct link to Multiple XY Components")

By providing the container with data, every _XY Component_ within the container will be able to use it. There is no limit to the number of _XY Components_ your container can have.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer data={data}>  <VisStackedBar x={x} y={y} barWidth={5} color="#E2203A"/>  <VisLine x={x} y={y}/>  <VisScatter x={x} y={y} shape={shape}/></VisXYContainer>
```

template.html

```
<vis-xy-container [data]="data">  <vis-stacked-bar  [x]="x"   [y]="y"   [barWidth]="5"   color="#E2203A"></vis-stacked-bar>  <vis-line [x]="x" [y]="y"></vis-line>  <vis-scatter [x]="x" [y]="y" [shape]="shape"></vis-scatter></vis-xy-container>
```

component.svelte

```
<VisXYContainer {data}>  <VisStackedBar {x} {y} barWidth={5} color="#E2203A"/>  <VisLine {x} {y}/>  <VisScatter {x} {y} {shape}/></VisXYContainer>
```

component.vue

```
<VisXYContainer :data="data">  <VisStackedBar :x="x" :y="y" :barWidth="5" color="#E2203A" />  <VisLine :x="x" :y="y" />  <VisScatter :x="x" :y="y" :shape="shape" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer data={data}>  <VisStackedBar x={x} y={y} barWidth={5} color="#E2203A"/>  <VisLine x={x} y={y}/>  <VisScatter x={x} y={y} shape={shape}/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  components: [    new StackedBar({ x, y, barWidth: 5, color: "#E2203A" })    new Line({ x, y })    new Scatter({ x, y, shape })  ]}, data)
```

Loading...

## Chart Sizing [](#chart-sizing "Direct link to Chart Sizing")

### Width and Height [](#width-and-height "Direct link to Width and Height")

By default, _XY Container_ will try to fit within the bounds of its parent HTML element. If the parent height isn't defined, the default height of `300px` will be applied. You can also explicitly define the container's size with the `width` and `height` properties, which accepts numeric values.

```
const width = 200;const height = 100;
```

Loading...

### Margin [](#margin "Direct link to Margin")

You can set _XY Container_'s `margin` to control the spacing between the container and adjacent elements. The `margin` property accepts a value of type `Sizing`, where each value represents the corresponding margin size in pixels.

#### Sizing [](#sizing "Direct link to Sizing")

```
type Sizing = {  top: number;  bottom: number;  left: number;  right: number;}
```

Note that the chart's size is affected by this property. Notice how the following chart is affected after setting the margin accordingly.

```
const margin = { left: 100, right: 100 }
```

#### Before: [](#before "Direct link to Before:")

Loading...

#### After: [](#after "Direct link to After:")

Loading...

### Padding [](#padding "Direct link to Padding")

You can configure the `padding` property of _XY Container_ to change how its children are spaced apart. This property also accepts value of type [Sizing](#sizing). In contrast to `margin`, the `padding` property will not affect the overall size of the chart, but rather tha size of the individual components. See how this works using the same example as above:

```
const padding = { left: 100, right: 100 }
```

Loading...

### Range [](#range "Direct link to Range")

The `xRange` and `yRange` determine the screen space your chart contains. By default, an _XY Container_ will fit to its container. Provide `xRange` with values [`xStart`, `width`] and `yRange` with [`yStart`, `height`] to override the default configuration.

## Domain [](#domain "Direct link to Domain")

You can change the domain of your data with the `xDomain` and `yDomain` properties to configure which values your `XY Component` should display. The result will show all data that is in this range- excluding any values that fall outside of the range, and occupying any missing values with white space. See the following example, which looks like this when the domain is not set:

Loading...

#### `xDomain = [4,8]`[](#xdomain--48 "Direct link to xdomain--48")

Loading...

#### `yDomain = [0,100]`[](#ydomain--0100 "Direct link to ydomain--0100")

Loading...

### Domain Constraints [](#domain-constraints "Direct link to Domain Constraints")

Customizing your domain is helpful in datasets with outliers. When using dynamic data, you may not know which values to constrain your domain values to. With the following constraint properties `xDomainMinConstraint`, `xDomainMaxConstraint`, `yDomainMinConstraint`, and `yDomainMaxConstraint`, you can define partial domains. For the following examples, consider the following case where the majority of the data is within the ranges `[0,10]` for all values of x and y. These properties accept a number array in the form `[number, number]` or more typically `[number, undefined]` | `[undefined, number]`.

#### Domain Constraints: None [](#domain-constraints-none "Direct link to Domain Constraints: None")

Loading...

#### xDomainMinConstraint: `[0, undefined]`[](#xdomainminconstraint-0-undefined "Direct link to xdomainminconstraint-0-undefined")

Loading...

#### yDomainMaxConstraint: `[undefined, 10]`[](#ydomainmaxconstraint-undefined-10 "Direct link to ydomainmaxconstraint-undefined-10")

Loading...

### `preventEmptyDomain`[](#preventemptydomain "Direct link to preventemptydomain")

When the calculated domain is empty (when domain's min and max values are equal), use the `preventEmptyDomain` property to extend it by `+1`. This may be useful when you have no data or a single data point and you want to show the empty space. The possible values are:

- `true`: automatically extend the domain by `+1` when the domain is empty (domain start equals domain end);
- `null`: extend the domain, but only when there's no data (default);
- `false`: keep the domain as is.

For example, a grouped bar with a single data point at `x=1`:

`preventEmptyDomain :`

Loading...

## Scale [](#scale "Direct link to Scale")

To change the scale of one of your axes in your _Container_, use the `xScale` or `yScale` property and a Scale function (i.e. `Scale.scaleLinear()`). Currently, only continuous scales are supported. See d3-scale for more information about the meaning behind these functions.

```
import { Scale } from '@unovis/ts'const yScale = Scale.scaleLinear()
```

Loading...

```
const yScale = Scale.scalePow().exponent(2)
```

## scaleByDomain [](#scalebydomain "Direct link to scaleByDomain")

You can also set the `yScale` domain dynamically based on the current `xDomain`, meaning that only visible data will be used in the domain calculation. Take a look at the example below. The `xDomain` configuration property there is not set, the chart displays the whole dataset and the Y axis shows ticks from 0 to 150.

Loading...

Let's set `xDomain` to `[0, 50]`. The chart now shows only a portion of the original data but the Y axis still displays the whole data range. Setting `scaleByDomain` to `true` will tell the chart to dynamically calculate the domain of `yScale` based on the data within `xDomain`. It comes in hand when you're updating xDomain programmatically using, for example, the _Brush_ component to provide some navigation capabilities to a chart with lots of data points.

`scaleByDomain :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer  data={data}   scaleByDomain={true}   xDomain={[0,50]}>  <VisStackedBar x={x} y={y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

template.html

```
<vis-xy-container  [data]="data"   [scaleByDomain]="true"   [xDomain]="[0,50]">  <vis-stacked-bar [x]="x" [y]="y"></vis-stacked-bar>  <vis-axis type="x"></vis-axis>  <vis-axis type="y"></vis-axis></vis-xy-container>
```

component.svelte

```
<VisXYContainer  {data}   scaleByDomain={true}   xDomain={[0,50]}>  <VisStackedBar {x} {y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

component.vue

```
<VisXYContainer  :data="data"   :scaleByDomain="true"   :xDomain="[0,50]">  <VisStackedBar :x="x" :y="y" />  <VisAxis type="x" />  <VisAxis type="y" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer  data={data}   scaleByDomain={true}   xDomain={[0,50]}>  <VisStackedBar x={x} y={y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  scaleByDomain: true,   xDomain: [0,50],   components: [new StackedBar({ x, y })],   xAxis: new Axis({ type: "x" }),   yAxis: new Axis({ type: "y" })}, data)
```

Loading...

## Y Direction [](#y-direction "Direct link to Y Direction")

You can set `yDirection` to change the direction of data along the Y axis. Supported values are `Direction.North` and `Direction.South`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer data={data} yDirection="south">  <VisStackedBar x={x} y={y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

template.html

```
<vis-xy-container [data]="data" yDirection="south">  <vis-stacked-bar [x]="x" [y]="y"></vis-stacked-bar>  <vis-axis type="x"></vis-axis>  <vis-axis type="y"></vis-axis></vis-xy-container>
```

component.svelte

```
<VisXYContainer {data} yDirection="south">  <VisStackedBar {x} {y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

component.vue

```
<VisXYContainer :data="data" yDirection="south">  <VisStackedBar :x="x" :y="y" />  <VisAxis type="x" />  <VisAxis type="y" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer data={data} yDirection="south">  <VisStackedBar x={x} y={y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  yDirection: "south",   components: [new StackedBar({ x, y })],   xAxis: new Axis({ type: "x" }),   yAxis: new Axis({ type: "y" })}, data)
```

Loading...

## SVG Defs [](#svg-defs "Direct link to SVG Defs")

You can use the `svgDefs` property to define custom fill patterns for your components. See our Tips and Tricks for details.

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |