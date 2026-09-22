# Styling and theming

## Color palette

- `colors` (light) and `colorsDark` arrays (`styles/colors.d.ts`) drive the
  default palette.
- Components receive palette colors through CSS variables: `getCSSColorVariable(i)`
  returns `--vis-color<N>`. Dark palette is stored as `--vis-dark-color<N>`
  (`styles/index.js`).
- A `color` accessor returning `null`/`undefined` falls back to the palette
  slot assigned by the container (`utils/color.d.ts`, `getColor`).
- `UnovisColorScale` (exported ordinal scale pre-filled with the palette) for
  custom mappings; container-level `colorFunction: (key) => string` overrides
  palette resolution for all components (`core/container/config.d.ts`).
- Helpers: `getLighterColor(hex, percentage?)`, `getDarkerColor(hex, pL?, pS?)`,
  `isColorDark(color, threshold?)`, `brighter(color, amount)`
  (`styles/colors.d.ts`, `utils/color.d.ts`).

## CSS variables

All Unovis styling hooks are `--vis-*` CSS custom properties, injected
globally at import time via `@emotion/css` (`styles/index.js`). Override them
on `:root` or any ancestor of the chart element:

```css
:root {
  --vis-color0: #2596be;
  --vis-font-family: 'MyFont', sans-serif;
}
```

Base variables include `--vis-font-family` (default `Inter, Arial,
"Helvetica Neue", Helvetica, sans-serif`), `--vis-font-wh-ratio`,
`--vis-color-grey`, `--vis-color-main[-light|-dark]`
(`styles/index.js`). Components add their own, e.g. `--vis-line-cursor`,
`--vis-line-stroke-dasharray`, `--vis-line-gapfill-stroke-dasharray`
(`components/line/style.js`).

Runtime font/text defaults are read from `globalThis` before falling back:
`UNOVIS_ICON_FONT_FAMILY` (default `FontAwesome`),
`UNOVIS_TEXT_DEFAULT_FONT_SIZE` (default `12`),
`UNOVIS_FONT_W2H_RATIO_DEFAULT`, `UNOVIS_TEXT_SEPARATOR_DEFAULT`,
`UNOVIS_TEXT_HYPHEN_CHARACTER_DEFAULT`, `UNOVIS_TEXT_DEFAULT` — set them on
`globalThis` before first render to change text measurement globally
(`styles/index.js`).

## Dark theme

The dark palette activates automatically when any of these selectors match
(`utils/theme.d.ts`, injected in `styles/index.js`):

```
html[data-theme="dark"], html.dark-theme, body.dark-theme, html.theme-dark, body.theme-dark
```

When one matches, `--vis-color<N>` variables resolve to the
`--vis-dark-color<N>` values. To support other schemes, apply one of these
classes/attributes, or override the `--vis-color<N>` variables yourself.
`isDarkThemeEnabled()` (exported from `utils/style.d.ts`) reports the
current state. Guide: https://unovis.dev/docs/guides/theming

## Patterns

Fill patterns (`FillPatternType`: `StripesDiagonal`, `Dots`,
`StripesVertical`, `Crosshatch`, `Waves`, `Circles`) and line patterns
(`LinePatternType`: `Circle`, `Triangle`, `Diamond`, `Arrow`, `Square`,
`Star`) are built in (`styles/patterns.d.ts`).

Assign via the component's `pattern` accessor:

```ts
import { FillPatternType, StackedBar } from '@unovis/ts'

const bar = new StackedBar<DataRecord>({
  y: [d => d.a, d => d.b],
  pattern: FillPatternType.Dots,
})
```

Patterns render by adding the class `theme-patterns` to `<body>`
(`body.theme-patterns` CSS rule in `styles/index.js`), which applies
`mask`/`marker` styling to elements carrying the
`unovis-pattern-index` attribute:

```ts
document.body.classList.add('theme-patterns')
```

Related helpers: `getPatternById`, `getFillPatternId`,
`getMarkerPatternId`, `getContextMarkerPatternId`,
`createColoredMarkerElement` (`styles/patterns.d.ts`).

## Text sizing constants

`styleLargeSize` and `styleExtraLargeSize` (`styles/sizes.d.ts`) are the
canonical font sizes for emphasized text.

## Accessibility and semantic markup

- Container `ariaLabel` config adds an `aria-label` to the chart's div
  (`core/container/config.d.ts`).
- Legends (`BulletLegend`) support `onLegendItemClick` for toggling series
  visibility, and items accept `inactive`/`hidden`/`pointer` flags.

## Content Security Policy

Styles inject at runtime through emotion; for strict CSP environments see
https://unovis.dev/docs/guides/csp before assuming a nonce-free setup works.

## Testing charts

- The library's own tests run `vitest` with `jsdom` (`package.json`
  `scripts.test`, `devDependencies`). Mirror that setup for Node-side
  render tests.
- Add stable hooks via the `attributes` config instead of relying on
  generated class names: `attributes: { [Line.selectors.line]: {
  'data-testid': 'line-0' } }` (`core/component/config.d.ts`).
- For Crosshair interactions simulated without real pointer events, set
  `skipRangeCheck: true` (`components/crosshair/config.d.ts`).
- Call `container.destroy()` in test teardown to drop ResizeObservers
  (`core/container/index.d.ts`).
