# Component catalog

All exports come from the package barrel `@unovis/vue` (`components.d.ts`, `containers.d.ts`). Every component also exports a selectors object, for example `VisAreaSelectors`.

Rules:

- Components in the first three sections require a container context. Place them in the container's default slot.
- Standalone components render their own DOM node. Use them anywhere.
- Props map one to one to the `@unovis/ts` config interface named after the core class, for example `StackedBarConfigInterface`.

## Containers

| Component | Core class | Use |
| --- | --- | --- |
| `VisXYContainer` | `XYContainer` | Multiple XY components, axes, crosshair, tooltip, annotations (`containers.d.ts:1`) |
| `VisSingleContainer` | `SingleContainer` | One visualization component plus an optional tooltip (`containers.d.ts:2`) |

Key `VisXYContainer` props, verified in `containers/xy-container/index.js:7-41`: `xScale`, `yScale`, `xDomain`, `yDomain`, `xDomainMinConstraint`, `xDomainMaxConstraint`, `yDomainMinConstraint`, `yDomainMaxConstraint`, `xRange`, `yRange`, `yDirection`, `xAxis`, `yAxis`, `autoMargin`, `tooltip`, `crosshair`, `preventEmptyDomain`, `scaleByDomain`, `annotations`, `clipPathExtend`, `bleed`, `onRenderComplete`, `duration`, `margin`, `padding`, `sizing`, `width`, `height`, `svgDefs`, `ariaLabel`, `colorFunction`, `data`.

`VisSingleContainer` takes the same layout props (`margin`, `padding`, `sizing`, `width`, `height`, `svgDefs`, `ariaLabel`, `colorFunction`, `onRenderComplete`) plus `component`, `tooltip`, and `annotations` (`containers/single-container/index.js:7-22`).

Both containers expose `component`, the ref to the core container instance.

Docs: [XY Container](https://unovis.dev/docs/containers/XY_Container), [Single Container](https://unovis.dev/docs/containers/Single_Container).

## XY chart components

Live inside `VisXYContainer`. All take accessors `x` and `y`, plus `id`, `color`, `colorKeys`, `xScale`, `yScale`, `excludeFromDomainCalculation`, `duration`, `events`, `attributes`, `data`.

| Component | Key props beyond the common set |
| --- | --- |
| `VisArea` | `curveType`, `baseline`, `opacity`, `cursor`, `line`, `lineColor`, `lineWidth`, `lineDashArray`, `linePattern`, `minHeight1Px`, `minHeight`, `stackMinHeight`, `pattern` (`components/area/index.js:7-33`) |
| `VisLine` | `curveType`, `lineWidth`, `lineDashArray`, `fallbackValue`, `highlightOnHover`, `cursor`, `interpolateMissingData`, `pattern` (`components/line/index.js`) |
| `VisScatter` | `size`, `sizeScale`, `sizeRange`, `shape`, `label`, `labelColor`, `labelHideOverlapping`, `labelTextBrightnessRatio`, `labelPosition`, `strokeColor`, `strokeWidth`, `pattern` |
| `VisStackedBar` | `barWidth`, `barMaxWidth`, `dataStep`, `barPadding`, `roundedCorners`, `cursor`, `barMinHeight1Px`, `barMinHeightZeroValue`, `orientation`, `baseline`, `barStyle`, `pattern` (`components/stacked-bar/index.js:8-26`) |
| `VisGroupedBar` | `groupWidth`, `groupMaxWidth`, `dataStep`, `groupPadding`, `barPadding`, `roundedCorners`, `barMinHeight`, `cursor`, `orientation`, `barStyle`, `pattern` (`components/grouped-bar/index.js`) |
| `VisBoxplot` | grouped accessors `median`, `quartiles` (`[q1, q3]`), `whiskers` (`[min, max]`), plus `color`, `barWidth`, `barMaxWidth`, `barPadding`, `roundedCorners`, `dataStep` through config attributes. Declares only `data` as a Vue prop ([docs](https://unovis.dev/docs/components/Boxplot)) |
| `VisTimeline` | row based segments with per row labels and colors. Declares only `data` as a Vue prop ([docs](https://unovis.dev/docs/components/Timeline)) |
| `VisXYLabels` | `label`, `backgroundColor`, `clustering`, `clusterLabel`, `xPositioning`, `yPositioning` |

Docs for each: <https://unovis.dev/docs/components/&lt;Name&gt;>.

`VisBoxplot` example:

```vue
<script setup lang="ts">
const x = (d: StatsRecord) => d.group
const median = (d: StatsRecord) => d.median
const quartiles = (d: StatsRecord) => d.quartiles // [q1, q3]
const whiskers = (d: StatsRecord) => d.whiskers // [min, max]
</script>

<template>
  <VisXYContainer :data="data">
    <VisBoxplot :x="x" :median="median" :quartiles="quartiles" :whiskers="whiskers" />
    <VisAxis type="x" />
    <VisAxis type="y" />
  </VisXYContainer>
</template>
```

Provide a subset of the accessors for quartiles only or median only plots ([Boxplot docs](https://unovis.dev/docs/components/Boxplot)).

## Auxiliary components

| Component | Container | Notes |
| --- | --- | --- |
| `VisAxis` | XY | `type` (`'x'` or `'y'`), `label`, `tickFormat`, `tickValues`, `numTicks`, `tickSpacing`, `tickTextFitMode`, `tickTextWidth`, `tickTextSeparator`, `tickTextAdaptiveSets`, `tickTextFontSize`, `tickTextAlign`, `tickTextAngle`, `tickPadding`, `tickSize`, `gridLine`, `domainLine`, `minMaxTicksOnly`, `labelTextFitMode`, `labelTextTrimType`, `labelTextSeparator` (`components/axis/index.js`) |
| `VisCrosshair` | XY | `template`, `color`, `snapMode`, `showHorizontalLine`, `forceShowAt`, `skipRangeCheck`, `circleRadius` through config attributes. Declares only `data` as a Vue prop ([docs](https://unovis.dev/docs/components/Crosshair)) |
| `VisTooltip` | XY, Single, or standalone | `triggers`, `container`, `followCursor`, `allowHover`, placement props, `hideDelay`, `showDelay` (`components/tooltip/index.js`) |
| `VisBrush` | XY | `onBrush`, `onBrushStart`, `onBrushMove`, `onBrushEnd`, `selection`, `draggable`, `handlePosition`, `selectionMinLength`, `brushHeightExtend` |
| `VisFreeBrush` | XY | `mode`, `onBrush`, `selection`, `autoHide` |
| `VisPlotband` | XY | `axis`, `from`, `to`, `color`, `labelText`, `labelPosition`, `labelOffsetX`, `labelOffsetY`, `labelOrientation`, `labelColor`, `labelSize` (`components/plotband/index.js`) |
| `VisPlotline` | XY | `axis`, `value`, `color`, `lineWidth`, `lineStyle`, `labelText` and the same label props (`components/plotline/index.js`) |
| `VisAnnotations` | XY, Single | `items`, `renderTextBoundingBoxes` (`components/annotations/index.js`) |

## Single container components

Live inside `VisSingleContainer`.

| Component | Key props |
| --- | --- |
| `VisDonut` | `value`, `angleRange`, `padAngle`, `minSegmentAngle`, `sortFunction`, `cornerRadius`, `color`, `pattern`, `radius`, `arcWidth`, `centralLabel`, `centralSubLabel`, `centralSubLabelWrap`, `showEmptySegments` (`components/donut/index.js:7-28`) |
| `VisNestedDonut` | `layers`, `layerSettings`, `layerPadding`, `direction`, `segmentColor`, `segmentPattern`, `segmentLabel`, plus the donut label props |
| `VisRadialBar` | `value`, `maxValue`, `angleRange`, `padAngle`, `barMinAngle`, `sortFunction`, `cornerRadius`, `color`, `radius`, `trackWidth`, `trackPadding`, `reverseOrder`, `centralLabel`, `centralSubLabel`, `showBackground` (`components/radial-bar/index.js:7-32`) |
| `VisHeatmap` | `value`, `color`, `colorRange`, `colorDomain`, `numRows`, `numColumns`, `layout`, `offset`, `cellSize`, `cellPadding`, `cellCornerRadius`, `columnLabel`, `rowLabel`, `labelHideOverlapping` (`components/heatmap/index.js:7-27`) |
| `VisTreemap` | `value`, `layers`, `tileLabel`, `tileColor`, `tileFunction`, `tileSort`, `tilePadding`, `tileShowHtmlTooltip`, `topLevelParent` |
| `VisSankey` | `nodeWidth`, `nodeAlign`, `nodePadding`, `nodeAdaptivePadding`, `nodeSort`, `linkValue`, `linkColor`, `linkPattern`, `labelVisibility`, `subLabelPlacement`, `highlightSubtreeOnHover`, `zoomScale`, `zoomPan`, `enableZoom`, `onLayoutCalculated` (`components/sankey/index.js`) |
| `VisChordDiagram` | `nodeColor`, `nodeLabel`, `nodePattern`, `linkValue`, `linkColor`, `linkPattern`, `highlightedNodeId` (`components/chord-diagram/index.js`) |
| `VisGraph` | `nodes` and `links` in data, `layoutType`, `linkWidth`, `linkFlow`, `nodeSize`, `nodeIcon`, `nodeLabel`, `nodeSubLabel`, `nodeLabelFitMode`, `nodeLabelWidth`, `zoomScaleExtent`, `onNodeSelectionBrush`, `onZoom` and more (`components/graph/index.js`) |
| `VisTopoJSONMap` | `projection`, `topojson`, `mapFeatureName`, `mapFitToPoints`, `zoomFactor`, `linkWidth`, `pointLongitude`, `pointLatitude` and more (`components/topojson-map/index.js`) |

`VisRadialBar` and `VisHeatmap` are new in 1.7 ([release notes](https://unovis.dev/releases/1.7)).

```vue
<script setup lang="ts">
import { VisSingleContainer, VisHeatmap } from '@unovis/vue'
const value = (d: number) => d
</script>

<template>
  <VisSingleContainer :data="data">
    <VisHeatmap :value="value" :num-rows="7" :cell-size="16" :cell-padding="3" :cell-corner-radius="3" />
  </VisSingleContainer>
</template>
```

`VisHeatmap` fills column by column by default. Set `layout` to `HeatmapLayoutType.Row` to fill row by row. A `null` or `undefined` value renders an empty cell ([Heatmap docs](https://unovis.dev/docs/components/Heatmap)).

`VisGraph` data shape:

```ts
const data = {
  nodes: [{ id: 'a', label: 'Node A' }],
  links: [{ source: 'a', target: 'b', width: 2 }],
}
```

## Standalone components

| Component | Notes |
| --- | --- |
| `VisBulletLegend` | `items` (`name`, `color`, `colorKey`), `onLegendItemClick`, `bulletSize`, `bulletShape`, `orientation`, `colorFunction` (`html-components/bullet-legend/index.js`) |
| `VisFlowLegend` | flow intensity legend for flow maps |
| `VisRollingPinLegend` | marginal value ranges ([docs](https://unovis.dev/docs/components/RollingPinLegend)) |
| `VisLeafletMap` | tile map: `accessToken`, `renderer`, `preserveDrawingBuffer`, `pointLongitude`, `pointLatitude`, `topoJSONLayer`, `clusterExpandOnClick` (`html-components/leaflet-map/index.js`). Requires a vector tile URL ([docs](https://unovis.dev/docs/components/LeafletMap)) |
| `VisLeafletFlowMap` | map with flows: data holds `points` and `flows` arrays ([docs](https://unovis.dev/docs/components/LeafletFlowMap)) |

## Types and helpers from @unovis/ts

The wrappers forward config objects, so enums and helpers come from `@unovis/ts`:

```ts
import {
  Scale, // scaleLinear, scalePow, scaleOrdinal for xScale / yScale / colorFunction
  Sizing, // Sizing.Extend for the container sizing prop
  FitMode, // FitMode.Wrap for graph label wrapping
  HeatmapLayoutType, // Column (default) or Row
  FillPatternType, LinePatternType, // pattern accessor values
  CrosshairSnapMode, // X (default) or XY
} from '@unovis/ts'
```

Scale usage: pass a d3 scale to `xScale` or `yScale` ([XY Container docs](https://unovis.dev/docs/containers/XY_Container)).
