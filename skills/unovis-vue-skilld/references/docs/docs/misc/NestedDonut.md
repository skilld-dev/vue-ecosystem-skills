---
title: "Nested Donut | Unovis"
meta:
  "og:description": "Nested Donut is a variation of our Donut component that supports hierarchical data. Similar to a traditional Sunburst"
  "og:title": "Nested Donut | Unovis"
  description: "Nested Donut is a variation of our Donut component that supports hierarchical data. Similar to a traditional Sunburst"
---

## Data [](#data "Direct link to Data")

_Nested Donut_ expects an array of generic data records, the properties of which will be used to define the _layers_. Each layer will contain nodes or _segments_ that represent their corresponding quantity in the data array.

For the following examples, assume data is of type `Datum[]`.

```
type Datum = {  group: string;  subgroup: string;};
```

### Defining Layers [](#defining-layers "Direct link to Defining Layers")

The `layers` property accepts an array of string accessor functions based on the `Datum` provided. The first accessor will define the outermost layer of the chart, the second will provide the next, and so on. We can provide `layers` with accessors such the `group` property defines parent nodes with `subgroup` children.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisNestedDonut } from '@unovis/react'function Component(props) {  const data: Datum[] = props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  return (    <VisSingleContainer data={data}>      <VisNestedDonut layers={layers}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: Datum[];  layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]}
```

template.html

```
<vis-single-container [data]="data">  <vis-nested-donut [layers]="layers"></vis-nested-donut></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisNestedDonut } from '@unovis/svelte'  export let data: Datum[]  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]</script><VisSingleContainer {data}>  <VisNestedDonut {layers}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisNestedDonut } from '@unovis/vue'const props = defineProps<{ data: Datum[] }>()const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]</script><template>  <VisSingleContainer :data="data">    <VisNestedDonut :layers="layers" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisNestedDonut } from '@unovis/solid'function Component(props) {  const data: Datum[] = () => props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  return (    <VisSingleContainer data={data()}>      <VisNestedDonut layers={layers}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, NestedDonut } from '@unovis/ts'import { data, Datum } from './data'const container = new SingleContainer<Datum>(node, {  component: new NestedDonut<Datum>({    layers: [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  })}, data)
```

Loading...

#### Layers with missing/undefined data [](#layers-with-missingundefined-data "Direct link to Layers with missing/undefined data")

Now consider data where `value` is optional and only groups `A` and `B` have corresponding value properties. We see the hierarchical data is as expected, where the `C` group does not have child segments in the inner layer:

```
layers = [(d: Datum) => d.group, (d: Datum) => d.value]
```

### Segment Values [](#segment-values "Direct link to Segment Values")

By default, segment lengths are assigned based on the number of occurrences within the data array. For example, consider the following data provided to a single layer:

```
const data = ['A', 'A', 'A', 'B', 'B', 'C']
```

We would expect the values of A, B, and C to be proportional to their counts within in the array, i.e. 3, 2, and 1, respectively.

### Custom `value` Accessor [](#custom-value-accessor "Direct link to custom-value-accessor")

Alternatively, you can override the default way _Nested Donut_ calculates values by providing your own `value` accessor function. For example, f your data is shaped like:

```
const data = [{ label: 'A', value: 3 }, { label: 'B', value: 2 }, { label: 'C', value: 1 }]
```

you can provide `value` with `(d: Datum) => d.value` to achieve the same effect.

## Layer Settings [](#layer-settings "Direct link to Layer Settings")

You can customize the appearance for each individual layer with the `layerSettings` property, which accepts an accessor that returns the following type based on the layer's depth:

```
type NestedDonutLayerSettings = {  width: number | string; // The layer's width in pixels or css string to be converted to pixels  labelAlignment: NestedDonutSegmentLabelAlignment; // Alignment of the layer's segment labels}
```

### Default Values [](#default-values "Direct link to Default Values")

By default, each layer has the same `NestedDonutLayerSettings` object with the following values:

```
{  width: 50,  labelAlignment: NestedDonutSegmentLabelAlignment.Perpendicular;}
```

### Label Alignment [](#label-alignment "Direct link to Label Alignment")

The `labelAlignment` property specifies how the segment labels will align based on their radial position. The possible values are:

- `NestedDonutSegmentLabelAlignment.Along` - label is rotated with respect to the segment angle
- `NestedDonutSegmentLabelAlignment.Perpendicular` - label is rotated perpendicular to the segment angle (**default**)
- `NestedDonutSegmentLabelAlignment.Straight` - no rotation is applied

Loading...

Loading...

Loading...

### Variable Layer Settings [](#variable-layer-settings "Direct link to Variable Layer Settings")

To set different layer settings depending on the layer, provide an `NestedDonutLayerSettings` accessor function with a numeric parameter. The number refers to the layer's index in the provided `layers` property.

```
layers = [(d: Datum) => d.group, (d: Datum) => d.subgroup]// The accessor function that takes a layer index and returns a \`NestedDonutLayerSettings\` object:layerSettings = (layer: number) => {  if (i === 0) {    return { width: 25 }  }}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisNestedDonut } from '@unovis/react'function Component(props) {  const data: Datum[] = props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const layerSettings = (i: number) =>  i  ===  0  &&  ({        width :  25      })  return (    <VisSingleContainer data={data}>      <VisNestedDonut layers={layers} layerSettings={layerSettings}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: Datum[];  layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  layerSettings = (i: number) =>  i  ===  0  &&  ({        width :  25      })}
```

template.html

```
<vis-single-container [data]="data">  <vis-nested-donut  [layers]="layers"   [layerSettings]="layerSettings"></vis-nested-donut></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisNestedDonut } from '@unovis/svelte'  export let data: Datum[]  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const layerSettings = (i: number) =>  i  ===  0  &&  ({        width :  25      })</script><VisSingleContainer {data}>  <VisNestedDonut {layers} {layerSettings}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisNestedDonut } from '@unovis/vue'const props = defineProps<{ data: Datum[] }>()const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]const layerSettings = (i: number) =>  i  ===  0  &&  ({        width :  25      })</script><template>  <VisSingleContainer :data="data">    <VisNestedDonut :layers="layers" :layerSettings="layerSettings" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisNestedDonut } from '@unovis/solid'function Component(props) {  const data: Datum[] = () => props.data  const layers = [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup]  const layerSettings = (i: number) =>  i  ===  0  &&  ({        width :  25      })  return (    <VisSingleContainer data={data()}>      <VisNestedDonut layers={layers} layerSettings={layerSettings}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, NestedDonut } from '@unovis/ts'import { data, Datum } from './data'const container = new SingleContainer<Datum>(node, {  component: new NestedDonut<Datum>({    layers: [(d: Datum) =>  d.group, (d: Datum) =>  d.subgroup],     layerSettings: (i: number) =>  i  ===  0  &&  ({          width :  25        })  })}, data)
```

Loading...

## Layer Padding [](#layer-padding "Direct link to Layer Padding")

You can provide a constant numeric value to `layerPadding` to set the spacing between each layer in pixels.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisNestedDonut layers={layers} layerPadding={10}/>
```

```
<vis-nested-donut  [layers]="layers"   [layerPadding]="10"></vis-nested-donut>
```

```
<VisNestedDonut {layers} layerPadding={10}/>
```

```
<VisNestedDonut :layers="layers" :layerPadding="10" />
```

```
<VisNestedDonut layers={layers} layerPadding={10}/>
```

```
const nestedDonut = new NestedDonut<Datum>({ layers, layerPadding: 10 })
```

Loading...

## Segments [](#segments "Direct link to Segments")

### Segment Datum [](#segment-datum "Direct link to Segment Datum")

Unlike our non-hierarchical components, the data type used by accessors to customize segments will not resemble the `Datum` type because the segments are generated based on the collection of `Datum` objects provided.

So for certain properties that customize segments, accessors will deal with the following type:

```
type NestedDonutSegmentDatum<Datum> = {  key: Datum[keyof Datum] // the category based on the current layer  root: Datum[keyof Datum] // the highest parent node}type NestedDonutSegment<Datum> = {  data: NestedDonutSegmentDatum<Datum>;  depth: number;  height: number;  value: number;}
```

### Segment Color [](#segment-color "Direct link to Segment Color")

As an example, we can provide `color` property with an accessor that returns the color based on the segment's `root`:

```
export const groupColors = {  A: 'red',  B: 'green',  C: 'blue',}segmentColor = (d: NestedDonutSegment<Datum>) => groupColors[d.data.root]
```

This gives us the appearance of three distinct colors based on the segment's group instead of the default shading:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisNestedDonut layers={layers} segmentColor={segmentColor}/>
```

```
<vis-nested-donut  [layers]="layers"   [segmentColor]="segmentColor"></vis-nested-donut>
```

```
<VisNestedDonut {layers} {segmentColor}/>
```

```
<VisNestedDonut :layers="layers" :segmentColor="segmentColor" />
```

```
<VisNestedDonut layers={layers} segmentColor={segmentColor}/>
```

```
const nestedDonut = new NestedDonut<Datum>({ layers, segmentColor })
```

Loading...

### Segment Labels [](#segment-labels "Direct link to Segment Labels")

You can customize a _segment_'s labels with the following properties: `segmentLabel` and `segmentLabelColor`:

```
const segmentColor = '#ddd'const segmentLabel = (d: Datum) => {  switch (d.data.key) {    case 'A':      return 'Alpha'    case 'B':      return 'Beta'    case 'C':      return 'Charlie'      return d.data.key  }}const segmentLabelColor = (d: Datum) => groupColors[d.data.root]
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisNestedDonut  layers={layers}   segmentColor="#ddd"   segmentLabel={segmentLabel}   segmentLabelColor={segmentLabelColor}/>
```

```
<vis-nested-donut  [layers]="layers"   segmentColor="#ddd"   [segmentLabel]="segmentLabel"   [segmentLabelColor]="segmentLabelColor"></vis-nested-donut>
```

```
<VisNestedDonut  {layers}   segmentColor="#ddd"   {segmentLabel}   {segmentLabelColor}/>
```

```
<VisNestedDonut  :layers="layers"   segmentColor="#ddd"   :segmentLabel="segmentLabel"   :segmentLabelColor="segmentLabelColor" />
```

```
<VisNestedDonut  layers={layers}   segmentColor="#ddd"   segmentLabel={segmentLabel}   segmentLabelColor={segmentLabelColor}/>
```

```
const nestedDonut = new NestedDonut<Datum>({  layers,   segmentColor: "#ddd",   segmentLabel,   segmentLabelColor})
```

Loading...

## Direction [](#direction "Direct link to Direction")

By default, _Nested Donut_ will form layers starting with the outermost layer and work inward towards the center. You can use the `NestedDonutDirection.Outwards` or `'outwards'` to the `direction` property to get a _Nested Donut_ that resembles a traditional _Sunburst_ diagram:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisNestedDonut layers={layers} direction="outwards"/>
```

```
<vis-nested-donut  [layers]="layers"   direction="outwards"></vis-nested-donut>
```

```
<VisNestedDonut {layers} direction="outwards"/>
```

```
<VisNestedDonut :layers="layers" direction="outwards" />
```

```
<VisNestedDonut layers={layers} direction="outwards"/>
```

```
const nestedDonut = new NestedDonut<Datum>({ layers, direction: "outwards" })
```

Loading...

## Further configuration [](#further-configuration "Direct link to Further configuration")

_Nested Donut_ shares the following properties with our traditional _Donut_ chart. Read Donut's doc page to learn more.

- `angleRange`
- `centralLabel`
- `centralSubLabel`
- `emptySegmentLabel`
- `showBackground`
- `showEmptySegments`

## CSS Variables [](#css-variables "Direct link to CSS Variables")

_Nested Donut_ supports the following CSS variables:

```
/* Undefined by default to allow proper fallback to var(--vis-font-family) */--vis-nested-donut-font-family: undefined;/* Background */--vis-nested-donut-background-color: #e7e9f3/* Central label */--vis-nested-donut-central-label-font-size: 16px;--vis-nested-donut-central-label-font-weight: 600;--vis-nested-donut-central-label-text-color: #5b5f6d;/* Central sub-label */--vis-nested-donut-central-sublabel-font-size: 12px;--vis-nested-donut-central-sublabel-font-weight: 500;--vis-nested-donut-central-sublabel-text-color: #5b5f6d;/* Segments */--vis-nested-donut-segment-stroke-width: 1px;--vis-nested-donut-segment-stroke-color: var(--vis-nested-donut-background-color);--vis-nested-donut-segment-label-text-color-light: #5b5f6d;--vis-nested-donut-segment-label-text-color-dark: #fff;--vis-nested-donut-segment-label-font-size: 1em;/* Dark theme */--vis-dark-nested-donut-background-color: #18160c;--vis-dark-nested-donut-central-label-text-color: #fff;--vis-dark-nested-donut-central-sublabel-text-color: #fff;
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |