---
title: "Line | Unovis"
meta:
  "og:description": "Learn how to configure a Line chart"
  "og:title": "Line | Unovis"
  description: "Learn how to configure a Line chart"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The _Line_ component has been designed to work together with _XY Container_. The minimal _Line_ configuration looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisLine } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data}>      <VisLine x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = (d: DataRecord) =>  d.y}
```

template.html

```
<vis-xy-container [data]="data">  <vis-line [x]="x" [y]="y"></vis-line></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisLine } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y</script><VisXYContainer {data}>  <VisLine {x} {y}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisLine } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.y</script><template>  <VisXYContainer :data="data">    <VisLine :x="x" :y="y" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisLine } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data()}>      <VisLine x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Line } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  components: [    new Line<DataRecord>({    x: (d: DataRecord) =>  d.x,     y: (d: DataRecord) =>  d.y  })  ]}, data)
```

Loading...

## Multiple Lines [](#multiple-lines "Direct link to Multiple Lines")

_Line_ can also accept an array of `y` accessors to display multiple lines:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  return (    <VisLine x={x} y={y}/>  )}
```

component.ts

```
@Component({  template: '<vis-line [x]="x" [y]="y"></vis-line>'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]}
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisLine } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]</script><VisLine {x} {y}/>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisLine } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]</script><template>  <VisLine :x="x" :y="y" /></template>
```

component.tsx

```
function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  return (    <VisLine x={x} y={y}/>  )}
```

component.ts

```
const line = new Line<DataRecord>({  x: (d: DataRecord) =>  d.x,   y: [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]})
```

Loading...

## Line Appearance [](#line-appearance "Direct link to Line Appearance")

### Width [](#width "Direct link to Width")

Specify the Line's width in pixels using the `lineWidth` property:

`lineWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLine lineWidth={5} x={x} y={y}/>
```

```
<vis-line [lineWidth]="5" [x]="x" [y]="y"></vis-line>
```

```
<VisLine lineWidth={5} {x} {y}/>
```

```
<VisLine :lineWidth="5" :x="x" :y="y" />
```

```
<VisLine lineWidth={5} x={x} y={y}/>
```

```
const line = new Line<DataRecord>({ lineWidth: 5, x, y })
```

Loading...

### Curve Type [](#curve-type "Direct link to Curve Type")

Using the `curveType: CurveType` property you can set various curve type options. For example:

`curveType :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLine curveType="basis" x={x} y={y}/>
```

```
<vis-line curveType="basis" [x]="x" [y]="y"></vis-line>
```

```
<VisLine curveType="basis" {x} {y}/>
```

```
<VisLine curveType="basis" :x="x" :y="y" />
```

```
<VisLine curveType="basis" x={x} y={y}/>
```

```
const line = new Line<DataRecord>({ curveType: "basis", x, y })
```

Loading...

### Color [](#color "Direct link to Color")

`color :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLine color="#a611a5" x={x} y={y}/>
```

```
<vis-line color="#a611a5" [x]="x" [y]="y"></vis-line>
```

```
<VisLine color="#a611a5" {x} {y}/>
```

```
<VisLine color="#a611a5" :x="x" :y="y" />
```

```
<VisLine color="#a611a5" x={x} y={y}/>
```

```
const line = new Line<DataRecord>({ color: "#a611a5", x, y })
```

Loading...

#### For multiple lines: [](#for-multiple-lines "Direct link to For multiple lines:")

If you want to set color for multiple lines at once, you'll have to define a colors array in your component and reference colors by index in the accessor function:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  return (    <VisXYContainer data={data}>      <VisLine x={x} y={y} color={color}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]}
```

template.html

```
<vis-xy-container [data]="data">  <vis-line [x]="x" [y]="y" [color]="color"></vis-line></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisLine } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]</script><VisXYContainer {data}>  <VisLine {x} {y} {color}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisLine } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]</script><template>  <VisXYContainer :data="data">    <VisLine :x="x" :y="y" :color="color" />  </VisXYContainer></template>
```

component.tsx

```
function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  return (    <VisXYContainer data={data()}>      <VisLine x={x} y={y} color={color}/>    </VisXYContainer>  )}
```

component.ts

```
const line = new Line<DataRecord>({  x: (d: DataRecord) =>  d.x,   y: [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ],   color: (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]})const container = new XYContainer<DataRecord>(node, { components: [line] }, data)
```

Loading...

### Dashes [](#dashes "Direct link to Dashes")

You can configure a dashed line with the lineDashArray property and a dash array. See SVG stroke-dasharray to learn more about this attribute.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLine x={x} y={y} lineDashArray={[5]}/>
```

```
<vis-line [x]="x" [y]="y" [lineDashArray]="[5]"></vis-line>
```

```
<VisLine {x} {y} lineDashArray={[5]}/>
```

```
<VisLine :x="x" :y="y" :lineDashArray="[5]" />
```

```
<VisLine x={x} y={y} lineDashArray={[5]}/>
```

```
const line = new Line<DataRecord>({ x, y, lineDashArray: [5] })
```

Loading...

#### For multiple lines: [](#for-multiple-lines-1 "Direct link to For multiple lines:")

Similar to [mutlti-color configuration](#for-multiple-lines), you can provide an accessor function to customize each line.

## Dealing with missing data [](#dealing-with-missing-data "Direct link to Dealing with missing data")

### Fallback Value [](#fallback-value "Direct link to Fallback Value")

In the case of missing data (when the data values are `undefined`, `NaN`, `''`, etc ...), you can assign a fallback value for _Line_ using the `fallbackValue` config property. The default value is `undefined`, which means that the line will break in the areas of no data and continue when the data appears again. If you set `fallbackValue` to `null`, the values will be treated as numerical `0` values and the line won't break; however if the whole dataset consists of only `null`s, the line won't be displayed.

Consider the following example, where the dataset contains `undefined` values over in the following domain: `4 <= x <= 6`

`fallbackValue :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLine fallbackValue={7} x={x} y={y}/>
```

```
<vis-line [fallbackValue]="7" [x]="x" [y]="y"></vis-line>
```

```
<VisLine fallbackValue={7} {x} {y}/>
```

```
<VisLine :fallbackValue="7" :x="x" :y="y" />
```

```
<VisLine fallbackValue={7} x={x} y={y}/>
```

```
const line = new Line<DataRecord>({ fallbackValue: 7, x, y })
```

Loading...

### Line Interpolation [](#line-interpolation "Direct link to Line Interpolation")

Alternatively, you can set the `interpolateMissingData` property to `true` to fill in the data gaps with a dashed line. If `fallbackValue` is set, those values will be plotted on the inteprolated line. Otherwise, it will be a smooth curve between defined points, like below:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLine x={x} y={y} interpolateMissingData={true}/>
```

```
<vis-line [x]="x" [y]="y" [interpolateMissingData]="true"></vis-line>
```

```
<VisLine {x} {y} interpolateMissingData={true}/>
```

```
<VisLine :x="x" :y="y" :interpolateMissingData="true" />
```

```
<VisLine x={x} y={y} interpolateMissingData={true}/>
```

```
const line = new Line<DataRecord>({ x, y, interpolateMissingData: true })
```

Loading...

You can customize the appearance of of the interpolated line with the following CSS varibles:

```
--vis-line-gapfill-stroke-dasharray: 2 3;--vis-line-gapfill-stroke-opacity: 0.8;--vis-line-gapfill-stroke-dashoffset: 0;
```

## Events [](#events "Direct link to Events")

```
import { Line } from '@unovis/ts'...const events = {  [Line.selectors.line]: {    mouseover: (data: DataRecord[]) => {},    mouseleave: (data: DataRecord[]) => {},    ...  }}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLine x={x} y={y} events={events}/>
```

```
<vis-line [x]="x" [y]="y" [events]="events"></vis-line>
```

```
<VisLine {x} {y} {events}/>
```

```
<VisLine :x="x" :y="y" :events="events" />
```

```
<VisLine x={x} y={y} events={events}/>
```

```
const line = new Line<DataRecord>({ x, y, events })
```

Loading...

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Line_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.custom-line {  --vis-line-cursor: cell;  --vis-line-stroke-dasharray: 55 15;  --vis-line-stroke-dashoffset: 0;}
```

Loading...

<details>

<summary>Supported CSS variables and their default values</summary>



```
--vis-line-cursor: default;--vis-line-stroke-dasharray: none;--vis-line-stroke-dashoffset: 0;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |