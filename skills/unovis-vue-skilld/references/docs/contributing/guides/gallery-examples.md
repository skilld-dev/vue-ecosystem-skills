---
title: "Adding an example to the Gallery | Unovis"
meta:
  "og:description": "We welcome anyone to submit an example to our gallery."
  "og:title": "Adding an example to the Gallery | Unovis"
  description: "We welcome anyone to submit an example to our gallery."
---

## Overview [](#overview "Direct link to Overview")

Add your example to the website in the directory `packages/website/src/examples`. Before submitting a pull request, make sure you have done the following:

- Made a directory with all of the [required files](#required-files)
- Updated the list of examples in `examples-list.tsx` to include yours
- Added light and dark screenshots of your example to the `_previews` directory as `png` files
- Verified the example works in each of our supported UI frameworks (how-to guide [here](#testing-each-framework))

## Required Files [](#required-files "Direct link to Required Files")

Your directory should be called `your-example-name`. In it, you will need to have files for all of our supported UI frameworks (angular, react, svelte and vanilla typescript) as well as a `data` and `index` file. The structure looks like:

```
your-example├── data.ts├── index.tsx├── your-example.component.html # ┓├── your-example.component.ts   # ┠ angular├── your-example.module.ts      # ┛├── your-example.svelte         # svelte├── your-example.ts             # typescript├── your-example.tsx            # react
```

#### What to include in `index.tsx`[](#what-to-include-in-indextsx "Direct link to what-to-include-in-indextsx")

All example index files look roughly the same, you will just need to fill in the highlighted lines. You can copy and paste the following:

```
/* eslint-disable import/no-unresolved, import/no-webpack-loader-syntax, @typescript-eslint/no-var-requires */import React from 'react'import BrowserOnly from '@docusaurus/BrowserOnly'import { Example } from '@site/src/types/example'const pathname = ''const example: Example = {  component: () => <BrowserOnly>{() => {    // eslint-disable-next-line @typescript-eslint/naming-convention    const Component = require(\`./${pathname}.tsx\`).default    return <Component />  }}</BrowserOnly>,  pathname,  title: '',  description: <div></div>,  codeReact: require(\`!!raw-loader!./${pathname}.tsx\`).default,  codeTs: require(\`!!raw-loader!./${pathname}.ts\`).default,  codeAngular: {    html: require(\`!!raw-loader!./${pathname}.component.html\`).default,    component: require(\`!!raw-loader!./${pathname}.component.ts\`).default,    module: require(\`!!raw-loader!./${pathname}.module.ts\`).default,  },  codeSvelte: require(\`!!raw-loader!./${pathname}.svelte\`).default,  data: require('!!raw-loader!./data').default,  preview: require(\`../_previews/${pathname}.png\`).default,  previewDark: require(\`../_previews/${pathname}-dark.png\`).default,}export default example
```

note

- **pathname** should correspond to your directory name
- **title** should reference the library component(s) your using
- **description** should be a brief description of your visualization with any data sources cited

## Testing each framework [](#testing-each-framework "Direct link to Testing each framework")

Before you submit a pull request, be sure you have verified that the example works for each framework on your local machine. In the `packages/website` directory, you can view your example by following the steps below:

### React [](#react "Direct link to React")

1. Run the command

```
npm run start
```

1. Open localhost:9300 and navigate to your example's page

### TypeScript [](#typescript "Direct link to TypeScript")

Same steps above, but add `&ts` to the end of the url.

### Svelte [](#svelte "Direct link to Svelte")

1. Add your example's `svelte` file path to the `imports` array in `src-demo/svelte-gallery.svelte`
2. From the terminal, run the command

```
cd packages/sveltenpm run gallery
```

### Vue [](#vue "Direct link to Vue")

1. Add your example's `vue` file path to the `imports` array in `src-demo/App.vue`
2. From the terminal, run the command

```
cd packages/vuenpm run gallery
```

### Solid [](#solid "Direct link to Solid")

1. Add your example's `-solid.tsx` file path to the `imports` array in `src-demo/app.tsx`
2. From the terminal, run the command

```
cd packages/solidnpm run gallery
```

### Angular [](#angular "Direct link to Angular")

1. Import your angular module in `gallery/src/main.ts`
2. Add the imported module to the `imports` field in the `NgModule` decorator:

```
@NgModule({declarations: [AppComponent],imports: [... /* your angular module here */],bootstrap: [AppComponent],providers: [BrowserModule],})
```

1. Add the example component's selector to the `Component` decorator's `template` field:

```
@Component({  selector: 'app-component',  template: \`    ...      \`})
```

1. From the terminal, run the command

```
cd packages/angularnpm run gallery
```

- [Overview](#overview)
- [Required Files](#required-files)
- [Testing each framework](#testing-each-framework)
  - [React](#react)
  - [TypeScript](#typescript)
  - [Svelte](#svelte)
  - [Vue](#vue)
  - [Solid](#solid)
  - [Angular](#angular)