---
title: "Axis | Unovis"
meta:
  "og:description": "Basic configuration"
  "og:title": "Axis | Unovis"
  description: "Basic configuration"
---

### Basic configuration [](#basic-configuration "Direct link to Basic configuration")

The _Axis_ component has been designed to work together with _XY Container_. The minimal _Axis_ configuration looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis type="x"/>
```

```
<vis-axis type="x"></vis-axis>
```

```
<VisAxis type="x"/>
```

```
<VisAxis type="x" />
```

```
<VisAxis type="x"/>
```

```
const axis = new Axis<DataRecord>({ type: "x" })
```

Loading...

### Axis Types [](#axis-types "Direct link to Axis Types")

_Axis_ supports two `AxisType` properties to bind to your data: `AxisType.X` and `AxisType.Y`. You can also simply provide the string `"x"` or `"y"`.

#### AxisType.X [](#axistypex "Direct link to AxisType.X")

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis type="x"/>
```

```
<vis-axis type="x"></vis-axis>
```

```
<VisAxis type="x"/>
```

```
<VisAxis type="x" />
```

```
<VisAxis type="x"/>
```

```
const axis = new Axis<DataRecord>({ type: "x" })
```

Loading...

#### AxisType.Y [](#axistypey "Direct link to AxisType.Y")

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis type="y"/>
```

```
<vis-axis type="y"></vis-axis>
```

```
<VisAxis type="y"/>
```

```
<VisAxis type="y" />
```

```
<VisAxis type="y"/>
```

```
const axis = new Axis<DataRecord>({ type: "y" })
```

Loading...

### Axis Position [](#axis-position "Direct link to Axis Position")

You can change the position of your axis with a `Position` type or a string equivalent: `"top"`, `"right"`, `"bottom"`, or `"left"`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="y" position="right" label="Y"/>  <VisAxis type="x" position="top" label="X"/></VisXYContainer>
```

template.html

```
<vis-xy-container [data]="data">  <vis-axis type="y" position="right" label="Y"></vis-axis>  <vis-axis type="x" position="top" label="X"></vis-axis></vis-xy-container>
```

component.svelte

```
<VisXYContainer {data}>  <VisAxis type="y" position="right" label="Y"/>  <VisAxis type="x" position="top" label="X"/></VisXYContainer>
```

component.vue

```
<VisXYContainer :data="data">  <VisAxis type="y" position="right" label="Y" />  <VisAxis type="x" position="top" label="X" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="y" position="right" label="Y"/>  <VisAxis type="x" position="top" label="X"/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  yAxis: new Axis({ type: "y", position: "right", label: "Y" }),   xAxis: new Axis({ type: "x", position: "top", label: "X" })}, data)
```

Loading...

note

Note: An X _Axis_ can only accept the values `Position.Bottom` (default) and `Position.Top` and a Y _Axis_ can only accept `Position.Left` (default) and `Position.Right`. The default will be used in the case of an invalid position argument.

## Labeling [](#labeling "Direct link to Labeling")

### Axis Label [](#axis-label "Direct link to Axis Label")

You can provide a string to label your axes with the `label` property:

`label :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis label="Label" type="x"/>
```

```
<vis-axis label="Label" type="x"></vis-axis>
```

```
<VisAxis label="Label" type="x"/>
```

```
<VisAxis label="Label" type="x" />
```

```
<VisAxis label="Label" type="x"/>
```

```
const axis = new Axis<DataRecord>({ label: "Label", type: "x" })
```

Loading...

### Label Font Size [](#label-font-size "Direct link to Label Font Size")

Change the label size (in pixels) with the `labelFontSize` property.

`labelFontSize :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis labelFontSize={30} type="x" label="Label"/>
```

```
<vis-axis [labelFontSize]="30" type="x" label="Label"></vis-axis>
```

```
<VisAxis labelFontSize={30} type="x" label="Label"/>
```

```
<VisAxis :labelFontSize="30" type="x" label="Label" />
```

```
<VisAxis labelFontSize={30} type="x" label="Label"/>
```

```
const axis = new Axis<DataRecord>({ labelFontSize: 30, type: "x", label: "Label" })
```

Loading...

### Label Color [](#label-color "Direct link to Label Color")

Change the label color with the `labelColor` property.

`labelColor :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis labelColor="#1acb9a" type="x" label="Label"/>
```

```
<vis-axis labelColor="#1acb9a" type="x" label="Label"></vis-axis>
```

```
<VisAxis labelColor="#1acb9a" type="x" label="Label"/>
```

```
<VisAxis labelColor="#1acb9a" type="x" label="Label" />
```

```
<VisAxis labelColor="#1acb9a" type="x" label="Label"/>
```

```
const axis = new Axis<DataRecord>({  labelColor: "#1acb9a",   type: "x",   label: "Label"})
```

Loading...

### Label Margin [](#label-margin "Direct link to Label Margin")

The spacing between the label and the axis itself can be set with the `labelMargin` property:

`labelMargin :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis labelMargin={5} type="x" label="Label"/>
```

```
<vis-axis [labelMargin]="5" type="x" label="Label"></vis-axis>
```

```
<VisAxis labelMargin={5} type="x" label="Label"/>
```

```
<VisAxis :labelMargin="5" type="x" label="Label" />
```

```
<VisAxis labelMargin={5} type="x" label="Label"/>
```

```
const axis = new Axis<DataRecord>({ labelMargin: 5, type: "x", label: "Label" })
```

Loading...

### Grid Line [](#grid-line "Direct link to Grid Line")

You can enable or disable the visibility of the _Axis_ grid line with the `gridLine` property.

`gridLine :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis gridLine={true} type="x"/>
```

```
<vis-axis [gridLine]="true" type="x"></vis-axis>
```

```
<VisAxis gridLine={true} type="x"/>
```

```
<VisAxis :gridLine="true" type="x" />
```

```
<VisAxis gridLine={true} type="x"/>
```

```
const axis = new Axis<DataRecord>({ gridLine: true, type: "x" })
```

Loading...

### Axis Domain Line [](#axis-domain-line "Direct link to Axis Domain Line")

You can enable or disable the visibility of the axis domain line with the `domainLine` property.

`domainLine :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis domainLine={true} type="x" label="Label"/>
```

```
<vis-axis [domainLine]="true" type="x" label="Label"></vis-axis>
```

```
<VisAxis domainLine={true} type="x" label="Label"/>
```

```
<VisAxis :domainLine="true" type="x" label="Label" />
```

```
<VisAxis domainLine={true} type="x" label="Label"/>
```

```
const axis = new Axis<DataRecord>({ domainLine: true, type: "x", label: "Label" })
```

Loading...

### Providing Data to _Axis_[](#providing-data-to-axis "Direct link to providing-data-to-axis")

If you use the _Axis_ component alone, without other xy-components, you'll need to provide an `x` accessor or `y` accessors to populate the axis values. Consider the following example with a single axis and a data array with x values in the range `0 < x < 10`:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisAxis } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  return (    <VisXYContainer data={data}>      <VisAxis type="x" x={x}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x}
```

template.html

```
<vis-xy-container [data]="data">  <vis-axis type="x" [x]="x"></vis-axis></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisAxis } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x</script><VisXYContainer {data}>  <VisAxis type="x" {x}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisAxis } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.x</script><template>  <VisXYContainer :data="data">    <VisAxis type="x" :x="x" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisAxis } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  return (    <VisXYContainer data={data()}>      <VisAxis type="x" x={x}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Axis } from '@unovis/ts'import { data, DataRecord } from './data'const container = new XYContainer<DataRecord>(node, {  xAxis: new Axis<DataRecord>({ type: "x", x: (d: DataRecord) =>  d.x })}, data)
```

Loading...

Another example:

```
const x = (d: DataRecord) => d.x * 100
```

Loading...

## Tick Configuration [](#tick-configuration "Direct link to Tick Configuration")

The _Axis_ component supports a wide variety of tick customization options

### Tick Line [](#tick-line "Direct link to Tick Line")

You can remove tick labels from your axis by setting the `tickLine` property to false:

`tickLine :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickLine={undefined} type="x"/>
```

```
<vis-axis [tickLine]="undefined" type="x"></vis-axis>
```

```
<VisAxis tickLine={undefined} type="x"/>
```

```
<VisAxis :tickLine="undefined" type="x" />
```

```
<VisAxis tickLine={undefined} type="x"/>
```

```
const axis = new Axis<DataRecord>({ tickLine: undefined, type: "x" })
```

Loading...

### Tick Label Font Size [](#tick-label-font-size "Direct link to Tick Label Font Size")

To change the font size for the tick labels, you provide the `tickTextFontSize` property with a CSS string.

`tickTextFontSize :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickTextFontSize="50px" type="x"/>
```

```
<vis-axis tickTextFontSize="50px" type="x"></vis-axis>
```

```
<VisAxis tickTextFontSize="50px" type="x"/>
```

```
<VisAxis tickTextFontSize="50px" type="x" />
```

```
<VisAxis tickTextFontSize="50px" type="x"/>
```

```
const axis = new Axis<DataRecord>({ tickTextFontSize: "50px", type: "x" })
```

Loading...

### Tick Label Color [](#tick-label-color "Direct link to Tick Label Color")

You can change the color of the tick labels with the `tickTextColor` property.

`tickTextColor :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickTextColor="#1acb9a" type="x"/>
```

```
<vis-axis tickTextColor="#1acb9a" type="x"></vis-axis>
```

```
<VisAxis tickTextColor="#1acb9a" type="x"/>
```

```
<VisAxis tickTextColor="#1acb9a" type="x" />
```

```
<VisAxis tickTextColor="#1acb9a" type="x"/>
```

```
const axis = new Axis<DataRecord>({ tickTextColor: "#1acb9a", type: "x" })
```

Loading...

### Tick Label Format [](#tick-label-format "Direct link to Tick Label Format")

You can customize how ticks are formatted using the `tickFormat` property and a label formatter function. The following example uses Javascript's built-in Date formatter function `toDateString()`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis type="x" x={x} tickFormat={tickFormat}/>
```

```
<vis-axis type="x" [x]="x" [tickFormat]="tickFormat"></vis-axis>
```

```
<VisAxis type="x" {x} {tickFormat}/>
```

```
<VisAxis type="x" :x="x" :tickFormat="tickFormat" />
```

```
<VisAxis type="x" x={x} tickFormat={tickFormat}/>
```

```
const axis = new Axis<DataRecord>({ type: "x", x, tickFormat })
```

Loading...

### Label Alignment [](#label-alignment "Direct link to Label Alignment")

Change the tick's label alignment with respect to the tick marker using `tickTextAlign` property with a TextAlign value: `TextAlign.Left`, `TextAlign.Right` or `TextAlign.Center`.

`tickTextAlign :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickTextAlign="right" type="x"/>
```

```
<vis-axis tickTextAlign="right" type="x"></vis-axis>
```

```
<VisAxis tickTextAlign="right" type="x"/>
```

```
<VisAxis tickTextAlign="right" type="x" />
```

```
<VisAxis tickTextAlign="right" type="x"/>
```

```
const axis = new Axis<DataRecord>({ tickTextAlign: "right", type: "x" })
```

Loading...

### Label Rotation [](#label-rotation "Direct link to Label Rotation")

Change the tick's label angle using `tickTextAngle` property with a number value. Use this variable along with `tickTextAlign` to make sure the tick label displays as desired.

`tickTextAngle :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickTextAngle={15} type="x" tickTextAlign="left"/>
```

```
<vis-axis  [tickTextAngle]="15"   type="x"   tickTextAlign="left"></vis-axis>
```

```
<VisAxis tickTextAngle={15} type="x" tickTextAlign="left"/>
```

```
<VisAxis :tickTextAngle="15" type="x" tickTextAlign="left" />
```

```
<VisAxis tickTextAngle={15} type="x" tickTextAlign="left"/>
```

```
const axis = new Axis<DataRecord>({  tickTextAngle: 15,   type: "x",   tickTextAlign: "left"})
```

Loading...

### Label Width [](#label-width "Direct link to Label Width")

To limit the width of the tick labels (in pixels), you can use the `tickTextWidth` property.

`tickTextWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickTextWidth={50} type="x"/>
```

```
<vis-axis [tickTextWidth]="50" type="x"></vis-axis>
```

```
<VisAxis tickTextWidth={50} type="x"/>
```

```
<VisAxis :tickTextWidth="50" type="x" />
```

```
<VisAxis tickTextWidth={50} type="x"/>
```

```
const axis = new Axis<DataRecord>({ tickTextWidth: 50, type: "x" })
```

Loading...

