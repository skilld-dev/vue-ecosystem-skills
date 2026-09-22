# Migration: v3.19.2 to v3.25.9

Baseline: v3.19.2 (2026-05-05). Current: v3.25.9 (2026-09-21). Full history: https://github.com/graphieros/vue-data-ui/releases

## Breaking change

- **v3.25.0 breaking: `showOnlyAtModulo` now applies a real modulo.** Previously it approximated a label count; now `modulo: 2` shows one label every 2 ticks, and the `modulo` default changed from 12 to 2. New `showFirstAndLast: true` forces edge labels (they may overlap; labels get a background-colored stroke). Affects VueUiXy (incl. SSR), VueUiStackbar, VueUiStackline, VueUiCandlestick (also VueUiBump, VueUiRidgeline for the modulo fix). Review any config that sets `showOnlyAtModulo` or `modulo`.
  Source: https://github.com/graphieros/vue-data-ui/releases/tag/v3.25.0

## New components

- **VueUiHill** (v3.23.0): task progress from "to do" to "done" with effort emphasis; exposes `edit`, `save`, `cancel`, `copyAlt`, `datapointEnter/Leave`, `selectDatapoint` and more. https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.0
- **VueUiLabel** (v3.24.0): draggable labels for chart `#svg` slots; emits `dragStart`, `drag`, `dragEnd`, `mouseenter`, `mouseleave`, `click`, `focus`, `blur`; auto-reorders to avoid overlaps. https://github.com/graphieros/vue-data-ui/releases/tag/v3.24.0

## New APIs by version (3.19.3 → 3.25.9)

- v3.19.4: `tooltip.offsetX` on all charts with tooltips. https://github.com/graphieros/vue-data-ui/releases/tag/v3.19.4
- v3.19.5: `zoom.keepState` on VueUiStackline/Stackbar. https://github.com/graphieros/vue-data-ui/releases/tag/v3.19.5
- v3.19.6: `#custom-menu-before` / `#custom-menu-after` slots on all chart-menu components. https://github.com/graphieros/vue-data-ui/releases/tag/v3.19.6
- v3.19.7: y-axis right positioning (`chart.grid.labels.yAxis.position` on Xy; `style.chart.grid.y.position` on Stackbar/Stackline; `style.layout.grid.yAxis.position` on Candlestick/DonutEvolution). https://github.com/graphieros/vue-data-ui/releases/tag/v3.19.7
- v3.19.9: `@selectLegend` now also fires on the legend select-all toggle. https://github.com/graphieros/vue-data-ui/releases/tag/v3.19.9
- v3.20.7: VueUiXy continuous `{ x, y }` series (line/plot only; bars hidden with a warning when mixed); emit type definitions for all components; x-axis `commonScaleSteps`, `useNiceScale`, `scaleMin`, `scaleMax`, `rounding`, `formatter`, `reverse`; y-axis `reverse`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.20.7
- v3.20.9: VueUiXy crosshairs tooltip alternative under `chart.highlighter.crosshairs`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.20.9
- v3.21.0 / v3.21.1: SSR static SVG (`createStaticVueUiXy`, then `createStaticVueUiDonut`) via `vue-data-ui/ssr` and treeshaken `vue-data-ui/ssr/vue-ui-xy` / `vue-data-ui/ssr/vue-ui-donut`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.21.0
- v3.21.3: VueUiRadar `layout.scaleToAxisMax` and `layout.targetReference` (overflow handling + target polygon). https://github.com/graphieros/vue-data-ui/releases/tag/v3.21.3
- v3.21.4: VueUiXy `line.dot.selectedRadius`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.21.4
- v3.21.5: VueUiSparkline `#svg` slot exposes series and hovered index. https://github.com/graphieros/vue-data-ui/releases/tag/v3.21.5
- v3.22.0: `useTooltipPosition` composable. https://github.com/graphieros/vue-data-ui/releases/tag/v3.22.0
- v3.22.1: `cutNullValues` on VueUiSparkline (`style.line`) and VueUiTableSparkline (`sparkline`). https://github.com/graphieros/vue-data-ui/releases/tag/v3.22.1
- v3.22.2: VueUiWordCloud per-word `color` in dataset; `quality: 'fast' | 'balanced' | 'precise'`; `words.proximity` default now 0 (adjust if you overrode it). https://github.com/graphieros/vue-data-ui/releases/tag/v3.22.2
- v3.22.5: VueUiHistoryPlot `temperatureColors`, `temperatureAngle`, `usePlotTemperatureColors`, `temperatureIndependant`, `smooth`; VueUiStripPlot `type: 'classic' | 'scatter' | 'violin'` with violin styling block. https://github.com/graphieros/vue-data-ui/releases/tag/v3.22.5
- v3.22.6: VueUiTreemap pan zoom (`style.chart.zoom.show`). https://github.com/graphieros/vue-data-ui/releases/tag/v3.22.6
- v3.22.8: `createColorWheel` utility; VueUiWorld size/perf overhaul. https://github.com/graphieros/vue-data-ui/releases/tag/v3.22.8
- v3.22.10: `average` and `median` utilities. https://github.com/graphieros/vue-data-ui/releases/tag/v3.22.10
- v3.23.0: VueUiHill; standardized `config.transitions` (disabled under `prefers-reduced-motion`); `config.devHints` on all components. https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.0
- v3.23.1: `zoom.autoFit` (`zoomXyAutoFit` on QuickChart); overrides `zoom.maxWidth`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.1
- v3.23.2: `config.debug` warnings standardized; package size cut. https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.2
- v3.23.5: VueUiRadar `layout.grid.rotation`, `labels.dataLabels.offset`, tooltip on plot hover. https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.5
- v3.23.6: VueUiWaffle `rect.merged`, `rect.selection.unselectedOpacity`, `rect.selection.wrap`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.6
- v3.23.7: VueUiStripPlot `grid.scaleMin`/`scaleMax`; draggable annotator menu. https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.7
- v3.23.9: VueUiXy `@selectX` and `config.event.datapointXxx` expose the full visible dataset (type changes). https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.9
- v3.23.11: VueUiDag `focusOnNode(id, options)`; `VueUiDagFocusOnNodeOptions` from `vue-data-ui/vue-ui-dag`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.23.11
- v3.24.1: `style.bar.borderRadius` on VueUiSparkbar and VueUiSparkStackbar. https://github.com/graphieros/vue-data-ui/releases/tag/v3.24.1
- v3.25.4: annotator can edit/move/delete positioned elements; x-axis label dedupe restored. https://github.com/graphieros/vue-data-ui/releases/tag/v3.25.4
- v3.25.5: VueUiRidgeline `yAxis.labels.offsetY`/`centered`, `#svg` exposes formatted dataset; VueUiAnnotator grouping-of-groups, `#toggle` + icon slots; `userOptions.annotatorPalette`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.25.5
- v3.25.6: VueUiRidgeline `selector.labels.showLast`; VueUiAgePyramid `layout.bars.labels` block. https://github.com/graphieros/vue-data-ui/releases/tag/v3.25.6
- v3.25.7: VueUiHeatmap color fixes (single cell/row/column). https://github.com/graphieros/vue-data-ui/releases/tag/v3.25.7
- v3.25.8: VueUiHeatmap `cells.scaleMin`/`scaleMax`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.25.8
- v3.25.9: components no longer re-render when only tooltip config changes (fixes `useTooltipPosition` reactivity). https://github.com/graphieros/vue-data-ui/releases/tag/v3.25.9

## Older context still relevant

- v3.15.0 made `useCursorPointer` opt-in (default false) and added the `altCopy` action. https://github.com/graphieros/vue-data-ui/releases/tag/v3.15.0
- v3.14.3 removed per-locale files in favor of `Intl`. https://github.com/graphieros/vue-data-ui/releases/tag/v3.14.3
- v2 → v3: no breaking changes, only modified padding configs on some charts (README.md:185-200).
