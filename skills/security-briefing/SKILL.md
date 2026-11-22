---
name: security-briefing
description: Monthly (or on request) security posture briefing for the founder — open risks by rating, overdue fixes, a quick CIS Controls IG1 / NIST CSF 2.0 baseline check, an OWASP SAMM-lite maturity snapshot, what a company at this stage should do next, and pending self-improvements. Use for "what should we fix first", "how secure are we", "status", or the monthly scheduled run.
---

# security-briefing

Think like a careful first security hire at a start-up: practical, prioritised, cheap first.
Scheduled runs never ask questions — they record them as obligations.

1. **Load everything:** `ai-team/company/`, `assets.md`, `history/` (risks, obligations,
   decisions, journal since the last briefing), `threat-models/`, `reviews/` since the last
   briefing, `policies/`, `incidents/`, `learnings.md`; `ai-team/team.md` for other members.
2. **Risk review.** Open risks by rating; risks past their review date; accepted risks whose
   decision is due for review; risks with no movement for 60+ days. Propose re-ratings with
   reasons (never close a risk without evidence).
3. **Baseline check** — for the company's stage, compare against a short list drawn from CIS
   Controls v8.1 IG1, grouped by NIST CSF 2.0 function:
   - Govern: someone owns security; policies exist and are approved; risk register reviewed;
   - Identify: asset register complete; threat model for each live product;
   - Protect: MFA on email, code host, cloud and admin accounts; least privilege; secrets out of
     code; dependency updates automated; backups; device encryption;
   - Detect: audit logs enabled and kept; alerts for the critical ones;
   - Respond / Recover: incident response plan; backups restore-tested; `security.txt` published.
   Mark each item done (evidence) / partly / missing / unknown (→ question as obligation).
4. **Maturity snapshot** (optional, quarterly): rate the 15 OWASP SAMM 2.0 practices 0–1–2
   roughly, only to pick the next one or two to improve — not as a score to show anyone.
5. **Calendar** — overdue and next-60-days items from `history/obligations.md` (rotations,
   certificate renewals, policy reviews, customer audits).
6. **Advisories** — for critical dependencies named in recent scans, note whether anything new
   appeared in CISA KEV or the advisory databases since the last scan; suggest a re-scan if so
   (don't run active checks in a scheduled briefing).
7. **Self-improvement** — count `general` learnings that are `pending`; if any, propose running
   `ai-security:improve`.
8. **Write** `ai-team/security/digests/YYYY-MM-DD-security-briefing.md`:
   ```
   # Security briefing — YYYY-MM-DD
   ## Top 3 things to do this month
   ## Open risks (critical / high first; overdue reviews)
   ## Deadlines (overdue / next 60 days)
   ## Baseline (CIS IG1 / CSF 2.0): done · partly · missing · unknown
   ## Since last briefing (reviews, scans, incidents)
   ## When to bring in a human security professional (if at all)
   ## Questions for other team members
   ## Agent self-improvement (pending learnings)
   ```
   No secrets or exploit details in the digest — link to the reviews.
9. `ai-security:log-job` (journal entry; new obligations; re-rated risks with events; open
   questions recorded).
