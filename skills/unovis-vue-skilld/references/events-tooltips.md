# Events, tooltips, crosshair

## Events

Pass an `events` object to any `Vis*` chart component. Keys are CSS selectors, values are event handler maps. Every component exports a selectors object that provides the selector strings (`components/area/index.js:5`).

```vue
<script setup lang="ts">
import { VisStackedBarSelectors } from '@unovis/vue'

const events = {
  [VisStackedBarSelectors.bar]: {
    click: (d: DataRecord) => console.log('clicked', d),
  },
}
</script>

<template>
  <VisXYContainer :data="data">
    <VisStackedBar :x="x" :y="y" :events="events" />
  </VisXYContainer>
</template>
```

The same pattern works for axis ticks:

```vue
<script setup lang="ts">
import { VisAxisSelectors } from '@unovis/vue'
const axisEvents = {
  [VisAxisSelectors.tick]: {
    click: (val: number) => console.log('clicked tick', val),
  },
}
</script>

<template>
  <VisAxis type="x" :events="axisEvents" />
</template>
```

Notes:

- Selectors objects exist for every component, for example `VisHeatmapSelectors.cell`, `VisBoxplotSelectors.box`, `VisRadialBarSelectors.bar` ([Heatmap docs](https://unovis.dev/docs/components/Heatmap), [Boxplot docs](https://unovis.dev/docs/components/Boxplot)).
- Since 1.7, handlers are resolved when the event fires, so they never run with stale state after a config update ([release notes](https://unovis.dev/releases/1.7)).

## Tooltip

`VisTooltip` works inside both containers or standalone. The `triggers` prop maps selectors to content callbacks. Return a string, an `HTMLElement`, or `null` to hide the tooltip ([Tooltip docs](https://unovis.dev/docs/components/Tooltip)).

```vue
<script setup lang="ts">
import { VisStackedBarSelectors } from '@unovis/vue'
const triggers = {
  [VisStackedBarSelectors.bar]: (d: DataRecord, i: number) =>
    `<b>${d.category}</b>: ${d.value}`,
}
</script>

<template>
  <VisXYContainer :data="data">
    <VisStackedBar :x="x" :y="y" />
    <VisTooltip :triggers="triggers" />
  </VisXYContainer>
</template>
```

Trigger callbacks receive `(datum, i, els)`. Returning `undefined` or nothing shows an empty tooltip; returning `null` hides it.

Useful props: `followCursor`, `allowHover`, `horizontalPlacement`, `verticalPlacement`, `hideDelay`, `showDelay` (`components/tooltip/index.js:7-22`).

## Crosshair

`VisCrosshair` lives in `VisXYContainer`. The `template` prop takes the same selector map as tooltip `triggers` and shows the content in a crosshair label ([Crosshair docs](https://unovis.dev/docs/components/Crosshair)).

```vue
<script setup lang="ts">
import { VisLineSelectors } from '@unovis/vue'
const template = {
  [VisLineSelectors.line]: (d: DataRecord) => `${d.x}: ${d.y}`,
}
</script>

<template>
  <VisXYContainer :data="data">
    <VisLine :x="x" :y="y" />
    <VisCrosshair :template="template" />
    <VisAxis type="x" />
  </VisXYContainer>
</template>
```

Config props travel as attributes because `VisCrosshair` declares only `data` as a Vue prop (`components/crosshair/index.js:7-9`):

- `snapMode`: `CrosshairSnapMode.X` by default, `CrosshairSnapMode.XY` snaps to the datum closest to the pointer in both axes. Import the enum from `@unovis/ts`.
- `showHorizontalLine`: renders a horizontal line through the snapped point. Both are new in 1.7 ([release notes](https://unovis.dev/releases/1.7)).
- `forceShowAt`: pins the crosshair, for example `:force-show-at="{ x: 1707093300 }"`. Use it for synced charts. A change to `forceShowAt` triggers a redraw since 1.6.6 ([1.6.6 changes](https://github.com/f5/unovis/releases/tag/1.6.6)).
- `color`, `circleRadius`, `skipRangeCheck`: further styling and behavior options ([Crosshair docs](https://unovis.dev/docs/components/Crosshair)).

The tooltip aligns automatically with the crosshair when both are present ([release notes](https://unovis.dev/releases/1.5)).

## Annotations

`VisAnnotations` draws callouts over a chart. Place it inside either container and pass `items` ([Annotations docs](https://unovis.dev/docs/components/Annotations)).

```vue
<script setup lang="ts">
const annotations = [
  { x: 5, y: 10, text: 'Threshold reached' },
]
</script>

<template>
  <VisXYContainer :data="data">
    <VisLine :x="x" :y="y" />
    <VisAnnotations :items="annotations" />
  </VisXYContainer>
</template>
```

Position values accept `calc()` expressions since 1.6.1 ([1.6.1 changes](https://github.com/f5/unovis/releases/tag/1.6.1)).

## Reference lines and bands

Prefer `VisPlotline` and `VisPlotband` over annotations for simple reference marks. Both report `bleed` since 1.7, so labels at the domain edge shift into the chart instead of clipping. `labelText` accepts styled `UnovisText` blocks and `\n` line breaks ([release notes](https://unovis.dev/releases/1.7)).

```vue
<template>
  <VisXYContainer :data="data">
    <VisLine :x="x" :y="y" />
    <VisPlotline axis="y" :value="10" color="#ff6b7e" label-text="SLA" />
    <VisPlotband axis="x" :from="2" :to="4" color="#4d8cfd" label-text="maintenance window" />
    <VisAxis type="x" />
  </VisXYContainer>
</template>
```
