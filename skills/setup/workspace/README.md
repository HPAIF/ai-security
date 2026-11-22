# ai-team/ — private workspace of your AI Team

This folder is the memory of your AI Team agents (lawyer, accountant, …): company facts,
history, contracts, registers, research and what the agents learned.

> ⚠️ **Private.** It will hold personal data, contracts and financial records.
> - Keep `ai-team/` out of any public repository (add it to your project's `.gitignore`).
> - Recommended: `git init` inside this folder and commit after each session, so the history is
>   tamper-evident. Push only to a private remote, if at all.
> - Back it up (encrypted disk or cloud).

- `team.md` — which members are installed
- `company/` — facts every member shares (profile, documents, one file per product)
- `<member>/` — each member's own history, research and inbox

The agents themselves (rules, skills) come from public plugins and update separately; nothing in
this folder is ever sent back to them unless you approve an anonymised improvement.
