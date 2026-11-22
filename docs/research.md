# Research behind the AI security member (v0.1.0)

Notes from the research done before building this plugin (2026-11-22). Links plus short
paraphrases; open the sources for the full text. Versions change: the skills tell the agent to
re-check a framework or advisory before relying on it.

## What security work looks like at an early-stage startup

- Small teams can't run a full security programme. Advice for startups points the same way:
  start from **what needs protecting** (customer data, credentials, code, availability), fix the
  cheap high-impact basics (MFA, secrets out of code, patching, backups), threat-model the
  product in short recurring sessions, and add formality only as customers, investors or
  regulators ask for it.
  - SEI (Carnegie Mellon), *Security at an Early Stage Startup* — https://sei.cmu.edu/library/security-at-early-stage-startup/
  - Bessemer, *A comprehensive guide to security for startups* — https://www.bvp.com/atlas/security-for-startups
  - Cloud Security Alliance, *7 steps to get started with security and privacy engineering* (2025) — https://cloudsecurityalliance.org/blog/2025/02/14/7-steps-to-get-started-with-security-and-privacy-engineering
  - Shostack, *Threat modeling at a startup* — https://shostack.org/archive/2014/12/threat-modeling-at-a-startup/
- Leaked credentials in early repositories (API keys, cloud keys) are one of the most common
  real-world problems — hence a dedicated weekly secret scan.

**Implications for this plugin:** a founder-facing agent that (1) keeps an asset register and a
risk register, (2) threat-models products lightly and often, (3) reviews code and config
statically, (4) scans dependencies and secrets weekly, (5) writes short, true policies, (6)
guides incident response, and (7) briefs the founder monthly on what to fix next.

## Frameworks chosen and where they are used

| Framework | What it is (paraphrase) | Used in |
|---|---|---|
| **Threat Modeling Manifesto** — https://www.threatmodelingmanifesto.org/ | Four questions: what are we working on, what can go wrong, what will we do about it, did we do a good enough job. | `threat-model` structure |
| **STRIDE** (via OWASP Threat Modeling Cheat Sheet) — https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html | Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege — each the violation of a security property (authentication, integrity, accountability, confidentiality, availability, authorisation). The cheat sheet's process: model the system as a data-flow diagram with trust boundaries, identify and rank threats, choose responses (mitigate / eliminate / transfer / accept), review. It advises starting with STRIDE and not piling on techniques. | `threat-model`, threat-model template |
| **OWASP Top 10:2025** — https://top10.owasp.org/2025 | The ten most critical web-application risk categories: A01 Broken Access Control, A02 Security Misconfiguration, A03 Software Supply Chain Failures, A04 Cryptographic Failures, A05 Injection, A06 Insecure Design, A07 Authentication Failures, A08 Software or Data Integrity Failures, A09 Security Logging and Alerting Failures, A10 Mishandling of Exceptional Conditions. | `security-review` checklist, threat mapping |
| **OWASP ASVS 5.0.0** (May 2025) — https://asvs.owasp.org/ | An open standard of security requirements for designing, building and testing web apps and services; usable as a metric, as build guidance and as procurement requirements. Organised in levels of increasing rigour. | `security-review` (deep / contractual reviews), security requirements in threat models |
| **OWASP Cheat Sheet Series** — https://cheatsheetseries.owasp.org/ | Concise fix-oriented guidance per topic. The Secrets Management cheat sheet: detect secrets before commit, use more than one detector, revoke and rotate leaked secrets immediately, history rewrite has costs, prefer short-lived CI credentials (OIDC), never log secrets. | fixes in reviews; `dependency-secret-scan`; secrets policy |
| **OWASP SAMM 2.0** — https://owaspsamm.org/model/ | Maturity model for software security: 5 business functions (Governance, Design, Implementation, Verification, Operations), 3 practices each (15 total). | optional quarterly snapshot in `security-briefing` |
| **CIS Critical Security Controls v8.1, IG1** — https://www.cisecurity.org/controls/implementation-groups/ig1 | Implementation Group 1 is "essential cyber hygiene": 56 safeguards aimed at small organisations with limited security staff, against common non-targeted attacks. | baseline for `security-policy` and `security-briefing` |
| **NIST CSF 2.0** — https://www.nist.gov/cyberframework | Current version of the Cybersecurity Framework; six functions: Govern, Identify, Protect, Detect, Respond, Recover. NIST SP 1300 is a small-business quick-start guide (one page per function) — https://csrc.nist.gov/pubs/sp/1300/final | structure of policies and the briefing's baseline |
| **NIST SP 800-61 Rev. 3** (April 2025) — https://csrc.nist.gov/pubs/sp/800/61/r3/final | Incident response recommendations, recast as a CSF 2.0 community profile; supersedes Rev. 2 (2012). | `incident-response` |
| **NIST SSDF, SP 800-218 v1.1** (Feb 2022) — https://csrc.nist.gov/pubs/sp/800/218/final | High-level secure software development practices that can be added to any SDLC. | background for review and policy content |
| **SLSA** (current spec v1.2) — https://slsa.dev/spec/v1.0/levels | Supply-chain build levels: L0 none, L1 provenance exists, L2 hosted build platform signs provenance, L3 hardened, isolated builds. | supply-chain hygiene in `dependency-secret-scan` |
| **OpenSSF Scorecard** — https://github.com/ossf/scorecard | Automated 0–10 checks of repository security practices (branch protection, code review, dangerous workflows, token permissions, pinned dependencies, SAST, security policy, vulnerabilities…). | CI/CD checks in `security-review` and scans |
| **OSV / OSV-Scanner** — https://osv.dev/ | Distributed open-source vulnerability database aggregating advisories (GitHub, PyPA, RustSec…); the scanner checks lockfiles, SBOMs and containers across 40+ ecosystems. | `dependency-secret-scan` |
| **CISA KEV catalog** — https://www.cisa.gov/known-exploited-vulnerabilities-catalog | Authoritative list of vulnerabilities known to be exploited in the wild; meant as one input to patch prioritisation. | prioritisation in scans and briefing |
| **CVSS v4.0** (FIRST) — https://www.first.org/cvss/v4.0/ | Vulnerability scoring with Base, Threat (formerly Temporal), Environmental and Supplemental metric groups. | severity in findings |
| **RFC 9116 security.txt** — https://www.rfc-editor.org/rfc/rfc9116 | Machine-readable file at `/.well-known/security.txt` telling researchers how to report vulnerabilities; `Contact` and `Expires` are the required fields. | vulnerability-disclosure policy |

## Considered and left for later

- **DREAD** scoring — mentioned in startup guides, but subjective; we rank by likelihood × impact.
- **PASTA, VAST, LINDDUN** (privacy threat modeling) — heavier; LINDDUN may be added for privacy
  reviews together with the lawyer member.
- **SOC 2 / ISO 27001 readiness** — a likely future skill (customer-driven); for now the agent
  escalates certification work to human auditors.
- **Pen testing / DAST** — deliberately excluded from v0.1.0 apart from founder-approved local
  tests; active testing has the highest risk of harming systems or touching third parties.

## Skills derived from the research

`threat-model` (Manifesto + STRIDE) · `security-review` (Top 10:2025 + ASVS 5.0) ·
`dependency-secret-scan` (OSV/advisories, KEV, CVSS, secrets cheat sheet, SLSA, Scorecard) ·
`security-policy` (CIS IG1 + CSF 2.0 + RFC 9116) · `incident-response` (SP 800-61r3) ·
`security-briefing` (risk register, CIS IG1/CSF baseline, SAMM snapshot).