### Label Fit Mode [](#label-fit-mode "Direct link to Label Fit Mode")

_Axis_ accepts the following values for the `tickTextFitMode` property: `FitMode.Wrap` or `FitMode.Trim`. This determines how the axis will handle tick text overflow. The following example showcases the previous example using `"trim"` instead of `"wrap"`.

`tickTextFitMode :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickTextFitMode="trim" type="x" tickTextWidth={10}/>
```

```
<vis-axis  tickTextFitMode="trim"   type="x"   [tickTextWidth]="10"></vis-axis>
```

```
<VisAxis tickTextFitMode="trim" type="x" tickTextWidth={10}/>
```

```
<VisAxis tickTextFitMode="trim" type="x" :tickTextWidth="10" />
```

```
<VisAxis tickTextFitMode="trim" type="x" tickTextWidth={10}/>
```

```
const axis = new Axis<DataRecord>({  tickTextFitMode: "trim",   type: "x",   tickTextWidth: 10})
```

Loading...

### Label Trim Type [](#label-trim-type "Direct link to Label Trim Type")

When a tick label becomes too long, and you want to trim it, you can customize the trimming method with the `tickTextTrimType` property. _Axis_ accepts a `TrimMode` or a string. For example, when we configure `tickTextTrimType` to `TrimMode.Start`, we can see the start of the label gets cut off instead of the middle.

`tickTextTrimType :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis  tickTextTrimType="start"   type="x"   tickTextFitMode="trim"   tickTextWidth={30}/>
```

```
<vis-axis  tickTextTrimType="start"   type="x"   tickTextFitMode="trim"   [tickTextWidth]="30"></vis-axis>
```

```
<VisAxis  tickTextTrimType="start"   type="x"   tickTextFitMode="trim"   tickTextWidth={30}/>
```

```
<VisAxis  tickTextTrimType="start"   type="x"   tickTextFitMode="trim"   :tickTextWidth="30" />
```

```
<VisAxis  tickTextTrimType="start"   type="x"   tickTextFitMode="trim"   tickTextWidth={30}/>
```

```
const axis = new Axis<DataRecord>({  tickTextTrimType: "start",   type: "x",   tickTextFitMode: "trim",   tickTextWidth: 30})
```

Loading...

### Force Word Break [](#force-word-break "Direct link to Force Word Break")

In addition, you can enable a forced word break for overflowing tick labels with the `tickTextForceWordBreak` property.

`tickTextForceWordBreak :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickTextForceWordBreak={true} type="x" tickTextWidth={10}/>
```

```
<vis-axis  [tickTextForceWordBreak]="true"   type="x"   [tickTextWidth]="10"></vis-axis>
```

```
<VisAxis tickTextForceWordBreak={true} type="x" tickTextWidth={10}/>
```

```
<VisAxis :tickTextForceWordBreak="true" type="x" :tickTextWidth="10" />
```

```
<VisAxis tickTextForceWordBreak={true} type="x" tickTextWidth={10}/>
```

```
const axis = new Axis<DataRecord>({  tickTextForceWordBreak: true,   type: "x",   tickTextWidth: 10})
```

Loading...

### Text Separator [](#text-separator "Direct link to Text Separator")

_Axis_ accepts a `string` or `string[]` value for `tickTextSeparator` property. This will allow tick labels to be separated by custom values in the case of overflow. Note: this only takes effect when `FitMode.Wrap` is enabled and `tickTextWidth` is defined.

`tickTextSeparator :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis tickTextSeparator="," type="x" tickTextWidth={10}/>
```

```
<vis-axis  tickTextSeparator=","   type="x"   [tickTextWidth]="10"></vis-axis>
```

```
<VisAxis tickTextSeparator="," type="x" tickTextWidth={10}/>
```

```
<VisAxis tickTextSeparator="," type="x" :tickTextWidth="10" />
```

```
<VisAxis tickTextSeparator="," type="x" tickTextWidth={10}/>
```

```
const axis = new Axis<DataRecord>({  tickTextSeparator: ",",   type: "x",   tickTextWidth: 10})
```

Loading...

### Custom Number of Ticks [](#custom-number-of-ticks "Direct link to Custom Number of Ticks")

By default, the _Axis_ component provides an optimal number of ticks displayed based on the component's size. You can alter the tick count to your liking using the `numTicks` property.

