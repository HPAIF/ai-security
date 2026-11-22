# Security risk register

> Every security risk to the company: findings not fixed on the spot, threats from threat models,
> gaps against the baseline. Written by `log-job` and the role skills. Open `high` and
> `critical` rows are shown at the start of every session by the session hook, so keep the
> column order exactly. Never delete a row; change its status and add a dated event below.
> Never write secrets or exploit steps here — link the review instead.
>
> - **Likelihood / Impact:** high / medium / low (say why in the review it links to)
> - **Rating:** critical / high / medium / low (likelihood × impact; a leaked live secret or an
>   exploitable flaw in CISA KEV is at least `high`)
> - **Treatment:** mitigate / avoid / transfer / accept (accept needs a decision D-xxxx)
> - **Status:** open / mitigating / accepted / closed / transferred

| ID | Opened | Asset / product | Risk | Source (TM/SR/SC/IR id) | Likelihood | Impact | Rating | Treatment | Status | Review by |
|---|---|---|---|---|---|---|---|---|---|---|

## Event log
> `RK-xxxx · YYYY-MM-DD · event` — e.g. "RK-0001 · 2027-02-01 · fix merged by cto, verified by re-scan SC-2027-02-01".
