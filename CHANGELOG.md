# Changelog

All notable changes to the AI security engineer. Versions follow semver: patch = fixes and
wording, minor = new skill / workspace files, major = breaking workspace change.
Entries that need a workspace change list a **Migration** step; `setup` (upgrade mode) applies it.

## 0.1.5 — 2026-11-28
- Shorter replies: chat answers are about 5 lines by default (answer first, no headings, at most
  3 bullets, no report of housekeeping). The full answer format is for memos and full analyses;
  long content goes into a workspace file with the path in the chat.

## 0.1.4 — 2026-11-23
- Talk to colleagues only where the founder sees it: no hidden Agent-tool calls; @mention in group
  chats (one answer, no discussion without the founder); "For @member:" elsewhere.

## 0.1.3 — 2026-11-23
- Missed questions: an unanswered question that still matters is repeated briefly under
  "Still open:" at the end of the next answer.

## 0.1.2 — 2026-11-23
- Ask colleagues directly, never through the founder: @mention in group chats, the Agent tool
  as main agent, "Question for @member" when called by the lead.

## 0.1.1 — 2026-11-23
- Rule "Be concise": shortest answer that keeps all important information (warnings, numbers,
  dates, sources, decisions); long only when the content needs it.

## 0.1.0 — 2026-11-22
- Basic version, to be specialised later.
- Agent `security`, rules (`RULES.md`): company-owned assets only, never touch third-party
  systems, never print secrets, private vulnerability reporting, evidence for every finding,
  append-only history, escalation, never invent, confidentiality, never act for the company.
- Skills: setup, threat-model (STRIDE), security-review (OWASP Top 10:2025, ASVS 5.0),
  dependency-secret-scan (OSV/advisories, CISA KEV, CVSS v4.0, SLSA, Scorecard), security-policy
  (CIS Controls v8.1 IG1, NIST CSF 2.0, RFC 9116), incident-response (NIST SP 800-61r3),
  security-briefing, log-job, improve.
- Workspace folder `ai-team/security/` (workspace contract v1): asset register, risk register,
  threat models, reviews, policies, incidents.
- SessionStart hook: open high/critical risks, obligations, journal, inbox, pending learnings.
- Research notes in `docs/research.md`.
- **Migration:** none (first release).