note

The specified count is only a hint, the axis can have more or fewer ticks depending on the data

`numTicks :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis numTicks={20} type="x"/>
```

```
<vis-axis [numTicks]="20" type="x"></vis-axis>
```

```
<VisAxis numTicks={20} type="x"/>
```

```
<VisAxis :numTicks="20" type="x" />
```

```
<VisAxis numTicks={20} type="x"/>
```

```
const axis = new Axis<DataRecord>({ numTicks: 20, type: "x" })
```

Loading...

### Display Only Minimum and Maximum Ticks [](#display-only-minimum-and-maximum-ticks "Direct link to Display Only Minimum and Maximum Ticks")

Set the `minMaxTicksOnly` property to `true` if you only want to see the two end ticks on the axis.

note

To display the minimum and maximum ticks only when the chart width is limited (this behavior is enabled my default), you can use the `minMaxTicksOnlyWhenWidthIsLess` property (defaults to 250px). This helps avoid clutter in smaller visualizations while still providing essential information.

`minMaxTicksOnly :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis minMaxTicksOnly={true} type="x"/>
```

```
<vis-axis [minMaxTicksOnly]="true" type="x"></vis-axis>
```

```
<VisAxis minMaxTicksOnly={true} type="x"/>
```

```
<VisAxis :minMaxTicksOnly="true" type="x" />
```

```
<VisAxis minMaxTicksOnly={true} type="x"/>
```

```
const axis = new Axis<DataRecord>({ minMaxTicksOnly: true, type: "x" })
```

Loading...

When using `minMaxTicksOnly`, you can still show grid lines by setting `minMaxTicksOnlyShowGridLines` to `true`.

`minMaxTicksOnlyShowGridLines :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis  minMaxTicksOnlyShowGridLines={true}   minMaxTicksOnly={true}   type="x"/>
```

```
<vis-axis  [minMaxTicksOnlyShowGridLines]="true"   [minMaxTicksOnly]="true"   type="x"></vis-axis>
```

```
<VisAxis  minMaxTicksOnlyShowGridLines={true}   minMaxTicksOnly={true}   type="x"/>
```

```
<VisAxis  :minMaxTicksOnlyShowGridLines="true"   :minMaxTicksOnly="true"   type="x" />
```

```
<VisAxis  minMaxTicksOnlyShowGridLines={true}   minMaxTicksOnly={true}   type="x"/>
```

```
const axis = new Axis<DataRecord>({  minMaxTicksOnlyShowGridLines: true,   minMaxTicksOnly: true,   type: "x"})
```

Loading...

### Set Ticks Explicitly [](#set-ticks-explicitly "Direct link to Set Ticks Explicitly")

You can customize the ticks displayed by providing the _Axis_ component with a number array. The following example only shows even values for x after getting the `tickValue` array from a filter function.

```
function tickValues() {  return data.filter(d => d.x % 2 == 0)})
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis type="x" tickValues={[0,2,4,6,8]}/>
```

```
<vis-axis type="x" [tickValues]="[0,2,4,6,8]"></vis-axis>
```

```
<VisAxis type="x" tickValues={[0,2,4,6,8]}/>
```

```
<VisAxis type="x" :tickValues="[0,2,4,6,8]" />
```

```
<VisAxis type="x" tickValues={[0,2,4,6,8]}/>
```

```
const axis = new Axis<DataRecord>({ type: "x", tickValues: [0,2,4,6,8] })
```

Loading...

### Hide Overlapping Ticks `1.5`[](#hide-overlapping-ticks-15 "Direct link to hide-overlapping-ticks-15")

To prevent overlapping tick labels on the axis, you can use the `tickTextHideOverlapping` property. When enabled, it hides any tick labels that would otherwise overlap with one another based on a simple bounding box collision detection algorithm. This ensures cleaner, more legible axes, particularly in cases where the available space is limited or when displaying many ticks.

note

The algorithm used for detecting overlaps may not be accurate when a `tickTextAngle` is specified, so results can vary depending on tick rotation.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis type="x" numTicks={15} tickTextHideOverlapping={true}/>
```

```
<vis-axis  type="x"   [numTicks]="15"   [tickTextHideOverlapping]="true"></vis-axis>
```

```
<VisAxis type="x" numTicks={15} tickTextHideOverlapping={true}/>
```

```
<VisAxis type="x" :numTicks="15" :tickTextHideOverlapping="true" />
```

```
<VisAxis type="x" numTicks={15} tickTextHideOverlapping={true}/>
```

```
const axis = new Axis<DataRecord>({  type: "x",   numTicks: 15,   tickTextHideOverlapping: true})
```

Loading...

## Displaying Multiple Axes [](#displaying-multiple-axes "Direct link to Displaying Multiple Axes")

More commonly, you will want to display both an x and y axis for your graph. You can display multiple axes in an _XY Container_ like so:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="y"/>  <VisAxis type="x"/></VisXYContainer>
```

template.html

```
<vis-xy-container [data]="data">  <vis-axis type="y"></vis-axis>  <vis-axis type="x"></vis-axis></vis-xy-container>
```

component.svelte

```
<VisXYContainer {data}>  <VisAxis type="y"/>  <VisAxis type="x"/></VisXYContainer>
```

component.vue

```
<VisXYContainer :data="data">  <VisAxis type="y" />  <VisAxis type="x" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="y"/>  <VisAxis type="x"/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  yAxis: new Axis({ type: "y" }),   xAxis: new Axis({ type: "x" })}, data)
```

Loading...

## Displaying Axis with a Chart [](#displaying-axis-with-a-chart "Direct link to Displaying Axis with a Chart")

You can include a chart within your _XY Container_ alongside your axes like this:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="y"/>  <VisLine x={x} y={y}/>  <VisAxis type="x"/></VisXYContainer>
```

template.html

```
<vis-xy-container [data]="data">  <vis-axis type="y"></vis-axis>  <vis-line [x]="x" [y]="y"></vis-line>  <vis-axis type="x"></vis-axis></vis-xy-container>
```

component.svelte

```
<VisXYContainer {data}>  <VisAxis type="y"/>  <VisLine {x} {y}/>  <VisAxis type="x"/></VisXYContainer>
```

component.vue

```
<VisXYContainer :data="data">  <VisAxis type="y" />  <VisLine :x="x" :y="y" />  <VisAxis type="x" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer data={data}>  <VisAxis type="y"/>  <VisLine x={x} y={y}/>  <VisAxis type="x"/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  yAxis: new Axis({ type: "y" }),   components: [new Line({ x, y })],   xAxis: new Axis({ type: "x" })}, data)
```

Loading...

## Additional Styling: CSS Variables [](#additional-styling-css-variables "Direct link to Additional Styling: CSS Variables")

The _Axis_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.container {  --vis-axis-tick-label-font-size: 20px;  --vis-axis-label-color: #1acb9a;  --vis-axis-font-family: monospace;  --vis-axis-tick-label-color:  #8777d9;}
```

Loading...

<details>

<summary>All supported CSS variables and their default values</summary>



```
--vis-axis-tick-color: #e8e9ef;--vis-axis-grid-color: #e8e9ef;--vis-axis-grid-line-width: 1px;--vis-axis-grid-line-dasharray: none;--vis-axis-label-font-size: 14px;--vis-axis-label-color: #6c778c;--vis-axis-label-weight: 500;--vis-axis-tick-label-color: #6c778c;--vis-axis-tick-label-font-size: 12px;--vis-axis-tick-label-weight: 500;--vis-axis-tick-label-cursor: default;--vis-axis-tick-label-text-decoration: none;--vis-axis-tick-line-width: 1px;--vis-axis-tick-label-hide-transition: opacity 400ms ease-in-out;--vis-dark-axis-tick-color: #6c778c;--vis-dark-axis-tick-label-color: #e8e9ef;--vis-dark-axis-grid-color: #6c778c;--vis-dark-axis-label-color: #fefefe;
```

</details>

## Events [](#events "Direct link to Events")

```
import { Axis } from '@unovis/ts'events = {  [Axis.selectors.tick]: {    mouseover: (d: number | Date) => {},    mouseout: (d: number | Date) => {}  }}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisAxis type="x" events={events}/>
```

```
<vis-axis type="x" [events]="events"></vis-axis>
```

```
<VisAxis type="x" {events}/>
```

```
<VisAxis type="x" :events="events" />
```

```
<VisAxis type="x" events={events}/>
```

```
const axis = new Axis<DataRecord>({ type: "x", events })
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |