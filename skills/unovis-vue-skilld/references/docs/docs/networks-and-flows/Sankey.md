---
title: "Sankey | Unovis"
meta:
  "og:description": "Learn how to configure a Sankey Diagram"
  "og:title": "Sankey | Unovis"
  description: "Learn how to configure a Sankey Diagram"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

_Sankey_ is a popular kind of flow diagram that visualizes flows between multiple nodes. To define a Sankey diagram you'll need to have data about its nodes and flows between them.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisSankey } from '@unovis/react'function Component(props) {  const data: SankeyData = props.data  return (    <VisSingleContainer data={data}>      <VisSankey/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: SankeyData;}
```

template.html

```
<vis-single-container [data]="data">  <vis-sankey></vis-sankey></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisSankey } from '@unovis/svelte'  export let data: SankeyData</script><VisSingleContainer {data}>  <VisSankey/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisSankey } from '@unovis/vue'const props = defineProps<{ data: SankeyData }>()</script><template>  <VisSingleContainer :data="data">    <VisSankey />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisSankey } from '@unovis/solid'function Component(props) {  const data: SankeyData = () => props.data  return (    <VisSingleContainer data={data()}>      <VisSankey/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Sankey } from '@unovis/ts'import { data, SankeyNode,  SankeyLink } from './data'const container = new SingleContainer<SankeyNode, SankeyLink>(node, {  component: new Sankey<SankeyNode, SankeyLink>({ })}, data)
```

Loading...

Specifically, _Sankey_ accepts data in the following form:

```
type SankeyData<NodeDatum, LinkDatum> = {  nodes: NodeDatum[];  links: LinkDatum[];}
```

### Links [](#links "Direct link to Links")

The minimal configuration for a _Link_ datum contains `source` and `target` properties, which correspond to the starting and ending nodes of the link, and a numerical `value`.

```
type SankeyLink = {  source: string | number | SankeyNode;  target: string | number | SankeyNode;  value?: number;}
```

Note that the `value` is not required, but recommended since by default _Sankey_ will use this property to calculate the width of each link. Alternatively, you can provide a numeric accessor function to the `linkValue` property.

### Nodes [](#nodes "Direct link to Nodes")

While there are no explicitly required properties for `NodeDatum`, a common configuration looks like:

```
type SankeyNode = {  id: string;  color: string;  label: string;}
```

Alternatively, you can provide accessor functions to `id`, `nodeColor`, `nodeLabel` properties to achieve the same effect.

## Component Sizing [](#component-sizing "Direct link to Component Sizing")

_Sankey_ supports three different sizing options that can be set via _SingleContainer_: `Sizing.Fit` (default), `Sizing.Extend` and `Sizing.FitWidth`.

By default, _SingleContainer_ and _Sankey_ will take all the available space of its parent HTML element. However, if you set _SingleContainer_'s `sizing` to `Sizing.Extend` (or `"extend"`), the diagram will be able to go beyond its parent size and become scrollable. In that case you'll be able to control the diagram size by using the following properties: `nodeWidth`, `nodeHorizontalSpacing`, `nodeMinHeight`, `nodeMaxHeight`, and `nodePadding` (see Node Sizing).

The `Sizing.FitWidth` (or `"fit_width"`) option is similar to the `Sizing.Extend` option, but the whole component will be scaled down proportionally to fit horizontally into its container; vertical scrolling will remain available.

## Interactive Zoom and Pan [](#interactive-zoom-and-pan "Direct link to Interactive Zoom and Pan")

Zooming scales the Sankey layout (not individual SVG elements), preserving stroke widths and label sizes. Mouse wheel zoom and drag panning are supported.

- **enableZoom**: toggle interaction (default: `false`).
- **zoomMode**: `SankeyZoomMode.XY | SankeyZoomMode.X | SankeyZoomMode.Y` (default: `SankeyZoomMode.Y`).
- **zoomExtent**: allowed zoom range `[min, max]` (default: `[1, 5]`).
- **zoomScale**: `[horizontal, vertical]` layout scale factors (programmatic control).
- **zoomPan**: `[x, y]` pixel offsets (programmatic control).
- **onZoom**: callback `(hScale, vScale, panX, panY, extent, event) => void`.

Smart pan constraints prevent panning beyond diagram bounds.

`enableZoom :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisSankey enableZoom={true} label="Enable Zoom / Pan"/>
```

```
<vis-sankey [enableZoom]="true" label="Enable Zoom / Pan"></vis-sankey>
```

```
<VisSankey enableZoom={true} label="Enable Zoom / Pan"/>
```

```
<VisSankey :enableZoom="true" label="Enable Zoom / Pan" />
```

```
<VisSankey enableZoom={true} label="Enable Zoom / Pan"/>
```

```
const sankey = new Sankey<SankeyNode, SankeyLink>({  enableZoom: true,   label: "Enable Zoom / Pan"})
```

Loading...

## Labels [](#labels "Direct link to Labels")

The following customization options are available for _Node_ labels:

### Label Background [](#label-background "Direct link to Label Background")

For a chart with many nodes, it might be useful to add a background by setting the `labelBackground` property to `true`:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisSankey labelBackground={true}/>
```

```
<vis-sankey [labelBackground]="true"></vis-sankey>
```

```
<VisSankey labelBackground={true}/>
```

```
<VisSankey :labelBackground="true" />
```

```
<VisSankey labelBackground={true}/>
```

```
const sankey = new Sankey<SankeyNode, SankeyLink>({ labelBackground: true })
```

Loading...

### Label Fitting [](#label-fitting "Direct link to Label Fitting")

By default, node labels that exceed the width constraint will be trimmed to exclude the middle. For the following properties, the default configuration for _Sankey_ looks like:

```
{  labelFit: FitMode.Trim,  labelMaxWidth: 70,  labelTrimMode: TrimMode.Middle,  labelExpandTrimmedOnHover: true,}
```

For overflowing labels, the default configuration renders as:

Loading...

#### `FitMode.Wrap`[](#fitmodewrap "Direct link to fitmodewrap")

You can disable trimming by setting `labelFit` to `FitMode.Wrap` or `'wrap'`, which forces line breaking:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisSankey } from '@unovis/react'function Component(props) {  const data: SankeyData = props.data  const label = (d: SankeyNode) =>  \`Long node name :  ${d.id}\`  return (    <VisSingleContainer data={data}>      <VisSankey        label={label}         labelFit="wrap"         labelMaxWidth={80}         labelForceWordBreak={false}      />    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: SankeyData;  label = (d: SankeyNode) =>  \`Long node name :  ${d.id}\`}
```

template.html

```
<vis-single-container [data]="data">  <vis-sankey  [label]="label"   labelFit="wrap"   [labelMaxWidth]="80"   [labelForceWordBreak]="false"></vis-sankey></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisSankey } from '@unovis/svelte'  export let data: SankeyData  const label = (d: SankeyNode) =>  \`Long node name :  ${d.id}\`</script><VisSingleContainer {data}>  <VisSankey  {label}   labelFit="wrap"   labelMaxWidth={80}   labelForceWordBreak={false}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisSankey } from '@unovis/vue'const props = defineProps<{ data: SankeyData }>()const label = (d: SankeyNode) =>  \`Long node name :  ${d.id}\`</script><template>  <VisSingleContainer :data="data">    <VisSankey      :label="label"       labelFit="wrap"       :labelMaxWidth="80"       :labelForceWordBreak="false"     />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisSankey } from '@unovis/solid'function Component(props) {  const data: SankeyData = () => props.data  const label = (d: SankeyNode) =>  \`Long node name :  ${d.id}\`  return (    <VisSingleContainer data={data()}>      <VisSankey        label={label}         labelFit="wrap"         labelMaxWidth={80}         labelForceWordBreak={false}      />    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Sankey } from '@unovis/ts'import { data, SankeyNode,  SankeyLink } from './data'const container = new SingleContainer<SankeyNode, SankeyLink>(node, {  component: new Sankey<SankeyNode, SankeyLink>({    label: (d: SankeyNode) =>  \`Long node name :  ${d.id}\`,     labelFit: "wrap",     labelMaxWidth: 80,     labelForceWordBreak: false  })}, data)
```

Loading...

tip

When `labelFit` is set to `FitMode.Wrap`, you can change which characters to denote a new line with the `labelTextSeparator` property. (default: `[' ', '-']`).

#### `FitMode.Trim`[](#fitmodetrim "Direct link to fitmodetrim")

You can the `labelTrimMode` property to change which portion of the labels you want to trim:

`labelTrimMode :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisSankey labelTrimMode="start" label={label} labelMaxWidth={80}/>
```

```
<vis-sankey  labelTrimMode="start"   [label]="label"   [labelMaxWidth]="80"></vis-sankey>
```

```
<VisSankey labelTrimMode="start" {label} labelMaxWidth={80}/>
```

```
<VisSankey labelTrimMode="start" :label="label" :labelMaxWidth="80" />
```

```
<VisSankey labelTrimMode="start" label={label} labelMaxWidth={80}/>
```

```
const sankey = new Sankey<SankeyNode, SankeyLink>({  labelTrimMode: "start",   label,   labelMaxWidth: 80})
```

Loading...

### Label Placement [](#label-placement "Direct link to Label Placement")

The following properties deal with node label placement:

- `labelPosition`, which corresponds to the **horizontal** placement relative to the node (default: `Position.Auto`);
- `labelVerticalAlign`, for **vertical** alignment (default: `VerticalAlign.Middle`);
- `labelVisibility`, which accepts a custom function that when returns false, the label will be hidden altogether.

### Automatic Label Sizing [](#automatic-label-sizing "Direct link to Automatic Label Sizing")

Labels can optionally take the available horizontal space between nodes automatically.

- **labelMaxWidthTakeAvailableSpace**: enable automatic width (default: `false`).
- **labelMaxWidthTakeAvailableSpaceTolerance**: tolerance for available space calculation; by default computed from label and sub-label font sizes.
- Precedence: when provided, `labelMaxWidth` always overrides automatic sizing.

### Sub-labels [](#sub-labels "Direct link to Sub-labels")

You can add a secondary label with the `subLabel` property. Sub-label color and font size can be configured with the `subLabelColor` and `subLabelFontSize` properties.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: SankeyData = props.data  const label = (d: SankeyNode) =>  d.id  const subLabel = (d: SankeyNode) =>  d.val  return (    <VisSankey label={label} subLabel={subLabel}/>  )}
```

component.ts

```
@Component({  template: '<vis-sankey [label]="label" [subLabel]="subLabel"></vis-sankey>'})export class Component {  @Input data: SankeyData;  label = (d: SankeyNode) =>  d.id  subLabel = (d: SankeyNode) =>  d.val}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisSankey } from '@unovis/svelte'  export let data: SankeyData  const label = (d: SankeyNode) =>  d.id  const subLabel = (d: SankeyNode) =>  d.val</script><VisSankey {label} {subLabel}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisSankey } from '@unovis/vue'const props = defineProps<{ data: SankeyData }>()const label = (d: SankeyNode) =>  d.idconst subLabel = (d: SankeyNode) =>  d.val</script><template>  <VisSankey :label="label" :subLabel="subLabel" /></template>
```

component.tsx

```
function Component(props) {  const data: SankeyData = () => props.data  const label = (d: SankeyNode) =>  d.id  const subLabel = (d: SankeyNode) =>  d.val  return (    <VisSankey label={label} subLabel={subLabel}/>  )}
```

component.ts

```
const sankey = new Sankey<SankeyNode, SankeyLink>({  label: (d: SankeyNode) =>  d.id,   subLabel: (d: SankeyNode) =>  d.val})
```

Loading...

By default, sub-labels will be placed below the main labels. However, if you set the `subLabelPlacement` property to `SankeySubLabelPlacement.Inline` (or `"inline"`), they will be placed right next to the main label on the left or on the right (depending on `labelPosition`).

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisSankey  label={label}   subLabel={subLabel}   subLabelPlacement="inline"   subLabelToLabelInlineWidthRatio={0.7}/>
```

