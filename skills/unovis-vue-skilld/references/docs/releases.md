---
title: "Blog | Unovis"
meta:
  "og:description": Blog
  "og:title": "Blog | Unovis"
  description: Blog
---

## Angular LTS Support

January 23, 2026 · 2 min read



Qian Liu

Maintainer, Key Contributor



Surya Hanumandla

Maintainer, Key Contributor



Nikita Rokotyan

Creator, Key Contributor

## Overview [](#overview "Direct link to Overview")

Effective with the next major release (1.7) of Unovis, we will only support Angular versions that are currently in Long-Term Support (LTS) as defined by Angular's version support policy.

## What This Means [](#what-this-means "Direct link to What This Means")

Angular follows a predictable release cycle where each major version receives:

- **6 months** of active support (regular updates and patches)
- **12 months** of long-term support (critical fixes and security patches)
- After 18 months, versions reach end-of-life

Unovis will support all Angular versions currently in their LTS window. As Angular versions reach end-of-life, Unovis will drop support for those versions in our next minor release.

## Current Status [](#current-status "Direct link to Current Status")

Currently, Unovis supports Angular versions **12 through 19** (`"@angular/common": "12 - 19"` in our peer dependencies). Moving forward, we will only support Angular versions that are in active support or LTS.

## Why This Change? [](#why-this-change "Direct link to Why This Change?")

1. **Security**: Unsupported Angular versions no longer receive security updates, which can pose risks to applications
2. **Modern Features**: Allows us to leverage newer Angular features and APIs (standalone components, signals, improved TypeScript support, etc.)
3. **Maintenance Efficiency**: Reduces the testing matrix and allows our team to focus on supporting current Angular versions with better quality
4. **Industry Standard**: This aligns with how other major Angular libraries (Angular Material, NgRx, etc.) manage version support

## Timeline [](#timeline "Direct link to Timeline")

- **Effective Date**: Next major version release of Unovis
- **Transition Period**: Current versions of Unovis will continue to support the existing range until the next major release

## What You Should Do [](#what-you-should-do "Direct link to What You Should Do")

1. **Check Your Angular Version**: Run `ng version` to see which Angular version you're using
2. **Plan Your Upgrade**: If you're using an Angular version that's approaching end-of-life, plan to upgrade
3. **Stay Informed**: Follow Angular's release schedule to know when versions enter and exit LTS

## References [](#references "Direct link to References")

- Angular Version Support Policy
- Angular Material Version Support
- Unovis Documentation

## Feedback [](#feedback "Direct link to Feedback")

We value your input! If you have concerns or questions about this policy change, please:

- Open an issue on GitHub
- Join the discussion in our community channels
- Reach out to the maintainers

---

**The Unovis Team**

## Release 1.6

August 14, 2025 · 5 min read



Qian Liu

Maintainer, Key Contributor



Nikita Rokotyan

Creator, Key Contributor



Surya Hanumandla

Maintainer, Key Contributor

Version `1.6` of _Unovis_ is here! This is one of our most feature-packed releases yet, bringing exciting new components, enhanced graph functionality, improved axis customization, and numerous quality of life improvements.

We're excited to welcome our new first-time contributors to the Unovis community: @dennisadriaans, @curran, @50rayn, and @devgru. Thank you for your valuable contributions! 

## Release Highlights [](#release-highlights "Direct link to Release Highlights")

###  New Components: Treemap, Plotline, Plotband & Rolling Pin Legend [](#-new-components-treemap-plotline-plotband--rolling-pin-legend "Direct link to  New Components: Treemap, Plotline, Plotband &amp; Rolling Pin Legend")

Introducing four new components:

**_Treemap_**

- Hierarchical data visualization with customizable layers
- Rich styling options including `tileColor`, `tilePadding`, `tileBorderRadius` and `lightnessVariationAmount`
- Interactive features with hover states: `--vis-treemap-tile-hover-stroke-color`, `--vis-treemap-tile-hover-stroke-opacity`

**_Plotline_** - Draw precise reference lines across your charts:



- Support for both X and Y axis orientation
- Customizable line styles (solid, dashed, dotted)
- Configurable colors, widths, and positioning
- Works with all XY components

**_Plotband_** - Highlight ranges and areas in your visualizations:



- Create horizontal or vertical bands across chart areas
- Customizable colors with transparency support
- Flexible labeling with multiple positioning options

**_Rolling Pin Legend_** - Compact legend for displaying color scales:



- Displays color gradients in a horizontal rolling pin format
- Left and right label support for scale endpoints
- Customizable font sizes and styling

Check out _Plotline_'s documentation, _Plotband_'s documentation, _Treemap_'s documentation, and _Rolling Pin Legend_'s documentation with examples to learn how to use them.

###  Enhanced Crosshair Component [](#-enhanced-crosshair-component "Direct link to  Enhanced Crosshair Component")

Allow enforcement of crosshair display at certain position, this can be used to enable synchronized crosshair display

###  Line Chart Interpolation [](#-line-chart-interpolation "Direct link to  Line Chart Interpolation")

New interpolation feature for handling missing data in line charts:

- `interpolateMissingData` property fills data gaps with dashed lines
- Customizable appearance with CSS variables

```
    --vis-line-gapfill-stroke-dasharray: 2 3;    --vis-line-gapfill-stroke-opacity: 0.8;    --vis-line-gapfill-stroke-dashoffset: 0;
```

- Works seamlessly with fallback values for better data visualization

###  Bullet Legend Enhancements [](#-bullet-legend-enhancements "Direct link to  Bullet Legend Enhancements")

_Bullet Legend_ now supports multiple colors per item, enabling more sophisticated legend designs:



- Multiple color arrays for complex legend items

###  Axis Customization [](#-axis-customization "Direct link to  Axis Customization")

New CSS variables for greater axis styling control:

- `--vis-axis-line-stroke-color`: Customize axis line color
- `--vis-axis-line-stroke-width`: Control axis line thickness
- Better separation between domain line and tick styling
- **Label Trim and Wrap**: Add trim and wrap functionality to axis labels for better text handling



###  Timeline Component Enhancements [](#-timeline-component-enhancements "Direct link to  Timeline Component Enhancements")

Major updates to the Timeline component with new features and improved functionality:

- **Row Icons**: Support for enhanced visual categorization with icons alongside row labels
- **Line Icons**: Add start and end icons to timeline lines with configurable positioning
- **Arrow Support**: Connect related timeline entries with customizable arrows allowing user to create Gantt Charts
- **Hover Styles**: Better visual feedback with configurable hover states
- **Animation Control**: Configurable animation positions for line enter/exit transitions
- **Label Positioning**: Improved label positioning and clipping behavior with dedicated clipPath
- `labelTextAlign`: Adds `labelTextAlign` config option to Timeline component to control label alignment

###  Graph Component Updates [](#-graph-component-updates "Direct link to  Graph Component Updates")

Continued improvements to the Graph component:

- Enhanced panel documentation and examples
- Configurable node and group spacing in Parallel layouts (doc)

## Other Changes [](#other-changes "Direct link to Other Changes")

### Enhancements [](#enhancements "Direct link to Enhancements")

- Component | Graph: Enhanced panel documentation and examples #616
- Container | XY: Handle edge cases when `scaleByDomain` is `true` #588
- Website | Gallery: New custom nodes graph with tooltips example #603
- Website | Gallery: New patchy line chart gallery example #558
- Website | Gallery: New stacked area chart with attributes example #597
- Website | Docs: Enhanced documentation for multiple components

### Bug Fixes [](#bug-fixes "Direct link to Bug Fixes")

- Component | Tooltip: Fix dynamic config retrieval for mousemove handler #606
- Component | Graph: Fix link flow group dot issue #575
- Component | Graph: Fix link flow animation update #577
- Component | Timeline: Fix icon data binding, ordinal scale domain, and arrow exit transition #536
- Solid | Bug: Component destroy method #602
- Core | Types: Making `fontSize` optional in `UnovisText` #585

### Quality of Life Improvements [](#quality-of-life-improvements "Direct link to Quality of Life Improvements")

- TS: Replace deprecated JSX.Element with React.ReactNode #545
- Testing: Continued improvements to visual testing infrastructure

## Release 1.5

December 4, 2024 · 3 min read



Qian Liu

Maintainer, Key Contributor



Nikita Rokotyan

Creator, Key Contributor



Rebecca Bol

Maintainer, Key Contributor

Version `1.5` of _Unovis_ has arrived! This release is packed with enhancements, including full support for Solid; compatibility with React 19 and Angular 19; many Graph component tweaks; exciting new features; and numerous bug fixes.

## Release Highlights [](#release-highlights "Direct link to Release Highlights")

###  Solid Support [](#-solid-support "Direct link to  Solid Support")

_Unovis_ now works with Solid — one of the most performant JSX frameworks. Thanks to @hngngn for this amazing contribution!

###  React 19 and Angular 19 [](#--react-19-and-angular-19 "Direct link to   React 19 and Angular 19")

_Unovis_ now also support Angular 19 and React 19.  Calling for Svelte 5 support contribution (discussion)! Huge thanks to @pingu-codes for your incredible help with Svelte support! .

###  Graph [](#-graph "Direct link to  Graph")

A ton of new features were added to _Graph_:

- Provide your own functions to render nodes allowing you to highly customize how the graph looks (docs).
- Post-Layout (docs) and Post-Render Customization (docs) allowing you to modify the layout of the graph on the fly and render additional layers with D3.
- Provide custom SVG icon to link labels (docs).
- Zoom start/end and node dragging callbacks (docs).
- Fit view to specific nodes by providing an array of node ids.
- Multiple node selection (docs).
- Enable _Graph_ nodes to accept precalculated layout data (docs).

###  Tooltip [](#-tooltip "Direct link to  Tooltip")

_Tooltip_ now can be anchored to the target element, can be hovered over, and supports dynamic content (updates if the content changes) (docs).

###  Axis [](#-axis "Direct link to  Axis")

Axis now automatically hides overlapping labels (docs) and supports label rotation (docs).

###  Bullet Legend [](#-bullet-legend "Direct link to  Bullet Legend")

You can set the orientation of _Bullet Legend_ to `'vertical'` (docs).



###  Discord [](#-discord "Direct link to  Discord")

_Unovis_ now has a Discord channel! Join us to say hi, ask questions, and stay updated with the latest news.

## Other changes [](#other-changes "Direct link to Other changes")

### Enhancements [](#enhancements "Direct link to Enhancements")

- Testing | Add Cypress and Percy for visual testing #419
- Component | Brush: Additional styling options via CSS variables #392
- Website | Upgrade to Docusaurus V3 #486
- Website | Gallery: Range plot #390
- Website | Gallery: Scatter Plot with Varied Shape #370
- Website | Gallery: Donut Example #367
- Website | Add new composite chart section and dual axis chart #383

### Bug Fixes [](#bug-fixes "Direct link to Bug Fixes")

- Component | Scatter: MakesizeScale immutable to prevent sizeRange collisions #411
- Component | Scatter: Label rendering fixes #413
- Component | TopoJSON Map: Various fixes #425
- Core | Bug: XY-container size rendering fix #431

## Release 1.4

April 2, 2024 · 3 min read



Rebecca Bol

Maintainer, Key Contributor

Version `1.4.0` of _Unovis_ is finally here! This update is packed full with enhancements including the new Annotations component, expanded Graph features, and a number of bug fixes to improve overall stability of the library.

## Release Highlights [](#release-highlights "Direct link to Release Highlights")

###  New component: Annotations [](#-new-component-annotations "Direct link to  New component: Annotations")

Introducing _Annotations_, a versatile new component that enables you to overlay customized, stylized text on top of your visualizations. Whether you want to highlight points of interest, annotate trends, or simply add text labels to your charts or graphs, _Annotations_ is designed to integrate smoothly with any Unovis component.

Check out _Annotations_'s documentation and gallery example to learn how to use it.



###  Graph Link Curvature and SVG Icons [](#-graph-link-curvature-and-svg-icons "Direct link to  Graph Link Curvature and SVG Icons")

A number of features were added to _Graph_ in this PR, including link curvature configuration, the ability to use custom SVGs as node icons, and support for longer link labels. Check out the docs for a deep dive into the latest enhancements or to explore the breadth of features Graph has to offer.



###  Bullet Legend Shapes [](#-bullet-legend-shapes "Direct link to  Bullet Legend Shapes")

_Bullet Legend_ now supports a variety of shapes on the component level and for individual legend items. Perfect for when you want to pair a legend with a combination chart or shaped scatter plot.



## Other changes [](#other-changes "Direct link to Other changes")

### Enhancements [](#enhancements "Direct link to Enhancements")

- React: Exporting component selectors to allow for easier import #325
- Component | Crosshair | Configurable stroke and strokeWidth #353
- Vue | export selector, docs: update #358

### Bug Fixes [](#bug-fixes "Direct link to Bug Fixes")

- Component | Donut | Fix: sortFunction type error #308
- XYContainer | Fix: Crosshair accessors #309
- Component | Timeline | Fix: Color rendering on enter #310
- Component | Chord Diagram | Fixes, enhancements, and refactoring #318
- Website | Releases: Fix url image preview #323
- Core Component and Tooltip event handling tweaks #330
- Svelte | Package: Add missing exports condition for Svelte #334
- Angular | Build: Removing shared from peer dependencies #349
- React | Fixing ref initialization #344
- XY Container | Fix: scaleByDomain produces inconsistent behavior among XY charts #348
- Component | XYLabels | Fix clustering config not taking effect #351
- Component | Crosshair | Fix: crosshair with multiple area issue #356

## Release 1.3

November 8, 2023 · 2 min read



Nikita Rokotyan

Creator, Key Contributor



Rebecca Bol

Maintainer, Key Contributor

Unovis 1.3 introduces Vue support and a new pattern theme to further improve our support for accessibility features.

## Release Highlights [](#release-highlights "Direct link to Release Highlights")

###  Vue 3 support [](#-vue-3-support "Direct link to  Vue 3 support")

Long-awaited support for Vue, the third most popular front-end UI framework. Kudos to our community member @zernonia for this amazing contribution!

###  Patterns [](#-patterns "Direct link to  Patterns")

A new theme with pattern fills that can be enabled by adding the `theme-patterns` class to the `body` element of your document. See the documentation and this pull request for more details.



## Other changes [](#other-changes "Direct link to Other changes")

Other changes were aimed at improving the overall stability of the library making the codebase more robust to future changes

- Refactoring: From Config Classes to Objects #279
- Refactoring: No Implicit Any #290
- Component | Tooltip | Fix: Prevent container overflow when viewport size is reduced #292
- Component | NestedDonut | Fix: TS errors #296
- Svelte: Fixing SingleContainer props and adding support for `class` property #294
- Theme | Patterns: Adjust injected SVG style #298

## Release 1.2

June 27, 2023 · 3 min read



Nikita Rokotyan

Creator, Key Contributor



Rebecca Bol

Maintainer, Key Contributor

A new version of _Unovis_ is waiting for you on NPM! This update introduces a new component: Nested Donut (aka Sunburst). It also adds better support for accessibility features, allows you to apply additional styles to axes, and much more.

## Release Highlights [](#release-highlights "Direct link to Release Highlights")

###  New component: _Nested Donut_[](#--new-component-nested-donut "Direct link to --new-component-nested-donut")

_Nested Donut_ is a captivating graphical representation that displays hierarchical data in a circular format. Its nested design allows for multiple concentric rings, each representing a different level of data, enabling users to explore relationships and proportions effortlessly.

Check out _Nested Donut_'s documentation and example to learn how to use it.



###  Accessibility: Supporting ARIA tags [](#--accessibility-supporting-aria-tags "Direct link to   Accessibility: Supporting ARIA tags")

You can now set the `aria-label` attribute for your visualization by providing the `ariaLabel` config property to the container you use. Unovis will automatically apply `role="figure"` attribute to the container element, making it accessible to assistive technologies.



###  New CSS variables for styling Axis [](#--new-css-variables-for-styling-axis "Direct link to   New CSS variables for styling Axis")

If you want to customize the width of your tick and grid lines, you can do so using the new `--vis-axis-tick-line-width` and `--vis-axis-grid-line-width` variables.

The color of the domain line by default equals the tick color (that can be specified with `--vis-axis-tick-color`), but _Unovis 1.2_ allows you to explicitly set it via `--vis-axis-domain-color`.

Additionally you can apply custom `cursor` and `text-decoration` to your tick labels with `--vis-axis-tick-label-cursor` and `--vis-axis-tick-label-text-decoration` variables.



## Other changes [](#other-changes "Direct link to Other changes")

### Enhancements [](#enhancements "Direct link to Enhancements")

- Component | LeafletMap: Adding `getExpandedCluster` public method #205
- Component | Line: Better enter transition for broken lines #227
- Component | Scatter: Fixing the missing points issue #227
- Component | Scatter: Stroke color and width support #232

### Bug Fixes [](#bug-fixes "Direct link to Bug Fixes")

- Container | XY: Calling render right after initialization if there are axes or components with data #212
- @unovis/svelte: Updating component lifecycles to prevent DOM related errors with SvelteKt (SSR) #216

### Other [](#other "Direct link to Other")

- Core: Using native ResizeObserver when available #209
- Dependencies: Updating Dagre packages to work with Angular 16 #210

## Release 1.1

April 20, 2023 · 3 min read



Nikita Rokotyan

Creator, Key Contributor



Rebecca Bol

Maintainer, Key Contributor

We're excited to announce the release of _Unovis_ `1.1.0`! This update brings new features, enhancements, and bug fixes that improve the overall user experience and stability of the library.

## Release Highlights [](#release-highlights "Direct link to Release Highlights")

###  ELK support for Graph [](#-elk-support-for-graph "Direct link to -elk-support-for-graph")

We've added ELK integration to our Graph component. Now you can render complex hierarchical graphs ELK is famous for! 

###  New component: Multi-Level Chord Diagram [](#--new-component-multi-level-chord-diagram "Direct link to   New component: Multi-Level Chord Diagram")

_Multi-Level Chord Diagram_ can display hierarchical relationships and interactions between multiple entities, often used to visualize complex systems or networks. It showcases the flow of data or connections between different levels, allowing users to understand the intricacies of interconnected components and their relative importance within the system. 

###  Goodbye `lodash`[](#-goodbye-lodash "Direct link to -goodbye-lodash")

_Unovis_ doesn't have `lodash` as it's dependency anymore saving precious 90KB (unzipped) of your app bundle! 

## Changelog [](#changelog "Direct link to Changelog")

### New Features [](#new-features "Direct link to New Features")

- Component | Graph: ELK Support by @rokotyan #161
- Chord Diagram: Refactoring, Docs, Examples by @reb-dev #105

### Enhancements [](#enhancements "Direct link to Enhancements")

- Goodbye lodash by @rokotyan #100
- Component | Timeline: Fixing odd rows fill color by @rokotyan #145
- Component | LeafletMap: Calling fitView and fitToPoints in the next frame by @rokotyan #148
- Code Quality: Enabling strictFunctionTypes by @rokotyan #158
- React | Tweaks: Supporting style and className; Removing @emotion/css dependency by @rokotyan #162
- Component | LeafletMap | Styles: Updating MapLibreArcticLight style by @rokotyan #165
- Component | LeafletMap: Configurable inner label color by @rokotyan #156
- Component | Chord Diagram: Better accessor support for non-leaf nodes by @reb-dev #160
- Website: Updating Docusaurus and fixing editUrl by @rokotyan #175
- Container | Core, Single: Setting SVG size in render() by @rokotyan #174

### Bug Fixes [](#bug-fixes "Direct link to Bug Fixes")

- Component | Graph | Link fixes by @reb-dev #151
- React: Fixing double-render on component initialization by @rokotyan #154
- React: Fixing component initialization flow by @rokotyan #164
- Component | Chord Diagram: Fixing invisible nodes by @reb-dev #169

### Other [](#other "Direct link to Other")

- Misc tweaks and fixes by @rokotyan #168

## Announcing Unovis 1.0

December 12, 2022 · One min read



Nikita Rokotyan

Creator, Key Contributor



Rebecca Bol

Maintainer, Key Contributor



### We’re excited to announce Unovis 1.0 - a modular data visualization framework for React, Angular, Svelte, and vanilla TypeScript or JavaScript! [](#were-excited-to-announce-unovis-10---a-modular-data-visualization-framework-for-react-angular-svelte-and-vanilla-typescript-or-javascript "Direct link to We’re excited to announce Unovis 1.0 - a modular data visualization framework for React, Angular, Svelte, and vanilla TypeScript or JavaScript!")

After more than 3 years in development, _Unovis_ finally goes open source. _Unovis_ can draw charts, maps and network graphs, no matter what UI framework you use. We’ve been using it extensively at F5 with Angular and React apps, and it now empowers user interfaces of F5 Distributed Cloud console and NGINX Controller.

### Why Unovis? [](#why-unovis "Direct link to Why Unovis?")

-  Integrates nicely with the UI framework of your choice, making it very easy to use;
-  Supports various charts, simple and detailed maps, network graphs and diagrams;
-  Highly customizable, thanks to the extensive use of CSS variables;
-  Extensive documentation and growing gallery of examples.

### Want to give it try? [](#want-to-give-it-try "Direct link to Want to give it try?")

Go to unovis.dev, check out the docs, explore the gallery, or jump right into development with our Quick Start guide.