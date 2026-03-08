---
title: "Leaflet Map | Unovis"
meta:
  "og:description": "Learn how to set up a Leaflet map"
  "og:title": "Leaflet Map | Unovis"
  description: "Learn how to set up a Leaflet map"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

_LeafletMap_ is a mapping component capable of rendering detailed maps. It doesn't come with preloaded maps, so you'll need to provide a vector tile source first to make it work. You can use an existing cloud map tile server (like MapTiler Cloud, which has a free tier) or host your own tiles (we've successfully used OpenMapTiles in the past).

Let's assume you've got an API key from MapTiler. You can initialize _LeafletMap_ by providing a `style` URL or object to it. MapTiler has a few vector styles available by default, but you can also create your own. Don't forget to set the attribution properly.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
function Component(props) {  const style = \`https://api.maptiler.com/maps/positron/style.json?key=${key}\`  const attribution = [    \`<a href="https://www.maptiler.com/copyright/" target="_blank">MapTiler</a>\`,    \`<a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap contributors</a>\`  ]  return (    <VisLeafletMap style={style} attribution={attribution}/>  )}
```

component.ts

```
@Component({  template: \`    <vis-leaflet-map      [style]="style"       [attribution]="attribution"    ></vis-leaflet-map>  \`})export class Component {  style = \`https://api.maptiler.com/maps/positron/style.json?key=${key}\`  attribution = [    \`<a href="https://www.maptiler.com/copyright/" target="_blank">MapTiler</a>\`,    \`<a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap contributors</a>\`  ]}
```

component.svelte

```
<script lang='ts'>  import { VisLeafletMap } from '@unovis/svelte'  const style = \`https://api.maptiler.com/maps/positron/style.json?key=${key}\`  const attribution = [    \`<a href="https://www.maptiler.com/copyright/" target="_blank">MapTiler</a>\`,    \`<a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap contributors</a>\`  ]</script><VisLeafletMap {style} {attribution}/>
```

component.vue

```
<script setup lang="ts">import { VisLeafletMap } from '@unovis/vue'const style = \`https://api.maptiler.com/maps/positron/style.json?key=${key}\`const attribution = [    \`<a href="https://www.maptiler.com/copyright/" target="_blank">MapTiler</a>\`,    \`<a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap contributors</a>\`  ]</script><template>  <VisLeafletMap :style="style" :attribution="attribution" /></template>
```

component.tsx

```
function Component(props) {  const style = \`https://api.maptiler.com/maps/positron/style.json?key=${key}\`  const attribution = [    \`<a href="https://www.maptiler.com/copyright/" target="_blank">MapTiler</a>\`,    \`<a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap contributors</a>\`  ]  return (    <VisLeafletMap style={style} attribution={attribution}/>  )}
```

component.ts

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style: \`https://api.maptiler.com/maps/positron/style.json?key=${key}\`,   attribution: [    \`<a href="https://www.maptiler.com/copyright/" target="_blank">MapTiler</a>\`,    \`<a href="https://www.openstreetmap.org/copyright" target="_blank">OpenStreetMap contributors</a>\`  ]})
```

Loading...

## Map Data [](#map-data "Direct link to Map Data")

_LeafletMap_ can plot an array of points provided to the component. The corresponding data objects can be in an arbitrary format, but they need to have properties storing the latitude and longitude values. A minimum viable datatype of the data objects looks like:

```
type MapDataRecord = {  latitude: number;  longitude: number;}
```

You can provide alternative `pointLatitude` and `pointLongitude` accessor functions in your _LeafletMap_ configuration.

Close points will automatically cluster and uncluster as you zoom in or out. When you click on a cluster, the map will smoothly zoom into a cluster (if map zoom is too far) or expand it showing the contained points.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap style={style} data={data}/>
```

```
<vis-leaflet-map [style]="style" [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap {style} {data}/>
```

```
<VisLeafletMap :style="style" :data="data" />
```

```
<VisLeafletMap style={style} data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, { style }, data)
```

Loading...

## Points [](#points "Direct link to Points")

### Point Color [](#point-color "Direct link to Point Color")

You can set custom color to the points by using the `pointColor` property, which accepts either a constant CSS color string or an accessor function. The default point color comes from the `--vis-map-point-default-fill-color` CSS variable.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap style={style} pointColor="#FFD651" data={data}/>
```

```
<vis-leaflet-map  [style]="style"   pointColor="#FFD651"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap {style} pointColor="#FFD651" {data}/>
```

```
<VisLeafletMap :style="style" pointColor="#FFD651" :data="data" />
```

```
<VisLeafletMap style={style} pointColor="#FFD651" data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style,   pointColor: "#FFD651"}, data)
```

Loading...

### Point Shape [](#point-shape "Direct link to Point Shape")

_LeafletMap_ supports 4 different point shapes: "circle", "square", "triangle" and "ring". You can set the shape by using the `pointShape` property. It accepts a `LeafletMapPointShape` enum, a string, or an accessor function returning either of them.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap style={style} pointShape="triangle" data={data}/>
```

```
<vis-leaflet-map  [style]="style"   pointShape="triangle"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap {style} pointShape="triangle" {data}/>
```

```
<VisLeafletMap :style="style" pointShape="triangle" :data="data" />
```

```
<VisLeafletMap style={style} pointShape="triangle" data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style,   pointShape: "triangle"}, data)
```

Loading...

### Point Radius [](#point-radius "Direct link to Point Radius")

Point radius can be set by providing a constant value or a function to the `pointRadius` property.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap style={style} pointRadius={pointRadius} data={data}/>
```

