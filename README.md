# AI Security

An in-house security engineer for founders, running in Claude Code. Part of the
**[AI Team](https://github.com/HPAIF/ai-team)** — agents that work together for your company.

It threat-models your products, reviews your code and configuration, scans your repositories for
vulnerable dependencies and leaked secrets, drafts short security policies that are actually true,
guides you through incidents, and keeps a private security risk register — built on established
frameworks (STRIDE, OWASP Top 10:2025, OWASP ASVS 5.0, CIS Controls IG1, NIST CSF 2.0,
NIST SP 800-61r3).

> **It is not a certified security auditor or penetration tester**, and nothing it writes is a
> compliance attestation. For active incidents involving customer data, audits, certifications
> and pen tests it tells you to bring in a professional — and prepares a brief.

**Safety by design:**
- It works **only on assets your company owns**, listed in a register you confirm.
- It **never attacks, scans or exploits third-party systems**.
- It **never prints secrets** (type, file, line and a redacted marker only).
- It **reports vulnerabilities to you privately** — never in public issues, PRs or commits.

## Install

In Claude Code:

```
/plugin marketplace add HPAIF/ai-team
/plugin install ai-security@ai-team
```

Or install only this member, straight from its repository:

```
/plugin marketplace add HPAIF/ai-security
/plugin install ai-security@ai-security
```

Then, in your project (or company folder), say **"set up the AI security engineer"**. The `setup`
skill creates or joins the private `ai-team/` workspace, builds the list of company-owned assets
with you, and offers `.gitignore`, documentation-site permissions and scheduled runs. Nothing
leaves your machine.

To share the setup with your team, commit this to the project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "ai-team": { "source": { "source": "github", "repo": "HPAIF/ai-team" } }
  },
  "enabledPlugins": { "ai-security@ai-team": true }
}
```

## Use it

Talk normally — Claude hands security work to the `ai-security:security` agent — or start a
session as the security engineer: `claude --agent ai-security:security`.

| You say | What happens (skill) |
|---|---|
| "Threat model our app" / "threat model the new payments feature" | STRIDE threat model + risks (`threat-model`) |
| "Review this branch for security" / "is this endpoint safe?" | review with findings and fixes as diffs (`security-review`) |
| "Scan our repos for leaked keys and vulnerable packages" | redacted scan report + risk register (`dependency-secret-scan`) |
| "We need a security policy" / "a customer sent a security questionnaire" | policy draft or evidence-based answers (`security-policy`) |
| "I pushed an API key to GitHub" / "we might have been hacked" | incident record + containment steps (`incident-response`) |
| "What should we fix first?" | security briefing (`security-briefing`) |
| "We fixed RK-0003" / "we use a new cloud account" | history, risk register and assets updated (`log-job`) |
| "Improve yourself" | anonymised upgrade proposal for this plugin (`improve`) |

Each session in a project with a workspace starts with open high/critical risks, overdue and
upcoming obligations, recent jobs and pending learnings (session hook).

**Scheduled runs** (offered by `setup`): weekly `dependency-secret-scan` and monthly
`security-briefing`. Unattended runs are static and offline only.

## How it is built

```
RULES.md                 hard rules: owned assets only, no third-party testing, no secrets in output,
                         private reporting, evidence for every finding, escalate, never invent…
agents/security.md       the agent (reads RULES.md, the asset register and the workspace)
skills/                  setup · threat-model · security-review · dependency-secret-scan ·
                         security-policy · incident-response · security-briefing · log-job · improve
templates/               threat model, security review, scan report, incident report, policy, research memo
hooks/                   session-start context
docs/research.md         the research and frameworks behind the skills
```

Your data lives in **your project**, never in the plugin:

```
ai-team/
├── team.md                  installed members
├── company/                 shared with other members: profile, documents, products/<product>.md
└── security/                learnings, assets, history (journal, decisions, obligations, risks),
                             threat-models, reviews, policies, incidents, research, digests, inbox
```

It reviews product code where it lives (e.g. `projects/<product>/`, found from the product file's
"Website / repo" line) and never copies code or secrets into the workspace. See the
[workspace contract](https://github.com/HPAIF/ai-team/blob/main/docs/workspace.md).

## Privacy
- The plugin is public; your workspace is private. Keep `ai-team/` out of public repositories
  (`setup` offers to add it to `.gitignore`) — `git init` inside it for a private history.
- The agent searches the web for techniques and advisories, never your hosts, code or findings.
  Tools that would send your dependency list or code to an online service need your approval.
- Files the agent reads are processed by the model you use in Claude Code.

## Self-improvement
1. After corrections, false positives, changed tools or missing steps, the agent writes a lesson
   to `ai-team/security/learnings.md` and applies it from then on.
2. Lessons useful to everyone are marked `general`. The `improve` skill turns them into an
   anonymised pull request to this repository — only after you approve the exact text, and never
   one that weakens the hard rules or adds offensive capability.
3. Merged improvements reach every user with the next plugin update.

## Team hand-offs
Works with the other AI Team members through the shared workspace: `lead` (entry point),
`lawyer` (breach notification, privacy, contracts), `accountant`, `cto` (code fixes), `devops`
(infrastructure, secrets storage, CI), `product` (security requirements in specs), `marketing`,
`sales` (security questionnaires). If a member isn't installed, it names the plugin
(`ai-<member>`).

## Upgrading
`/plugin marketplace update ai-team`, then `/plugin update ai-security@ai-team` (restart Claude
Code). Run "set up the AI security engineer" again to apply workspace migrations; it never
overwrites your history.

## Contributing
See [CONTRIBUTING.md](CONTRIBUTING.md). License: [MIT](LICENSE).
