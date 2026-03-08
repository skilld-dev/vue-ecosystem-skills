---
title: "Chord Diagram | Unovis"
meta:
  "og:description": "Basic Configuration"
  "og:title": "Chord Diagram | Unovis"
  description: "Basic Configuration"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The _Chord Diagram_ component is a variation of a network graph where nodes and links are displayed in a circular layout.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisSingleContainer data={data}>  <VisChordDiagram/></VisSingleContainer>
```

template.html

```
<vis-single-container [data]="data">  <vis-chord-diagram></vis-chord-diagram></vis-single-container>
```

component.svelte

```
<VisSingleContainer {data}>  <VisChordDiagram/></VisSingleContainer>
```

component.vue

```
<VisSingleContainer :data="data">  <VisChordDiagram /></VisSingleContainer>
```

component.tsx

```
<VisSingleContainer data={data}>  <VisChordDiagram/></VisSingleContainer>
```

component.ts

```
const container = new SingleContainer<ChordInputNode,ChordLinkDatum>(node, {  component: new ChordDiagram({ })}, data)
```

Loading...

where data types look like:

```
type ChordInputNode = {    id?: string;}type ChordInputLink = {    source: number | string | ChordInputNode;    target: number | string | ChordInputNode;    value: number;}type ChordData<ChordInputNode, ChordInputLink> = {  nodes: ChordInputNode[];  links: ChordInputLink[];}
```

## Node Label [](#node-label "Direct link to Node Label")

You can supply node labels through that data as a property of `ChordInputNode`, or by using a `StringAccessor` function in the component:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: ChordData = props.data  const nodeLabel = (d: ChordInputNode) =>  \`${d.id}\`  return (    <VisChordDiagram nodeLabel={nodeLabel}/>  )}
```

component.ts

```
@Component({  template: '<vis-chord-diagram [nodeLabel]="nodeLabel"></vis-chord-diagram>'})export class Component {  @Input data: ChordData;  nodeLabel = (d: ChordInputNode) =>  \`${d.id}\`}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisChordDiagram } from '@unovis/svelte'  export let data: ChordData  const nodeLabel = (d: ChordInputNode) =>  \`${d.id}\`</script><VisChordDiagram {nodeLabel}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisChordDiagram } from '@unovis/vue'const props = defineProps<{ data: ChordData }>()const nodeLabel = (d: ChordInputNode) =>  \`${d.id}\`</script><template>  <VisChordDiagram :nodeLabel="nodeLabel" /></template>
```

component.tsx

```
function Component(props) {  const data: ChordData = () => props.data  const nodeLabel = (d: ChordInputNode) =>  \`${d.id}\`  return (    <VisChordDiagram nodeLabel={nodeLabel}/>  )}
```

component.ts

```
const chordDiagram = new ChordDiagram<ChordInputNode,ChordLinkDatum>({  nodeLabel: (d: ChordInputNode) =>  \`${d.id}\`})
```

Loading...

## Node Label Alignment [](#node-label-alignment "Direct link to Node Label Alignment")

By default, the labels will be placed inside the node with respect to the curve. Alternatively, you can set `nodeLabelAlignment` to _perpendicular_:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisChordDiagram  nodeLabel={nodeLabel}   nodeLabelAlignment="perpendicular"/>
```

```
<vis-chord-diagram  [nodeLabel]="nodeLabel"   nodeLabelAlignment="perpendicular"></vis-chord-diagram>
```

```
<VisChordDiagram {nodeLabel} nodeLabelAlignment="perpendicular"/>
```

```
<VisChordDiagram  :nodeLabel="nodeLabel"   nodeLabelAlignment="perpendicular" />
```

```
<VisChordDiagram  nodeLabel={nodeLabel}   nodeLabelAlignment="perpendicular"/>
```

```
const chordDiagram = new ChordDiagram<ChordInputNode,ChordLinkDatum>({  nodeLabel,   nodeLabelAlignment: "perpendicular"})
```

Loading...

## Node and Link Colors [](#node-and-link-colors "Direct link to Node and Link Colors")

You can provide color accessors for the nodes, and links to customize the color of your chart.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisChordDiagram nodeColor={nodeColor} linkColor={linkColor}/>
```

```
<vis-chord-diagram  [nodeColor]="nodeColor"   [linkColor]="linkColor"></vis-chord-diagram>
```

```
<VisChordDiagram {nodeColor} {linkColor}/>
```

```
<VisChordDiagram :nodeColor="nodeColor" :linkColor="linkColor" />
```

```
<VisChordDiagram nodeColor={nodeColor} linkColor={linkColor}/>
```

```
const chordDiagram = new ChordDiagram<ChordInputNode,ChordLinkDatum>({  nodeColor,   linkColor})
```

Loading...

## Circle Customization [](#circle-customization "Direct link to Circle Customization")

You can change the appearance of your circular chart with the following related properties from _Donut_:

- `angleRange`
- `cornerRadius`
- `padAngle`

## Hierarchical data [](#hierarchical-data "Direct link to Hierarchical data")

_ChordDiagram_ supports hierarchical data. When you provide `nodeLevels` with a list of properties, nodes will be displayed as `n` distinct layers, where `n` is the number of properties provided.

Consider the following example, where data has the following type:

```
const data = {  nodes: [    { id: 'A1', group: 'Level 1', subgroup: 'A'},    { id: 'B1', group: 'Level 1', subgroup: 'B' },    ...  ],  links: [...]}
```

Then, by providing this list we can see three distinct layers in the visualization:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisChordDiagram } from '@unovis/react'function Component(props) {  const data: ChordData = props.data  const nodeLevels = [\`group\`, \`subgroup\`]  return (    <VisSingleContainer data={data}>      <VisChordDiagram nodeLevels={nodeLevels}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: ChordData;  nodeLevels = [\`group\`, \`subgroup\`]}
```

template.html

```
<vis-single-container [data]="data">  <vis-chord-diagram [nodeLevels]="nodeLevels"></vis-chord-diagram></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisChordDiagram } from '@unovis/svelte'  export let data: ChordData  const nodeLevels = [\`group\`, \`subgroup\`]</script><VisSingleContainer {data}>  <VisChordDiagram {nodeLevels}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisChordDiagram } from '@unovis/vue'const props = defineProps<{ data: ChordData }>()const nodeLevels = [\`group\`, \`subgroup\`]</script><template>  <VisSingleContainer :data="data">    <VisChordDiagram :nodeLevels="nodeLevels" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisChordDiagram } from '@unovis/solid'function Component(props) {  const data: ChordData = () => props.data  const nodeLevels = [\`group\`, \`subgroup\`]  return (    <VisSingleContainer data={data()}>      <VisChordDiagram nodeLevels={nodeLevels}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, ChordDiagram } from '@unovis/ts'import { data, ChordInputNode, ChordLinkDatum } from './data'const container = new SingleContainer<ChordInputNode,ChordLinkDatum>(node, {  component: new ChordDiagram<ChordInputNode,ChordLinkDatum>({    nodeLevels: [\`group\`, \`subgroup\`]  })}, data)
```

Loading...

### Accessor functions with hierarchical nodes [](#accessor-functions-with-hierarchical-nodes "Direct link to Accessor functions with hierarchical nodes")

Because internal nodes are generated and not provided as apart of the original data, the accessor functions for nodes in _ChordDiagram_ will have a different parameter type of `N | ChordHierarchyNode<N>`. Leaf nodes will still have the input datum type, `N` and non-leaf nodes have the following type:

```
type ChordHierarchyNode<N> = {  /* The property name (i.e. 'A') */  key: string;  /*  Array of descendant nodes */  values: (N | ChordHierarchyNode<N>)[];  /* Zero for the root node, and increasing by one for each descendant generation */  depth: number;  /* Zero for leaf nodes, and the greatest distance from any descendant leaf for internal nodes */  height: number;  /* Aggregated value calcualted from link data */  value: number;  /* Key values for the ancestor nodes. i.e ['A', 'Level 1', 'root'] */  ancestors: string[];}
```

In cases where you want to customize the appearance of internal nodes you can refer to this type.

For example, consider the following case where you want a 2-level chart grouped by the key provided in `nodeLevels`. We can adjust the accessor functions to change the label and color configuration for inner nodes like so:

```
// Node datumtype N = {  label: string;  group: 'A' | 'B' | 'C'}const colors =  { A: 'lightgreen', B: 'cornflowerblue', C: 'indigo'}// Configurationconst nodeLevels = ['group']const nodeLabel = (d: N | ChordHierarchyNode<N>) => (d as N).label ?? \`${d.key}: ${colors[d.key]}\`const nodeColor = (d: N | ChordHierarchyNode<N>) => colors[d.key ?? d.group]const nodeLabelAlignment = (d: N | ChordHierarchyNode<N>) => d.height > 0 ? 'along' : 'perpendicular'
```

The result gives us a _Chord Diagram_ with color-coded group data:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisChordDiagram  nodeLevels={nodeLevels}   nodeColor={nodeColor}   nodeLabel={nodeLabel}   nodeLabelAlignment={nodeLabelAlignment}/>
```

```
<vis-chord-diagram  [nodeLevels]="nodeLevels"   [nodeColor]="nodeColor"   [nodeLabel]="nodeLabel"   [nodeLabelAlignment]="nodeLabelAlignment"></vis-chord-diagram>
```

```
<VisChordDiagram  {nodeLevels}   {nodeColor}   {nodeLabel}   {nodeLabelAlignment}/>
```

```
<VisChordDiagram  :nodeLevels="nodeLevels"   :nodeColor="nodeColor"   :nodeLabel="nodeLabel"   :nodeLabelAlignment="nodeLabelAlignment" />
```

```
<VisChordDiagram  nodeLevels={nodeLevels}   nodeColor={nodeColor}   nodeLabel={nodeLabel}   nodeLabelAlignment={nodeLabelAlignment}/>
```

```
const chordDiagram = new ChordDiagram<ChordInputNode,ChordLinkDatum>({  nodeLevels,   nodeColor,   nodeLabel,   nodeLabelAlignment})
```

Loading...

### Radius Scale Exponent [](#radius-scale-exponent "Direct link to Radius Scale Exponent")

The `radiusScaleExponent` property affects how the radii scale with each hierarchy level. Increasing this value will result in more distance between each level, while decreasing results in the opposite. Default = `2`.

`radiusScaleExponent :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisChordDiagram radiusScaleExponent={0.75} nodeLevels={nodeLevels}/>
```

```
<vis-chord-diagram  [radiusScaleExponent]="0.75"   [nodeLevels]="nodeLevels"></vis-chord-diagram>
```

```
<VisChordDiagram radiusScaleExponent={0.75} {nodeLevels}/>
```

```
<VisChordDiagram  :radiusScaleExponent="0.75"   :nodeLevels="nodeLevels" />
```

```
<VisChordDiagram radiusScaleExponent={0.75} nodeLevels={nodeLevels}/>
```

```
const chordDiagram = new ChordDiagram<ChordInputNode,ChordLinkDatum>({  radiusScaleExponent: 0.75,   nodeLevels})
```

Loading...

## Events [](#events "Direct link to Events")

```
import { ChordDiagram, ChordNode, ChordRibbon } from '@unovis/vis'events = {  [ChordDiagram.selectors.node]: {    mouseover: (d: ChordNode<N>) => {},    mouseout: (d: ChordNode<N>) => {},  },  [ChordDiagram.selectors.link]: {    mouseover: (d: ChornRibbon<N>) => {},    mouseout: (d: ChornRibbon<N>) => {},  },}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisChordDiagram events={events}/>
```

```
<vis-chord-diagram [events]="events"></vis-chord-diagram>
```

```
<VisChordDiagram {events}/>
```

```
<VisChordDiagram :events="events" />
```

```
<VisChordDiagram events={events}/>
```

```
const chordDiagram = new ChordDiagram<ChordInputNode,ChordLinkDatum>({ events })
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

<details>

<summary>All supported CSS variables</summary>



```
--vis-chord-diagram-link-fill-color: #cad5f6;--vis-chord-diagram-link-stroke-color: #777777;--vis-chord-diagram-link-stroke-opacity: 0.15;--vis-chord-diagram-label-text-fill-color-bright: #ffffff;--vis-chord-diagram-label-text-fill-color-dark: #a5abb2;/* Dark theme */--vis-dark-chord-diagram-link-fill-color: #575c65;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |