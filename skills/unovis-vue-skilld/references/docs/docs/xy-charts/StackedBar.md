---
title: "Stacked Bar | Unovis"
meta:
  "og:description": "Learn how to configure a Stacked Bar chart"
  "og:title": "Stacked Bar | Unovis"
  description: "Learn how to configure a Stacked Bar chart"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The _Stacked Bar_ component has been designed to work together with _XY Container_. The minimal _Stacked Bar_ configuration looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisStackedBar } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data}>      <VisStackedBar x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = (d: DataRecord) =>  d.y}
```

template.html

```
<vis-xy-container [data]="data">  <vis-stacked-bar [x]="x" [y]="y"></vis-stacked-bar></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisStackedBar } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y</script><VisXYContainer {data}>  <VisStackedBar {x} {y}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisStackedBar } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.y</script><template>  <VisXYContainer :data="data">    <VisStackedBar :x="x" :y="y" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisStackedBar } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data()}>      <VisStackedBar x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, StackedBar } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  components: [    new StackedBar<DataRecord>({    x: (d: DataRecord) =>  d.x,     y: (d: DataRecord) =>  d.y  })  ]}, data)
```

Loading...

## Multiple Stacked Bars [](#multiple-stacked-bars "Direct link to Multiple Stacked Bars")

_Stacked Bar_ can accept an array of y accessors to display values as a stack of bars:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisStackedBar } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  return (    <VisXYContainer data={data}>      <VisStackedBar x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]}
```

template.html

```
<vis-xy-container [data]="data">  <vis-stacked-bar [x]="x" [y]="y"></vis-stacked-bar></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisStackedBar } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]</script><VisXYContainer {data}>  <VisStackedBar {x} {y}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisStackedBar } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]</script><template>  <VisXYContainer :data="data">    <VisStackedBar :x="x" :y="y" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisStackedBar } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  return (    <VisXYContainer data={data()}>      <VisStackedBar x={x} y={y}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, StackedBar } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  components: [    new StackedBar<DataRecord>({    x: (d: DataRecord) =>  d.x,     y: [      (d: DataRecord) =>  d.y,      (d: DataRecord) =>  d.y1,      (d: DataRecord) =>  d.y2    ]  })  ]}, data)
```

Loading...

## Orientation [](#orientation "Direct link to Orientation")

_Stacked Bar_ supports horizontal and vertical orientation.

`orientation :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisStackedBar orientation="horizontal" x={x} y={y}/>
```

```
<vis-stacked-bar  orientation="horizontal"   [x]="x"   [y]="y"></vis-stacked-bar>
```

```
<VisStackedBar orientation="horizontal" {x} {y}/>
```

```
<VisStackedBar orientation="horizontal" :x="x" :y="y" />
```

```
<VisStackedBar orientation="horizontal" x={x} y={y}/>
```

```
const stackedBar = new StackedBar<DataRecord>({ orientation: "horizontal", x, y })
```

Loading...

## Rounded Corners [](#rounded-corners "Direct link to Rounded Corners")

You can apply rounded corners to the top bar in your _Stacked Bar_ component using the `roundedCorners` property, which accepts either a `number` (in pixels) or `boolean` argument.

`roundedCorners :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisStackedBar roundedCorners={true} x={x} y={y}/>
```

```
<vis-stacked-bar  [roundedCorners]="true"   [x]="x"   [y]="y"></vis-stacked-bar>
```

```
<VisStackedBar roundedCorners={true} {x} {y}/>
```

```
<VisStackedBar :roundedCorners="true" :x="x" :y="y" />
```

```
<VisStackedBar roundedCorners={true} x={x} y={y}/>
```

```
const stackedBar = new StackedBar<DataRecord>({ roundedCorners: true, x, y })
```

Loading...

## Bar Color [](#bar-color "Direct link to Bar Color")

Set the color of each bar by assigning the color property to a color string, a color accessor function or an array of color strings.

### Stacked Bars [](#stacked-bars "Direct link to Stacked Bars")

For stacked data, use an array of values or a single callback function.

```
// Either of these workconst colors = ['red', 'green', 'blue']const color = (d: DataRecord, i: number) => ['red', 'green', 'blue'][i]
```

Loading...

### Non-Stacked Bars [](#non-stacked-bars "Direct link to Non-Stacked Bars")

If you want non-stacked data (i.e. single bars) to display variable colors, you can use a single color accessor. The following sets the color based on the value of y:

```
const color = (d: DataRecord) => d.y > 7 ? '#FF4F4E' : '#1acb9a'}
```

Loading...

## Bar Sizing [](#bar-sizing "Direct link to Bar Sizing")

### Bar Width [](#bar-width "Direct link to Bar Width")

By default, the width of the bars is calculated automatically based on their count. But you can also strictly set the bar's width in pixels using the barWidth property:

`barWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisStackedBar barWidth={5} x={x} y={y}/>
```

```
<vis-stacked-bar [barWidth]="5" [x]="x" [y]="y"></vis-stacked-bar>
```

```
<VisStackedBar barWidth={5} {x} {y}/>
```

```
<VisStackedBar :barWidth="5" :x="x" :y="y" />
```

```
<VisStackedBar barWidth={5} x={x} y={y}/>
```

```
const stackedBar = new StackedBar<DataRecord>({ barWidth: 5, x, y })
```

Loading...

### Limiting Dynamic Bar Width [](#limiting-dynamic-bar-width "Direct link to Limiting Dynamic Bar Width")

When you don't know the number of bars in advance, and you're relying on automatic bar width calculation, you might want to limit the maximum bar width to prevent the bars from being too wide when there are just a few of them. That can be achieved by setting the barMaxWidth property.

### Bar Padding [](#bar-padding "Direct link to Bar Padding")

Another way to control the bar's width is by changing the barPadding property, which specifies how much of the available sector should be empty, in the range of [0,1).

`barPadding :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisStackedBar barPadding={0.5} x={x} y={y}/>
```

```
<vis-stacked-bar [barPadding]="0.5" [x]="x" [y]="y"></vis-stacked-bar>
```

```
<VisStackedBar barPadding={0.5} {x} {y}/>
```

```
<VisStackedBar :barPadding="0.5" :x="x" :y="y" />
```

```
<VisStackedBar barPadding={0.5} x={x} y={y}/>
```

```
const stackedBar = new StackedBar<DataRecord>({ barPadding: 0.5, x, y })
```

Loading...

### Minimum Bar Height [](#minimum-bar-height "Direct link to Minimum Bar Height")

When you have highly scattered data with very low and high values, the bars corresponding to the lower values can be so small, so they become invisible. If you want to prevent that you can set the minimum bar height to 1 pixel using the `barMinHeight1Px` boolean property.

`barMinHeight1Px :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisStackedBar barMinHeight1Px={undefined} x={x} y={y}/>
```

```
<vis-stacked-bar  [barMinHeight1Px]="undefined"   [x]="x"   [y]="y"></vis-stacked-bar>
```

```
<VisStackedBar barMinHeight1Px={undefined} {x} {y}/>
```

```
<VisStackedBar :barMinHeight1Px="undefined" :x="x" :y="y" />
```

```
<VisStackedBar barMinHeight1Px={undefined} x={x} y={y}/>
```

```
const stackedBar = new StackedBar<DataRecord>({ barMinHeight1Px: undefined, x, y })
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
<VisStackedBar x={x} y={y}/>
```

```
<vis-stacked-bar [x]="x" [y]="y"></vis-stacked-bar>
```

```
<VisStackedBar {x} {y}/>
```

```
<VisStackedBar :x="x" :y="y" />
```

```
<VisStackedBar x={x} y={y}/>
```

```
const stackedBar = new StackedBar<DataRecord>({ x, y })
```

Loading...

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisStackedBar x={x} y={y} dataStep={0.1}/>
```

```
<vis-stacked-bar [x]="x" [y]="y" [dataStep]="0.1"></vis-stacked-bar>
```

```
<VisStackedBar {x} {y} dataStep={0.1}/>
```

```
<VisStackedBar :x="x" :y="y" :dataStep="0.1" />
```

```
<VisStackedBar x={x} y={y} dataStep={0.1}/>
```

```
const stackedBar = new StackedBar<DataRecord>({ x, y, dataStep: 0.1 })
```

Loading...

## Ordinal Data [](#ordinal-data "Direct link to Ordinal Data")

Read our guide about using ordinal/categorical values with _XY Components_ here

## Events [](#events "Direct link to Events")

```
import { StackedBar } from '@unovis/ts'...events = {    [StackedBar.selectors.bar]: {        click: (d: DataRecord) => {},        ...    },    [StackedBar.selectors.barGroup]: {        mouseover: (d: DataRecord[]) => {},        ...    },}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisStackedBar x={x} y={y} events={events}/>
```

```
<vis-stacked-bar [x]="x" [y]="y" [events]="events"></vis-stacked-bar>
```

```
<VisStackedBar {x} {y} {events}/>
```

```
<VisStackedBar :x="x" :y="y" :events="events" />
```

```
<VisStackedBar x={x} y={y} events={events}/>
```

```
const stackedBar = new StackedBar<DataRecord>({ x, y, events })
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Stacked Bar_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.custom-stacked-bar {  --vis-stacked-bar-stroke-color: #000;  --vis-stacked-bar-stroke-width: 5px;  --vis-stacked-bar-hover-stroke-width: 10px;  --vis-stacked-bar-hover-stroke-color: #8777d9;}
```

Loading...

<details>

<summary>Supported CSS variables and their default values</summary>



```
--vis-stacked-bar-cursor: default;--vis-stacked-bar-fill-color: var(--vis-color-main);--vis-stacked-bar-stroke-color: none;--vis-stacked-bar-stroke-width: 0px;--vis-stacked-bar-hover-stroke-width: none;--vis-stacked-bar-hover-stroke-color: none; /* Dark Theme */--vis-dark-stacked-bar-stroke-color: none;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |