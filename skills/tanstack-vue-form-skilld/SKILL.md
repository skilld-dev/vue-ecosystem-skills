---
name: tanstack-vue-form-skilld
description: Use when writing, reviewing, or debugging code that imports @tanstack/vue-form (TanStack Form for Vue). Covers the 1.33.x API, including useForm, form.Field, form.FormGroup, form.Subscribe, form.useSelector, validators with Standard Schema, onDynamic with revalidateLogic, and array fields with mode="array". Result, forms built on current, non-deprecated Vue APIs with correct reactivity.
---

# @tanstack/vue-form 1.33.5

Headless, type-safe form state for Vue 3. The package re-exports all of `@tanstack/form-core` and adds Vue components and hooks (src/index.ts:1-5).

## Environment

- Version studied: `@tanstack/vue-form@1.33.5`, bundling `@tanstack/form-core@1.33.5` and `@tanstack/vue-store@^0.11.0` (package.json:39-42).
- Peer dependency: `vue ^3.4.0` (package.json:48-50). TypeScript 5.4 through 5.9 are in the test matrix (package.json:54-60).
- Import from the package root only. The sole subpath export is `./package.json` (package.json:21-33). Dual ESM/CJS, `sideEffects: false`.
- Official docs: https://tanstack.com/form/latest/docs/framework/vue/overview

## Minimal form

```vue
<script setup lang="ts">
import { useForm } from '@tanstack/vue-form'

const form = useForm({
  defaultValues: {
    fullName: '',
  },
  onSubmit: async ({ value }) => {
    console.log(value)
  },
})
</script>

<template>
  <form @submit.prevent.stop="form.handleSubmit">
    <form.Field name="fullName">
      <template v-slot="{ field }">
        <input
          :name="field.name"
          :value="field.state.value"
          @blur="field.handleBlur"
          @input="(e) => field.handleChange((e.target as HTMLInputElement).value)"
        />
      </template>
    </form.Field>
    <button type="submit">Submit</button>
  </form>
</template>
```

Source: official quick start, https://tanstack.com/form/latest/docs/framework/vue/quick-start

## Field binding rules

- Fields are created with the `form.Field` component. The `name` prop must be a deep key of `defaultValues`, for example `'details.email'` or `` `people[${i}].name` ``.
- The scoped slot receives `{ field, state }` (src/useField.tsx:543-547). `field` is a `FieldApi`, `state` mirrors `field.state`.
- Inputs are controlled: bind `:value="field.state.value"`, push updates through `field.handleChange`, and wire `@blur="field.handleBlur"`.
- For number inputs, use `(e.target as HTMLInputElement).valueAsNumber`.
- Do not write `v-model` on the slot input; state flows through `handleChange`.
- `form.Field` merges its props with fallthrough attrs before creating the field (src/useField.tsx:541), so validators and listeners can be passed as props or attrs.

## Reactivity

- In `<script setup>`, use `form.useSelector((state) => state.values.firstName)`. It returns a `Readonly<Ref<T>>` (src/useForm.tsx:155-189).
- `form.useStore` is deprecated; it is the same function as `useSelector`. Prefer `form.useSelector` (src/useForm.tsx:190-227, 336-337).
- In the template, use `<form.Subscribe>` with an optional `selector` prop. Without `selector`, the slot receives the whole form state (src/useForm.tsx:338-349).
- Do not call the `useField` hook directly for reactivity. It is designed for use inside `form.Field`; use `form.useSelector` instead (official basic-concepts note, https://tanstack.com/form/latest/docs/framework/vue/guides/basic-concepts).
- `useSelector` and `useStore` are re-exported from `@tanstack/vue-store` for raw store access (src/index.ts:2).

Details: [references/reactivity.md](./references/reactivity.md)

## Validation essentials

- Pass validators via the `validators` prop on `form.Field`, or `validators` in `useForm` options. Hooks: `onMount`, `onChange`, `onBlur`, `onSubmit`, `onDynamic`, each with an `Async` variant.
- A validator returns `undefined` when valid, or an error of any type (usually a string). Errors land in `field.state.meta.errors` and `field.state.meta.errorMap`.
- Standard Schema libraries work directly as validators: Zod v3.24.0 or higher, Valibot v1.0.0 or higher, ArkType v2.1.20 or higher, Yup v1.7.0 or higher (official basic-concepts guide).
- Debounce async validators with the `async-debounce-ms` prop or per-validator `onChangeAsyncDebounceMs`.
- `onDynamic` validators only run when `validationLogic: revalidateLogic()` is set in `useForm` options.

```vue
<form.Field
  name="age"
  :validators="{
    onChange: z.number().gte(13, 'You must be 13 to make an account'),
  }"
>
```

Details: [references/validation.md](./references/validation.md)

## Array fields

- Give the wrapping field `mode="array"`. In array mode the component tracks `state.meta._arrayVersion` instead of the value, so child edits do not re-render the whole list (src/useField.tsx:258-267, src/types.ts:12-15).
- Render sub-fields with `v-for` over `field.state.value` and deep names such as `` `people[${i}].name` ``.
- Mutate through the array methods: `pushValue`, `removeValue`, `swapValues`, `moveValue`, `insertValue`, `replaceValue`, `clearValues`.

Details: [references/array-fields.md](./references/array-fields.md)

## Form groups

- `<form.FormGroup name="step1" v-slot="{ group }">` builds a sub-form for one key of the form data. The slot receives `{ group, state }` (src/useFormGroup.tsx:525-529).
- `group.handleSubmit()` submits and validates only the group; `form.handleSubmit()` submits the whole form.
- Group validators can return `{ group, fields }`, where `fields` keys are relative to the group, and Standard Schemas can be composed per step.

Details: [references/form-groups.md](./references/form-groups.md)

## Version-specific rules

- BREAKING since v1.28.0: `field.state.meta.errors` is flattened by default, so `['err']` not `[['err']]`. Restore the old nesting per field with `disableErrorFlat: true` in field options. Release: https://github.com/TanStack/form/releases/tag/%40tanstack%2Fvue-form%401.28.0
- DEPRECATED: `form.useStore`, use `form.useSelector` (src/useForm.tsx:190-192, 336-337).
- DEPRECATED: `field.getValue()`, read `field.state.value` instead (official FieldApi reference, https://tanstack.com/form/latest/docs/reference/classes/FieldApi).
- `Field` accepts `mode: 'value' | 'array'`. Array mode exists to avoid list re-renders; see https://github.com/TanStack/form/issues/1925 (src/useField.tsx:258-259).
- `useForm` generates an SSR-safe form id from Vue's `useId` when available, falling back to a uuid, so server markup and client hydration agree (src/useForm.tsx:272, src/useFormId.ts:18-24). `useFormId` itself is internal and not exported (dist/esm/index.js).
- Reusable option sets: `formOptions({ defaultValues })` from form-core, spread into `useForm`.

## Pitfalls

- Standard Schema transforms are not preserved. `onSubmit` always receives the input data; call `schema.parse(value)` inside `onSubmit` for transformed output (official submission guide, https://tanstack.com/form/latest/docs/framework/vue/guides/submission-handling).
- A form-level validator error on a field can be overwritten by that field's own validator; field validation runs after form-level field errors are set (official validation guide).
- Sync validators run first; the matching `Async` validator is skipped when sync fails, unless `asyncAlways: true`.
- `canSubmit` is true until the form is touched. Combine `!canSubmit || isPristine` to gate a submit button before any interaction. Prefer `aria-disabled` over `disabled` for accessibility (official validation guide).
- The `Field` and `FormGroup` components pass the parent form automatically. Only the standalone `Field` and `FormGroup` exports require an explicit `form` option.
- Async default values: wrap them in `reactive` and `computed` refs (TanStack Query pattern, https://tanstack.com/form/latest/docs/framework/vue/guides/async-initial-values).

## References

- [references/api-surface.md](./references/api-surface.md): exports, hooks, components, and core class methods with source citations.
- [references/reactivity.md](./references/reactivity.md): selectors, Subscribe, listeners, and reactive meta tracking.
- [references/validation.md](./references/validation.md): validators, schemas, dynamic validation, linked fields, and submission handling.
- [references/array-fields.md](./references/array-fields.md): array fields and array mutation methods.
- [references/form-groups.md](./references/form-groups.md): sub-forms, group validation, and group state.