```
<vis-sankey  [label]="label"   [subLabel]="subLabel"   subLabelPlacement="inline"   [subLabelToLabelInlineWidthRatio]="0.7"></vis-sankey>
```

```
<VisSankey  {label}   {subLabel}   subLabelPlacement="inline"   subLabelToLabelInlineWidthRatio={0.7}/>
```

```
<VisSankey  :label="label"   :subLabel="subLabel"   subLabelPlacement="inline"   :subLabelToLabelInlineWidthRatio="0.7" />
```

```
<VisSankey  label={label}   subLabel={subLabel}   subLabelPlacement="inline"   subLabelToLabelInlineWidthRatio={0.7}/>
```

```
const sankey = new Sankey<SankeyNode, SankeyLink>({  label,   subLabel,   subLabelPlacement: "inline",   subLabelToLabelInlineWidthRatio: 0.7})
```

Loading...

### Label Text Decoration [](#label-text-decoration "Direct link to Label Text Decoration")

Customize text decoration for labels via:

- **labelTextDecoration**: accessor for main label decoration (e.g., `'underline'`, `'line-through'`).
- **subLabelTextDecoration**: accessor for sub-label decoration.

## Node Customization [](#node-customization "Direct link to Node Customization")

### Node Alignment [](#node-alignment "Direct link to Node Alignment")

You can override the default node alignment with the `nodeAlign` property. Accepted values are `SankeyNodeAlign.Left`, `SankeyNodeAlign.Right`, `SankeyNodeAlign.Center` and `SankeyNodeAlign.Justify` (default)

`nodeAlign :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisSankey nodeAlign="left"/>
```

```
<vis-sankey nodeAlign="left"></vis-sankey>
```

```
<VisSankey nodeAlign="left"/>
```

```
<VisSankey nodeAlign="left" />
```

```
<VisSankey nodeAlign="left"/>
```

```
const sankey = new Sankey<SankeyNode, SankeyLink>({ nodeAlign: "left" })
```

Loading...

### Node Sizing [](#node-sizing "Direct link to Node Sizing")

By default, the height of the nodes will be calculated automatically based on the height of _Sankey_'s container and the `nodePadding` property. The width of the nodes can be set with the `nodeWidth` configuration option (measurement is in pixels).

`nodeWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisSankey nodeWidth={100} nodePadding={20}/>
```

```
<vis-sankey [nodeWidth]="100" [nodePadding]="20"></vis-sankey>
```

```
<VisSankey nodeWidth={100} nodePadding={20}/>
```

```
<VisSankey :nodeWidth="100" :nodePadding="20" />
```

```
<VisSankey nodeWidth={100} nodePadding={20}/>
```

```
const sankey = new Sankey<SankeyNode, SankeyLink>({ nodeWidth: 100, nodePadding: 20 })
```

Loading...

If `sizing` of _SingleContainer_ is set to `Sizing.Extend` or `Sizing.FitWidth` (see Component Sizing), you can control the height of the nodes by setting the `nodeMinHeight` and `nodeMaxHeight` properties. Note that those options are approximate since d3-sankey doesn't allow setting the node height explicitly.

### Node Icons [](#node-icons "Direct link to Node Icons")

Provide an accessor function to `nodeIcon` to add a label/symbol over the node itself. Customize the icon's color with `iconColor`:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: SankeyData = props.data  const nodeIcon = (d: NodeDatum) => d.currencySymbol  return (    <VisSankey nodeIcon={nodeIcon} iconColor="white"/>  )}
```

component.ts

```
@Component({  template: '<vis-sankey [nodeIcon]="nodeIcon" iconColor="white"></vis-sankey>'})export class Component {  @Input data: SankeyData;  nodeIcon = (d: NodeDatum) => d.currencySymbol}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisSankey } from '@unovis/svelte'  export let data: SankeyData  const nodeIcon = (d: NodeDatum) => d.currencySymbol</script><VisSankey {nodeIcon} iconColor="white"/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisSankey } from '@unovis/vue'const props = defineProps<{ data: SankeyData }>()const nodeIcon = (d: NodeDatum) => d.currencySymbol</script><template>  <VisSankey :nodeIcon="nodeIcon" iconColor="white" /></template>
```

component.tsx

```
function Component(props) {  const data: SankeyData = () => props.data  const nodeIcon = (d: NodeDatum) => d.currencySymbol  return (    <VisSankey nodeIcon={nodeIcon} iconColor="white"/>  )}
```

component.ts

```
const sankey = new Sankey<SankeyNode, SankeyLink>({  nodeIcon: (d: NodeDatum) => d.currencySymbol,   iconColor: "white"})
```

Loading...

### Node Selection State [](#node-selection-state "Direct link to Node Selection State")

Use **selectedNodeIds: string[]** to programmatically set selected nodes. Selected nodes expose CSS variables for styling the selection outline:

- `--vis-sankey-node-selection-stroke-width`
- `--vis-sankey-node-selection-stroke-opacity`
- `--vis-sankey-node-selection-border-radius`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: SankeyData = props.data  const selectedNodeIds = [\`A\`, \`C\`]  return (    <VisSankey nodePadding={5} selectedNodeIds={selectedNodeIds}/>  )}
```

