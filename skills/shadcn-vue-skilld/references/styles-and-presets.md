# Styles and presets

Source: `dist/registry-hxzbzXMt.js:3141-3244` (named presets), `dist/transform-menu-CLNZ5vUh.js:5-46` (bases, styles), `:415-443` (base colors), `dist/preset/index.d.ts:2-12` (preset code vocabularies), `dist/icons/index.d.ts:2-43` (icon libraries).

## Base

One component library base: `reka` (Reka UI, dependency `reka-ui`).

## Named presets

Preset names carry no prefix in 2.8.x (`-p vega`, not `-p reka-vega`). Each preset fixes style, icons, and font:

| Preset | Style | Icons | Font |
| --- | --- | --- | --- |
| `vega` | Vega | lucide | inter |
| `nova` | Nova | lucide | geist-sans |
| `maia` | Maia | hugeicons | figtree |
| `lyra` | Lyra | phosphor | jetbrains-mono |
| `mira` | Mira | hugeicons | inter |
| `luma` | Luma | lucide | inter |
| `sera` | Sera | lucide | noto-sans |

All named presets default to `baseColor: neutral`, `theme: neutral`, `fontHeading: inherit`, `menuAccent: subtle`, `menuColor: default`, `radius: default`, `rtl: false`.

## Visual styles

Seven styles ship in the CLI constants: `vega` (classic shadcn/ui look), `nova` (compact), `maia` (soft, rounded, generous spacing), `lyra` (boxy, sharp, pairs with mono fonts), `mira` (dense interfaces), `luma` (fluid, luminous, glassy), `sera` (editorial, typographic).
An eighth style, `rhea`, is valid inside encoded preset codes (`dist/preset/index.d.ts:3`) but has no named preset; pick it via the builder at https://shadcn-vue.com/create.

## Encoded preset codes

`shadcn-vue/preset` exports `encodePreset`, `decodePreset`, `isPresetCode`, `isValidPreset`, `generateRandomPreset` (`dist/preset/index.d.ts:29-34`). Codes are base62 strings accepted anywhere a preset name is: `init -p <code>` and `apply <code>`.

Vocabulary inside a code (`dist/preset/index.d.ts:4-12`):

- styles: the seven above plus `rhea`
- base colors: `neutral`, `stone`, `zinc`, `mauve`, `olive`, `mist`, `taupe`
- themes: the seven base colors plus 17 accent hues (amber to yellow)
- chart colors: same 24 as themes
- icon libraries: `lucide`, `tabler`, `hugeicons`, `phosphor`, `remixicon`
- fonts and heading fonts: 24 values, `inherit` allowed for heading
- radius: `default`, `none`, `small`, `medium`, `large`
- menu accent: `subtle`, `bold`; menu color: `default`, `inverted`, `default-translucent`, `inverted-translucent`

The `init --base-color` help text lists older names (`neutral, gray, zinc, stone, slate`) because the live registry decides availability (`getRegistryBaseColors`); for preset codes only the seven above decode.

## Icon libraries

| Library | Package(s) | Usage |
| --- | --- | --- |
| `lucide` | `@lucide/vue` | `<IconName />` |
| `tabler` | `@tabler/icons-vue` | `<IconName />` |
| `hugeicons` | `@hugeicons/vue`, `@hugeicons/core-free-icons` | `<HugeiconsIcon :icon="IconName" :stroke-width="2" />` |
| `phosphor` | `@phosphor-icons/vue` | `<IconName :stroke-width="2" />` |
| `remixicon` | `@remixicon/vue` | `<IconName />` |

Registry items hardcode icon imports for their source library. The CLI rewrites dependency lists to your chosen library and `migrate icons` rewrites existing components (`dist/transform-menu-CLNZ5vUh.js:476-500`). `lucide-vue-next` is the legacy lucide package name.

## Fonts

Font names usable in `init --font` and preset codes (`dist/preset/index.d.ts:7-8`):
`inter`, `geist-sans`, `noto-sans`, `nunito-sans`, `figtree`, `roboto`, `raleway`, `dm-sans`, `public-sans`, `outfit`, `jetbrains-mono`, `playfair-display`, `oxanium`, `manrope`, `space-grotesk`, `montserrat`, `ibm-plex-sans`, `source-sans-3`, `instrument-sans`, `geist-mono`, `noto-serif`, `roboto-slab`, `merriweather`, `lora`.

Fonts are Google Fonts; the registry supplies the `@import`, family, and CSS variable (`--font-sans`) for each (`dist/transform-menu-CLNZ5vUh.js:48-70`).
