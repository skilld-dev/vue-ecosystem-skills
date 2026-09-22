# New functions: v14.4.0 and v15.0.0

Signatures are taken from the prepared types (`dist/index.d.ts`).

## `useWebMCP` (v15.0.0)

Registers a [WebMCP](https://github.com/webmachinelearning/webmcp) tool on the
experimental `document.modelContext` and ties registration to the current
scope. Feature-detects and no-ops where absent. Docs:
<https://vueuse.org/useWebMCP>. Types: `dist/index.d.ts:5402-5516`.

```ts
const { isSupported, isRegistered, error } = useWebMCP({
  name: 'add-to-cart',                       // tool id the agent calls
  description: 'Adds an item to the shopping cart',
  inputSchema: {                             // JSON Schema for args
    type: 'object',
    properties: { sku: { type: 'string' } },
    required: ['sku'],
  },
  execute: ({ sku }) => cart.add(sku),       // may be async; thrown Errors
                                             // become isError results
  enabled: () => storeOpen.value,            // register only while true
})
```

- `name`, `description`, `inputSchema`, `annotations`, `enabled` accept
  reactive getters; changes re-register the tool.
- `formatOutput(result, args)` shapes results; `onError` handles failures.
- Returns `{ isSupported, isRegistered, error }` (`error` holds e.g. a
  permissions-policy `NotAllowedError`).

## `useTemporalNow` (v15.0.0)

Reactive Temporal API returning a `Temporal.ZonedDateTime` ref. Docs:
<https://vueuse.org/useTemporalNow>. Types: `dist/index.d.ts:4625-4703`.

```ts
const { now, timezone, pause, resume } = useTemporalNow({ timezone: 'Europe/Berlin' })

now.value.toPlainDate()        // Temporal.PlainDate
now.value.add({ hours: 1 })    // arithmetic
now.value.format({ dateStyle: 'full', timeStyle: 'short' })
```

- `timezone` defaults to `'UTC'` (`dist/index.d.ts:4625-4634`).
- Returns helpers: `toTimezone`, `toCalendar`, `toPlainDate`, `toPlainTime`,
  `toPlainDateTime`, `format`, `add`, `subtract`, `compare`.
- Pass `temporal` to supply `@js-temporal/polyfill` or another polyfill instead
  of the global `Temporal` (option documented at `dist/index.d.ts:4625` region).
- Extends `ConfigurableScheduler`; drive updates with `scheduler` if needed.

## `useLiveAnnouncer` (v15.0.0)

Screen-reader announcements via aria-live regions. Docs:
<https://vueuse.org/useLiveAnnouncer>. Types: `dist/index.d.ts:3121-3134`.

```ts
const { announce, polite, assertive } = useLiveAnnouncer()

polite('Saved draft')                       // polite live region
assertive('Connection lost')                // assertive live region
announce('Saved', 'polite', 500)            // explicit form
```

- `timeout` clears the message after ms so repeated announcements re-announce.
- `idPrefix` (default `'vueuse-live-announcer'`) isolates announcer elements.

## `useElementOverflow` (v14.4.0)

Tracks whether an element overflows its box. Docs:
<https://vueuse.org/useElementOverflow>. Types: `dist/index.d.ts:1991-2016`.

```ts
const { isXOverflowed, isYOverflowed, stop, update } = useElementOverflow(el)
```

- Returns readonly booleans plus manual `update()` and `stop()`; mutations of
  size or children update automatically via ResizeObserver.
