---
title: "TopoJSON Map | Unovis"
meta:
  "og:description": "Learn how to configure a TopoJSON Map"
  "og:title": "TopoJSON Map | Unovis"
  description: "Learn how to configure a TopoJSON Map"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

## Map Data [](#map-data "Direct link to Map Data")

There are three main building blocks that can make up the data supplied to _TopoJSONMap_:

- **point**, a geographical coordinate
- **link**, a graph edge that connects two _points_
- **area**, a geographical area

The container for _TopoJSONMap_ accepts data in the form of an `Object` with these three building blocks as keys mapped to their data arrays, like so:

```
type MapData = {  points: MapPoint[];  links: MapLink[];  areas: MapArea[];}
```

where [`MapPoint`](#points), [`MapLink`](#links) and [`MapArea`](#areas), are custom types that represent map data. Keep reading to learn more about the minimum configurations for these types.

## Points [](#points "Direct link to Points")

A minimum viable datatype of the objects provided to the `points` attribute is:

```
type MapPoint = {  id: string;  latitude: number;  longitude: number;  color: string;}
```

You can also provide these values through the `latitude`, `longitude`, `pointId`, and `color` properties.

### `mapFitToPoints`[](#mapfittopoints "Direct link to mapfittopoints")

Enabling `mapFitToPoints` will automatically adjust the map's zoom level to fit all the points provided.

#### Before :

#### After :

### Point Styling [](#point-styling "Direct link to Point Styling")

The following _TopoJSONMap_ properties accept accessor functions to customize the appearance of your points:

- `pointColor`
- `pointCursor`
- `pointRadius`
- `pointStrokeWidth`

### Point Labels [](#point-labels "Direct link to Point Labels")

You can provide labels with the `pointLabel` attribute, which accepts a `StringAccessor` function to be called on each `MapPoint` datum.

For example, consider the following type and accessor function:

```
type MapPoint = {  id: string;  latitude: number;  longitude: number;  city: string;}const pointLabel = (d: MapPoint) => d.city
```

### Point Label Styling [](#point-label-styling "Direct link to Point Label Styling")

The following _TopoJSONMap_ properties can further customize your Point Label.

- `pointLabelPosition`
- `pointLabelTextBrighnessRatio`

### Example: Custom Points [](#example-custom-points "Direct link to Example: Custom Points")

## Links [](#links "Direct link to Links")

A minimum viable data type of the objects provided to the `links` attribute contains the keys `source` and `target`, which correspond to the points the link will connect. Most commonly, the `pointId`.

```
type MapLink = {  source: string | number | MapPoint;  target: string | number | MapPoint;}
```

Or, you can simply provide these values through the `linkSource` and `linkTarget` properties.

#### Link customization [](#link-customization "Direct link to Link customization")

You can further customize the map _Links_ with the following properties:

- `linkColor`
- `linkCursor`
- `linkWidth`

## Areas [](#areas "Direct link to Areas")

To work with features in the _TopoJSONMap_, all you need is a unique `id` which is defined in the chart's _topojson_ definition or an `areaId` accessor function. For example, in our `WorldMapTopoJSON` _topojson_, every country has a unique id that corresponds to the ISO 3166-1 alpha-2 country code. See our [topojson configuration](#topojson-configuration) section for more details.

```
type MapArea = {  id: string;}
```

As a basic example, let's say you have an array of countries created from ISO codes:

```
const countryCodes = [  'AU','BR','CN','EG','FR','IN','JP','MX','NO','PE','PH','RU','TZ','US']const areaData = countryCodes.map(id => ({ id }))const data = { areas: areaData }
```

The provided countries will be highlighted according to their color defined in the topojson file:

### Custom Color [](#custom-color "Direct link to Custom Color")

You can override the default area colors by including a `color` property in `AreaDatum` or by providing an `areaColor` accessor function.

#### Method 1: Through `AreaDatum` property [](#method-1-through-areadatum-property "Direct link to method-1-through-areadatum-property")

```
const data = {  points: [],  links: [],  areas: [    { id: 'AU', color: 'red' },    { id: 'BR', color: 'blue' },    { id: 'CN', color: 'green' },  ]}
```

#### Method 2: Through `areaColor` accessor function [](#method-2-through-areacolor-accessor-function "Direct link to method-2-through-areacolor-accessor-function")

```
const areaColor = (d: AreaDatum) => {  switch (d.id) {    case 'AU': return 'red'    case 'BR': return 'blue'    case 'CN': return 'green'  }}
```

The result:

**Note**: If `areaColor` is provided, it will override the `color` property in `AreaDatum`.

## Projections [](#projections "Direct link to Projections")

You can provide a projection for your _TopoJSONMap_ with a `MapProjection` instance. See D3's geo projections for more information.

## Zoom [](#zoom "Direct link to Zoom")

By default, zooming is enabled for a _TopoJSONMap_ component. You can disable it by setting the `disableZoom` property to `true`.

For further customization, you can configure the following zoom properties:

### `zoomFactor`[](#zoomfactor "Direct link to zoomfactor")

To set the initial zoom factor.

### `zoomExtent`[](#zoomextent "Direct link to zoomextent")

`zoomExtent` represents the range `[a,b]` which your map can zoom in and out, where `[a, b]` are the minimum and maximum zoom factors, respectively.

### `zoomDuration`[](#zoomduration "Direct link to zoomduration")

`zoomDuration` is the duration of the animation on when zooming in on your _TopoJSONMap_.

## Heatmap Mode [](#heatmap-mode "Direct link to Heatmap Mode")

For datasets with a lot of points, you can enable `heatmapMode`

You can customize the appearance of your heat map blur with the `heatmapModeBlurStdDeviation` property.

To lower or raise the threshold that will disable the blur effect of your heat map, use the the `heatmapModeZoomLevelThreshold` property. You can provide a zoom level, (i.e. `2` for _2x_ zoom), that once reached, that will no longer display the blur effect.

## TopoJSON Configuration [](#topojson-configuration "Direct link to TopoJSON Configuration")

In order for the _TopoJSONMap_ component to render properly, the `topojson` property and a valid `mapFeatureName` must be provided. The `mapFeatureName` corresponds to the type of unique _area_ ids in your data.

TopoJSONs currently available in `@unovis/ts/maps`:

| `topojson` | `mapFeatureName` | unique `MapArea` id | AreaDatum example |
| --- | --- | --- | --- |
| WorldMapTopoJSON,<br>WorldMapSimplestTopoJSON,<br>WorldMap110mAlpha | countries | ISO 2-digit country code | `{ id: 'ZM' }` |
| ChinaTopoJSON | provinces | ISO subdivision code (CN) | `{ id: 'CN-ZS' }` |
| FranceTopoJSON | regions | ISO subdivision code (FR) | `{ id: 'FR-94' }` |
| GermanyTopoJSON | regions | ISO subdivision code (DE) | `{ id: 'DE-13' }` |
| IndiaTopoJSON | regions | ISO subdivision code (IN) | `{ id: 'IN-DB' }` |
| UKTopoJSON | regions | UK ONS/GSS geocode | `{ id: 'E15000002' }` |
| USATopoJSON | states | FIPS 2-digit state code | `{ id: '51' }` |
| USCountiesTopoJSON | counties | FIPS 5-digit county code | `{ id: '53033' }` |

## Events [](#events "Direct link to Events")

```
import { TopoJSONMap } from '@unovis/ts'const events = {  [TopoJSONMap.selectors.point]: {},  [TopoJSONMap.selectors.feature]: {},}
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

The _TopoJSONMap_ component supports additional styling via CSS variables that you can define for your visualization container.

<details>

<summary>All supported CSS variables and their default values</summary>



```
--vis-map-feature-color: #dce3eb;--vis-map-boundary-color: #ffffff;--vis-map-point-label-text-color-dark: #5b5f6d;--vis-map-point-label-text-color-light: #fff;--vis-map-point-label-font-weight: 600;--vis-map-point-label-font-size: 12px;--vis-map-point-label-font-family /* Dark Theme */--vis-dark-map-feature-color: #5b5f6d;--vis-dark-map-boundary-color: #2a2a2a;--vis-dark-map-point-label-text-color-dark: #fff;--vis-dark-map-point-label-text-color-light:#5b5f6d;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |