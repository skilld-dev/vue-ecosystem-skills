---
title: "Pull Requests | Unovis"
meta:
  "og:description": Rebasing
  "og:title": "Pull Requests | Unovis"
  description: Rebasing
---

## Rebasing [](#rebasing "Direct link to Rebasing")

Before creating a pull request, make sure your branch is up-to-date with the main branch. We recommend rebasing your branch on the main branch to avoid merge conflicts and keep the commit history clean.

```
git checkout main && git pullgit checkout <your-branch> && git rebase maingit push --force
```

## Commit Messages [](#commit-messages "Direct link to Commit Messages")

Commits should have the following format:

```
git commit -m "<type> | <scope>: <subject>"
```

Rules:

- **type** can be any of the following: `Core`, `Component`, `Container`, `Utils`, `Styles` - for core library changes `Angular`, `React`, `Svelte`, `Vue`, `Solid` - for wrapper related changes `Website` - for changes related to website content `Dev`, `Shared` - for changes to the demo app, dev tools or integrations `CI` - for CI/CD pipeline related changes `Release` - for release commits `Misc` - anything else
- **scope** should be the name of the component or feature being worked on in _PascalCase_
- Additional **scope** values can be added with `|` delimiter
- **subject** is a short description of the change in _Sentence case_
- A reference `<#issue>` may also be provided on the next line
- No leading or trailing whitespace in the header

note

- Scope is optional but encouraged for all types except `CI` or `Release`
- For `Component` type, scope should be one of the component names

Some examples:

```
"Core | Utils: Refactoring shape rendering helpers""Component | Timeline: Fixing enter transition bug""Dev | Build: Upgrading rollup dependency""React | Autogen: Tweaking component lifecycle logic""Release: 1.4.0""Website | Gallery: Adding a new example""Website | Docs | Axis: Updating some property description"
```

- [Rebasing](#rebasing)
- [Commit Messages](#commit-messages)