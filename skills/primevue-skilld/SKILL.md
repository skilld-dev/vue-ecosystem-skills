---
name: primevue-skilld
description: Use when writing, debugging, or updating code that imports primevue (PrimeVue v5, UI component library for Vue 3). Provides setup with the required PrimeUI license key, deprecated API replacements, compound component usage, and design token theming.
---

# PrimeVue (`primevue@5.0.1`)

Version 5.0.1, prepared source `input/source/package.json`. UI component library for Vue 3.
Docs: https://primevue.dev (component pages live at `https://primevue.dev/<name>`, e.g. `https://primevue.dev/inputtags/`).

## Critical v5 facts

1. **License key required.** v5 ships under the PrimeUI dual license (free Community or paid Commercial). Pass the key as a `license` string option when installing the plugin. Verification is offline; a missing, invalid, or expired key may display a license notice (`input/source/LICENSE.md`).
2. **No breaking public API changes from v4**, per the official migration guide (https://primevue.dev/migration/v5/). Deprecated v4 APIs still work in v5 and are removed in v6. Write new code against the replacements in [v5 changes](references/v5-changes.md).
3. **16px root font base.** v5 assumes a 16px document root; v4 assumed 14px. Every preset ships a `-compat` variant for 14px layouts, maintained until June 2027 (https://primevue.dev/theming/styled/).
4. **Config plugin.** Install once with `app.use`. The default export of `primevue/config` is also re-exported as `Config` from the package root (`input/source/index.mjs:139`).

## Setup

```js
// main.js
import { createApp } from 'vue';
import PrimeVue from 'primevue/config'; // or: import { Config } from 'primevue'
import Aura from '@primeuix/themes/aura';
import App from './App.vue';

const app = createApp(App);
app.use(PrimeVue, {
    license: '<your PrimeUI license key>',
    ripple: true, // optional, disabled by default
    theme: {
        preset: Aura,
        options: {
            darkModeSelector: '.app-dark' // default is 'system'
        }
    }
});
```

Details: theme options, locale, unstyled mode, Nuxt module, auto import in [setup](references/setup.md).

## Import patterns

```vue
<script setup>
// Tree-shakeable subpath imports (package.json exports map "./*")
import Button from 'primevue/button';
import Select from 'primevue/select';
// Style classes for a component (design token CSS)
import SelectStyle from 'primevue/select/style';
</script>
```

- Root import `from 'primevue'` also works and exports every component, style, service, and composable (`input/source/index.mjs`).
- Icons: SVG icon components come from `@primeicons/vue` (dependency `^8.0.0` in `input/source/package.json`). The `@primevue/icons` package is deprecated in v5.

## Golden rules

- **Never use a deprecated component in new code.** Deprecated in v5 (removal in v6): `MultiSelect`, `Galleria`, `Image`, `ColorPicker`, `ImageCompare`, `ScrollPanel`, `Password`, `InputMask` (component), `PanelMenu`, `Chart`, `Editor`, `AutoComplete` with `multiple`, `Carousel` driven by `value`, `Tabs` `scrollable`. Use the replacement table in [v5 changes](references/v5-changes.md).
- **Buttons compose content in the default slot.** `label`, `icon`, `iconPos`, `iconClass`, `badge`, `badgeClass`, `badgeSeverity`, `loading`, `loadingIcon` props are all deprecated since v5.0.0 (`input/source/button/index.d.ts`).
- **Compound components over prop-driven templates**: `Tabs`/`TabList`/`Tab`/`TabPanels`/`TabPanel`, `Accordion`/`AccordionPanel`/`AccordionHeader`/`AccordionContent`, `Stepper` family, `Sidebar` family, `Gallery` family, `Carousel` family. Active state binds with `v-model:value` (Accordion's `activeIndex` prop and events were removed in v5).
- **Overlays are Teleport-based**: set `appendTo="body"` (default) or `"self"`; most overlay components accept `overlayStyle`/`overlayClass` (panel* props were removed in v5).
- **Prefer design tokens over CSS overrides**: use `dt` prop for scoped tokens and preset customization via `definePreset` instead of `:deep()` or style classes (https://primevue.dev/theming/styled/).

## Common tasks

### Button (slot composition)

```vue
<Button severity="contrast" size="small">
    <i class="pi pi-check" />
    <span>Confirm</span>
    <Badge value="2" />
</Button>
```

Icon order in the slot replaces `iconPos`; use `disabled` plus your own spinner instead of `loading`.

### Multiple selection (replaces MultiSelect)

```vue
<Select v-model="selectedCities" multiple :options="cities" optionLabel="name" fluid />
```

`multiple` on `Select` ("When specified, allows selecting multiple values", `input/source/select/index.d.ts`).

### Tags input (replaces AutoComplete multiple)

```vue
<InputTags v-model="tags" typeahead :suggestions="suggestions" @complete="search" delimiter="," />
```

Key props: `max`, `allowDuplicate`, `addOnBlur`, `addOnPaste`, `addOnTab`, `delimiter` (string or RegExp). Emits `add`, `remove`, `option-select`, `complete` (`input/source/inputtags/index.d.ts`).

### Toast service

```js
// main.js: app.use(ToastService)
import { useToast } from 'primevue/usetoast';
const toast = useToast();
toast.add({ severity: 'info', summary: 'Saved', life: 3000 });
```

Service methods: `add`, `remove`, `removeGroup`, `removeAllGroups` (`input/source/toastservice/index.d.ts`). Same pattern for `ConfirmationService` + `useConfirm` and `DialogService` + `useDialog` (dynamic dialogs).

### Mask directive (replaces InputMask component)

```vue
<InputText v-mask="{ mask: '99-9999', unmask: true }" v-model="value" />
```

Options: `mask`, `slotChar` (default `_`), `autoClear` (default true), `unmask`, `onChange` receiving `{ value, rawValue }` (`input/source/mask/index.d.ts`).

### App sidebar (compound)

```vue
<SidebarLayout>
    <SidebarAside>
        <SidebarHeader>…</SidebarHeader>
        <SidebarContent>
            <SidebarGroup>
                <SidebarGroupLabel>Admin</SidebarGroupLabel>
                <SidebarGroupContent>
                    <SidebarMenu>
                        <SidebarMenuItem><SidebarMenuButton>Users</SidebarMenuButton></SidebarMenuItem>
                    </SidebarMenu>
                </SidebarGroupContent>
            </SidebarGroup>
        </SidebarContent>
        <SidebarFooter>…</SidebarFooter>
    </SidebarAside>
    <SidebarMain><RouterView /></SidebarMain>
</SidebarLayout>
```

`Sidebar` inside a `SidebarLayout` requires a unique `id`; supports `side`, `variant` (`sidebar|floating|inset`), `collapsible` (`offcanvas|icon|none`), `v-model:open`, `openOnHover`, `overlay`, `width` (`input/source/sidebar/index.d.ts`). Full part list in [components](references/components.md).

### Form fields

- `FloatLabel`, `IftaLabel` (in-field label), or plain `Label`.
- Wrap a region in `<Fluid>` for full-width inputs instead of `fluid` on each field.
- `invalid` prop on any input drives the error style; validation state via `@primevue/forms` (separate package, https://primevue.dev/forms/).

### DataTable performance

With `dataKey` set, bind `expandedRows` to an object (`{ '1004': true }`) rather than an array of row objects for O(1) lookup on large data (official DataTable docs). Persist user preferences with `stateStorage` + `stateKey`.

## References

- [Setup and configuration](references/setup.md): install, license, theme presets, dark mode, locale, unstyled mode, Nuxt.
- [v5 changes and migration](references/v5-changes.md): deprecation and removal tables with replacements.
- [Components and replacements](references/components.md): compound families, new v5 components, services, utilities.
