---
title: "Single Container | Unovis"
meta:
  "og:description": "Learn how to use Single Container"
  "og:title": "Single Container | Unovis"
  description: "Learn how to use Single Container"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

_Single Container_ is a basic container for a Unovis component. It is designed to hold one visualization component and an (optional) _Tooltip_. Just wrap the component of your choice in _Single Container_ to render it.

note

For XY Components, instead use the XY Container, which designed to handle 2D data with X and Y coordinates.

## Sizing [](#sizing "Direct link to Sizing")

### Width and Height [](#width-and-height "Direct link to Width and Height")

By default, _Single Container_ will try to fit within the bounds of its parent HTML element. If the parent height isn't defined, the default height of `300px` will be applied. You can also explicitly define the container's size with the `width` and `height` properties, which accepts numeric values.

```
const width = 200;const height = 100;
```

### Margin and Padding [](#margin-and-padding "Direct link to Margin and Padding")

You can supply _Single Container_'s `margin` and `padding` properties with values of the following type:

```
type Sizing = {  top: number;  bottom: number;  left: number;  right: number;}
```

Where each number represents the number of pixels for the corresponding property.

Note: Size Conflicts

Setting margin will affect the chart's size. Notice how Sankey's width decreases when setting the horizontal margin, despite having the same configured width:

```
{ left: 100, right: 100 }
```

#### Before: [](#before "Direct link to Before:")

Loading...

#### After: [](#after "Direct link to After:")

Loading...

### `sizing` Property [](#sizing-property "Direct link to sizing-property")

The `sizing` property determines whether components should fit into the container or the container should expand to fit to the component's size. Currently, only Sankey supports the `sizing` option. By default, all components will fit to the size of _Single Container_.

## SVG Defs [](#svg-defs "Direct link to SVG Defs")

You can use the `svgDefs` property to define custom fill patterns for your components. See our Tips and Tricks for details.

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |