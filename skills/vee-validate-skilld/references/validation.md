# Validation reference

## Rule syntaxes

A rule returns `true`, a message `string`, an array of messages (since 4.10.0), or a promise of either (`GenericValidateFunction`, `dist/vee-validate.d.ts:318`). Validators receive `(value, ctx)` where `ctx` is `FieldValidationMetaInfo` with `field`, `name`, `label`, `value`, `form` (`dist/vee-validate.d.ts:157-167`) — use `ctx.form` for cross-field validation.

```ts
const isStrong = (value: string) =>
  value.length >= 8 || 'Use at least 8 characters';

const { defineField } = useForm({
  validationSchema: {
    password: [isStrong, mustContainDigit], // array of validators runs in order, bails by default
  },
});
```

## Object schemas

Object schemas map field paths to rules, strings (global rule syntax), or nested objects. Field-level with `useField`: pass the rule expression directly. Form-level paths support dot and bracket notation (`RawFormSchema`, `dist/vee-validate.d.ts:359`).

## Typed schemas (yup, zod, valibot)

Wrap third-party schemas with `toTypedSchema` from the matching adapter package, then pass to `validationSchema`. `InferOutput`/`InferInput` differentiate the submitted type from the form type (`dist/vee-validate.d.ts:200-201`), useful for schemas that transform values (e.g. zod coercion, `z.coerce.number()`).

```ts
import { toTypedSchema } from '@vee-validate/zod';
import * as z from 'zod';

const schema = toTypedSchema(
  z.object({
    email: z.string().email(),
    age: z.coerce.number().min(18),
  })
);

const { handleSubmit } = useForm({ validationSchema: schema });
```

Passing a raw yup/zod schema without `toTypedSchema` produces "No such validator 'VVTypedSchema' exists" (https://github.com/logaretm/vee-validate/discussions/4819). Schema casts apply on submit and on `resetForm` (since 4.10.6). Sources: https://vee-validate.logaretm.com/v4/guide/composition-api/typed-schema/, https://vee-validate.logaretm.com/v4/integrations/zod-schema-validation/

Zod 4 requires `@vee-validate/zod >= 4.15.0` (https://github.com/logaretm/vee-validate/issues/5027).

## Global validators (legacy, string rules)

`defineRule(id, validator)` registers string rules usable as `'required|email'` or `{ required: true, min: 2 }` (`dist/vee-validate.d.ts:504`). The `@vee-validate/rules` package ships 25+ rules; `@vee-validate/i18n` ships 45+ locales (README:50-51). Global rules need a message source: `configure({ generateMessage })` or the i18n package (https://vee-validate.logaretm.com/v4/guide/global-validators/, https://vee-validate.logaretm.com/v4/guide/i18n/).

String rules work without any of this when every rule is a function; the typed/composition path is preferred for new code.

## Global configuration

```ts
import { configure } from 'vee-validate';

configure({
  bails: true,                  // stop on first failing rule (per validator array; yup unaffected)
  validateOnBlur: true,
  validateOnChange: true,
  validateOnInput: false,
  validateOnModelUpdate: true,
  generateMessage: ctx => `${ctx.field} is invalid`,
});
```

`VeeValidateConfig` at `dist/vee-validate.d.ts:506-514`. The four `validateOn*` flags only affect `<Field>` components, not `useField` (https://vee-validate.logaretm.com/v4/api/configuration/).

## Standalone validation utils

- `validate(value, rules, options?)`: validate a single value outside any form (`dist/vee-validate.d.ts:492`).
- `validateObject(schema, values)`: validate an object against a form schema (`dist/vee-validate.d.ts:493-499`).
- `normalizeRules`, `isNotNestedPath`, `cleanupNonNestedPath`: path and rule helpers (`dist/vee-validate.d.ts:519-526`).

## Async validation

Return a promise from a validator. `meta.pending` (field) and `isValidating` (form, since 4.9.3) track in-flight validation. To avoid flicker, disable submit on `isSubmitting || isValidating` (https://vee-validate.logaretm.com/v4/examples/async-validation).
