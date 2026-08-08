---
name: yo-codex
description: >-
  Route, contract, supervise, resume, and verify delegated work performed by a
  Codex agent. Use when handing implementation, investigation, review, testing,
  or another bounded task to Codex through native agent threads, a callable
  Codex MCP tool, or the Codex CLI; when choosing among those surfaces; or when
  recovering delegated work after a timeout, disconnect, or partial result.
---

# Yo Codex

## Outcome

Delegate a bounded job to the best Codex surface without expanding authority,
losing user work, creating competing writers, or mistaking an agent report for
proof. Preserve a resumable thread when iteration is likely and return an
independently verified result.

Use `references/delegation-contract.md` for the prompt and handoff templates.
Use `references/surfaces.md` for capability probes and surface-specific examples.

## Non-negotiable rules

- Delegation does not transfer accountability. The caller owns scope,
  integration, verification, and the final claim.
- A registered MCP server is not evidence that the current caller exposes its
  tools. Inspect the callable tool surface.
- Never hardcode a model, reasoning effort, tool name, sandbox, or approval
  policy merely because a previous machine supported it.
- `--yolo` / `--dangerously-bypass-approvals-and-sandbox` means no Codex sandbox
  and no approval prompts. Never describe that execution as sandboxed.
- One writer owns a working tree at a time. Parallel write-heavy work requires
  separate worktrees or another genuinely isolated workspace.
- Preserve pre-existing staged, unstaged, and untracked work. Never use reset,
  checkout, clean, stash, broad formatting, or bulk rewrites to simplify the
  handoff unless the user explicitly requests that operation.
- A timeout or lost response creates unknown state, not permission to rerun.
- A delegated agent's summary and test claims are leads. Inspect the resulting
  state and run proportionate independent verification.

## 1. Decide whether delegation helps

Delegate when a distinct worker can materially improve speed, focus, context
isolation, or independent judgment and the job has a clear endpoint.

Good shapes include:

- bounded implementation with observable acceptance criteria;
- read-heavy exploration, log analysis, or test execution that would pollute the
  main context;
- an independent review pinned to an exact diff or revision;
- several truly independent read-only lanes;
- one isolated write lane while the caller coordinates and verifies.

Do not delegate merely to relay a trivial answer, duplicate work already in
progress, escape an unresolved product decision, or recursively launch Codex
from Codex with no independent value. If the current Codex session can do the
work directly, continue locally unless the user or applicable instructions ask
for an independent agent.

Parallelize only independent work. Prefer read-only parallelism. If two tasks
touch the same contracts, generated outputs, lockfiles, migrations, Git index,
or verification environment, sequence them or isolate them and define an
integration order.

## 2. Discover the effective environment

Before choosing a route, establish live truth:

1. Read applicable `AGENTS.md` files and repository instructions for the exact
   working directory.
2. Resolve the absolute working directory and, for Git work, record branch,
   `HEAD`, merge base or review target, and staged/unstaged/untracked state.
3. Inspect the caller's actual tools for native agent or Codex MCP start and
   continuation calls. Do not infer callability from `codex mcp list`.
4. If CLI fallback is possible, run `codex --version` and focused `--help` for
   the subcommands and flags that will be used. Installed capabilities drift.
5. Determine the effective model/configuration only when it changes the route.
   Let valid user, project, managed, and session configuration apply unless the
   user requested an override or the task requires a proven different mode.
6. Identify sandbox, approval, network, external-tool, and credential boundaries
   separately. A prompt, approval setting, and filesystem sandbox are different
   controls.

Stop and report the exact missing capability if there is no usable delegation
surface. Do not call all browser, shell, or MCP automation unavailable because
one surface is absent.

## 3. Freeze authority and the work contract

The delegated worker receives no more authority than the caller has for this
task.

- **Investigate/review/report**: read-only unless edits were separately requested.
- **Implement/fix**: edit the assigned local workspace and run relevant local
  checks. Do not assume commit, push, PR, issue comment, deployment, publication,
  secret use, or another external write.
- **GitHub/delivery action**: include only when the user or active workflow
  clearly authorized that exact action and destination.
- **Potentially destructive, public, security-sensitive, or irreversible work**:
  state the boundary and escalation condition explicitly.

Give the worker a contract containing:

- objective and why this lane exists;
- absolute `cwd`, repository/project identity, and pinned source or diff;
- in-scope behavior, owned paths or components, and non-goals;
- protected user changes and forbidden operations;
- granted authority and explicit exclusions;
- relevant constraints and applicable instructions;
- acceptance criteria and exact evidence expected;
- the solution-shape constraint: smallest complete production-quality change,
  with no speculative abstractions, layers, dependencies, configuration, or
  future-proofing, plus a final simplification pass;
- stop/escalation conditions;
- concise return shape: result, changes/findings, commands and outcomes,
  unresolved risks, and current state.

Do not paste a vague issue title and expect the worker to reconstruct material
decisions. Do not overload the prompt with unrelated history. Include evidence
and constraints that change the work.

## 4. Establish ownership before launch

Capture the baseline before any write delegation:

- exact source revision and review base;
- staged, unstaged, and untracked paths;
- user-owned files or hunks;
- processes, generated files, migrations, lockfiles, or shared fixtures the task
  may affect;
- expected output paths.

Use one of these models:

1. **Single writer in the current tree** - best when the task depends on current
   local changes. The caller remains read-only in that tree until handoff.
2. **Isolated worktree or workspace** - best for an independent implementation,
   alternative approach, or simultaneous writers. Pin the starting revision,
   give each writer a separate branch/worktree, and plan integration.
3. **Read-only worker** - safe to run against a shared tree if it will not mutate
   files, the Git index, dependencies, caches that affect others, or external
   state.

