# Validation in @tanstack/vue-form

Official guide: https://tanstack.com/form/latest/docs/framework/vue/guides/validation

## Where validators live

- Field level: the `validators` prop on `form.Field`.
- Form level: the `validators` key in `useForm` options.
- Hooks per validator slot: `onMount`, `onChange`, `onBlur`, `onSubmit`, `onDynamic`, each with an `Async` variant (visible in the generic matrix, src/useForm.tsx:243-255, prepared source).

Return `undefined` when valid; return an error (usually a string) otherwise. Errors land in `field.state.meta.errors` and `field.state.meta.errorMap` keyed by hook, for example `errorMap.onChange`.

```vue
<form.Field
  name="age"
  :validators="{
    onChange: ({ value }) => (value < 13 ? 'You must be 13 to make an account' : undefined),
    onBlur: ({ value }) => (value < 0 ? 'Invalid value' : undefined),
  }"
>
  <template v-slot="{ field }">
    <input
      type="number"
      :value="field.state.value"
      @blur="field.handleBlur"
      @input="(e) => field.handleChange((e.target as HTMLInputElement).valueAsNumber)"
    />
    <em role="alert" v-if="!field.state.meta.isValid">
      {{ field.state.meta.errors.join(', ') }}
    </em>
  </template>
</form.Field>
```

## Async validation and debouncing

Sync runs first; the matching async validator is skipped when sync fails, unless `asyncAlways: true`. Debounce with the `async-debounce-ms` prop, or per validator with `onChangeAsyncDebounceMs`:

```vue
<form.Field
  name="username"
  :async-debounce-ms="500"
  :validators="{
    onChangeAsync: async ({ value }) => await checkUsername(value),
  }"
>
```

## Standard Schema validation

Pass a schema where a function is expected. Supported versions (official basic-concepts guide): Zod v3.24.0 or higher, Valibot v1.0.0 or higher, ArkType v2.1.20 or higher, Yup v1.7.0 or higher.

```vue
<form.Field
  name="age"
  :validators="{
    onChange: z.number().gte(13, 'You must be 13 to make an account'),
  }"
>
```

Combine a schema with a function through `field.parseValueWithSchema` (does not touch internal error state) or `form.parseValuesWithSchema` at the form level.

Transforms are not preserved: `onSubmit` receives the schema input. Parse in the handler for the output type:

```ts
const schema = z.object({ age: z.string().transform(Number) })
const form = useForm({
  defaultValues: { age: '13' } as z.input<typeof schema>,
  validators: { onChange: schema },
  onSubmit: ({ value }) => {
    const output = schema.parse(value)
  },
})
```

## Form-level validators

Form validators run against the whole value and can set errors on many fields at once by returning `{ form, fields }`:

```ts
useForm({
  validators: {
    onSubmitAsync: async ({ value }) => {
      const hasErrors = await verifyDataOnServer(value)
      if (hasErrors) {
        return {
          form: 'Invalid data',
          fields: {
            age: 'Must be 13 or older to sign',
            'socials[0].url': 'The provided URL does not exist',
            'details.email': 'An email is required',
          },
        }
      }
      return null
    },
  },
})
```

Field keys use full deep names, including array indices. A field's own validator can overwrite an error set here; field validation runs after form-level field errors are applied (official validation guide).

Read form-level errors through `form.useSelector((state) => state.errorMap)` or `form.Subscribe`.

## Dynamic validation with onDynamic

`onDynamic` is dormant until you pass `validationLogic: revalidateLogic()` to `useForm` (official guide, https://tanstack.com/form/latest/docs/framework/vue/guides/dynamic-validation):

```ts
import { revalidateLogic, useForm } from '@tanstack/vue-form'

const form = useForm({
  defaultValues: { firstName: '', lastName: '' },
  validationLogic: revalidateLogic({ mode: 'submit', modeAfterSubmission: 'change' }),
  validators: {
    onDynamic: ({ value }) => (!value.firstName ? { firstName: 'A first name is required' } : undefined),
  },
})
```

`revalidateLogic` options: `mode` before first submission (`'change' | 'blur' | 'submit'`, default `'submit'`) and `modeAfterSubmission` (default `'change'`). Errors appear under `errorMap.onDynamic`. Standard Schemas are accepted as `onDynamic` validators. For form groups, pass `onDynamic` to the `FormGroup`, not to `useForm`.

## Linked fields

Re-run one field's validation when another changes with `onChangeListenTo` (also `onBlurListenTo`), official guide https://tanstack.com/form/latest/docs/framework/vue/guides/linked-fields:

```vue
<form.Field
  name="confirm_password"
  :validators="{
    onChangeListenTo: ['password'],
    onChange: ({ value, fieldApi }) =>
      value !== fieldApi.form.getFieldValue('password') ? 'Passwords do not match' : undefined,
  }"
>
```

## Submission

- Block submission while invalid: validators run on submit and the submission is stopped on errors.
- `canSubmit` is true until the form is touched. Combine with `isPristine` to gate the button: `!canSubmit || isPristine`. Prefer `aria-disabled` over `disabled` (official validation guide).
- Multiple submit actions: set `onSubmitMeta` defaults and call `form.handleSubmit({ submitAction: 'publish' })` per button; `onSubmit` receives `{ value, meta }` (official guide, https://tanstack.com/form/latest/docs/framework/vue/guides/submission-handling).

## Error shape

Since v1.28.0 `meta.errors` is flattened by default (`['err']`, not `[['err']]`); opt back in per field with `disableErrorFlat: true`. Release: https://github.com/TanStack/form/releases/tag/%40tanstack%2Fvue-form%401.28.0
