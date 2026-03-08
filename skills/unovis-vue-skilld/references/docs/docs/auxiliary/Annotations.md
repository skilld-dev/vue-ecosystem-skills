---
title: "Annotations | Unovis"
meta:
  "og:description": "The Annotations component allows you to add informative text to your visualizations."
  "og:title": "Annotations | Unovis"
  description: "The Annotations component allows you to add informative text to your visualizations."
---

## Basic Configuration [](#basic-configuration "Direct link to Basic Configuration")

Include the `Annotations` component in your _Single_ or _XY_ container with an array of **items**. A basic example looks like:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

component.tsx

```
<VisXYContainer yDomain={[0,15]} data={data}>  <VisArea x={x} y={y} curveType="linear"/>  <VisAnnotations items={items}/></VisXYContainer>
```

template.html

```
<vis-xy-container [yDomain]="[0,15]" [data]="data">  <vis-area [x]="x" [y]="y" curveType="linear"></vis-area>  <vis-annotations [items]="items"></vis-annotations></vis-xy-container>
```

component.svelte

```
<VisXYContainer yDomain={[0,15]} {data}>  <VisArea {x} {y} curveType="linear"/>  <VisAnnotations {items}/></VisXYContainer>
```

component.vue

```
<VisXYContainer :yDomain="[0,15]" :data="data">  <VisArea :x="x" :y="y" curveType="linear" />  <VisAnnotations :items="items" /></VisXYContainer>
```

component.tsx

```
<VisXYContainer yDomain={[0,15]} data={data}>  <VisArea x={x} y={y} curveType="linear"/>  <VisAnnotations items={items}/></VisXYContainer>
```

component.ts

```
const container = new XYContainer<DataRecord>(node, {  yDomain: [0,15],   components: [new Area({ x, y, curveType: "linear" })],   annotations: new Annotations({ items })}, data)
```

Loading...

where _items_ has the following definition:

```
let items: AnnotationItem[] = [  { x: 12, y: 10, content: { text: 'Chart Title', fontSize: 30 }},  { x: 15, y: 50, width: 200, content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam rutrum dignissim lorem, a mollis lacus lacinia eget' },  { x: '50%', y: '20%', content: 'Label #1', subject: { x: '42%', y: '38%' }},  { x: '70%', y: '40%', content: 'Label #2', subject: { x: '86%', y: '50%' }},]
```

## Items [](#items "Direct link to Items")

The `items` property accepts an array of `AnnotationItem` objects. For minimum configuration, include **content** (the text) and an optional **subject** (the highlighted area).

#### `AnnotationItem` Type [](#annotationitem-type "Direct link to annotationitem-type")

```
type AnnotationItem = {  // Base properties  content: string | UnovisText | UnovisText[];  subject?: AnnotationSubject;  // Position and size properties  x?: number | \`${number}%\` | \`${number}px\`  y?: number | \`${number}%\` | \`${number}px\`  width?: number | \`${number}%\` | \`${number}px\`  height?: number | \`${number}%\` | \`${number}px\`   // Wrapping and alignment properties  separator?: string | string[];  verticalAlign?: VerticalAlign | string;  textAlign?: TextAlign | string;  wordBreak?: boolean;  fastMode?: boolean;  // Miscellaneous  cursor: string;}
```

## Text Content [](#text-content "Direct link to Text Content")

The `content` property accepts a string, a `UnovisText` object, or an array of `UnovisText` objects.

As a basic example, you can use a string:

```
let items: AnnotationItem[] = [  { content: 'Item 1' }]
```

When we place Annotations in an empty chart with the above items array, we get the default text appearance:

Loading...

### Styled Text [](#styled-text "Direct link to Styled Text")

To customize font or color of your text, provide `content` with an object of type `UnovisText`. In this case, you put the desired string content to the `text` property, and additional properties can be set.

```
items = [{  content: { text: 'Item 2', color: 'red' }}]
```

Loading...

### Multi-Line Text [](#multi-line-text "Direct link to Multi-Line Text")

You can group a single annotation into multiple lines of text by providing an array of `UnovisText` items to the content property.

The following is also a valid input for `items`:

```
items = [{  content: [    {      text: 'Item 3',      fontSize: 24,      fontWeight: 600    },    {      text: 'contains multiple text blocks lines',      fontFamily: 'cursive',      fontSize: 16    },    {      text: 'with custom styles',      color: 'green',      fontWeight: 'bold'    },  ],}]
```

Loading...

### `UnovisText` type [](#unovistext-type "Direct link to unovistext-type")

```
type UnovisText = {  // The text content to be displayed.  text: string;  // The font size of the text in pixels.  fontSize?: number;  // The font family of the text.  fontFamily?: string;  // The font weight of the text.  fontWeight?: number;  // The color of the text.  color?: string;  // The line height scaling factor for the text.  lineHeight?: number;  // The top margin of the text block in pixels  marginTop?: number;  // The bottom margin of the text block in pixels  marginBottom?: number;  // The font width-to-height ratio  fontWidthToHeightRatio?: number;};
```

## Positioning [](#positioning "Direct link to Positioning")

The `x` and `y` properties define the position of the annotation. They can be specified in pixels (number or string) or as a percentage of the container size. You can also add `textAlign` and `verticalAlign` properties to adjust the alignment of the text.

For example, the following is a valid definition of

```
const items= [  {    content: 'Item A',    x: 0,    y: 10,    subject: { x: 50, y: 50 }  },  {    content: 'Item B',    x: '150px',    y: '20px',    textAlign: 'right',    subject: { x: '100px', y: '60px' }  },  {    content: 'Item C',    x: '50%',    y: '100%',    textAlign: 'center',    verticalAlign: 'bottom',    subject: { x: '50%', y: '70%' },  },]
```

Loading...

## Subjects [](#subjects "Direct link to Subjects")

Subjects are focal points of the annotation. They can be used to highlight a specific area or point. The minimum configuration of a `subject` is an `x` and `y` coordinate.

```
items = [{  content: 'Item with Subject',  subject: { x: '50%', y: 20 }}]
```

Loading...

### Subject Points [](#subject-points "Direct link to Subject Points")

The point corresponds to the center of the subject area. When a radius is provided, the point becomes visible.

```
items = [{  content: 'Item with Subject',  subject: { x: '50%', y: 2, radius: 4 }}]
```

Loading...

### `AnnotationSubject` Type [](#annotationsubject-type "Direct link to annotationsubject-type")

```
export type AnnotationSubject = {  x: LengthUnit | (() => LengthUnit);  y: LengthUnit | (() => LengthUnit);  /** Subject radius */  radius?: number;  /** Subject fill color */  fillColor?: string;  /** Subject stroke color */  strokeColor?: string;  /** Subject stroke-dasharray configuration */  strokeDasharray?: string;  /** Padding between the subject and the connector line */  padding?: number;  /** Connector line color */  connectorLineColor?: string;  /** Connector line stroke-dasharray configuration */  connectorLineStrokeDasharray?: string;};
```

## CSS Variables [](#css-variables "Direct link to CSS Variables")

```
--vis-annotations-connector-stroke-color: #444;--vis-annotations-connector-stroke-width: 1px;--vis-annotations-connector-stroke-dasharray: none;--vis-annotations-subject-stroke-color: #444;--vis-annotations-subject-fill-color: none;--vis-annotations-subject-stroke-dasharray: none;--vis-dark-annotations-conntector-stroke-color: #fff;--vis-dark-annotations-subject-stroke-color: #fff;
```

## Component Props [](#component-props "Direct link to Component Props")

| Name | Type | Description |
| --- | --- | --- |
| * required property |