---
title: "Plotline | Unovis"
meta:
  "og:description": "A Plotline is used to highlight a specific region along the X or Y axis in a chart. It is only compatible with the XY container."
  "og:title": "Plotline | Unovis"
  description: "A Plotline is used to highlight a specific region along the X or Y axis in a chart. It is only compatible with the XY container."
---

## Basic configuration [](#basic-configuration "Direct link to Basic configuration")

The basic configuration of a Plotline includes specifying the axis (x or y) and the exact value where the line should appear. You can customize its appearance using properties like `color`, `lineWidth`, and `lineStyle`, and optionally add a `label` for annotation. These settings allow you to visually mark thresholds, targets, or reference points in your chart.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisXYContainer, VisLine, VisAxis, VisAxis, VisPlotline } from '@unovis/react'function Component(props) {  const data: DataRecord[] = props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer yDomain={[0]} data={data}>      <VisLine x={x} y={y}/>      <VisAxis type="x"/>      <VisAxis type="y"/>      <VisPlotline value={5}/>    </VisXYContainer>  )}
```

component.ts

```
@Component({  templateUrl: 'template.html'})export class Component {  @Input data: DataRecord[];  x = (d: DataRecord) =>  d.x  y = (d: DataRecord) =>  d.y}
```

template.html

```
<vis-xy-container [yDomain]="[0]" [data]="data">  <vis-line [x]="x" [y]="y"></vis-line>  <vis-axis type="x"></vis-axis>  <vis-axis type="y"></vis-axis>  <vis-plotline [value]="5"></vis-plotline></vis-xy-container>
```

component.svelte

```
<script lang='ts'>  import { VisXYContainer, VisLine, VisAxis, VisAxis, VisPlotline } from '@unovis/svelte'  export let data: DataRecord[]  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y</script><VisXYContainer yDomain={[0]} {data}>  <VisLine {x} {y}/>  <VisAxis type="x"/>  <VisAxis type="y"/>  <VisPlotline value={5}/></VisXYContainer>
```

component.vue

```
<script setup lang="ts">import { VisXYContainer, VisLine, VisAxis, VisAxis, VisPlotline } from '@unovis/vue'const props = defineProps<{ data: DataRecord[] }>()const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.y</script><template>  <VisXYContainer :yDomain="[0]" :data="data">    <VisLine :x="x" :y="y" />    <VisAxis type="x" />    <VisAxis type="y" />    <VisPlotline :value="5" />  </VisXYContainer></template>
```

component.tsx

```
import { VisXYContainer, VisLine, VisAxis, VisAxis, VisPlotline } from '@unovis/solid'function Component(props) {  const data: DataRecord[] = () => props.data  const x = (d: DataRecord) =>  d.x  const y = (d: DataRecord) =>  d.y  return (    <VisXYContainer yDomain={[0]} data={data()}>      <VisLine x={x} y={y}/>      <VisAxis type="x"/>      <VisAxis type="y"/>      <VisPlotline value={5}/>    </VisXYContainer>  )}
```

component.ts

```
import { XYContainer, Line, Axis, Plotline } from '@unovis/ts'import { data, DataRecord } from './data'const x = (d: DataRecord) =>  d.xconst y = (d: DataRecord) =>  d.yconst plotline = new Plotline<DataRecord>({ value: 5 })const container = new XYContainer<DataRecord>(node, {  yDomain: [0],   components: [plotline, new Line({ x, y })],   xAxis: new Axis({ type: "x" }),   yAxis: new Axis({ type: "y" })}, data)
```

Loading...

## Orientation [](#orientation "Direct link to Orientation")

The `axis` property controls the orientation of the plotline by specifying which axis it belongs to:

- axis: `x` draws a vertical plotline, crossing the chart along the y-axis — typically used to mark a specific x-value (e.g., a date or event marker).
- axis: `y` (default) draws a horizontal plotline, crossing the chart along the x-axis — often used to indicate thresholds or target values.

Set this property based on which dimension the plotline should emphasize.

Default: `y` (horizontal)

`axis :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline axis="y" value={5}/>
```

```
<vis-plotline axis="y" [value]="5"></vis-plotline>
```

```
<VisPlotline axis="y" value={5}/>
```

```
<VisPlotline axis="y" :value="5" />
```

```
<VisPlotline axis="y" value={5}/>
```

```
const plotline = new Plotline<DataRecord>({ axis: "y", value: 5 })
```

Loading...

## Color [](#color "Direct link to Color")

The `color` property sets the stroke color of the `plotline`.

You can provide any valid CSS color value, such as:

- Named colors (e.g., "red", "blue")
- Hex codes (e.g., "#ffcc00")
- RGB / RGBA (e.g., "rgba(255, 0, 0, 0.8)")
- CSS variables (e.g., `var(--vis-plotline-color)`)

Use this to visually emphasize the line or match it with your chart’s color scheme.

Default: `var(--vis-plotline-color)`

`color :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline color="#ff8400" value={5}/>
```

```
<vis-plotline color="#ff8400" [value]="5"></vis-plotline>
```

```
<VisPlotline color="#ff8400" value={5}/>
```

```
<VisPlotline color="#ff8400" :value="5" />
```

```
<VisPlotline color="#ff8400" value={5}/>
```

```
const plotline = new Plotline<DataRecord>({ color: "#ff8400", value: 5 })
```

Loading...

## Value [](#value "Direct link to Value")

The `value` property defines the exact coordinate along the specified axis where the `plotline` should be drawn.

- It accepts a single number.
- The line is rendered perpendicular to the axis.
- If value is null or undefined, the plotline is skipped.

Use this to highlight a specific threshold, target, or reference value in your chart.

Default: `0`

`value :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline value={5}/>
```

```
<vis-plotline [value]="5"></vis-plotline>
```

```
<VisPlotline value={5}/>
```

```
<VisPlotline :value="5" />
```

```
<VisPlotline value={5}/>
```

```
const plotline = new Plotline<DataRecord>({ value: 5 })
```

Loading...

note

The specified `value` for the plotline should lie within the domain of the corresponding axis.

## Line Width [](#line-width "Direct link to Line Width")

The `lineWidth` property sets the thickness of the plotline in pixels.

- Accepts any positive number (e.g., 1, 2, 3.5).
- Use this to emphasize or de-emphasize the plotline visually.

You can also define the width globally using the CSS variable `--vis-plotline-width`.

Default: 2

`lineWidth :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline lineWidth={2} value={5}/>
```

```
<vis-plotline [lineWidth]="2" [value]="5"></vis-plotline>
```

```
<VisPlotline lineWidth={2} value={5}/>
```

```
<VisPlotline :lineWidth="2" :value="5" />
```

```
<VisPlotline lineWidth={2} value={5}/>
```

```
const plotline = new Plotline<DataRecord>({ lineWidth: 2, value: 5 })
```

Loading...

## Line style [](#line-style "Direct link to Line style")

The `lineStyle` property controls the visual appearance of the plotline’s stroke. You can choose from a set of named presets or define a custom dash pattern.

Options:

- Named presets (from `PlotlineLineStylePresets` enum):
  - solid
    - dash
    - dashDot
    - dot
    - longDash
    - longDashDot
    - longDashDotDot
    - shortDash
    - shortDashDot
    - shortDashDotDot
    - shortDot
- Custom pattern:
  - Provide an array of numbers representing the SVG stroke-dasharray. Example: [4, 2] for a dashed line with 4px dash and 2px gap.

You can also style it globally using the CSS variable `--vis-plotline-dasharray`.

Default: `solid`

`lineStyle :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline lineStyle="solid" value={5}/>
```

```
<vis-plotline lineStyle="solid" [value]="5"></vis-plotline>
```

```
<VisPlotline lineStyle="solid" value={5}/>
```

```
<VisPlotline lineStyle="solid" :value="5" />
```

```
<VisPlotline lineStyle="solid" value={5}/>
```

```
const plotline = new Plotline<DataRecord>({ lineStyle: "solid", value: 5 })
```

Loading...

## Labeling [](#labeling "Direct link to Labeling")

_Plotline_ supports an optional label to annotate the highlighted line. The labeling system is flexible and includes controls for positioning, orientation, offset, size, and color.

### Label Position [](#label-position "Direct link to Label Position")

The `labelPosition` property determines where the label is rendered in relation to the plotline. It supports placement on all four sides of the chart area.

Available values:

- `top-left`
- `top`
- `top-right`
- `right`
- `bottom-right`
- `bottom`
- `bottom-left`
- `left`

Default: `top-left`

`labelPosition :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline  labelPosition="top-left"   value={5}   labelText="Nice label 🙂"/>
```

```
<vis-plotline  labelPosition="top-left"   [value]="5"   labelText="Nice label 🙂"></vis-plotline>
```

```
<VisPlotline  labelPosition="top-left"   value={5}   labelText="Nice label 🙂"/>
```

```
<VisPlotline  labelPosition="top-left"   :value="5"   labelText="Nice label 🙂" />
```

```
<VisPlotline  labelPosition="top-left"   value={5}   labelText="Nice label 🙂"/>
```

```
const plotline = new Plotline<DataRecord>({  labelPosition: "top-left",   value: 5,   labelText: "Nice label 🙂"})
```

Loading...

### Label Orientation [](#label-orientation "Direct link to Label Orientation")

The `labelOrientation` property sets the text layout direction. Use it to control how the label is rotated or aligned.

Options:

- `horizontal` (default)
- `vertical`

`labelOrientation :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline  labelOrientation="horizontal"   value={5}   labelText="Nice label 🙂"   axis="x"/>
```

```
<vis-plotline  labelOrientation="horizontal"   [value]="5"   labelText="Nice label 🙂"   axis="x"></vis-plotline>
```

```
<VisPlotline  labelOrientation="horizontal"   value={5}   labelText="Nice label 🙂"   axis="x"/>
```

```
<VisPlotline  labelOrientation="horizontal"   :value="5"   labelText="Nice label 🙂"   axis="x" />
```

```
<VisPlotline  labelOrientation="horizontal"   value={5}   labelText="Nice label 🙂"   axis="x"/>
```

```
const plotline = new Plotline<DataRecord>({  labelOrientation: "horizontal",   value: 5,   labelText: "Nice label 🙂",   axis: "x"})
```

Loading...

### Label Offset [](#label-offset "Direct link to Label Offset")

You can fine-tune the label’s position using the `labelOffsetX` and `labelOffsetY` properties. These accept pixel values and apply additional horizontal and vertical shifts relative to the defined label position.

Examples:

- A positive `labelOffsetX` moves the label to the right.
- A negative `labelOffsetY` moves the label upward.

Use these offsets to avoid overlap with the plotline or nearby chart elements, or to improve visual alignment.

Default: `14` for both `labelOffsetX` and `labelOffsetY`

`labelOffsetY :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline labelOffsetY={16} value={5} labelText="Sad label 🙃"/>
```

```
<vis-plotline  [labelOffsetY]="16"   [value]="5"   labelText="Sad label 🙃"></vis-plotline>
```

```
<VisPlotline labelOffsetY={16} value={5} labelText="Sad label 🙃"/>
```

```
<VisPlotline :labelOffsetY="16" :value="5" labelText="Sad label 🙃" />
```

```
<VisPlotline labelOffsetY={16} value={5} labelText="Sad label 🙃"/>
```

```
const plotline = new Plotline<DataRecord>({  labelOffsetY: 16,   value: 5,   labelText: "Sad label 🙃"})
```

Loading...

### Label Font Size [](#label-font-size "Direct link to Label Font Size")

The `labelSize` property controls the font size of the label, specified in pixels.

By default, it inherits from the CSS variable `--vis-plotline-label-font-size`, which typically resolves to `12px`. You can override this by providing a numeric value—for example, `14` sets the font size to `14px`.

Use this setting to ensure label visibility or to match your chart’s typographic scale.

Default: `12`

`labelSize :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline labelSize={16} value={5} labelText="Small label 🤏"/>
```

```
<vis-plotline  [labelSize]="16"   [value]="5"   labelText="Small label 🤏"></vis-plotline>
```

```
<VisPlotline labelSize={16} value={5} labelText="Small label 🤏"/>
```

```
<VisPlotline :labelSize="16" :value="5" labelText="Small label 🤏" />
```

```
<VisPlotline labelSize={16} value={5} labelText="Small label 🤏"/>
```

```
const plotline = new Plotline<DataRecord>({  labelSize: 16,   value: 5,   labelText: "Small label 🤏"})
```

Loading...

### Label Color [](#label-color "Direct link to Label Color")

To customize the label’s appearance, use the `labelColor` property. It accepts any valid CSS color string, including:

- Named colors – e.g., `red`, `black`
- Hex values – e.g., `#333333`, `#FF8800`
- CSS variables – e.g., `var(--vis-text-color)`

If omitted, the label inherits the default text color defined for the plotline context, which may vary depending on light or dark mode styles.

Default: `#000`

`labelColor :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisPlotline  labelColor="#cf3312"   value={5}   labelText="Party label 🥳"/>
```

```
<vis-plotline  labelColor="#cf3312"   [value]="5"   labelText="Party label 🥳"></vis-plotline>
```

```
<VisPlotline  labelColor="#cf3312"   value={5}   labelText="Party label 🥳"/>
```

```
<VisPlotline  labelColor="#cf3312"   :value="5"   labelText="Party label 🥳" />
```

```
<VisPlotline  labelColor="#cf3312"   value={5}   labelText="Party label 🥳"/>
```

```
const plotline = new Plotline<DataRecord>({  labelColor: "#cf3312",   value: 5,   labelText: "Party label 🥳"})
```

Loading...

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _Plotline_ component supports additional styling via CSS variables that you can define for your visualization container. For example:

styles.css

```
.custom-plotline {  --vis-plotline-color: rgb(226, 32, 58);  --vis-plotline-width: 2;  --vis-plotline-label-font-size: 12px;  --vis-plotline-label-color: #000;}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer yDomain={[0]} data={data}>  <VisLine x={x} y={y}/>  <VisAxis type="x"/>  <VisAxis type="y"/>  <VisPlotline value={5} labelText="Fancy label 😎"/></VisXYContainer>
```

template.html

```
<vis-xy-container [yDomain]="[0]" [data]="data">  <vis-line [x]="x" [y]="y"></vis-line>  <vis-axis type="x"></vis-axis>  <vis-axis type="y"></vis-axis>  <vis-plotline [value]="5" labelText="Fancy label 😎"></vis-plotline></vis-xy-container>
```

component.svelte

```
<VisXYContainer yDomain={[0]} {data}>  <VisLine {x} {y}/>  <VisAxis type="x"/>  <VisAxis type="y"/>  <VisPlotline value={5} labelText="Fancy label 😎"/></VisXYContainer>
```

component.vue

```
<VisXYContainer :yDomain="[0]" :data="data">  <VisLine :x="x" :y="y" />  <VisAxis type="x" />  <VisAxis type="y" />  <VisPlotline :value="5" labelText="Fancy label 😎" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer yDomain={[0]} data={data}>  <VisLine x={x} y={y}/>  <VisAxis type="x"/>  <VisAxis type="y"/>  <VisPlotline value={5} labelText="Fancy label 😎"/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  yDomain: [0],   components: [    new Line({ x, y })    new Plotline({ value: 5, labelText: "Fancy label 😎" })  ],   xAxis: new Axis({ type: "x" }),   yAxis: new Axis({ type: "y" })}, data)
```

Loading...

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |