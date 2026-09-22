# Migration to 1.7.0

Baseline for this skill: `@unovis/vue@1.7.0` with `@unovis/ts@1.7.0`. This file lists the changes since 1.6.5 that affect Vue code. Cite source: the prepared package and the [1.7 release notes](https://unovis.dev/releases/1.7) plus the [GitHub release](https://github.com/f5/unovis/releases/tag/1.7.0).

## Upgrade actions

1. Update both packages together: `npm install -P @unovis/ts@1.7.0 @unovis/vue@1.7.0`. The `@unovis/ts` peer range is exact (`package.json:57`).
2. If code pins `@unovis/ts` below 1.7.0, npm or pnpm reports a peer conflict. Align the versions first.

## Vue specific fix

The `data` prop of `VisCrosshair`, `VisTimeline`, and `VisBoxplot` was silently dropped between 1.6.5 and 1.7 because of a misplaced `@vue-ignore` annotation. It works again in 1.7.0 ([PR 857](https://github.com/f5/unovis/pull/857)). If per component `data` on these three seems ignored on an older 1.6.x patch, that is the cause.

## New components

- `VisBoxplot`: XY box and whisker plots with grouped `median`, `quartiles`, `whiskers` accessors ([docs](https://unovis.dev/docs/components/Boxplot)).
- `VisRadialBar`: stacked ring charts for `VisSingleContainer`, with `barMinAngle`, `angleRange`, track sizing, central labels ([docs](https://unovis.dev/docs/components/RadialBar)).
- `VisHeatmap`: GitHub style grids for `VisSingleContainer`, with `numRows`, `layout`, `offset`, quantized `colorRange` ([docs](https://unovis.dev/docs/components/Heatmap)).

## New config options on existing components

| Component | Option | Effect |
| --- | --- | --- |
| `VisXYContainer` | `bleed` | Overrides the calculated edge spacing. Takes a `Spacing` object or a function over the components (`containers/xy-container/index.js:29`). Guide: <https://unovis.dev/docs/guides/bleed> |
| `VisXYContainer`, `VisSingleContainer` | `colorFunction` | Chart wide `(key) => color` for synchronized palettes (`containers/xy-container/index.js:39`) |
| XY chart components | `colorKeys` | Stable keys aligned with the `y` accessors (`components/area/index.js:25`) |
| `VisArea`, `VisLine`, `VisScatter`, `VisGroupedBar`, `VisStackedBar`, `VisDonut` | `pattern` | Pattern fills via `FillPatternType` and `LinePatternType` |
| `VisStackedBar` | `baseline` | Floating bars, the primitive for waterfall charts (`components/stacked-bar/index.js:11`) |
| `VisStackedBar`, `VisGroupedBar` | `barStyle` | Per bar inline styles (`components/stacked-bar/index.js:10`) |
| `VisAxis` | `tickTextAdaptiveSets` | Picks the largest fitting tick set (`components/axis/index.js:37`) |
| `VisAxis` | `tickSpacing` | Default X axis tick density (`components/axis/index.js:27`) |
| `VisAxis` | `labelTextSeparator` | Trim separator for the axis label (`components/axis/index.js:16`) |
| `VisCrosshair` | `snapMode`, `showHorizontalLine` | XY snapping and horizontal line ([docs](https://unovis.dev/docs/components/Crosshair)) |
| `VisDonut` | `minSegmentAngle` | Minimum sweep for non zero segments (`components/donut/index.js:12`) |
| `VisGraph` | `nodeLabelFitMode`, `nodeLabelWidth`, `nodeLabelSeparator`, `nodeLabelForceWordBreak`, and sub label counterparts | Label wrapping via `FitMode.Wrap` (`components/graph/index.js:65-73`) |
| `VisSankey` | `nodeAdaptivePadding` | Compresses padding instead of node height |
| `VisPlotline`, `VisPlotband` | `labelText` | Styled `UnovisText` blocks and `\n` breaks; labels shift into the chart instead of clipping (`components/plotline/index.js:14`) |
| `VisLeafletMap` | `preserveDrawingBuffer` | Enables `toDataURL()` export of the map canvas (`html-components/leaflet-map/index.js:21`) |

## Behavior changes

- Containers reconcile SVG children on `updateContainer` instead of tearing down. CSS transitions and per element state survive config updates ([release notes](https://unovis.dev/releases/1.7)).
- Entering bars grow from the baseline. Interrupted exit transitions no longer leave ghost bars.
- Text renders with canvas measured metrics and trims at precise positions. Expect slightly different label trimming than 1.6.
- The pattern defs SVG injects at zero size. Pages importing Unovis no longer register a layout shift ([release notes](https://unovis.dev/releases/1.7)).
- The published code is no longer minified. Stack traces now map to readable module paths.
- `config.events` callbacks resolve at dispatch time, so handlers see current state after `setConfig`.

## Not applicable to Vue

These 1.7 framework changes affect other packages, not `@unovis/vue`:

- `@unovis/angular` supports Angular 20 to 22 and requires RxJS 7.5+.
- `@unovis/svelte` moved to Svelte 4.

## Related new packages

- `@unovis/ssr`: headless `renderToSvg` and `svgToPng` in Node 20+. Use it for CI, email, and PDF charts. Vue wrappers are not part of it; it drives `@unovis/ts` classes directly (<https://unovis.dev/releases/1.7>).
- `@unovis/mcp`: MCP server that turns data into Unovis charts and component source, including Vue (<https://unovis.dev/docs/mcp>).

## Changes from 1.6.5 to 1.6.7 worth knowing

These landed between the previous skill baseline (1.6.5) and 1.7.0:

- `VisAxis`: function form for `tickTextAlign`, configurable `tickSize` ([1.6.6 changes](https://github.com/f5/unovis/releases/tag/1.6.6)).
- `VisCrosshair`: configurable `circleRadius`; `forceShowAt` changes now redraw.
- `VisBrush`: `brushHeightExtend`.
- `VisXYContainer`: chart creation waits for child slots to register, so `v-for` children work ([PR 802](https://github.com/f5/unovis/pull/802)).
- `VisScatter`: points with missing values are skipped; hover performance improved.
- `VisArea`: gradient clipping fixed for non zero y domains ([1.6.7 changes](https://github.com/f5/unovis/releases/tag/1.6.7)).
