# API changes: 2.0.0 → 2.1.2

All release citations point to GitHub release notes; content is not
duplicated here.

## v2.0.0 (2026-04-02)

https://github.com/formkit/formkit/releases/tag/v2.0.0

- Added the React package; `@formkit/core` remains the framework-agnostic
  base for both the Vue and React adapters.
- No `@formkit/core` API removals or signature changes are listed in the
  release notes. Code written against 1.x core APIs (nodes, store, ledger,
  hooks, registry) compiles against 2.x unchanged.
- Note for surrounding packages: `@formkit/vue` declared Vue as a peer
  dependency starting in 1.6.0 — if upgrading a whole app from 1.x, verify
  the Vue peer install.

## v2.1.0 (2026-06-10)

https://github.com/formkit/formkit/releases/tag/v2.1.0

Core-relevant fixes (release notes, **core** section):

- Preserve buffered reset events — emitter buffering during `reset()` no
  longer drops events.
- Avoid repeated reset input hooks — `reset()` runs input hooks once.
- Preserve reset invalid state.
- Apply explicit reset values to all node types — `reset(id, value)` now
  honors the explicit value for group/list/input alike.
- Resolve prototype members in compiled tail access — `$token.method`
  expressions now bind prototype-inherited functions.

Behavioral impact: if code depended on `reset()` dropping buffered events or
skipping explicit values on non-input nodes, 2.1.0 changes that behavior.

## v2.1.1 (2026-07-24)

https://github.com/formkit/formkit/releases/tag/v2.1.1

- Vue-only fix (destroy node in `onSSRComplete`). No core API change.

## v2.1.2 (2026-07-24)

https://github.com/formkit/formkit/releases/tag/v2.1.2

Core fixes:

- Remove parentless nodes — the registry now deregisters nodes without a
  parent during teardown.
- Guard repeated config removal — repeated `config._rmn` writes no longer
  double-run root config removal.

## Upgrade checklist (1.x → 2.1.2)

1. `@formkit/core`, `@formkit/utils` (and any adapter) must all be on 2.x;
   the prepared source pins `@formkit/utils@^2.1.2` (`package.json:38-40`).
2. Audit for same-`name` sibling inputs; adopt
   `config.mergeStrategy = { name: 'synced' }` where unavoidable.
3. If you wrapped `reset()` behavior, re-test explicit reset values on group
   and list nodes (2.1.0 change).
4. Run the official changelog for anything outside core:
   https://formkit.com/changelog
