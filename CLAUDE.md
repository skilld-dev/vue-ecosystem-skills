# Vue Ecosystem Skills — Development Guide

## Skill Scopes

`packages.json` lists every package with a Skill.
`skills-lock.json` records the version each Skill was built from.

## Skill Structure

Each skill follows a consistent structure:

```
skills/<name>/
├── SKILL.md                    # Overview with API changes + best practices
└── references/
    └── <topic>.md              # One topic each, linked from SKILL.md
```

## Guidelines

- SKILL.md must stay under 500 lines — use references for deep-dive content
- At most eight reference files per Skill, one topic each, every one linked from SKILL.md
- Cite release notes, issues, and discussions by URL. Never copy them into the repository
- API Changes section: only version-specific additions and breaking changes with `[source]` links
- Best Practices section: patterns derived from official docs, not general JS knowledge
- All code examples must be TypeScript + Composition API unless the skill specifically targets Options API

## Keeping Skills current

`packages.json` names every package this repository maintains a Skill for.
`skills-lock.json` records the version each Skill was built from.

```sh
pnpm validate                   # check every Skill against the rules below
pnpm sync:check                 # report which packages moved ahead of the lockfile
pnpm sync                       # rebuild every Skill whose package moved
pnpm sync @vueuse/core pinia    # rebuild named packages, whatever the lockfile says
```

The sync runs `generate-package-skill` through `skilld-harness`, using OpenCode
as the agent runtime and `skilld-harness/sandbox-local` as the sandbox.
It needs `OPENCODE_API_KEY`, or an `opencode auth login` session on this computer.

Choose the model with `--model=` or `SKILLD_MODEL`.
Choose how many run at once with `--concurrency=` or `SKILLD_CONCURRENCY`.

One Skill takes about four to seven minutes to rebuild.

The Sync Skills workflow runs the same thing on GitHub, and only when you start
it by hand. It needs an `OPENCODE_API_KEY` repository secret, and it opens a
pull request rather than pushing to `main`.