```
<vis-leaflet-map  [style]="style"   [pointRadius]="pointRadius"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap {style} {pointRadius} {data}/>
```

```
<VisLeafletMap  :style="style"   :pointRadius="pointRadius"   :data="data" />
```

```
<VisLeafletMap style={style} pointRadius={pointRadius} data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, { style, pointRadius }, data)
```

Loading...

### Point Labels [](#point-labels "Direct link to Point Labels")

#### Central [](#central "Direct link to Central")

Points can have two kinds of labels: central and bottom. The label at the center of the point can be set by using the `pointLabel` property. This label will fit into the point, so it is supposed to be short.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap  style={style}   pointRadius={pointRadius}   pointLabel={pointLabel}   data={data}/>
```

```
<vis-leaflet-map  [style]="style"   [pointRadius]="pointRadius"   [pointLabel]="pointLabel"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap {style} {pointRadius} {pointLabel} {data}/>
```

```
<VisLeafletMap  :style="style"   :pointRadius="pointRadius"   :pointLabel="pointLabel"   :data="data" />
```

```
<VisLeafletMap  style={style}   pointRadius={pointRadius}   pointLabel={pointLabel}   data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style,   pointRadius,   pointLabel}, data)
```

Loading...

####

You can control the color of central labels with the `pointLabelColor` and `clusterLabelColor` config properties. By default, the label color will be set to a CSS variable, depending on the point brightness, either to `--vis-map-point-inner-label-text-color-light` or to `--vis-map-point-inner-label-text-color-dark`.

#### Bottom [](#bottom "Direct link to Bottom")

The bottom label is configurable via the `pointBottomLabel` property. All label properties can accept accessor functions as their value. In the example below we set `pointBottomLabel` to `d => d.id`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap  style={style}   pointBottomLabel={pointBottomLabel}   data={data}/>
```

```
<vis-leaflet-map  [style]="style"   [pointBottomLabel]="pointBottomLabel"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap {style} {pointBottomLabel} {data}/>
```

```
<VisLeafletMap  :style="style"   :pointBottomLabel="pointBottomLabel"   :data="data" />
```

```
<VisLeafletMap  style={style}   pointBottomLabel={pointBottomLabel}   data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, { style, pointBottomLabel }, data)
```

Loading...

## Clusters [](#clusters "Direct link to Clusters")

Configuration options for clusters are very similar to the configuration of regular points but there are a few differences. Clusters are always displayed as circles (or rings when `colorMap` is provided). And cluster related accessor functions will receive `LeafletMapClusterDatum` (instead of `LeafletMapPointDatum`) as an argument, which has a `clusterPoints` property containing all points within that cluster.

### Cluster Color and Radius [](#cluster-color-and-radius "Direct link to Cluster Color and Radius")

Just like with points you can set custom cluster color by using the `clusterColor` property. The default color comes from the `--vis-map-cluster-default-fill-color` CSS variable.

Similarly, you can also set custom cluster radius by providing `clusterRadius`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap  style={style}   clusterColor="black"   clusterRadius={clusterRadius}   data={data}/>
```

```
<vis-leaflet-map  [style]="style"   clusterColor="black"   [clusterRadius]="clusterRadius"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap {style} clusterColor="black" {clusterRadius} {data}/>
```

```
<VisLeafletMap  :style="style"   clusterColor="black"   :clusterRadius="clusterRadius"   :data="data" />
```

```
<VisLeafletMap  style={style}   clusterColor="black"   clusterRadius={clusterRadius}   data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style,   clusterColor: "black",   clusterRadius}, data)
```

Loading...

### Cluster Labels [](#cluster-labels "Direct link to Cluster Labels")

By default, clusters display the number of contained points in the center. That behaviour can be overridden with the `clusterLabel` property. The `clusterBottomLabel` property allows you to set the bottom label.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap  style={style}   clusterLabel={clusterLabel}   clusterBottomLabel={clusterBottomLabel}   data={data}/>
```

```
<vis-leaflet-map  [style]="style"   [clusterLabel]="clusterLabel"   [clusterBottomLabel]="clusterBottomLabel"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap {style} {clusterLabel} {clusterBottomLabel} {data}/>
```

```
<VisLeafletMap  :style="style"   :clusterLabel="clusterLabel"   :clusterBottomLabel="clusterBottomLabel"   :data="data" />
```

```
<VisLeafletMap  style={style}   clusterLabel={clusterLabel}   clusterBottomLabel={clusterBottomLabel}   data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style,   clusterLabel,   clusterBottomLabel}, data)
```

Loading...

Similar to regular point labels, you can set the color of central labels with the `clusterLabelColor` config property, and use the `--vis-map-cluster-inner-label-text-color-light` and `--vis-map-cluster-inner-label-text-color-dark` CSS variables to change the default behaviour.

### Expand on Click [](#expand-on-click "Direct link to Expand on Click")

If you want clusters to never expand on click, you can set `clusterExpandOnClick` to `false`. In that case when you click on a cluster, the map will keep zooming in until the zoom level is high enough for the cluster to break.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap  style={style}   pointColor="#286e47"   clusterExpandOnClick={false}   data={data}/>
```

```
<vis-leaflet-map  [style]="style"   pointColor="#286e47"   [clusterExpandOnClick]="false"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap  {style}   pointColor="#286e47"   clusterExpandOnClick={false}   {data}/>
```

```
<VisLeafletMap  :style="style"   pointColor="#286e47"   :clusterExpandOnClick="false"   :data="data" />
```

```
<VisLeafletMap  style={style}   pointColor="#286e47"   clusterExpandOnClick={false}   data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style,   pointColor: "#286e47",   clusterExpandOnClick: false}, data)
```

Loading...

## Color Map [](#color-map "Direct link to Color Map")

If you're using `LeafletMapPointShape.Circle` or `LeafletMapPointShape.Ring` as a point shape, and your points have multiple values of the same kind associated with them, you can show the distribution of those values on a tiny pie / donut diagram.

Let's say we want to show city population by age, and our data point looks like:

```
type MapDataRecord = {  ...  age0_18: number;  age19_64: number;  age65plus: number;}
```

You can use the `colorMap` property to define the color (and custom CSS class if necessary) for the corresponding pie / donut segments:

```
const colorMap = {  age0_18: { color: '#0085FF' },  age19_64: { color: '#41A4FF' },  age65plus: { color: '#8BC7FF', className: 'age65plus' },}
```

Clusters will automatically reflect that too — they'll be rendered as small donuts. You can control the thickness of the donut ring by using the `clusterRingWidth` and `pointRingWidth` properties.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap  style={style}   pointBottomLabel={pointBottomLabel}   pointRadius={pointRadius}   clusterRingWidth={2}   colorMap={colorMap}   data={data}/>
```

```
<vis-leaflet-map  [style]="style"   [pointBottomLabel]="pointBottomLabel"   [pointRadius]="pointRadius"   [clusterRingWidth]="2"   [colorMap]="colorMap"   [data]="data"></vis-leaflet-map>
```

```
<VisLeafletMap  {style}   {pointBottomLabel}   {pointRadius}   clusterRingWidth={2}   {colorMap}   {data}/>
```

```
<VisLeafletMap  :style="style"   :pointBottomLabel="pointBottomLabel"   :pointRadius="pointRadius"   :clusterRingWidth="2"   :colorMap="colorMap"   :data="data" />
```

```
<VisLeafletMap  style={style}   pointBottomLabel={pointBottomLabel}   pointRadius={pointRadius}   clusterRingWidth={2}   colorMap={colorMap}   data={data}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style,   pointBottomLabel,   pointRadius,   clusterRingWidth: 2,   colorMap}, data)
```

Loading...

## TopoJSON Overlay [](#topojson-overlay "Direct link to TopoJSON Overlay")

_LeafletMap_ can also display a topojson overlay on top of the base map. It's configurable via the `topoJSONLayer` config property. The configuration object for the overlay consists of several properties:

```
topoJSONLayer: {  /* Your \`TopoJSON.Topology\` object. Default: \`undefined\` */  sources: TopoJSON.Topology;  /* Name of the feature collection to be rendered. Default: \`undefined\` */  featureName: string;  /* Fill color property name. Default: \`undefined\` */  fillProperty: string;  /* Fill opacity. Default: \`0.6\` */  fillOpacity: number;  /* Stroke color property name. Default: \`undefined\` */  strokeProperty: string;  /* Stroke opacity. Default: \`0.8\` */  strokeOpacity: number;  /* Stroke width. Default: \`2\` */  strokeWidth: number;}
```

Let's say your Topojson looks like:

```
const topojson = {    "type": "Topology",    "arcs": [...],    "objects": {        "countries": {            "type": "GeometryCollection",            "geometries": [                {                    "arcs": [...],                    "type": "MultiPolygon",                    "properties": {                        "name": "Canada",                        "color": "#1f77b4",                        "color-stroke": "#3E5FFF"                    },                    "id": "CA"                },                ...        }    }}
```

Then you can use the following `topoJSONLayer` configuration to display the layer in _LeafletMap_:

```
const topoJSONLayer = {  sources: topojson,  featureName: 'countries',  fillProperty: 'color',  strokeProperty: 'color-stroke',}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap style={style} topoJSONLayer={topoJSONLayer}/>
```

```
<vis-leaflet-map  [style]="style"   [topoJSONLayer]="topoJSONLayer"></vis-leaflet-map>
```

```
<VisLeafletMap {style} {topoJSONLayer}/>
```

```
<VisLeafletMap :style="style" :topoJSONLayer="topoJSONLayer" />
```

```
<VisLeafletMap style={style} topoJSONLayer={topoJSONLayer}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, { style, topoJSONLayer })
```

Loading...

caution

This feature is not supported when the [raster](#using-raster-files) renderer is enabled.

## Map Callbacks [](#map-callbacks "Direct link to Map Callbacks")

_LeafletMap_ has several configurable callback functions that will be called upon various map interactions. All of these functions (except `onMapInitialized`) will have `{ mapCenter, zoomLevel, bounds }` provided as an argument.

```
/** Function to be called after the map's async initialization is done. Default: \`undefined\` */onMapInitialized: (() => void)/** Map Move / Zoom unified callback function. Default: \`undefined\` */onMapMoveZoom: (({ mapCenter, zoomLevel, bounds }: MapZoomState) => void)/** Map Move Start callback function. Default: \`undefined\` */onMapMoveStart: (({ mapCenter, zoomLevel, bounds }: MapZoomState) => void)/** Map Move End callback function. Default: \`undefined\` */onMapMoveEnd: (({ mapCenter, zoomLevel, bounds }: MapZoomState) => void)/** Map Zoom Start callback function. Default: \`undefined\` */onMapZoomStart: (({ mapCenter, zoomLevel, bounds }: MapZoomState) => void)/** Map Zoom End callback function. Default: \`undefined\` */onMapZoomEnd: (({ mapCenter, zoomLevel, bounds }: MapZoomState) => void)/** Map Zoom Click callback function. Default: \`undefined\` */onMapClick: (({ mapCenter, zoomLevel, bounds }: MapZoomState) => void)
```

The callback functions above were added to enable deeper _LeafletMap_ integration into other project. If you want to set up a callback functions for the data layer (points, clusters, ...) you can use _Unovis_'s traditional events configuration:

```
events: {  // One event for regular points and clusters  [LeafletMap.selectors.point]: {    click: (d: LeafletMapPoint<MapDataRecord> => {      ...    }  }}
```

## Controlling the View [](#controlling-the-view "Direct link to Controlling the View")

By default, if you provide data to the map before the initialization, it'll automatically fit the view to show all the data points. You can disable that behaviour by setting `fitViewOnInit` to `false`, in that case the whole world will be displayed. If you want the map to re-fit the view on data updates, you can set `fitViewOnUpdate` to `true`. The fit padding can be controlled with the `fitViewPadding` property.

Alternatively, if you want the map to display a specific area upon initialization, you can set the `initialBounds` property in the following format:

```
type Bounds = {  northEast: { lat: number; lng: number };  southWest: { lat: number; lng: number };}
```

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap style={style} initialBounds={initialBounds}/>
```

```
<vis-leaflet-map  [style]="style"   [initialBounds]="initialBounds"></vis-leaflet-map>
```

```
<VisLeafletMap {style} {initialBounds}/>
```

```
<VisLeafletMap :style="style" :initialBounds="initialBounds" />
```

```
<VisLeafletMap style={style} initialBounds={initialBounds}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, { style, initialBounds })
```

Loading...

Also, if you want specific bounds to be set on every map update, you can achieve that by setting the `fitBoundsOnUpdate` config property.

The _LeafletMap_ Typescript component has several public methods allowing you to control the view:

```
public zoomIn (increment: number)public zoomOut (decrement: number)public setZoom (zoomLevel: number)public fitView ()
```

If you're using _Unovis_ with a UI framework you can still access those functions. In React you can use the useRef hook to access the Typescript instance of _LeafletMap_. In Angular there's a ViewChild decorator allowing you to do the same. Svelte's _LeafletMap_ wrapper re-exports the functions, so you can simply import them in you code along with the component.

tip

If you want to learn more about various zoom levels, Mapbox has a great article on that topic.

## Selecting Points [](#selecting-points "Direct link to Selecting Points")

There are two ways how you can select a point on the map: provide a unique point id in the `selectedPointId` config property or call one of the imperative methods of the Typescript component using the technique described right above.

Available methods:

```
/* Select a point by id and optionally center the map view. * This method was designed to be used mainly with the \`[LeafletMap.selectors.point]\` click events * (when the user actually clicks on a point) and if the specified point is inside one of the collapsed * clusters it won't be selected. You can use the \`zoomToPointById\` method to achieve that. */public selectPointById (id: string, centerView = false)/* Zoom to a point by id and optionally select it. * If the point is inside a cluster, it'll be automatically expanded to show the enclosed point. * You can also force set the zoom level by providing the \`customZoomLevel\` argument. */public zoomToPointById (id: string, selectPoint = false, customZoomLevel?: number)/* Get the id of the selected point */public getSelectedPointId ()/* Unselect point if it was selected before */public unselectPoint ()
```

## Dark Theme [](#dark-theme "Direct link to Dark Theme")

You can provide a separate style for the dark theme via the `styleDarkTheme` property, if you want _LeafletMap_ to change its look when the dark theme is enabled.

## Using Raster files [](#using-raster-files "Direct link to Using Raster files")

By default, _LeafletMap_ uses the MapLibre GL JS renderer and the vector tile source you provide for the base map. You can use a raster tile source instead by providing a valid URL template string to `style`, and setting `renderer` to `LeafletMapRenderer.Raster` or `"raster"`.

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletMap  style="https://tile.openstreetmap.org/{z}/{x}/{y}.png"   renderer="raster"   attribution={attribution}/>
```

```
<vis-leaflet-map  style="https://tile.openstreetmap.org/{z}/{x}/{y}.png"   renderer="raster"   [attribution]="attribution"></vis-leaflet-map>
```

```
<VisLeafletMap  style="https://tile.openstreetmap.org/{z}/{x}/{y}.png"   renderer="raster"   {attribution}/>
```

```
<VisLeafletMap  style="https://tile.openstreetmap.org/{z}/{x}/{y}.png"   renderer="raster"   :attribution="attribution" />
```

```
<VisLeafletMap  style="https://tile.openstreetmap.org/{z}/{x}/{y}.png"   renderer="raster"   attribution={attribution}/>
```

```
const leafletMap = new LeafletMap<MapDataRecord>(node, {  style: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",   renderer: "raster",   attribution})
```

Loading...

note

When this rendering mode is enabled, `style` (and `styleDarkTheme`, if using) must be of type `string` in the form of a URL template. Only when `renderer` is set to `LeafletMapRenderer.MapLibre` (the default) can MapLibre's `StyleSpecification` object be used.

## Tooltip [](#tooltip "Direct link to Tooltip")

### For points and clusters [](#for-points-and-clusters "Direct link to For points and clusters")

_LeafletMap_ accepts a _Tooltip_ instance as a config property. If you want to add a tooltip to the points and clusters, you can use the `[LeafletMap.selectors.point]` selector in your _Tooltip_ configuration for both.

### For TopoJSON features [](#for-topojson-features "Direct link to For TopoJSON features")

If you have a TopoJSON overlay on your map, you can make the tooltip work with it by using the `[LeafletMap.selectors.map]` selector. In that case the tooltip callback will be called on every `mousemove` event, but the `feature` argument will be passed only when the mouse is above a `topoJSONLayer.featureName` feature.

## Events [](#events "Direct link to Events")

The following selectors are available for events:

```
import { LeafletMap } from '@unovis/ts'...events = {    [LeafletMap.selectors.point]: {},    [LeafletMap.selectors.innerLabel]: {},    [LeafletMap.selectors.bottomLabel]: {},    [LeafletMap.selectors.map]: {}}
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |