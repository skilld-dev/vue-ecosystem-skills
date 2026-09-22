---
name: unovis-ts-skilld
description: Use when building charts, network graphs, timelines, or maps with @unovis/ts in vanilla TypeScript or JavaScript. Provides correct container and component setup, accessor and config patterns, update and destroy lifecycle, tooltip, crosshair, and styling rules for Unovis 1.7.x.
---

# @unovis/ts

Unovis core package for vanilla TypeScript/JavaScript. Version 1.7.0, Apache-2.0,
ES modules only (`"type": "module"`). Renders SVG (plus Leaflet/MapLibre for maps)
into a DOM element. Source paths cited below are relative to the package root
(`node_modules/@unovis/ts/`).

Install (per README.md and https://unovis.dev/docs/intro):

```bash
npm install -P @unovis/ts
```

## TypeScript setup

- Enable `allowSyntheticDefaultImports` in `compilerOptions` (required by Unovis
  dependencies). Source: https://unovis.dev/docs/intro
- If `tsconfig.json` lists `types` explicitly, add `"topojson-client"` to it.
  Source: https://unovis.dev/docs/intro
- Styles are injected at runtime via `@emotion/css` (declared in
  `package.json` `sideEffects`: `styles/index.js`). Importing any component
  injects the global CSS variables. Do not import a CSS file; there is none.
  For strict CSP sites read https://unovis.dev/docs/guides/csp

## Architecture

Three building blocks (README.md, `index.js`):

- **Containers** own the DOM element, the data, size, and rendering.
  - `XYContainer(element, config, data)` — multiple XY components plus `xAxis`,
    `yAxis`, `tooltip`, `crosshair`, `annotations` slots
    (`containers/xy-container/config.d.ts`).
  - `SingleContainer(element, config, data)` — exactly one component
    (`component` slot), e.g. Graph, Sankey, TopoJSONMap, Donut, Treemap
    (`containers/single-container/config.d.ts`).
- **Components** are constructed with their config: `new Line({ x, y })`. They
  hold no data; the container feeds them the data array.
- **Standalone components** need no container: `LeafletMap`,
  `LeafletFlowMap`, and the legends (`BulletLegend`, `RollingPinLegend`,
  `FlowLegend`). Source: https://unovis.dev/docs/intro

Data records are generic (`Line<Datum>`), read through **accessors**:
a value or a function `(d, i) => value`. Types in `types/accessor.d.ts`:
`NumericAccessor`, `StringAccessor`, `ColorAccessor`, `BooleanAccessor`,
`GenericAccessor`.

```ts
import { Axis, Line, XYContainer } from '@unovis/ts'

type DataRecord = { x: number; y: number }
const data: DataRecord[] = [
  { x: 0, y: 0 },
  { x: 1, y: 2 },
  { x: 2, y: 1 },
]

const line = new Line<DataRecord>({
  x: d => d.x,
  y: d => d.y,
})

const chart = new XYContainer(document.getElementById('vis-container')!, {
  components: [line],
  xAxis: new Axis(),
  yAxis: new Axis(),
}, data)
```

Individual imports are tree-shakable and equivalent
(`@unovis/ts/containers/xy-container`, `@unovis/ts/components/line`, ...).
Source: https://unovis.dev/docs/quick-start. Heavy parts (Graph layouts,
LeafletMap renderer) load via dynamic import after initialization.

## Update lifecycle

Data lives on the container; configs live on components. Update through the
container's public API (`containers/xy-container/index.d.ts`):

| Method | Purpose |
| --- | --- |
| `setData(data, preventRender?)` | Replace the data array |
| `updateContainer(config, preventRender?)` | Merge container config |
| `updateComponents(configs[], preventRender?)` | Merge configs, index-aligned with `components` |
| `update(containerConfig, componentConfigs?, data?)` | All at once |

`SingleContainer` has `updateComponent` (singular) instead of
`updateComponents` (`containers/single-container/index.d.ts`). Pass
`preventRender: true` to defer rendering when batching updates.

Always call `chart.destroy()` when tearing down (SPA route change, test
teardown). It removes the ResizeObserver, DOM node, and timers
(`core/container/index.d.ts`).

## Sizing

Container config `width`/`height` accept pixels or CSS units but **not `%`**
(`core/container/config.d.ts`). For percentage sizing, set `width`/`height`
via CSS on the container's DOM element instead. `sizing` controls fit
behavior: `Sizing.Fit` (default), `Sizing.Extend`, `Sizing.FitWidth`
(`types/component.d.ts`).

## Common recipes

Tooltip and crosshair go in the container config, not the components array:

```ts
import { Axis, Crosshair, Line, Tooltip, XYContainer } from '@unovis/ts'

const tooltip = new Tooltip()
const crosshair = new Crosshair<DataRecord>({
  color: d => d.color ?? null,
  template: d => `<div>${d.x}: ${d.y}</div>`,
})

const chart = new XYContainer(el, {
  components: [line],
  xAxis: new Axis(),
  yAxis: new Axis(),
  tooltip,
  crosshair,
}, data)
```

Stacked bars use one `y` accessor per stack level:

```ts
import { Axis, StackedBar, XYContainer } from '@unovis/ts'

const bar = new StackedBar<DataRecord>({
  y: [d => d.a, d => d.b],
})
new XYContainer(el, { components: [bar], xAxis: new Axis(), yAxis: new Axis() }, data)
```

A graph lives in a `SingleContainer` with `{ nodes, links }` data:

```ts
import { Graph, GraphLayoutType, SingleContainer } from '@unovis/ts'

const graph = new Graph<GraphNodeDatum, GraphLinkDatum>({
  layoutType: GraphLayoutType.Force,
  linkStroke: l => l.color ?? null,
  nodeSize: n => n.size ?? 10,
})

const chart = new SingleContainer(el, { component: graph }, {
  nodes: [{ id: 'a' }, { id: 'b' }],
  links: [{ source: 'a', target: 'b' }],
})
```

Events are declared per-component with CSS selectors exposed as static
`selectors` on each component class (`core/component/config.d.ts`):

```ts
const area = new Area<DataRecord>({
  x: d => d.x,
  y: d => d.y,
  events: {
    [Area.selectors.area]: {
      click: d => console.log('clicked', d),
    },
  },
  attributes: { // stable hooks for E2E tests
    [Area.selectors.area]: { 'test-value': d => String(d.y) },
  },
})
```

Map with bundled TopoJSON (`maps.d.ts` exports `WorldMapTopoJSON`,
`USATopoJSON`, `GermanyTopoJSON`, `UKTopoJSON`, `FranceTopoJSON`,
`IndiaTopoJSON`, `ChinaTopoJSON`, `USCountiesTopoJSON`,
`WorldMapSimplestTopoJSON`, `WorldMap110mAlphaTopoJSON`):

```ts
import { SingleContainer, TopoJSONMap, WorldMapTopoJSON } from '@unovis/ts'

const map = new TopoJSONMap<AreaDatum, PointDatum>({
  topojson: WorldMapTopoJSON,
  mapFeatureName: 'countries',
  areaColor: d => d.color ?? null,
  pointColor: d => d.color ?? null,
  longitude: d => d.longitude ?? null,
  latitude: d => d.latitude ?? null,
})
new SingleContainer(el, { component: map }, areaData)
```

## Rules and pitfalls

- Do not mutate `component.config` or `container.config` directly; call the
  `update*` methods so changes merge with defaults and re-render.
- `Axis` instances for `xAxis`/`yAxis` need no `type`; the container assigns
  it (`containers/xy-container/config.d.ts`). Set `type` only for a standalone
  `Axis` in `components`.
- Colors: component `color` accessors returning `null` fall back to the
  container palette (`--vis-color<N>` CSS variables). Use `colorKeys` on XY
  components to map series to colors (`core/xy-component/config.d.ts`).
- Animation duration: container `duration` overrides all components;
  component `duration` (default `600`) applies to data transitions.
- Numeric string enums (`CurveType`, `SymbolType`, `Position`, ...) also
  accept their raw string values, e.g. `curveType: 'monotoneX'`.
- Package targets browsers. Node usage needs a DOM shim (the library's own
  tests run Vitest with jsdom, `package.json` scripts).

## References

- [API surface](references/api-surface.md) — full export catalog, container
  and component class API, events/attributes, tooltips.
- [Components](references/components.md) — per-component key configs,
  defaults, and data shapes.
- [Styling and theming](references/styling.md) — color palette, CSS
  variables, dark theme, patterns, testing.

Official documentation: https://unovis.dev/docs/intro — component reference at
`https://unovis.dev/docs/components/<Name>` (e.g. `/docs/components/Line`),
containers at `/docs/containers/XY_Container` and
`/docs/containers/Single_Container`. Gallery: https://unovis.dev/gallery.
Release notes: https://github.com/f5/unovis/releases (current prepared
version 1.7.0, `package.json`).
