# Migration and versions

## v3.0.0 (2025-03-10): breaking

- CJS support dropped; the package is ESM-only. `require('@vueuse/motion')` fails; migrate the consumer to ESM or use dynamic `import()` (`package.json:2,31-35`; https://github.com/vueuse/motion/pull/254).
- Dependency baseline moved to VueUse v13 (`@vueuse/core`, `@vueuse/shared` ^13.0.0, `package.json:83-84`). See https://github.com/vueuse/motion/releases/tag/v3.0.0

## v3.0.1 - v3.0.3: fixes

- 3.0.1/3.0.2: maintenance releases after the v3 line (https://github.com/vueuse/motion/releases).
- 3.0.3: Nuxt build type externalization fix; `defu` added to dependencies. If you saw missing-module errors for `defu` in Nuxt, 3.0.3 fixes it (https://github.com/vueuse/motion/releases/tag/v3.0.3).

## Still-true facts inherited from v2

- Vue 2 support was dropped in v2.0.0; v3 is Vue 3 only (https://github.com/vueuse/motion/releases/tag/v2.0.0).
- `<Motion>`/`<MotionGroup>`, `delay`/`duration` shorthand props, and `useMotionFeatures` export landed across v2.1.0 - v2.2.6 and are present in v3 (https://github.com/vueuse/motion/releases).

## Nightly channel

Install pre-release builds with `npm install @vueuse/motion@npm:vueuse-motion-nightly` (`README.md:74-80`). The nightly tag tracks `main`; expect instability.

## Package facts (3.0.3)

- Exports: `.` -> `dist/index.mjs`, `./nuxt` -> `dist/nuxt/module.mjs`; types via `dist/index.d.mts` and `dist/nuxt/module.d.mts` (`package.json:31-44`).
- Runtime deps: `popmotion` ^11, `framesync` ^6, `style-value-types` ^5, `defu` ^6 (`package.json:82-89`).
- Peer: `vue >=3.0.0`; optional: `@nuxt/kit ^3.13.0` (`package.json:79-92`).
- Animation engine is Popmotion; for a WAAPI-based alternative the maintainers point to Motion.dev (`README.md:86`).
- Docs: https://motion.vueuse.org; demos: https://vueuse-motion-demo.netlify.app; repo: https://github.com/vueuse/motion.
