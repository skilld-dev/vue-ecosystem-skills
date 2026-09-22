# API surface

Everything below is exported from the package entry point `@unovis/ts`
(`index.d.ts`, `index.js`). Paths are relative to the package root.

## Containers

| Export | Config type | Notes |
| --- | --- | --- |
| `XYContainer<Datum>` | `XYContainerConfigInterface<Datum>` | Multi-component XY chart, axes, tooltip, crosshair, annotations |
| `SingleContainer<Data>` | `SingleContainerConfigInterface<Data>` | Exactly one `component` |

Shared container config (`core/container/config.d.ts`): `duration`, `margin`,
`padding`, `sizing`, `width`, `height`, `svgDefs`, `ariaLabel`,
`colorFunction`.

`XYContainerConfigInterface` adds (`containers/xy-container/config.d.ts`):
`components`, `xScale`/`yScale` (`Scale.scaleLinear()` etc.),
`xDomain`/`yDomain`, `xDomainMinConstraint`/`xDomainMaxConstraint` (and Y
counterparts), `xRange`/`yRange`, `yDirection` (`Direction.North` default),
`xAxis`, `yAxis`, `autoMargin` (default `true`), `tooltip`, `crosshair`,
`annotations`, `preventEmptyDomain` (default `null`), `scaleByDomain`,
`clipPathExtend` (default `2`), `bleed`, `onRenderComplete`.

`SingleContainerConfigInterface` adds: `component`, `tooltip`,
`annotations`, `onRenderComplete`
(`containers/single-container/config.d.ts`).

### Class methods

`ContainerCore` (`core/container/index.d.ts`): `render(duration?)`,
`destroy()`, getters `containerWidth`, `containerHeight`, `width`, `height`.

`XYContainer` (`containers/xy-container/index.d.ts`): `setData(data,
preventRender?)`, `updateContainer(config, preventRender?)`,
`updateComponents(configs, preventRender?)` (index-aligned with `components`),
`update(containerConfig, componentConfigs?, data?)`, `components` getter.

`SingleContainer` (`containers/single-container/index.d.ts`): `setData`,
`updateContainer`, `updateComponent(config, preventRender?)`, `update`,
`getFitWidthScale()`.

## Components

Chart components (config type named `<Name>ConfigInterface<Datum>` in each
directory):

`Line`, `Area`, `StackedBar`, `GroupedBar`, `Boxplot`, `Scatter`,
`Crosshair`, `Brush`, `FreeBrush`, `Timeline`, `XYLabels`, `Heatmap`,
`Annotations`, `Plotband`, `Plotline`, `Axis`, `Tooltip`, `Sankey`,
`ChordDiagram`, `Graph`, `TopoJSONMap`, `LeafletMap`, `LeafletFlowMap`,
`Donut`, `NestedDonut`, `RadialBar`, `Treemap`, `BulletLegend`,
`RollingPinLegend`, `FlowLegend`, `VisControls`
(`components.d.ts`).

LeafletMap styles: `MapLibreArcticDark`, `MapLibreArcticLight`.

## Base classes

- `ComponentCore<CoreDatum, Config>` (`core/component/index.d.ts`):
  `setConfig`, `setData`, `setSize`, `render(duration?)`, `destroy()`,
  `isDestroyed()`, `bleed` getter. Containers drive sizing and color.
- `XYComponentCore<Datum, Config>` extends it with `xScale`/`yScale`
  management. All XY chart components extend this.

Shared component config (`core/component/config.d.ts`):

- `duration` (default `600`): data update transition duration.
- `events`: `{ [Component.selectors.X]: { click?: fn, mouseover?: fn, ... } }`.
  Callbacks receive `(datum, event)`.
- `attributes`: `{ [Component.selectors.X]: { [name]: value | accessor } }`.
  Applied to rendered elements; use for E2E test hooks.

Every component class exposes a static `selectors` object keyed by element
(e.g. `Line.selectors.line`, `Area.selectors.area`,
`StackedBar.selectors.bar`). Source: `components/*/index.d.ts`.

XY component config (`core/xy-component/config.d.ts`): `x` accessor
(required), `y` single or array of accessors (required), `id` (default
`(d, i) => d.id ?? i`), `color` (default `d => d.color`), `colorKeys`,
`xScale`/`yScale` (caller manages domain and range), and
`excludeFromDomainCalculation` for secondary-data components.

## Accessor types (`types/accessor.d.ts`)

```ts
type NumericAccessor<D> = ((d: D, i: number, ...any: unknown[]) => number | null | undefined)
  | number | null | undefined
// StringAccessor, ColorAccessor, BooleanAccessor, GenericAccessor<R, D> follow the same shape
type ColorFunction = (key: string | number) => string
```

