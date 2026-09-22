---
name: vue-data-ui-skilld
description: "A user-empowering data visualization Vue 3 components library (69 components) for eloquent data storytelling. ALWAYS use when writing code importing \"vue-data-ui\". Consult for component choice, config, theming, slots, tooltips, exports, SSR, debugging, or modifying vue-data-ui, vue data ui."
---

# graphieros/vue-data-ui `vue-data-ui@3.25.9`

- Docs: https://vue-data-ui.graphieros.com/ (per-component pages: `https://vue-data-ui.graphieros.com/docs#vue-ui-<name>`)
- Repo: https://github.com/graphieros/vue-data-ui
- Requires `vue >= 3.3.0`; `jspdf >= 3.0.1` is an optional peer dep, install it only for the PDF export feature (package.json:112-119).
- Types ship with the package; main entry types resolve to `dist/types/vue-data-ui.d.ts` (package.json:66-90).

## References

- [API surface](./references/api-surface.md): entry points, import styles, utils, composables, SSR.
- [Components](./references/components.md): catalog, common props/emits/exposed methods/slots.
- [Customization](./references/customization.md): config patterns, themes, user options, slots, a11y, responsive, big data.
- [Migration v3.19.2 to v3.25.9](./references/migration-v3.19-v3.25.md): API deltas incl. the v3.25.0 breaking change.

## Setup

```bash
npm i vue-data-ui
```

```vue
<script setup>
import { ref } from "vue";
import { VueUiDonut } from "vue-data-ui";
import "vue-data-ui/style.css"; // required css

const dataset = ref([
  { name: "A", value: 12 },
  { name: "B", value: 88 },
]);
const config = ref({ theme: "zen" });
</script>

<template>
  <VueUiDonut :dataset="dataset" :config="config" />
</template>
```

Every component takes a `dataset` prop and a `config` object prop. Pass a partial `config`; the component merges it over defaults. Prefer `computed` configs so mutations stay reactive.

## Common tasks

Build a typed config from defaults and override safely:

```ts
import { getVueDataUiConfig, mergeConfigs, type VueUiXyConfig } from "vue-data-ui";

const config = computed<VueUiXyConfig>(() => mergeConfigs({
  defaultConfig: getVueDataUiConfig("vue_ui_xy"), // snake_case component key
  userConfig: { chart: { title: { text: "Sales" } } },
}));
```

Call exposed methods through a template ref (available per component, see components reference):

```ts
const chart = useTemplateRef("chart");
const data = await chart.value.getData();
const img = await chart.value.getImage({ scale: 2 }); // { imgUri, base64, title, width, height, aspectRatio }
chart.value.showSeries("Series 1"); // or hideSeries("Series 1")
```

Customize tooltips with `tooltip.customFormat: ({ seriesIndex, datapoint, series, config }) => string`, or richer content via `#tooltip-before` / `#tooltip-after` slots. Customize data labels with `formatter: ({ value, config }) => string`.

Drag tooltips out of the pointer's way with the `useTooltipPosition` composable (since v3.22.0):

```ts
import { useTooltipPosition } from "vue-data-ui/composables";
const chartRef = useTemplateRef("chartRef");
const tooltipPosition = useTooltipPosition(chartRef); // ComputedRef<"left" | "right" | "center">
const config = computed(() => ({ chart: { tooltip: { position: tooltipPosition.value } } }));
```

Render static SVG server-side (no browser needed):

```ts
import { createStaticVueUiXy } from "vue-data-ui/ssr"; // or 'vue-data-ui/ssr/vue-ui-xy' (treeshaken)
const svg = await createStaticVueUiXy({ dataset, config });
```

## Best practices

- Use `VueUiXyCanvas` instead of `VueUiXy` for very large datasets; tune `config.downsample.threshold` (LTTB downsampling). Defaults: Xy 1095, XyCanvas 10000, Quadrant/Scatter/Sparkline/SparkTrend 1095 (README.md:979-1002).
- With `config.responsive: true`, place charts in a container with fixed dimensions; a 100% height container makes the chart grow infinitely (README.md:968-977).
- Opt in to pointer cursors with `config.useCursorPointer: true`; disabled by default for a11y (README.md:1521-1529).
- Enable the a11y alt-text button with `userOptions.buttons.altCopy: true` plus a `userOptions.callbacks.altCopy` callback (README.md:1488-1519).
- Reverse an axis with the dedicated `reverse` config flags (since v3.20.7), do not hack negative values. X axis: `chart.grid.labels.xAxis.reverse`; y axis: `chart.grid.labels.yAxis.reverse` (VueUiXy).
- Gate `config.debug` and `config.devHints.enable` behind a dev environment variable; some critical warnings still print (v3.23.0, v3.23.2 release notes).
- Use `legend.selectAllToggle.show: true` to offer a select-all checkbox (more than 2 series); `@selectLegend` also fires when it is toggled (since v3.19.9).
- Import from `vue-data-ui/utils` for utilities the main entry does not re-export, e.g. `adaptColorToBackground` (dist/utils.js export list).
- Do not pass `bar` type series mixed with continuous `{ x, y }` series in `VueUiXy`; bars are hidden and a warning is logged (v3.20.7 release notes).
- `#tooltip` slots replace default content; `#tooltip-before`/`#tooltip-after` prepend/append instead.

## Version limits and breaking changes

- v3.25.0 (breaking): `showOnlyAtModulo` now applies a real modulo and the `modulo` default changed from 12 to 2; use the new `showFirstAndLast: true` to force edge labels. Affects VueUiXy (+SSR), VueUiStackbar, VueUiStackline, VueUiCandlestick. See [migration](./references/migration-v3.19-v3.25.md).
- v3 is not breaking vs v2, but some padding configs changed (README.md:185-200).
- Since v3.14.3 locale files are removed; time labels rely on `Intl` (v3.14.3 release notes).
