---
name: setup
description: Set up (or repair/upgrade) the AI security engineer in the current project — creates the private ai-team/ workspace (shared company files + ai-team/security/), builds the register of company-owned assets in scope, registers the security member in team.md, and offers privacy, permissions and scheduled runs. Use on first use in a project, when the workspace is missing, or after a plugin update that changes the workspace.
---

# setup

Template files are in `${CLAUDE_PLUGIN_ROOT}/skills/setup/workspace/`. Never overwrite an
existing file in `ai-team/` — the workspace may already hold real history.

1. **Explain** in two lines what will be created (`ai-team/` private workspace) and that nothing
   leaves the machine.
   **Location:** if an `ai-team/` already exists in this folder or a parent folder, join it —
   never create a second one. Otherwise ask where to create it: in this folder (default), or in a
   parent company folder when this project is one of several products (layout
   `<company>/ai-team/` next to `<company>/projects/<product>/`).
2. **Ask** (one question at a time, skip what is already in `ai-team/team.md`):
   - answer language (default English).
   There is no jurisdiction question for this member; leave `team.md`'s jurisdiction as it is
   (`TBD` if you create the file).
3. **Create shared files if missing** (another member may have created them already):
   `ai-team/README.md`, `ai-team/team.md`, `ai-team/company/profile.md`,
   `ai-team/company/documents.md`, `ai-team/company/products/_template.md`. Fill `team.md`
   (date, `workspace_contract: 1`) and the profile's stage date if you created them.
4. **Create the member folder** `ai-team/security/` from the template's `security/` folder:
   `learnings.md`, `assets.md`, `history/{journal,decisions,obligations,risks}.md`,
   `threat-models/README.md`, `reviews/README.md`, `policies/README.md`,
   `incidents/README.md`, `research/README.md`, `digests/README.md`, `inbox/README.md`.
5. **Build the asset register** (`assets.md`) — the scope you may work on:
   - list candidate assets from `ai-team/company/products/*.md` ("Website / repo" lines), the
     company `CLAUDE.md`, and folders under `projects/` next to `ai-team/` (repositories:
     `git -C <path> remote get-url origin` is enough; don't read code yet);
   - show the list and ask the founder to confirm which ones the company owns or controls, and
     whether any third-party accounts (cloud, code host, domain registrar) should be listed for
     configuration review of the company's own account;
   - write only confirmed rows (`A-0001`…), with `Testing allowed: static`. Unconfirmed
     candidates → obligation "Confirm ownership of …".
6. **Register** a row in `team.md`: `security | ai-security | ai-security:security |
   ai-team/security/ | <plugin version> | <today> | threat models, code & config review,
   dependency & secret scans, security policies, incident response, risk register`.
7. **First journal entry** `J-0001 · <today> · setup` and obligations:
   - `O-0001` "Fill in company/profile.md and a product file in company/products/" (due in 14
     days) — only if no other member created it already;
   - `O-0002` "First threat model of the main product (threat-model)" (due in 14 days);
   - `O-0003` "First dependency and secret scan of each repository in assets.md" (due in 7 days).
   If products are described in the project (README, docs), offer to draft the product file's
   Data section (personal data, hosting, sub-processors) from them — the founder confirms before
   you write.
8. **Offer, don't force** (ask each; do only what is approved):
   - **Privacy:** if the project is a git repo, add `ai-team/` to `.gitignore`; suggest
     `git init` inside `ai-team/` for private, tamper-evident history. Check that `.env` and
     other secret files are git-ignored in each repository in scope and report (don't fix
     without approval).
   - **Permissions:** merge the `allow` list from `${CLAUDE_PLUGIN_ROOT}/skills/setup/permissions.json`
     into the project's `.claude/settings.json` so framework and advisory sites can be fetched
     without prompts. It allows reading public documentation only — no scanning tools.
   - **Tools:** list which local scanners are already installed (`command -v gitleaks osv-scanner
     trivy semgrep npm pip-audit`). Suggest missing ones with their official install page; never
     install anything without approval.
   - **Scheduled runs:** weekly `dependency-secret-scan` (e.g. Mondays 08:00) and monthly
     `security-briefing` (1st of month). Create them if a scheduling tool is available in this
     session; otherwise explain how to schedule them in the Claude app.
9. **Upgrade mode** (workspace exists): compare with the template, create only missing files or
   folders, apply migrations listed in `CHANGELOG.md` for versions newer than the one in
   `team.md`, update the version in `team.md`, and log what changed.
10. Finish with a short summary: what exists now, the three most useful first requests ("threat
    model our main product", "scan our repos for leaked secrets", "what should we fix first?"),
    and `log-job`.
