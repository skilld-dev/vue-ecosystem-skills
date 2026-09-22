# API surface of @tanstack/vue-form 1.33.5

All citations point into the prepared package source unless marked as official docs.

## Package root exports

From `dist/esm/index.js` and src/index.ts:1-5:

- `useForm`, `Field`, `useField`, `FormGroup`, `useFormGroup` (Vue bindings)
- `useSelector`, `useStore` re-exported from `@tanstack/vue-store` (src/index.ts:2)
- Everything from `@tanstack/form-core`, notably:
  - Classes: `FormApi`, `FieldApi`, `FormGroupApi`, `FieldGroupApi`
  - Functions: `formOptions`, `mergeForm`, `revalidateLogic`, `createFieldMap`, `deepCopy`, `evaluate`, `isGlobalFormValidationError`, `isStandardSchemaValidator`, `uuid`
  - Variables: `defaultValidationLogic`, `formEventClient`, `standardSchemaValidators`, `throttleFormState`

`useFormId` is internal. It exists in the source (src/useFormId.ts:18-24) but is not exported from the package index.

## useForm

`useForm(opts?: FormOptions)` returns `FormApi & VueFormApi` (src/useForm.tsx:243-360).

VueFormApi members (src/useForm.tsx:113-241):

| Member | Kind | Notes |
| --- | --- | --- |
| `Field` | Component | Bound to the parent form api (src/useForm.tsx:305-318) |
| `FormGroup` | Component | Bound to the parent form api (src/useForm.tsx:319-332) |
| `useSelector` | Hook | `(selector?) => Readonly<Ref<TSelected>>` (src/useForm.tsx:155-189) |
| `useStore` | Hook | Deprecated alias of `useSelector` (src/useForm.tsx:190-192, 336-337) |
| `Subscribe` | Component | Optional `selector` prop; slot receives the selected state (src/useForm.tsx:338-349) |

Lifecycle: `useForm` mounts the api with `onMounted(formApi.mount)` and keeps options current through `formApi.update(opts)` (src/useForm.tsx:354-357). A form id is generated SSR-safely from `useFormId()` (src/useForm.tsx:272).

## Field and useField

`Field` is a `defineComponent` with `inheritAttrs: false`; it merges props with attrs and calls `useField` internally (src/useField.tsx:480-550). The slot receives `{ field, state }` (src/useField.tsx:543-547).

`useField(opts)` returns `{ api, state }` as const (src/useField.tsx:378-383):

- `api`: a `FieldApi` whose `state` getter returns the reactive `fieldState` computed.
- `state`: the same reactive state, with `value` and the meta flags listed below.

Field options extend `FieldApiOptions` with `mode?: 'value' | 'array'` (src/types.ts:12-15, 16-75).

Reactively tracked meta in `state`: `isTouched`, `isBlurred`, `isDirty`, `errorMap`, `errorSourceMap`, `isValidating` (src/useField.tsx:260-291). Other meta (`errors`, `isValid`, `isPristine`, `isDefaultValue`, `_arrayVersion`) is derived in the same computed (src/useField.tsx:293-322).

### FieldApi surface (form-core)

Official reference: https://tanstack.com/form/latest/docs/reference/classes/FieldApi

- Value and events: `handleChange`, `handleBlur`, `setValue`, `setErrorMap`, `setMeta`
- Array methods: `pushValue`, `removeValue`, `insertValue`, `replaceValue`, `moveValue`, `swapValues`, `clearValues`
- Schema helpers: `parseValueWithSchema`, `parseValueWithSchemaAsync`
- Misc: `getMeta`, `getInfo`, `validate`, `update`, `mount`
- Deprecated: `getValue()`; read `state.value` instead

## FormGroup and useFormGroup

`FormGroup` is a `defineComponent`; the slot receives `{ group, state }` (src/useFormGroup.tsx:525-529).

`useFormGroup(opts)` returns `{ api, state }` where `state` is a `Readonly<Ref<FormGroupStoreState>>` (src/useFormGroup.tsx:296-316).

## FormApi surface (form-core)

Official reference: https://tanstack.com/form/latest/docs/reference/classes/FormApi

- Submit: `handleSubmit(meta?)`, `onSubmitMeta` option
- Values: `getFieldValue`, `setFieldValue`, `replaceFieldValue`
- Arrays: `pushFieldValue`, `removeFieldValue`, `insertFieldValue`, `moveFieldValues`, `swapFieldValues`, `clearFieldValues`, `validateArrayFieldsStartingFrom`, `validateAllFields`, `validateField`
- Meta and fields: `getFieldMeta`, `setFieldMeta`, `resetFieldMeta`, `getFieldInfo`, `deleteField`, `reset`, `resetField`, `setErrorMap`, `getAllErrors`
- Schema helpers: `parseValuesWithSchema`, `parseValuesWithSchemaAsync`
- Lifecycle: `mount`, `update`

## Exported Vue types

From src/useForm.tsx, src/useField.tsx, src/useFormGroup.tsx, src/types.ts:

- `VueFormApi`, `VueFieldApi`, `VueFormGroupApi`
- `UseFieldOptions`, `UseFieldOptionsBound`
- `FieldComponent`, `FieldComponentProps`, `FieldComponentBoundProps`
- `FormGroupComponent`, `FormGroupComponentProps`, `FormGroupComponentBoundProps`

The generics cover the full validator matrix: `TOnMount`, `TOnChange`, `TOnChangeAsync`, `TOnBlur`, `TOnBlurAsync`, `TOnSubmit`, `TOnSubmitAsync`, `TOnDynamic`, `TOnDynamicAsync` for field and form, plus `TFormOnServer` and `TSubmitMeta` (src/useForm.tsx:243-255). In templates these are inferred from props; write them by hand only for shared composable wrappers.
