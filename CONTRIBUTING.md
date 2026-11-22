# Contributing

Improvements are welcome — new skills, better checks, framework updates, fewer false positives.
Many will arrive as pull requests from the agent's own `improve` skill.

## The one rule: no company data
This repository is public. Never commit anything from an `ai-team/` workspace or a product
repository: names, hostnames, domains, IP addresses, account IDs, repository names, secrets or any
part of one, vulnerability details of a real system, dates of private events, quotes from private
documents. Use neutral examples ("a Node.js API", "a cloud storage bucket").

## What goes where
| Change | File |
|---|---|
| A rule every company should follow | `RULES.md` (rules may be added or clarified, never weakened) |
| A procedure | `skills/<skill>/SKILL.md` (new skill → new folder + row in RULES.md skills table) |
| A document format | `templates/` |
| A framework, version or source | the skill that uses it + `docs/research.md` |
| A documentation site to allow | `skills/setup/permissions.json` |
| Workspace files | `skills/setup/workspace/` + a **Migration** note in `CHANGELOG.md` |

Hard rules that may never be weakened: company-owned assets only · never attack, scan or exploit
third-party systems · never print secrets · report vulnerabilities privately · evidence for every
finding · escalation · never invent · confidentiality · never act for the company.

Contributions that add offensive capability (exploit code, scanning outside the asset register,
evasion) are not accepted.

## Release
1. Bump `version` in `.claude-plugin/plugin.json` (patch / minor / major — see CHANGELOG).
2. Add a `CHANGELOG.md` entry (with a Migration step if the workspace changes).
3. `claude plugin validate .` must pass.
4. Merge to `main`. Users get it with `/plugin update ai-security@ai-team`.
