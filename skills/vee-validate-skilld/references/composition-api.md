# Composition API reference

All signatures cited from the prepared source `dist/vee-validate.d.ts`. Docs: https://vee-validate.logaretm.com/v4/api/use-form/, https://vee-validate.logaretm.com/v4/guide/composition-api/handling-forms/

## useForm

```ts
useForm<TValues, TOutput, TSchema>(opts?: FormOptions<TValues, TOutput, TSchema>): FormContext<TValues, TOutput>
```

`FormOptions` (`dist/vee-validate.d.ts:1357-1365`):

| Option | Type | Notes |
| --- | --- | --- |
| `validationSchema` | `MaybeRef<TSchema>` | Typed schema, yup schema (with `@vee-validate/yup`), or object of path to rule. |
| `initialValues` | `PartialDeep<TValues>` | Reactive initial values are deprecated since 4.12.0; pass a plain object or a getter. |
| `initialErrors` | flat path map | Pre-existing errors keyed by field path. |
| `initialTouched` | flat path map | Pre-existing touched state. |
| `validateOnMount` | `boolean` | Validate when the form mounts. |
| `keepValuesOnUnmount` | `MaybeRef<boolean>` | Keep values of unmounted fields; use for multi-step and tabbed forms. |
| `name` | `string` | Form name for devtools and nested form identification. |

`FormContext` members (`dist/vee-validate.d.ts:410-465`, public shape at 461-465):

- State: `values` (readonly since 4.10.0), `errors` (flat computed map), `errorBag` (path to `string[]`), `meta` (`touched`, `dirty`, `valid`, `pending`, `initialValues`), `isSubmitting`, `isValidating` (since 4.9.3), `submitCount`, `controlledValues`.
- Validation: `validate(opts?)`, `validateField(path, opts?)`. Modes: `'validated-only' | 'silent' | 'force'` (`dist/vee-validate.d.ts:231-241`). Silent validation does not mutate field state (https://github.com/logaretm/vee-validate/discussions/4980).
- Submission: `handleSubmit(cb, onInvalidSubmit?)` and `handleSubmit.withControlled(cb)` (`dist/vee-validate.d.ts:430-432`). The handler receives `(values, ctx)` where `ctx` includes `evt` and `controlledValues` (`dist/vee-validate.d.ts:347-351`).
- Mutations (`FormActions`, `dist/vee-validate.d.ts:330-339`): `setFieldValue(path, value, shouldValidate?)`, `setFieldError`, `setErrors`, `setValues`, `setFieldTouched`, `setTouched`, `resetForm(state?, opts?)`, `resetField(path, state?)`.
- `resetForm` accepts `ResetFormOpts.force` (since 4.13.0) to replace values instead of merging (`dist/vee-validate.d.ts:327-329`).
- Reset helpers: `handleReset()`, `submitForm(e?)`.

## defineField

`defineField(path, config?)` returns `[model: Ref<TValue>, props: Ref<BaseFieldProps & TExtras>]` (`dist/vee-validate.d.ts:443`). Call it in `setup`. The model is a writable computed that routes writes through `setFieldValue`; the props ref carries `onBlur`, `onChange`, `onInput` plus whatever your config adds (`dist/vee-validate.d.ts:363-367`).

Static config:

```ts
const [email, emailProps] = defineField('email', {
  label: 'Email', // used by global rules for message generation (since 4.12.0)
  validateOnBlur: true,
  validateOnChange: true,
  validateOnInput: false,
  validateOnModelUpdate: true,
  props: state => ({ 'aria-invalid': state.errors.length > 0 ? 'true' : 'false' }),
});
```

Lazy config (function of field state; `props` becomes a plain object):

```ts
const [email, emailProps] = defineField('email', state => ({
  validateOnInput: state.errors.length === 0,
  props: { 'aria-invalid': state.errors.length > 0 ? 'true' : 'false' },
}));
```

Source: https://vee-validate.logaretm.com/v4/api/use-form/#definefield

Deprecated alternatives: `useFieldModel`, `defineComponentBinds`, `defineInputBinds` (`dist/vee-validate.d.ts:444-459`).

## useField

```ts
useField<TValue>(path: MaybeRefOrGetter<string>, rules?, opts?: Partial<FieldOptions<TValue>>): FieldContext<TValue>
```

`FieldOptions` (`dist/vee-validate.d.ts:528-553`): `initialValue`, `validateOnValueUpdate`, `validateOnMount`, `bails`, `type` (`'checkbox' | 'radio' | 'default'`), `checkedValue`, `uncheckedValue`, `label`, `controlled` (opposite of deprecated `standalone`), `keepValueOnUnmount`, `syncVModel` (`boolean | string`, default `false` since 4.10.0, `dist/vee-validate.mjs:1862`; pass a string to sync a custom model prop name, supported since 4.10.0). Deprecated: `valueProp` (use `checkedValue`), `standalone` (use `controlled`), `modelPropName` (use `syncVModel`).

`FieldContext` (`dist/vee-validate.d.ts:293-317`): `value`, `meta`, `errors`, `errorMessage`, `resetField(state?)`, `handleReset()`, `validate(opts?)`, `handleChange(e, shouldValidate?)`, `handleBlur(e?, shouldValidate?)`, `setState()`, `setTouched()`, `setErrors()`, `setValue(value, shouldValidate?)`. Use `handleChange` for both input and change events; `handleInput` is deprecated since 4.4.0.

Docs: https://vee-validate.logaretm.com/v4/api/use-field/

## useFieldArray

```ts
useFieldArray<TValue>(arrayPath: MaybeRefOrGetter<string>): FieldArrayContext<TValue>
```

`FieldArrayContext` (`dist/vee-validate.d.ts:278-288`): `fields: Ref<FieldEntry<TValue>[]>` plus `push`, `remove(idx)`, `swap(a, b)`, `insert(idx, value)`, `prepend(value)`, `update(idx, value)`, `replace(newArray)`, `move(oldIdx, newIdx)` (`move` since 4.6.0). Each `FieldEntry` has `value`, `key` (stable unique id), `isFirst`, `isLast` (`dist/vee-validate.d.ts:272-277`). Key your `v-for` by `entry.key`, never by index; the key is not the index and must not be used inside field names.

Docs: https://vee-validate.logaretm.com/v4/api/use-field-array/

## Cross-component state

These composables find the nearest form context without destructuring `useForm`:

- Read: `useFieldValue(path?)`, `useFieldError(path?)`, `useFormValues()`, `useFormErrors()`, `useIsFieldDirty/Touched/Valid(path?)`, `useIsFormDirty/Touched/Valid()`, `useIsSubmitting()`, `useIsValidating()`, `useSubmitCount()` (`dist/vee-validate.d.ts:1373-1446`).
- Write (since 4.11.0): `useSetFieldValue(path?)`, `useSetFieldError(path?)`, `useSetFieldTouched(path?)`, `useSetFormValues()`, `useSetFormErrors()`, `useSetFormTouched()` (`dist/vee-validate.d.ts:1448-1478`).
- Actions: `useSubmitForm(cb)`, `useValidateField(path?)`, `useValidateForm()`, `useResetForm()` (`dist/vee-validate.d.ts:1401, 1421, 1371, 1448`).
- `useFormContext()` (since 4.14.0) returns the full `FormContext` for the current form, replacing manual `inject(FormContextKey)` (`dist/vee-validate.d.ts:1367`).

State hooks without an enclosing form resolve nothing; call them inside components wrapped by a `useForm` caller.
