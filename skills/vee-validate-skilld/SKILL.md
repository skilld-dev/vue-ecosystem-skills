---
name: vee-validate-skilld
description: Use when writing, reviewing, or debugging Vue.js forms that import vee-validate (useForm, defineField, useField, useFieldArray, Form, Field, FieldArray, ErrorMessage). Provides correct v4.15.x Composition API and component usage, validation schema patterns, typed-schema integration, version-specific API changes since 4.9, deprecations, and known pitfalls.
---

# vee-validate 4.15.1

Form validation for Vue 3. Facts below come from the prepared source (`dist/vee-validate.d.ts`, `dist/vee-validate.mjs`, `package.json`) and official docs at https://vee-validate.logaretm.com/v4/.

## Environment

- Package `vee-validate@4.15.1` (`package.json:3`). Requires `vue ^3.4.26` as peer (`package.json:42`).
- ESM + CJS, `sideEffects: false`, single entry `vee-validate` (`package.json:11-26`).
- v4 supports Vue 3 only. Vue 2 needs vee-validate 2.x/3.x (README:69-72).
- Schema adapters live in separate packages: `@vee-validate/yup`, `@vee-validate/zod`, `@vee-validate/valibot`; global rules in `@vee-validate/rules`; messages in `@vee-validate/i18n`.

## Two API styles

**Composition API (preferred for new code).** `useForm` + `defineField` + `handleSubmit`:

```vue
<script setup>
import { useForm } from 'vee-validate';

function required(value) {
  return value ? true : 'This field is required';
}

const { defineField, handleSubmit, errors } = useForm({
  validationSchema: { field: required },
});

const [field, fieldProps] = defineField('field');

const onSubmit = handleSubmit(values => {
  console.log(values);
});
</script>

<template>
  <form @submit="onSubmit">
    <input v-model="field" v-bind="fieldProps" />
    <span>{{ errors.field }}</span>
    <button>Submit</button>
  </form>
</template>
```

Source: README:84-118, https://vee-validate.logaretm.com/v4/guide/composition-api/getting-started/

**Declarative components.** `Form` + `Field` with scoped slots:

```vue
<script setup>
import { Field, Form } from 'vee-validate';

function required(value) {
  return value ? true : 'This field is required';
}

function onSubmit(values) {
  console.log(values);
}
</script>

<template>
  <Form v-slot="{ errors }" @submit="onSubmit">
    <Field name="field" :rules="required" />
    <span>{{ errors.field }}</span>
    <button>Submit</button>
  </Form>
</template>
```

Source: README:122-153, https://vee-validate.logaretm.com/v4/guide/components/handling-forms/

## Core rules

- Bind fields with `defineField(path, config?)`. It returns `[model, props]`; spread the props with `v-bind` and the model with `v-model` (`dist/vee-validate.d.ts:443`, https://vee-validate.logaretm.com/v4/api/use-form/#definefield).
- Never write directly to `values.field`; use the `defineField` model, `setFieldValue`, or `useSetFieldValue`.
- `useFieldModel`, `defineComponentBinds`, and `defineInputBinds` are deprecated in favor of `defineField` (`dist/vee-validate.d.ts:444-459`).
- Show errors only after interaction, e.g. `v-if="errorMessage && meta.touched"`, to avoid aggressive validation UX (https://vee-validate.logaretm.com/v4/guide/best-practices/#avoiding-aggressive-validation).
- For TypeScript, wrap yup/zod/valibot schemas with `toTypedSchema` from the matching `@vee-validate/*` package. Passing a raw schema without it fails with "No such validator 'VVTypedSchema' exists" (https://vee-validate.logaretm.com/v4/guide/composition-api/typed-schema/, https://github.com/logaretm/vee-validate/discussions/4819).
- `useField` inside a custom component must not sync its v-model by default (`syncVModel` defaults to `false`, breaking change in 4.10.0). Opt in per field with `syncVModel: true` or a model prop name string (`dist/vee-validate.mjs:1862`).
- Field names are paths. Dots nest objects, `[0]` indexes arrays; wrap the name in brackets, e.g. `[user.name]`, to treat dots as literal (https://vee-validate.logaretm.com/v4/guide/composition-api/nested-objects-and-arrays/).
- The `errors` object is always flat: reference the exact path string used as the field name, brackets included (https://vee-validate.logaretm.com/v4/guide/composition-api/nested-objects-and-arrays/).
- Iterate array fields with `fields` from `useFieldArray` and key `v-for` by `entry.key` (a stable id, never the index) (https://vee-validate.logaretm.com/v4/guide/composition-api/nested-objects-and-arrays/).
- Pass reactive field names as getters (`useField(() => props.name)`) so vee-validate tracks name changes (https://vee-validate.logaretm.com/v4/guide/composition-api/caveats/).
- Keep schemas non-reactive: declare them outside `ref`/`reactive` or wrap with `markRaw` to avoid deep reactivity overhead (https://vee-validate.logaretm.com/v4/guide/best-practices/#reactive-schemas).
- `handleSubmit.withControlled(cb)` submits only fields registered with `useField`/`defineField` (`dist/vee-validate.d.ts:430-432`); note typed schemas can still surface all initial values (open issue: https://github.com/logaretm/vee-validate/issues/4960).

## Validation modes

Global defaults: `validateOnBlur: true`, `validateOnChange: true`, `validateOnInput: false`, `validateOnModelUpdate: true`, `bails: true`. Change globally with `configure()`; note these four trigger flags only apply to the `<Field>` component, not `useField` (https://vee-validate.logaretm.com/v4/api/configuration/). To validate only on submit, disable input/change/blur triggers per field in `defineField` config or globally (https://github.com/logaretm/vee-validate/discussions/4903).

## References

- [Composition API](./references/composition-api.md): `useForm`, `defineField`, `useField`, `useFieldArray`, state and setter composables, form context.
- [Components](./references/components.md): `Form`, `Field`, `FieldArray`, `ErrorMessage` props, slots, rendering, v-model rules.
- [Validation](./references/validation.md): validator functions, object schemas, typed schemas, global rules, i18n, standalone `validate` utils.
- [API surface](./references/api-surface.md): every runtime export and notable type, cited to `dist/vee-validate.d.ts`.
- [Version changes](./references/version-changes.md): API additions, breaking changes, and deprecations from 4.9.0 to 4.15.1.
- [Pitfalls](./references/pitfalls.md): composition caveats, nested path rules, array fields, known open issues.