Do not silently copy ignored secrets or local configuration into an isolated
workspace. If the job needs user changes that are not committed, either keep a
single writer in the current tree or deliberately transfer a reviewed snapshot;
never stash or discard the user's state as setup.

## 5. Choose the execution surface

### Native Codex child thread

When already inside a Codex surface with native agent controls, and delegation is
explicitly requested or allowed by applicable instructions, prefer a native
child for a bounded independent lane. It preserves platform-native supervision
and avoids recursively launching another CLI.

Use child threads mainly for read-heavy parallel work or isolated write lanes.
Confirm inherited sandbox and approval mode before launch. A parent started with
`--yolo` passes that unsandboxed mode to native children unless the surface
supports and applies a narrower child override.

### Callable conversational Codex tool

Prefer a callable start/continue pair for iterative implementation, debugging,
or review likely to need follow-up. Use the exact names and schemas exposed to
the caller. Pass the absolute `cwd` and the complete contract. Supply optional
model, sandbox, approval, or developer-instruction overrides only when deliberate
and supported.

Save the returned thread identifier immediately. Send normal follow-ups to that
same thread. Do not use a deprecated continuation field when the current schema
exposes a replacement.

### Codex CLI non-interactive mode

Use `codex exec` for automation, pipelines, bounded shell delegation, or when no
callable conversational tool exists. It is not necessarily one-shot: current
versions can persist and resume non-interactive sessions. Probe the installed
help, retain the exact session ID, and avoid ephemeral mode when follow-up may be
needed.

Use structured event output or an output schema when another program must
consume the result. Use `codex review` for a supported review target such as an
exact commit, base diff, or uncommitted tree. Pin the review input; a moving
branch name can change while the worker runs.

### Explicitly sandboxed command from an unsandboxed session

If the parent CLI/TUI uses `--yolo` and the user explicitly requests a command
inside the native Codex sandbox, use the installed sandbox helper rather than
claiming ordinary shell execution is sandboxed. On this user's native Windows
setup, the required shape is:

```powershell
codex sandbox -P ':workspace' -C '<focused-workspace>' -- <command> <args...>
```

Verify the installed help and effective profile before use. Treat the helper's
command tree as sandboxed; the already-running parent and its model connection
remain unsandboxed. If no network is required, verify that the selected profile
enforces it. Never retry a sandbox denial under `--yolo` without new authority.

This helper runs a command; it is not a substitute for an agent conversation.
If Codex must reason about the command, keep reasoning in the current session and
run only the authorized command through the helper.

## 6. Launch and supervise

At launch, record:

- surface and probed version/schema;
- thread/session/worker identifier;
- absolute `cwd`, source revision, and workspace owner;
- effective authority, sandbox, approval, and network posture;
- contract and acceptance evidence.

For long-running work, monitor through the surface's status mechanism. Steer the
existing thread when assumptions change. Do not create a replacement worker
while the original may still be running or may already have edited the tree.

When a worker returns:

1. separate completed actions from recommendations and unverified claims;
2. compare current status/diff with the captured baseline;
3. check owned scope and protected user work before accepting anything;
4. inspect focused code paths or findings needed to assess correctness;
5. run independent acceptance checks from the controlling context;
6. return attributable failures to the same thread with exact command, exit
   code, relevant output, and expected behavior.

Follow-ups should add new evidence or a changed decision. Do not make the worker
reread the entire task for every failing check.

## 7. Recover unknown or partial state

On timeout, disconnect, crash, or malformed response:

1. stop new writers;
2. inspect process/worker status, workspace diff, generated outputs, and external
   state within current authority;
3. resume the exact thread/session when possible and ask it to reconcile
   completed versus remaining work;
4. if resume is impossible, preserve and review partial work before deciding
   whether the caller takes ownership or starts a new worker with a recovered
   baseline;
5. never repeat external or non-idempotent actions until their outcome is known.

If the worker crossed scope, preserve the user's state and report the concrete
diff. Do not erase unauthorized edits with destructive Git commands. Repair or
revert selectively only when authorized and provenance is clear.

## 8. Verify and close

Verification must be independent enough for the risk:

- run focused behavior tests first, then broader repository gates as warranted;
- validate the exact resulting diff or revision, not an earlier worker snapshot;
- inspect whether every new concept and moving part is required by acceptance,
  a supported contract, demonstrated risk, repository boundary, or faithful
  evidence; remove accidental complexity before closeout;
- check negative cases, integration boundaries, and runtime behavior when they
  are part of acceptance;
- for reviews, reproduce high-severity findings where practical and distinguish
  confirmed defects from hypotheses;
- for external actions, verify the destination's actual state.

Use `yo-audit` when the user requests an independent final audit. Use
`yo-branch` for branch, commit, push, PR, and integration conventions when those
actions are authorized.

Call the delegation complete only when the requested outcome exists, protected
work is intact, required checks pass or are honestly reported, and no required
handoff remains. Report the surface/session, owned scope, resulting files or
findings, verification evidence, unresolved risk, and any external state changed.

## Anti-patterns

- Treating MCP registration as callable tool availability.
- Pinning yesterday's model name or deprecated tool spelling in a permanent skill.
- Setting approval to `never` and calling that a sandbox.
- Calling `--yolo` trusted or sandboxed because the repository is familiar.
- Starting multiple writers in one dirty working tree.
- Retrying after a lost response without inspecting partial state.
- Accepting an agent's "tests pass" sentence as the only evidence.
- Letting a worker commit, push, post, publish, or deploy because it seemed useful.
- Starting a fresh thread for every follow-up and losing causal context.
- Delegating an unresolved product decision as though it were implementation.

## Research basis

Primary sources and local capability evidence are recorded in
`references/sources.md`.
