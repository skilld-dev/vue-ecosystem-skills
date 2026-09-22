# Styling and animation

## State attributes

Primitives expose state as data attributes; style those instead of toggling classes:

- `data-state="open" | "closed"` on accordions, dialogs, popovers, and similar parts
- `data-state="checked" | "unchecked" | "indeterminate"` on Checkbox parts
- `data-state="active" | "inactive"` on items and triggers
- `data-state="on" | "off"` on Toggle and ToggleGroup
- `data-disabled`, `data-highlighted`, `data-selected` for interaction state
- `data-side`, `data-align` on Popper-based content for placement-aware styles
- `data-swipe-direction` and swipe progress variables on Drawer content
- `data-state="visible" | "hidden"` on `Presence`-managed parts

```css
.AccordionItem[data-state="open"] {
  border-bottom-width: 2px;
}
```

## CSS variables

Animation-friendly custom properties use the `--reka-` prefix, for example `--reka-combobox-trigger-width`, `--reka-tabs-indicator-size`, `--reka-tabs-indicator-thickness`, `--reka-tabs-indicator-position`, and `--reka-scroll-area-corner-width`. The Tabs indicator variables come from `src/Tabs/TabsIndicator.vue:73-75`. Reference: https://reka-ui.com/docs/guides/styling

## Scoped styles and teleported content

Dialog, Popover, Tooltip, Menu, and similar content portals append to `document.body` by default, outside the scoped subtree. Use `:deep()` from an ancestor, or a global style block:

```vue
<style scoped>
/* will not reach the teleported DialogContent */
</style>
<style>
:global(.DialogOverlay) { background: rgb(0 0 0 / 0.5); }
</style>
```

Set a different container with the part's `to` prop, or globally with `ConfigProvider` `teleportTo` (prepared source `src/ConfigProvider/ConfigProvider.vue:45`).

## Animation with `force-mount`

Content parts unmount when closed. To animate exit, add `force-mount` and wrap in Vue's `<Transition>`; control visibility with the `data-state` attribute:

```vue
<DialogPortal>
  <Transition name="fade">
    <DialogContent force-mount>...</DialogContent>
  </Transition>
</DialogPortal>
```

```css
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
```

`forceMount` renders the element regardless of open state, so keep it hidden yourself when closed, for example with `[data-state="closed"] { display: none; }` or `:hidden`. `Presence` (https://reka-ui.com/docs/utilities/presence) provides the same mounting control for your own components. Guide: https://reka-ui.com/docs/guides/animation
