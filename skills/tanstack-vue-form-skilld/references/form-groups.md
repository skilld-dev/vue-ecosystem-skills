# Form groups in @tanstack/vue-form

Official guide: https://tanstack.com/form/latest/docs/framework/vue/guides/form-groups

A form group is a sub-form over one key of the form data, for example one step of a stepper. It validates and submits independently of the parent form.

## Usage

```vue
<script setup lang="ts">
import { ref } from 'vue'
import { useForm } from '@tanstack/vue-form'

const step = ref(0)

const form = useForm({
  defaultValues: {
    step1: { name: '' },
    step2: { age: 0 },
  },
})
</script>

<template>
  <form.FormGroup v-if="step === 0" name="step1" v-slot="{ group: formGroup }">
    <form @submit.prevent.stop="formGroup.handleSubmit()">
      <form.Field name="step1.name">
        <template v-slot="{ field }">
          <input
            :value="field.state.value"
            @input="(e) => field.handleChange((e.target as HTMLInputElement).value)"
          />
        </template>
      </form.Field>
    </form>
  </form.FormGroup>
</template>
```

- The slot receives `{ group, state }` (src/useFormGroup.tsx:525-529, prepared source). `group` is a `FormGroupApi` with form-like methods such as `handleSubmit`, `deleteField`, and `insertFieldValue`.
- `formGroup.handleSubmit()` validates and submits only the group. Call `form.handleSubmit()` to submit the whole form, for example from the last step.
- Group callbacks: `onGroupSubmit`, `onGroupSubmitInvalid`, and `onSubmitMeta` props on `form.FormGroup`.
- The `useFormGroup(opts)` hook returns `{ api, state }` with `state` as a `Readonly<Ref>` (src/useFormGroup.tsx:296-316); the component form is the normal path in templates.

## Group validation

Group validators can return errors three ways:

```vue
<form.FormGroup
  name="step1"
  :validators="{
    onChange: ({ value, groupApi }) => ({
      group: value.name === 'error' ? 'Group error' : undefined,
      fields: {
        name: value.name === 'error' ? 'Field error' : undefined,
      },
    }),
  }"
  v-slot="{ group: formGroup }"
>
  {{ formGroup.state.meta.errorMap.onChange }}
</form.FormGroup>
```

- `group` is the group-level error, read from `formGroup.state.meta.errors` or `errorMap`.
- `fields` keys are relative to the group (`name`, not `step1.name`), matching how Standard Schemas address group fields.
- Standard Schemas are accepted directly, and compose with the parent form schema: pass `step1Schema` to the group and `z.object({ step1: step1Schema, step2: step2Schema })` to `useForm`. Partially validated data still flags errors if a group is bypassed.

## Dynamic validation

With `onDynamic` and `revalidateLogic()`, pass the sub-schema to the group, not to `useForm`. A form-level `onDynamic` only re-runs its `onChange` when the form itself is submitted; the group's `onDynamic` keys off `formGroup.submissionAttempts` (official guide).

```vue
<form.FormGroup name="step1" :validators="{ onDynamic: step1Schema }" />
```

## Group state meta

- `formGroup.state.meta.isFieldsValid`: field-level validators have no errors
- `formGroup.state.meta.isGroupValid`: group-level validators have no errors
- `formGroup.state.meta.isValid`: both are valid
- `formGroup.state.meta.isSubmitting`: the group submit is in flight
