# Codex delegation surfaces

Probe live capabilities before copying any example. Names and flags below reflect
the local 2026-07-10 snapshot and current official documentation; they are not a
permanent compatibility promise.

## Capability ladder

| Evidence | What it proves | What it does not prove |
|---|---|---|
| Native spawn/list/reply tools exposed to the caller | This session can manage native child threads | Their sandbox, write isolation, or suitability |
| A callable Codex start tool and continuation tool | This caller can create and continue a Codex conversation | That another client exposes the same names/schema |
| `codex mcp list` contains a Codex server | The CLI configuration registers a server | That the current caller exposes or can invoke its tools |
| `codex --version` and focused `--help` succeed | The installed CLI supports the displayed surface | That credentials, policy, network, or repository state permit the run |
| A prompt says "read-only" or "no network" | The worker received an instruction | Any enforced security boundary |

## Current callable MCP shape

The local caller currently exposes `mcp__codex__codex` and
`mcp__codex__codex_reply`. The start call accepts a prompt, optional absolute
`cwd`, and optional model/sandbox/approval/config overrides. The response returns
content plus `threadId`. The continuation call takes `threadId` and a prompt;
`conversationId` is deprecated in the current schema.

Use discovered metadata rather than embedding this spelling in an orchestrator.
Conceptually:

```text
start({
  prompt: <delegation contract>,
  cwd: <absolute workspace>,
  ...only deliberate supported overrides
}) -> { content, threadId }

continue({
  threadId: <saved id>,
  prompt: <new evidence or decision>
})
```

Do not automatically send a fixed model, `workspace-write`, or approval `never`.
The user/session/project configuration may be more current or more restrictive.

## Current CLI shapes

Inspect the installed help first. On the local `codex-cli 0.144.0` snapshot:

```powershell
codex --version
codex exec --help
codex exec resume --help
codex review --help
codex sandbox --help
```

### Persistent non-interactive run

Feed complex prompts through stdin or a safely handled file rather than fragile
shell interpolation:

```powershell
$contract | codex exec -C $cwd --json -
```

Capture the session ID from structured events. Continue the exact run:

```powershell
$followUp | codex exec resume $sessionId -
```

Use `--ephemeral` only when intentionally forgoing persisted session rollout.
Use `--output-schema <path>` for a machine-validated final response and
`--output-last-message <path>` when a downstream step needs the final message.
Do not put credentials in prompts, command history, or output files.

### Pinned review

The current review command supports `--commit <SHA>`, `--base <BRANCH>`, and
`--uncommitted`. Prefer an immutable commit or a base resolved to exact source
state when reproducibility matters:

```powershell
$instructions | codex review --commit $sha -
```

Record what was actually reviewed. `--uncommitted` includes staged, unstaged,
and untracked changes and can drift while another writer is active.

### Explicit Windows command sandbox

For this user's native Windows CLI when the parent runs with `--yolo`:

```powershell
codex sandbox -P ':workspace' -C 'C:\focused\repo' -- <command> <args...>
```

Allow up to 60 seconds for first startup. Resolve the focused workspace first.
Verify that the active profile supplies the requested filesystem and network
policy. The helper confines its command tree, not the parent Codex session.

The current help also supports sandbox-state input, extra readable roots, and an
explicit network-disable switch for that supplied sandbox state. Do not combine
options by guesswork; follow the installed schema and active permission profile.

## Configuration and permissions

- Omitted CLI options inherit configuration; command-line overrides take
  precedence for that invocation.
- Sandbox mode controls technical reach. Approval policy controls when execution
  pauses. Network and external/app tool permissions are separate.
- `--ask-for-approval never` can run within `read-only` or `workspace-write`; it
  is not synonymous with full access.
- `--yolo` bypasses both approvals and Codex sandboxing. Use it only as the user
  intended and describe it accurately.
- Native subagents inherit the parent turn's live permission overrides, including
  `--yolo`, unless a supported narrower child override is applied.
- Non-interactive runs cannot satisfy a new interactive approval; the blocked
  action fails and must be surfaced.

## Writer isolation

Use separate worktrees/branches for simultaneous writers. Pin a common base and
give each worker a unique path and integration order. A worktree separates file
and index state but shares repository metadata, so do not assign the same branch
to two worktrees or allow concurrent branch-moving operations.

If the current tree is dirty:

- record user work before delegation;
- keep one writer there when the task depends on those changes; or
- create an isolated worker from a pinned clean revision and integrate its patch
  deliberately;
- do not stash, reset, clean, or silently copy ignored secrets.

## Failure taxonomy

| Symptom | Response |
|---|---|
| Tool absent but server registered | Use another proven surface; do not diagnose the server as broken |
| Start failed before an ID and no edits | Correct the discovered configuration and retry once if safe |
| Timeout/disconnect after start | Treat state as unknown; inspect and resume exact ID |
| Session ID unavailable | Preserve current diff/output, then decide explicit takeover or recovered new run |
| Approval needed in unattended run | Report failed boundary; do not widen permissions silently |
| Sandbox denial | Report denial; never rerun unsandboxed without new authority |
| Worker changed protected scope | Stop writers, preserve evidence/user work, and reconcile selectively |
| Worker says complete but checks fail | Return exact evidence to same session; completion remains false |
