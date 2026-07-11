# Sources for yo-codex

The product changes quickly. These primary sources calibrate delegation routing,
session continuity, permissions, isolation, and verification. Re-probe the live
caller and installed CLI before acting.

## Local capability snapshot

Verified on 2026-07-10 with `codex-cli 0.144.0`:

- the CLI exposes `exec`, `exec resume`, `review`, `sandbox`, `mcp`,
  `mcp-server`, `resume`, and `fork`;
- `codex exec` supports structured JSON events, persisted or ephemeral runs,
  output schema validation, final-message output, model/config overrides, and
  sandbox/approval selection;
- native Windows `codex sandbox` supports permission profiles, focused working
  directory, sandbox-state input, readable-root additions, and disabling network
  for supplied sandbox state;
- the current caller exposes `mcp__codex__codex` and
  `mcp__codex__codex_reply`; continuation uses `threadId`, while
  `conversationId` is deprecated.

Derived rule: local help and tool metadata are runtime evidence, not a portable
API guarantee. Probe only the surface needed for the task.

## CLI reference and non-interactive sessions

The official command reference defines CLI flags, `codex exec`, structured
output, output schemas, sandbox modes, `exec resume`, review targets, and the
native sandbox helper. It explicitly defines `--yolo` as bypassing approvals and
sandboxing. The non-interactive guide positions `codex exec` for scripts and CI,
documents resuming by session ID, and recommends separating a read-only Codex job
from a later write-capable job in automation.

- OpenAI, "Developer commands"
  https://developers.openai.com/codex/cli/reference
- OpenAI, "Non-interactive mode"
  https://developers.openai.com/codex/non-interactive-mode

Derived rules: retain the session ID, resume before duplicating work, use
structured output for automation, pin review inputs, and never mislabel `--yolo`.

## Sandboxing, approvals, and network

OpenAI documents sandbox mode and approval policy as separate controls. Local
workspace-write defaults to no command network access; `--ask-for-approval never`
can be paired with restricted sandbox modes; `--yolo` is no sandbox/no approvals.
The same guidance recommends clean, version-controlled workflows and independent
review and testing of agent changes.

- OpenAI, "Agent approvals and security"
  https://developers.openai.com/codex/agent-approvals-security
- OpenAI, "Sandboxing"
  https://developers.openai.com/codex/sandboxing

Derived rules: describe effective enforcement, not prompt intent; preserve least
authority; distinguish network from filesystem policy; independently verify.

## Instructions and configuration precedence

Codex reads global and project `AGENTS.md` guidance before work and layers files
from project root toward the working directory, with nearer guidance later in
the chain. CLI flags override inherited configuration for an invocation.

- OpenAI, "Custom instructions with AGENTS.md"
  https://developers.openai.com/codex/guides/agents-md
- OpenAI, "Config basics"
  https://developers.openai.com/codex/config-basic

Derived rule: send the correct absolute `cwd`, let applicable instructions load,
and add overrides only when they are intentional and supported.

## Subagent orchestration

OpenAI recommends subagents for independent, bounded work, especially read-heavy
exploration, tests, triage, and summarization. It cautions that parallel
write-heavy work increases conflicts and coordination cost. Native subagents
inherit the parent turn's live sandbox and approval overrides, and unattended
approval requests fail rather than waiting for interaction.

- OpenAI, "Subagents"
  https://developers.openai.com/codex/subagents

Derived rules: delegate only when it adds value, prefer read-only parallelism,
use explicit ownership for writes, and inspect inherited permission posture.

## Worktree isolation

OpenAI's worktree guide uses separate checkouts for independent parallel tasks,
explains that each worktree has its own files while sharing Git metadata, and
documents the one-branch-per-worktree constraint. It also notes that ignored
files require deliberate copying in managed worktrees.

- OpenAI, "Worktrees"
  https://developers.openai.com/codex/environments/git-worktrees

Derived rules: one writer per tree, unique branch/worktree ownership, deliberate
integration, and no silent transfer of ignored secrets or configuration.

## Human supervision and verification

OpenAI describes Codex results as reviewable through diffs, terminal logs, and
test evidence and recommends human review before integration or production use.

- OpenAI, "Introducing Codex"
  https://openai.com/index/introducing-codex/
- OpenAI, "Introducing the Codex app"
  https://openai.com/index/introducing-the-codex-app/

Derived rule: the controller remains accountable for inspecting state,
independent verification, integration, and the final completion claim.
