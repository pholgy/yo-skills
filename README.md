# Yo Skills

My personal software-engineering playbook for coding agents.

Yo Skills helps Codex and Claude work the way I want: verify the real system
before acting, understand impact before editing, use the smallest workflow that
fits the risk, prove the result, and leave a clean technical handoff.

It is not a prompt collection that forces ceremony onto every task. Clear work
stays direct. Broad or risky work gets deeper evidence and review.

## Why I made this

I want an agent to behave like a careful engineering teammate:

- check the current code, revision, runtime, and discussion instead of trusting
  an old assumption;
- separate a symptom, its cause, its blast radius, and the fix;
- preserve user changes, running processes, and approval boundaries;
- use parallel work only when the task actually decomposes;
- keep uncertainty visible instead of turning missing evidence into confidence;
- write concise issues, pull requests, reviews, and handoffs from verified facts;
- stop at the outcome I asked for rather than silently publishing, merging, or
  deploying more.

The bundle is self-contained. No Yo workflow requires Superpowers or another
non-Yo skill.

## Quick install

Clone or download this repository, open a terminal in its root, then run one
command.

```bash
git clone https://github.com/pholgy/yo-skills.git
cd yo-skills
```

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

macOS, Linux, or Git Bash:

```bash
chmod +x ./install.sh ./verify.sh
./install.sh
```

The default `auto` mode installs into the user-global homes it detects:

| Host | User-global location |
|---|---|
| Codex | `~/.codex/skills` |
| Claude Code | `~/.claude/skills` |
| Shared agent tools | `~/.agents/skills` |

These are global for the current operating-system user across projects, not
machine-wide for every user account.

Install an explicit target when auto-detection is not what you want:

```powershell
.\install.ps1 -Target codex
.\install.ps1 -Target codex,claude
.\install.ps1 -Target all
```

```bash
./install.sh --target codex
./install.sh --target codex --target claude
./install.sh --target all
```

Run the same installer again to update. Existing copies of these 19 skills are
moved to a timestamped directory under `~/.yo-skills-backups/` before the new
version is installed. Unrelated skills and plugins are not changed.

Claude's optional SessionStart reminder is deliberately opt-in. Install both
canonical hook files, backup-first, without changing `settings.json`:

```powershell
.\install.ps1 -Target claude -InstallClaudeHook
```

```bash
./install.sh --target claude --install-claude-hook
```

## Verify

```powershell
.\verify.ps1
```

```bash
./verify.sh
```

Verification compares every installed file with this repository. A valid
installation reports 19 matching skills for each selected host.

Include the optional Claude hook in that comparison only when you installed or
manage it from this bundle:

```powershell
.\verify.ps1 -Target claude -IncludeClaudeHook
```

```bash
./verify.sh --target claude --include-claude-hook
```

Start a fresh Codex or Claude session after installing so its skill catalog is
reloaded.

## How I use it

You can invoke a skill directly, but natural requests usually work because each
skill describes when it applies.

| What I need | Primary skill |
|---|---|
| I am not sure where to start | `yo-flow` |
| Verify whether a claimed bug is real | `yo-verify-premise` |
| Explain a confirmed failure | `yo-debug` |
| Understand who or what an edit can affect | `yo-impact` |
| Make a broad engineering decision | `yo-engineering` |
| Design a consequential change | `yo-design` |
| Build a new capability | `yo-feature` |
| Clear multiple findings or review comments | `yo-fix-loop` |
| Independently review an exact change | `yo-audit` |
| Run a broad, read-only system review | `yo-workflow` |
| Prepare a branch or pull request | `yo-branch` |
| Write GitHub issues, PRs, reviews, or replies | `yo-gh-write` |
| Handle active production impact | `yo-incident` |
| Prepare, publish, or verify a release | `yo-release` |

Examples:

```text
Verify this bug against current main before changing anything.

Audit authorization across the API, jobs, admin tools, and recovery paths.

Fix these review findings, prove each one, then draft the PR.

Production login is failing right now. Mitigate safely first.
```

See [the full skill map](yo-skills-overview.md) for all 19 skills and common
handoff chains.

## What makes the bundle different

- **Evidence before edits.** Claims are bound to current code and the relevant
  environment.
- **Risk without ritual.** Tiny reversible work stays tiny; consequential work
  gets explicit invariants, rollback, and independent verification.
- **Honest deep review.** `yo-workflow` maps coverage, challenges candidates with
  independent evidence, and keeps unresolved risks separate from confirmed
  findings.
- **Safe ownership.** One writer owns a tree. User processes and dirty changes
  are protected.
- **Clean GitHub writing.** Public claims are concise, technical, and
  reproducible.
- **No Superpowers dependency.** The routing layer uses only bundled Yo skills.

## Safety and privacy

The installers:

- read only this local repository;
- perform no downloads or network requests;
- replace only the 19 skill directories shipped under `skills/` by default;
- preserve replaced copies before installation;
- when explicitly opted in, replace only the two named Claude hook files after
  preserving their previous copies;
- never edit Claude `settings.json`, plugin settings, repositories, or project
  files.

Review any skill before installing it, especially when using a fork you did not
create yourself.

## Repository layout

```text
skills/       Current Yo skills
archive/      Pre-rewrite snapshots
validation/   Rerunnable behavior scenarios
hooks/        Optional Claude SessionStart reminder
install.*     Backup-first installers
verify.*      Installed-tree verification
INSTALL.md    Detailed and manual installation reference
VALIDATION.md Validation record and limits
```

The research basis for each workflow lives beside that skill under
`skills/<name>/references/`. The bundle-level evidence is recorded in
[VALIDATION.md](VALIDATION.md).

## Personalize it

Fork the repository and change only what represents your own workflow. A useful
starting point is
`skills/yo-gh-write/references/repo-profiles.md` for repository-specific labels,
reviewers, and writing conventions.

Keep universal engineering rules separate from preferences and from live tool
capabilities. If a model, CLI flag, hook contract, or host behavior can change,
verify it live instead of freezing it into a permanent rule.

## Detailed installation and recovery

See [INSTALL.md](INSTALL.md) for manual installation, the optional Claude hook,
backup locations, and recovery instructions.

## License

[MIT](LICENSE) — use it, fork it, and adapt it to your own engineering workflow.
