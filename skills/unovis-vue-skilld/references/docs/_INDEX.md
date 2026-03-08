---
total: 54
---

# Docs Index

- [Gallery | Unovis](./gallery.md): Basic Line Chart previewBasic Line Chart preview Basic Line Chart Multi Line Chart previewMulti Line Chart preview Multi Line Chart Line Chart with...
- [Unovis](./index.md): Framework Independent
- [Blog | Unovis](./releases.md): January 23, 2026 · 2 min read
- [Search the documentation | Unovis](./search.md): Powered by Powered by Algolia

## contributing (4)

- [Architecture | Unovis](./contributing/architecture.md): A contents of the Unovis repo is contained in the packages directory:
- [Getting Started | Unovis](./contributing/getting-started.md): Minimum requirements: npm (v7 or above) and Node.js (v12 or above).
- [Contributing | Unovis](./contributing/intro.md): F5 has adopted a Code of Conduct that we expect project participants to adhere to. Please read the full text so that you can understand what action...
- [Pull Requests | Unovis](./contributing/pull-requests.md): Before creating a pull request, make sure your branch is up-to-date with the main branch. We recommend rebasing your branch on the main branch to a...

## contributing/guides (2)

- [How to Add a Component to Unovis | Unovis](./contributing/guides/adding-a-component.md): Before you start, make sure you familiarize yourself with our library's architecture. You should also be comfortable working with TypeScript and D3.
- [Adding an example to the Gallery | Unovis](./contributing/guides/gallery-examples.md): Add your example to the website in the directory packages/website/src/examples. Before submitting a pull request, make sure you have done the follo...

## docs/auxiliary (11)

- [Annotations | Unovis](./docs/auxiliary/Annotations.md): Include the Annotations component in your Single or XY container with an array of items. A basic example looks like:
- [Axis | Unovis](./docs/auxiliary/Axis.md): The Axis component has been designed to work together with XY Container. The minimal Axis configuration looks like:
- [Brush | Unovis](./docs/auxiliary/Brush.md): Brush is designed to work inside an XYContainer alongside an XYChart. The basic configuration looks like:
- [Bullet Legend | Unovis](./docs/auxiliary/BulletLegend.md): BulletLegend is a stand-alone component that can be used alongside your visualization to label colored data.
- [Crosshair | Unovis](./docs/auxiliary/Crosshair.md): The Crosshair component is a special tooltip designed to work in an XYContainer. When a user is interacting with the XYContainer and a crosshair is...
- [Free Brush | Unovis](./docs/auxiliary/FreeBrush.md): Free Brush is an extention of Brush, an interactive component that is designed to work inside an XYContainer. See brush docs to learn about basic c...
- [Plotband | Unovis](./docs/auxiliary/Plotband.md): component.tsx
- [Plotline | Unovis](./docs/auxiliary/Plotline.md): The basic configuration of a Plotline includes specifying the axis (x or y) and the exact value where the line should appear. You can customize its...
- [Rolling Pin Legend | Unovis](./docs/auxiliary/RollingPinLegend.md): RollingPinLegend is a stand-alone component that can be used alongside your visualization to compactly label marginal values while also displaying ...
- [Tooltip | Unovis](./docs/auxiliary/Tooltip.md): The Tooltip component allows you to add informative text when hovering over a chart element. It can work within both XYContainer and SingleContaine...
- [XYLabels | Unovis](./docs/auxiliary/XYLabels.md): Get started with just two required properties - x, y accessors and an optional label function.

## docs/category (1)

- [Component Reference | Unovis](./docs/category/component-reference.md): Single Container XY Container

## docs/containers (2)

- [Single Container | Unovis](./docs/containers/Single_Container.md): Single Container is a basic container for a Unovis component. It is designed to hold one visualization component and an (optional) Tooltip. Just wr...
- [XY Container | Unovis](./docs/containers/XY_Container.md): XY Container is designed as a container that manages multiple XY Components at once, along with optional X and Y axes, tooltip, and crosshair. Here...

## docs/guides (3)

- [JavaScript Usage | Unovis](./docs/guides/js-usage.md): component.tsx
- [Theming | Unovis](./docs/guides/theming.md): In addition to configuration properties, our components also rely on CSS variables to supply the values of various SVG attributes such as fill, str...
- [Tips and Tricks | Unovis](./docs/guides/tips-and-tricks.md): If you want to custom SVG definitions available for your components, you can use the svgDefs property on the container, like this:

## docs (2)

- [Introduction | Unovis](./docs/intro.md): This documentation will help you to get comfortable with Unovis — a modular and framework-independent library for charts, maps and network graphs.
- [Quick Start | Unovis](./docs/quick-start.md): Unovis is distributed in the format of ES modules. After the library is installed you can simply import Unovis components from @unovis/... packages:

## docs/maps (3)

- [Leaflet Flow Map | Unovis](./docs/maps/LeafletFlowMap.md): LeafletFlowMap expects the data to be an object with points and flows arrays:
- [Leaflet Map | Unovis](./docs/maps/LeafletMap.md): LeafletMap is a mapping component capable of rendering detailed maps. It doesn't come with preloaded maps, so you'll need to provide a vector tile ...
- [TopoJSON Map | Unovis](./docs/maps/TopoJSONMap.md): There are three main building blocks that can make up the data supplied to TopoJSONMap:

## docs/misc (3)

- [Donut | Unovis](./docs/misc/Donut.md): The minimum configuration for the Donut component looks like:
- [Nested Donut | Unovis](./docs/misc/NestedDonut.md): Nested Donut expects an array of generic data records, the properties of which will be used to define the layers. Each layer will contain nodes or ...
- [Treemap | Unovis](./docs/misc/Treemap.md): Treemap expects an array of generic data records, the properties of which will be used to define the layers. Each layer will contain tiles that rep...

## docs/networks-and-flows (3)

- [Chord Diagram | Unovis](./docs/networks-and-flows/ChordDiagram.md): The Chord Diagram component is a variation of a network graph where nodes and links are displayed in a circular layout.
- [Graph | Unovis](./docs/networks-and-flows/Graph.md): Graph expects the data to be an object with nodes and links arrays:
- [Sankey | Unovis](./docs/networks-and-flows/Sankey.md): Sankey is a popular kind of flow diagram that visualizes flows between multiple nodes. To define a Sankey diagram you'll need to have data about it...

## docs/xy-charts (6)

- [Area | Unovis](./docs/xy-charts/Area.md): component.tsx
- [Grouped Bar | Unovis](./docs/xy-charts/GroupedBar.md): The Grouped Bar component has been designed to work together with XY Container. The minimal Grouped Bar configuration looks like:
- [Line | Unovis](./docs/xy-charts/Line.md): The Line component has been designed to work together with XY Container. The minimal Line configuration looks like:
- [Scatter | Unovis](./docs/xy-charts/Scatter.md): The Scatter component has been designed to work together with XYContainer. The minimal Scatter configuration looks like:
- [Stacked Bar | Unovis](./docs/xy-charts/StackedBar.md): The Stacked Bar component has been designed to work together with XY Container. The minimal Stacked Bar configuration looks like:
- [Timeline | Unovis](./docs/xy-charts/Timeline.md): The Timeline component has been designed to work together with XY Container. The minimal Timeline configuration looks like:

## gallery (1)

- [Gallery | Unovis](./gallery/view.md)

## releases (9)

- [Release 1.1 | Unovis](./releases/1.1.md): April 20, 2023 · 3 min read
- [Release 1.2 | Unovis](./releases/1.2.md): June 27, 2023 · 3 min read
- [Release 1.3 | Unovis](./releases/1.3.md): November 8, 2023 · 2 min read
- [Release 1.4 | Unovis](./releases/1.4.md): April 2, 2024 · 3 min read
- [Release 1.5 | Unovis](./releases/1.5.md): December 4, 2024 · 3 min read
- [Release 1.6 | Unovis](./releases/1.6.md): August 14, 2025 · 5 min read
- [Announcing Unovis 1.0 | Unovis](./releases/1.md): December 12, 2022 · One min read
- [Archive | Unovis](./releases/archive.md)
- [Authors | Unovis](./releases/authors.md)
