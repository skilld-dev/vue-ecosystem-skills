---
title: "Timeline | Unovis"
meta:
  "og:description": "Learn how to configure a Timeline chart"
  "og:title": "Timeline | Unovis"
  description: "Learn how to configure a Timeline chart"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The _Timeline_ component has been designed to work together with _XY Container_. The minimal _Timeline_ configuration looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisTimeline } from '@unovis/react'function Component(props) {  const data: TimeDataRecord[] = props.data  const x = (d: TimeDataRecord) =>  d.timestamp  return (    <VisXYContainer data={data}>      <VisTimeline x={x}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: TimeDataRecord[];  x = (d: TimeDataRecord) =>  d.timestamp}
```

template.html

```
<vis-xy-container [data]="data">  <vis-timeline [x]="x"></vis-timeline></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisTimeline } from '@unovis/svelte'  export let data: TimeDataRecord[]  const x = (d: TimeDataRecord) =>  d.timestamp</script><VisXYContainer {data}>  <VisTimeline {x}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisTimeline } from '@unovis/vue'const props = defineProps<{ data: TimeDataRecord[] }>()const x = (d: TimeDataRecord) =>  d.timestamp</script><template>  <VisXYContainer :data="data">    <VisTimeline :x="x" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisTimeline } from '@unovis/solid'function Component(props) {  const data: TimeDataRecord[] = () => props.data  const x = (d: TimeDataRecord) =>  d.timestamp  return (    <VisXYContainer data={data()}>      <VisTimeline x={x}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Timeline } from '@unovis/ts'import { data, TimeDataRecord } from './data'const container = new XYContainer<TimeDataRecord>(node, {  components: [    new Timeline<TimeDataRecord>({    x: (d: TimeDataRecord) =>  d.timestamp  })  ]}, data)
```

Loading...

where `TimeDataRecord` has at least the following properties:

```
type TimeDataRecord = {  timestamp: Date; // Position on the X axis. Can be \`number\` or \`Date\`  length: number; // Length of the line in X axis values, i.e. milliseconds if you use \`Date\`  type: string; // The row it will be displayed in}
```

note

By default, if the records in your data array contain `length` and `type` properties (as shown above), _Timeline_ will only need the `x` accessor provided to display the data. Otherwise, you can explicitly define accessor functions for `length` and `type`.

## Labels [](#labels "Direct link to Labels")

Enable the `showLabels` property to display row types along the **vertical** axis. You can alter the appearance of these labels with the `labelWidth` and `maxLabelWidth` properties.

Like other XY components, labeling data along the **horizontal** axis can be accomplished by adding an _Axis_ component to your container. See following example which displays labeled _Timeline_ alongside a labeled _X Axis_:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="x" tickFormat={tickFormat}/>  <VisTimeline x={x} showLabels={true}/></VisXYContainer>
```

template.html

```
<vis-xy-container [data]="data">  <vis-axis type="x" [tickFormat]="tickFormat"></vis-axis>  <vis-timeline [x]="x" [showLabels]="true"></vis-timeline></vis-xy-container>
```

component.svelte

```
<VisXYContainer {data}>  <VisAxis type="x" {tickFormat}/>  <VisTimeline {x} showLabels={true}/></VisXYContainer>
```

component.vue

```
<VisXYContainer :data="data">  <VisAxis type="x" :tickFormat="tickFormat" />  <VisTimeline :x="x" :showLabels="true" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="x" tickFormat={tickFormat}/>  <VisTimeline x={x} showLabels={true}/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<TimeDataRecord>(node, {  xAxis: new Axis({ type: "x", tickFormat }),   components: [new Timeline({ x, showLabels: true })]}, data)
```

Loading...

Note

Since _Timeline_ groups vertical data in an ordinal fashion, adding a Y axis here is not recommended.

## Row Configuration [](#row-configuration "Direct link to Row Configuration")

### Alternating row colors [](#alternating-row-colors "Direct link to Alternating row colors")

For easier readability, each row's background color alternates among two colors by default. To display a single background color across all rows, disable the `alternatingRowColors` property:

`alternatingRowColors :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTimeline alternatingRowColors={true} x={x}/>
```

```
<vis-timeline [alternatingRowColors]="true" [x]="x"></vis-timeline>
```

```
<VisTimeline alternatingRowColors={true} {x}/>
```

```
<VisTimeline :alternatingRowColors="true" :x="x" />
```

```
<VisTimeline alternatingRowColors={true} x={x}/>
```

```
const timeline = new Timeline<TimeDataRecord>({ alternatingRowColors: true, x })
```

Loading...

### Row Height [](#row-height "Direct link to Row Height")

Use the `rowHeight` property to adjust the size of each row.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTimeline x={x} rowHeight={50}/>
```

```
<vis-timeline [x]="x" [rowHeight]="50"></vis-timeline>
```

```
<VisTimeline {x} rowHeight={50}/>
```

```
<VisTimeline :x="x" :rowHeight="50" />
```

```
<VisTimeline x={x} rowHeight={50}/>
```

```
const timeline = new Timeline<TimeDataRecord>({ x, rowHeight: 50 })
```

Loading...

## Line Configuration [](#line-configuration "Direct link to Line Configuration")

### Line Cap [](#line-cap "Direct link to Line Cap")

By default, lines have squared ends. You can give your lines a rounded appearance by setting `lineCap` property to `true`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTimeline x={x} lineCap={true}/>
```

```
<vis-timeline [x]="x" [lineCap]="true"></vis-timeline>
```

```
<VisTimeline {x} lineCap={true}/>
```

```
<VisTimeline :x="x" :lineCap="true" />
```

```
<VisTimeline x={x} lineCap={true}/>
```

```
const timeline = new Timeline<TimeDataRecord>({ x, lineCap: true })
```

Loading...

### Showing empty segments [](#showing-empty-segments "Direct link to Showing empty segments")

Set `showEmptySegments` to `true` if you want to display lines that are `undefined` or too small to see.

`showEmptySegments :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTimeline showEmptySegments={true} x={x} lineCap={true}/>
```

```
<vis-timeline  [showEmptySegments]="true"   [x]="x"   [lineCap]="true"></vis-timeline>
```

```
<VisTimeline showEmptySegments={true} {x} lineCap={true}/>
```

```
<VisTimeline :showEmptySegments="true" :x="x" :lineCap="true" />
```

```
<VisTimeline showEmptySegments={true} x={x} lineCap={true}/>
```

```
const timeline = new Timeline<TimeDataRecord>({  showEmptySegments: true,   x,   lineCap: true})
```

Loading...

#### Empty segments positioning [](#empty-segments-positioning "Direct link to Empty segments positioning")

When both `showEmptySegments` and `lineCap` are set to `true`, you can control the positioning of small segments using the `showEmptySegmentsCorrectPosition` property. When set to `true` (default), small segments will be centered at their actual position. When set to `false`, small segments will be aligned to the left of their position.

`showEmptySegmentsCorrectPosition :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTimeline  showEmptySegmentsCorrectPosition={true}   x={x}   lineCap={true}   showEmptySegments={true}/>
```

```
<vis-timeline  [showEmptySegmentsCorrectPosition]="true"   [x]="x"   [lineCap]="true"   [showEmptySegments]="true"></vis-timeline>
```

```
<VisTimeline  showEmptySegmentsCorrectPosition={true}   {x}   lineCap={true}   showEmptySegments={true}/>
```

```
<VisTimeline  :showEmptySegmentsCorrectPosition="true"   :x="x"   :lineCap="true"   :showEmptySegments="true" />
```

```
<VisTimeline  showEmptySegmentsCorrectPosition={true}   x={x}   lineCap={true}   showEmptySegments={true}/>
```

```
const timeline = new Timeline<TimeDataRecord>({  showEmptySegmentsCorrectPosition: true,   x,   lineCap: true,   showEmptySegments: true})
```

Loading...

### Line Width [](#line-width "Direct link to Line Width")

You can also change the line thickness with the `lineWidth` property, which determines how much vertical space each _Timeline_ item occupies.

### Example: Custom timeline lines [](#example-custom-timeline-lines "Direct link to Example: Custom timeline lines")

`lineWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTimeline lineWidth={10} x={x} rowHeight={100}/>
```

```
<vis-timeline  [lineWidth]="10"   [x]="x"   [rowHeight]="100"></vis-timeline>
```

```
<VisTimeline lineWidth={10} {x} rowHeight={100}/>
```

```
<VisTimeline :lineWidth="10" :x="x" :rowHeight="100" />
```

```
<VisTimeline lineWidth={10} x={x} rowHeight={100}/>
```

```
const timeline = new Timeline<TimeDataRecord>({ lineWidth: 10, x, rowHeight: 100 })
```

Loading...

## Events [](#events "Direct link to Events")

### Scrolling [](#scrolling "Direct link to Scrolling")

You can provide a callback to the `onScroll` property, which accepts a function of type:

```
type onScroll = (n: number) => void
```

where _n_ is equal to the distance scrolled from the top of the timeline (in pixels).

See the following example, where `onScroll` updates the xAxis label:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: TimeDataRecord[] = props.data  const onScroll = (n: number) => setAxisLabel(\`${n}px from the top\`)  const x = (d: TimeDataRecord) =>  d.timestamp  return (    <VisTimeline x={x} onScroll={onScroll}/>  )}
```

component.ts

```
@Component({  template: '<vis-timeline [x]="x" [onScroll]="onScroll"></vis-timeline>'})export class Component {  @Input data: TimeDataRecord[];  onScroll = (n: number) => setAxisLabel(\`${n}px from the top\`)  x = (d: TimeDataRecord) =>  d.timestamp}
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisTimeline } from '@unovis/svelte'  export let data: TimeDataRecord[]  const onScroll = (n: number) => setAxisLabel(\`${n}px from the top\`)  const x = (d: TimeDataRecord) =>  d.timestamp</script><VisTimeline {x} {onScroll}/>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisTimeline } from '@unovis/vue'const props = defineProps<{ data: TimeDataRecord[] }>()const onScroll = (n: number) => setAxisLabel(\`${n}px from the top\`)const x = (d: TimeDataRecord) =>  d.timestamp</script><template>  <VisTimeline :x="x" :onScroll="onScroll" /></template>
```

component.tsx

```
function Component(props) {  const data: TimeDataRecord[] = () => props.data  const onScroll = (n: number) => setAxisLabel(\`${n}px from the top\`)  const x = (d: TimeDataRecord) =>  d.timestamp  return (    <VisTimeline x={x} onScroll={onScroll}/>  )}
```

component.ts

```
const timeline = new Timeline<TimeDataRecord>({  x: (d: TimeDataRecord) =>  d.timestamp,   onScroll: (n: number) => setAxisLabel(\`${n}px from the top\`)})
```

Loading...

### Custom cursor for hover events [](#custom-cursor-for-hover-events "Direct link to Custom cursor for hover events")

You can set custom cursor when hovering over a line. However, it'll only be active if you've defined events for `[Timeline.selectors.line]`:

### More Events [](#more-events "Direct link to More Events")

```
import { Timeline } from '@unovis/ts'const events = {  [Timeline.selectors.background]: {    wheel: () => { ... },  },  [Timeline.selectors.line]: {    click: () => { ... },  }  [Timeline.selectors.label]: {    mouseover: () => { ... }  }}
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Timeline_ component supports additional styling via CSS variables:

<details>

<summary>All supported CSS variables</summary>



```
--vis-timeline-row-even-fill-color: #FFFFFF;--vis-timeline-row-odd-fill-color: #F7FAFC;--vis-timeline-row-background-opacity: 1;--vis-timeline-scrollbar-background-color: #E6E9F3;--vis-timeline-scrollbar-color: #9EA7B8; --vis-timeline-label-font-size: 12px;--vis-timeline-label-color: #6C778C; --vis-timeline-cursor: default;--vis-timeline-line-color: var(--vis-color-main);--vis-timeline-line-stroke-width: 0; /* The line stroke color variable is not defined by default *//* to allow it to fallback to the corresponding row background color *//* --vis-timeline-line-stroke-color: none; */ /* Dark Theme */--vis-dark-timeline-row-even-fill-color: #292B34;--vis-dark-timeline-row-odd-fill-color: #333742;--vis-dark-timeline-scrollbar-background-color: #292B34;--vis-dark-timeline-scrollbar-color: #6C778C;--vis-dark-timeline-label-color: #EFF5F8;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |