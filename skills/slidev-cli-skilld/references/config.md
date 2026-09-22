# Headmatter and Frontmatter Configuration

Source: shipped skill references and https://sli.dev/custom/. Headmatter (first
frontmatter block) configures the deck; per-slide frontmatter configures one slide.

## Headmatter

### Theme and appearance

```yaml
---
theme: default              # theme package name or local path
colorSchema: auto           # auto | light | dark
aspectRatio: 16/9
canvasWidth: 980            # canvas width in px
favicon: /favicon.ico
transition: slide-left      # default transition for all slides
---
```

### Fonts

```yaml
---
fonts:
  sans: Roboto
  serif: Roboto Slab
  mono: Fira Code
  provider: google          # google | none
---
```

### Code and highlighting

```yaml
---
highlighter: shiki
lineNumbers: false          # line numbers on all code blocks
monaco: true                # true | 'dev' | 'build'
twoslash: true
magicMoveDuration: 1000     # Magic Move duration, ms
shiki:
  magicMove:
    easing: ease-in-out
    stagger: 5
---
```

### Features

```yaml
---
drawings:
  enabled: true
  persist: false
  presenterOnly: false
  syncAll: true
record: dev                 # recording in dev only
selectable: true
contextMenu: true
wakeLock: true
comark: true                # Comark attribute syntax
mcp: true                   # set false to disable the MCP server
---
```

### Export and build

```yaml
---
download: false             # PDF download button in built SPA
exportFilename: slides
export:
  format: pdf
  timeout: 30000
  withClicks: false
  withToc: false
remoteAssets: false         # download remote assets locally at build
plantUmlServer: https://www.plantuml.com/plantuml
---
```

### Info and SEO

```yaml
---
title: My Presentation
titleTemplate: '%s - Slidev'
author: Your Name
keywords: slidev, presentation
info: |
  ## About
  Description with markdown.
seoMeta:
  ogTitle: Presentation Title
  ogDescription: Description
  ogImage: https://example.com/og.png
  twitterCard: summary_large_image
---
```

### Presenter and routing

```yaml
---
presenter: true             # true | 'dev' | 'build'
browserExporter: dev        # true | 'dev' | 'build'; gates /export/ page
routerMode: history         # history | hash
---
```

### Addons and theme config

```yaml
---
addons:
  - excalidraw
themeConfig:
  primary: '#5d8392'        # keys are theme-specific
defaults:                   # default frontmatter for all slides
  layout: default
  transition: fade
htmlAttrs:
  lang: en
  dir: ltr
---
```

## Per-slide frontmatter

### Layout and looks

```yaml
---
layout: two-cols           # see components-layouts.md for the list
background: /image.jpg
backgroundSize: cover
class: 'text-center text-white'
zoom: 0.8                   # scale whole slide content
---
```

### Clicks and transitions

```yaml
---
clicks: 5                  # total click count for this slide
clicksStart: 0             # starting click number
transition: fade           # or 'slide-left | slide-right' (forward | backward)
---
```

### Visibility and TOC

```yaml
---
hide: true                 # skip this slide (disabled: true also works)
hideInToc: true            # hide from the Toc component
level: 2                   # heading level for TOC nesting
title: Custom Title        # override slide title in TOC/presenter
routeAlias: intro          # serve at /intro instead of /N
preload: false             # do not mount until entered
---
```

### Importing and dragging

```yaml
---
src: ./pages/intro.md      # also supports #2,5-7 ranges
dragPos:
  logo: 100,50,200,100,0   # Left,Top,Width,Height,Rotate
  arrow: 300,200,50,50,45
---
```

### Layout props

Image and iframe layouts take props in frontmatter:

```yaml
---
layout: image-right
image: /photo.jpg
class: my-class
---
```

```yaml
---
layout: iframe
url: https://example.com
---
```
