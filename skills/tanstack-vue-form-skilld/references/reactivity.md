# Reactivity in @tanstack/vue-form

## Select form state in script setup

`form.useSelector` returns a `Readonly<Ref>` scoped to the selected slice (src/useForm.tsx:155-189, prepared source):

```vue
<script setup lang="ts">
const firstName = form.useSelector((state) => state.values.firstName)
const canSubmit = form.useSelector((state) => state.canSubmit)
</script>

<template>
  <p>{{ firstName }}</p>
</template>
```

`form.useStore` is the deprecated alias (src/useForm.tsx:190-192, 336-337). Use `useSelector` in new code.

## Subscribe in the template

`form.Subscribe` takes an optional `selector` prop; the slot receives the selected state. Without `selector`, the whole form state is passed (src/useForm.tsx:338-349):

```vue
<form.Subscribe selector="(state) => ({ canSubmit: state.canSubmit, isSubmitting: state.isSubmitting })">
  <template v-slot="{ canSubmit, isSubmitting }">
    <button type="submit" :aria-disabled="!canSubmit">
      {{ isSubmitting ? '...' : 'Submit' }}
    </button>
  </template>
</form.Subscribe>
```

Source: official basic-concepts guide, https://tanstack.com/form/latest/docs/framework/vue/guides/basic-concepts

## Do not use useField for reactivity

The standalone `useField` hook mounts and unmounts a `FieldApi` and is designed for use inside `form.Field` (src/useField.tsx:361-368). For reading state in `script setup`, use `form.useSelector`. The official docs state the same for the discouraged `form.useField` pattern.

## Reactive field meta

Inside a `form.Field` slot, `field.state` is a computed that eagerly tracks `isTouched`, `isBlurred`, `isDirty`, `errorMap`, `errorSourceMap`, and `isValidating` (src/useField.tsx:260-322). Reading `field.state.meta` from a render function re-renders on meta updates; you do not need extra subscriptions for these flags.

## Raw store access

`useSelector` and `useStore` are re-exported from `@tanstack/vue-store` (src/index.ts:2). Use them against `form.store` or `field.store` only when you need store-level control outside the provided helpers.

## Listeners

React to triggers with the `listeners` prop; side effects belong there, not in validators:

```vue
<form.Field
  name="country"
  :listeners="{
    onChange: ({ value }) => {
      form.setFieldValue('province', '')
    },
  }"
>
```

Source: official basic-concepts guide. Listener hooks mirror validator hooks (`onChange`, `onBlur`, `onMount`, `onSubmit`).

## Async initial values

Pass `reactive` default values built from `computed` refs so the form updates when data arrives (official guide, https://tanstack.com/form/latest/docs/framework/vue/guides/async-initial-values):

```vue
<script setup lang="ts">
import { reactive, computed } from 'vue'

const { data, isLoading } = useQuery({ queryKey: ['data'], queryFn: fetchPerson })

const defaultValues = reactive({
  firstName: computed(() => data.value?.firstName || ''),
  lastName: computed(() => data.value?.lastName || ''),
})

const form = useForm({ defaultValues, onSubmit: async ({ value }) => submit(value) })
</script>

<template>
  <p v-if="isLoading">Loading..</p>
  <form v-else @submit.prevent.stop="form.handleSubmit"><!-- ... --></form>
</template>
```
