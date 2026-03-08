---
title: "Area | Unovis"
meta:
  "og:description": "Learn how to configure an Area chart"
  "og:title": "Area | Unovis"
  description: "Learn how to configure an Area chart"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisArea } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data}>      <VisArea x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = (d: DataRecord) =>  d.y}
```

template.html

```
<vis-xy-container [data]="data">  <vis-area [x]="x" [y]="y"></vis-area></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisArea } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y</script><VisXYContainer {data}>  <VisArea {x} {y}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisArea } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.y</script><template>  <VisXYContainer :data="data">    <VisArea :x="x" :y="y" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisArea } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data()}>      <VisArea x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Area } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  components: [    new Area<DataRecord>({    x: (d: DataRecord) =>  d.x,     y: (d: DataRecord) =>  d.y  })  ]}, data)
```

Loading...

## Curve Types [](#curve-types "Direct link to Curve Types")

Using the `curveType: CurveType` property you can set various curve type options. For example:

`curveType :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea curveType="basis" x={x} y={y}/>
```

```
<vis-area curveType="basis" [x]="x" [y]="y"></vis-area>
```

```
<VisArea curveType="basis" {x} {y}/>
```

```
<VisArea curveType="basis" :x="x" :y="y" />
```

```
<VisArea curveType="basis" x={x} y={y}/>
```

```
const area = new Area<DataRecord>({ curveType: "basis", x, y })
```

Loading...

Learn more about configurable curves from D3's documentation

## Color [](#color "Direct link to Color")

Setting color for a single _Area_ component is simple, you can achieve that just by setting the `color` property of the component to a hex string.

`color :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea color="#19cb9a" x={x} y={y}/>
```

```
<vis-area color="#19cb9a" [x]="x" [y]="y"></vis-area>
```

```
<VisArea color="#19cb9a" {x} {y}/>
```

```
<VisArea color="#19cb9a" :x="x" :y="y" />
```

```
<VisArea color="#19cb9a" x={x} y={y}/>
```

```
const area = new Area<DataRecord>({ color: "#19cb9a", x, y })
```

Loading...

## Line [](#line "Direct link to Line")

You can also display a line connecting the points of the _Area_ component by setting the `line` property to `true`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea x={x} y={y} opacity={0.3} line={true}/>
```

```
<vis-area [x]="x" [y]="y" [opacity]="0.3" [line]="true"></vis-area>
```

```
<VisArea {x} {y} opacity={0.3} line={true}/>
```

```
<VisArea :x="x" :y="y" :opacity="0.3" :line="true" />
```

```
<VisArea x={x} y={y} opacity={0.3} line={true}/>
```

```
const area = new Area<DataRecord>({ x, y, opacity: 0.3, line: true })
```

Loading...

### Line Width [](#line-width "Direct link to Line Width")

`lineWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea lineWidth={5} x={x} y={y} opacity={0.3} line={true}/>
```

```
<vis-area  [lineWidth]="5"   [x]="x"   [y]="y"   [opacity]="0.3"   [line]="true"></vis-area>
```

```
<VisArea lineWidth={5} {x} {y} opacity={0.3} line={true}/>
```

```
<VisArea :lineWidth="5" :x="x" :y="y" :opacity="0.3" :line="true" />
```

```
<VisArea lineWidth={5} x={x} y={y} opacity={0.3} line={true}/>
```

```
const area = new Area<DataRecord>({ lineWidth: 5, x, y, opacity: 0.3, line: true })
```

Loading...

### Line Color [](#line-color "Direct link to Line Color")

`lineColor :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea lineColor="#a611a5" x={x} y={y} opacity={0.3} line={true}/>
```

```
<vis-area  lineColor="#a611a5"   [x]="x"   [y]="y"   [opacity]="0.3"   [line]="true"></vis-area>
```

```
<VisArea lineColor="#a611a5" {x} {y} opacity={0.3} line={true}/>
```

```
<VisArea  lineColor="#a611a5"   :x="x"   :y="y"   :opacity="0.3"   :line="true" />
```

```
<VisArea lineColor="#a611a5" x={x} y={y} opacity={0.3} line={true}/>
```

```
const area = new Area<DataRecord>({  lineColor: "#a611a5",   x,   y,   opacity: 0.3,   line: true})
```

Loading...

## Stacked Areas [](#stacked-areas "Direct link to Stacked Areas")

### Y Accessors [](#y-accessors "Direct link to Y Accessors")

_Area_ can accept an array of `y` accessors to display stacked areas from your provided data.

**Note**: It is important that an array of accessors or provided, not a single accessor which returns an array. For example, if you wanted to generate a chart with three areas of random data:

Loading...

```
/* ✅ Do this */const y = [  () => Math.random(),  () => Math.random(),  () => Math.random(),]/* ⛔ Not this */const y = d => [Math.random(), Math.random(), Math.random()]
```

### Multiple Colors [](#multiple-colors "Direct link to Multiple Colors")

If you want to configure multiple colors for your _Area_ component, you'll have to supply a single accessor. A common configuration is to utilize the data's index:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisArea } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  return (    <VisXYContainer data={data}>      <VisArea x={x} y={y} color={color}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]}
```

template.html

```
<vis-xy-container [data]="data">  <vis-area [x]="x" [y]="y" [color]="color"></vis-area></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisArea } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]</script><VisXYContainer {data}>  <VisArea {x} {y} {color}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisArea } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]</script><template>  <VisXYContainer :data="data">    <VisArea :x="x" :y="y" :color="color" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisArea } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  return (    <VisXYContainer data={data()}>      <VisArea x={x} y={y} color={color}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Area } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  components: [    new Area<DataRecord>({    x: (d: DataRecord) =>  d.x,     y: [      (d: DataRecord) =>  d.y,      (d: DataRecord) =>  d.y1,      (d: DataRecord) =>  d.y2    ],     color: (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  })  ]}, data)
```

Loading...

## Dealing with small values [](#dealing-with-small-values "Direct link to Dealing with small values")

If your data has small or zero values leading to some parts of the area to become invisible, you can use the `minHeight` property to set a minimum height for the area. This can be useful if you want to visually emphasize that the data behind the chart is defined but just very small.

`minHeight :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea minHeight={1} x={x} y={y}/>
```

```
<vis-area [minHeight]="1" [x]="x" [y]="y"></vis-area>
```

```
<VisArea minHeight={1} {x} {y}/>
```

```
<VisArea :minHeight="1" :x="x" :y="y" />
```

```
<VisArea minHeight={1} x={x} y={y}/>
```

```
const area = new Area<DataRecord>({ minHeight: 1, x, y })
```

Loading...

### Stacking minimum heights [](#stacking-minimum-heights "Direct link to Stacking minimum heights")

When working with stacked areas and using the `minHeight` property, you can control whether the minimum height adjustments stack on top of each other or not using the `stackMinHeight` property.

By default, each area with a minimum height will be adjusted independently. When you set `stackMinHeight` to `true`, the minimum height adjustments will be cumulative, which can affect the visual appearance of stacked areas with small values.

> **Note:** Use the `minHeight` and `stackMinHeight` properties carefully as they modify the visual representation of the data without changing the underlying values. The Crosshair component will still show circles at the original data values, not at the visually extended area height.

`stackMinHeight :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea stackMinHeight={undefined} x={x} y={y} minHeight={5}/>
```

```
<vis-area  [stackMinHeight]="undefined"   [x]="x"   [y]="y"   [minHeight]="5"></vis-area>
```

```
<VisArea stackMinHeight={undefined} {x} {y} minHeight={5}/>
```

```
<VisArea :stackMinHeight="undefined" :x="x" :y="y" :minHeight="5" />
```

```
<VisArea stackMinHeight={undefined} x={x} y={y} minHeight={5}/>
```

```
const area = new Area<DataRecord>({ stackMinHeight: undefined, x, y, minHeight: 5 })
```

Loading...

## Events [](#events "Direct link to Events")

The _Area_ component supports the following events:

```
import { Area } from '@unovis/ts'events = [Area.selectors.area]: {  click: (data: DataRecord[]) => {},  mouseover: (data: DataRecord[]) => {},  mouseleave: (data: DataRecord[]) => {}}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea x={x} y={y} events={events}/>
```

```
<vis-area [x]="x" [y]="y" [events]="events"></vis-area>
```

```
<VisArea {x} {y} {events}/>
```

```
<VisArea :x="x" :y="y" :events="events" />
```

```
<VisArea x={x} y={y} events={events}/>
```

```
const area = new Area<DataRecord>({ x, y, events })
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Area_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.custom-area {  --vis-area-fill-opacity: 0.5;  --vis-area-hover-fill-opacity: 1;  --vis-area-stroke-width: 1px;
```

Loading...

<details>

<summary>Supported CSS variables and their default values</summary>



```
--vis-area-cursor: default;--vis-area-fill-opacity: 1;--vis-area-stroke-color: none;--vis-area-stroke-width: 0px;--vis-area-stroke-dasharray: none;--vis-area-stroke-opacity: 1;--vis-area-hover-fill-opacity: none;--vis-area-hover-stroke-width: none; /* Dark Theme */--vis-dark-area-stroke-color: none;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |