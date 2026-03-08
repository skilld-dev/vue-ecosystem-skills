---
title: "Scatter | Unovis"
meta:
  "og:description": "Learn how to configure a Scatter plot"
  "og:title": "Scatter | Unovis"
  description: "Learn how to configure a Scatter plot"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The _Scatter_ component has been designed to work together with _XYContainer_. The minimal _Scatter_ configuration looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisScatter } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data}>      <VisScatter x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = (d: DataRecord) =>  d.y}
```

template.html

```
<vis-xy-container [data]="data">  <vis-scatter [x]="x" [y]="y"></vis-scatter></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisScatter } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y</script><VisXYContainer {data}>  <VisScatter {x} {y}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisScatter } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.y</script><template>  <VisXYContainer :data="data">    <VisScatter :x="x" :y="y" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisScatter } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data()}>      <VisScatter x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Scatter } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  components: [    new Scatter<DataRecord>({    x: (d: DataRecord) =>  d.x,     y: (d: DataRecord) =>  d.y  })  ]}, data)
```

Loading...

## Point Appearance [](#point-appearance "Direct link to Point Appearance")

### Custom Shape [](#custom-shape "Direct link to Custom Shape")

You can change the point's symbol using the `symbol` attribute, which accepts a `SymbolType` or a corresponding `string` (`'circle'`, `'cross'`, `'diamond'`, `'square'`, `'star'`, `'triangle'`, `'wye'` ) or a function (executed per data point) that returns either of them.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} shape="wye"/>
```

```
<vis-scatter [x]="x" [y]="y" shape="wye"></vis-scatter>
```

```
<VisScatter {x} {y} shape="wye"/>
```

```
<VisScatter :x="x" :y="y" shape="wye" />
```

```
<VisScatter x={x} y={y} shape="wye"/>
```

```
const scatter = new Scatter<DataRecord>({ x, y, shape: "wye" })
```

Loading...

### Custom Color [](#custom-color "Direct link to Custom Color")

You can provide _Scatter_ with a single `color` hex value or a `color` accessor function.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} color="#DA348F"/>
```

```
<vis-scatter [x]="x" [y]="y" color="#DA348F"></vis-scatter>
```

```
<VisScatter {x} {y} color="#DA348F"/>
```

```
<VisScatter :x="x" :y="y" color="#DA348F" />
```

```
<VisScatter x={x} y={y} color="#DA348F"/>
```

```
const scatter = new Scatter<DataRecord>({ x, y, color: "#DA348F" })
```

Loading...

### Stroke Color [](#stroke-color "Direct link to Stroke Color")

You can also set a stroke color for your points by providing a `strokeColor` hex value or a `strokeColor` accessor function.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} color="none" strokeColor="#DA348F"/>
```

```
<vis-scatter  [x]="x"   [y]="y"   color="none"   strokeColor="#DA348F"></vis-scatter>
```

```
<VisScatter {x} {y} color="none" strokeColor="#DA348F"/>
```

```
<VisScatter :x="x" :y="y" color="none" strokeColor="#DA348F" />
```

```
<VisScatter x={x} y={y} color="none" strokeColor="#DA348F"/>
```

```
const scatter = new Scatter<DataRecord>({  x,   y,   color: "none",   strokeColor: "#DA348F"})
```

Loading...

### Stroke Width [](#stroke-width "Direct link to Stroke Width")

If you want to change the stroke width, you can use the `strokeWidth` property, which accepts a constant value or an accessor function.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter  x={x}   y={y}   color="none"   strokeColor="#DA348F"   strokeWidth={5}/>
```

```
<vis-scatter  [x]="x"   [y]="y"   color="none"   strokeColor="#DA348F"   [strokeWidth]="5"></vis-scatter>
```

```
<VisScatter  {x}   {y}   color="none"   strokeColor="#DA348F"   strokeWidth={5}/>
```

```
<VisScatter  :x="x"   :y="y"   color="none"   strokeColor="#DA348F"   :strokeWidth="5" />
```

```
<VisScatter  x={x}   y={y}   color="none"   strokeColor="#DA348F"   strokeWidth={5}/>
```

```
const scatter = new Scatter<DataRecord>({  x,   y,   color: "none",   strokeColor: "#DA348F",   strokeWidth: 5})
```

Loading...

### Size and Size Range [](#size-and-size-range "Direct link to Size and Size Range")

You can use the `size` property to set the point size (i.e. point diameter if `shape` is set to `SymbolType.Circle`) in pixels by providing a constant value or an accessor function, e.g.: `d => d.size`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} size={50}/>
```

