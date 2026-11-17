<h1>vue-ecosystem-skills</h1>

[![license](https://img.shields.io/github/license/skilld-dev/vue-ecosystem-skills?color=yellow)](https://github.com/skilld-dev/vue-ecosystem-skills/blob/main/LICENSE)

> AI agent skills for the bleeding edge Vue ecosystem. Built from real docs, issues, and releases.

## Why?

Getting agents to follow the latest conventions in the Vue ecosystem is difficult. All agents still struggle with [Vue 3.5](https://blog.vuejs.org/posts/vue-3-5) APIs out of the box - and with Vue 3.6 on the horizon alongside recent releases for [Pinia v3](https://github.com/vuejs/pinia/blob/v3/packages/pinia/CHANGELOG.md), [Vue Router v5](https://github.com/vuejs/router/blob/main/packages/router/CHANGELOG.md), [Reka UI v2](https://github.com/unovue/reka-ui), and [VueUse v14](https://github.com/vueuse/vueuse), getting the right context to agents is as important as ever.

Hand-crafted rules are great, but maintaining them is a burden - especially when working across several packages that are all actively releasing. Author-shipped skills ([skills-npm](https://github.com/antfu/skills-npm)) are the ideal solution, but most Vue libraries don't ship them yet.

This repo bridges the gap: pre-built Skills from real sources (docs, GitHub issues, discussions, changelogs). Maintainers and contributors rebuild Skills from published packages with `skilld-harness`. Updates start manually and reach this collection through reviewed pull requests. See [Updating Skills](#updating-skills) to contribute.

<p align="center">
<table>
<tbody>
<td align="center">
<sub>Made possible by my <a href="https://github.com/sponsors/harlan-zw">Sponsor Program 💖</a><br> Follow me <a href="https://twitter.com/harlan_zw">@harlan_zw</a> 🐦 • Join <a href="https://discord.gg/275MBUBvgP">Discord</a> for help</sub><br>
</td>
</tbody>
</table>
</p>

## Features

- 📦 **Package Context**: Best practices and API changes for each Skill's recorded package version.
- 📚 **Unopinionated**: Just follows the docs, no personal biases or opinions injected
- 🔬 **Deep References**: Real GitHub issues, discussions, and changelogs
- 🎯 **Version-Aware**: API changes and best practices tied to specific package versions
- 🍋 **Update Checks**: Compare recorded package versions with npm before rebuilding Skills.
- 🤝 **Ecosystem**: Compatible with [`npx skills`](https://skills.sh/) and [skilld](https://github.com/skilld-dev/skilld)

## Quick Start

```bash
npx skilld add skilld-dev/vue-ecosystem-skills
```

Or if you prefer [skills.sh](https://skills.sh/):

```bash
npx skills add skilld-dev/vue-ecosystem-skills
```

**Ensure skills are used** - Add this to your agent file (e.g. `CLAUDE.md`, `.cursorrules`):

```
Before modifying code, evaluate each installed skill against the current task.
For each skill, determine YES/NO relevance and invoke all YES skills before proceeding.
```

### Claude Code Marketplace

```bash
# Add marketplace
/plugin marketplace add skilld-dev/vue-ecosystem-skills

# Install a skill (run once per skill)
/plugin install pinia@vue-ecosystem-skills
/plugin install vue-router@vue-ecosystem-skills
/plugin install reka-ui@vue-ecosystem-skills
```

## Available Skills

Versions below describe the generated Skills, as recorded in [skills-lock.json](skills-lock.json).
They do not track npm releases automatically.

### Core

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue              # 3.6.0-beta.17
npx skilld add skilld-dev/vue-ecosystem-skills --skill pinia            # 4.0.3
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue-router       # 5.3.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue-test-utils   # 2.5.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill unhead           # 3.4.1
```

### Data & State

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill pinia-colada          # 1.4.5
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-query    # 5.103.2
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-store    # 0.11.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-table    # 9.2.4
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-virtual  # 3.13.39
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-form     # 1.33.5
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-router   # 1.170.35
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-ai-vue       # 0.24.3
```

### UI

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill reka-ui          # 2.10.5
npx skilld add skilld-dev/vue-ecosystem-skills --skill shadcn-vue       # 2.8.2
npx skilld add skilld-dev/vue-ecosystem-skills --skill primevue         # 5.0.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill vuetify          # 4.0.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill quasar           # 2.33.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill floating-ui-vue  # 2.0.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue-data-ui      # 3.25.9
npx skilld add skilld-dev/vue-ecosystem-skills --skill unovis-vue       # 1.7.0
```

### Forms

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill formkit          # 2.1.2
npx skilld add skilld-dev/vue-ecosystem-skills --skill vee-validate     # 4.15.1
```

### Animation

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill motion-vue       # 2.4.4
```

### VueUse

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-core           # 15.0.0
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-shared         # 15.0.0
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-components     # 15.0.0
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-integrations   # 15.0.0
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-math           # 15.0.0
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-motion         # 3.0.3
```

### Tooling

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue-i18n     # 11.4.12
npx skilld add skilld-dev/vue-ecosystem-skills --skill vitepress    # 1.6.4
npx skilld add skilld-dev/vue-ecosystem-skills --skill tresjs       # 5.9.0
```

## Updating Skills

Updates are manual. [packages.json](packages.json) selects the packages and release channels.
[skills-lock.json](skills-lock.json) records each generated version.
Most packages use `latest`; Vue uses `beta`, and Vuetify uses `next`.
Preserve those channels when rebuilding.

From a fork's checkout, use Node.js 22 and the pinned pnpm version from [package.json](package.json).

1. Install dependencies and check which packages changed:

   ```sh
   pnpm install --frozen-lockfile
   pnpm sync:check
   ```

   The check reports packages that need a rebuild. It changes no files and needs no generation credentials.

2. For generation, set `OPENCODE_API_KEY` in your environment, or sign in with `opencode auth login`.
   Never commit credentials. Generation uses OpenCode through `skilld-harness` and can take several minutes per Skill.

3. Rebuild only the packages you want to contribute:

   ```sh
   pnpm sync pinia vue-router vuetify@next
   ```

   Named packages rebuild even when their recorded versions match npm.
   Without package arguments, `pnpm sync` rebuilds all packages that changed or lack a lockfile record.

4. Check the generated Skills:

   ```sh
   pnpm validate
   ```

   Review API changes, source links, and references against [the collection guidelines](CLAUDE.md#guidelines).
   Update the version comments above from `skills-lock.json` for each rebuilt Skill.
   Open a pull request with the changed `skills/` files, `skills-lock.json`, and README version comments.

Maintainers can also start the [Sync Skills workflow](.github/workflows/sync-skills.yml) by hand.
It requires the `OPENCODE_API_KEY` repository secret and opens a pull request when generated files change.
Its optional `packages` input accepts space-separated package specifiers, including tags such as `vuetify@next`.
Leave it empty to rebuild packages that changed. The workflow does not update README version comments; include them during review.

## Related

- [skilld](https://github.com/skilld-dev/skilld) - Search, run, and install curated Agent Skills
- [vuejs-ai/skills](https://github.com/vuejs-ai/skills) - Hand-crafted Vue 3 best practices skills
- [antfu/skills](https://github.com/antfu/skills) - Anthony Fu's curated skills for Vue/Vite/Nuxt
- [vueuse/vueuse-skills](https://github.com/vueuse/vueuse-skills) - Agent skills for VueUse
- [onmax/nuxt-skills](https://github.com/onmax/nuxt-skills) - Agent skills for Nuxt
- [RuleKit](https://rulekit.dev) - Paid curated agent rules for Vue/Nuxt by posva

## License

Licensed under the [MIT license](https://github.com/skilld-dev/vue-ecosystem-skills/blob/main/LICENSE).
