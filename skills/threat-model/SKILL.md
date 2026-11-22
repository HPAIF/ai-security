---
name: threat-model
description: Build or update a threat model of a company product, feature or architecture — data-flow diagram, trust boundaries, STRIDE threats per element, ranked by likelihood and impact, with mitigations — and feed unmitigated threats into the security risk register. Use for "threat model X", before building a sensitive feature (auth, payments, file upload, admin, integrations, AI features), or when the architecture changes.
---

# threat-model

Frameworks: the Threat Modeling Manifesto's four questions (what are we working on? what can go
wrong? what are we going to do about it? did we do a good enough job?), **STRIDE** per element,
OWASP Threat Modeling Cheat Sheet. Keep it lightweight: a first model of a small product should
take one session, not a week.

1. **Scope.** Confirm the product or feature is company-owned (`ai-team/security/assets.md`).
   Load memory: the product file in `ai-team/company/products/`, earlier `threat-models/TM-*`
   for it (update instead of starting over), open `history/risks.md` rows, the `product`
   member's spec if one exists (`ai-team/product/specs/`), the `cto` member's decisions if any.
2. **What are we working on?** Build the system model from the product file, the repository
   (README, architecture docs, infrastructure-as-code, routes, data models — read, don't run) and
   the founder's answers:
   - external entities (users by role, admins, third-party services), processes, data stores,
     data flows;
   - **trust boundaries** (internet ↔ app, app ↔ database, tenant ↔ tenant, app ↔ vendor API);
   - the assets worth protecting (personal data, credentials, money, availability, the code);
   - draw a data-flow diagram as a Mermaid `flowchart` in the model.
   List assumptions; ask the founder the one missing fact that matters most.
3. **What can go wrong?** For each element and each flow that crosses a trust boundary, walk
   STRIDE: **S**poofing (authentication), **T**ampering (integrity), **R**epudiation (logging /
   accountability), **I**nformation disclosure (confidentiality), **D**enial of service
   (availability), **E**levation of privilege (authorisation). Add abuse cases from the product's
   features (e.g. multi-tenant data leaks, account takeover, abuse of free trials, prompt
   injection for AI features, supply-chain compromise via dependencies or CI). Map each threat to
   an OWASP Top 10:2025 category where one fits.
4. **Rank** each threat: likelihood and impact (high / medium / low, with one-line reasons) →
   rating (critical / high / medium / low). Note existing controls you actually saw in code or
   config (cite file:line) versus ones you assume.
5. **What are we going to do about it?** For each threat choose mitigate / avoid / transfer /
   accept. For mitigations, write a concrete security requirement (reference the ASVS 5.0
   requirement area where useful) and who implements it (`cto`, `devops`, founder). Accepting a
   risk is the founder's decision → record it.
6. **Did we do a good enough job?** Check: every trust-boundary flow has STRIDE coverage; every
   data store holding personal data or secrets has a disclosure threat; the founder has seen the
   top threats. List what was out of scope.
7. **Write** `ai-team/security/threat-models/TM-XXXX-<product>[-<feature>].md` from
   `${CLAUDE_PLUGIN_ROOT}/templates/threat-model.md` (next free number; an update appends to the
   revision log of the existing file).
8. **Hand off:** security requirements for upcoming features → write the exact request for the
   `product` member (to put in the spec) and the `cto` member (to implement).
9. `ai-security:log-job` — journal; unmitigated threats rated medium or above → `history/risks.md`;
   mitigations → obligations; accepted risks → decisions; "re-run when the architecture changes"
   as an obligation with no date.
