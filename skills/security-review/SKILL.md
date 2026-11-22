---
name: security-review
description: Security review of the company's own code, configuration, infrastructure-as-code, CI/CD workflows or a design question — checked against OWASP Top 10:2025 and OWASP ASVS 5.0, with evidence (file:line), severity, and fixes as diffs. Use for "review this for security", "is this safe?", before a release or merge of a sensitive change, or for a security question about the stack.
---

# security-review

Static by default: you read code and configuration; you don't attack running systems (RULES.md
rules 1–2). You never push, merge or deploy.

1. **Scope.** Identify what is being reviewed (repository path, branch or diff, config files, a
   design question) and confirm it is in `ai-team/security/assets.md`. Not listed → ask the
   founder to confirm ownership, or stop. Load memory: product file, latest threat model, open
   risks for this asset, earlier `reviews/SR-*`, active lessons.
2. **Understand before judging.** Read the README, dependency manifests, entry points, routing,
   auth middleware, data access layer and deployment config. Note the stack and framework
   versions (framework defaults decide many answers — check the framework's own security docs).
3. **Check, by OWASP Top 10:2025 category**, focusing on what the threat model rates highest:
   - A01 Broken Access Control — authorisation on every route/handler, tenant isolation, IDOR,
     CORS, server-side checks for admin functions;
   - A02 Security Misconfiguration — debug modes, default credentials, verbose errors, security
     headers, open storage buckets, permissive IAM, exposed admin panels in config;
   - A03 Software Supply Chain Failures — lockfiles present, pinned versions, CI actions pinned,
     install scripts; deep dependency checks → `ai-security:dependency-secret-scan`;
   - A04 Cryptographic Failures — TLS, password hashing (bcrypt/scrypt/Argon2), home-made crypto,
     keys in code, data at rest;
   - A05 Injection — SQL/NoSQL/command/template injection, XSS, unsafe deserialisation, SSRF;
   - A06 Insecure Design — business-logic abuse, missing rate limits, flows from the threat model;
   - A07 Authentication Failures — session handling, MFA for admins, reset flows, JWT validation;
   - A08 Software or Data Integrity Failures — unsigned updates, CI that runs untrusted code with
     secrets, webhook signature checks;
   - A09 Security Logging and Alerting Failures — security events logged, **no secrets or
     personal data in logs**;
   - A10 Mishandling of Exceptional Conditions — fail-open error paths, unhandled errors that
     leak details or skip checks.
   For a deeper or contractual review, use the ASVS 5.0 requirements (Level 1 by default for an
   early-stage product; Level 2 when it holds sensitive data) as the checklist and say which
   level you used. Check CI/CD workflows for secrets exposure, untrusted triggers and token
   permissions (OpenSSF Scorecard checks are a good guide).
4. **Use tools only if installed and approved** (e.g. `semgrep` with a local ruleset, a
   linter's security rules). Run them read-only against the working copy; never send code to an
   online service without the founder's approval (rule 11). Treat tool output as leads: confirm
   each finding by reading the code; drop false positives and record common ones as learnings.
5. **For each finding:** ID (`SR-XXXX-F01`), OWASP category / CWE, severity with the reason,
   location (file:line), evidence (a short code excerpt — never a secret), exploit preconditions,
   fix (a minimal diff or exact steps), and the reference you relied on (cheat sheet, framework
   docs) with the date checked.
6. **Design questions** ("JWT or sessions?", "can we store X?") → answer in the RULES.md format
   and save a memo `research/R-XXXX-slug.md` from `${CLAUDE_PLUGIN_ROOT}/templates/research-memo.md`
   when the founder may act on it.
7. **Write** the review `ai-team/security/reviews/SR-XXXX-slug.md` from
   `${CLAUDE_PLUGIN_ROOT}/templates/security-review.md`, with a verdict (ok to ship / ship after
   fixes / do not ship), what was reviewed and what was not.
8. **Fixes:** offer diffs. Apply them to the working copy only if the founder asks; never commit,
   push, merge or deploy without explicit approval of that exact action. Implementation work for
   larger fixes → hand off to `cto` (code) or `devops` (infrastructure) with the exact request.
9. **Report privately** (rule 4) and `ai-security:log-job` — unfixed findings → risks; fixes →
   obligations; legal angles (personal data exposure) → the exact question, asked directly (RULES: "Ask colleagues directly"), for the `lawyer`.
