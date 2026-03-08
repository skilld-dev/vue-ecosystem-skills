---
title: "Leaflet Flow Map | Unovis"
meta:
  "og:description": "Learn how to configure a Leaflet flow map"
  "og:title": "Leaflet Flow Map | Unovis"
  description: "Learn how to configure a Leaflet flow map"
---

## Data [](#data "Direct link to Data")

_LeafletFlowMap_ expects the data to be an object with `points` and `flows` arrays:

```
type LeafletMapData = {  points: MapPointRecord[];  flows: MapFlowRecord[];}
```

The `points` array corresponds to regular _LeafletMap_ points. The `flows` array should contain information about source and target coordinates of the flying particles. By default, _LeafletFlowMap_ expects the following data format:

```
type MapFlowRecord = {  sourceLongitude: number;  sourceLatitude: number;  targetLongitude: number;  targetLatitude: number;}
```

You can also use custom accessor functions to get the source and target coordinates of the particles by providing them to the following configuration options: `sourceLatitude`, `sourceLongitude`, `targetLatitude`, `targetLongitude`.

## Particles [](#particles "Direct link to Particles")

_LeafletFlowMap_ allows to change the appearance of the flying particles by providing either constant values or accessor functions (that will be executed per flow) to the configuration attributes specified below.

### Color [](#color "Direct link to Color")

The color of the particles can be set by using the `flowParticleColor` property:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletFlowMap style={style} flowParticleColor="#f00" data={data}/>
```

```
<vis-leaflet-flow-map  [style]="style"   flowParticleColor="#f00"   [data]="data"></vis-leaflet-flow-map>
```

```
<VisLeafletFlowMap {style} flowParticleColor="#f00" {data}/>
```

```
<VisLeafletFlowMap  :style="style"   flowParticleColor="#f00"   :data="data" />
```

```
<VisLeafletFlowMap style={style} flowParticleColor="#f00" data={data}/>
```

```
const leafletFlowMap = new LeafletFlowMap<MapPointRecord, MapFlowRecord>(node, {  style,   flowParticleColor: "#f00"}, data)
```

Loading...

### Radius [](#radius "Direct link to Radius")

You can chance the radius of the particles with the `flowParticleRadius` property:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletFlowMap style={style} flowParticleRadius={10} data={data}/>
```

```
<vis-leaflet-flow-map  [style]="style"   [flowParticleRadius]="10"   [data]="data"></vis-leaflet-flow-map>
```

```
<VisLeafletFlowMap {style} flowParticleRadius={10} {data}/>
```

```
<VisLeafletFlowMap  :style="style"   :flowParticleRadius="10"   :data="data" />
```

```
<VisLeafletFlowMap style={style} flowParticleRadius={10} data={data}/>
```

```
const leafletFlowMap = new LeafletFlowMap<MapPointRecord, MapFlowRecord>(node, {  style,   flowParticleRadius: 10}, data)
```

Loading...

### Speed [](#speed "Direct link to Speed")

The speed of the particles can be controlled by using the `flowParticleSpeed` property. The value is in arbitrary angular units, we recommend it to be in the range of [0,0.2].

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletFlowMap style={style} flowParticleSpeed={0.02} data={data}/>
```

```
<vis-leaflet-flow-map  [style]="style"   [flowParticleSpeed]="0.02"   [data]="data"></vis-leaflet-flow-map>
```

```
<VisLeafletFlowMap {style} flowParticleSpeed={0.02} {data}/>
```

```
<VisLeafletFlowMap  :style="style"   :flowParticleSpeed="0.02"   :data="data" />
```

```
<VisLeafletFlowMap style={style} flowParticleSpeed={0.02} data={data}/>
```

```
const leafletFlowMap = new LeafletFlowMap<MapPointRecord, MapFlowRecord>(node, {  style,   flowParticleSpeed: 0.02}, data)
```

Loading...

### Density [](#density "Direct link to Density")

The `flowParticleDensity` property can be used to set the density / frequency of the flying particles. The recommended range is [0, 3].

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletFlowMap style={style} flowParticleDensity={2} data={data}/>
```

```
<vis-leaflet-flow-map  [style]="style"   [flowParticleDensity]="2"   [data]="data"></vis-leaflet-flow-map>
```

```
<VisLeafletFlowMap {style} flowParticleDensity={2} {data}/>
```

```
<VisLeafletFlowMap  :style="style"   :flowParticleDensity="2"   :data="data" />
```

```
<VisLeafletFlowMap style={style} flowParticleDensity={2} data={data}/>
```

```
const leafletFlowMap = new LeafletFlowMap<MapPointRecord, MapFlowRecord>(node, {  style,   flowParticleDensity: 2}, data)
```

Loading...

## Flow Source Points [](#flow-source-points "Direct link to Flow Source Points")

Similarly, you can change how the source points will look.

### Color [](#color-1 "Direct link to Color")

The color of the flow source can be customized by using the `sourcePointColor` configuration property:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletFlowMap  style={style}   sourcePointColor="#4A46B5"   data={data}/>
```

```
<vis-leaflet-flow-map  [style]="style"   sourcePointColor="#4A46B5"   [data]="data"></vis-leaflet-flow-map>
```

```
<VisLeafletFlowMap {style} sourcePointColor="#4A46B5" {data}/>
```

```
<VisLeafletFlowMap  :style="style"   sourcePointColor="#4A46B5"   :data="data" />
```

```
<VisLeafletFlowMap  style={style}   sourcePointColor="#4A46B5"   data={data}/>
```

```
const leafletFlowMap = new LeafletFlowMap<MapPointRecord, MapFlowRecord>(node, {  style,   sourcePointColor: "#4A46B5"}, data)
```

Loading...

### Radius [](#radius-1 "Direct link to Radius")

The `sourcePointRadius` property sets the radius of the source point:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisLeafletFlowMap style={style} sourcePointRadius={5} data={data}/>
```

```
<vis-leaflet-flow-map  [style]="style"   [sourcePointRadius]="5"   [data]="data"></vis-leaflet-flow-map>
```

```
<VisLeafletFlowMap {style} sourcePointRadius={5} {data}/>
```

```
<VisLeafletFlowMap  :style="style"   :sourcePointRadius="5"   :data="data" />
```

```
<VisLeafletFlowMap style={style} sourcePointRadius={5} data={data}/>
```

```
const leafletFlowMap = new LeafletFlowMap<MapPointRecord, MapFlowRecord>(node, {  style,   sourcePointRadius: 5}, data)
```

Loading...

### Events [](#events "Direct link to Events")

The flow source points have the following configurable callback functions for mouse events:

```
/** Flow source point click callback function. Default: \`undefined\` */onSourcePointClick: (f: FlowDatum, x: number, y: number, event: MouseEvent) => void;/** Flow source point mouse over callback function. Default: \`undefined\` */onSourcePointMouseEnter: (f: FlowDatum, x: number, y: number, event: MouseEvent) => void;/** Flow source point mouse leave callback function. Default: \`undefined\` */onSourcePointMouseLeave: (f: FlowDatum, event: MouseEvent) => void;
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |