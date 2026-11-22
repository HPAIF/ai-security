---
name: log-job
description: Record a job in the company's security memory — journal entry plus updates to the risk register, decisions, obligations, asset register, shared company facts and learnings. Use at the end of every task that produced a finding, a review, a policy, a decision, a risk, a deadline or a change of company facts (including scheduled runs).
---

# log-job

All history files are **append-only**: add rows/entries; to correct, add a new entry that
references the old one. Never delete history. Never write a secret anywhere (type, location and
a redacted marker only). Get today's date with `date +%F`.
Paths below are under `ai-team/security/` unless they start with `ai-team/`.

1. **Journal** — append to `history/journal.md` (next J-number, format at the top of the file):
   request, what was done and on which assets (A-ids), output files, frameworks and advisories
   relied on with dates checked, follow-ups.
2. **Risks** — every finding or threat not fixed on the spot → a row in `history/risks.md`
   (next RK-id, keep the exact column order: likelihood, impact, rating, treatment, status,
   review date). A change to an existing risk (fixed, accepted, re-rated) → update its status
   cell and append an event line `RK-xxxx · date · event` (what changed and the evidence, e.g. a
   re-scan ID). Close a risk only with evidence that the fix is in place.
3. **Decisions** — the founder chose something (a design option, a tool, a policy, accepting a
   risk) → append to `history/decisions.md` with the reasoning, sources and a review date. An
   accepted risk always gets a decision.
4. **Obligations** — every deadline, recurring duty (key rotation, certificate renewal, access
   review) or recommended fix → append a row to `history/obligations.md` (keep the exact table
   format; due date `YYYY-MM-DD` or `—`). Mark finished ones `done` (don't delete the row).
5. **Assets** — a newly confirmed company-owned asset, a retired one, or a change in what testing
   the founder allows → update `assets.md`.
6. **Company facts** — new or changed facts (hosting, sub-processors, personal data, admin
   access, a security document created) → update `ai-team/company/profile.md`, the product file
   in `ai-team/company/products/` or `ai-team/company/documents.md`, and say in the journal
   entry what changed (these files are shared with other members).
7. **Learnings** — anything this task taught you (correction, false positive, tool or source
   change, missing step) → append to `learnings.md` with the right scope (see RULES.md).
8. Confirm to the founder in one line what was recorded (e.g. "Logged J-0007, RK-0003, O-0012,
   L-0002").
