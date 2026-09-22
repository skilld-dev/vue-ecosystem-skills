# Array fields in @tanstack/vue-form

Official guide: https://tanstack.com/form/latest/docs/framework/vue/guides/arrays

## Use mode="array"

Give the wrapping field the `mode="array"` prop. The option exists on field options as `mode?: 'value' | 'array'` (src/types.ts:12-15, prepared source).

Why it exists: in array mode `useField` tracks `state.meta._arrayVersion` instead of the value identity, so edits to one row do not re-render every row (src/useField.tsx:258-267). The value is then read straight from `fieldApi.state.value` (src/useField.tsx:310-311). Background: https://github.com/TanStack/form/issues/1925

## Shape

```vue
<script setup lang="ts">
import { useForm } from '@tanstack/vue-form'

const form = useForm({
  defaultValues: {
    people: [] as Array<{ age: number; name: string }>,
  },
  onSubmit: ({ value }) => console.log(value),
})
</script>

<template>
  <form @submit.prevent.stop="form.handleSubmit">
    <form.Field name="people" mode="array">
      <template v-slot="{ field }">
        <div>
          <form.Field
            v-for="(_, i) of field.state.value"
            :key="i"
            :name="`people[${i}].name`"
          >
            <template v-slot="{ field: subField }">
              <input
                :value="subField.state.value"
                @input="(e) => subField.handleChange((e.target as HTMLInputElement).value)"
              />
            </template>
          </form.Field>
          <button type="button" @click="field.pushValue({ name: '', age: 0 })">
            Add person
          </button>
        </div>
      </template>
    </form.Field>
    <button type="submit">Submit</button>
  </form>
</template>
```

Sub-field names are deep keys with the index inline: `` `people[${i}].name` ``. Keys can go arbitrarily deep into objects inside arrays.

## Mutation methods

On a field (FieldApi):

- `pushValue(value)`
- `removeValue(index)`
- `insertValue(index, value)`
- `replaceValue(index, value)`
- `moveValue(aIndex, bIndex)`
- `swapValues(aIndex, bIndex)`
- `clearValues()`

On the form (FormApi), the same operations addressed by field name:

- `pushFieldValue(name, value)`
- `removeFieldValue(name, index)`
- `insertFieldValue(name, index, value)`
- `replaceFieldValue(name, index, value)`
- `moveFieldValues(name, aIndex, bIndex)`
- `swapFieldValues(name, aIndex, bIndex)`
- `clearFieldValues(name)`

The form also exposes `validateArrayFieldsStartingFrom(name, startIndex)` and `validateAllFields()` for targeted revalidation after array edits.

## Notes

- Render the empty state from the array field itself: `Array.isArray(field.state.value) && !field.state.value.length`.
- Use `v-for` over `field.state.value` of the array field; do not copy the array into local state.
- Remove buttons inside rows should call the parent array field's `removeValue(i)` with `type="button"` so they do not submit the form.
