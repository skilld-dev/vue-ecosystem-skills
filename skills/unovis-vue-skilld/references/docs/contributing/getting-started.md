---
title: "Getting Started | Unovis"
meta:
  "og:description": Requirements
  "og:title": "Getting Started | Unovis"
  description: Requirements
---

## Requirements [](#requirements "Direct link to Requirements")

Minimum requirements: npm (v7 or above) and Node.js (v12 or above).

## Installing Dependencies [](#installing-dependencies "Direct link to Installing Dependencies")

Once you clone and open the repo in the IDE of your choice, first install the dependencies:

```
npm install
```

If any dependency-related issues arise, try a clean install:

```
npm run install:clean
```

## Local Development [](#local-development "Direct link to Local Development")

### Demo App [](#demo-app "Direct link to Demo App")

If you're making changes to the core library `@unovis/ts`, we recommend creating at least one example using our local demo app to visually test your changes. Add the example to `packages/dev/src/examples` in the appropriate category folder.

To start the development server for the demo app, run the command:

```
npm run dev
```

### Website [](#website "Direct link to Website")

To start the development server for the website, run the command:

```
npm run website
```

### Framework Apps [](#framework-apps "Direct link to Framework Apps")

Each framework wrapper* has a demo app to verify our gallery examples work as expected. To run the app for a specific framework, navigate to that directory within `packages` and run the command:

```
npm run gallery
```

- [Requirements](#requirements)
- [Installing Dependencies](#installing-dependencies)
- [Local Development](#local-development)
  - [Demo App](#demo-app)
  - [Website](#website)
  - [Framework Apps](#framework-apps)