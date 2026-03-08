---
title: "Brush | Unovis"
meta:
  "og:description": "Basic Configuration"
  "og:title": "Brush | Unovis"
  description: "Basic Configuration"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

_Brush_ is designed to work inside an _XYContainer_ alongside an _XYChart_. The basic configuration looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisArea, VisBrush } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data}>      <VisArea x={x} y={y}/>      <VisBrush/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = (d: DataRecord) =>  d.y}
```

template.html

```
<vis-xy-container [data]="data">  <vis-area [x]="x" [y]="y"></vis-area>  <vis-brush></vis-brush></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisArea, VisBrush } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y</script><VisXYContainer {data}>  <VisArea {x} {y}/>  <VisBrush/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisArea, VisBrush } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.y</script><template>  <VisXYContainer :data="data">    <VisArea :x="x" :y="y" />    <VisBrush />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisArea, VisBrush } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer data={data()}>      <VisArea x={x} y={y}/>      <VisBrush/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Area, Brush } from '@unovis/ts'import { data, DataRecord } from './data'const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.yconst brush = new Brush<DataRecord>({ })const container = new XYContainer<DataRecord>(node, {  components: [brush, new Area({ x, y })]}, data)
```

Loading...

## Usage [](#usage "Direct link to Usage")

The _Brush_ component has four event listener properties:

- `onBrushStart`
- `onBrushMove`
- `onBrushEnd`
- `onBrush`, which encapsulates all the above.

Each callback has the following parameters:

- _selection_: type `[number, number]`, the range of data current being displayed
- _event_ - the brush event instance
- _userDriven_: type `boolean`, to indicate whether the event was triggered by the user

## Selections [](#selections "Direct link to Selections")

### Manual Selection [](#manual-selection "Direct link to Manual Selection")

You can explicitly define the default selection range using the `selection` property:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBrush selection={[3,6]}/>
```

```
<vis-brush [selection]="[3,6]"></vis-brush>
```

```
<VisBrush selection={[3,6]}/>
```

```
<VisBrush :selection="[3,6]" />
```

```
<VisBrush selection={[3,6]}/>
```

```
const brush = new Brush<DataRecord>({ selection: [3,6] })
```

Loading...

### Selection Min Length [](#selection-min-length "Direct link to Selection Min Length")

You can set a constraint for the minimum `selection` value with the `selectionMinLength` property:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBrush selectionMinLength={5}/>
```

```
<vis-brush [selectionMinLength]="5"></vis-brush>
```

```
<VisBrush selectionMinLength={5}/>
```

```
<VisBrush :selectionMinLength="5" />
```

```
<VisBrush selectionMinLength={5}/>
```

```
const brush = new Brush<DataRecord>({ selectionMinLength: 5 })
```

Loading...

### Draggable [](#draggable "Direct link to Draggable")

By default, setting the desired the range relies on moving both start and end _Brush_ handles. You can adjust the entire range with one click by enabling the `draggable` proprerty:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBrush selectionMinLength={2} selection={[3,6]} draggable={true}/>
```

```
<vis-brush  [selectionMinLength]="2"   [selection]="[3,6]"   [draggable]="true"></vis-brush>
```

```
<VisBrush selectionMinLength={2} selection={[3,6]} draggable={true}/>
```

```
<VisBrush  :selectionMinLength="2"   :selection="[3,6]"   :draggable="true" />
```

```
<VisBrush selectionMinLength={2} selection={[3,6]} draggable={true}/>
```

```
const brush = new Brush<DataRecord>({  selectionMinLength: 2,   selection: [3,6],   draggable: true})
```

Loading...

## Brush Appearance [](#brush-appearance "Direct link to Brush Appearance")

### Handle Position [](#handle-position "Direct link to Handle Position")

`handlePosition` changes the placement of the _Brush_ handle with respect to the _XYChart_.

`handlePosition :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBrush handlePosition="outside"/>
```

```
<vis-brush handlePosition="outside"></vis-brush>
```

```
<VisBrush handlePosition="outside"/>
```

```
<VisBrush handlePosition="outside" />
```

```
<VisBrush handlePosition="outside"/>
```

```
const brush = new Brush<DataRecord>({ handlePosition: "outside" })
```

Loading...

### Handle Width [](#handle-width "Direct link to Handle Width")

`handleWidth` sets the width in pixels of the _Brush_'s handle:

`handleWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBrush handleWidth={20}/>
```

```
<vis-brush [handleWidth]="20"></vis-brush>
```

```
<VisBrush handleWidth={20}/>
```

```
<VisBrush :handleWidth="20" />
```

```
<VisBrush handleWidth={20}/>
```

```
const brush = new Brush<DataRecord>({ handleWidth: 20 })
```

Loading...

### Selection [](#selection "Direct link to Selection")

You can change the appearance of the selection by changing the corresponding CSS variables. For example, here's how you can modify the appearance of the selected and unselected areas:

```
--vis-brush-selection-fill-color: #0b1640;--vis-brush-selection-opacity: 0.6;--vis-brush-unselected-fill-color: #fff;--vis-brush-unselected-opacity: 0.9;
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBrush selection={[2,5]}/>
```

```
<vis-brush [selection]="[2,5]"></vis-brush>
```

```
<VisBrush selection={[2,5]}/>
```

```
<VisBrush :selection="[2,5]" />
```

```
<VisBrush selection={[2,5]}/>
```

```
const brush = new Brush<DataRecord>({ selection: [2,5] })
```

Loading...

## CSS Variables [](#css-variables "Direct link to CSS Variables")

<details>

<summary>Supported CSS variables and their default values</summary>



```
--vis-brush-selection-fill-color: none;--vis-brush-selection-stroke-color: none;--vis-brush-selection-stroke-width: 0;--vis-brush-selection-opacity: 0;--vis-brush-unselected-fill-color: #0b1640;--vis-brush-unselected-stroke-color: #acb2b9;--vis-brush-unselected-stroke-width: 0;--vis-brush-unselected-opacity: 0.4;--vis-brush-handle-fill-color: #6d778c;--vis-brush-handle-stroke-color: #eee;--vis-dark-brush-selection-fill-color: none;--vis-dark-brush-selection-stroke-color: none;--vis-dark-brush-selection-stroke-width: 0;--vis-dark-brush-selection-opacity: 0;--vis-dark-brush-unselected-fill-color: #acb2b9;--vis-dark-brush-unselected-stroke-color: #0b1640;--vis-dark-brush-unselected-stroke-width: 0;--vis-dark-brush-unselected-opacity: 0.4;--vis-dark-brush-handle-fill-color: #acb2b9;--vis-dark-brush-handle-stroke-color: var(--vis-color-grey);
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |