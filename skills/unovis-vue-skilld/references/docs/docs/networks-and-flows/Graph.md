---
title: "Graph | Unovis"
meta:
  "og:description": "Learn how to configure a Network Graph"
  "og:title": "Graph | Unovis"
  description: "Learn how to configure a Network Graph"
---

## Data [](#data "Direct link to Data")

_Graph_ expects the data to be an object with `nodes` and `links` arrays:

```
type GraphData = {  nodes: NodeDatum[];  links: LinkDatum[];}
```

The `NodeDatum` object type in generic and doesn't have any mandatory fields, however we recommend adding unique `id`s to each node to support better graph animations. Your links will need to have the `source` and `target` properties referencing specific nodes either by their index in the `nodes` array or by their unique `id`; or they can be references to the actual node objects.

```
type NodeDatum = {  id?: string;  x?: number;  y?: number;}type LinkDatum = {  id?: string;  source: number | string | NodeDatum;  target: number | string | NodeDatum;}
```

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

_Graph_ is a component that works inside _Single Container_. By default, _Graph_ will render your network using force layout and will display nodes as circles.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisGraph } from '@unovis/react'function Component(props) {  const data: NodeData = props.data  return (    <VisSingleContainer data={data}>      <VisGraph/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: NodeData;}
```

template.html

```
<vis-single-container [data]="data">  <vis-graph></vis-graph></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisGraph } from '@unovis/svelte'  export let data: NodeData</script><VisSingleContainer {data}>  <VisGraph/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisGraph } from '@unovis/vue'const props = defineProps<{ data: NodeData }>()</script><template>  <VisSingleContainer :data="data">    <VisGraph />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisGraph } from '@unovis/solid'function Component(props) {  const data: NodeData = () => props.data  return (    <VisSingleContainer data={data()}>      <VisGraph/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Graph } from '@unovis/ts'import { data, NodeDatum,  LinkDatum } from './data'const container = new SingleContainer<NodeDatum, LinkDatum>(node, {  component: new Graph<NodeDatum, LinkDatum>({ })}, data)
```

Loading...

## Nodes [](#nodes "Direct link to Nodes")

### Shape and Size [](#shape-and-size "Direct link to Shape and Size")

Shape and size of the nodes can be set with the `nodeShape` and `nodeSize` config properties. They can accept either a constant value or an accessor function.

The following node shapes are supported: `Shape.Circle` (`"circle"`), `Shape.Square` (`"square"`), `Shape.Hexagon` (`"hexagon"`), and `Shape.Triangle` (`"triangle"`).

`nodeSize` sets the diameter of the node in pixels at zoom level `1`. Keep in mind that _Graph_ will automatically choose zoom level at initialization to fit to the size of the container.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: NodeData = props.data  const nodeShape = (n: NodeDatum, i: number) =>  ['square', 'circle', 'hexagon', 'triangle'][i % 4]  return (    <VisGraph nodeShape={nodeShape} nodeSize={50}/>  )}
```

component.ts

```
@Component({  template: '<vis-graph [nodeShape]="nodeShape" [nodeSize]="50"></vis-graph>'})export class Component {  @Input data: NodeData;  nodeShape = (n: NodeDatum, i: number) =>  ['square', 'circle', 'hexagon', 'triangle'][i % 4]}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisGraph } from '@unovis/svelte'  export let data: NodeData  const nodeShape = (n: NodeDatum, i: number) =>  ['square', 'circle', 'hexagon', 'triangle'][i % 4]</script><VisGraph {nodeShape} nodeSize={50}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisGraph } from '@unovis/vue'const props = defineProps<{ data: NodeData }>()const nodeShape = (n: NodeDatum, i: number) =>  ['square', 'circle', 'hexagon', 'triangle'][i % 4]</script><template>  <VisGraph :nodeShape="nodeShape" :nodeSize="50" /></template>
```

component.tsx

```
function Component(props) {  const data: NodeData = () => props.data  const nodeShape = (n: NodeDatum, i: number) =>  ['square', 'circle', 'hexagon', 'triangle'][i % 4]  return (    <VisGraph nodeShape={nodeShape} nodeSize={50}/>  )}
```

component.ts

```
const graph = new Graph<NodeDatum, LinkDatum>({  nodeShape: (n: NodeDatum, i: number) =>  ['square', 'circle', 'hexagon', 'triangle'][i % 4],   nodeSize: 50})
```

Loading...

### Custom SVG Shapes [](#custom-svg-shapes "Direct link to Custom SVG Shapes")

Alternatively, you can provide `nodeShape` property with custom SVGs to get the exact shape you want. You can either provide it directly as a string in your _StringAccessor_ or for better control over the element, put the shape(s) definition in the container's `svgDefs` property and reference it with `use` tag. For more information on providing custom `svgDefs`, visit our doc about it.

Here is an example using the `svgDefs` approach and where every _node_ has the following type:

```
type NodeDatum = {  id: string;  shape: 'blob' | 'cloud' | 'diamond' | 'house'}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisGraph } from '@unovis/react'function Component(props) {  const data: NodeData = props.data  const svgDefs = \`  <path id="blob" d="M 19.415 1.0564 C 20.585 2.47 20.225 5.89 21.665 8.2612 C 23.06 10.678 26.345 12.046 28.325 14.554 C 30.305 17.1076 31.025 20.8012 28.865 21.9412 C 26.75 23.1268 21.755 21.7588 18.605 23.3092 C 15.455 24.8596 14.105 29.3284 12.485 29.8756 C 10.865 30.3772 8.93 27.0028 6.41 25.042 C 3.89 23.1268 0.83 22.6708 0.38 20.9836 C -0.07 19.2964 2.135 16.378 2.54 13.642 C 2.945 10.9516 1.55 8.4892 2.135 7.03 C 2.72 5.5708 5.285 5.1148 7.355 4.294 C 9.47 3.4276 11.135 2.1964 13.34 1.2388 C 15.545 0.3268 18.245 -0.3116 19.415 1.0564 Z"/>  <path id="cloud" d="M 14 -1 A 9 9 90 0 0 5 8 A 9 9 90 0 0 5.1055 9.3125 A 6 6 90 0 0 1 15 A 6 6 90 0 0 7 21 L 22 21 A 7 7 90 0 0 29 14 A 7 7 90 0 0 22.9414 7.0703 A 9 9 90 0 0 14 -1 z"/>  <polygon id="diamond" points="0,15 15,0 30,15 15,30"/>  <polygon id="house" points="4,18 4,30 13,30 13,24 17,24 17,30 26,30 26,18 30,18 15,0 0,18"/>\`  const nodeLabel = (n: NodeDatum) =>  n.shape  const nodeShape = (n: NodeDatum) =>  \`<use href = "#${n.shape}" stroke - width = "3" / >\`  return (    <VisSingleContainer      svgDefs={svgDefs}       data={data}    >      <VisGraph nodeLabel={nodeLabel} nodeShape={nodeShape}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: NodeData;  svgDefs = \`  <path id="blob" d="M 19.415 1.0564 C 20.585 2.47 20.225 5.89 21.665 8.2612 C 23.06 10.678 26.345 12.046 28.325 14.554 C 30.305 17.1076 31.025 20.8012 28.865 21.9412 C 26.75 23.1268 21.755 21.7588 18.605 23.3092 C 15.455 24.8596 14.105 29.3284 12.485 29.8756 C 10.865 30.3772 8.93 27.0028 6.41 25.042 C 3.89 23.1268 0.83 22.6708 0.38 20.9836 C -0.07 19.2964 2.135 16.378 2.54 13.642 C 2.945 10.9516 1.55 8.4892 2.135 7.03 C 2.72 5.5708 5.285 5.1148 7.355 4.294 C 9.47 3.4276 11.135 2.1964 13.34 1.2388 C 15.545 0.3268 18.245 -0.3116 19.415 1.0564 Z"/>  <path id="cloud" d="M 14 -1 A 9 9 90 0 0 5 8 A 9 9 90 0 0 5.1055 9.3125 A 6 6 90 0 0 1 15 A 6 6 90 0 0 7 21 L 22 21 A 7 7 90 0 0 29 14 A 7 7 90 0 0 22.9414 7.0703 A 9 9 90 0 0 14 -1 z"/>  <polygon id="diamond" points="0,15 15,0 30,15 15,30"/>  <polygon id="house" points="4,18 4,30 13,30 13,24 17,24 17,30 26,30 26,18 30,18 15,0 0,18"/>\`  nodeLabel = (n: NodeDatum) =>  n.shape  nodeShape = (n: NodeDatum) =>  \`<use href = "#${n.shape}" stroke - width = "3" / >\`}
```

template.html

```
<vis-single-container  [svgDefs]="svgDefs"   [data]="data">  <vis-graph [nodeLabel]="nodeLabel" [nodeShape]="nodeShape"></vis-graph></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisGraph } from '@unovis/svelte'  export let data: NodeData  const svgDefs = \`  <path id="blob" d="M 19.415 1.0564 C 20.585 2.47 20.225 5.89 21.665 8.2612 C 23.06 10.678 26.345 12.046 28.325 14.554 C 30.305 17.1076 31.025 20.8012 28.865 21.9412 C 26.75 23.1268 21.755 21.7588 18.605 23.3092 C 15.455 24.8596 14.105 29.3284 12.485 29.8756 C 10.865 30.3772 8.93 27.0028 6.41 25.042 C 3.89 23.1268 0.83 22.6708 0.38 20.9836 C -0.07 19.2964 2.135 16.378 2.54 13.642 C 2.945 10.9516 1.55 8.4892 2.135 7.03 C 2.72 5.5708 5.285 5.1148 7.355 4.294 C 9.47 3.4276 11.135 2.1964 13.34 1.2388 C 15.545 0.3268 18.245 -0.3116 19.415 1.0564 Z"/>  <path id="cloud" d="M 14 -1 A 9 9 90 0 0 5 8 A 9 9 90 0 0 5.1055 9.3125 A 6 6 90 0 0 1 15 A 6 6 90 0 0 7 21 L 22 21 A 7 7 90 0 0 29 14 A 7 7 90 0 0 22.9414 7.0703 A 9 9 90 0 0 14 -1 z"/>  <polygon id="diamond" points="0,15 15,0 30,15 15,30"/>  <polygon id="house" points="4,18 4,30 13,30 13,24 17,24 17,30 26,30 26,18 30,18 15,0 0,18"/>\`  const nodeLabel = (n: NodeDatum) =>  n.shape  const nodeShape = (n: NodeDatum) =>  \`<use href = "#${n.shape}" stroke - width = "3" / >\`</script><VisSingleContainer {svgDefs} {data}>  <VisGraph {nodeLabel} {nodeShape}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisGraph } from '@unovis/vue'const props = defineProps<{ data: NodeData }>()const svgDefs = \`  <path id="blob" d="M 19.415 1.0564 C 20.585 2.47 20.225 5.89 21.665 8.2612 C 23.06 10.678 26.345 12.046 28.325 14.554 C 30.305 17.1076 31.025 20.8012 28.865 21.9412 C 26.75 23.1268 21.755 21.7588 18.605 23.3092 C 15.455 24.8596 14.105 29.3284 12.485 29.8756 C 10.865 30.3772 8.93 27.0028 6.41 25.042 C 3.89 23.1268 0.83 22.6708 0.38 20.9836 C -0.07 19.2964 2.135 16.378 2.54 13.642 C 2.945 10.9516 1.55 8.4892 2.135 7.03 C 2.72 5.5708 5.285 5.1148 7.355 4.294 C 9.47 3.4276 11.135 2.1964 13.34 1.2388 C 15.545 0.3268 18.245 -0.3116 19.415 1.0564 Z"/>  <path id="cloud" d="M 14 -1 A 9 9 90 0 0 5 8 A 9 9 90 0 0 5.1055 9.3125 A 6 6 90 0 0 1 15 A 6 6 90 0 0 7 21 L 22 21 A 7 7 90 0 0 29 14 A 7 7 90 0 0 22.9414 7.0703 A 9 9 90 0 0 14 -1 z"/>  <polygon id="diamond" points="0,15 15,0 30,15 15,30"/>  <polygon id="house" points="4,18 4,30 13,30 13,24 17,24 17,30 26,30 26,18 30,18 15,0 0,18"/>\`const nodeLabel = (n: NodeDatum) =>  n.shapeconst nodeShape = (n: NodeDatum) =>  \`<use href = "#${n.shape}" stroke - width = "3" / >\`</script><template>  <VisSingleContainer    :svgDefs="svgDefs"     :data="data"  >    <VisGraph :nodeLabel="nodeLabel" :nodeShape="nodeShape" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisGraph } from '@unovis/solid'function Component(props) {  const data: NodeData = () => props.data  const svgDefs = \`  <path id="blob" d="M 19.415 1.0564 C 20.585 2.47 20.225 5.89 21.665 8.2612 C 23.06 10.678 26.345 12.046 28.325 14.554 C 30.305 17.1076 31.025 20.8012 28.865 21.9412 C 26.75 23.1268 21.755 21.7588 18.605 23.3092 C 15.455 24.8596 14.105 29.3284 12.485 29.8756 C 10.865 30.3772 8.93 27.0028 6.41 25.042 C 3.89 23.1268 0.83 22.6708 0.38 20.9836 C -0.07 19.2964 2.135 16.378 2.54 13.642 C 2.945 10.9516 1.55 8.4892 2.135 7.03 C 2.72 5.5708 5.285 5.1148 7.355 4.294 C 9.47 3.4276 11.135 2.1964 13.34 1.2388 C 15.545 0.3268 18.245 -0.3116 19.415 1.0564 Z"/>  <path id="cloud" d="M 14 -1 A 9 9 90 0 0 5 8 A 9 9 90 0 0 5.1055 9.3125 A 6 6 90 0 0 1 15 A 6 6 90 0 0 7 21 L 22 21 A 7 7 90 0 0 29 14 A 7 7 90 0 0 22.9414 7.0703 A 9 9 90 0 0 14 -1 z"/>  <polygon id="diamond" points="0,15 15,0 30,15 15,30"/>  <polygon id="house" points="4,18 4,30 13,30 13,24 17,24 17,30 26,30 26,18 30,18 15,0 0,18"/>\`  const nodeLabel = (n: NodeDatum) =>  n.shape  const nodeShape = (n: NodeDatum) =>  \`<use href = "#${n.shape}" stroke - width = "3" / >\`  return (    <VisSingleContainer      svgDefs={svgDefs}       data={data()}    >      <VisGraph nodeLabel={nodeLabel} nodeShape={nodeShape}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Graph } from '@unovis/ts'import { data, NodeDatum,  LinkDatum } from './data'const container = new SingleContainer<NodeDatum, LinkDatum>(node, {  svgDefs: \`  <path id="blob" d="M 19.415 1.0564 C 20.585 2.47 20.225 5.89 21.665 8.2612 C 23.06 10.678 26.345 12.046 28.325 14.554 C 30.305 17.1076 31.025 20.8012 28.865 21.9412 C 26.75 23.1268 21.755 21.7588 18.605 23.3092 C 15.455 24.8596 14.105 29.3284 12.485 29.8756 C 10.865 30.3772 8.93 27.0028 6.41 25.042 C 3.89 23.1268 0.83 22.6708 0.38 20.9836 C -0.07 19.2964 2.135 16.378 2.54 13.642 C 2.945 10.9516 1.55 8.4892 2.135 7.03 C 2.72 5.5708 5.285 5.1148 7.355 4.294 C 9.47 3.4276 11.135 2.1964 13.34 1.2388 C 15.545 0.3268 18.245 -0.3116 19.415 1.0564 Z"/>  <path id="cloud" d="M 14 -1 A 9 9 90 0 0 5 8 A 9 9 90 0 0 5.1055 9.3125 A 6 6 90 0 0 1 15 A 6 6 90 0 0 7 21 L 22 21 A 7 7 90 0 0 29 14 A 7 7 90 0 0 22.9414 7.0703 A 9 9 90 0 0 14 -1 z"/>  <polygon id="diamond" points="0,15 15,0 30,15 15,30"/>  <polygon id="house" points="4,18 4,30 13,30 13,24 17,24 17,30 26,30 26,18 30,18 15,0 0,18"/>\`,   component: new Graph<NodeDatum, LinkDatum>({    nodeLabel: (n: NodeDatum) =>  n.shape,     nodeShape: (n: NodeDatum) =>  \`<use href = "#${n.shape}" stroke - width = "3" / >\`  })}, data)
```

Loading...

Note that depending on your SVG, it may require some additional tweaking to get the appearance you want. For example, custom nodes would require `stroke-width`, or `fill` attributes if not already defined. It may also be necessary to tweak your shape size to fit into the bounds of your configured `nodeSize`, like this example:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  nodeSize={50}   nodeShape="<image width='50' height='50' href='https://upload.wikimedia.org/wikipedia/commons/7/7e/Sphere_-_monochrome_simple.svg'/>"/>
```

```
<vis-graph  [nodeSize]="50"   nodeShape="<image width='50' height='50' href='https://upload.wikimedia.org/wikipedia/commons/7/7e/Sphere_-_monochrome_simple.svg'/>"></vis-graph>
```

```
<VisGraph  nodeSize={50}   nodeShape="<image width='50' height='50' href='https://upload.wikimedia.org/wikipedia/commons/7/7e/Sphere_-_monochrome_simple.svg'/>"/>
```

```
<VisGraph  :nodeSize="50"   nodeShape="<image width='50' height='50' href='https://upload.wikimedia.org/wikipedia/commons/7/7e/Sphere_-_monochrome_simple.svg'/>" />
```

```
<VisGraph  nodeSize={50}   nodeShape="<image width='50' height='50' href='https://upload.wikimedia.org/wikipedia/commons/7/7e/Sphere_-_monochrome_simple.svg'/>"/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  nodeSize: 50,   nodeShape: "<image width='50' height='50' href='https://upload.wikimedia.org/wikipedia/commons/7/7e/Sphere_-_monochrome_simple.svg'/>"})
```

Loading...

### Fill and Stroke [](#fill-and-stroke "Direct link to Fill and Stroke")

Use the `nodeFill` and `nodeStroke` properties to set node's fill and stroke color. A custom stroke width can be provided to `nodeStrokeWidth`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: NodeData = props.data  const nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)  const nodeStroke = (n: NodeDatum, i: number) =>  getColorByIndex(i  +  1)  const nodeStrokeWidth = (d: NodeDatum, i: number) =>  1  +  i  *  3  return (    <VisGraph      nodeFill={nodeFill}       nodeStroke={nodeStroke}       nodeStrokeWidth={nodeStrokeWidth}    />  )}
```

component.ts

```
@Component({  template: \`    <vis-graph      [nodeFill]="nodeFill"       [nodeStroke]="nodeStroke"       [nodeStrokeWidth]="nodeStrokeWidth"    ></vis-graph>  \`})export class Component {  @Input data: NodeData;  nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)  nodeStroke = (n: NodeDatum, i: number) =>  getColorByIndex(i  +  1)  nodeStrokeWidth = (d: NodeDatum, i: number) =>  1  +  i  *  3}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisGraph } from '@unovis/svelte'  export let data: NodeData  const nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)  const nodeStroke = (n: NodeDatum, i: number) =>  getColorByIndex(i  +  1)  const nodeStrokeWidth = (d: NodeDatum, i: number) =>  1  +  i  *  3</script><VisGraph {nodeFill} {nodeStroke} {nodeStrokeWidth}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisGraph } from '@unovis/vue'const props = defineProps<{ data: NodeData }>()const nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)const nodeStroke = (n: NodeDatum, i: number) =>  getColorByIndex(i  +  1)const nodeStrokeWidth = (d: NodeDatum, i: number) =>  1  +  i  *  3</script><template>  <VisGraph    :nodeFill="nodeFill"     :nodeStroke="nodeStroke"     :nodeStrokeWidth="nodeStrokeWidth"   /></template>
```

component.tsx

```
function Component(props) {  const data: NodeData = () => props.data  const nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)  const nodeStroke = (n: NodeDatum, i: number) =>  getColorByIndex(i  +  1)  const nodeStrokeWidth = (d: NodeDatum, i: number) =>  1  +  i  *  3  return (    <VisGraph      nodeFill={nodeFill}       nodeStroke={nodeStroke}       nodeStrokeWidth={nodeStrokeWidth}    />  )}
```

component.ts

```
const graph = new Graph<NodeDatum, LinkDatum>({  nodeFill: (n: NodeDatum, i: number) =>  getColorByIndex(i),   nodeStroke: (n: NodeDatum, i: number) =>  getColorByIndex(i  +  1),   nodeStrokeWidth: (d: NodeDatum, i: number) =>  1  +  i  *  3})
```

Loading...

### Icons and Labels [](#icons-and-labels "Direct link to Icons and Labels")

#### In the center [](#in-the-center "Direct link to In the center")

Nodes can have icons in the center, set by providing the `nodeIcon` accessor function, which returns either a character (if you're using an icon font) or an internal href (if you're defining your icons as custom SVG defs). By default, the icon will fit to the size of the node. You can set custom icon size in pixels with the `nodeIconSize` property.

When using an icon font or when your SVG icon `fill` is set to `currentColor`, the component will automatically choose the icon color (dark or light) based on the node's fill color. You can change the dark and light colors with the `--vis-graph-node-icon-fill-color-bright` and `--vis-graph-node-icon-fill-color-dark` CSS variables.

The icon font can be set via the `--vis-graph-icon-font-family` CSS variable.

note

Icon fonts have different baseline values and sometime you might need to specify a custom `dominant-baseline` to make the icons be vertically centered. You can achieve that by changing the `--vis-graph-node-dominant-baseline` CSS variable value (usually between `middle` and `central`). The default value is `middle`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: NodeData = props.data  const nodeIcon = (n: NodeDatum, i: number) =>  getNodeIconByIndex(i)  const nodeIconSize = (n: NodeDatum, i: number) =>  10  +  i  const nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)  return (    <VisGraph      nodeIcon={nodeIcon}       nodeIconSize={nodeIconSize}       nodeFill={nodeFill}    />  )}
```

component.ts

```
@Component({  template: \`    <vis-graph      [nodeIcon]="nodeIcon"       [nodeIconSize]="nodeIconSize"       [nodeFill]="nodeFill"    ></vis-graph>  \`})export class Component {  @Input data: NodeData;  nodeIcon = (n: NodeDatum, i: number) =>  getNodeIconByIndex(i)  nodeIconSize = (n: NodeDatum, i: number) =>  10  +  i  nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisGraph } from '@unovis/svelte'  export let data: NodeData  const nodeIcon = (n: NodeDatum, i: number) =>  getNodeIconByIndex(i)  const nodeIconSize = (n: NodeDatum, i: number) =>  10  +  i  const nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)</script><VisGraph {nodeIcon} {nodeIconSize} {nodeFill}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisGraph } from '@unovis/vue'const props = defineProps<{ data: NodeData }>()const nodeIcon = (n: NodeDatum, i: number) =>  getNodeIconByIndex(i)const nodeIconSize = (n: NodeDatum, i: number) =>  10  +  iconst nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)</script><template>  <VisGraph    :nodeIcon="nodeIcon"     :nodeIconSize="nodeIconSize"     :nodeFill="nodeFill"   /></template>
```

component.tsx

```
function Component(props) {  const data: NodeData = () => props.data  const nodeIcon = (n: NodeDatum, i: number) =>  getNodeIconByIndex(i)  const nodeIconSize = (n: NodeDatum, i: number) =>  10  +  i  const nodeFill = (n: NodeDatum, i: number) =>  getColorByIndex(i)  return (    <VisGraph      nodeIcon={nodeIcon}       nodeIconSize={nodeIconSize}       nodeFill={nodeFill}    />  )}
```

component.ts

```
const graph = new Graph<NodeDatum, LinkDatum>({  nodeIcon: (n: NodeDatum, i: number) =>  getNodeIconByIndex(i),   nodeIconSize: (n: NodeDatum, i: number) =>  10  +  i,   nodeFill: (n: NodeDatum, i: number) =>  getColorByIndex(i)})
```

Loading...

#### At the bottom [](#at-the-bottom "Direct link to At the bottom")

Node label and sub-label can be set by providing the `nodeLabel` and `nodeSubLabel` accessor functions.

tip

By default, long labels will be trimmed and displayed in full only on hover. You can control that behaviour via the `nodeLabelTrim` and `nodeSubLabelTrim` config properties.

You can also configure how trimming works by specifying custom `nodeLabelTrimMode`, `nodeLabelTrimLength`, `nodeSubLabelTrimMode`, and `nodeSubLabelTrimLength` values.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph nodeLabel={nodeLabel} nodeSubLabel={nodeSubLabel}/>
```

```
<vis-graph  [nodeLabel]="nodeLabel"   [nodeSubLabel]="nodeSubLabel"></vis-graph>
```

```
<VisGraph {nodeLabel} {nodeSubLabel}/>
```

```
<VisGraph :nodeLabel="nodeLabel" :nodeSubLabel="nodeSubLabel" />
```

```
<VisGraph nodeLabel={nodeLabel} nodeSubLabel={nodeSubLabel}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({ nodeLabel, nodeSubLabel })
```

Loading...

The font size of the labels can be controlled via CSS variables. Here is a full list of the variables available to control the appearance of the node labels, and their default values:

```
--vis-graph-node-label-font-size: 9pt;--vis-graph-node-label-background: #ffffff;--vis-graph-node-label-text-color: #0F1E57;--vis-graph-node-sublabel-text-color: #989aa3;--vis-graph-node-sublabel-font-size: 8pt;--vis-graph-node-label-font-family: var(--vis-font-family);/* Dark Theme */--vis-dark-graph-node-label-background: var(--vis-color-grey);--vis-dark-graph-node-label-text-color: #ffffff;--vis-dark-graph-node-sublabel-text-color: #989aa3;
```

#### On the side [](#on-the-side "Direct link to On the side")

The third option to add labels to the nodes is `nodeSideLabels`. Side labels are small circular labels in the top right corner of the node. One node can have multiple side labels at once. You can configure them by providing an accessor function to `nodeSideLabels` that returns an array of `GraphCircleLabel` objects:

```
type GraphCircleLabel = {  text: string;  textColor?: string; // Optional text color. By default, the text color will depend on the brightness of the circle color.  color?: string | null; // Optional color  cursor?: string | null; // Optional cursor on hover  fontSize?: string | null; // Optional font size as a CSS string  radius?: number; // Circle radius in pixels}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph nodeSideLabels={nodeSideLabels}/>
```

```
<vis-graph [nodeSideLabels]="nodeSideLabels"></vis-graph>
```

```
<VisGraph {nodeSideLabels}/>
```

```
<VisGraph :nodeSideLabels="nodeSideLabels" />
```

```
<VisGraph nodeSideLabels={nodeSideLabels}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({ nodeSideLabels })
```

Loading...

You can configure the default appearance of the side labels with the following CSS variables:

```
--vis-graph-node-side-label-background-fill-color: #a0a9af;--vis-graph-node-side-label-background-stroke-color: #ffffff;--vis-graph-node-side-label-fill-color-bright: #ffffff;--vis-graph-node-side-label-fill-color-dark: #494b56;// Dark Theme--vis-dark-graph-node-side-label-background-fill-color: #989aa3;--vis-dark-graph-node-side-label-background-stroke-color: var(--vis-color-grey);--vis-dark-graph-node-side-label-fill-color-bright: #f1f4f7;--vis-dark-graph-node-side-label-fill-color-dark: var(--vis-color-grey);
```

### Gauge Outline [](#gauge-outline "Direct link to Gauge Outline")

Nodes can also have a gauge outline on top of stroke, if you provide an accessor function to `nodeGaugeValue` returning a number in the range of [0, 1]. The width of the gauge is linked to the `nodeStrokeWidth` value.

You can set the color of the gauge with `nodeGaugeFill`. The default gauge color is configurable via the `--vis-graph-node-stroke-segment-color` CSS variable.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: NodeData = props.data  const nodeGaugeFill = (n: NodeDatum, i: number) =>  gradient(i  *  10)  const nodeGaugeValue = (n: NodeDatum, i: number) =>  i  *  10  const nodeLabel = (n: NodeDatum, i: number) =>  \`${i  *  10}%\`  return (    <VisGraph      nodeGaugeFill={nodeGaugeFill}       nodeGaugeValue={nodeGaugeValue}       nodeLabel={nodeLabel}    />  )}
```

component.ts

```
@Component({  template: \`    <vis-graph      [nodeGaugeFill]="nodeGaugeFill"       [nodeGaugeValue]="nodeGaugeValue"       [nodeLabel]="nodeLabel"    ></vis-graph>  \`})export class Component {  @Input data: NodeData;  nodeGaugeFill = (n: NodeDatum, i: number) =>  gradient(i  *  10)  nodeGaugeValue = (n: NodeDatum, i: number) =>  i  *  10  nodeLabel = (n: NodeDatum, i: number) =>  \`${i  *  10}%\`}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisGraph } from '@unovis/svelte'  export let data: NodeData  const nodeGaugeFill = (n: NodeDatum, i: number) =>  gradient(i  *  10)  const nodeGaugeValue = (n: NodeDatum, i: number) =>  i  *  10  const nodeLabel = (n: NodeDatum, i: number) =>  \`${i  *  10}%\`</script><VisGraph {nodeGaugeFill} {nodeGaugeValue} {nodeLabel}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisGraph } from '@unovis/vue'const props = defineProps<{ data: NodeData }>()const nodeGaugeFill = (n: NodeDatum, i: number) =>  gradient(i  *  10)const nodeGaugeValue = (n: NodeDatum, i: number) =>  i  *  10const nodeLabel = (n: NodeDatum, i: number) =>  \`${i  *  10}%\`</script><template>  <VisGraph    :nodeGaugeFill="nodeGaugeFill"     :nodeGaugeValue="nodeGaugeValue"     :nodeLabel="nodeLabel"   /></template>
```

component.tsx

```
function Component(props) {  const data: NodeData = () => props.data  const nodeGaugeFill = (n: NodeDatum, i: number) =>  gradient(i  *  10)  const nodeGaugeValue = (n: NodeDatum, i: number) =>  i  *  10  const nodeLabel = (n: NodeDatum, i: number) =>  \`${i  *  10}%\`  return (    <VisGraph      nodeGaugeFill={nodeGaugeFill}       nodeGaugeValue={nodeGaugeValue}       nodeLabel={nodeLabel}    />  )}
```

component.ts

```
const graph = new Graph<NodeDatum, LinkDatum>({  nodeGaugeFill: (n: NodeDatum, i: number) =>  gradient(i  *  10),   nodeGaugeValue: (n: NodeDatum, i: number) =>  i  *  10,   nodeLabel: (n: NodeDatum, i: number) =>  \`${i  *  10}%\`})
```

Loading...

### Disabled State [](#disabled-state "Direct link to Disabled State")

Nodes can have a disabled (greyed out) state configured by the `nodeDisabled` property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: NodeData = props.data  const nodeDisabled = (n: NodeDatum, i: number) =>  n.value < 50  const nodeLabel = (n: NodeDatum) =>  n.value.toFixed(0)  return (    <VisGraph nodeDisabled={nodeDisabled} nodeLabel={nodeLabel}/>  )}
```

component.ts

```
@Component({  template: \`    <vis-graph      [nodeDisabled]="nodeDisabled"       [nodeLabel]="nodeLabel"    ></vis-graph>  \`})export class Component {  @Input data: NodeData;  nodeDisabled = (n: NodeDatum, i: number) =>  n.value < 50  nodeLabel = (n: NodeDatum) =>  n.value.toFixed(0)}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisGraph } from '@unovis/svelte'  export let data: NodeData  const nodeDisabled = (n: NodeDatum, i: number) =>  n.value < 50  const nodeLabel = (n: NodeDatum) =>  n.value.toFixed(0)</script><VisGraph {nodeDisabled} {nodeLabel}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisGraph } from '@unovis/vue'const props = defineProps<{ data: NodeData }>()const nodeDisabled = (n: NodeDatum, i: number) =>  n.value < 50const nodeLabel = (n: NodeDatum) =>  n.value.toFixed(0)</script><template>  <VisGraph :nodeDisabled="nodeDisabled" :nodeLabel="nodeLabel" /></template>
```

component.tsx

```
function Component(props) {  const data: NodeData = () => props.data  const nodeDisabled = (n: NodeDatum, i: number) =>  n.value < 50  const nodeLabel = (n: NodeDatum) =>  n.value.toFixed(0)  return (    <VisGraph nodeDisabled={nodeDisabled} nodeLabel={nodeLabel}/>  )}
```

component.ts

```
const graph = new Graph<NodeDatum, LinkDatum>({  nodeDisabled: (n: NodeDatum, i: number) =>  n.value < 50,   nodeLabel: (n: NodeDatum) =>  n.value.toFixed(0)})
```

Loading...

The disabled state appearance can be redefined with these CSS variables:

```
--vis-graph-node-greyout-color: #ebeff7;--vis-graph-node-icon-greyout-color: #c6cad1;--vis-graph-node-side-label-background-greyout-color: #f1f4f7;// Dark Theme--vis-dark-graph-node-greyout-color: #494b56;--vis-dark-graph-node-icon-greyout-color: var(--vis-color-grey);--vis-dark-graph-node-side-label-background-greyout-color: #f1f4f7;
```

### Custom Rendering `1.5`[](#custom-rendering-15 "Direct link to custom-rendering-15")

The _Graph_ component offers extensive customization options for node rendering, allowing you to define how nodes are displayed at various stages of their lifecycle — such as on entering, updating, zooming, and exiting. You can inject custom rendering functions using the following configuration properties:

- `nodeEnterCustomRenderFunction`: Customize the node rendering when a node enters the DOM.
- `nodeUpdateCustomRenderFunction`: Define the rendering when a node updates its position or properties.
- `nodePartialUpdateCustomRenderFunction`: Partially update nodes on specific interactions like mouseover, background click, and brushing.
- `nodeExitCustomRenderFunction`: Customize how nodes are rendered when they exit the DOM.
- `nodeOnZoomCustomRenderFunction`: Adjust node rendering dynamically during zooming or panning.

These functions provide access to each node's data (`datum`), the node's DOM element selection (`g`), the component configuration (`config`), and the current zoom level (`zoomLevel`). This gives you full control to modify elements such as SVG shapes, colors, labels, icons, and more.

```
import { select, Selection } from 'd3-selection'import { GraphNode, GraphConfigInterface } from '@unovis/ts'export const nodeEnterCustomRenderFunction = (  datum: GraphNode,  g: Selection<SVGGElement, GraphNode, null, unknown>,  config: GraphConfigInterface) => {  // Initial rendering logic for the node  g.append('circle')  // Add custom icons, labels, or any additional elements  g.append('text')    .attr('dy', -10)    .attr('text-anchor', 'middle')}export const nodeUpdateCustomRenderFunction = (  datum: GraphNode,  g: Selection<SVGGElement, GraphNode, null, unknown>,  config: GraphConfigInterface) => {  // Update the node's size, color  g.select('circle')    .attr('r', config.nodeSize ?? 20)    .style('fill', config.nodeFill ?? 'steelblue')  // Update labels or any custom elements based on node data  g.select('text')    .text(datum.id)}
```

Using these functions, you can create highly customized and dynamic node appearances, adapting the visual representation based on data or user interaction. These functions are invoked for each node in the graph, providing flexibility for various use cases, from static iconography to interactive, animated elements.

## Links [](#links "Direct link to Links")

### Color, Width and Type [](#color-width-and-type "Direct link to Color, Width and Type")

Set link color and width with the `linkStroke` and `linkWidth` properties. The default link color can be set with the `--vis-graph-link-stroke-color` CSS variable (and `--vis-dark-graph-node-greyout-color` for the dark theme). Use the `--vis-graph-link-stroke-opacity` variable to set link opacity.

If you want a link to be dashed, you can achieve that by providing an accessor function to `linkStyle` returning either `GraphLinkStyle.Dashed` (`"dashed"`) or `GraphLinkStyle.Solid` (`"solid"`). The dashes length and spacing can be changed with the `--vis-graph-link-dashed-stroke-dasharray` CSS variable.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  linkStroke={linkStroke}   linkStyle={linkStyle}   linkWidth={linkWidth}/>
```

```
<vis-graph  [linkStroke]="linkStroke"   [linkStyle]="linkStyle"   [linkWidth]="linkWidth"></vis-graph>
```

```
<VisGraph {linkStroke} {linkStyle} {linkWidth}/>
```

```
<VisGraph  :linkStroke="linkStroke"   :linkStyle="linkStyle"   :linkWidth="linkWidth" />
```

```
<VisGraph  linkStroke={linkStroke}   linkStyle={linkStyle}   linkWidth={linkWidth}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({ linkStroke, linkStyle, linkWidth })
```

Loading...

### Curvature [](#curvature "Direct link to Curvature")

You can control link curvature by setting the `linkCurvature` property to a number in the range of [0, 2]. The default value is 0 which means straight lines.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph linkCurvature={1}/>
```

```
<vis-graph [linkCurvature]="1"></vis-graph>
```

```
<VisGraph linkCurvature={1}/>
```

```
<VisGraph :linkCurvature="1" />
```

```
<VisGraph linkCurvature={1}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({ linkCurvature: 1 })
```

Loading...

### Arrows [](#arrows "Direct link to Arrows")

Providing an accessor function to `linkArrow` will turn on arrows display on links. The function should return `GraphLinkArrowStyle.Single` (`"single"` or simply `true`) or `GraphLinkArrowStyle.Double` (`"double"`) or `null`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph linkArrow={linkArrow}/>
```

```
<vis-graph [linkArrow]="linkArrow"></vis-graph>
```

```
<VisGraph {linkArrow}/>
```

```
<VisGraph :linkArrow="linkArrow" />
```

```
<VisGraph linkArrow={linkArrow}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({ linkArrow })
```

Loading...

### Labels `Updated in 1.5`[](#labels-updated-in-15 "Direct link to labels-updated-in-15")

Links can have one or multiple textual or custom SVG labels. When the label is short (two characters or less) or an SVG href, it'll be rendered with a circular background similarly to node's side labels. Longer labels will have a rectangular background.

To enable link labels you'll need to provide a function for `linkLabel` returning either a single `GraphLinkLabel` object or an array of `GraphLinkLabel` objects to display.

To use custom SVG as labels (available in _Unovis_ 1.5), you'll first need to define it in your container SVG defs and provide the `href` to your custom SVG definition using the `text` property of your label. In this case the `fontSize` property will control the size of your custom SVG label.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph linkLabel={linkLabel}/>
```

```
<vis-graph [linkLabel]="linkLabel"></vis-graph>
```

```
<VisGraph {linkLabel}/>
```

```
<VisGraph :linkLabel="linkLabel" />
```

```
<VisGraph linkLabel={linkLabel}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({ linkLabel })
```

Loading...

The default appearance of the labels is controlled with the following CSS variables:

```
--vis-graph-link-label-font-size: 9pt;--vis-graph-link-label-background: #e6e9f3;--vis-graph-link-label-text-color: #18181B;// Dark Theme--vis-dark-graph-link-label-background: #3f3f45;--vis-dark-graph-link-label-text-color: var(--vis-graph-link-label-text-color-bright);
```

### Band [](#band "Direct link to Band")

Link can also have a semi-transparent band, which you can turn on by providing a constant value or an accessor function to `linkBandWidth`. The opacity of the band can be changed with the `--vis-graph-link-band-opacity` CSS property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph linkBandWidth={linkBandWidth}/>
```

```
<vis-graph [linkBandWidth]="linkBandWidth"></vis-graph>
```

```
<VisGraph {linkBandWidth}/>
```

```
<VisGraph :linkBandWidth="linkBandWidth" />
```

```
<VisGraph linkBandWidth={linkBandWidth}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({ linkBandWidth })
```

Loading...

### Flying Particles [](#flying-particles "Direct link to Flying Particles")

Set `linkFlow` to `true` (or provide an accessor function) to turn on flying particles along the links. Configure the size of the particles with `linkFlowParticleSize` and animation speed with either `linkFlowAnimDuration` or `linkFlowParticleSpeed` properties.

The `linkFlowParticleSpeed` property (in pixels per second) takes precedence over `linkFlowAnimDuration` when both are provided.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  linkFlow={linkFlow}   linkFlowParticleSize={3}   linkFlowParticleSpeed={10}/>
```

```
<vis-graph  [linkFlow]="linkFlow"   [linkFlowParticleSize]="3"   [linkFlowParticleSpeed]="10"></vis-graph>
```

```
<VisGraph  {linkFlow}   linkFlowParticleSize={3}   linkFlowParticleSpeed={10}/>
```

```
<VisGraph  :linkFlow="linkFlow"   :linkFlowParticleSize="3"   :linkFlowParticleSpeed="10" />
```

```
<VisGraph  linkFlow={linkFlow}   linkFlowParticleSize={3}   linkFlowParticleSpeed={10}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  linkFlow,   linkFlowParticleSize: 3,   linkFlowParticleSpeed: 10})
```

Loading...

### Multiple Links [](#multiple-links "Direct link to Multiple Links")

If there are multiple links between two nodes, all of them will be displayed. You can control the spacing between the neighboring links with the `linkNeighborSpacing` property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph linkNeighborSpacing={3}/>
```

```
<vis-graph [linkNeighborSpacing]="3"></vis-graph>
```

```
<VisGraph linkNeighborSpacing={3}/>
```

```
<VisGraph :linkNeighborSpacing="3" />
```

```
<VisGraph linkNeighborSpacing={3}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({ linkNeighborSpacing: 3 })
```

Loading...

## Layout [](#layout "Direct link to Layout")

### Force [](#force "Direct link to Force")

By default, the layout of the graph will be calculated using d3-force. If you want to change the default force simulation settings, provide a `GraphForceLayoutSettings` configuration object to the `forceLayoutSettings` config property.

```
type GraphForceLayoutSettings = {  /** Preferred Link Distance. Default: \`60\` */  linkDistance?: number;  /** Link Strength [0:1]. Default: \`0.45\` */  linkStrength?: number;  /** Charge Force (<0 repulsion, >0 attraction). Default: \`-500\` */  charge?: number;  /** X-centring force. Default: \`0.15\` */  forceXStrength?: number;  /** Y-centring force. Default: \`0.25\` */  forceYStrength?: number;}
```

### Parallel [](#parallel "Direct link to Parallel")

If your nodes can be separated into multiple groups, and you want them to be organized by columns or rows, set `layoutType` to `GraphLayoutType.Parallel` (`"parallel"`) or `GraphLayoutType.ParallelHorizontal` (`"parallel horizontal"`) respectively.

You can define the node's group (i.e. column or row) by providing a `layoutNodeGroup` accessor function.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: NodeData = props.data  const layoutNodeGroup = (d: NodeDatum, i: number) =>  (i  +  1) % 4  return (    <VisGraph layoutType="parallel" layoutNodeGroup={layoutNodeGroup}/>  )}
```

component.ts

```
@Component({  template: \`    <vis-graph      layoutType="parallel"       [layoutNodeGroup]="layoutNodeGroup"    ></vis-graph>  \`})export class Component {  @Input data: NodeData;  layoutNodeGroup = (d: NodeDatum, i: number) =>  (i  +  1) % 4}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisGraph } from '@unovis/svelte'  export let data: NodeData  const layoutNodeGroup = (d: NodeDatum, i: number) =>  (i  +  1) % 4</script><VisGraph layoutType="parallel" {layoutNodeGroup}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisGraph } from '@unovis/vue'const props = defineProps<{ data: NodeData }>()const layoutNodeGroup = (d: NodeDatum, i: number) =>  (i  +  1) % 4</script><template>  <VisGraph layoutType="parallel" :layoutNodeGroup="layoutNodeGroup" /></template>
```

component.tsx

```
function Component(props) {  const data: NodeData = () => props.data  const layoutNodeGroup = (d: NodeDatum, i: number) =>  (i  +  1) % 4  return (    <VisGraph layoutType="parallel" layoutNodeGroup={layoutNodeGroup}/>  )}
```

component.ts

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "parallel",   layoutNodeGroup: (d: NodeDatum, i: number) =>  (i  +  1) % 4})
```

Loading...

You can control the group spacing with the `layoutParallelGroupSpacing` property. By default, group spacing will be calculated automatically based on the size of the container.

Every group can also have sub-groups, which can be defined by providing the `layoutParallelNodeSubGroup` accessor function. When there are too many nodes inside one sub-group you can make them wrap and go onto the next column (or row in case of `GraphLayoutType.ParallelHorizontal`) by specifying the `layoutParallelNodesPerColumn` value.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  layoutType="parallel"   layoutNodeGroup={layoutNodeGroup}   layoutParallelNodeSubGroup={layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={2}/>
```

```
<vis-graph  layoutType="parallel"   [layoutNodeGroup]="layoutNodeGroup"   [layoutParallelNodeSubGroup]="layoutParallelNodeSubGroup"   [layoutParallelNodesPerColumn]="2"></vis-graph>
```

```
<VisGraph  layoutType="parallel"   {layoutNodeGroup}   {layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={2}/>
```

```
<VisGraph  layoutType="parallel"   :layoutNodeGroup="layoutNodeGroup"   :layoutParallelNodeSubGroup="layoutParallelNodeSubGroup"   :layoutParallelNodesPerColumn="2" />
```

```
<VisGraph  layoutType="parallel"   layoutNodeGroup={layoutNodeGroup}   layoutParallelNodeSubGroup={layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={2}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "parallel",   layoutNodeGroup,   layoutParallelNodeSubGroup,   layoutParallelNodesPerColumn: 2})
```

Loading...

The sub-groups will be placed on one column (or row in case of `GraphLayoutType.ParallelHorizontal`) by default. You can make them wrap and form more columns and rows by providing a `layoutParallelSubGroupsPerRow` value.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  layoutType="parallel"   layoutNodeGroup={layoutNodeGroup}   layoutParallelNodeSubGroup={layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={2}   layoutParallelSubGroupsPerRow={2}/>
```

```
<vis-graph  layoutType="parallel"   [layoutNodeGroup]="layoutNodeGroup"   [layoutParallelNodeSubGroup]="layoutParallelNodeSubGroup"   [layoutParallelNodesPerColumn]="2"   [layoutParallelSubGroupsPerRow]="2"></vis-graph>
```

```
<VisGraph  layoutType="parallel"   {layoutNodeGroup}   {layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={2}   layoutParallelSubGroupsPerRow={2}/>
```

```
<VisGraph  layoutType="parallel"   :layoutNodeGroup="layoutNodeGroup"   :layoutParallelNodeSubGroup="layoutParallelNodeSubGroup"   :layoutParallelNodesPerColumn="2"   :layoutParallelSubGroupsPerRow="2" />
```

```
<VisGraph  layoutType="parallel"   layoutNodeGroup={layoutNodeGroup}   layoutParallelNodeSubGroup={layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={2}   layoutParallelSubGroupsPerRow={2}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "parallel",   layoutNodeGroup,   layoutParallelNodeSubGroup,   layoutParallelNodesPerColumn: 2,   layoutParallelSubGroupsPerRow: 2})
```

Loading...

Here's a diagram showing the anatomy of the parallel layouts and their configuration properties: 

#### Fine-tuning Node and Sub-group Spacing [](#fine-tuning-node-and-sub-group-spacing "Direct link to Fine-tuning Node and Sub-group Spacing")

You can control the spacing between nodes and sub-groups with additional spacing properties:

- `layoutParallelGroupSpacing`: Controls spacing between main groups (columns or rows). By default, calculated automatically based on container size.
- `layoutParallelNodeSpacing`: Controls spacing between individual nodes. Can be a single number (for uniform spacing) or an array `[horizontal, vertical]` for different horizontal and vertical spacing.
- `layoutParallelSubGroupSpacing`: Controls spacing between sub-groups. Default is `40` pixels.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  layoutType="parallel"   layoutNodeGroup={layoutNodeGroup}   layoutParallelNodeSubGroup={layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={3}   layoutParallelSubGroupsPerRow={2}   layoutParallelGroupSpacing={150}   layoutParallelNodeSpacing={[20,20]}   layoutParallelSubGroupSpacing={40}/>
```

```
<vis-graph  layoutType="parallel"   [layoutNodeGroup]="layoutNodeGroup"   [layoutParallelNodeSubGroup]="layoutParallelNodeSubGroup"   [layoutParallelNodesPerColumn]="3"   [layoutParallelSubGroupsPerRow]="2"   [layoutParallelGroupSpacing]="150"   [layoutParallelNodeSpacing]="[20,20]"   [layoutParallelSubGroupSpacing]="40"></vis-graph>
```

```
<VisGraph  layoutType="parallel"   {layoutNodeGroup}   {layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={3}   layoutParallelSubGroupsPerRow={2}   layoutParallelGroupSpacing={150}   layoutParallelNodeSpacing={[20,20]}   layoutParallelSubGroupSpacing={40}/>
```

```
<VisGraph  layoutType="parallel"   :layoutNodeGroup="layoutNodeGroup"   :layoutParallelNodeSubGroup="layoutParallelNodeSubGroup"   :layoutParallelNodesPerColumn="3"   :layoutParallelSubGroupsPerRow="2"   :layoutParallelGroupSpacing="150"   :layoutParallelNodeSpacing="[20,20]"   :layoutParallelSubGroupSpacing="40" />
```

```
<VisGraph  layoutType="parallel"   layoutNodeGroup={layoutNodeGroup}   layoutParallelNodeSubGroup={layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={3}   layoutParallelSubGroupsPerRow={2}   layoutParallelGroupSpacing={150}   layoutParallelNodeSpacing={[20,20]}   layoutParallelSubGroupSpacing={40}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "parallel",   layoutNodeGroup,   layoutParallelNodeSubGroup,   layoutParallelNodesPerColumn: 3,   layoutParallelSubGroupsPerRow: 2,   layoutParallelGroupSpacing: 150,   layoutParallelNodeSpacing: [20,20],   layoutParallelSubGroupSpacing: 40})
```

Loading...

### Circular and Concentric [](#circular-and-concentric "Direct link to Circular and Concentric")

There are two circular layout types available: `GraphLayoutType.Circular` (`"circular"`) and `GraphLayoutType.Concentric` (`"concentric"`). The first one just places all the nodes along one circle, the second one allows you to define multiple concentric circles with the `layoutNodeGroup` accessor function.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph layoutType="circular" layoutNodeGroup={layoutNodeGroup}/>
```

```
<vis-graph  layoutType="circular"   [layoutNodeGroup]="layoutNodeGroup"></vis-graph>
```

```
<VisGraph layoutType="circular" {layoutNodeGroup}/>
```

```
<VisGraph layoutType="circular" :layoutNodeGroup="layoutNodeGroup" />
```

```
<VisGraph layoutType="circular" layoutNodeGroup={layoutNodeGroup}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "circular",   layoutNodeGroup})
```

Loading...

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph layoutType="concentric" layoutNodeGroup={layoutNodeGroup}/>
```

```
<vis-graph  layoutType="concentric"   [layoutNodeGroup]="layoutNodeGroup"></vis-graph>
```

```
<VisGraph layoutType="concentric" {layoutNodeGroup}/>
```

```
<VisGraph layoutType="concentric" :layoutNodeGroup="layoutNodeGroup" />
```

```
<VisGraph layoutType="concentric" layoutNodeGroup={layoutNodeGroup}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "concentric",   layoutNodeGroup})
```

Loading...

### Dagre [](#dagre "Direct link to Dagre")

_Graph_ also supports Dagre layout, which works especially well for trees and directed acyclic graphs. Dagre can be enabled by setting `layoutType` to `GraphLayoutType.Dagre` (`"dagre"`). You can configure the layout by providing a Dagre configuration object to `dagreLayoutSettings`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  layoutType="dagre"   dagreLayoutSettings={dagreLayoutSettings}/>
```

```
<vis-graph  layoutType="dagre"   [dagreLayoutSettings]="dagreLayoutSettings"></vis-graph>
```

```
<VisGraph layoutType="dagre" {dagreLayoutSettings}/>
```

```
<VisGraph  layoutType="dagre"   :dagreLayoutSettings="dagreLayoutSettings" />
```

```
<VisGraph  layoutType="dagre"   dagreLayoutSettings={dagreLayoutSettings}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "dagre",   dagreLayoutSettings})
```

Loading...

### ELK [](#elk "Direct link to ELK")

Starting from Unovis version 1.1.0 _Graph_ supports The Eclipse Layout Kernel which has several layout algorithms available. You can enable ELK by setting `layoutType` to `GraphLayoutType.Elk` (or `"elk"`) and providing the layout configuration via the `layoutElkSettings` property.

The default configuration is provided for the ELK Layered algorithm which works with hierarchical nodes structure. Since _Graph's_ data model doesn't support hierarchy, we allow specifying it externally via the `layoutElkNodeGroups` property as an array of grouping function. For example, if your nodes have `group` and `subGroup` properties, you can set `layoutElkNodeGroups` to `[d => d.group, d => d.subGroup]` and _Graph_ will automatically generate hierarchical data structure for ELK.

Additionally, you can specify individual layout configuration for each group (or layer in the ELK's terms) by providing a function to `layoutElkSettings` that receives group name as its only argument, and returns an ELK layout configuration object:

```
layoutElkSettings: layer => {  switch (layer) {    case 'root': return { ... }    case 'group1': return { ... }    ...  }}
```

The ELK Layered algorithm works best when combined with [panels](#panels), allowing you to highlight the hierarchical nature of your graph data. Check out the ELK example in the gallery to learn more.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  layoutType="elk"   layoutElkNodeGroups={layoutElkNodeGroups}   nodeLabel={nodeLabel}   panels={panels}/>
```

```
<vis-graph  layoutType="elk"   [layoutElkNodeGroups]="layoutElkNodeGroups"   [nodeLabel]="nodeLabel"   [panels]="panels"></vis-graph>
```

```
<VisGraph layoutType="elk" {layoutElkNodeGroups} {nodeLabel} {panels}/>
```

```
<VisGraph  layoutType="elk"   :layoutElkNodeGroups="layoutElkNodeGroups"   :nodeLabel="nodeLabel"   :panels="panels" />
```

```
<VisGraph  layoutType="elk"   layoutElkNodeGroups={layoutElkNodeGroups}   nodeLabel={nodeLabel}   panels={panels}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "elk",   layoutElkNodeGroups,   nodeLabel,   panels})
```

Loading...

### Precalculated [](#precalculated "Direct link to Precalculated")

If you want to specify node locations, set `layoutType` to `GraphLayoutType.Precalculated`(or `"precalculated"`). Then pass in node positions (`x` and `y`) as part of graph data.

Note: if you selected `GraphLayoutType.Precalculated` but fail to pass in `x` and `y`, all your nodes will render at the default positions.

### Non-connected nodes aside [](#non-connected-nodes-aside "Direct link to Non-connected nodes aside")

If you want non-connected graph nodes to be placed below the layout, set `layoutNonConnectedAside` to `true`.

### Post-Layout Customization `1.5`[](#post-layout-customization-15 "Direct link to post-layout-customization-15")

The `Graph` component includes a `onLayoutCalculated` callback, which provides an opportunity to adjust the positions or properties of nodes and links after the layout has been calculated. This can be useful if you need to make final tweaks or apply additional logic once the layout is determined.

This callback function is triggered with the calculated node and link arrays, allowing you to inspect and modify their properties directly. For example, you can use this callback to enforce specific positioning constraints or adjust node/link styles.

Here's a basic example that demonstrates how to use the `onLayoutCalculated` callback to adjust node positions:

```
const onLayoutCalculated = (nodes: GraphNode<N, L>[], links: GraphLink<N, L>[]) => {  // Modify nodes based on custom criteria  nodes.forEach(node => {    if (node.group === 'special') {      // Set specific positions or styles for nodes in the 'special' group      node.x += 50;      node.y -= 30;    }  });};
```

## Fitting the graph into container [](#fitting-the-graph-into-container "Direct link to Fitting the graph into container")

_Graph_ automatically fits the layout to the container size on every config or data update. However, when the user has moved or zoomed the graph there's some level of tolerance after which automatic fitting will be disabled. The tolerance value can be tweaked with the `layoutAutofitTolerance` property (default value is 8.0):

- `0` — Stop fitting after any pan or zoom;
- `Number.POSITIVE_INFINITY` — Always fit;

You can control the padding around the graph when fitting to the container with the `fitViewPadding` property. The default padding is `50` pixels, but you can specify different values for each side using the `Spacing` object type: `{ top, right, bottom, left }`.

Additionally, you can set the alignment of the graph when fitting to the container using the `fitViewAlign` property. The default is `GraphFitViewAlignment.Center`, but you can also use `GraphFitViewAlignment.Top` or other available alignment options.

If you need to re-enable autofit after the graph has been panned or zoomed, you can do so by calling the public `resetAutofitState()` method of the component instance.

To disable the autofit behavior completely set `layoutAutofit` to `false`.

## Panels [](#panels "Direct link to Panels")

When you use one of the parallel layouts, it can be useful to draw panels around groups and sub-groups. You can define your set of panels by providing an array of `GraphPanelConfig` to the `panels` configuration property.

```
type GraphPanelConfig = {  /** Panel nodes references by unique ids */  nodes: (string|number)[];  /** Panel label */  label?: string;  /** Trim label if it's longer than this number of characters */  labelTrimLength?: number;  /** Trim mode of the label */  labelTrimMode?: TrimMode;  /** Position of the label */  labelPosition?: Position.Top | Position.Bottom | string;  /** Fill color of the panel */  fillColor?: string;  /** Color of the panel's border */  borderColor?: string;  /** Border width of the panel in pixels */  borderWidth?: number;  /** Inner padding */  padding?: number | Spacing;  /** Dashed outline showing that the panel is selected */  dashedOutline?: boolean;  /** Side icon symbol */  sideIconSymbol?: string;  /** Size of the icon as a CSS string. e.g.: \`12pt\` or \`12px\` */  sideIconFontSize?: string;  /** Color of the icon */  sideIconSymbolColor?: string;  /** Shape of the icon's background */  sideIconShape?: GraphNodeShape | string;  /** Size of the icon's background shape */  sideIconShapeSize?: number;  /** Stroke color of the icon's background shape */  sideIconShapeStroke?: string;  /** Cursor, when hovering over the icon */  sideIconCursor?: string;}
```

The only thing you need to do to define a panel is to provide an array of node ids — the panel will be drawn around them. Here is an example of a graph, that has the following panels configuration:

```
const panels = [{  nodes: [...],  label: 'Group 1',  color: '#E3116C',  padding: 1,  dashedOutline: true,  sideIconSymbol: '⚾',  sideIconShape: 'circle',  sideIconShapeStroke: '#777',  sideIconCursor: 'pointer',  sideIconFontSize: '24pt',  sideIconShapeSize: 58,}]
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisGraph  layoutType="parallel"   layoutNodeGroup={layoutNodeGroup}   layoutParallelNodeSubGroup={layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={5}   panels={panels}/>
```

```
<vis-graph  layoutType="parallel"   [layoutNodeGroup]="layoutNodeGroup"   [layoutParallelNodeSubGroup]="layoutParallelNodeSubGroup"   [layoutParallelNodesPerColumn]="5"   [panels]="panels"></vis-graph>
```

```
<VisGraph  layoutType="parallel"   {layoutNodeGroup}   {layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={5}   {panels}/>
```

```
<VisGraph  layoutType="parallel"   :layoutNodeGroup="layoutNodeGroup"   :layoutParallelNodeSubGroup="layoutParallelNodeSubGroup"   :layoutParallelNodesPerColumn="5"   :panels="panels" />
```

```
<VisGraph  layoutType="parallel"   layoutNodeGroup={layoutNodeGroup}   layoutParallelNodeSubGroup={layoutParallelNodeSubGroup}   layoutParallelNodesPerColumn={5}   panels={panels}/>
```

```
const graph = new Graph<NodeDatum, LinkDatum>({  layoutType: "parallel",   layoutNodeGroup,   layoutParallelNodeSubGroup,   layoutParallelNodesPerColumn: 5,   panels})
```

Loading...

The default panel appearance can be controlled with these CSS variables:

```
  --vis-graph-panel-border-color: #E6E9F3;  --vis-graph-panel-border-opacity: 0.9;  --vis-graph-panel-fill-color: #ffffff;  --vis-graph-panel-label-color: #6c778c;  --vis-graph-panel-label-background: #ffffff;  --vis-graph-panel-label-font-family: var(--vis-font-family);  --vis-graph-panel-label-font-size: 10pt;  --vis-graph-panel-label-font-weight: 300;  --vis-graph-panel-dashed-outline-color: #b7b7b7;  --vis-graph-panel-side-icon-symbol-color: #9ea7b8;  --vis-graph-panel-side-icon-shape-fill-color: #ffffff;  /* Dark Theme */  --vis-dark-graph-panel-border-color: var(--vis-color-grey);  --vis-dark-graph-panel-fill-color: #292b34;  --vis-dark-graph-panel-label-color: #E6E9F3;  --vis-dark-graph-panel-label-background: var(--vis-color-grey);  --vis-dark-graph-panel-side-icon-symbol-color: #ffffff;  --vis-dark-graph-panel-side-icon-shape-fill-color: #6c778c;  --vis-dark-graph-panel-border-color: #a0a6ad;
```

The side icon font family can be set with the `--vis-graph-icon-font-family` CSS variable.

## Selecting nodes and links [](#selecting-nodes-and-links "Direct link to Selecting nodes and links")

Node and link selection can be set via the config of the graph, which has two dedicated properties for that: `selectedNodeId` and `selectedLinkId`. When a node or link is selected, the graph will highlight it as well as the nodes it is connected to.

If you want to be able to select a node or a link by clicking on them, you can achieve that by setting up an event that will update `selectedNodeId` or `selectedLinkId` configuration property of your _Graph_ component.

```
const events = {  [Graph.selectors.node]: {      click: (d: GraphNode) => {          // Set the selected node id here, e.g.: config.selectedNodeId = d.id          // and trigger the component update if required by your UI framework       }  },}
```

## Pan / Zoom / Drag [](#pan--zoom--drag "Direct link to Pan / Zoom / Drag")

By default, you can pan / zoom the graph and drag its nodes around. That behavior can be disabled by setting the `disableZoom` and `disableDrag` properties to `false` respectively.

The maximum and minimum zoom levels can be set with the `zoomScaleExtent` property (default is `[0.35, 1.25]`).

You can also provide a callback function to `onZoom` if you want to have some custom reaction when the graph is being panned or zoomed.

_Graph_ implements a set of public methods to allow you controlling the view externally:

```
public zoomIn (increment: number)public zoomOut (increment: number)public setZoom (zoomLevel: number)public fitView ()public fitViewToBounds (xExtent?: [number, number], yExtent?: [number, number], duration?: number, alignment?: GraphFitViewAlignment)
```

If you use React or Angular, you can access the component instance for calling these methods by using `useRef` or `ViewChild` respectively.

### Callbacks [](#callbacks "Direct link to Callbacks")

The _Graph_ component supports a comprehensive set of interaction callbacks, giving you control over node dragging, zooming/panning. These callbacks allow you to add custom behavior and responses during user interactions, enhancing the interactivity and responsiveness of the graph.

#### Node Dragging Callbacks [](#node-dragging-callbacks "Direct link to Node Dragging Callbacks")

You can define custom actions for node dragging with the following callbacks:

- `onNodeDragStart`: Triggered when a node drag starts.
- `onNodeDrag`: Called continuously as a node is being dragged.
- `onNodeDragEnd`: Invoked when a node drag operation ends.

Each of these callbacks receives the node data and the drag event, allowing for actions such as updating other elements based on the dragged node's position or applying visual effects during the drag.

```
onNodeDragStart: (n: GraphNode<N, L>, event: D3DragEvent<SVGGElement, GraphNode<N, L>, unknown>) => void | undefined;onNodeDrag: (n: GraphNode<N, L>, event: D3DragEvent<SVGGElement, GraphNode<N, L>, unknown>) => void | undefined;onNodeDragEnd: (n: GraphNode<N, L>, event: D3DragEvent<SVGGElement, GraphNode<N, L>, unknown>) => void | undefined;
```

#### Zoom and Pan Callbacks [](#zoom-and-pan-callbacks "Direct link to Zoom and Pan Callbacks")

For handling zoom and pan interactions, you can use these callbacks:

- `onZoomStart`: Fires when a zoom or pan operation begins.
- `onZoom`: Triggered continuously during zooming or panning, providing the current zoom scale and transform details.
- `onZoomEnd`: Called when zooming or panning ends.

These callbacks allow you to dynamically adjust graph elements, update UI components, or log zoom and pan activities.

```
onZoom: (zoomScale: number, zoomScaleExtent: [number, number], event: D3ZoomEvent<SVGGElement, unknown> | undefined, transform: ZoomTransform) => void;onZoomStart: (zoomScale: number, zoomScaleExtent: [number, number], event: D3ZoomEvent<SVGGElement, unknown> | undefined, transform: ZoomTransform) => void;onZoomEnd: (zoomScale: number, zoomScaleExtent: [number, number], event: D3ZoomEvent<SVGGElement, unknown> | undefined, transform: ZoomTransform) => void;
```

## Multiple Node Drag [](#multiple-node-drag "Direct link to Multiple Node Drag")

To drag multiple nodes at once, the node selection brush can be activated with the shift key. This behavior can be disabled by setting the `disableBrush` property to `true`.

While the shift key is pressed, multiple nodes can be brushed by dragging the mouse over them. When the mouse releases, the selected nodes will be grouped inside a selection rectangle, which can be dragged around as a single entity.

Releasing the shift key will unselect all nodes and hide the selection rectangle.

The brush selection rectangle opacity can be changed with the `--vis-graph-brush-selection-opacity` CSS variable. The appearance of the "brushed" nodes can be customized with the following CSS variables:

```
--vis-graph-brushed-node-stroke-color;--vis-graph-brushed-node-label-text-color;--vis-graph-brushed-node-icon-fill-color;
```

### Callbacks [](#callbacks-1 "Direct link to Callbacks")

Additionally, there are two callback functions in _Graph_'s configuration that can be used to see which nodes are being brushed and dragged:

- `onNodeSelectionBrush`: Fires when nodes are selected using the brushing tool. It provides an array of selected nodes and the brush event, making it ideal for grouping or highlighting nodes.
- `onNodeSelectionDrag`: Called during a multi-node drag operation, enabling you to manage grouped node movements or apply custom interactions.

```
onNodeSelectionBrush: (selectedNodes: GraphNode<N, L>[], event: D3BrushEvent<SVGGElement> | undefined) => void;onNodeSelectionDrag: (selectedNodes: GraphNode<N, L>[], event: D3DragEvent<SVGGElement, GraphNode<N, L>, unknown>) => void;
```

## Post-Render Customization `1.5`[](#post-render-customization-15 "Direct link to post-render-customization-15")

The _Graph_ component provides an `onRenderComplete` callback function that allows you to add custom elements to the graph's canvas after the rendering is fully complete. This function is especially useful for layering additional elements or annotations on top of the existing nodes and links.

This callback receives several parameters, including the canvas selection (`g`),arrays of nodes and links, and configuration details. With this access, you can append, update, or transform elements as needed to enhance the visual output.

```
onRenderComplete (  g: Selection<SVGGElement, unknown, null, undefined>,  nodes: GraphNode<N, L>[],  links: GraphLink<N, L>[],  config: GraphConfigInterface<N, L>,  duration: number,  zoomLevel: number,  width: number,  height: number) => void;
```

## Events [](#events "Direct link to Events")

The following selectors are available for events:

```
import { Graph } from '@unovis/ts'const events = {    [Graph.selectors.root]: { ... },    [Graph.selectors.background]: { ... },    [Graph.selectors.node]: { ... },    [Graph.selectors.nodeShape]: { ... },    [Graph.selectors.nodeGauge]: { ... },    [Graph.selectors.nodeSideLabel]: { ... },    [Graph.selectors.nodeLabel]: { ... },    [Graph.selectors.link]: { ... },    [Graph.selectors.linkLine]: { ... },    [Graph.selectors.panel]: { ... },    [Graph.selectors.panelRect]: { ... },    [Graph.selectors.panelSelection]: { ... },    [Graph.selectors.panelLabel]: { ... },    [Graph.selectors.panelLabelText]: { ... },    [Graph.selectors.panelSideIcon]: { ... },    [Graph.selectors.panelSideIconShape]: { ... },    [Graph.selectors.panelSideIconSymbol]: { ... },}
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |