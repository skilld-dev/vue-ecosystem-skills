---
title: "Free Brush | Unovis"
meta:
  "og:description": "Basic Configuration"
  "og:title": "Free Brush | Unovis"
  description: "Basic Configuration"
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

_Free Brush_ is an extention of _Brush_, an interactive component that is designed to work inside an _XYContainer_. See brush docs to learn about basic configuration and usage.

## Mode [](#mode "Direct link to Mode")

You can change the axis alignment of your _Free Brush_ by setting the `mode` property to `"x"`, `"y"` or `"xy"`:

`mode :`

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisFreeBrush mode="y"/>
```

```
<vis-free-brush mode="y"></vis-free-brush>
```

```
<VisFreeBrush mode="y"/>
```

```
<VisFreeBrush mode="y" />
```

```
<VisFreeBrush mode="y"/>
```

```
const freeBrush = new FreeBrush<DataRecord>({ mode: "y" })
```

Loading...

## Auto Hide [](#auto-hide "Direct link to Auto Hide")

Disabling the `autoHide` property will keep the _Free Brush_ selection visible after the `onBrushEnd` event has triggered:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
<VisFreeBrush autoHide={false}/>
```

```
<vis-free-brush [autoHide]="false"></vis-free-brush>
```

```
<VisFreeBrush autoHide={false}/>
```

```
<VisFreeBrush :autoHide="false" />
```

```
<VisFreeBrush autoHide={false}/>
```

```
const freeBrush = new FreeBrush<DataRecord>({ autoHide: false })
```

Loading...

## CSS Variables [](#css-variables "Direct link to CSS Variables")

<details>

<summary>All supported CSS variables and their default values</summary>



```
--vis-free-brush-selection-fill-color: #0b1640;--vis-free-brush-selection-fill-opacity: 0.4;--vis-free-brush-selection-stroke-color: #acb2b9;--vis-free-brush-handle-fill-color: #6d778c;--vis-free-brush-handle-stroke-color: none; /* Dark Theme */--vis-dark-free-brush-selection-fill-color: #344174;--vis-dark-free-brush-selection-stroke-color: #0b1640;--vis-dark-free-brush-handle-fill-color: #6d778c;
```

</details>

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |