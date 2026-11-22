---
name: security-policy
description: Draft or update the company's security policies and security documents — information security policy, access control, secrets management, vulnerability disclosure and security.txt (RFC 9116), incident response plan, backup and recovery, acceptable use — sized for an early-stage company from CIS Controls v8.1 IG1 and NIST CSF 2.0; also drafts accurate answers to customer security questionnaires. Use for "we need a security policy", "a customer sent a security questionnaire", "set up security.txt".
---

# security-policy

A policy for a five-person company must be short, true and followed. Never write a control the
company does not actually have; mark planned controls as planned. The legal-compliance side
(what a law or contract requires) belongs to the `lawyer` member.

1. **Load memory:** `ai-team/company/profile.md`, product files (data, hosting, sub-processors),
   `ai-team/company/documents.md`, existing `policies/`, `assets.md`, open risks, decisions,
   active lessons. If a `lawyer` member exists, read its obligations and contract register for
   security commitments the company already made (DPAs, SLAs, customer contracts).
2. **Pick the baseline:** CIS Controls v8.1 Implementation Group 1 (the 56 essential safeguards)
   as the control checklist, organised under the NIST CSF 2.0 functions (Govern, Identify,
   Protect, Detect, Respond, Recover). For each relevant safeguard, record: in place (evidence) /
   partly / not yet / not applicable. This gap list is the basis for every policy.
3. **Draft the requested document** from `${CLAUDE_PLUGIN_ROOT}/templates/policy.md`:
   - purpose, scope (assets), roles (who is responsible — often the founder), the rules
     themselves in plain language, exceptions process, review cycle;
   - typical starter set: information security policy (umbrella), access control (MFA
     everywhere, least privilege, joiner/leaver checklist), secrets management (where secrets
     live, rotation, leak response — OWASP Secrets Management Cheat Sheet), vulnerability
     management (scan cadence, fix deadlines by severity), incident response plan (from
     `ai-security:incident-response`), backup and recovery, acceptable use of devices;
   - **vulnerability disclosure:** a short policy page plus a `security.txt` per RFC 9116 —
     `Contact` and `Expires` are required, served at `/.well-known/security.txt`; draft the file,
     the founder or `devops` publishes it.
4. **Customer security questionnaires** (file in `inbox/`): answer each question only from
   evidence (policies, assets, reviews, decisions). Unknown → "to confirm" with the question for
   the founder. Never overstate a control or claim a certification the company does not hold.
   Save the answers in `research/R-XXXX-questionnaire-<customer>.md`; the founder sends them.
5. **Legal check:** list the legal questions the policy raises (breach-notification deadlines,
   personal-data rules, contractual commitments) and write the exact question for the `lawyer`.
   Don't state legal requirements yourself as fact.
6. **Save** `ai-team/security/policies/<name>.md` with front-matter status `draft`. When the
   founder approves it, set `approved`, the date and next review date, and register it in
   `ai-team/company/documents.md` (shared file).
7. `ai-security:log-job` — gaps against IG1 → risks (high-impact ones) and obligations; the
   policy's review date → obligation; approval → decision.
