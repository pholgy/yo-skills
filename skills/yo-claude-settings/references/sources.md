# Sources for yo-claude-settings

Claude Code changes rapidly. Official Anthropic documentation and live runtime
evidence determine current product behavior; the user's quality-first preference
selects among supported options.

## Models, aliases, effort, and context

Anthropic documents `best` as Fable 5 when available and otherwise latest Opus,
and describes Fable 5 as the most capable Claude Code model for hardest and
long-running tasks. The same page defines current effort support and precedence:
the environment variable outranks configured effort and frontmatter; `max` is
session-only and can overthink; ultracode is orchestration at xhigh; modern
models always use adaptive reasoning. It also documents current 1M context
availability and actual model fallback behavior.

- Anthropic, "Model configuration"
  https://code.claude.com/docs/en/model-config

Derived rules: use current runtime/model evidence, choose xhigh as this user's
durable quality posture, reserve max for deliberate hard sessions, and never
claim fixed thinking on adaptive-only models.

## Settings scopes and validation

Anthropic documents managed, command-line, local, project, and user scopes; key-
specific merge behavior; environment overrides; and active settings inspection.
The local CLI help notes that non-interactive mode can silently ignore invalid
settings and that diagnostic commands may start configured integrations.

- Anthropic, "Claude Code settings"
  https://code.claude.com/docs/en/settings
- Anthropic, "CLI reference"
  https://code.claude.com/docs/en/cli-reference

Derived rules: edit the correct layer minimally, preserve enforcement and
secrets, and verify effective state in a new interactive session.

## CLAUDE.md and auto memory

Anthropic documents managed/user/project/local instruction sources, ancestor
loading, lazy subdirectory loading, path-scoped rules, imports, and the fact that
Claude Code does not read `AGENTS.md` unless `CLAUDE.md` imports it. It also
distinguishes behavioral instruction context from enforced settings and explains
automatic memory indexing/on-demand topic reads.

- Anthropic, "How Claude remembers your project"
  https://code.claude.com/docs/en/memory

Derived rules: use the target's actual instruction chain, avoid broad scans, use
imports for shared AGENTS guidance, and consult memory proportionally.

## Context and session recovery

Anthropic's context guide documents `/context`, compaction reinjection, lazy
reload of nested/path-scoped instructions, skill reinjection limits, focused
compaction, and clearing between unrelated tasks. Session docs describe resume,
fork, clear, compact, and the danger of resuming one session in two terminals.

- Anthropic, "Explore the context window"
  https://code.claude.com/docs/en/context-window
- Anthropic, "Manage sessions"
  https://code.claude.com/docs/en/sessions

Derived rules: decide from actual context use, preserve causal state, reload
nested guidance after compaction, and never duplicate an unknown side effect.

## Parallel work and isolation

Anthropic distinguishes subagents, background agent view, teams, and dynamic
workflows. It recommends worktrees when sessions touch the same files and warns
that parallel agents multiply usage and need ownership/coordination.

- Anthropic, "Run agents in parallel"
  https://code.claude.com/docs/en/agents

Derived rule: orchestration is a separate behavior, not an effort setting; use it
only when explicitly authorized and isolate writers.

## Dated local evidence

The verified Claude Code 2.1.204 settings/environment snapshot is recorded in
`current-baseline.md`. Recheck it after upgrades, provider/account changes, or a
reported drift rather than treating it as permanent policy.

## Golden engineering behavior

Anthropic recommends starting with simple composable patterns and adding
complexity only when it demonstrably improves outcomes. Google, Microsoft, and
OpenAI supply complementary review, reliability, and smallest-tested-fix
evidence. The primary source-to-rule map is in
[the bundle quality standard](../../yo-engineering/references/quality-standard.md).

Derived rule: the durable Claude baseline optimizes for maximum correctness
with the fewest necessary concepts, requires root-cause regression closure for
defects, and ends substantive work with a simplification pass.
