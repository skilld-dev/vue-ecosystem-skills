---
title: "Tips and Tricks | Unovis"
meta:
  "og:description": "Power user tricks"
  "og:title": "Tips and Tricks | Unovis"
  description: "Power user tricks"
---

## Custom Fills with SVG `defs`[](#custom-fills-with-svg-defs "Direct link to custom-fills-with-svg-defs")

If you want to custom SVG definitions available for your components, you can use the `svgDefs` property on the container, like this:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisArea } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const svgDefs = \`    <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  \`  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer svgDefs={svgDefs} data={data}>      <VisArea x={x} y={y} color="url(#gradient)"/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  svgDefs = \`    <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  \`  x = (d: DataRecord) =>  d.x  y = (d: DataRecord) =>  d.y}
```

template.html

```
<vis-xy-container [svgDefs]="svgDefs" [data]="data">  <vis-area [x]="x" [y]="y" color="url(#gradient)"></vis-area></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisArea } from '@unovis/svelte'  export let data: DataRecord[]  const svgDefs = \`    <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  \`  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y</script><VisXYContainer {svgDefs} {data}>  <VisArea {x} {y} color="url(#gradient)"/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisArea } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const svgDefs = \`    <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  \`const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.y</script><template>  <VisXYContainer :svgDefs="svgDefs" :data="data">    <VisArea :x="x" :y="y" color="url(#gradient)" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisArea } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const svgDefs = \`    <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  \`  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer svgDefs={svgDefs} data={data()}>      <VisArea x={x} y={y} color="url(#gradient)"/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Area } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  svgDefs: \`    <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  \`,   components: [    new Area<DataRecord>({    x: (d: DataRecord) =>  d.x,     y: (d: DataRecord) =>  d.y,     color: "url(#gradient)"  })  ]}, data)
```

Loading...

note

Alternatively, you can define any defs you want to use in an SVG element on the same page.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisArea ... color="url(#gradient)"/><svg>  <defs>       <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  </defs></svg>
```

```
<vis-area ... color="url(#gradient)"></vis-area><svg>  <defs>       <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  </defs></svg>
```

```

```

```

```

```

```

```
const chart = new Area({... color: "url(#gradient)"})document.getElementById('container').insertAdjacentHTML(\`<svg>  <defs>       <linearGradient id="gradient" gradientTransform="rotate(90)">      <stop offset="20%" stop-color="#051937" />      <stop offset="40%" stop-color="#004d7a" />      <stop offset="60%" stop-color="#008793" />      <stop offset="80%" stop-color="#00bf72" />    </linearGradient>  </defs></svg>\`)
```

## Displaying Ordinal Values [](#displaying-ordinal-values "Direct link to Displaying Ordinal Values")

We don't natively support the ordinal scale for XY components, but it can still be achieved with some small tweaks.

- In your _XY Component_, provide the `x` property _NumericAccessor_ that returns the data index.

```
const x = (d: DataRecord, i: number) => i
```

- In your _Axis_ component, provide the `tickFormat` property with a _StringAccessor_ that returns your value. Two common configurations are:

**Case 1**: When your data is an array of objects containing your ordinal property:

```
const tickFormat = (tick: number) => data[tick].category
```

**Case 2**: Your ordinal values are explicitly defined as an array of strings:

```
const categories = ['A', 'B', 'C', 'D', 'E']const tickFormat = (tick: number) => categories[tick]
```

When we apply these adjustments to a basic _Stacked Bar_ chart with an _X Axis_ component, the result looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="x" tickFormat={tickFormat}/>  <VisStackedBar x={x} y={y}/></VisXYContainer>
```

template.html

```
<vis-xy-container [data]="data">  <vis-axis type="x" [tickFormat]="tickFormat"></vis-axis>  <vis-stacked-bar [x]="x" [y]="y"></vis-stacked-bar></vis-xy-container>
```

component.svelte

```
<VisXYContainer {data}>  <VisAxis type="x" {tickFormat}/>  <VisStackedBar {x} {y}/></VisXYContainer>
```

component.vue

```
<VisXYContainer :data="data">  <VisAxis type="x" :tickFormat="tickFormat" />  <VisStackedBar :x="x" :y="y" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="x" tickFormat={tickFormat}/>  <VisStackedBar x={x} y={y}/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  xAxis: new Axis({ type: "x", tickFormat }),   components: [new StackedBar({ x, y })]}, data)
```

Loading...