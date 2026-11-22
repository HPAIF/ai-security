# Reviews and scans

- `SR-XXXX-short-slug.md` — code / configuration reviews (skill `security-review`, OWASP Top 10, ASVS)
- `SC-YYYY-MM-DD-<repo>.md` — dependency and secret scans (skill `dependency-secret-scan`)

Secrets are always redacted (type, file, line, at most a 4-character prefix). Never delete a
report; a re-check is a new report that links the old one.
