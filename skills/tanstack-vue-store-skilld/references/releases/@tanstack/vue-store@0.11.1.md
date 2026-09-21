---
tag: @tanstack/vue-store@0.11.1
version: 0.11.1
published: 2026-08-05
---

# @tanstack/vue-store@0.11.1

### Patch Changes

-   Updated dependencies \[[`1d7c87e`](https://github.com/TanStack/store/commit/1d7c87e9a3e465fbc88d1a57c46e7b454ee3eb65)\]:
    -   @tanstack/store@0.11.1

## Core @tanstack/store@0.11.1

### Patch Changes

-   Inline reactive flag constants in generated builds to improve tree-shaking. ([#350](https://github.com/TanStack/store/pull/350))

No Vue adapter API changes. Verified against the prepared source: `src/index.ts` re-exports `@tanstack/store` plus `useSelector`, `useAtom`, `useStore` (deprecated), `_useStore`.