Accessors returning `null`/`undefined` usually mean "fall back to default"
(e.g. palette color), not zero.

## Enums and value objects (`types/`, plus component `types.d.ts`)

- `CurveType` (`types/curve.d.ts`): `Linear`, `MonotoneX` (Line/Area default),
  `MonotoneY`, `Natural`, `Step`, `StepAfter`, `StepBefore`, `Basis*`,
  `Cardinal*`, `CatmullRom*`, `Bundle`. `Curve` maps them to d3 factories.
- `SymbolType` (`types/symbol.d.ts`): `Circle`, `Cross`, `Diamond`, `Square`,
  `Star`, `Triangle`, `Wye`.
- `Position`: `Top`, `Bottom`, `Left`, `Right`, `Center`, `Auto`.
  `Orientation`: `Horizontal`, `Vertical`. `Arrangement`: `Inside`,
  `Outside`, `Center`. `PositionStrategy`: `Absolute`, `Fixed`
  (`types/position.d.ts`).
- `Direction` (`types/direction.d.ts`): `North`, `South`, `East`, `West`.
- `Sizing` (`types/component.d.ts`): `Fit`, `Extend`, `FitWidth`.
- `FitMode` (`Wrap`, `Trim`), `TrimMode` (`Start`, `Middle`, `End`),
  `TextAlign` (`Left`, `Center`, `Right`), `VerticalAlign` (`Top`,
  `Middle`, `Bottom`) — `types/text.d.ts`.
- `AxisType` (`components/axis/types.d.ts`): `X`, `Y`.
- `Scale` (`types/scale.d.ts`): re-export of d3-scale factory functions
  (`scaleLinear`, `scaleLog`, `scaleTime`, `scaleBand`, ...).
  `ContinuousScale` = the union accepted by XY `xScale`/`yScale`.
- `Shape`, `CrosshairSnapMode` (`X`, `XY`), `FindNearestDirection`,
  `FreeBrushMode`, `HeatmapLayoutType`, `GraphLayoutType`, `GraphNodeShape`,
  `GraphLinkStyle`, `GraphLinkArrowStyle`, `GraphNodeSelectionHighlightMode`,
  `GraphFitViewAlignment`, `SankeyLayout`, `SankeyNodeAlign`, `SankeyZoomMode`,
  `SankeyZoomOrigin`, `SankeyEnterTransitionType`, `SankeyExitTransitionType`,
  `SankeySubLabelPlacement`, `NestedDonutDirection`,
  `NestedDonutSegmentLabelAlignment`, `PlotbandLabelPosition`,
  `PlotbandLabelOrientation`, `PlotlineLabelPosition`,
  `PlotlineLabelOrientation`, `PlotlineLineStylePresets`,
  `BulletLegendOrientation`, `BulletShape`, `ChordLabelAlignment`,
  `VisControlsOrientation`, `XYLabelPositioning`, `LeafletMapPointShape`,
  `LeafletMapRenderer`, `TopoJSONMapPointShape`, `MapPointLabelPosition`,
  `MapProjection`, `MapProjectionKind`.

## Data models (`data-models/`)

`GraphDataModel`, `MapDataModel`, `MapGraphDataModel`, `SeriesDataModel`.
Graph data shape: `{ nodes: N[], links?: L[] }` with links referencing nodes
by `id` (`data-models/graph.d.ts`).

## Style exports (`styles/`)

`colors` (default light palette array), `colorsDark`,
`getCSSColorVariable(index)` → `--vis-color<N>`, `getLighterColor`,
`getDarkerColor` (`styles/colors.d.ts`); `FillPatternType`,
`LinePatternType`, `fills`, `lines`, `PATTERN_SIZE_PX` (`styles/patterns.d.ts`);
`styleLargeSize`, `styleExtraLargeSize` (`styles/sizes.d.ts`).

## Utility exports (`utils/`)

Commonly useful: `getColor`, `isColorDark`, `UnovisColorScale` (ordinal
palette scale, `utils/color.d.ts`), `clamp`, `getExtent`, `getStackedExtent`,
`merge`, `isEqual`, `throttle` (`utils/data.d.ts`), `isDarkThemeEnabled`,
`cssvar`, `injectGlobalCssVariables` (`utils/style.d.ts`),
`darkThemeCssSelectors` (`utils/theme.d.ts`), `guid`, `getCSSVariableValue`,
`getPixelValue` (`utils/misc.d.ts`), `smartTransition`, `applyInlineStyles`
(`utils/d3.d.ts`), `estimateTextSize`, `getWrappedText`, `trimString*`
(`utils/text.d.ts`).

Full list: `index.js` in the package root.
