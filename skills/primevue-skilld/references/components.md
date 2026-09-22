# Components and replacements

Export inventory: `input/source/index.mjs` (also `index.d.ts`). Component docs at `https://primevue.dev/<name>/`.

## New in v5

| Component | Purpose | Key API (prepared source) |
| --- | --- | --- |
| `CommandMenu` | Searchable command palette menu | `model` (`CommandMenuItem[]`; leaf items support `command`, `disabled`, `keywords`), `search`, `filter`, `placeholder`, `emptyMessage`, `emptyFilterMessage` (`commandmenu/index.d.ts`) |
| `Compare` | Slider that compares two views | `v-model` number position, `min`, `max`; parts `CompareItem`, `CompareHandle`, `CompareIndicator` (`compare/index.d.ts`) |
| `Gallery` | Media gallery with lightbox (replaces `Galleria` and `Image` preview) | `v-model:activeIndex`, `fullscreen`, `closeOnEscape` (`gallery/index.d.ts`) |
| `InputTags` | Tag input with optional typeahead (replaces `AutoComplete` `multiple`) | `modelValue: string[]`, `typeahead`, `suggestions`, `delimiter`, `max`, `allowDuplicate`, `addOnBlur`, `addOnPaste`, `addOnTab`, `minLength`, `delay`; emits `add`, `remove`, `option-select`, `complete` (`inputtags/index.d.ts`) |
| `InputPassword` | Minimal password input with controllable mask state (replaces `Password`) | `v-model`, `v-model:mask` (default masked), no built-in meter or toggle UI; emits `update:mask` (`inputpassword/index.d.ts`) |
| `InputColor` | Color picker with composable parts (replaces `ColorPicker`) | `v-model` string, `format` default `'hsba'` (`InputColorFormat`); parts `InputColorArea`, `InputColorSlider`, `InputColorSwatch`, `InputColorEyeDropper`, `InputColorInput`, each with subparts (`inputcolor/index.d.ts`) |
| `Sidebar` family | Headless app sidebar compound (not the old overlay drawer, which is `Drawer`) | `Sidebar` requires unique `id` inside a `SidebarLayout`; `side` (`left|right`), `variant` (`sidebar|floating|inset`), `collapsible` (`offcanvas|icon|none`, default `icon`), `overlay`, `v-model:open`, `openOnHover`, `hoverOpenDelay` (50), `hoverCloseDelay` (100), `hideOnOutsideClick`, `width` (default `16rem`) (`sidebar/index.d.ts`) |
| `ScrollArea` | Scrollable area with styled scrollbars (replaces `ScrollPanel`) | `variant` (default `'auto'`), `mask`; parts `ScrollAreaViewport`, `ScrollAreaContent`, `ScrollAreaScrollbar`, `ScrollAreaHandle`, `ScrollAreaCorner` (`scrollarea/index.d.ts`) |
| `Mask` | Directive replacing the `InputMask` component | `v-mask="{ mask, slotChar, autoClear, unmask, onChange }"`; `onChange` receives `{ value, rawValue }` (`mask/index.d.ts`) |

Also reworked: `Carousel` compound API and multi-level `Menu` (supports nested `items` and `toggleable` groups, replacing `PanelMenu`).

## Sidebar compound parts

Layout: `SidebarLayout` (root, keeps the sidebar registry), `SidebarAside`, `SidebarMain`, `SidebarHeader`, `SidebarContent`, `SidebarFooter`.
Navigation: `SidebarGroup`, `SidebarGroupLabel`, `SidebarGroupContent`, `SidebarGroupAction`, `SidebarMenu`, `SidebarMenuItem`, `SidebarMenuButton`, `SidebarMenuAction`, `SidebarMenuBadge`, `SidebarMenuSub`, `SidebarMenuSubItem`, `SidebarMenuSubButton`.
Controls: `SidebarRail` (icon strip), `SidebarTrigger` (toggle button), `SidebarSpacer`, `SidebarPanel`, `SidebarBackdrop`, plus the standalone controlled `Sidebar`.
All exported from `primevue` root or their `primevue/sidebar*` subpaths (`input/source/index.mjs`).

## Gallery parts

`GalleryItem`, `GalleryThumbnail`, `GalleryThumbnailContent`, `GalleryThumbnailItem`, `GalleryContent`, `GalleryHeader`, `GalleryFooter`, `GalleryBackdrop`, `GalleryPrev`, `GalleryNext`, `GalleryFullScreen`, `GalleryRotateLeft`, `GalleryRotateRight`, `GalleryZoomIn`, `GalleryZoomOut`, `GalleryZoomToggle`, `GalleryDownload` (`input/source/index.mjs`).

## Carousel compound

```vue
<Carousel v-model:page="page">
    <CarouselContent>
        <CarouselItem v-for="item in items" :key="item.id">…</CarouselItem>
    </CarouselContent>
    <CarouselPrev />
    <CarouselNext />
</Carousel>
```

`value` (data array) is deprecated since v5 (`carousel/index.d.ts`); page state binds with `v-model:page`; `CarouselIndicators`/`CarouselIndicator` render the dots.

## Compound families (established in v4, current in v5)

- Tabs: `Tabs` (`v-model:value`), `TabList`, `Tab`, `TabPanels`, `TabPanel`. Without `TabPanels` it works as a semantic nav bar (pair with `router-link`; use `asChild` + `v-slot` for headless headers).
- Accordion: `Accordion` (`v-model:value`), `AccordionPanel`, `AccordionHeader`, `AccordionContent`.
- Stepper: `Stepper` (`v-model:value`), `StepList`, `Step`, `StepItem` (required in vertical layouts), `StepPanels`, `StepPanel`. `Steps` (old) still exists but prefer `Stepper`.
- Input helpers: `IconField` + `InputIcon` (decorative icons around inputs), `FloatLabel`, `IftaLabel`, `InputGroup` + `InputGroupAddon`, `Fluid`.
- Overlays: `Popover` (inline popup), `Drawer` (overlay side panel), `Dialog`, `DynamicDialog` (via `DialogService`).

## Services and composables

| Module | Provides |
| --- | --- |
| `primevue/toastservice` | `ToastService` plugin; methods `add`, `remove`, `removeGroup`, `removeAllGroups` |
| `primevue/usetoast` | `useToast(): ToastServiceMethods` |
| `primevue/dialogservice` | `DialogService` plugin for dynamic dialogs |
| `primevue/usedialog` | `useDialog(): { open(content, options?) }` |
| `primevue/confirmationservice` | `ConfirmationService` plugin for ConfirmDialog/ConfirmPopup |
| `primevue/useconfirm` | `useConfirm()` for ConfirmDialog/ConfirmPopup |
| `primevue/terminalservice` | Terminal command bus |
| `primevue/utils` | `blockBodyScroll`, `unblockBodyScroll` |

Pattern: register the plugin (`app.use(ToastService)`), mount the display component (`<Toast />`), call the composable. `useDialog().open(Component, { props, data })` returns a `DynamicDialogInstance`.

## Directives

`Tooltip`, `Ripple`, `StyleClass`, `FocusTrap`, `KeyFilter`, `AnimateOnScroll`, `Mask` (new in v5). Global `pt` keys for directives live under `directives` in the config (`input/source/config/index.d.ts`).

## Forms integration

Inputs accept `formControl` (Record) and work with `@primevue/forms` `Form`/`FormField`; `invalid` styles errors; `variant` (`outlined|filled`) and `fluid` size inputs (`inputtags/index.d.ts`, `inputpassword/index.d.ts`).

## DataTable and TreeTable

`DataTable` + `Column`/`ColumnGroup`/`Row`; `TreeTable` + shared `Column`. Performance notes: set `dataKey` and use an object for `expandedRows` for O(1) expansion on large data; use `stateStorage` + `stateKey` to persist sort/filter/page state; `VirtualScroller` (`items`, `itemSize`, and `delay` to throttle rendering during fast scroll) handles large lists.
