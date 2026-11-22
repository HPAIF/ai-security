---
name: dependency-secret-scan
description: Scan the company's own repositories for known-vulnerable dependencies (OSV, GitHub advisories, NVD, CISA KEV, CVSS v4.0) and leaked secrets (working tree and git history), plus basic supply-chain hygiene (lockfiles, pinned CI actions, SLSA/OpenSSF Scorecard checks); report with secrets redacted and feed the risk register. Runs weekly on a schedule; also use for "scan our repos", "do we have leaked keys?", "is library X vulnerable?".
---

# dependency-secret-scan

Static and local. Only repositories with type `repository` in `ai-team/security/assets.md`.
Scheduled runs never ask questions and never use online services that were not approved.

## 1. Prepare
- Load `assets.md`, open `history/risks.md` rows (avoid duplicates), the previous
  `reviews/SC-*` report for each repo, active lessons.
- Check which tools are installed: `command -v gitleaks trufflehog detect-secrets osv-scanner
  trivy npm pnpm yarn pip-audit cargo-audit govulncheck bundle-audit`. Use what exists; never
  install a tool without the founder's approval. No tools → do a manual review (step 2–3 by
  reading lockfiles and grepping for secret patterns) and say so in the report.

## 2. Secrets
- Run secret scanners **in redacting mode** and write their raw output only to a temporary file
  outside the workspace that you delete afterwards, e.g. `gitleaks detect --source <repo>
  --redact --no-banner --report-path <tmp>.json` (include git history; a secret removed from the
  current code is still leaked if it is in history).
- Without a scanner: search for high-signal patterns (private key headers, `AKIA`, `ghp_`,
  `sk_live_`, `xox[bp]-`, `password\s*=`, connection strings) with `grep -n` piped through a
  redaction step — print file:line and the pattern name, never the matched value.
- Check `.gitignore` covers `.env*`, key files and local config; check CI files don't echo
  secrets.
- For each hit: type, file:line (or commit short hash + path), redacted marker (≤ 4 characters),
  whether it looks live or a test/example value, and the action: **revoke and rotate** at the
  provider (the founder or `devops` does it — never you), then remove from code; rewriting git
  history is optional and has costs (see the OWASP Secrets Management Cheat Sheet). A live leaked
  secret is at least `high`; `critical` if it grants production or customer-data access.

## 3. Dependencies
- Find manifests and lockfiles. A missing lockfile is itself a finding (A03:2025).
- Run the ecosystem's audit **offline or against the package registry the project already
  uses** (e.g. `npm audit --omit=dev` uses the npm registry the project already talks to;
  `osv-scanner --offline` with a local database). Tools that upload the dependency list to a
  third-party API need the founder's approval once (record it as a decision), because the list
  reveals the stack.
- For each vulnerable package: package, installed version, advisory ID (GHSA / CVE / OSV),
  severity and CVSS v4.0 (or v3.1) vector as published, fixed version. **Open the advisory**
  (osv.dev, github.com/advisories or nvd.nist.gov) to confirm before reporting — tool output and
  memory are leads. Check whether the CVE is in the CISA Known Exploited Vulnerabilities catalog.
- **Prioritise by real risk, not raw count:** in KEV or exploit public → first; reachable from
  the company's code (is the vulnerable function used? runtime vs dev dependency?) → raise;
  dev-only and unreachable → lower. Say how you judged reachability.
- Fix: the smallest upgrade that resolves it, breaking changes noted; offer the diff to the
  manifest. Never merge or deploy it.

## 4. Supply-chain hygiene (quick)
- CI actions pinned to a commit SHA, minimal `permissions:` for tokens, no secrets exposed to
  pull requests from forks, branch protection and code review on the default branch (ask the
  founder if you can't see it), automated dependency updates enabled.
- Where the company publishes builds or packages: note the current SLSA build level (most
  early-stage projects are L0–L1) and the next practical step.

## 5. Report and record
- Write `ai-team/security/reviews/SC-YYYY-MM-DD-<repo>.md` from
  `${CLAUDE_PLUGIN_ROOT}/templates/scan-report.md`: tools and versions used (or "manual"),
  what was scanned, findings by severity, changes since the last scan, what was not scanned.
- Delete temporary raw output files.
- `ai-security:log-job` (request "scheduled: dependency-secret-scan" for scheduled runs): new
  findings → risks; resolved ones → close with the scan ID as evidence; rotations and upgrades →
  obligations; a live leaked secret → also tell the founder at the top of the answer and suggest
  `ai-security:incident-response`.