```
<vis-scatter [x]="x" [y]="y" [size]="50"></vis-scatter>
```

```
<VisScatter {x} {y} size={50}/>
```

```
<VisScatter :x="x" :y="y" :size="50" />
```

```
<VisScatter x={x} y={y} size={50}/>
```

```
const scatter = new Scatter<DataRecord>({ x, y, size: 50 })
```

Loading...

_Scatter's_ `sizeRange` attribute represents a range of numbers for a point's size. When `sizeRange` is set, the `size` property will be treated as relative and all the points will be rescaled according to the provided range.

In tha case if you provide a constant value to `size`, every resulting size value will be the median of `sizeRange`. Fox example, if `sizeRange` is set to `[10,50]`, that will make the default size equal to 30px (or `(min + max)/2`).

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} size={size} sizeRange={[10,50]}/>
```

```
<vis-scatter  [x]="x"   [y]="y"   [size]="size"   [sizeRange]="[10,50]"></vis-scatter>
```

```
<VisScatter {x} {y} {size} sizeRange={[10,50]}/>
```

```
<VisScatter :x="x" :y="y" :size="size" :sizeRange="[10,50]" />
```

```
<VisScatter x={x} y={y} size={size} sizeRange={[10,50]}/>
```

```
const scatter = new Scatter<DataRecord>({ x, y, size, sizeRange: [10,50] })
```

Loading...

## Point Labels [](#point-labels "Direct link to Point Labels")

You can also place labels on _Scatter's_ points by passing a string accessor function to the `label` property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} size={20} label={label}/>
```

```
<vis-scatter [x]="x" [y]="y" [size]="20" [label]="label"></vis-scatter>
```

```
<VisScatter {x} {y} size={20} {label}/>
```

```
<VisScatter :x="x" :y="y" :size="20" :label="label" />
```

```
<VisScatter x={x} y={y} size={20} label={label}/>
```

```
const scatter = new Scatter<DataRecord>({ x, y, size: 20, label })
```

Loading...

### Label Color [](#label-color "Direct link to Label Color")

You can also configure a custom color for your labels by providing the `labelColor` attribute with a color accessor method or string. Note that setting this property overrides `labelTextBrightnessRatio`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} size={20} label={label} labelColor="red"/>
```

```
<vis-scatter  [x]="x"   [y]="y"   [size]="20"   [label]="label"   labelColor="red"></vis-scatter>
```

```
<VisScatter {x} {y} size={20} {label} labelColor="red"/>
```

```
<VisScatter :x="x" :y="y" :size="20" :label="label" labelColor="red" />
```

```
<VisScatter x={x} y={y} size={20} label={label} labelColor="red"/>
```

```
const scatter = new Scatter<DataRecord>({ x, y, size: 20, label, labelColor: "red" })
```

Loading...

### Label Position [](#label-position "Direct link to Label Position")

You can change a point's label position with the `labelPosition` property, which accepts a _Position_ or _Position_ accessor function. Supported values are `Position.Center`, `Position.Bottom` (default), `Position.Left`, `Position.Right` and `Position.Top`

`labelPosition :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter labelPosition="bottom" x={x} y={y}/>
```

```
<vis-scatter labelPosition="bottom" [x]="x" [y]="y"></vis-scatter>
```

```
<VisScatter labelPosition="bottom" {x} {y}/>
```

```
<VisScatter labelPosition="bottom" :x="x" :y="y" />
```

```
<VisScatter labelPosition="bottom" x={x} y={y}/>
```

```
const scatter = new Scatter<DataRecord>({ labelPosition: "bottom", x, y })
```

Loading...

### Label Text Brightness Ratio [](#label-text-brightness-ratio "Direct link to Label Text Brightness Ratio")

By default, labels with `Position.Center` will be assigned a color based on the point's shade with the `labelTextBrightnessRatio` property. It accepts any value between `0` and `1` (inclusive).

The default setting `0.65` creates darker text on light backgrounds and light text on dark backgrounds. See how the contrast differs in the following examples, when we assign more extreme values to the `labelTextBrightnessRatio` property:

`labelTextBrightnessRatio :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter  labelTextBrightnessRatio={0.65}   x={x}   y={y}   size={20}   color={color}   label={label}   labelPosition="center"/>
```

```
<vis-scatter  [labelTextBrightnessRatio]="0.65"   [x]="x"   [y]="y"   [size]="20"   [color]="color"   [label]="label"   labelPosition="center"></vis-scatter>
```

```
<VisScatter  labelTextBrightnessRatio={0.65}   {x}   {y}   size={20}   {color}   {label}   labelPosition="center"/>
```

```
<VisScatter  :labelTextBrightnessRatio="0.65"   :x="x"   :y="y"   :size="20"   :color="color"   :label="label"   labelPosition="center" />
```

```
<VisScatter  labelTextBrightnessRatio={0.65}   x={x}   y={y}   size={20}   color={color}   label={label}   labelPosition="center"/>
```

```
const scatter = new Scatter<DataRecord>({  labelTextBrightnessRatio: 0.65,   x,   y,   size: 20,   color,   label,   labelPosition: "center"})
```

Loading...

### Overlapping Labels [](#overlapping-labels "Direct link to Overlapping Labels")

When there're overlapping labels, _Scatter_ will hide some of them to avoid cluttering. You can see hidden labels by hobvering over the points. If you want to disable hiding overlapping labels, you can set the `labelHideOverlapping` property to `false`.

`labelHideOverlapping :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter  labelHideOverlapping={true}   x={x}   y={y}   size={10}   color={color}   label={label}/>
```

```
<vis-scatter  [labelHideOverlapping]="true"   [x]="x"   [y]="y"   [size]="10"   [color]="color"   [label]="label"></vis-scatter>
```

```
<VisScatter  labelHideOverlapping={true}   {x}   {y}   size={10}   {color}   {label}/>
```

```
<VisScatter  :labelHideOverlapping="true"   :x="x"   :y="y"   :size="10"   :color="color"   :label="label" />
```

```
<VisScatter  labelHideOverlapping={true}   x={x}   y={y}   size={10}   color={color}   label={label}/>
```

```
const scatter = new Scatter<DataRecord>({  labelHideOverlapping: true,   x,   y,   size: 10,   color,   label})
```

Loading...

## Custom Cursor [](#custom-cursor "Direct link to Custom Cursor")

_Scatter_ also allows to set a custom `cursor` when hovering over a point by providing a `cursor` accessor function.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} cursor="crosshair"/>
```

```
<vis-scatter [x]="x" [y]="y" cursor="crosshair"></vis-scatter>
```

```
<VisScatter {x} {y} cursor="crosshair"/>
```

```
<VisScatter :x="x" :y="y" cursor="crosshair" />
```

```
<VisScatter x={x} y={y} cursor="crosshair"/>
```

```
const scatter = new Scatter<DataRecord>({ x, y, cursor: "crosshair" })
```

Loading...

## Events [](#events "Direct link to Events")

```
import { Scatter } from '@unovis/ts'...events = {    [Scatter.selectors.point]: {        click: (d: DataRecord) => {},        ...    },}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisScatter x={x} y={y} events={events}/>
```

```
<vis-scatter [x]="x" [y]="y" [events]="events"></vis-scatter>
```

```
<VisScatter {x} {y} {events}/>
```

```
<VisScatter :x="x" :y="y" :events="events" />
```

```
<VisScatter x={x} y={y} events={events}/>
```

```
const scatter = new Scatter<DataRecord>({ x, y, events })
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Scatter_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.custom-vis {--vis-scatter-fill-opacity: 0.5;--vis-scatter-stroke-width: 1;--vis-scatter-hover-stroke-width: 2;--vis-scatter-point-label-text-color-dark: darkblue;}
```

Loading...

<details>

<summary>Details</summary>



<summary>Supported CSS variables and their default values</summary>



```
--vis-scatter-cursor: default;--vis-scatter-fill-color: var(--vis-color-main);--vis-scatter-stroke-color: 'none';--vis-scatter-stroke-width: 1px;--vis-scatter-fill-opacity: 1;--vis-scatter-stroke-opacity: 1;--vis-scatter-hover-stroke-width: 2px; --vis-scatter-point-label-text-color-dark: #5b5f6d;--vis-scatter-point-label-text-color-light: #fff;--vis-scatter-point-label-text-font-weight: 500;--vis-scatter-point-label-text-font-size: 12px;--vis-scatter-point-label-text-font-family
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |