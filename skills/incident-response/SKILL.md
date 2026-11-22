---
name: incident-response
description: Guide the founder through a security incident or suspected incident — leaked key, suspicious login, compromised account or dependency, data exposure, defacement, ransomware — following NIST SP 800-61r3 and the CSF 2.0 Respond/Recover functions — triage, containment steps, evidence, eradication, recovery, notifications hand-off and a blameless post-incident review. Use for "we've been hacked", "I pushed a key to GitHub", "something weird in the logs", or to write an incident response plan.
---

# incident-response

Speed and calm. You advise and prepare; the founder (or `devops`) performs every action on
systems and accounts (rule 12). Never investigate by probing third-party systems (rule 2).

1. **Open the record now.** Create `ai-team/security/incidents/IR-XXXX-slug.md` from
   `${CLAUDE_PLUGIN_ROOT}/templates/incident-report.md` and start the timeline (UTC times, who
   noticed what). Everything later is appended.
2. **Triage (minutes).** Ask only what decides the next step: what happened, when, which assets
   (check `assets.md`), is it ongoing, is customer or personal data involved, are credentials
   involved. Rate severity: **SEV1** (active attacker, customer data exposed, production down),
   **SEV2** (contained compromise, a live secret leaked), **SEV3** (suspicious, no confirmed
   impact). SEV1, or personal data, ransomware or extortion → **escalate first line**: recommend
   an incident-response professional now, and tell the founder to involve the `lawyer` member
   (notification duties can have short legal deadlines).
3. **Contain** — give numbered steps the founder can do now, most urgent first, e.g.:
   - leaked secret → revoke/rotate it at the provider first, then check provider logs for use
     since the leak, then remove it from code (history rewrite optional);
   - compromised account → reset password, revoke sessions and tokens, check MFA and recovery
     settings, review recent admin actions;
   - compromised dependency → pin to a known-good version, rebuild from clean CI, rotate secrets
     that the build could read;
   - suspicious server → isolate (don't power off if forensics may be needed), snapshot first.
4. **Preserve evidence.** Tell the founder which logs to export before they roll over (code host
   audit log, cloud audit logs, app logs, auth provider logs) and where to store them privately.
   Record the location in the incident file, not the content. Never paste secrets or full
   personal data into the record.
5. **Investigate (read-only).** With the founder's go-ahead, read company-owned logs and config to
   establish scope: entry point, what was accessed, since when. Mark every conclusion with the
   evidence and confidence; "unknown" is an acceptable answer — never invent a timeline.
6. **Eradicate and recover.** Root-cause fix (with `cto`/`devops`), restore from known-good
   backups, verify (re-scan with `ai-security:dependency-secret-scan`, re-check access), watch
   for recurrence.
7. **Notifications (prepare, don't send).** List who may need to know: customers, affected users,
   partners, insurer, authorities. Whether and when notification is legally required → exact
   question to the `lawyer` member. Draft messages only on request; the founder sends them.
8. **Post-incident review** (blameless) within a week: what happened, what worked, what didn't,
   contributing causes, actions with owners. Update the threat model, policies and the incident
   response plan.
9. `ai-security:log-job` — risks (root causes, residual risk), obligations (each action with a
   date), decisions, learnings (what the playbook missed).

**Plan mode:** asked for an incident response plan rather than a live incident → write
`policies/incident-response-plan.md` via `ai-security:security-policy`: contacts, severity levels,
the steps above as a one-page checklist, where logs live, who can revoke what.
