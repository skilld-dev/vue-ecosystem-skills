---
title: "Crosshair | Unovis"
meta:
  "og:description": "Basic Configuration"
  "og:title": "Crosshair | Unovis"
  description: "Basic Configuration"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The _Crosshair_ component is a special tooltip designed to work in an _XYContainer_. When a user is interacting with the _XYContainer_ and a crosshair is provided, the _Crosshair_ will appear as a vertical line and render circles on the corresponding `y` values in the dataset.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisLine, VisAxis, VisAxis, VisCrosshair } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const padding = {    top: 5,    bottom: 5  }  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  return (    <VisXYContainer padding={padding} data={data}>      <VisLine x={x} y={y}/>      <VisAxis type="x"/>      <VisAxis type="y"/>      <VisCrosshair/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  padding = {    top: 5,    bottom: 5  }  x = (d: DataRecord) =>  d.x  y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]}
```

template.html

```
<vis-xy-container [padding]="padding" [data]="data">  <vis-line [x]="x" [y]="y"></vis-line>  <vis-axis type="x"></vis-axis>  <vis-axis type="y"></vis-axis>  <vis-crosshair></vis-crosshair></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisLine, VisAxis, VisAxis, VisCrosshair } from '@unovis/svelte'  export let data: DataRecord[]  const padding = {    top: 5,    bottom: 5  }  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]</script><VisXYContainer {padding} {data}>  <VisLine {x} {y}/>  <VisAxis type="x"/>  <VisAxis type="y"/>  <VisCrosshair/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisLine, VisAxis, VisAxis, VisCrosshair } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const padding = {    top: 5,    bottom: 5  }const x = (d: DataRecord) =>  d.xconst y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]</script><template>  <VisXYContainer :padding="padding" :data="data">    <VisLine :x="x" :y="y" />    <VisAxis type="x" />    <VisAxis type="y" />    <VisCrosshair />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisLine, VisAxis, VisAxis, VisCrosshair } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const padding = {    top: 5,    bottom: 5  }  const x = (d: DataRecord) =>  d.x  const y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]  return (    <VisXYContainer padding={padding} data={data()}>      <VisLine x={x} y={y}/>      <VisAxis type="x"/>      <VisAxis type="y"/>      <VisCrosshair/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Line, Axis, Crosshair } from '@unovis/ts'import { data, DataRecord } from './data'const x = (d: DataRecord) =>  d.xconst y = [    (d: DataRecord) =>  d.y,    (d: DataRecord) =>  d.y1,    (d: DataRecord) =>  d.y2  ]const crosshair = new Crosshair<DataRecord>({ })const container = new XYContainer<DataRecord>(node, {  padding: {    top: 5,    bottom: 5  },   components: [new Line({ x, y })],   xAxis: new Axis({ type: "x" }),   yAxis: new Axis({ type: "y" }),   crosshair}, data)
```

Loading...

## X and Y accessors [](#x-and-y-accessors "Direct link to X and Y accessors")

Like other components in you can supply `x` and `y` accessors to the _Crosshair_ component to control where it appears in your container. There's also a dedicated `yStacked` property for dealing with stacked values.

By default, _Crosshair_ automatically takes the `x`, `y` and `yStacked` settings from _XYContainer_. But as soon as you manually specify any of them, the component will expect the rest to be provided as well. For example, if you supply the `x` accessor function to your crosshair you'll also have to supply the `y` or `yStacked` settings depending on your chart configuration.

See the following example which moves the position of the crosshair line to the right of each bar.

```
const x: ((d: DataRecord) => number) = d.x + 0.5const yStacked: ((d: DataRecord) => number)[] = [d => d.y, d => d.y1, d => d.y2]
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisCrosshair x={x} yStacked={yStacked}/>
```

```
<vis-crosshair [x]="x" [yStacked]="yStacked"></vis-crosshair>
```

```
<VisCrosshair {x} {yStacked}/>
```

```
<VisCrosshair :x="x" :yStacked="yStacked" />
```

```
<VisCrosshair x={x} yStacked={yStacked}/>
```

```
const crosshair = new Crosshair<DataRecord>({ x, yStacked })
```

Loading...

## Show/Hide Behavior [](#showhide-behavior "Direct link to Show/Hide Behavior")

By default, the _Crosshair_ component will render if the cursor is within a certain distance in pixels from a valid `x` value. You can disable this feature using the `hideWhenFarFromPointer` attribute.

`hideWhenFarFromPointer :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisCrosshair hideWhenFarFromPointer={true}/>
```

```
<vis-crosshair [hideWhenFarFromPointer]="true"></vis-crosshair>
```

```
<VisCrosshair hideWhenFarFromPointer={true}/>
```

```
<VisCrosshair :hideWhenFarFromPointer="true" />
```

```
<VisCrosshair hideWhenFarFromPointer={true}/>
```

```
const crosshair = new Crosshair<DataRecord>({ hideWhenFarFromPointer: true })
```

Loading...

#### `hideWhenFarFromPointerDistance`[](#hidewhenfarfrompointerdistance "Direct link to hidewhenfarfrompointerdistance")

Use the `hideWhenFarFromPointerDistance` attribute with a length (in pixels) that represents the minimum horizontal distance the cursor must be from a datapoint before hiding.

`hideWhenFarFromPointerDistance :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisCrosshair hideWhenFarFromPointerDistance={50}/>
```

```
<vis-crosshair [hideWhenFarFromPointerDistance]="50"></vis-crosshair>
```

```
<VisCrosshair hideWhenFarFromPointerDistance={50}/>
```

```
<VisCrosshair :hideWhenFarFromPointerDistance="50" />
```

```
<VisCrosshair hideWhenFarFromPointerDistance={50}/>
```

```
const crosshair = new Crosshair<DataRecord>({ hideWhenFarFromPointerDistance: 50 })
```

Loading...

## Custom Color [](#custom-color "Direct link to Custom Color")

Provide a `string` or color accessor function to the `color` attribute to customize the crosshair's point color:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: DataRecord[] = props.data  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  return (    <VisCrosshair color={color}/>  )}
```

component.ts

```
@Component({  template: '<vis-crosshair [color]="color"></vis-crosshair>'})export class Component {  @Input data: DataRecord[];  color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]}
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisCrosshair } from '@unovis/svelte'  export let data: DataRecord[]  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]</script><VisCrosshair {color}/>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisCrosshair } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]</script><template>  <VisCrosshair :color="color" /></template>
```

component.tsx

```
function Component(props) {  const data: DataRecord[] = () => props.data  const color = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  return (    <VisCrosshair color={color}/>  )}
```

component.ts

```
const crosshair = new Crosshair<DataRecord>({  color: (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]})
```

Loading...

## Custom Stroke Color and Width [](#custom-stroke-color-and-width "Direct link to Custom Stroke Color and Width")

Provide values or accessor functions to the `strokeColor` and `strokeWidth` attributes to customize the crosshair's circle stroke color and width:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: DataRecord[] = props.data  const strokeColor = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  const strokeWidth = (d: DataRecord, i: number) =>  [1, 2, 3][i]  return (    <VisCrosshair      color="none"       strokeColor={strokeColor}       strokeWidth={strokeWidth}    />  )}
```

component.ts

```
@Component({  template: \`    <vis-crosshair      color="none"       [strokeColor]="strokeColor"       [strokeWidth]="strokeWidth"    ></vis-crosshair>  \`})export class Component {  @Input data: DataRecord[];  strokeColor = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  strokeWidth = (d: DataRecord, i: number) =>  [1, 2, 3][i]}
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisCrosshair } from '@unovis/svelte'  export let data: DataRecord[]  const strokeColor = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  const strokeWidth = (d: DataRecord, i: number) =>  [1, 2, 3][i]</script><VisCrosshair color="none" {strokeColor} {strokeWidth}/>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisCrosshair } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const strokeColor = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]const strokeWidth = (d: DataRecord, i: number) =>  [1, 2, 3][i]</script><template>  <VisCrosshair    color="none"     :strokeColor="strokeColor"     :strokeWidth="strokeWidth"   /></template>
```

component.tsx

```
function Component(props) {  const data: DataRecord[] = () => props.data  const strokeColor = (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i]  const strokeWidth = (d: DataRecord, i: number) =>  [1, 2, 3][i]  return (    <VisCrosshair      color="none"       strokeColor={strokeColor}       strokeWidth={strokeWidth}    />  )}
```

component.ts

```
const crosshair = new Crosshair<DataRecord>({  color: "none",   strokeColor: (d: DataRecord, i: number) =>  ['red', 'green', 'blue'][i],   strokeWidth: (d: DataRecord, i: number) =>  [1, 2, 3][i]})
```

Loading...

## Adding a Tooltip [](#adding-a-tooltip "Direct link to Adding a Tooltip")

You can render text content for your _Crosshair_ component by providing it with a `template` property and a _Tooltip_ component within the same container.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisScatter, VisTooltip, VisAxis, VisAxis, VisCrosshair } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const padding = {    top: 5,    bottom: 5  }  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  const template = (d: DataRecord) =>  [d.x, d.y].join(', ')  return (    <VisXYContainer padding={padding} data={data}>      <VisScatter x={x} y={y}/>      <VisTooltip/>      <VisAxis type="x"/>      <VisAxis type="y"/>      <VisCrosshair template={template}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  padding = {    top: 5,    bottom: 5  }  x = (d: DataRecord) =>  d.x  y = (d: DataRecord) =>  d.y  template = (d: DataRecord) =>  [d.x, d.y].join(', ')}
```

template.html

```
<vis-xy-container [padding]="padding" [data]="data">  <vis-scatter [x]="x" [y]="y"></vis-scatter>  <vis-tooltip></vis-tooltip>  <vis-axis type="x"></vis-axis>  <vis-axis type="y"></vis-axis>  <vis-crosshair [template]="template"></vis-crosshair></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisScatter, VisTooltip, VisAxis, VisAxis, VisCrosshair } from '@unovis/svelte'  export let data: DataRecord[]  const padding = {    top: 5,    bottom: 5  }  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  const template = (d: DataRecord) =>  [d.x, d.y].join(', ')</script><VisXYContainer {padding} {data}>  <VisScatter {x} {y}/>  <VisTooltip/>  <VisAxis type="x"/>  <VisAxis type="y"/>  <VisCrosshair {template}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisScatter, VisTooltip, VisAxis, VisAxis, VisCrosshair } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const padding = {    top: 5,    bottom: 5  }const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.yconst template = (d: DataRecord) =>  [d.x, d.y].join(', ')</script><template>  <VisXYContainer :padding="padding" :data="data">    <VisScatter :x="x" :y="y" />    <VisTooltip />    <VisAxis type="x" />    <VisAxis type="y" />    <VisCrosshair :template="template" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisScatter, VisTooltip, VisAxis, VisAxis, VisCrosshair } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const padding = {    top: 5,    bottom: 5  }  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  const template = (d: DataRecord) =>  [d.x, d.y].join(', ')  return (    <VisXYContainer padding={padding} data={data()}>      <VisScatter x={x} y={y}/>      <VisTooltip/>      <VisAxis type="x"/>      <VisAxis type="y"/>      <VisCrosshair template={template}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Scatter, Tooltip, Axis, Crosshair } from '@unovis/ts'import { data, DataRecord } from './data'const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.yconst crosshair = new Crosshair<DataRecord>({  template: (d: DataRecord) =>  [d.x, d.y].join(', ')})const container = new XYContainer<DataRecord>(node, {  padding: {    top: 5,    bottom: 5  },   components: [new Scatter({ x, y })],   tooltip: new Tooltip({ }),   xAxis: new Axis({ type: "x" }),   yAxis: new Axis({ type: "y" }),   crosshair}, data)
```

Loading...

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Crosshair_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.visualization-container-div {  --vis-crosshair-line-stroke-color: #f88080;  --vis-crosshair-circle-stroke-color: #000000;}
```

Loading...

<details>

<summary>All supported CSS variables and their default values</summary>



```
--vis-crosshair-line-stroke-color: #888;--vis-crosshair-line-stroke-width: 1px;--vis-crosshair-circle-stroke-color: #fff;--vis-crosshair-circle-stroke-width: 1px;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |