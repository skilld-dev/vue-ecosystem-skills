---
title: "XYLabels | Unovis"
meta:
  "og:description": "Learn how to add labels to XY chart data points"
  "og:title": "XYLabels | Unovis"
  description: "Learn how to add labels to XY chart data points"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

Get started with just two required properties - `x`, `y` accessors and an optional `label` function.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.9)"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.9)" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   color: "#374151",   backgroundColor: "rgba(255, 255, 255, 0.9)"})
```

Loading...

```
// Basic configurationconst xyLabels = new XYLabels({  x: d => d.x,  y: d => d.y,  label: d => d.label})
```

## Label Content [](#label-content "Direct link to Label Content")

The `label` property accepts a string accessor function that determines what text to display for each data point.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.95)"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.95)" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   color="#374151"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   color: "#374151",   backgroundColor: "rgba(255, 255, 255, 0.95)"})
```

Loading...

```
// Custom label contentlabel: d => \`${d.label}: ${d.y}\`
```

## Positioning [](#positioning "Direct link to Positioning")

XYLabels supports three different positioning modes through the `xPositioning` and `yPositioning` properties:

### Data Space Positioning (Default) [](#data-space-positioning-default "Direct link to Data Space Positioning (Default)")

By default, labels are positioned in data space, meaning their coordinates correspond to data values. This is ideal when you want labels to move with your data:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   xPositioning="data_space"   yPositioning="data_space"   color="#0F172A"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   xPositioning="data_space"   yPositioning="data_space"   color="#0F172A"   backgroundColor="rgba(255, 255, 255, 0.9)"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   xPositioning="data_space"   yPositioning="data_space"   color="#0F172A"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   xPositioning="data_space"   yPositioning="data_space"   color="#0F172A"   backgroundColor="rgba(255, 255, 255, 0.9)" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   xPositioning="data_space"   yPositioning="data_space"   color="#0F172A"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   xPositioning: "data_space",   yPositioning: "data_space",   color: "#0F172A",   backgroundColor: "rgba(255, 255, 255, 0.9)"})
```

Loading...

```
// Data space positioning (default)xPositioning: XYLabelPositioning.DataSpace,yPositioning: XYLabelPositioning.DataSpace
```

### Absolute Pixel Positioning [](#absolute-pixel-positioning "Direct link to Absolute Pixel Positioning")

Position labels using absolute pixel coordinates from the top-left corner of the chart area:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   xPositioning="absolute_px"   yPositioning="absolute_px"   color="#065F46"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   xPositioning="absolute_px"   yPositioning="absolute_px"   color="#065F46"   backgroundColor="rgba(255, 255, 255, 0.95)"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   xPositioning="absolute_px"   yPositioning="absolute_px"   color="#065F46"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   xPositioning="absolute_px"   yPositioning="absolute_px"   color="#065F46"   backgroundColor="rgba(255, 255, 255, 0.95)" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   xPositioning="absolute_px"   yPositioning="absolute_px"   color="#065F46"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   xPositioning: "absolute_px",   yPositioning: "absolute_px",   color: "#065F46",   backgroundColor: "rgba(255, 255, 255, 0.95)"})
```

Loading...

```
// Absolute pixel positioningxPositioning: XYLabelPositioning.AbsolutePx,yPositioning: XYLabelPositioning.AbsolutePx,x: 100, // 100 pixels from lefty: 50   // 50 pixels from top
```

### Absolute Percentage Positioning [](#absolute-percentage-positioning "Direct link to Absolute Percentage Positioning")

Position labels using percentage coordinates (0-100) relative to the chart container dimensions:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   xPositioning="absolute_percentage"   yPositioning="absolute_percentage"   color="#92400E"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   xPositioning="absolute_percentage"   yPositioning="absolute_percentage"   color="#92400E"   backgroundColor="rgba(255, 255, 255, 0.95)"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   xPositioning="absolute_percentage"   yPositioning="absolute_percentage"   color="#92400E"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   xPositioning="absolute_percentage"   yPositioning="absolute_percentage"   color="#92400E"   backgroundColor="rgba(255, 255, 255, 0.95)" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   xPositioning="absolute_percentage"   yPositioning="absolute_percentage"   color="#92400E"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   xPositioning: "absolute_percentage",   yPositioning: "absolute_percentage",   color: "#92400E",   backgroundColor: "rgba(255, 255, 255, 0.95)"})
```

Loading...

```
// Absolute percentage positioningxPositioning: XYLabelPositioning.AbsolutePercentage,yPositioning: XYLabelPositioning.AbsolutePercentage,x: 75, // 75% from left edgey: 25  // 25% from top edge
```

### Mixed Positioning [](#mixed-positioning "Direct link to Mixed Positioning")

You can mix different positioning modes for x and y coordinates:

```
// Mix data space with screen spacexPositioning: XYLabelPositioning.DataSpace,      // Follow data horizontallyyPositioning: XYLabelPositioning.AbsolutePx,     // Fixed vertical positiony: 20 // Always 20px from top
```

## Styling [](#styling "Direct link to Styling")

### Label Color [](#label-color "Direct link to Label Color")

Control label text color with the `color` property. You can use dynamic colors based on your data:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   color={color}   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   [color]="color"   backgroundColor="rgba(255, 255, 255, 0.9)"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   {color}   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   :color="color"   backgroundColor="rgba(255, 255, 255, 0.9)" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   color={color}   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   color,   backgroundColor: "rgba(255, 255, 255, 0.9)"})
```

Loading...

### Background Color [](#background-color "Direct link to Background Color")

Add background colors to make labels more readable, especially over complex visualizations:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   backgroundColor="rgba(255, 255, 255, 0.95)"   color="#374151"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   backgroundColor="rgba(255, 255, 255, 0.95)"   color="#374151"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   backgroundColor="rgba(255, 255, 255, 0.95)"   color="#374151"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   backgroundColor="rgba(255, 255, 255, 0.95)"   color="#374151" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   backgroundColor="rgba(255, 255, 255, 0.95)"   color="#374151"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   backgroundColor: "rgba(255, 255, 255, 0.95)",   color: "#374151"})
```

Loading...

### Font Size [](#font-size "Direct link to Font Size")

Customize label font size with the `labelFontSize` property. You can make it dynamic based on data values:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   labelFontSize={labelFontSize}   color="#831843"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   [labelFontSize]="labelFontSize"   color="#831843"   backgroundColor="rgba(255, 255, 255, 0.9)"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   {labelFontSize}   color="#831843"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   :labelFontSize="labelFontSize"   color="#831843"   backgroundColor="rgba(255, 255, 255, 0.9)" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   labelFontSize={labelFontSize}   color="#831843"   backgroundColor="rgba(255, 255, 255, 0.9)"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   labelFontSize,   color: "#831843",   backgroundColor: "rgba(255, 255, 255, 0.9)"})
```

Loading...

## Label Clustering [](#label-clustering "Direct link to Label Clustering")

When labels overlap, XYLabels can automatically cluster them to reduce visual clutter. This feature is enabled by default and is particularly useful for dense datasets.

### Enabling/Disabling Clustering [](#enablingdisabling-clustering "Direct link to Enabling/Disabling Clustering")

Control clustering with the `clustering` property. When enabled, overlapping labels are automatically grouped together to reduce visual clutter. Toggle the checkbox below to see the difference:

Loading...

```
// Enable/disable clustering programmaticallyconst xyLabels = new XYLabels({  x: d => d.x,  y: d => d.y,  label: d => d.label,  clustering: true, // Set to false to disable clustering    // Optional: Customize cluster appearance when clustering is enabled  clusterLabel: (records) => \`${records.length} items\`,  clusterBackgroundColor: 'rgba(132, 204, 22, 0.2)',  clusterLabelColor: '#365314'})
```

### Cluster Customization [](#cluster-customization "Direct link to Cluster Customization")

Customize cluster appearance with cluster-specific properties:

```
// Cluster configurationclusterLabel: (records) => \`${records.length} items\`,clusterFontSize: 14,clusterBackgroundColor: 'rgba(59, 130, 246, 0.1)',clusterLabelColor: '#1E40AF'
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   clustering={true}   clusterLabel={clusterLabel}   clusterBackgroundColor="rgba(59, 130, 246, 0.1)"   clusterLabelColor="#1E40AF"   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   [clustering]="true"   [clusterLabel]="clusterLabel"   clusterBackgroundColor="rgba(59, 130, 246, 0.1)"   clusterLabelColor="#1E40AF"   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   clustering={true}   {clusterLabel}   clusterBackgroundColor="rgba(59, 130, 246, 0.1)"   clusterLabelColor="#1E40AF"   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   :clustering="true"   :clusterLabel="clusterLabel"   clusterBackgroundColor="rgba(59, 130, 246, 0.1)"   clusterLabelColor="#1E40AF"   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   clustering={true}   clusterLabel={clusterLabel}   clusterBackgroundColor="rgba(59, 130, 246, 0.1)"   clusterLabelColor="#1E40AF"   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   clustering: true,   clusterLabel,   clusterBackgroundColor: "rgba(59, 130, 246, 0.1)",   clusterLabelColor: "#1E40AF",   color: "#1E40AF",   backgroundColor: "rgba(255, 255, 255, 0.95)"})
```

Loading...

## Events [](#events "Direct link to Events")

The XYLabels component supports interactive events on both individual labels and clusters. Available selectors:

- `XYLabels.selectors.label` - Events for individual labels
- `XYLabels.selectors.cluster` - Events for label clusters (when clustering is enabled)

```
import { XYLabels } from '@unovis/ts'const events = {  [XYLabels.selectors.label]: {    click: (d: Datum) => alert(\`Clicked: ${d.label}\`),    mouseover: (d: Datum) => console.log('Label hovered:', d),    mouseleave: (d: Datum) => console.log('Label unhovered:', d)  },  [XYLabels.selectors.cluster]: {    click: (cluster: XYLabel<Datum>[]) => {      const labels = cluster.map(d => d.label).join(', ')      alert(\`Cluster clicked! Contains: ${labels}\`)    },    mouseover: (cluster: XYLabel<Datum>[]) => {      console.log('Cluster hovered:', cluster.length, 'labels')    }  }}
```

### Interactive Labels [](#interactive-labels "Direct link to Interactive Labels")

Click on any label below to see event handling in action:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisXYLabels  x={x}   y={y}   label={label}   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"   cursor="pointer"   events={events}/>
```

```
<vis-xy-labels  [x]="x"   [y]="y"   [label]="label"   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"   cursor="pointer"   [events]="events"></vis-xy-labels>
```

```
<VisXYLabels  {x}   {y}   {label}   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"   cursor="pointer"   {events}/>
```

```
<VisXYLabels  :x="x"   :y="y"   :label="label"   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"   cursor="pointer"   :events="events" />
```

```
<VisXYLabels  x={x}   y={y}   label={label}   color="#1E40AF"   backgroundColor="rgba(255, 255, 255, 0.95)"   cursor="pointer"   events={events}/>
```

```
const xYLabels = new XYLabels<DataRecord>({  x,   y,   label,   color: "#1E40AF",   backgroundColor: "rgba(255, 255, 255, 0.95)",   cursor: "pointer",   events})
```

Loading...

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The following CSS variables can be used to customize the default appearance:

```
/* Label styling */--vis-xy-label-font-size: 12px;--vis-xy-label-font-family: var(--vis-font-family);--vis-xy-label-text-color: #000;--vis-xy-label-background-fill-color: none;--vis-xy-label-background-stroke-color: none;--vis-xy-label-background-stroke-width: 0;--vis-xy-label-padding: 4px;/* Cluster styling */--vis-xy-label-cluster-font-size: 14px;--vis-xy-label-cluster-text-color: #000;--vis-xy-label-cluster-background-fill-color: #f0f0f0;--vis-xy-label-cluster-background-stroke-color: #ccc;--vis-xy-label-cluster-background-stroke-width: 1px;--vis-xy-label-cluster-padding: 6px;/* Dark theme overrides */--vis-dark-xy-label-text-color: #fff;--vis-dark-xy-label-cluster-text-color: #fff;--vis-dark-xy-label-cluster-background-fill-color: #333;--vis-dark-xy-label-cluster-background-stroke-color: #666;
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |