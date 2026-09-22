# Pitfalls

## Composition API caveats

Source: https://vee-validate.logaretm.com/v4/guide/composition-api/caveats/

- Pass the field name as a getter when it can change: `useField(() => props.name)`. Passing `props.name` directly loses reactivity when names are dynamic (array fields, generated forms). `toRef`, `toRefs`, and `computed` also work.
- Destructured composables keep reactivity only if you destructure them. If you keep the whole object (`const form = useForm()`), wrap with `reactive()` for template auto-unwrapping; note writable computed refs like `field.value` then need `.value` in `v-model`.
- `defineField` must run inside `setup`.

## Nested paths and arrays

Source: https://vee-validate.logaretm.com/v4/guide/composition-api/nested-objects-and-arrays/

- Dots create objects, `[n]` with a numeric `n` creates arrays. `some.nested[0path]` does not nest (not a number); `some.nested[0].path` does.
- Escape with brackets to disable nesting: `[user.name]` is a literal key, useful for keys that contain dots or for APIs that send flat keys.
- `errors` is always flat and keyed exactly like the field name, brackets included: `errors['[user.name]']`, `errors['links[0].url']`.
- Key `v-for` over `useFieldArray().fields` by `entry.key`. The key is a stable id, not an index; never build field names from it.
- Use `keepValuesOnUnmount: true` on `useForm` (or `keepValueOnUnmount` per field) for multi-step and tabbed forms where fields unmount; otherwise values are destroyed.
- Writing to unregistered nested paths: mutate via `setFieldValue` so path state and validation are created for you.

## Validation behavior

- Show errors after `meta.touched` (or on submit) to avoid error messages on first render (https://vee-validate.logaretm.com/v4/guide/best-practices/).
- `setFieldValue` validates by default (since 4.10.0); pass `false` as third arg to skip.
- Schema validation with `mode: 'silent'` mutates nothing; `validated-only` (default for submits) only updates previously validated fields; `force` validates everything (`dist/vee-validate.d.ts:231-241`).
- Wrap schemas in `markRaw` or keep them outside reactive state; deeply reactive schemas cause overhead and update loops (https://github.com/logaretm/vee-validate/issues/4424).
- Dynamic schemas: an `undefined` initial schema can break reactivity of later schema updates (https://github.com/logaretm/vee-validate/issues/4624); prefer a schema that exists up front.

## Known open issues (cite, do not restate as fixed)

- `handleSubmit.withControlled` includes all values when a typed schema is present: https://github.com/logaretm/vee-validate/issues/4960
- `FieldArray` with radio inputs inside items misbehaves: https://github.com/logaretm/vee-validate/issues/5013
- `setFieldValue` types are unreliable for bracket array paths: https://github.com/logaretm/vee-validate/issues/5074
- `useFieldArray` error types are imprecise: https://github.com/logaretm/vee-validate/issues/4721
- `meta.valid` can stay `false` with no errors after remounting steps (labeled v5): https://github.com/logaretm/vee-validate/issues/4630
- `meta.dirty` always `true` when `initialValues` contains optional fields: https://github.com/logaretm/vee-validate/issues/4697
- i18n locale switch does not re-generate messages reactively: https://github.com/logaretm/vee-validate/issues/4672

## Devtools

- `@vue/devtools-api ^7.5.2` is a runtime dependency (`package.json:45`); CJS interop errors with older bundler setups are tracked at https://github.com/logaretm/vee-validate/issues/4863
- Devtools integration appears in Vue devtools; forms are identified by `name` when provided.
