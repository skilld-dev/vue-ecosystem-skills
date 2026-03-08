---
title: "Treemap | Unovis"
meta:
  "og:description": "return {"
  "og:title": "Treemap | Unovis"
  description: "return {"
---

## Data [](#data "Direct link to Data")

_Treemap_ expects an array of generic data records, the properties of which will be used to define the _layers_. Each layer will contain tiles that represent their corresponding quantity in the data array.

For the following examples, assume data is of type `Datum[]`.

```
type Datum = {  group: string;  subgroup: string;  value: number;};
```

### Defining Layers [](#defining-layers "Direct link to Defining Layers")

The `layers` property accepts an array of string accessor functions based on the `Datum` provided. The first accessor will define the top level of the hierarchy, the second will provide the next level, and so on.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/react'function Component(props) {  const data: Datum[] = props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  return (    <VisSingleContainer data={data}>      <VisTreemap layers={layers}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: Datum[];  layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]}
```

template.html

```
<vis-single-container [data]="data">  <vis-treemap [layers]="layers"></vis-treemap></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisTreemap } from '@unovis/svelte'  export let data: Datum[]  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]</script><VisSingleContainer {data}>  <VisTreemap {layers}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisTreemap } from '@unovis/vue'const props = defineProps<{ data: Datum[] }>()const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]</script><template>  <VisSingleContainer :data="data">    <VisTreemap :layers="layers" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/solid'function Component(props) {  const data: Datum[] = () => props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  return (    <VisSingleContainer data={data()}>      <VisTreemap layers={layers}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Treemap } from '@unovis/ts'import { data, Datum } from './data'const container = new SingleContainer<Datum>(node, {  component: new Treemap<Datum>({    layers: [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  })}, data)
```

Loading...

### Tile Values [](#tile-values "Direct link to Tile Values")

By default, tile sizes are assigned based on the number of occurrences within the data array. To override this behavior, you can provide your own `value` accessor function.

```
value = (d: Datum) => d.value
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/react'function Component(props) {  const data: Datum[] = props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const value = (d: Datum) =>  d.value  return (    <VisSingleContainer data={data}>      <VisTreemap layers={layers} value={value}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: Datum[];  layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  value = (d: Datum) =>  d.value}
```

template.html

```
<vis-single-container [data]="data">  <vis-treemap [layers]="layers" [value]="value"></vis-treemap></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisTreemap } from '@unovis/svelte'  export let data: Datum[]  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const value = (d: Datum) =>  d.value</script><VisSingleContainer {data}>  <VisTreemap {layers} {value}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisTreemap } from '@unovis/vue'const props = defineProps<{ data: Datum[] }>()const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]const value = (d: Datum) =>  d.value</script><template>  <VisSingleContainer :data="data">    <VisTreemap :layers="layers" :value="value" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/solid'function Component(props) {  const data: Datum[] = () => props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const value = (d: Datum) =>  d.value  return (    <VisSingleContainer data={data()}>      <VisTreemap layers={layers} value={value}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Treemap } from '@unovis/ts'import { data, Datum } from './data'const container = new SingleContainer<Datum>(node, {  component: new Treemap<Datum>({    layers: [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup],     value: (d: Datum) =>  d.value  })}, data)
```

Loading...

## Tile Appearance [](#tile-appearance "Direct link to Tile Appearance")

### Tile Color [](#tile-color "Direct link to Tile Color")

You can customize the colors for each tile using the `tileColor` property:

```
tileColor = (d: TreemapNode<Datum>) => groupColors[d.data.key]
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap layers={layers} tileColor={tileColor}/>
```

```
<vis-treemap [layers]="layers" [tileColor]="tileColor"></vis-treemap>
```

```
<VisTreemap {layers} {tileColor}/>
```

```
<VisTreemap :layers="layers" :tileColor="tileColor" />
```

```
<VisTreemap layers={layers} tileColor={tileColor}/>
```

```
const treemap = new Treemap<Datum>({ layers, tileColor })
```

Loading...

### Tile Padding [](#tile-padding "Direct link to Tile Padding")

Control the spacing between tiles using the `tilePadding` property, which accepts a numeric value in pixels:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap layers={layers} tilePadding={4}/>
```

```
<vis-treemap [layers]="layers" [tilePadding]="4"></vis-treemap>
```