component.ts

```
@Component({  template: \`    <vis-sankey      [nodePadding]="5"       [selectedNodeIds]="selectedNodeIds"    ></vis-sankey>  \`})export class Component {  @Input data: SankeyData;  selectedNodeIds = [\`A\`, \`C\`]}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisSankey } from '@unovis/svelte'  export let data: SankeyData  const selectedNodeIds = [\`A\`, \`C\`]</script><VisSankey nodePadding={5} {selectedNodeIds}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisSankey } from '@unovis/vue'const props = defineProps<{ data: SankeyData }>()const selectedNodeIds = [\`A\`, \`C\`]</script><template>  <VisSankey :nodePadding="5" :selectedNodeIds="selectedNodeIds" /></template>
```

component.tsx

```
function Component(props) {  const data: SankeyData = () => props.data  const selectedNodeIds = [\`A\`, \`C\`]  return (    <VisSankey nodePadding={5} selectedNodeIds={selectedNodeIds}/>  )}
```

component.ts

```
const sankey = new Sankey<SankeyNode, SankeyLink>({  nodePadding: 5,   selectedNodeIds: [\`A\`, \`C\`]})
```

Loading...

## Sorting [](#sorting "Direct link to Sorting")

By default, _Sankey_ will sort the links based on their `value` in descending order from top to bottom. To change the order of the links, provide a custom sorting function to `linkSort`.

Alternatively, if you want to set the order of the nodes explicitly, you can provide a custom sorting function to `nodeSort`. It'll take precedence over the `linkSort` function.

See the following example, where nodes are sorted by property `x`, a number in the range `[0,4]`, which also configures the node's color:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: SankeyData = props.data  const nodeSort = (node1: NodeDatum, node2: NodeDatum) => node1.x - node2.x  const nodeColor = (d: SankeyNode) =>  \`var( -- vis - color${d.x})\`  return (    <VisSankey nodeColor={nodeColor} nodeSort={nodeSort}/>  )}
```

component.ts

```
@Component({  template: '<vis-sankey [nodeColor]="nodeColor" [nodeSort]="nodeSort"></vis-sankey>'})export class Component {  @Input data: SankeyData;  nodeSort = (node1: NodeDatum, node2: NodeDatum) => node1.x - node2.x  nodeColor = (d: SankeyNode) =>  \`var( -- vis - color${d.x})\`}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisSankey } from '@unovis/svelte'  export let data: SankeyData  const nodeSort = (node1: NodeDatum, node2: NodeDatum) => node1.x - node2.x  const nodeColor = (d: SankeyNode) =>  \`var( -- vis - color${d.x})\`</script><VisSankey {nodeColor} {nodeSort}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisSankey } from '@unovis/vue'const props = defineProps<{ data: SankeyData }>()const nodeSort = (node1: NodeDatum, node2: NodeDatum) => node1.x - node2.xconst nodeColor = (d: SankeyNode) =>  \`var( -- vis - color${d.x})\`</script><template>  <VisSankey :nodeColor="nodeColor" :nodeSort="nodeSort" /></template>
```

component.tsx

```
function Component(props) {  const data: SankeyData = () => props.data  const nodeSort = (node1: NodeDatum, node2: NodeDatum) => node1.x - node2.x  const nodeColor = (d: SankeyNode) =>  \`var( -- vis - color${d.x})\`  return (    <VisSankey nodeColor={nodeColor} nodeSort={nodeSort}/>  )}
```

component.ts

```
const sankey = new Sankey<SankeyNode, SankeyLink>({  nodeColor: (d: SankeyNode) =>  \`var( -- vis - color${d.x})\`,   nodeSort: (node1: NodeDatum, node2: NodeDatum) => node1.x - node2.x})
```

Loading...

## Post-Layout Customization `1.5`[](#post-layout-customization-15 "Direct link to post-layout-customization-15")

The `Sankey` component includes an `onLayoutCalculated` callback that runs after the layout is computed. This lets you inspect or adjust nodes and links, or react to the computed layout metrics.

The callback receives:

- `nodes: SankeyNode[]`
- `links: SankeyLink[]`
- `depth: number` — number of layout levels
- `width: number`, `height: number` — computed layout size
- `bleed: Spacing` — calculated outer spacing including labels `{ top, right, bottom, left }`

Example:

```
import type { SankeyNode, SankeyLink, Spacing } from '@unovis/ts'const onLayoutCalculated = <N, L>(  nodes: SankeyNode<N, L>[],  links: SankeyLink<N, L>[],  depth: number,  width: number,  height: number,  bleed: Spacing) => {  // For example, tweak nodes or log computed metrics  // nodes.forEach(n => { /* adjust properties if needed */ })  // console.log({ depth, width, height, bleed })}
```

## Events [](#events "Direct link to Events")

The following selectors are available for events:

```
import { Sankey } from '@unovis/ts'const events = {  [Sankey.selectors.node]: { ... }  [Sankey.selectors.nodeGroup]: { ... }  [Sankey.selectors.link]: { ... },  [Sankey.selectors.label]: { ... },  [Sankey.selectors.sublabel]: { ... },  [Sankey.selectors.labelGroup]: { ... },}
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

<details>

<summary>All supported CSS variables and their default values</summary>



```
--vis-sankey-link-cursor: default;--vis-sankey-link-color: var(--vis-color-main-light);--vis-sankey-link-opacity: 0.5;--vis-sankey-link-hover-opacity: 1.0;--vis-sankey-node-cursor: default;--vis-sankey-node-color: var(--vis-color-main);--vis-sankey-node-label-color: #575c65;--vis-sankey-node-opacity: 0.9;--vis-sankey-node-hover-opacity: 1.0;--vis-sankey-node-selection-stroke-width: 1.5px;--vis-sankey-node-selection-stroke-opacity: 0.6;--vis-sankey-node-selection-border-radius: 2px;--vis-sankey-node-label-background-fill-color: #ffffff;--vis-sankey-node-label-background-stroke-color: #eaeaea;--vis-sankey-node-label-background-opacity: 0.9;--vis-sankey-node-label-cursor: default;--vis-sankey-node-label-font-weight: 600;--vis-sankey-node-label-font-size: 12px;--vis-sankey-node-label-text-decoration: none;--vis-sankey-node-sublabel-font-size: 10px;--vis-sankey-node-sublabel-font-weight: 500;--vis-sankey-icon-size: 22px;--vis-sankey-icon-color: #ffffff;--vis-sankey-icon-stroke-opacity: 0.6;--vis-sankey-icon-font-family: FontAwesome;--vis-dark-sankey-link-color: var(--vis-color-main-dark);--vis-dark-sankey-node-color: var(--vis-color-main);--vis-dark-sankey-node-label-color: #eaeaea;--vis-dark-sankey-node-label-background-fill-color: #292b34;--vis-dark-sankey-node-label-background-stroke-color: #575c65;--vis-dark-sankey-icon-color: #292b34;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |