# Version changes (4.9.0 to 4.15.1)

Entries verified against the package changelog (https://github.com/logaretm/vee-validate/blob/main/packages/vee-validate/CHANGELOG.md) and the prepared types. The changelog file is never copied here; consult it by URL for exact wording.

## Breaking changes

- **4.10.0** — v-model support on `useField` disabled by default; opt in with `syncVModel: true` or a model prop name string. Prepared source confirms the default: `syncVModel: false` (`dist/vee-validate.mjs:1862`).
- **4.10.0** — form `values` marked readonly; mutate through `setFieldValue`, `setValues`, or field models.
- **4.10.0** — requires Vue 3.3+ (prepared 4.15.1 requires `vue ^3.4.26`, `package.json:42`).

## Additions

- **4.9.0** — component and input binds helpers (later superseded by `defineField`); path types applied to form API functions.
- **4.9.3** — `isValidating` added to `useForm` and form slot props.
- **4.10.0** — `handleBlur(e?, shouldValidate?)` can trigger validation; `syncVModel` accepts a model prop name; validators may return arrays of messages.
- **4.11.0** — composition setter functions: `useSetFieldValue`, `useSetFieldError`, `useSetFieldTouched`, `useSetFormValues`, `useSetFormErrors`, `useSetFormTouched`.
- **4.11.2** — internal and binds types exported (`BaseInputBinds`, `BaseComponentBinds`).
- **4.12.0** — `label` config in `defineField`; field arrays accept getter paths.
- **4.12.3** — nested field meta querying (`isFieldTouched('user.name')` style paths).
- **4.13.0** — `setValue` on `Field` instance and slot props; `ResetFormOpts.force` for `resetForm`/`useResetForm`; yup schema receives form values as context.
- **4.14.0** — `useFormContext` exported.

## Deprecations (all marked `@deprecated` in `dist/vee-validate.d.ts`)

| Deprecated | Use instead | Since | d.ts |
| --- | --- | --- | --- |
| `useFieldModel` | `defineField` | 4.9+ | 447-451 |
| `defineComponentBinds` | `defineField` | 4.9+ | 455 |
| `defineInputBinds` | `defineField` | 4.9+ | 459 |
| Reactive `initialValues` | plain object or getter | 4.12.0 | — |
| `handleInput` (slot prop) | `handleChange` | 4.4.0 | 581 |
| `valueProp` option | `checkedValue` | — | 537 |
| `standalone` option | `controlled` | — | 545 |
| `modelPropName` option | `syncVModel` | — | 550 |

Note: v5 removes the deprecated `useForm` define methods entirely (changelog `5.0.0-beta.1`, "remove deprecated useForm define methods"); avoid them now.

## Older context

- 4.6.0 — `move(oldIdx, newIdx)` on `FieldArray` (`dist/vee-validate.d.ts:287`).
- 4.1.0 — granular state hooks (`useIsFieldDirty` family, `useFieldValue`).