```
<VisTreemap {layers} tilePadding={4}/>
```

```
<VisTreemap :layers="layers" :tilePadding="4" />
```

```
<VisTreemap layers={layers} tilePadding={4}/>
```

```
const treemap = new Treemap<Datum>({ layers, tilePadding: 4 })
```

Loading...

### Tile Border Radius [](#tile-border-radius "Direct link to Tile Border Radius")

Add rounded corners to your tiles with the `tileBorderRadius` property:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap layers={layers} tileBorderRadius={8}/>
```

```
<vis-treemap [layers]="layers" [tileBorderRadius]="8"></vis-treemap>
```

```
<VisTreemap {layers} tileBorderRadius={8}/>
```

```
<VisTreemap :layers="layers" :tileBorderRadius="8" />
```

```
<VisTreemap layers={layers} tileBorderRadius={8}/>
```

```
const treemap = new Treemap<Datum>({ layers, tileBorderRadius: 8 })
```

Loading...

## Labels [](#labels "Direct link to Labels")

### Label Content [](#label-content "Direct link to Label Content")

Customize the text shown for each tile with `tileLabel`. It receives a `TreemapNode<Datum>` and should return a string. Default is `<key>: <value>`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/react'function Component(props) {  const data: Datum[] = props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const value = (d: Datum) =>  d.value  const tileLabel = (d: Datum) =>  \`${d.data.key} (${Math.round(d.value)})\`  return (    <VisSingleContainer data={data}>      <VisTreemap layers={layers} value={value} tileLabel={tileLabel}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: Datum[];  layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  value = (d: Datum) =>  d.value  tileLabel = (d: Datum) =>  \`${d.data.key} (${Math.round(d.value)})\`}
```

template.html

```
<vis-single-container [data]="data">  <vis-treemap  [layers]="layers"   [value]="value"   [tileLabel]="tileLabel"></vis-treemap></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisTreemap } from '@unovis/svelte'  export let data: Datum[]  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const value = (d: Datum) =>  d.value  const tileLabel = (d: Datum) =>  \`${d.data.key} (${Math.round(d.value)})\`</script><VisSingleContainer {data}>  <VisTreemap {layers} {value} {tileLabel}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisTreemap } from '@unovis/vue'const props = defineProps<{ data: Datum[] }>()const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]const value = (d: Datum) =>  d.valueconst tileLabel = (d: Datum) =>  \`${d.data.key} (${Math.round(d.value)})\`</script><template>  <VisSingleContainer :data="data">    <VisTreemap      :layers="layers"       :value="value"       :tileLabel="tileLabel"     />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/solid'function Component(props) {  const data: Datum[] = () => props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const value = (d: Datum) =>  d.value  const tileLabel = (d: Datum) =>  \`${d.data.key} (${Math.round(d.value)})\`  return (    <VisSingleContainer data={data()}>      <VisTreemap layers={layers} value={value} tileLabel={tileLabel}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Treemap } from '@unovis/ts'import { data, Datum } from './data'const container = new SingleContainer<Datum>(node, {  component: new Treemap<Datum>({    layers: [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup],     value: (d: Datum) =>  d.value,     tileLabel: (d: Datum) =>  \`${d.data.key} (${Math.round(d.value)})\`  })}, data)
```

Loading...

### Internal Node Labels [](#internal-node-labels "Direct link to Internal Node Labels")

By default, only leaf nodes (tiles with no children) are labeled. Set `labelInternalNodes` to `true` and provide a `tilePaddingTop` value to show labels for parent nodes as well:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap  layers={layers}   labelInternalNodes={true}   tilePaddingTop={18}/>
```

```
<vis-treemap  [layers]="layers"   [labelInternalNodes]="true"   [tilePaddingTop]="18"></vis-treemap>
```

```
<VisTreemap {layers} labelInternalNodes={true} tilePaddingTop={18}/>
```

```
<VisTreemap  :layers="layers"   :labelInternalNodes="true"   :tilePaddingTop="18" />
```

```
<VisTreemap  layers={layers}   labelInternalNodes={true}   tilePaddingTop={18}/>
```

```
const treemap = new Treemap<Datum>({  layers,   labelInternalNodes: true,   tilePaddingTop: 18})
```

Loading...

### Label Positioning [](#label-positioning "Direct link to Label Positioning")

Adjust the position of labels using the `labelOffsetX` and `labelOffsetY` properties:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap layers={layers} labelOffsetX={8} labelOffsetY={8}/>
```

```
<vis-treemap  [layers]="layers"   [labelOffsetX]="8"   [labelOffsetY]="8"></vis-treemap>
```

```
<VisTreemap {layers} labelOffsetX={8} labelOffsetY={8}/>
```

```
<VisTreemap :layers="layers" :labelOffsetX="8" :labelOffsetY="8" />
```

```
<VisTreemap layers={layers} labelOffsetX={8} labelOffsetY={8}/>
```

```
const treemap = new Treemap<Datum>({ layers, labelOffsetX: 8, labelOffsetY: 8 })
```

Loading...

### Label Fit Mode [](#label-fit-mode "Direct link to Label Fit Mode")

Control how labels fit within tiles using `labelFit`. This is applied to leaf nodes only.

Accepted values: `FitMode.Wrap` or `FitMode.Trim` (you can also pass strings `'wrap'` or `'trim'`). Default is `FitMode.Wrap`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/react'function Component(props) {  const data: Datum[] = props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  return (    <VisSingleContainer data={data}>      <VisTreemap layers={layers} labelFit="wrap"/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: Datum[];  layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]}
```

template.html

```
<vis-single-container [data]="data">  <vis-treemap [layers]="layers" labelFit="wrap"></vis-treemap></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisTreemap } from '@unovis/svelte'  export let data: Datum[]  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]</script><VisSingleContainer {data}>  <VisTreemap {layers} labelFit="wrap"/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisTreemap } from '@unovis/vue'const props = defineProps<{ data: Datum[] }>()const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]</script><template>  <VisSingleContainer :data="data">    <VisTreemap :layers="layers" labelFit="wrap" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/solid'function Component(props) {  const data: Datum[] = () => props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  return (    <VisSingleContainer data={data()}>      <VisTreemap layers={layers} labelFit="wrap"/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Treemap } from '@unovis/ts'import { data, Datum } from './data'const container = new SingleContainer<Datum>(node, {  component: new Treemap<Datum>({    layers: [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup],     labelFit: "wrap"  })}, data)
```

Loading...

### Label Trim Mode [](#label-trim-mode "Direct link to Label Trim Mode")

When `labelFit` is set to trim, choose which part of the label to trim with `labelTrimMode`. Default is `TrimMode.Middle`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/react'function Component(props) {  const data: Datum[] = props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  return (    <VisSingleContainer data={data}>      <VisTreemap layers={layers} labelFit="trim" labelTrimMode="end"/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: Datum[];  layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]}
```

template.html

```
<vis-single-container [data]="data">  <vis-treemap  [layers]="layers"   labelFit="trim"   labelTrimMode="end"></vis-treemap></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisTreemap } from '@unovis/svelte'  export let data: Datum[]  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]</script><VisSingleContainer {data}>  <VisTreemap {layers} labelFit="trim" labelTrimMode="end"/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisTreemap } from '@unovis/vue'const props = defineProps<{ data: Datum[] }>()const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]</script><template>  <VisSingleContainer :data="data">    <VisTreemap :layers="layers" labelFit="trim" labelTrimMode="end" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisTreemap } from '@unovis/solid'function Component(props) {  const data: Datum[] = () => props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  return (    <VisSingleContainer data={data()}>      <VisTreemap layers={layers} labelFit="trim" labelTrimMode="end"/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Treemap } from '@unovis/ts'import { data, Datum } from './data'const container = new SingleContainer<Datum>(node, {  component: new Treemap<Datum>({    layers: [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup],     labelFit: "trim",     labelTrimMode: "end"  })}, data)
```

Loading...

### Dynamic Label Size [](#dynamic-label-size "Direct link to Dynamic Label Size")

Enable or disable font size variation based on tile size with `enableTileLabelFontSizeVariation`, default is `true`:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap  layers={layers}   enableTileLabelFontSizeVariation={false}   tileLabelLargeFontSize={18}/>
```

```
<vis-treemap  [layers]="layers"   [enableTileLabelFontSizeVariation]="false"   [tileLabelLargeFontSize]="18"></vis-treemap>
```

```
<VisTreemap  {layers}   enableTileLabelFontSizeVariation={false}   tileLabelLargeFontSize={18}/>
```

```
<VisTreemap  :layers="layers"   :enableTileLabelFontSizeVariation="false"   :tileLabelLargeFontSize="18" />
```

```
<VisTreemap  layers={layers}   enableTileLabelFontSizeVariation={false}   tileLabelLargeFontSize={18}/>
```

```
const treemap = new Treemap<Datum>({  layers,   enableTileLabelFontSizeVariation: false,   tileLabelLargeFontSize: 18})
```

Loading...

You can customize the font sizes used with:

- `tileLabelSmallFontSize`: Font size for small tiles (default: 8px)
- `tileLabelMediumFontSize`: Font size for medium tiles (default: 12px)
- `tileLabelLargeFontSize`: Font size for large tiles (default: 22px)

## Advanced Features [](#advanced-features "Direct link to Advanced Features")

### Lightness Variance [](#lightness-variance "Direct link to Lightness Variance")

Enable subtle lightness variation between sibling tiles to improve visual distinction:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap layers={layers} enableLightnessVariance={true}/>
```

```
<vis-treemap  [layers]="layers"   [enableLightnessVariance]="true"></vis-treemap>
```

```
<VisTreemap {layers} enableLightnessVariance={true}/>
```

```
<VisTreemap :layers="layers" :enableLightnessVariance="true" />
```

```
<VisTreemap layers={layers} enableLightnessVariance={true}/>
```

```
const treemap = new Treemap<Datum>({ layers, enableLightnessVariance: true })
```

Loading...

### Click Affordance [](#click-affordance "Direct link to Click Affordance")

Indicate that tiles are clickable by setting `showTileClickAffordance` to `true`:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap layers={layers} showTileClickAffordance={true}/>
```

```
<vis-treemap  [layers]="layers"   [showTileClickAffordance]="true"></vis-treemap>
```

```
<VisTreemap {layers} showTileClickAffordance={true}/>
```

```
<VisTreemap :layers="layers" :showTileClickAffordance="true" />
```

```
<VisTreemap layers={layers} showTileClickAffordance={true}/>
```

```
const treemap = new Treemap<Datum>({ layers, showTileClickAffordance: true })
```

Loading...

## Layout Options [](#layout-options "Direct link to Layout Options")

### Top Padding for Internal Nodes [](#top-padding-for-internal-nodes "Direct link to Top Padding for Internal Nodes")

Add extra space at the top of parent tiles to accommodate labels with `tilePaddingTop`:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisTreemap  layers={layers}   labelInternalNodes={true}   tilePaddingTop={20}/>
```

```
<vis-treemap  [layers]="layers"   [labelInternalNodes]="true"   [tilePaddingTop]="20"></vis-treemap>
```

```
<VisTreemap {layers} labelInternalNodes={true} tilePaddingTop={20}/>
```

```
<VisTreemap  :layers="layers"   :labelInternalNodes="true"   :tilePaddingTop="20" />
```

```
<VisTreemap  layers={layers}   labelInternalNodes={true}   tilePaddingTop={20}/>
```

```
const treemap = new Treemap<Datum>({  layers,   labelInternalNodes: true,   tilePaddingTop: 20})
```

Loading...

## CSS Variables [](#css-variables "Direct link to CSS Variables")

_Treemap_ supports the following CSS variables:

```
--vis-treemap-tile-stroke-color: #fff;--vis-treemap-tile-stroke-width: 2px;--vis-treemap-tile-hover-stroke-color: #fff;--vis-treemap-tile-fill-color: #B9BEC3;--vis-treemap-tile-background-color: #fff;--vis-treemap-tile-cursor: default;--vis-treemap-label-text-color: #000;--vis-treemap-label-font-size: 12px;--vis-treemap-label-opacity: 0.8;/* Dark Theme */--vis-dark-treemap-tile-stroke-color: #2c2c2c;--vis-dark-treemap-tile-fill-color: #5b5f6d;--vis-dark-treemap-label-text-color: #5b5f6d;
```

> **Note:** The label color is now controlled by the CSS variable `--vis-treemap-label-text-color` (and `--vis-dark-treemap-label-text-color` for dark theme). This makes it easy to theme the treemap labels for light and dark modes.

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |