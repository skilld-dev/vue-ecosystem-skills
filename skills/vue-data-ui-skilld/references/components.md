# Components

69 components (README.md:14). Docs anchor pattern: `https://vue-data-ui.graphieros.com/docs#vue-ui-<kebab-name>`.

## Categories

- Charts: VueUiAgePyramid, VueUiBump, VueUiCandlestick, VueUiChestnut, VueUiChord, VueUiCirclePack, VueUiDag, VueUiDonut, VueUiDonutEvolution, VueUiDumbbell, VueUiFlow, VueUiFunnel, VueUiGalaxy, VueUiGauge, VueUiHeatmap, VueUiHistoryPlot, VueUiHorizontalBar, VueUiMolecule, VueUiMoodRadar, VueUiNestedDonuts, VueUiOnion, VueUiParallelCoordinatePlot, VueUiQuadrant, VueUiQuickChart, VueUiRadar, VueUiRelationCircle, VueUiRidgeline, VueUiRings, VueUiScatter, VueUiStackbar, VueUiStackline, VueUiStripPlot, VueUiThermometer, VueUiTiremarks, VueUiTreemap, VueUiWaffle, VueUiWheel, VueUiWordCloud, VueUiXy, VueUiXyCanvas
- Mini charts: VueUiSparkline, VueUiSparkbar, VueUiSparkStackbar, VueUiSparkHistogram, VueUiSparkgauge, VueUiSparkTrend, VueUiGizmo, VueUiBullet
- 3D: VueUi3dBar
- Tables: VueUiTable, VueUiTableHeatmap, VueUiTableSparkline, VueUiCarouselTable
- Rating: VueUiRating, VueUiSmiley
- Maps: VueUiGeo, VueUiWorld
- Productivity: VueUiHill (new v3.23.0)
- Utilities: VueUiAccordion, VueUiAnnotator, VueUiCursor, VueUiDashboard, VueUiDigits, VueUiIcon, VueUiKpi, VueUiLabel (new v3.24.0), VueUiMiniLoader, VueUiSkeleton, VueUiTimer

## Universal component

`VueDataUi` wraps any chart by name and forwards props/slots (README.md:149-180):

```html
<VueDataUi component="VueUiXy" :config="config" :dataset="dataset" />
```

`Arrow`, `VueUiIcon`, and `VueUiPattern` are not supported by the universal component; import them individually.

## Dataset and config types

Every component publishes `<Name>Config` and dataset types on the main module, e.g. `VueUiXyDatasetItem[]` / `VueUiXyConfig`. Full per-component dataset/config/slots/emits table in README.md:526-673. VueUiXy dataset items: `{ name, type: 'line' | 'bar' | 'plot', series: number[] | Array<{ x, y }>, color?, dashIndices? }` (continuous `{ x, y }` series since v3.20.7, line/plot only).

## Common exposed methods (via template ref)

Most charts expose some of (README.md:1333-1414, per-component table README.md:540-673):

- `getData()` (async): formatted internal data.
- `getImage({ scale? })` (async): `{ imgUri, base64, title, width, height, aspectRatio }`.
- `generatePdf`, `generateImage`, `generateCsv`, `generateSvg` (Dag).
- `toggleTable`, `toggleLabels`, `toggleTooltip`, `toggleSort`, `toggleStack`, `toggleFullscreen`, `toggleAnnotator`.
- `showSeries(name)` / `hideSeries(name)` on the 20 components listed in README.md:1393-1414.
- `zoomIn`, `zoomOut`, `resetZoom` (VueUiXy since v3.18.5, VueUiGeo, VueUiDag).
- `focusOnNode(id, { smooth?, duration?, zoomReset?, zoom? })` (async, returns success boolean) on VueUiDag since v3.23.11; type `VueUiDagFocusOnNodeOptions` from `vue-data-ui/vue-ui-dag`.
- VueUiCarouselTable: `toggleAnimation`, `pauseAnimation`, `resumeAnimation`.

## Common emits

`@selectDatapoint`, `@selectLegend` (also fires on the select-all toggle since v3.19.9), `@selectX` / `@selectTimeLabel` on time-based charts, `@rate` (Rating/Smiley). VueUiXy `@selectX` payload: `{ datapoint: VueUiXyDatasetItem[], index, indexLabel }`; it and `config.event.datapointClick|Enter|Leave` expose the full visible dataset (v3.23.9).

## Common slots

- `#svg="{ svg }"`: inject extra SVG into most charts; VueUiSparkline also exposes series + hovered index (v3.21.5), VueUiRidgeline the formatted dataset (v3.25.5).
- `#legend`, `#tooltip`, `#tooltip-before`, `#tooltip-after` (exclusions per component in README.md:253-398).
- `#watermark="{ isPrinting }"`: content shown on print/export only.
- `#reset-action="{ reset }"` on VueUiQuickChart (line/bar), VueUiXy, VueUiDonutEvolution, VueUiCandlestick, VueUiWordCloud; requires `zoom.useResetSlot: true`.
- `#chart-background`: background layer, pointer-events none; unsupported list in README.md:1019-1034.
- `#pattern="{ seriesIndex, patternId }"`: custom SVG patterns, or the `VueUiPattern` component with 12 ready-made names (README.md:1036-1113).
- `#menuIcon`, `#optionPdf` and friends, `#optionFullscreen="{ isFullscreen, toggleFullscreen }"` (README.md:729-743).
- `#custom-menu-before` / `#custom-menu-after`: extra actions inside the chart menu (since v3.19.6).
- `#hint="{ hint, isVisible }"`: keyboard navigation hint (a11y).
- Annotator submenu slots `#annotator-action-*` (since v3.5.1).

## Chart selection notes

- Time series with zoom: VueUiXy (SVG), VueUiXyCanvas (canvas, large datasets), VueUiCandlestick, VueUiDonutEvolution, VueUiStackbar, VueUiStackline.
- Distribution: VueUiStripPlot supports `type: 'classic' | 'scatter' | 'violin'` (since v3.22.5).
- Hierarchy: VueUiChestnut, VueUiTreemap (pan zoom since v3.22.6), VueUiCirclePack (recursive children since v3.19.1), VueUiDag.
- Quick autorouting from raw data: VueUiQuickChart produces line, bar or donut.
- Text: VueUiWordCloud accepts a prebuilt dataset or a plain string; `createWordCloudDatasetFromPlainText` converts.
