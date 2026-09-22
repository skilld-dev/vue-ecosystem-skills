# Composition

Official guide: https://reka-ui.com/docs/guides/composition

## `asChild`

Every primitive renders a DOM element by default. Pass `asChild` to merge the primitive's behavior and accessibility attributes onto the child instead:

```vue
<DialogTrigger asChild>
  <RouterLink to="/profile">Edit profile</RouterLink>
</DialogTrigger>
```

Rules:

- `asChild` expects exactly one child element or component.
- Use `as="tag"` (an `AsTag` string or any component) when you only need a different element, for example `as="span"`.
- Do not spread extra listeners onto the child that duplicate the primitive's own, for example a second `click` handler on a trigger.

## Prop and emit forwarding

When wrapping a primitive in your own component, forward with the dedicated utilities rather than re-declaring props:

```ts
import type { AccordionRootProps, AccordionRootEmits } from 'reka-ui'
import { useForwardPropsEmits } from 'reka-ui'

const props = defineProps<AccordionRootProps>()
const emits = defineEmits<AccordionRootEmits>()
const forwarded = useForwardPropsEmits(props, emits)
```

```vue
<AccordionRoot v-bind="forwarded">
  <slot />
</AccordionRoot>
```

- `useForwardProps(props)`: props only.
- `useEmitAsProps(emits)`: converts emits to `onXxx` props for `v-bind`.
- `useForwardPropsEmits(props, emits)`: both; type inference improved in 2.10.0 (https://github.com/unovue/reka-ui/releases/tag/v2.10.0).
- `withDefault(Component, { props })`: bake defaults into a primitive for reuse.

## `useForwardExpose`

Multi-root (fragment) components return a fragment from a template ref. `useForwardExpose` makes the ref return the rendered element, matching single-root behavior:

```ts
const { forwardRef } = useForwardExpose()
```

```vue
<div :ref="forwardRef">...</div>
```

## Context injection

Each family exposes `injectXxxContext` functions, for example `injectAccordionRootContext` and `injectComboboxRootContext`. Call one in a custom child that is not a registered part to read live primitive state:

```ts
const context = injectAccordionRootContext()
// context.isOpen.value, context.disabled.value, ...
```

Guide: https://reka-ui.com/docs/guides/inject-context. The primitives themselves are built with `createContext`, which is also exported.

## Controlled state

Every Root supports `v-model` on its main value plus `defaultXxx` uncontrolled variants; open/close state uses `v-model:open` and `@update:open`:

```vue
<TabsRoot v-model="activeTab">
<DialogRoot :open="open" @update:open="(o) => (open = o)">
```

Pass a value without a listener for uncontrolled usage with a default; pass the ref to make it controlled. Guide: https://reka-ui.com/docs/guides/controlled-state
