# Customization

## Config patterns

- Charts merge a partial `config` prop over internal defaults. Start from `getVueDataUiConfig('vue_ui_xy')` and override through `mergeConfigs` so nested branches survive.
- `config.theme` (since v2.2.9): `''`/`'default'`, `'dark'`, `'zen'`, `'hack'`, `'concrete'`, `'celebration'`, `'celebrationNight'`, `'minimal'`, `'minimalDark'` (README.md:465-490). Datapoint colors in the dataset override theme colors.
- `config.customPalette: string[]` on 30+ components; missing colors fall back to the internal palette (README.md:862-904). HEX, RGB, HSL, named colors accepted.
- `config.responsive: true` on supported charts (table in README.md:906-977); container must have fixed dimensions, avoid 100% height.
- `config.loading` toggles the skeleton loader (also auto-triggered by an undefined dataset); `config.debug` enables dev warnings (README.md:190-194).
- `config.devHints: { enable: true }` on all components since v3.23.0: console hints about dataset quality/fit.
- `config.transitions` (since v3.23.0, 17 listed charts): `{ enable, pauseOnLoad, pauseOnDatasetChange, activationDelayMs }`; transitions are force-disabled under `prefers-reduced-motion: reduce`.
- `config.downsample: { threshold }` for LTTB on VueUiXy (1095), VueUiXyCanvas (10000), VueUiQuadrant, VueUiScatter, VueUiSparkline, VueUiSparkTrend (README.md:979-1002).

## User options menu

Burger menu, top right, visible by default. Hide with `userOptions.show: false`; reveal on hover with `showOnChartHover: true` and `keepStateOnChartLeave` (README.md:685-727). Per-action buttons (`buttons.pdf`, `buttons.altCopy`, ...) and behavior-overriding callbacks (`callbacks.pdf`, `callbacks.img`, `callbacks.csv`, `callbacks.altCopy`, ...) (README.md:745-767). Per-chart action/slot names table in README.md:769-826. Since v3.25.5, `userOptions.annotatorPalette: string[]` customizes the annotator color picker.

## Tooltips

- `tooltip.position: 'left' | 'right' | 'center'`; pair with `useTooltipPosition` for dynamic flipping (v3.22.0).
- `tooltip.offsetX` when position is left/right (since v3.19.4).
- `tooltip.customFormat({ seriesIndex, datapoint, series, config })` returns an HTML string (README.md:206-216).
- `#tooltip` replaces contents; `#tooltip-before`/`#tooltip-after` add around them.

## Legend

- `legend.selectAllToggle` (opt-in) shows a select-all checkbox when series > 2 (README.md:283-322).
- Use exposed `showSeries`/`hideSeries` for programmatic control instead of mutating the dataset.

## Axes and labels

- y axis on the right: `chart.grid.labels.yAxis.position: 'left' | 'right'` (VueUiXy), `style.chart.grid.y.position` (Stackbar/Stackline), `style.layout.grid.yAxis.position` (Candlestick/DonutEvolution), all since v3.19.7.
- Reversed scales: `chart.grid.labels.xAxis.reverse` / `chart.grid.labels.yAxis.reverse` (VueUiXy, since v3.20.7).
- Continuous x: `xAxis.commonScaleSteps`, `useNiceScale`, `scaleMin`, `scaleMax`, `rounding`, `formatter` (since v3.20.7).
- Label thinning: `showOnlyAtModulo` + `modulo` (now a true modulo, default 2) and `showFirstAndLast` (see migration reference).
- Multiline labels with `\n` in specific slots per component (table in README.md:1270-1290).

## Annotations

- Built-in annotator in the chart menu; arrows, lines, text, shapes; editable/repositionable since v3.25.4; draggable menu since v3.23.7.
- Standalone `VueUiAnnotator` wraps any content; rich icon slots and a `#toggle` slot since v3.25.5.

## Patterns and gradients

- `#pattern` slot with `VueUiPattern` (props: `id`, `name`, `fill`, `stroke`, `strokeWidth`, `scale`; 12 pattern names) or raw `<pattern>` elements (README.md:1036-1113).
- `createPatternDef` utility for tooltip markers; `VueUiPatternSeed` component for seeded patterns.

## Accessibility

- Keyboard navigation with arrows inside the focused chart area; translate hints via `a11y.translations.{keyboardNavigation, tableAvailable, tableCaption}` (README.md:1416-1445).
- `#hint` scoped slot renders the navigation hint.
- Alt-text workflow: `userOptions.buttons.altCopy: true` + `callbacks.altCopy({ dataset, config })` + optional `buttonTitles.altCopy` (README.md:1488-1519).
- `useCursorPointer` opt-in (default false) (README.md:1521-1529).

## Performance

- Prefer `VueUiXyCanvas` for 5k+ datapoints or frequent (e.g. 100 ms) updates; SVG DOM nodes dominate cost otherwise (README.md:979-982; maintainer guidance in discussion #125).
- `zoom.autoFit: true` (since v3.23.1) stretches the zoom range input to the chart width; it overrides `zoom.maxWidth` and usually needs chart `padding`. Components: Xy, XyCanvas, QuickChart (`zoomXyAutoFit`), Stackbar, Stackline, DonutEvolution, Candlestick, Ridgeline, Table.
- `zoom.keepState: true` preserves zoom across config mutations (VueUiXy since v3.18.5; Stackline/Stackbar since v3.19.5).

## Export

- PNG/SVG from the menu or `getImage`/`generateImage`; CSV via `generateCsv`; PDF requires the optional `jspdf` peer dependency.
- PDF orientation/scaling configurable through `userOptions.print` (v3.15.0 release notes).
