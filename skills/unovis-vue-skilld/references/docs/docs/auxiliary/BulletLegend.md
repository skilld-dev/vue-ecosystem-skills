---
title: "Bullet Legend | Unovis"
meta:
  "og:description": Overview
  "og:title": "Bullet Legend | Unovis"
  description: Overview
---

## Overview [](#overview "Direct link to Overview")

_BulletLegend_ is a stand-alone component that can be used alongside your visualization to label colored data.

## Legend Items [](#legend-items "Direct link to Legend Items")

_BulletLegend_ requires the `items` property, an array of items that will be displayed in the legend. Each item has type `BulletLegendItemInterface`:

```
interface BulletLegendItemInterface {  name: string | number;  color?: string;  shape?: BulletShape;  inactive?: boolean;  hidden?: boolean;  pointer?: boolean;}
```

Note that the only required property, `name` corresponds to the legend items' label. Here is an example of a basic configuration, where `labels` is an array of strings:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
import { VisBulletLegend } from '@unovis/react'import { labels } from './data'function Component(props) {  const items = labels.map(label => ({ name: label }))  return (    <VisBulletLegend items={items}/>  )}
```

component.ts

```
import { labels } from './data'@Component({  template: '<vis-bullet-legend [items]="items"></vis-bullet-legend>'})export class Component {  items = labels.map(label => ({ name: label }))}
```

component.svelte

```
<script lang='ts'>  import { VisBulletLegend } from '@unovis/svelte'  import { labels } from './data'  const items = labels.map(label => ({ name: label }))</script><VisBulletLegend {items}/>
```

component.vue

```
<script setup lang="ts">import { VisBulletLegend } from '@unovis/vue'import { labels } from './data'const items = labels.map(label => ({ name: label }))</script><template>  <VisBulletLegend :items="items" /></template>
```

component.tsx

```
import { VisBulletLegend } from '@unovis/solid'import { labels } from './data'function Component(props) {  const items = labels.map(label => ({ name: label }))  return (    <VisBulletLegend items={items}/>  )}
```

component.ts

```
import { BulletLegend } from '@unovis/ts'import { labels } from './data'const bulletLegend = new BulletLegend(node, {  items: labels.map(label => ({ name: label }))})
```

Loading...

### Color [](#color "Direct link to Color")

By default, our color palette will be used to color each legend item, but you can provide your own colors in the legend item array.

```
const colors = ['red', 'blue', 'green']const items = labels.map((label, i) => ({ name: label, color: colors[i] }))
```

or manually:

```
const items = [  { name: 'A', color: 'red' },  { name: 'B', color: 'blue' },  { name: 'C', color: 'green' }]
```

Either will produce the following result:

Loading...

### Multiple Colors Per Item `1.6`[](#multiple-colors-per-item-16 "Direct link to multiple-colors-per-item-16")

In case you want to have multiple colors in your legend, you can simply pass in an arry into `color`

```
const items = [  {    name: 'item 1',    color: ['#4cc9f0', '#4361ee', '#f72585', '#7209b7']  },  {    name: 'item 2',    color: ['#3a0ca3', '#f9c74f', '#f94144']  }]
```

Loading...

### Shape [](#shape "Direct link to Shape")

You can specify the shape of individual bullets with the `shape` property or with the [`bulletShape`](#bullet-shapes) component config property. This is useful when you want to have the legend with a line chart or shaped scatter plot.

The supported shapes are apart of the `BulletShape` enum.

```
import { BulletShape } from '@unovis/ts'const items = [  { name: 'Circle', shape: BulletShape.Circle },  { name: 'Square', shape: BulletShape.Square },  { name: 'Triangle', shape: BulletShape.Triangle }  { name: 'Star', shape: BulletShape.Star }]
```

Loading...

<details>

<summary>All supported shapes:</summary>



- `BulletShape.Circle` or _"circle"_
- `BulletShape.Cross` or _"cross"_
- `BulletShape.Diamond` or _"diamond"_
- `BulletShape.Line` or _"line"_
- `BulletShape.Square` or _"square"_
- `BulletShape.Star` or _"star"_
- `BulletShape.Triangle` or _"triangle"_
- `BulletShape.Wye` or _"wye"_

</details>

### Inactive Items [](#inactive-items "Direct link to Inactive Items")

In some cases you may want to have some legend items look _inactive_, which reduces the opacity of the bullet. See how the initial legend looks when all of the items are inactive:

```
const items = labels.map(label => ({ name: label, inactive: true }))
```

Loading...

### Pointer [](#pointer "Direct link to Pointer")

The `pointer` property in the `BulletLegendItemInterface` refers to the cursor CSS property. Note that there is no specified default value unless `onLegendItemCilck` property is provided, in which case the cursor will be `pointer`.

## Orientation [](#orientation "Direct link to Orientation")

The `orientation` property can be set to `BulletLegendOrientation.Horizontal` (`'horizontal'`) or `BulletLegendOrientation.Horizontal` (`'vertical'`) to change the layout of the legend items. Having a vertical legend is useful when you have a large number of items and the legend container is scrollable.

Loading...

## Bullet Shapes [](#bullet-shapes "Direct link to Bullet Shapes")

You can specify the bullet shapes with `bulletShape` property. By default, the bullet shape is `circle` unless an individual item has a configured shape (see [Shape](#shape) section).

You can provide this property with a `BulletShape` enum value or string. Or a constant value. This might be preferable if you want each shape to be the same. For example:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBulletLegend items={items} bulletShape="line"/>
```

```
<vis-bullet-legend  [items]="items"   bulletShape="line"></vis-bullet-legend>
```

```
<VisBulletLegend {items} bulletShape="line"/>
```

```
<VisBulletLegend :items="items" bulletShape="line" />
```

```
<VisBulletLegend items={items} bulletShape="line"/>
```

```
const bulletLegend = new BulletLegend(node, { items, bulletShape: "line" })
```

Loading...

Alteratively, you can provide an accessor function of type:

```
function (d: BulletLegendItemInterface, i: number): BulletShape | string {}
```

note

If `bulletShape` is supplied, it will take precedence over the `shape` property in the `items` array.

## Label Configuration [](#label-configuration "Direct link to Label Configuration")

### Font Size [](#font-size "Direct link to Font Size")

The label's font size can be changed with a valid font-size CSS string provided to the `labelMaxWidth` property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBulletLegend items={items} labelFontSize="x-large"/>
```

```
<vis-bullet-legend  [items]="items"   labelFontSize="x-large"></vis-bullet-legend>
```

```
<VisBulletLegend {items} labelFontSize="x-large"/>
```

```
<VisBulletLegend :items="items" labelFontSize="x-large" />
```

```
<VisBulletLegend items={items} labelFontSize="x-large"/>
```

```
const bulletLegend = new BulletLegend(node, { items, labelFontSize: "x-large" })
```

Loading...

### Max Width [](#max-width "Direct link to Max Width")

Limit the label lengths with the `labelMaxWidth` property, which corresponds to the max-width CSS property. For example,

Loading...

providing `labelMaxWidth` will trim the contents of the item that exceeds the width.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisBulletLegend items={items} labelMaxWidth="50px"/>
```

```
<vis-bullet-legend  [items]="items"   labelMaxWidth="50px"></vis-bullet-legend>
```

```
<VisBulletLegend {items} labelMaxWidth="50px"/>
```

```
<VisBulletLegend :items="items" labelMaxWidth="50px" />
```

```
<VisBulletLegend items={items} labelMaxWidth="50px"/>
```

```
const bulletLegend = new BulletLegend(node, { items, labelMaxWidth: "50px" })
```

Loading...

### Custom Class [](#custom-class "Direct link to Custom Class")

You can also add any further configuration for your labels by providing `labelClassName` with your custom css class.

## Interactive Legend [](#interactive-legend "Direct link to Interactive Legend")

You can provide an event listener to `onLegendItemClick` to create interactive legends for your graph. It accepts a function that has the following signature:

```
function (item: BulletLegendItemInterface, index: number): void
```

where the parameters correspond to the clicked item.

One common configuration is when you want to filter a data in your chart based on the "active" legend items. Consider the following `StackedBar` chart example, where `onLegendItemClick` updates the _yAccessors_ to return `0` when the corresponding legend item is inactive. Try clicking to see the result:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
export function Chart({ data, x, y }): JSX.Element {const [items, setItems] = useState([  { name: 'Class A', inactive: false },  { name: 'Class B', inactive: false },  { name: 'Class C', inactive: false },])const toggleItem = useCallback((item: BulletLegendItemInterface, i: number) => {  const itemsCopy = [...items]  itemsCopy[i].active = !itemsCopy[i].active  setItems(itemsCopy)}, [items])return (<>  <VisBulletLegend items={items} onLegendItemClick={toggleItem}/>  <VisXYContainer data={data}>    <VisStackedBar x={x} y={useMemo(() => items.map((item, i) => item.inactive ? 0 : y[i]), [items])}/>    <VisAxis type='y'/>  </VisXYContainer></>)}
```

component.ts

```
data: DataRecord[]x: NumericAccessor<DataRecord>y: NumericAccessor<DataRecord>[]items: BulletLegendItemInterface[] = [{ name: 'Class A', inactive: false },{ name: 'Class B', inactive: false },{ name: 'Class C', inactive: false },]toggleItem (item: BulletLegendItemInterface, i: number): void {const itemsCopy = [...items]itemsCopy[i].active = !itemsCopy[i].activethis.items = itemsCopythis.y = items.map((y, i) => item.inactive ? 0 : y[i])}
```

template.html

```
<vis-bullet-legend [items]="items" [onLegendItemClick]="toggleItem"></vis-bullet-legend><vis-xy-container [data]="data"><vis-stacked-bar [x]="x" [y]="y"></vis-stacked-bar><vis-axis type="y"></vis-axis></vis-xy-container>
```

component.svelte

```
<script lang='ts'>let data: DataRecord[]let x: NumericAccessor<DataRecord>let y: NumericAccessor<DataRecord>[]let items = [  { name: 'Class A', inactive: false },  { name: 'Class B', inactive: false },  { name: 'Class C', inactive: false },])function toggleItem (item: BulletLegendItemInterface, i: number): void {  items[i].inactive = !items[i].inactive  y = items.map((item, i) => item.inactive ? 0 : y[i])}</script><VisBulletLegend {items} onLegendItemClick={toggleItem}/><VisXYContainer data={data}><VisStackedBar x={x} y={y}/><VisAxis type='y'/></VisXYContainer>
```

```

```

```

```

component.ts

```
const items = [{ name: 'Class A', inactive: false },{ name: 'Class B', inactive: false },{ name: 'Class C', inactive: false },]const legend = new BulletLegend(container)const chart = new XYContainer<DataRecord>(container, {components: [new StackedBar({ x, y })],xAxis: new Axis()}, data)function toggleItem (item: BulletLegendItemInterface, i: index): void {const items = legend.config.itemsitems[i].active = !items[i].activelegend.update({ ...legend.config, items: items })chart.updateComponents([{ x, y: items.map((item, i) => item.inactive ? 0 : y[i]) }])}legend.update({ items, onLegendItemClick: toggleItem })
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |