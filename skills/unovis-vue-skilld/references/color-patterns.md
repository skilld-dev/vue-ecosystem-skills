# Colors, patterns, theming

## Default category colors

Without configuration, components draw series colors from an ordinal color scale backed by the `--vis-color*` CSS variables. The scale is exported as `UnovisColorScale` from `@unovis/ts` so it can be re-ranged globally ([release notes](https://unovis.dev/releases/1.7)).

## Color synchronization

New in 1.7. It keeps one category on one color across every chart, legend, and tooltip on a page, regardless of series order.

Two props work together:

- `colorFunction` on `VisXYContainer`, `VisSingleContainer`, and `VisBulletLegend`: a function `(key) => color` applied chart wide (`containers/xy-container/index.js:39`, `html-components/bullet-legend/index.js:17`).
- `colorKeys` on a chart component: an array of stable keys, one per series, aligned with the `y` accessors (`components/area/index.js:25`).

```vue
<script setup lang="ts">
import { Scale } from '@unovis/ts'
const color = Scale.scaleOrdinal().range(['#4d8cfd', '#ff6b7e', '#00c19a'])
const keys = ['aws', 'azure', 'github']
</script>

<template>
  <VisBulletLegend :items="keys.map(name => ({ name, colorKey: name }))" :color-function="color" />
  <VisXYContainer :data="data" :color-function="color">
    <VisGroupedBar :x="d => d.month" :y="keys.map(k => d => d[k])" :color-keys="keys" />
  </VisXYContainer>
</template>
```

Legend bullets then render the pattern that matches the component fill ([release notes](https://unovis.dev/releases/1.7)).

`VisBulletLegend` items also accept an array of colors in `color` to draw multi color bullets ([Bullet Legend docs](https://unovis.dev/docs/components/BulletLegend)):

```vue
<script setup lang="ts">
const items = [{ name: 'Multi segment', color: ['#ff0000', '#00ff00', '#0000ff'] }]
</script>

<template>
  <VisBulletLegend :items="items" />
</template>
```

## Patterns

New in 1.7. A `pattern` accessor adds stripes, dots, hatches, and line markers as a second visual channel on top of color. Use it for color blind safe palettes, grayscale printing, and dense charts.

The prop is declared on `VisArea` (`components/area/index.js:9`), `VisLine` (`components/line/index.js:9`), `VisScatter`, `VisGroupedBar`, `VisStackedBar`, and `VisDonut` (`components/donut/index.js:16`). The core also supports it on `VisTimeline`, `VisNestedDonut` (`segmentPattern`), `VisSankey` (`nodePattern`, `linkPattern`), and `VisChordDiagram` (`nodePattern`, `linkPattern`), which receive config through attributes ([release notes](https://unovis.dev/releases/1.7)).

```vue
<script setup lang="ts">
import { FillPatternType } from '@unovis/ts'
const pattern = (d: DataRecord) => (d.projected ? FillPatternType.StripesDiagonal : null)
</script>

<template>
  <VisXYContainer :data="data">
    <VisStackedBar :x="x" :y="y" :pattern="pattern" />
  </VisXYContainer>
</template>
```

Enum values come from `@unovis/ts`. Fill patterns: `FillPatternType.StripesDiagonal`, `Dots`, `StripesVertical`, `Crosshatch`, `Waves`, `Circles`. Line patterns: `LinePatternType.Circle`, `Triangle`, `Diamond`, `Arrow`, `Square`, `Star`. Return `null` for a plain fill ([source](https://github.com/f5/unovis/blob/1.7.0/packages/ts/src/styles/patterns.ts)).

The `theme-patterns` CSS class applies the automatic pattern palette. Customize it with the `--vis-pattern-fill{i}`, `--vis-pattern-marker{i}`, and `--vis-pattern-dasharray{i}` variables ([theming guide](https://unovis.dev/docs/guides/theming)).

## CSS variables

Components read SVG attributes such as fill, stroke, and opacity from CSS variables named `--vis` plus the label plus the attribute, for example `--vis-area-cursor`. Override them in CSS scoped to the container element ([theming guide](https://unovis.dev/docs/guides/theming)):

```css
.custom-chart {
  --vis-sankey-node-color: #4d8cfd;
  --vis-sankey-link-opacity: 0.4;
}
```

Each component page lists its variables and defaults, for example [Heatmap](https://unovis.dev/docs/components/Heatmap) and [RadialBar](https://unovis.dev/docs/components/RadialBar).

Global variables include `--vis-font-family`, `--vis-color-main`, and the categorical `--vis-color*` series.

## Dark theme

Add the class `theme-dark` to the document `body` element. Every component then reads its `--vis-dark` prefixed variables. Override those variables to change dark values ([theming guide](https://unovis.dev/docs/guides/theming)):

```css
.custom-chart {
  --vis-sankey-node-color: #4d8cfd;
  --vis-dark-sankey-node-color: #7aa5ff;
}
```

## Gradients and custom defs

Define SVG gradients or patterns once per container with `svgDefs`, then reference them by URL in any `color` prop. This predates 1.7 and stays the way to paint continuous gradients ([tips and tricks](https://unovis.dev/docs/guides/tips-and-tricks)):

```vue
<script setup lang="ts">
const svgDefs = `
  <linearGradient id="area-gradient" x1="0" y1="0" x2="0" y2="1">
    <stop offset="0%" stop-color="#4d8cfd" stop-opacity="0.8" />
    <stop offset="100%" stop-color="#4d8cfd" stop-opacity="0.1" />
  </linearGradient>`
</script>

<template>
  <VisXYContainer :data="data" :svg-defs="svgDefs">
    <VisArea :x="x" :y="y" color="url(#area-gradient)" />
  </VisXYContainer>
</template>
```
