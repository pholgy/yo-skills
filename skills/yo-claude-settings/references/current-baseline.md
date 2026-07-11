# Current Claude Code baseline

This is a dated local snapshot, not a permanent model pin.

## Verified 2026-07-10

Platform: native Windows PowerShell

```text
Claude Code 2.1.204
```

Relevant user settings from `~/.claude/settings.json`:

```json
{
  "model": "claude-fable-5[1m]",
  "effortLevel": "xhigh",
  "env": {
    "CLAUDE_CODE_EFFORT_LEVEL": "high"
  },
  "permissions": {
    "defaultMode": "auto"
  }
}
```

The current process also has:

```text
CLAUDE_CODE_EFFORT_LEVEL=high
```

No `ANTHROPIC_MODEL` process override was observed. User and local settings may
contain other sensitive or unrelated fields; do not print them during an audit.

## Current interpretation

- The model setting selects Fable 5 with extended context. Current official docs
  describe Fable 5 as Claude Code's most capable model for hardest and
  long-running tasks. The model baseline is satisfied if the account/provider
  actually exposes it and no visible fallback occurred.
- Persisted `effortLevel` expresses an `xhigh` preference.
- The environment variable has higher precedence and makes effective effort
  `high`, not `xhigh`.
- `/effort xhigh`, skill frontmatter, or subagent frontmatter cannot override the
  current `high` environment value.
- Permission mode `auto` is a separate authority/control setting; this skill does
  not change it.

If the user explicitly asks to persist the good-brain effort, the minimal likely
delta is removal of `env.CLAUDE_CODE_EFFORT_LEVEL` from the user settings so the
existing `effortLevel: "xhigh"` can apply in a new session. Confirm that the env
value is not also set by the parent shell, registry, managed settings, or launcher
before editing. Do not remove it during a read-only ramp-up.

## Read-only audit

Inside Claude Code, inspect the effective surface:

```text
/model
/effort
/config
/context
/memory
```

From PowerShell, inspect only required values:

```powershell
claude --version
$settings = Get-Content -Raw "$HOME\.claude\settings.json" | ConvertFrom-Json
$settings.model
$settings.effortLevel
$settings.env.CLAUDE_CODE_EFFORT_LEVEL
$env:CLAUDE_CODE_EFFORT_LEVEL
$env:ANTHROPIC_MODEL
```

Do not run `claude -p` just to learn a stored value: it makes a model call and
non-interactive mode can silently ignore invalid settings.

## Drift matrix

| Observed state | Decision |
|---|---|
| Fable/best available + effective xhigh | Durable quality baseline satisfied |
| Fable selected + effective high from env | Report precedence conflict; no false xhigh claim |
| Max selected for one demanding session | Accept when deliberate; do not persist as universal default |
| Ultracode active | Report workflow/delegation behavior, not just effort |
| Fable visibly falls back to Opus | Report classified/provider fallback and actual model |
| Stronger supported model replaces Fable | Treat dated snapshot as stale; research before changing |
| 1M context available | Manage actual usage with `/context`; do not load broadly |
| Managed model/effort restriction applies | Honor it; do not bypass |

## Fresh-session handoff

```markdown
Objective: <observable outcome>
Workspace/source: <absolute cwd, branch/SHA, dirty state>
Decisions: <still-binding decisions>
Protected state: <user work, data, processes, deployments>
Completed: <verified actions and evidence>
Remaining: <ordered next actions>
Unknowns: <anything not safely repeatable>
Prohibited repeats: <migration/deploy/command until reconciled>
Loaded scope: <nested instructions/rules that must reload>
Effective settings: <model/effort/permissions only if material>
```
