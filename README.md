<h1>vue-ecosystem-skills</h1>

[![license](https://img.shields.io/github/license/skilld-dev/vue-ecosystem-skills?color=yellow)](https://github.com/skilld-dev/vue-ecosystem-skills/blob/main/LICENSE)

> AI agent skills for the bleeding edge Vue ecosystem. Built from real docs, issues, and releases.

## Why?

Getting agents to follow the latest conventions in the Vue ecosystem is difficult. All agents still struggle with [Vue 3.5](https://blog.vuejs.org/posts/vue-3-5) APIs out of the box - and with Vue 3.6 on the horizon alongside recent releases for [Pinia v3](https://github.com/vuejs/pinia/blob/v3/packages/pinia/CHANGELOG.md), [Vue Router v5](https://github.com/vuejs/router/blob/main/packages/router/CHANGELOG.md), [Reka UI v2](https://github.com/unovue/reka-ui), and [VueUse v14](https://github.com/vueuse/vueuse), getting the right context to agents is as important as ever.

Hand-crafted rules are great, but maintaining them is a burden - especially when working across several packages that are all actively releasing. Author-shipped skills ([skills-npm](https://github.com/antfu/skills-npm)) are the ideal solution, but most Vue libraries don't ship them yet.

This repo bridges the gap: pre-generated skills from real sources (docs, GitHub issues, discussions, changelogs) using [skilld](https://github.com/harlan-zw/skilld). Install once, get version-aware context for the entire Vue ecosystem - no manual curation, no author opt-in, and no LLM tokens spent on generation.

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

- 📦 **Bleeding Edge Context**: Always use the latest best practices and avoid deprecated patterns.
- 📚 **Unopinionated**: Just follows the docs, no personal biases or opinions injected
- 🔬 **Deep References**: Real GitHub issues, discussions, and changelogs
- 🎯 **Version-Aware**: API changes and best practices tied to specific package versions
- 🍋 **Always up-to-date**: Hooked into ecosystem releases so you're always working with the latest best practices
- 🤝 **Ecosystem**: Compatible with [`npx skills`](https://skills.sh/) and [skilld](https://github.com/harlan-zw/skilld)

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

### Core

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue              # 3.6.0-beta.6
npx skilld add skilld-dev/vue-ecosystem-skills --skill pinia            # 3.0.4
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue-router       # 5.0.2
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue-test-utils   # 2.4.6
npx skilld add skilld-dev/vue-ecosystem-skills --skill unhead           # 2.1.4
```

### Data & State

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill pinia-colada          # 0.21.4
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-query    # 5.92.9
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-store    # 0.9.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-table    # 8.21.3
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-virtual  # 3.13.18
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-form     # 1.28.3
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-vue-router   # 1.160.0
npx skilld add skilld-dev/vue-ecosystem-skills --skill tanstack-ai-vue       # 0.5.4
```

### UI

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill reka-ui          # 2.8.0
npx skilld add skilld-dev/vue-ecosystem-skills --skill shadcn-vue       # 2.4.3
npx skilld add skilld-dev/vue-ecosystem-skills --skill primevue         # 4.5.4
npx skilld add skilld-dev/vue-ecosystem-skills --skill vuetify          # 4.0.0-beta.2
npx skilld add skilld-dev/vue-ecosystem-skills --skill quasar           # 2.18.6
npx skilld add skilld-dev/vue-ecosystem-skills --skill floating-ui-vue  # 1.1.10
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue-data-ui      # 3.15.2
npx skilld add skilld-dev/vue-ecosystem-skills --skill unovis-vue       # 1.6.4
```

### Forms

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill formkit          # 1.7.2
npx skilld add skilld-dev/vue-ecosystem-skills --skill vee-validate     # 4.15.1
```

### Animation

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill motion-vue       # 2.0.0-beta.4
```

### VueUse

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-core           # 14.2.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-shared         # 14.2.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-components     # 14.2.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-integrations   # 14.2.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-math           # 14.2.1
npx skilld add skilld-dev/vue-ecosystem-skills --skill vueuse-motion         # 3.0.3
```

### Tooling

```bash
npx skilld add skilld-dev/vue-ecosystem-skills --skill vue-i18n     # 11.2.8
npx skilld add skilld-dev/vue-ecosystem-skills --skill vitepress    # 1.6.4
npx skilld add skilld-dev/vue-ecosystem-skills --skill tresjs       # 5.5.0
```

## Related

- [skilld](https://github.com/harlan-zw/skilld) - Generate AI agent skills from your NPM dependencies
- [vuejs-ai/skills](https://github.com/vuejs-ai/skills) - Hand-crafted Vue 3 best practices skills
- [antfu/skills](https://github.com/antfu/skills) - Anthony Fu's curated skills for Vue/Vite/Nuxt
- [vueuse/vueuse-skills](https://github.com/vueuse/vueuse-skills) - Agent skills for VueUse
- [onmax/nuxt-skills](https://github.com/onmax/nuxt-skills) - Agent skills for Nuxt
- [RuleKit](https://rulekit.dev) - Paid curated agent rules for Vue/Nuxt by posva

## License

Licensed under the [MIT license](https://github.com/skilld-dev/vue-ecosystem-skills/blob/main/LICENSE).
