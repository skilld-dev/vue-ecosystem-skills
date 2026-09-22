# Mounting options and config

All signatures come from the prepared source `dist/src/types.d.ts`, `dist/src/mount.d.ts`, and `dist/src/renderToString.d.ts`. Official reference: https://test-utils.vuejs.org/api/

## mount and shallowMount

```ts
mount(Component, options?)
```

`Component` is a component definition, SFC import, or functional component. `shallowMount` has the same signature and stubs every child component (`dist/src/mount.d.ts:22`). `ComponentMountingOptions` types `slots` keys against the component's declared slots (`dist/src/mount.d.ts:10-16`).

## Top-level options (BaseMountingOptions, dist/src/types.d.ts:21-58)

| Option | Type | Notes |
|---|---|---|
| `props` | `(RawProps & Props) \| null` | Props for the mounted component. Deprecated alias: `propsData` (`dist/src/types.d.ts:33-35`) |
| `data` | `() => Partial<Data>` | Overrides component data; must be a function |
| `attrs` | `Record<string, unknown>` | Non-prop attributes |
| `slots` | `Record<string, Slot>` | `default`, named, and scoped slots. Values: string template, `VNode`, function, component, or `{ template }` (`dist/src/types.d.ts:11-16`) |
| `global` | `GlobalMountOptions` | See below |
| `shallow` | `boolean` | Same effect as `shallowMount` |
| `attachTo` | `Element \| string` | Mount into a real element; required for code that needs `document` focus or layout (`dist/src/types.d.ts:68`). Not available for `renderToString` |

## global options (dist/src/types.d.ts:81-132)

| Option | Type | Notes |
|---|---|---|
| `plugins` | `(Plugin \| [Plugin, ...any[]])[]` | Installed on the test app; pass stores and routers here |
| `config` | `Partial<AppConfig>` | Vue app config, e.g. `errorHandler` |
| `mixins` | `ComponentOptions[]` | |
| `mocks` | `Record<string, any>` | Mocks global instance properties such as `$route`; meant for third-party plugin injections, not Vue internals |
| `provide` | `Record<any, any>` | Values for `inject()`; wrap symbol keys: `{ [key as symbol]: value }` |
| `components` | `Record<string, Component>` | Globally registered components |
| `directives` | `Record<string, Directive>` | Globally registered directives |
| `stubs` | `Record<string, Stub> \| string[]` | `Stub = boolean \| Component \| Directive` (`dist/src/types.d.ts:79-80`). Stub directives with `vName` keys. `transition` and `transition-group` are stubbed by default |
| `renderStubDefaultSlot` | `boolean` | Render default slot content inside stubs; default `false` |

## renderToString

```ts
renderToString(Component, options?): Promise<string>
```

SSR rendering; options are the same as `mount` except `attachTo` is not allowed (`dist/src/types.d.ts:73-78`, `dist/src/renderToString.d.ts:4`). Requires the optional `@vue/server-renderer` peer. Added in 2.3.0.

## The config object (dist/src/config.d.ts:5-32)

`config` sets defaults for every mount. Mutate it once in test setup.

```ts
import { config } from '@vue/test-utils'

config.global.stubs = { transition: true }
config.global.renderStubDefaultSlot = true
config.global.mocks = { $t: (key: string) => key }
```

- `config.global` mirrors the `global` mounting option and applies to all mounts.
- `config.plugins.VueWrapper` / `config.plugins.DOMWrapper`: extend wrapper classes with custom methods via `install(handler)`.
- `config.plugins.createStubs`: replace the built-in stub factory. Signature `CustomCreateStub({ name, component, registerStub }) => ConcreteComponent` (`dist/src/vnodeTransformers/stubComponentsTransformer.d.ts:3-10`).
- `config.renderStubDefaultSlot` (top level) is deprecated; use `config.global.renderStubDefaultSlot` (`dist/src/config.d.ts:14-17`).

## Stub keys

- Component name or kebab-case tag: `Foo`, `'foo-bar'`; stubs render as `<foo-stub>` / `<foo-bar-stub>`.
- Directive: `vTooltip` stubs `v-tooltip`.
- Built-ins: `teleport`, `transition`, `transition-group`, `KeepAlive` can be stubbed or replaced with components.

Since 2.5.1, config is shared across the CJS and ESM builds, so a config set via one entry point applies everywhere (https://github.com/vuejs/test-utils/releases/tag/v2.5.1).
