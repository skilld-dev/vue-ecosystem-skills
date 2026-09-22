# API surface

Complete runtime export list of `vee-validate@4.15.1`, from `dist/vee-validate.mjs:3947`. Type signatures in `dist/vee-validate.d.ts` (line references below).

## Components

| Export | Kind | d.ts |
| --- | --- | --- |
| `Form` | component | 950 |
| `Field` | component | 583 |
| `FieldArray` | component | 1205 |
| `ErrorMessage` | component | 1272 |

## Composables

| Export | Purpose | d.ts |
| --- | --- | --- |
| `useForm` | create form context | 1366 |
| `useFormContext` | nearest form context (since 4.14.0) | 1367 |
| `useField` | create standalone/shared field | 558 |
| `useFieldArray` | array field operations | 1369 |
| `useResetForm` | reset action factory | 1371 |
| `useIsFieldDirty` / `useIsFieldTouched` / `useIsFieldValid` | field meta | 1376-1386 |
| `useIsFormDirty` / `useIsFormTouched` / `useIsFormValid` | form meta | 1406-1416 |
| `useIsSubmitting` / `useIsValidating` / `useSubmitCount` | submission state | 1391, 1396, 1426 |
| `useValidateField` / `useValidateForm` | validation actions | 1401, 1421 |
| `useFieldValue` / `useFieldError` | field state readers | 1431, 1446 |
| `useFormValues` / `useFormErrors` | form state readers | 1436, 1441 |
| `useSubmitForm` | submit factory | 1448 |
| `useSetFieldValue` / `useSetFieldError` / `useSetFieldTouched` | field setters (since 4.11.0) | 1453-1463 |
| `useSetFormValues` / `useSetFormErrors` / `useSetFormTouched` | form setters (since 4.11.0) | 1468-1478 |

## Utilities and tokens

| Export | Purpose | d.ts |
| --- | --- | --- |
| `validate` | one-off value validation | 492 |
| `validateObject` (`validateObjectSchema`) | schema validation | 493 |
| `defineRule` | register global string rule | 504 |
| `configure` | global config | 514 |
| `normalizeRules` | rule expression to map | 526 |
| `isNotNestedPath` / `cleanupNonNestedPath` | bracket-escaped path helpers | 519, 521 |
| `FormContextKey` / `PublicFormContextKey` / `FieldContextKey` | injection keys | 1480-1482 |
| `IS_ABSENT` | sentinel for absent model value | 1483 |

## Notable exported types

- `Path<T>` / `PathValue<T, P>`: recursive path strings for nested objects and arrays (`dist/vee-validate.d.ts:125-145`).
- `TypedSchema<TInput, TOutput>` with `parse`, optional `cast` and `describe` (`dist/vee-validate.d.ts:191-199`); `InferInput` / `InferOutput` (200-201).
- `FieldMeta<TValue>`: `touched`, `dirty`, `valid`, `validated`, `required`, `pending`, `initialValue` (209-217). `FormMeta<TValues>` (218-224).
- `FieldEntry<TValue>`: `value`, `key`, `isFirst`, `isLast` (272-277).
- `FormValidationResult<TInput, TOutput>`: `valid`, `results`, `errors`, `values`, `source` (340-346).
- `SubmissionContext` extends `FormActions` with `evt` and `controlledValues` (347-351).
- `SchemaValidationMode`: `'validated-only' | 'silent' | 'force'` (231-236).
- `RuleExpression<TValue>`: string, rule map, function, function array, typed schema, or yup schema (554).
- Bind config types for `defineField`: `InputBindsConfig`, `LazyInputBindsConfig`, `BaseFieldProps` (363-394).
