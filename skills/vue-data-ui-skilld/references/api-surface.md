# API surface

Package version: 3.25.9 (package.json:4). Module type: ESM (`"type": "module"`).

## Entry points (package.json:66-90)

| Import | Purpose |
| --- | --- |
| `vue-data-ui` | All components + most utils/composables. Main entry for typical use. |
| `vue-data-ui/<component>` | Treeshaken single component, e.g. `vue-data-ui/vue-ui-xy` maps to `dist/components/vue-ui-xy.js`. |
| `vue-data-ui/utils` | All utility functions. Includes `adaptColorToBackground` and `getThemeConfig`, which the main entry does not re-export. |
| `vue-data-ui/composables` | `useTooltipPosition` (and `useObjectBindings`, also on the main entry). |
| `vue-data-ui/ssr` / `vue-data-ui/ssr/vue-ui-xy` / `vue-data-ui/ssr/vue-ui-donut` | Static SVG renderers: `createStaticVueUiXy`, `createStaticVueUiDonut`. |
| `vue-data-ui/style.css` | Required stylesheet (README.md:131-132). |

Per-component subpath types (e.g. `dist/types/vue-ui-xy.d.ts`) re-export the component's public types from the main `vue-data-ui` module; import config/dataset types from there (dist/types/vue-ui-xy.d.ts:3-43).

## Named exports from the main entry

Full list in dist/vue-data-ui.js:79. Components: `VueDataUi` (universal wrapper), `Arrow`, `VueUi3dBar`, `VueUiAccordion`, `VueUiAgePyramid`, `VueUiAnnotator`, `VueUiBullet`, `VueUiBump`, `VueUiCandlestick`, `VueUiCarouselTable`, `VueUiChestnut`, `VueUiChord`, `VueUiCirclePack`, `VueUiCursor`, `VueUiDag`, `VueUiDashboard`, `VueUiDigits`, `VueUiDonut`, `VueUiDonutEvolution`, `VueUiDumbbell`, `VueUiFlow`, `VueUiFunnel`, `VueUiGalaxy`, `VueUiGauge`, `VueUiGeo`, `VueUiGizmo`, `VueUiHeatmap`, `VueUiHill`, `VueUiHistoryPlot`, `VueUiHorizontalBar` (alias `VueUiVerticalBar`), `VueUiIcon`, `VueUiKpi`, `VueUiLabel`, `VueUiMiniLoader`, `VueUiMolecule`, `VueUiMoodRadar`, `VueUiNestedDonuts`, `VueUiOnion`, `VueUiParallelCoordinatePlot`, `VueUiPattern`, `VueUiPatternSeed`, `VueUiQuadrant`, `VueUiQuickChart`, `VueUiRadar`, `VueUiRating`, `VueUiRelationCircle`, `VueUiRidgeline`, `VueUiRings`, `VueUiScatter`, `VueUiSkeleton`, `VueUiSmiley`, `VueUiSparkHistogram`, `VueUiSparkStackbar`, `VueUiSparkTrend`, `VueUiSparkbar`, `VueUiSparkgauge`, `VueUiSparkline`, `VueUiStackbar`, `VueUiStackline`, `VueUiStripPlot`, `VueUiTable`, `VueUiTableHeatmap`, `VueUiTableSparkline`, `VueUiThermometer`, `VueUiTimer`, `VueUiTiremarks`, `VueUiTreemap`, `VueUiWaffle`, `VueUiWheel`, `VueUiWordCloud`, `VueUiWorld`, `VueUiXy`, `VueUiXyCanvas`.

Functions/composables: `abbreviate`, `applyDataCorrection`, `average`, `createColorWheel`, `createPatternDef`, `createSmoothPath`, `createStraightPath`, `createTSpans`, `createWordCloudDatasetFromPlainText`, `darkenColor`, `formatSmallValue`, `getCumulativeAverage`, `getCumulativeMedian`, `getPalette`, `getThemeConfig`, `getVueDataUiConfig`, `lightenColor`, `median`, `mergeConfigs`, `shiftColorHue`, `useObjectBindings`, `useTooltipPosition`.

## Config helpers

```ts
getVueDataUiConfig<T>(key: VueDataUiConfigKey, options?: {
  colorBackground?: string; colorTextPrimary?: string; colorTextSecondary?: string;
  colorGrid?: string; colorBorder?: string;
}): T
```

`key` is the component name in snake_case, e.g. `"vue_ui_xy"` (dist/types/utils.d.ts:226-242). The options object builds a quick custom theme.

`mergeConfigs({ defaultConfig, userConfig })` deep-merges a partial user config over defaults and returns a fully typed config (dist/types/utils.d.ts:121-142). Always spread through this when deriving from `getVueDataUiConfig`.

## Utility functions

Signatures and docblocks live in `dist/types/utils.d.ts`:

- Color: `lightenColor(color, strength)`, `darkenColor(color, strength)`, `shiftColorHue(color, strength)` (HEX/RGB/RGBA/named inputs, hex out), `createColorWheel(startColor, count)` (since v3.22.8). `adaptColorToBackground(bg, { dark, light })` is utils-entry only.
- Stats: `average(arr)`, `median(arr)` (finite numbers only, `null` when empty; since v3.22.10), `getCumulativeAverage({ values, config })`, `getCumulativeMedian({ values, config })` with `CumulativeConfig { keepInvalid?, convertInvalidToZero? }`.
- SVG: `createStraightPath(points)`, `createSmoothPath(points)`, `createTSpans({ content, fontSize, fill, maxWords, x, y })` (output goes in `v-html` of an SVG `<text>`), `createPatternDef({ id, seed, foregroundColor?, backgroundColor?, minSize?, maxSize?, disambiguator? })` for seeded patterns in tooltips.
- Data: `applyDataCorrection(data, { averageWindow, smoothingTau })` two-stage smoothing for `{ value }` series, `abbreviate({ source, length })`, `createWordCloudDatasetFromPlainText(text, cb?)`, `formatSmallValue({ value, maxDecimals?, fallbackFormatter?, removeTrailingZero? })`.

## Composables

- `useTooltipPosition(chartRef)` returns `ComputedRef<"left" | "right" | "center">`; accepts a ref, shallow/computed/template ref, getter, raw Element, component instance, or `$el` object (dist/types/composables.d.ts:29-60). Feed it to `tooltip.position`. Since v3.22.0; safe to use in reactive configs since v3.25.9 (no re-render on tooltip config change).
- `useObjectBindings(configRef, { delimiter?, skipArrays? })` flattens a config object into one `Ref` per leaf path, e.g. `bindings["style.chart.backgroundColor"]` (dist/types/utils.d.ts:434-478).

## SSR static rendering

`createStaticVueUiXy(state)` and `createStaticVueUiDonut(state)` return `Promise<string>` SVG markup. State: `{ dataset, config?, width?, height?, svgTitle?, additionalSvgContent? }`. `additionalSvgContent` is a string or a callback receiving computed geometry (`series` with resolved plot coordinates, `drawingArea`, `scale`, radii for donut) and returning extra SVG (dist/types/ssr.d.ts:17-180). Introduced v3.21.0 (Xy) and v3.21.1 (Donut).

## Peer dependencies

`vue >= 3.3.0` (required), `jspdf >= 3.0.1` (optional; needed only for the PDF user option and `generatePdf` methods) (package.json:112-119, README.md:1292-1294).
