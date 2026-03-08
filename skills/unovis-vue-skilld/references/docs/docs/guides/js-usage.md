---
title: "JavaScript Usage | Unovis"
meta:
  "og:description": "Use with JavaScript"
  "og:title": "JavaScript Usage | Unovis"
  description: "Use with JavaScript"
---

### Using with TypeScript [](#using-with-typescript "Direct link to Using with TypeScript")

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import React, { useCallback } from 'react'import { VisXYContainer, VisLine, VisAxis } from '@unovis/react'type DataRecord = { x: number; y: number }const data: DataRecord[] = [  { x: 0, y: 0 },  { x: 1, y: 2 },  { x: 2, y: 1 },]export function BasicLineChart (): JSX.Element {  return (    <VisXYContainer data={data}>      <VisLine<DataRecord>        x={useCallback(d => d.x, [])}        y={useCallback(d => d.y, [])}      ></VisLine>      <VisAxis type="x"></VisAxis>      <VisAxis type="y"></VisAxis>    </VisXYContainer>  )}
```

component.ts

```
import { Component } from '@angular/core'type DataRecord = { x: number; y: number }@Component({  selector: 'basic-line-chart',  templateUrl: './basic-line-chart.component.html'})export class BasicLineChartComponent {  x = (d: DataRecord): number => d.x  y = (d: DataRecord): number => d.y  data: DataRecord[] = [    { x: 0, y: 0 },    { x: 1, y: 2 },    { x: 2, y: 1 },  ]}
```

template.html

```
<vis-xy-container>    <vis-line [data]="data" [x]="x" [y]="y"></vis-line>    <vis-axis type="x"></vis-axis>    <vis-axis type="y"></vis-axis></vis-xy-container>
```

component.svelte

```
<script lang="ts">  import { VisXYContainer, VisLine, VisAxis } from '@unovis/svelte'  type DataRecord = { x: number, y: number }  export let data: DataRecord[] = [    { x: 0, y: 0 },    { x: 1, y: 2 },    { x: 2, y: 1 },  ]</script><VisXYContainer>  <VisLine {data} x={d => d.x} y={d => d.y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">  import { VisXYContainer, VisLine, VisAxis } from '@unovis/vue'  import { ref } from 'vue'  type DataRecord = { x: number, y: number }  const data = ref<DataRecord[]>([    { x: 0, y: 0 },    { x: 1, y: 2 },    { x: 2, y: 1 },  ])</script><VisXYContainer>  <VisLine :data="data" :x="d => d.x" :y="d => d.y" />  <VisAxis type="x" />  <VisAxis type="y" /></VisXYContainer>
```

component.tsx

```
import { VisXYContainer, VisLine, VisAxis } from '@unovis/solid'type DataRecord = { x: number; y: number }const data: DataRecord[] = [  { x: 0, y: 0 },  { x: 1, y: 2 },  { x: 2, y: 1 },]const BasicLineChart = () => {  return (    <VisXYContainer height='50dvh'>      <VisLine data={data} x={(d) => d.x} y={(d) => d.y} />      <VisAxis type='x' />      <VisAxis type='y' />    </VisXYContainer>  )}export default BasicLineChart
```

component.ts

```
import { Axis, Line, XYContainer } from '@unovis/ts'type DataRecord = { x: number; y: number }const data: DataRecord[] = [  { x: 0, y: 0 },  { x: 1, y: 2 },  { x: 2, y: 1 },]const line = new Line<DataRecord>({  x: d => d.x,  y: d => d.y,})const container = document.getElementById('vis-container')const chart = new XYContainer(container, {  components: [line],  xAxis: new Axis(),  yAxis: new Axis(),}, data)
```

### Using with JavaScript [](#using-with-javascript "Direct link to Using with JavaScript")

- React
- Angular
- Svelte
- Vue
- Solid
- JavaScript

component.tsx

```
import React, { useCallback } from 'react'import { VisXYContainer, VisLine, VisAxis } from '@unovis/react'const data = [  { x: 0, y: 0 },  { x: 1, y: 2 },  { x: 2, y: 1 },]export function BasicLineChart (){  return (    <VisXYContainer data={data}>      <VisLine        x={useCallback(d => d.x, [])}        y={useCallback(d => d.y, [])}      ></VisLine>      <VisAxis type="x"></VisAxis>      <VisAxis type="y"></VisAxis>    </VisXYContainer>  )}
```

component.ts

```
import { Component } from '@angular/core'@Component({  selector: 'basic-line-chart',  templateUrl: './basic-line-chart.component.html'})export class BasicLineChartComponent {  x = d => d.x  y = d => d.y  data = [    { x: 0, y: 0 },    { x: 1, y: 2 },    { x: 2, y: 1 },  ]}
```

template.html

```
<vis-xy-container>    <vis-line [data]="data" [x]="x" [y]="y"></vis-line>    <vis-axis type="x"></vis-axis>    <vis-axis type="y"></vis-axis></vis-xy-container>
```

component.svelte

```
<script>  import { VisXYContainer, VisLine, VisAxis } from '@unovis/svelte'  export let data = [    { x: 0, y: 0 },    { x: 1, y: 2 },    { x: 2, y: 1 },  ]</script><VisXYContainer>  <VisLine {data} x={d => d.x} y={d => d.y}/>  <VisAxis type="x"/>  <VisAxis type="y"/></VisXYContainer>
```

component.vue

```
<script setup>  import { VisXYContainer, VisLine, VisAxis } from '@unovis/vue'  import { ref } from 'vue'  const data = ref([    { x: 0, y: 0 },    { x: 1, y: 2 },    { x: 2, y: 1 },  ])</script><VisXYContainer>  <VisLine :data="data" :x="d => d.x" :y="d => d.y" />  <VisAxis type="x" />  <VisAxis type="y" /></VisXYContainer>
```

component.tsx

```
import { VisXYContainer, VisLine, VisAxis } from '@unovis/solid'const data = [  { x: 0, y: 0 },  { x: 1, y: 2 },  { x: 2, y: 1 },]const BasicLineChart = () => {  return (    <VisXYContainer height='50dvh'>      <VisLine data={data} x={(d) => d.x} y={(d) => d.y} />      <VisAxis type='x' />      <VisAxis type='y' />    </VisXYContainer>  )}export default BasicLineChart
```

component.js

```
import { Axis, Line, XYContainer } from '@unovis/ts'const data = [  { x: 0, y: 0 },  { x: 1, y: 2 },  { x: 2, y: 1 },]const line = new Line({  x: d => d.x,  y: d => d.y,})const container = document.getElementById('vis-container')const chart = new XYContainer(container, {  components: [line],  xAxis: new Axis(),  yAxis: new Axis(),}, data)
```