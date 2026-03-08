---
title: "Rolling Pin Legend | Unovis"
meta:
  "og:description": Overview
  "og:title": "Rolling Pin Legend | Unovis"
  description: Overview
---

## Overview [](#overview "Direct link to Overview")

_RollingPinLegend_ is a stand-alone component that can be used alongside your visualization to compactly label marginal values while also displaying the color scheme used.

## Legend Contents [](#legend-contents "Direct link to Legend Contents")

_RollingPinLegend_ requires the `rects` property, an array of strings representing colors used in a legend.

`leftLabelText` and `rightLabelText` are optional, but it is recommended to use at least one of them.

Here is an example of a basic configuration:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const rects = [    \`#11F\`,    \`#55F\`,    \`#99F\`,    \`#DDF\`,    \`#fff\`,    \`#FDD\`,    \`#F99\`,    \`#F55\`,    \`#F11\`  ]  return (    <VisRollingPinLegend      rects={rects}       leftLabelText="Democrat"       rightLabelText="Republican"    />  )}
```

component.ts

```
@Component({  template: \`    <vis-rolling-pin-legend      [rects]="rects"       leftLabelText="Democrat"       rightLabelText="Republican"    ></vis-rolling-pin-legend>  \`})export class Component {  rects = [    \`#11F\`,    \`#55F\`,    \`#99F\`,    \`#DDF\`,    \`#fff\`,    \`#FDD\`,    \`#F99\`,    \`#F55\`,    \`#F11\`  ]}
```

component.svelte

```
<script lang='ts'>  import { VisRollingPinLegend } from '@unovis/svelte'  const rects = [    \`#11F\`,    \`#55F\`,    \`#99F\`,    \`#DDF\`,    \`#fff\`,    \`#FDD\`,    \`#F99\`,    \`#F55\`,    \`#F11\`  ]</script><VisRollingPinLegend  {rects}   leftLabelText="Democrat"   rightLabelText="Republican"/>
```

component.vue

```
<script setup lang="ts">import { VisRollingPinLegend } from '@unovis/vue'const rects = [    \`#11F\`,    \`#55F\`,    \`#99F\`,    \`#DDF\`,    \`#fff\`,    \`#FDD\`,    \`#F99\`,    \`#F55\`,    \`#F11\`  ]</script><template>  <VisRollingPinLegend    :rects="rects"     leftLabelText="Democrat"     rightLabelText="Republican"   /></template>
```

component.tsx

```
function Component(props) {  const rects = [    \`#11F\`,    \`#55F\`,    \`#99F\`,    \`#DDF\`,    \`#fff\`,    \`#FDD\`,    \`#F99\`,    \`#F55\`,    \`#F11\`  ]  return (    <VisRollingPinLegend      rects={rects}       leftLabelText="Democrat"       rightLabelText="Republican"    />  )}
```

component.ts

```
const rollingPinLegend = new RollingPinLegend(node, {  rects: [    \`#11F\`,    \`#55F\`,    \`#99F\`,    \`#DDF\`,    \`#fff\`,    \`#FDD\`,    \`#F99\`,    \`#F55\`,    \`#F11\`  ],   leftLabelText: "Democrat",   rightLabelText: "Republican"})
```

Loading...

## Label Configuration [](#label-configuration "Direct link to Label Configuration")

### Font Size [](#font-size "Direct link to Font Size")

The labels' font size can be changed with a valid font-size CSS string provided to the `labelMaxWidth` property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisRollingPinLegend rects={rects} labelFontSize="x-large"/>
```

```
<vis-rolling-pin-legend  [rects]="rects"   labelFontSize="x-large"></vis-rolling-pin-legend>
```

```
<VisRollingPinLegend {rects} labelFontSize="x-large"/>
```

```
<VisRollingPinLegend :rects="rects" labelFontSize="x-large" />
```

```
<VisRollingPinLegend rects={rects} labelFontSize="x-large"/>
```

```
const rollingPinLegend = new RollingPinLegend(node, { rects, labelFontSize: "x-large" })
```

Loading...

### Custom Class [](#custom-class "Direct link to Custom Class")

You can also add any further configuration for labels by providing `labelClassName` with your custom css class.

## CSS Variables [](#css-variables "Direct link to CSS Variables")

<details>

<summary>Supported CSS variables and their default values</summary>



```
--vis-rolling-pin-legend-label-color: #6c778c;--vis-rolling-pin-legend-label-max-width: 300px;--vis-rolling-pin-legend-label-font-size: 12px;--vis-rolling-pin-legend-spacing: 4px;--vis-rolling-pin-legend-item-width: 8px;--vis-dark-rolling-pin-legend-label-color: #eee;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |