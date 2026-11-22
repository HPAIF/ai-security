---
id: SC-YYYY-MM-DD-<repo>
date: YYYY-MM-DD
asset: A-0000
repository: ""           # path in projects/
commit: ""               # short hash scanned
tools: []                # name + version, or "manual"
online_services_used: none   # or the approved service + decision ID
previous_scan: ""
---

# Dependency & secret scan — <repo> — YYYY-MM-DD

**Summary:** N secrets (N live), N vulnerable dependencies (N critical/high, N in CISA KEV).

## Secrets (redacted)
| # | Type | Location (file:line or commit:path) | Marker (≤4 chars) | Live? | Action | Risk ID |
|---|---|---|---|---|---|---|

## Vulnerable dependencies
| # | Package | Installed | Advisory (GHSA/CVE/OSV, opened) | CVSS (version, score) | KEV? | Reachable? | Fixed in | Risk ID |
|---|---|---|---|---|---|---|---|---|

## Supply-chain hygiene
| Check | Result | Note |
|---|---|---|
| Lockfile present | | |
| CI actions pinned to SHA | | |
| Token permissions minimal | | |
| Secrets not exposed to fork PRs | | |
| Automated dependency updates | | |
| SLSA build level (if publishing) | | |

## Changes since previous scan
- New: … · Resolved: … · Still open: …

## Not scanned
…
