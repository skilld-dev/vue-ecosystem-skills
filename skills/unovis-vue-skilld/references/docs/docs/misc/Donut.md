---
title: "Donut | Unovis"
meta:
  "og:description": "Learn how to configure a Donut chart"
  "og:title": "Donut | Unovis"
  description: "Learn how to configure a Donut chart"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

The minimum configuration for the _Donut_ component looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisDonut } from '@unovis/react'function Component(props) {  const data: number[] = props.data  const value = (d: number) =>  d  return (    <VisSingleContainer data={data}>      <VisDonut value={value}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: number[];  value = (d: number) =>  d}
```

template.html

```
<vis-single-container [data]="data">  <vis-donut [value]="value"></vis-donut></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisDonut } from '@unovis/svelte'  export let data: number[]  const value = (d: number) =>  d</script><VisSingleContainer {data}>  <VisDonut {value}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisDonut } from '@unovis/vue'const props = defineProps<{ data: number[] }>()const value = (d: number) =>  d</script><template>  <VisSingleContainer :data="data">    <VisDonut :value="value" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisDonut } from '@unovis/solid'function Component(props) {  const data: number[] = () => props.data  const value = (d: number) =>  d  return (    <VisSingleContainer data={data()}>      <VisDonut value={value}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Donut } from '@unovis/ts'import { data } from './data'const container = new SingleContainer<number>(node, {  component: new Donut<number>({ value: (d: number) =>  d })}, data)
```

Loading...

## Labels [](#labels "Direct link to Labels")

_Donut_ can have a label and a smaller sub-label in the center. You can provide them by using the `centralLabel` and `centralSubLabel` config properties. The sub-label will automatically wrap onto multiple lines (unless you set the `centralSubLabelWrap` property to `false`), while the main label is supposed to be short and doesn't have wrapping implemented.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut  value={value}   centralLabel="Label"   centralSubLabel="Long sub-label wraps onto the next line"/>
```

```
<vis-donut  [value]="value"   centralLabel="Label"   centralSubLabel="Long sub-label wraps onto the next line"></vis-donut>
```

```
<VisDonut  {value}   centralLabel="Label"   centralSubLabel="Long sub-label wraps onto the next line"/>
```

```
<VisDonut  :value="value"   centralLabel="Label"   centralSubLabel="Long sub-label wraps onto the next line" />
```

```
<VisDonut  value={value}   centralLabel="Label"   centralSubLabel="Long sub-label wraps onto the next line"/>
```

```
const donut = new Donut<number>({  value,   centralLabel: "Label",   centralSubLabel: "Long sub-label wraps onto the next line"})
```

Loading...

### Label Position [](#label-position "Direct link to Label Position")

You can adjust the position of both the central label and sub-label using offset properties:

#### Horizontal Offset [](#horizontal-offset "Direct link to Horizontal Offset")

Use `centralLabelOffsetX` to move the labels left or right (negative values move left, positive values move right):

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut  value={value}   centralLabel="Offset Label"   centralSubLabel="Moved horizontally"   centralLabelOffsetX={20}/>
```

```
<vis-donut  [value]="value"   centralLabel="Offset Label"   centralSubLabel="Moved horizontally"   [centralLabelOffsetX]="20"></vis-donut>
```

```
<VisDonut  {value}   centralLabel="Offset Label"   centralSubLabel="Moved horizontally"   centralLabelOffsetX={20}/>
```

```
<VisDonut  :value="value"   centralLabel="Offset Label"   centralSubLabel="Moved horizontally"   :centralLabelOffsetX="20" />
```

```
<VisDonut  value={value}   centralLabel="Offset Label"   centralSubLabel="Moved horizontally"   centralLabelOffsetX={20}/>
```

```
const donut = new Donut<number>({  value,   centralLabel: "Offset Label",   centralSubLabel: "Moved horizontally",   centralLabelOffsetX: 20})
```

Loading...

#### Vertical Offset [](#vertical-offset "Direct link to Vertical Offset")

Use `centralLabelOffsetY` to move the labels up or down (negative values move up, positive values move down):

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut  value={value}   centralLabel="Offset Label"   centralSubLabel="Moved vertically"   centralLabelOffsetY={-15}/>
```

```
<vis-donut  [value]="value"   centralLabel="Offset Label"   centralSubLabel="Moved vertically"   [centralLabelOffsetY]="-15"></vis-donut>
```

```
<VisDonut  {value}   centralLabel="Offset Label"   centralSubLabel="Moved vertically"   centralLabelOffsetY={-15}/>
```

```
<VisDonut  :value="value"   centralLabel="Offset Label"   centralSubLabel="Moved vertically"   :centralLabelOffsetY="-15" />
```

```
<VisDonut  value={value}   centralLabel="Offset Label"   centralSubLabel="Moved vertically"   centralLabelOffsetY={-15}/>
```

```
const donut = new Donut<number>({  value,   centralLabel: "Offset Label",   centralSubLabel: "Moved vertically",   centralLabelOffsetY: -15})
```

Loading...

You can combine both offsets to position the labels exactly where you need them.

## Angle Range [](#angle-range "Direct link to Angle Range")

By default, a _Donut_ will populate values in the angle range `[0, 2π]`. You can adjust your _Donut_'s `angleRange` property to a `[a,b]` of type `[number, number]` where a[0] = the starting position and a[1] = the ending position (in radians). A common example might be when you want an incomplete/semi circle:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut value={value} angleRange={[1,3.141592653589793]}/>
```

```
<vis-donut  [value]="value"   [angleRange]="[1,3.141592653589793]"></vis-donut>
```

```
<VisDonut {value} angleRange={[1,3.141592653589793]}/>
```

```
<VisDonut :value="value" :angleRange="[1,3.141592653589793]" />
```

```
<VisDonut value={value} angleRange={[1,3.141592653589793]}/>
```

```
const donut = new Donut<number>({ value, angleRange: [1,3.141592653589793] })
```

Loading...

### Half Donut Charts [](#half-donut-charts "Direct link to Half Donut Charts")

For convenience, Unovis provides preset angle ranges to create half donut charts in different orientations. You can import these constants from `@unovis/ts`:

```
import {  DONUT_HALF_ANGLE_RANGE_TOP,  DONUT_HALF_ANGLE_RANGE_RIGHT,  DONUT_HALF_ANGLE_RANGE_BOTTOM,  DONUT_HALF_ANGLE_RANGE_LEFT} from '@unovis/ts'
```

## Sorting [](#sorting "Direct link to Sorting")

By default, each _segment_ is placed in order of appearance within your `data` array, from To change this, provide a sorting function to the `sortFunction` property. The following example displays the segments in descending order:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisSingleContainer, VisDonut } from '@unovis/react'function Component(props) {  const data: number[] = props.data  const value = (d: number) =>  d  const sortFunction = (a, b) =>  a  -  b  return (    <VisSingleContainer data={data}>      <VisDonut value={value} sortFunction={sortFunction}/>    </VisSingleContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: number[];  value = (d: number) =>  d  sortFunction = (a, b) =>  a  -  b}
```

template.html

```
<vis-single-container [data]="data">  <vis-donut [value]="value" [sortFunction]="sortFunction"></vis-donut></vis-single-container>
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisDonut } from '@unovis/svelte'  export let data: number[]  const value = (d: number) =>  d  const sortFunction = (a, b) =>  a  -  b</script><VisSingleContainer {data}>  <VisDonut {value} {sortFunction}/></VisSingleContainer>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisDonut } from '@unovis/vue'const props = defineProps<{ data: number[] }>()const value = (d: number) =>  dconst sortFunction = (a, b) =>  a  -  b</script><template>  <VisSingleContainer :data="data">    <VisDonut :value="value" :sortFunction="sortFunction" />  </VisSingleContainer></template>
```

component.tsx

```
import { VisSingleContainer, VisDonut } from '@unovis/solid'function Component(props) {  const data: number[] = () => props.data  const value = (d: number) =>  d  const sortFunction = (a, b) =>  a  -  b  return (    <VisSingleContainer data={data()}>      <VisDonut value={value} sortFunction={sortFunction}/>    </VisSingleContainer>  )}
```

component.ts

```
import { SingleContainer, Donut } from '@unovis/ts'import { data } from './data'const container = new SingleContainer<number>(node, {  component: new Donut<number>({    value: (d: number) =>  d,     sortFunction: (a, b) =>  a  -  b  })}, data)
```

Loading...

## Size [](#size "Direct link to Size")

You can change the size of your _Donut_ with the following properties:

### Radius [](#radius "Direct link to Radius")

`radius` defines the outer/overall radius:

`radius :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut radius={50} value={value}/>
```

```
<vis-donut [radius]="50" [value]="value"></vis-donut>
```

```
<VisDonut radius={50} {value}/>
```

```
<VisDonut :radius="50" :value="value" />
```

```
<VisDonut radius={50} value={value}/>
```

```
const donut = new Donut<number>({ radius: 50, value })
```

Loading...

### Arc Width [](#arc-width "Direct link to Arc Width")

`arcWidth` defines the width of the circle's outer ring in pixels.

`arcWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut arcWidth={50} value={value}/>
```

```
<vis-donut [arcWidth]="50" [value]="value"></vis-donut>
```

```
<VisDonut arcWidth={50} {value}/>
```

```
<VisDonut :arcWidth="50" :value="value" />
```

```
<VisDonut arcWidth={50} value={value}/>
```

```
const donut = new Donut<number>({ arcWidth: 50, value })
```

Loading...

note

For the appearance of a traditional pie chart, set _Donut_'s `arcWidth` to `0`.

## Segment Appearance [](#segment-appearance "Direct link to Segment Appearance")

### Custom Color [](#custom-color "Direct link to Custom Color")

Customize the colors for each segment with a `colorAccessor` function:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const data: number[] = props.data  const value = (d: number) =>  d  const color = (d: number, i: number) =>  ['red', 'orange', 'blue', 'green'][i]  return (    <VisDonut value={value} color={color}/>  )}
```

component.ts

```
@Component({  template: '<vis-donut [value]="value" [color]="color"></vis-donut>'})export class Component {  @Input data: number[];  value = (d: number) =>  d  color = (d: number, i: number) =>  ['red', 'orange', 'blue', 'green'][i]}
```

component.svelte

```
<script lang='ts'>  import { VisSingleContainer, VisDonut } from '@unovis/svelte'  export let data: number[]  const value = (d: number) =>  d  const color = (d: number, i: number) =>  ['red', 'orange', 'blue', 'green'][i]</script><VisDonut {value} {color}/>
```

component.vue

```
<script setup lang="ts">import { VisSingleContainer, VisDonut } from '@unovis/vue'const props = defineProps<{ data: number[] }>()const value = (d: number) =>  dconst color = (d: number, i: number) =>  ['red', 'orange', 'blue', 'green'][i]</script><template>  <VisDonut :value="value" :color="color" /></template>
```

component.tsx

```
function Component(props) {  const data: number[] = () => props.data  const value = (d: number) =>  d  const color = (d: number, i: number) =>  ['red', 'orange', 'blue', 'green'][i]  return (    <VisDonut value={value} color={color}/>  )}
```

component.ts

```
const donut = new Donut<number>({  value: (d: number) =>  d,   color: (d: number, i: number) =>  ['red', 'orange', 'blue', 'green'][i]})
```

Loading...

### Corner Radius [](#corner-radius "Direct link to Corner Radius")

Providing a value to the `cornerRadius` property adds rounded corners to your _Donut_'s segments proportional to the _Donut_'s `arcWidth`.

`cornerRadius :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut cornerRadius={5} value={value}/>
```

```
<vis-donut [cornerRadius]="5" [value]="value"></vis-donut>
```

```
<VisDonut cornerRadius={5} {value}/>
```

```
<VisDonut :cornerRadius="5" :value="value" />
```

```
<VisDonut cornerRadius={5} value={value}/>
```

```
const donut = new Donut<number>({ cornerRadius: 5, value })
```

Loading...

### Pad angle [](#pad-angle "Direct link to Pad angle")

Pad each segment with the `padAngle` property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut value={value} padAngle={0.1}/>
```

```
<vis-donut [value]="value" [padAngle]="0.1"></vis-donut>
```

```
<VisDonut {value} padAngle={0.1}/>
```

```
<VisDonut :value="value" :padAngle="0.1" />
```

```
<VisDonut value={value} padAngle={0.1}/>
```

```
const donut = new Donut<number>({ value, padAngle: 0.1 })
```

Loading...

### Empty Segments [](#empty-segments "Direct link to Empty Segments")

When segments are empty (i.e. when their values are 0), you may still want them displayed in your _Donut_ as thin slices. To do this, set `showEmptySegments` to `true`:

`showEmptySegments :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut showEmptySegments={true} value={value} padAngle={0.03}/>
```

```
<vis-donut  [showEmptySegments]="true"   [value]="value"   [padAngle]="0.03"></vis-donut>
```

```
<VisDonut showEmptySegments={true} {value} padAngle={0.03}/>
```

```
<VisDonut :showEmptySegments="true" :value="value" :padAngle="0.03" />
```

```
<VisDonut showEmptySegments={true} value={value} padAngle={0.03}/>
```

```
const donut = new Donut<number>({ showEmptySegments: true, value, padAngle: 0.03 })
```

Loading...

#### Customizing empty segment size [](#customizing-empty-segment-size "Direct link to Customizing empty segment size")

When `showEmptySegments` is enabled, the default size for empty segments is `0.5 * π / 180` radians. You can tweak this to your liking with the `emptySegmentAngle` property which accepts a `number` in radians. For example, setting `emptySegmentAngle` to `Math.PI / 12` looks like:

Loading...

####

Note that this property will have no effect if `showEmptySegments` is `false`.

## Background [](#background "Direct link to Background")

By default, _Donut_ has a background underneath the segments, which is useful when your chart is empty. You can turn it off by setting `showBackground` to `false`.

`showBackground :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut  showBackground={true}   value={value}   angleRange={[-1.5707963267948966,1.5707963267948966]}/>
```

```
<vis-donut  [showBackground]="true"   [value]="value"   [angleRange]="[-1.5707963267948966,1.5707963267948966]"></vis-donut>
```

```
<VisDonut  showBackground={true}   {value}   angleRange={[-1.5707963267948966,1.5707963267948966]}/>
```

```
<VisDonut  :showBackground="true"   :value="value"   :angleRange="[-1.5707963267948966,1.5707963267948966]" />
```

```
<VisDonut  showBackground={true}   value={value}   angleRange={[-1.5707963267948966,1.5707963267948966]}/>
```

```
const donut = new Donut<number>({  showBackground: true,   value,   angleRange: [-1.5707963267948966,1.5707963267948966]})
```

Loading...

Also, you can change the angular range of the background by providing a `[number, number]` value (in radians) to `backgroundAngleRange`. By default, the background angular range will be the same as `angleRange`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut  value={value}   showBackground={true}   angleRange={[0,1.0471975511965976]}   backgroundAngleRange={[0,6.283185307179586]}/>
```

```
<vis-donut  [value]="value"   [showBackground]="true"   [angleRange]="[0,1.0471975511965976]"   [backgroundAngleRange]="[0,6.283185307179586]"></vis-donut>
```

```
<VisDonut  {value}   showBackground={true}   angleRange={[0,1.0471975511965976]}   backgroundAngleRange={[0,6.283185307179586]}/>
```

```
<VisDonut  :value="value"   :showBackground="true"   :angleRange="[0,1.0471975511965976]"   :backgroundAngleRange="[0,6.283185307179586]" />
```

```
<VisDonut  value={value}   showBackground={true}   angleRange={[0,1.0471975511965976]}   backgroundAngleRange={[0,6.283185307179586]}/>
```

```
const donut = new Donut<number>({  value,   showBackground: true,   angleRange: [0,1.0471975511965976],   backgroundAngleRange: [0,6.283185307179586]})
```

Loading...

The color of the background can be changed via the `--vis-donut-background-color` and `--vis-dark-donut-background-color` CSS variables.

## Events [](#events "Direct link to Events")

The following selectors are available for events:

```
import { Donut } from '@unovis/ts'...events = {    [Donut.selectors.segment]: { },    [Donut.selectors.background]: { },    [Donut.selectors.centralLabel]: { },    [Donut.selectors.centralSubLabel]: { },}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisDonut value={value} events={events}/>
```

```
<vis-donut [value]="value" [events]="events"></vis-donut>
```

```
<VisDonut {value} {events}/>
```

```
<VisDonut :value="value" :events="events" />
```

```
<VisDonut value={value} events={events}/>
```

```
const donut = new Donut<number>({ value, events })
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

All supported CSS variables and their default values

```
--vis-donut-central-label-font-size: 16px;--vis-donut-central-label-text-color: #5b5f6d;--vis-donut-central-label-font-family--vis-donut-central-label-font-weight: 600;--vis-donut-central-sub-label-font-size: 12px;--vis-donut-central-sub-label-text-color: #5b5f6d;--vis-donut-central-sub-label-font-family--vis-donut-central-sub-label-font-weight: 500;--vis-donut-background-color: #E7E9F3;--vis-dark-donut-central-label-text-color: #C2BECE;--vis-dark-donut-central-sub-label-text-color: #C2BECE;--vis-dark-donut-background-color: #18160C;
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |