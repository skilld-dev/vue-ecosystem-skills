---
title: "Grouped Bar | Unovis"
meta:
  "og:description": "Learn how to configure a Grouped Bar chart"
  "og:title": "Grouped Bar | Unovis"
  description: "Learn how to configure a Grouped Bar chart"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The _Grouped Bar_ component has been designed to work together with _XY Container_. The minimal _Grouped Bar_ configuration looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisGroupedBar } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  return (    <VisXYContainer data={data}>      <VisGroupedBar x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]}
```

template.html

```
<vis-xy-container [data]="data">  <vis-grouped-bar [x]="x" [y]="y"></vis-grouped-bar></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisGroupedBar } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]</script><VisXYContainer {data}>  <VisGroupedBar {x} {y}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisGroupedBar } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]</script><template>  <VisXYContainer :data="data">    <VisGroupedBar :x="x" :y="y" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisGroupedBar } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  return (    <VisXYContainer data={data()}>      <VisGroupedBar x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, GroupedBar } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  components: [    new GroupedBar<DataRecord>({    x: (d: DataRecord) =>  d.x,     y: [      (d: DataRecord) =>  d.y,      (d: DataRecord) =>  d.y1,      (d: DataRecord) =>  d.y2    ]  })  ]}, data)
```

Loading...

## Orientation [](#orientation "Direct link to Orientation")

_Grouped Bar_ supports horizontal and vertical orientation.

`orientation :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar orientation="horizontal" x={x} y={y}/>
```

```
<vis-grouped-bar  orientation="horizontal"   [x]="x"   [y]="y"></vis-grouped-bar>
```

```
<VisGroupedBar orientation="horizontal" {x} {y}/>
```

```
<VisGroupedBar orientation="horizontal" :x="x" :y="y" />
```

```
<VisGroupedBar orientation="horizontal" x={x} y={y}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ orientation: "horizontal", x, y })
```

Loading...

## Bar Colors [](#bar-colors "Direct link to Bar Colors")

Set the color of the bar by assigning the color property to a hex string and/or by assigning the color property to a function evaluated per each bar. In this example, each bar's color is assigned based on its index:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['#04c0c7', '#5144d3', '#da348f'][i]  return (    <VisGroupedBar x={x} y={y} color={color}/>  )}
```

component.ts

```
@Component({  template: '<vis-grouped-bar [x]="x" [y]="y" [color]="color"></vis-grouped-bar>'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  color = (d: DataRecord, i: number) =>  ['#04c0c7', '#5144d3', '#da348f'][i]}
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisGroupedBar } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['#04c0c7', '#5144d3', '#da348f'][i]</script><VisGroupedBar {x} {y} {color}/>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisGroupedBar } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]const color = (d: DataRecord, i: number) =>  ['#04c0c7', '#5144d3', '#da348f'][i]</script><template>  <VisGroupedBar :x="x" :y="y" :color="color" /></template>
```

component.tsx

```
function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  const color = (d: DataRecord, i: number) =>  ['#04c0c7', '#5144d3', '#da348f'][i]  return (    <VisGroupedBar x={x} y={y} color={color}/>  )}
```

component.ts

```
const groupedBar = new GroupedBar<DataRecord>({  x: (d: DataRecord) =>  d.x,   y: [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ],   color: (d: DataRecord, i: number) =>  ['#04c0c7', '#5144d3', '#da348f'][i]})
```

Loading...

## Rounded Corners [](#rounded-corners "Direct link to Rounded Corners")

You can apply rounded corners to the top bar in your _Grouped Bar_ component using the `roundedCorners` property, which accepts either a `number` (in pixels) or `boolean` argument.

`roundedCorners :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar roundedCorners={true} x={x} y={y}/>
```

```
<vis-grouped-bar  [roundedCorners]="true"   [x]="x"   [y]="y"></vis-grouped-bar>
```

```
<VisGroupedBar roundedCorners={true} {x} {y}/>
```

```
<VisGroupedBar :roundedCorners="true" :x="x" :y="y" />
```

```
<VisGroupedBar roundedCorners={true} x={x} y={y}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ roundedCorners: true, x, y })
```

Loading...

## Bar Sizing [](#bar-sizing "Direct link to Bar Sizing")

There are multiple configuration properties that contribute to the size of you bars in _Grouped Bar_. Some are on the group level while others on the individual.

### Group Width [](#group-width "Direct link to Group Width")

By default, the width of the bars is calculated automatically based on their count. But you can also strictly set the bar's width in pixels using the barWidth property:

`groupWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar groupWidth={50} x={x} y={y}/>
```

```
<vis-grouped-bar [groupWidth]="50" [x]="x" [y]="y"></vis-grouped-bar>
```

```
<VisGroupedBar groupWidth={50} {x} {y}/>
```

```
<VisGroupedBar :groupWidth="50" :x="x" :y="y" />
```

```
<VisGroupedBar groupWidth={50} x={x} y={y}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ groupWidth: 50, x, y })
```

Loading...

### Limiting Dynamic Group Width [](#limiting-dynamic-group-width "Direct link to Limiting Dynamic Group Width")

When you don't know the number of bars in advance, and you're relying on automatic bar width calculation, you might want to limit the maximum bar width to prevent the bars from being too wide when there are just a few of them. That can be achieved by setting the groupMaxWidth property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar x={x} y={y}/>
```

```
<vis-grouped-bar [x]="x" [y]="y"></vis-grouped-bar>
```

```
<VisGroupedBar {x} {y}/>
```

```
<VisGroupedBar :x="x" :y="y" />
```

```
<VisGroupedBar x={x} y={y}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ x, y })
```

Loading...

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar x={x} y={y} groupMaxWidth={25}/>
```

```
<vis-grouped-bar  [x]="x"   [y]="y"   [groupMaxWidth]="25"></vis-grouped-bar>
```

```
<VisGroupedBar {x} {y} groupMaxWidth={25}/>
```

```
<VisGroupedBar :x="x" :y="y" :groupMaxWidth="25" />
```

```
<VisGroupedBar x={x} y={y} groupMaxWidth={25}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ x, y, groupMaxWidth: 25 })
```

Loading...

### Group vs. Bar Padding [](#group-vs-bar-padding "Direct link to Group vs. Bar Padding")

Another way to control bar width is by adding padding to bar groups (`groupPadding` property) or individual bars (`barPadding). The value which specifies how much of the available sector should be empty in the range of [0,1].

`groupPadding :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar groupPadding={0.5} x={x} y={y}/>
```

```
<vis-grouped-bar  [groupPadding]="0.5"   [x]="x"   [y]="y"></vis-grouped-bar>
```

```
<VisGroupedBar groupPadding={0.5} {x} {y}/>
```

```
<VisGroupedBar :groupPadding="0.5" :x="x" :y="y" />
```

```
<VisGroupedBar groupPadding={0.5} x={x} y={y}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ groupPadding: 0.5, x, y })
```

Loading...

`barPadding :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar barPadding={0.5} x={x} y={y}/>
```

```
<vis-grouped-bar [barPadding]="0.5" [x]="x" [y]="y"></vis-grouped-bar>
```

```
<VisGroupedBar barPadding={0.5} {x} {y}/>
```

```
<VisGroupedBar :barPadding="0.5" :x="x" :y="y" />
```

```
<VisGroupedBar barPadding={0.5} x={x} y={y}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ barPadding: 0.5, x, y })
```

Loading...

### Minimum Bar Height [](#minimum-bar-height "Direct link to Minimum Bar Height")

When you have highly scattered data with very low and high values, the bars corresponding to the lower values can be so small, so they become invisible. If you want to prevent that you can set the minimum bar height to 1 pixel using the `barMinHeight` boolean property.

`barMinHeight :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar barMinHeight={1} x={x} y={y}/>
```

```
<vis-grouped-bar [barMinHeight]="1" [x]="x" [y]="y"></vis-grouped-bar>
```

```
<VisGroupedBar barMinHeight={1} {x} {y}/>
```

```
<VisGroupedBar :barMinHeight="1" :x="x" :y="y" />
```

```
<VisGroupedBar barMinHeight={1} x={x} y={y}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ barMinHeight: 1, x, y })
```

Loading...

## Preventing Overlaps with `dataStep`[](#preventing-overlaps-with-datastep "Direct link to preventing-overlaps-with-datastep")

When your data has gaps, it's impossible to do calculate of the bar width automatically. The visualization will still try to do that, but most likely the result will be wrong, and you'll see wide overlapping bars. However, you can help the calculation by setting your data step implicitly using the dataStep property. Consider the following example, with data mainly clumped in the domain `0 < x < 1`:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar x={x} y={y}/>
```

```
<vis-grouped-bar [x]="x" [y]="y"></vis-grouped-bar>
```

```
<VisGroupedBar {x} {y}/>
```

```
<VisGroupedBar :x="x" :y="y" />
```

```
<VisGroupedBar x={x} y={y}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ x, y })
```

Loading...

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar x={x} y={y} dataStep={0.1}/>
```

```
<vis-grouped-bar [x]="x" [y]="y" [dataStep]="0.1"></vis-grouped-bar>
```

```
<VisGroupedBar {x} {y} dataStep={0.1}/>
```

```
<VisGroupedBar :x="x" :y="y" :dataStep="0.1" />
```

```
<VisGroupedBar x={x} y={y} dataStep={0.1}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ x, y, dataStep: 0.1 })
```

Loading...

## Using Ordinal Data [](#using-ordinal-data "Direct link to Using Ordinal Data")

Read our guide about using ordinal/categorical values with _XY Components_ here

## Events [](#events "Direct link to Events")

```
import { GroupedBar } from '@unovis/ts'...events = {    [GroupedBar.selectors.bar]: {        click: (d: DataRecord) => {},        ...    },    [GroupedBar.selectors.barGroup]: {        mouseover: (d: DataRecord[]) => {},        ...    },}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGroupedBar x={x} y={y} events={events}/>
```

```
<vis-grouped-bar [x]="x" [y]="y" [events]="events"></vis-grouped-bar>
```

```
<VisGroupedBar {x} {y} {events}/>
```

```
<VisGroupedBar :x="x" :y="y" :events="events" />
```

```
<VisGroupedBar x={x} y={y} events={events}/>
```

```
const groupedBar = new GroupedBar<DataRecord>({ x, y, events })
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Grouped Bar_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.custom-vis {  --vis-grouped-bar-stroke-width: 2px;  --vis-grouped-bar-stroke-color: #000;  --vis-grouped-bar-cursor: crosshair;}
```

Loading...

<details>

<summary>Supported CSS variables and their default values</summary>



```
--vis-grouped-bar-cursor: default;--vis-grouped-bar-fill-color: var(--vis-color-main);--vis-grouped-bar-stroke-color: none;--vis-grouped-bar-stroke-width: 0px;--vis-grouped-bar-hover-stroke-width: 1px;--vis-grouped-bar-hover-stroke-color: none;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |