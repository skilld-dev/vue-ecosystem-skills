# Components

Per-component key config options. Config interfaces live at
`components/<name>/config.d.ts` in the package; full option docs at
`https://unovis.dev/docs/components/<Name>`. Only non-obvious or frequently
needed options are listed; defaults come from the config source.

All XY components inherit `x`, `y`, `id`, `color`, `colorKeys`,
`excludeFromDomainCalculation`, plus `duration`, `events`, `attributes`
(see [API surface](api-surface.md)).

## XY chart components

### Line — `components/line/config.d.ts`
- `curveType: CurveType` (default `MonotoneX`), `lineWidth` (default `2`),
  `lineDashArray`, `pattern` (`LinePatternType`).
- `fallbackValue`: `undefined` breaks the line on missing data, `null`
  treats gaps as `0`.
- `interpolateMissingData: boolean` draws a dashed gapfill segment,
  styled via `--vis-line-gapfill-*` CSS variables.
- `highlightOnHover` (default `false`).

### Area — `components/area/config.d.ts`
- `baseline` accessor, `opacity`, `curveType` (default `MonotoneX`).
- `line`, `lineColor`, `lineWidth`, `linePattern` render an outline on top.
- `minHeight` keeps zero/small segments visible; `stackMinHeight` stacks
  them.

### StackedBar — `components/stacked-bar/config.d.ts`
- `y` accepts an **array** of accessors, one per stack level.
- `barWidth`/`barMaxWidth` (px), `barPadding` (default `0`), `roundedCorners`
  (default `2`), `orientation` (default `Vertical`).
- `baseline` accessor enables waterfall/floating bars.
- `barStyle` accessor applies inline styles per bar (`fill`/`opacity`/
  `cursor`/`mask` stay managed by the component).

### GroupedBar — `components/grouped-bar/config.d.ts`
- `y` accepts an array of accessors, one per bar in each group.
- `groupWidth`/`groupMaxWidth`, `groupPadding` (default `0.05`),
  `barPadding` (default `0`), `roundedCorners` (default `2`),
  `barMinHeight` (default `1`), `dataStep` for gappy X data.

### Scatter — `components/scatter/config.d.ts`
- `size` (default `10`, diameter for circles), `sizeRange` + `sizeScale`
  (default `Scale.scaleSqrt()`) to scale point size by data.
- `shape` (default `SymbolType.Circle`), `strokeColor`, `strokeWidth`.
- `label`, `labelPosition` (default `Position.Bottom`),
  `labelHideOverlapping` (default `true`).

### Boxplot — `components/boxplot/config.d.ts`
Calculates quartiles from `x`/`y` data. See docs page for stats accessors.

### XYLabels — `components/xy-labels/config.d.ts`
Text labels positioned by data coordinates; `XYLabelPositioning` controls
placement.

### Crosshair — `components/crosshair/config.d.ts`
Passed to `XYContainer` config, not `components`.
- `template: (d, x, data, leftNearestDatumIndex) => string | HTMLElement`
  drives its tooltip content; give it a `Tooltip` instance via `tooltip`.
- `snapToData` (default `true`), `snapMode` (default `CrosshairSnapMode.X`;
  use `XY` for Scatter).
- `yStacked` accessors for StackedBar/Area; `color`, `circleRadius`
  (default `3`), `showHorizontalLine` (default `false`).
- `onCrosshairMove(x?, datum?, datumIndex?, event?)` callback.
- `visibilityThreshold` (default `0.35`): lower it for charts larger than
  the viewport, or set `0` to always show.

### Brush / FreeBrush — `components/brush/config.d.ts`, `components/free-brush/config.d.ts`
- Brush: 1D selection along X. `onBrush(selection, event, userDriven)`,
  `selection` in data coordinates (settable for controlled brush),
  `draggable`, `selectionMinLength`, `brushHeightExtend`.
- FreeBrush: 2D rectangular selection, `FreeBrushMode` selection behavior.

### Timeline — `components/timeline/config.d.ts`
Gantt-style rows in an XY container. Key accessors: `lineRow`, `lineDuration`
(X is start time), `color`, `lineWidth` (default `8`), `rowHeight` (default
`22`), `showRowLabels`, `rowLabelFormatter`. Note: `type`, `length`,
`cursor`, `showLabels`, `labelWidth`, `maxLabelWidth` are deprecated
renames.

### Plotband / Plotline — `components/plotband|plotline/config.d.ts`
Horizontal/vertical reference bands and lines inside an XY container, with
label placement enums (`PlotbandLabelPosition`, ...).

### Annotations — `components/annotations/config.d.ts`
Relative-position annotation labels; passed to container config
(`annotations` slot).

### Axis — `components/axis/config.d.ts`
- `label`, `tickFormat(tick, i, ticks)`, `tickValues`, `numTicks`,
  `tickSpacing` (X only, default `175`).
- `gridLine` (default `true`), `tickLine` (default `true`), `domainLine`
  (default `true`), `tickTextAngle`, `tickTextFontSize`.
- `tickTextAdaptiveSets` picks the largest fitting tick set; combine with
  `tickTextHideOverlapping` for narrow charts.
- `minMaxTicksOnly` collapses to two ticks.

## Single-container components

### Graph — `components/graph/config.d.ts`
Data: `{ nodes, links }`, links by node `id` (`data-models/graph.d.ts`).
- `layoutType` (`GraphLayoutType.Circular | Concentric | Parallel |
  ParallelHorizontal | Dagre | Force | Elk | Precalculated`); layout
  settings objects per type (`GraphForceLayoutSettings`,
  `GraphDagreLayoutSetting`, `GraphElkLayoutSettings`).
- Nodes: `nodeId`, `nodeSize`, `nodeShape` (`GraphNodeShape.Circle` default),
  `nodeFill`, `nodeIcon`, `nodeLabel`, custom render hooks
  (`nodeEnterCustomRenderFunction` etc.).
- Links: `linkSource`, `linkTarget`, `linkStroke`, `linkWidth`,
  `linkArrow` (`GraphLinkArrowStyle.Single` default), `linkFlow` +
  `linkFlowParticleSpeed` for animated traffic.
- Interaction: `zoomScaleExtent` (default `[0.35, 1.25]`), `disableZoom`,
  `disableDrag`, `fitViewPadding`, `fitViewAlign`, `onNodeClick`,
  `onLinkClick`, `onZoom`, `onRenderComplete`.
  `GraphNodeSelectionHighlightMode` controls selection emphasis.

### Sankey — `components/sankey/config.d.ts`
Data: `{ nodes, links }` with `nodeId`, `linkValue`. Node alignment via
`nodeAlign` (`SankeyNodeAlign.Justify` default; `SankeyLayout` exposes the
d3 alignment functions), `nodeWidth`, `nodePadding`, `iterations`. Zoom via
`enableZoom`, `zoomMode` (`SankeyZoomMode.XY` etc.). Enter/exit transitions
via `SankeyEnterTransitionType` / `SankeyExitTransitionType`.

### TopoJSONMap — `components/topojson-map/config.d.ts`
- `topojson` (TopoJSON.Topology; bundled ones in `maps.d.ts`),
  `mapFeatureName` (default `'countries'`), `projection` (default
  `MapProjection.Kavrayskiy7()`).
- Areas: `areaId` (must match TopoJSON feature ids), `areaColor`,
  `areaLabel`.
- Points: `longitude`, `latitude`, `pointColor`, `pointRadius` (default
  `8`), `pointShape` (`TopoJSONMapPointShape.Circle`), `pointLabel`.
- Links/flows: `linkSource`, `linkTarget`, `linkWidth`, plus
  `sourceLongitude`/`sourceLatitude`/`targetLongitude`/`targetLatitude`
  flow particle options with `enableFlowAnimation`.
- Clustering: `clustering` (default `false`), `clusteringDistance`
  (default `55`), `clusterColor`, `clusterRadius`, `clusterExpandOnClick`.
- Zoom: `zoomFactor`, `zoomExtent` (default `[0.5, 6]`), `disableZoom`,
  `zoomToLocation({ coordinates, zoomLevel, expandCluster })`.
- Heatmap mode: `heatmapMode`, `heatmapModeBlurStdDeviation`.

### LeafletMap / LeafletFlowMap — `components/leaflet-map/`, `components/leaflet-flow-map/`
Standalone (no container). Tile renderer via `renderer`
(`LeafletMapRenderer.Leaflet` default, `MapLibre` with style objects like
`MapLibreArcticLight`), points/links/clustering similar to TopoJSONMap.
The map library deps load via dynamic import.

### Donut — `components/donut/config.d.ts`
- `value` accessor (required), `angleRange` (e.g.
  `DONUT_HALF_ANGLE_RANGE_TOP` from `components/donut/constants` for
  half-donuts), `arcWidth`, `cornerRadius`, `padAngle`.
- `centralLabel`, `centralSubLabel` for center text.

### NestedDonut — `components/nested-donut/config.d.ts`
Sunburst-style rings. Data via nested `children`; config includes
`NestedDonutDirection` and `NestedDonutSegmentLabelAlignment`.

### RadialBar — `components/radial-bar/config.d.ts`
Bars around a circle. Note: events/attributes callbacks receive
`RadialBarArcDatum` (`components/radial-bar/types.d.ts`).

### Heatmap — `components/heatmap/config.d.ts`
Calendar heatmap in a `SingleContainer` (extends `ComponentCore`, not XY).
- `value` accessor (required) drives cell color; `null` renders an empty
  cell. `color` accessor takes precedence over `colorRange`.
- `colorRange: string[]` bucket colors build a quantized value → color
  scale; default green sequence configurable via `--vis-heatmap-color-*`
  CSS variables. `colorDomain: [min, max]` fixes its domain.
- `layout` fills the grid `HeatmapLayoutType.Column` (default,
  GitHub-contributions style) or `Row`; `numRows` (default `7`),
  `numColumns`, `offset` for alignment.
- `cellSize` (px or `[width, height]`; unset stretches to container),
  `cellPadding` (default `2`), `cellCornerRadius` (default `2`),
  `rowLabel`, `columnLabel`.

### Treemap — `components/treemap/config.d.ts`
- `layers: StringAccessor<Datum>[]` (hierarchy levels, required),
  `value`, `tileColor`, `tileLabel`, `tilePadding`, `tileBorderRadius`,
  `enableLightnessVariance` and `enableTileLabelFontSizeVariation` for
  automatic shading and font variation.

### ChordDiagram — `components/chord-diagram/config.d.ts`
Matrix or link-list flows; `ChordLabelAlignment` for label placement.

## Standalone legends and controls

- `BulletLegend` — `items: { name, color?, shape?, inactive?, hidden?,
  pointer?, colorKey? }[]`, `orientation` (`BulletLegendOrientation.Horizontal`
  default), `onLegendItemClick(d, i)`, `bulletShape`
  (`components/bullet-legend/config.d.ts`).
- `RollingPinLegend`, `FlowLegend` — proportional legends for flows/maps.
- `VisControls` — zoom/fit controls overlay, `VisControlsOrientation`.
- `Tooltip` — used via container `tooltip` slot or standalone; triggers
  keyed by `Component.selectors.X` returning HTML string or HTMLElement
  (`components/tooltip/config.d.ts`).
