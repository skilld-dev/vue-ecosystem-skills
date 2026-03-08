---
title: "Introduction | Unovis"
meta:
  "og:description": " Welcome to Unovis"
  "og:title": "Introduction | Unovis"
  description: " Welcome to Unovis"
---

##  Welcome to Unovis [](#-welcome-to-unovis "Direct link to  Welcome to Unovis")

This documentation will help you to get comfortable with _Unovis_ — a modular and framework-independent library for charts, maps and network graphs.

##  Install [](#-install "Direct link to  Install")

Unovis is available on NPM in several packages, each for the UI framework of your choice (_React_, _Angular_, _Svelte_ or _Vue_). The core package `@unovis/ts` can be used without a UI framework, and if you use one you'll need to install `@unovis/ts` along with the framework specific package:

- React
- Angular
- Svelte
- Vue
- Solid
- TypeScript

```
npm install -P @unovis/ts @unovis/react
```

```
npm install -P @unovis/ts @unovis/angular
```

```
npm install -P @unovis/ts @unovis/svelte
```

```
npm install -P @unovis/ts @unovis/vue
```

```
npm install -P @unovis/ts @unovis/solid
```

```
npm install -P @unovis/ts
```

info

If you use TypeScript, you'll need to enable the `allowSyntheticDefaultImports` option in the `compilerOptions` section of your `tsconfig.json`, because some of _Unovis_'s dependencies need it.

Also if you have `types` specified in `tsconfig.json` explicitly, you might need to add `"topojson-client"` to the list. Otherwise, the TypeScript compiler won't find the required TopoJSON types.

##  Create your first chart [](#-create-your-first-chart "Direct link to  Create your first chart")

Most of _Unovis_ components require a _Container_ to get rendered. There are two types of containers available:

- _XY Container_. Designed to manage multiple _XY Components_ (e.g. _Line_, _GroupedBar_, _Scatter_, ...), along with optional _Axes_, _Tooltip_ and _Crosshair_;
- _Single Container_. Works only with a single components, like _Graph_, _Sankey_, or _TopoJSONMap_. It also supports _Tooltip_.

Some of the components are stand-alone and don't need a container: _LeafletMap_, _LeafletFlowMap_ and legends.

Go to the  Quick Start section to learn how to quickly build a simple Line Chart.

##  Explore the docs [](#-explore-the-docs "Direct link to  Explore the docs")

Pick a component from the sidebar to learn how to configure it. Start with  _Line_ or  _Bar_ if you want something simple. Don't forget to check out our  Gallery to see what the library is capable of!