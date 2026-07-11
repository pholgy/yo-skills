# Current Codex baseline

This is a dated runtime snapshot, not a permanent model pin.

## Verified 2026-07-10

Platform: native Windows PowerShell

Installed CLI:

```text
codex-cli 0.144.0
```

Relevant user config in `~/.codex/config.toml`:

```toml
personality = "pragmatic"
model = "gpt-5.6-sol"
model_reasoning_effort = "max"
```

The bundled runtime catalog describes `gpt-5.6-sol` as the latest frontier
agentic coding model and exposes `low`, `medium`, `high`, `xhigh`, `max`, and
`ultra`. It describes `max` as maximum reasoning depth for the hardest problems
and `ultra` as maximum reasoning with automatic task delegation.

Current user policy:

- `gpt-5.6-sol` is correctly configured; do not revert it to the archived
  `gpt-5.5` value.
- `max` is the default deep single-agent effort; do not silently downshift.
- use `ultra` only for intentional, meaningfully separable delegation and only
  when user/project instructions permit it;
- `pragmatic` communication remains the configured default.

## Read-only audit shapes

Use the active surface when possible:

```text
/status
/model
/debug-config
```

On PowerShell, inspect only relevant user-config keys:

```powershell
$config = Join-Path $HOME '.codex\config.toml'
rg -n '^\s*(personality|model|model_reasoning_effort)\s*=' $config
```

Probe runtime capabilities after upgrades or suspected drift:

```powershell
codex --version
codex debug models --help
codex debug models --bundled
```

The bundled catalog avoids a refresh; the effective signed-in catalog may differ.
Do not paste the whole catalog or config into chat. Extract only the fields needed
to decide model availability and supported effort.

## Drift decisions

| Observed state | Decision |
|---|---|
| Current frontier model + `max` | Baseline satisfied |
| Newer supported frontier model configured | Treat old snapshot as stale, not the new config as drift |
| Current model deprecated/unavailable | Inspect live recommendations; do not guess replacement |
| Effort lower than `max` without explicit task override | Report downshift; change only if authorized |
| `ultra` active without intended delegation | Report behavior change; return to deep single-agent mode only if authorized |
| User explicitly asks for speed/cost reduction | Apply a turn/session override, not a permanent change unless requested |
| Project/managed layer overrides user config | Report effective source and honor higher-precedence policy |

## Fresh-session handoff

```markdown
Objective: <observable outcome>
Workspace/source: <absolute cwd, branch/SHA, dirty state>
Decisions: <only still-binding decisions>
Protected work: <user-owned files/hunks/processes>
Completed: <verified work and commands>
Remaining: <ordered next actions>
Unknowns/blockers: <unresolved state>
Effective settings: <model/effort/permissions only if material>
```
