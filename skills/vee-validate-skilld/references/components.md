# Components reference

Declarative higher-order components. Props verified in `dist/vee-validate.d.ts`. Docs: https://vee-validate.logaretm.com/v4/guide/components/handling-forms/

## Form

Props (`dist/vee-validate.d.ts:950-1051`): `as` (tag, default `'form'`), `validationSchema`, `initialValues`, `initialErrors`, `initialTouched`, `validateOnMount`, `onSubmit`, `onInvalidSubmit`, `keepValues`, `name`.

Scoped slot props (`FormSlotProps`, `dist/vee-validate.d.ts:943-949`): `meta`, `errors`, `errorBag`, `values`, `isSubmitting`, `isValidating`, `submitCount`, `controlledValues`, plus `validate`, `validateField`, `handleReset`, `setErrors`, `setFieldError`, `setFieldValue`, `setValues`, `setFieldTouched`, `setTouched`, `resetForm`, `resetField`, `handleSubmit(evt, cb?)`, `submitForm`, `getValues`, `getMeta`, `getErrors`.

```vue
<Form :validation-schema="schema" @submit="onSubmit" v-slot="{ errors, meta }">
  ...
  <button :disabled="!meta.valid">Submit</button>
</Form>
```

Prefer `@submit` over slot `handleSubmit` unless you need it inline. `onInvalidSubmit` receives `{ values, evt, errors, results }` (`dist/vee-validate.d.ts:352-358`).

## Field

Props (`dist/vee-validate.d.ts:583-834`): `name` (required), `as`, `rules`, `label`, `bails`, `type`, `validateOnMount`, `validateOnBlur`, `validateOnChange`, `validateOnInput`, `validateOnModelUpdate`, `uncheckedValue`, `modelValue`, `standalone`, `keepValue`. Instance members expose `value`, `meta`, `errors`, `errorMessage`, `setErrors`, `setTouched`, `reset`, `validate`, `setValue` (since 4.13.0), `handleChange` (`dist/vee-validate.d.ts:927-941`).

Rendering:

```vue
<!-- Renders an input[type=text] by default -->
<Field name="email" :rules="required" />

<!-- as prop: any element or component -->
<Field name="country" as="select" />
<Field name="field" as="my-text-field" />

<!-- scoped slot: renderless, bind the field object yourself -->
<Field name="password" v-slot="{ field, errorMessage }">
  <input v-bind="field" />
  <span>{{ errorMessage }}</span>
</Field>
```

With `v-slot`, `v-model` goes on the `Field` tag, never on the inner input (it conflicts with `v-bind="field"`) (https://vee-validate.logaretm.com/v4/api/field/#using-v-model). The slot also exposes `componentField` for component bindings, `value`, `meta`, `errors`, `errorMessage`, `handleChange`, `handleBlur`, `validate`, `resetField`, `setValue` (`dist/vee-validate.d.ts:574-582`).

Checkboxes and radios: give each input a `value` attr; vee-validate tracks the group by the shared `name`. `uncheckedValue` sets what an unchecked checkbox writes. Select multiple is partially supported: values are picked up but the initial UI state is not set; bind `selected` on options or use `v-slot` (https://vee-validate.logaretm.com/v4/api/field/).

Docs: https://vee-validate.logaretm.com/v4/api/field/

## FieldArray

Props: `name` only (`dist/vee-validate.d.ts:1205-1210`). Slot props mirror `useFieldArray`: `fields`, `push`, `remove`, `swap`, `insert`, `update`, `replace`, `prepend`, `move` (`dist/vee-validate.d.ts:1255-1266`).

```vue
<FieldArray name="links" v-slot="{ fields, push, remove }">
  <li v-for="(entry, idx) in fields" :key="entry.key">
    <Field :name="`links[${idx}].url`" />
    <button type="button" @click="remove(idx)">x</button>
  </li>
  <button type="button" @click="push({ url: '' })">Add</button>
</FieldArray>
```

Known limitation: `FieldArray` does not track radio groups inside array items well (https://github.com/logaretm/vee-validate/issues/5013).

Docs: https://vee-validate.logaretm.com/v4/api/field-array/

## ErrorMessage

Props: `name`, `as` (default renders a span with the message; omit `as` to use the slot) (`dist/vee-validate.d.ts:1269-1354`). Slot props: `{ message }`.

```vue
<Field name="email" />
<ErrorMessage name="email" as="div" />
```

Docs: https://vee-validate.logaretm.com/v4/api/error-message/
