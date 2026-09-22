# v5 changes and migration

Prime source: official migration guide https://primevue.dev/migration/v5/ (PrimeVue 5.0.1). Each row below is also evidenced by `@deprecated` JSDoc markers in the prepared package `input/source`.

## Headline changes

- v5 is the first release under the PrimeUI umbrella; licensing moved to a dual Community/Commercial model. No other breaking changes to public component APIs: existing v4 apps upgrade without code edits.
- Base font size assumption changed from 14px to 16px; `-compat` presets cover 14px layouts until June 2027.
- `InputMask` is now a directive (`Mask`) rather than a component.
- `Carousel` was rebuilt around a compound API; `Menu` supports multi-level navigation; `Toast` gained new entry/exit animations.
- Chart and Editor moved to PrimeUI PRO (https://vue.primeuipro.dev/).

## Deprecated in v5 (functional, removal in v6)

| Deprecated API | Replacement | Prepared source evidence |
| --- | --- | --- |
| `MultiSelect` | `Select` with `multiple` | `config/index.d.ts` PT note; `select/index.d.ts` `multiple` prop |
| `Galleria` | `Gallery` | `config/index.d.ts` |
| `Image` | `Gallery` | `image/index.d.ts`: "deprecated since v5.0. Use Gallery instead." |
| `ColorPicker` | `InputColor` | `config/index.d.ts` |
| `ImageCompare` | `Compare` | `imagecompare/index.d.ts` |
| `ScrollPanel` | `ScrollArea` | `scrollpanel/index.d.ts` |
| `Password` | `InputPassword` | `password/index.d.ts` |
| `InputMask` component | `Mask` directive | `inputmask/index.d.ts` |
| `PanelMenu` | `Menu` with `toggleable` option | `panelmenu/index.d.ts` |
| `Chart` | PrimeUI PRO Charts | `chart/index.d.ts` |
| `Editor` | PrimeUI PRO Text Editor | `editor/index.d.ts` |
| `@primevue/icons` package | SVG icons via `@primeicons/vue` | migration guide; `package.json` dep |
| `AutoComplete` `multiple` | `InputTags` with `typeahead` | `autocomplete/index.d.ts` on `multiple` |
| `Button` `label`, `icon`, `iconPos`, `iconClass` | icon and label content in the default slot, ordered as needed | `button/index.d.ts` (deprecated since v5.0.0) |
| `Button` `badge`, `badgeClass`, `badgeSeverity` | compose a `Badge` in the default slot | `button/index.d.ts` |
| `Button` `loading`, `loadingIcon` | own spinner in the default slot + `disabled` | migration guide |
| `Tabs` `scrollable` | scrolling is automatic when necessary | migration guide |
| `Carousel` `value` (data-driven) | compound API: `CarouselContent`, `CarouselItem`, `CarouselIndicators` (+ `CarouselPrev`/`CarouselNext`) | `carousel/index.d.ts` on `value` |

Migration advice: keep deprecated usage running during upgrade, then swap component by component; all replacements exist in the same `primevue` package at the same version.

## Removed in v5 (deprecated in v4)

Renamed or replaced components:

| Removed | Use |
| --- | --- |
| `Calendar` | `DatePicker` |
| `Dropdown` | `Select` |
| `Chips`, `InputChips` | `InputTags` |
| `InputSwitch` | `ToggleSwitch` |
| `OverlayPanel` | `Popover` |
| `TabView` | `Tabs` family |
| `TabMenu` | `Tabs` without `TabPanels` |
| `AccordionTab` | `AccordionPanel`/`AccordionHeader`/`AccordionContent` |
| `v-badge` (BadgeDirective) | `OverlayBadge` |
| `InlineMessage` | `Message` |

Removed props, slots, and APIs (highlights from the official removal table):

- `Accordion`: `activeIndex` prop and `update:activeIndex`, `tab-open`, `tab-close`, `tab-click` events; use `value` prop and `update:value`.
- `Button`: `plain` prop; use `severity="contrast"`.
- Config `inputStyle`; use `inputVariant`.
- `CascadeSelect`, `Select`: `panelStyle`/`panelClass`(/`panelProps`); use `overlayStyle`/`overlayClass`(/`overlayProps`).
- `InputNumber`: `incrementButtonIcon`/`decrementButtonIcon`; use `incrementIcon`/`decrementIcon`.
- Many icon slots renamed to drop the "icon" suffix pattern: e.g. `AutoComplete` `loadingicon` to `loader`, `TreeSelect` `triggericon` to `dropdownicon`, `Menubar`/`MegaMenu` `menubuttonicon` to `buttonicon`, `Toast` `icon` to `messageicon`, `Panel`/`Fieldset` `togglericon` to `toggleicon`, `Paginator` `firstpagelinkicon` etc. to `firsticon`/`previcon`/`nexticon`/`lasticon`, `SplitButton` `menubuttonicon` to `dropdownicon`, `OrderList`/`PickList` `item` to `option`.
- `AutoComplete`: `removeTokenIcon` prop/slot to `chipIcon`/`chipicon`; `item-select`/`item-unselect` events to `option-select`/`option-unselect`.
- `Message`: `sticky` prop; use `life` for auto-close.
- `TabPanel`: TabView-era header/content props; use the Tabs structure.
- Utilities: `UniqueComponentId` from `@primevue/core/utils`; use `uuid` from `@primeuix/utils`.
- Instance getters: `hasFluid` to `$fluid`; `filled` to `$filled`. Root element `$pc` marker removed.
- Theming: `switchTheme` function; use `usePreset` and related APIs. `primevue/themes` presets moved to `@primeuix/themes`.
- Nuxt: `nuxt-primevue`; use `@primevue/nuxt-module`.

Full removal table: https://primevue.dev/migration/v5/.
