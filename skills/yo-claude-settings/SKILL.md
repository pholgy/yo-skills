---
name: yo-claude-settings
description: >-
  Apply or audit the user's Claude Code baseline: strongest available model,
  high-depth adaptive reasoning, scoped CLAUDE.md instructions, focused changes,
  context and compaction hygiene, relevant auto memory, pragmatic writing, and
  safe ownership of local processes. Use when the user says "my settings",
  "ramp up", "use the good brain", or "no adaptive thinking"; reports
  model/effort/context drift; enters a new project scope; or asks to change Claude
  Code configuration.
---

# Yo Claude Settings

## Outcome

Start Claude Code work with effective model, effort, settings, instructions,
context, and process ownership understood. Preserve the user's quality-first
intent while using current Claude semantics rather than obsolete model names,
fixed-thinking controls, or broad instruction scans.

Use `references/current-baseline.md` for the dated local snapshot and audit
commands. Use `references/operating-baseline.md` for compact engineering,
context, process, and handoff checklists.

## Authority

Invoking this skill authorizes read-only inspection of relevant Claude settings,
environment variables, loaded instruction/memory sources, session status, and
project state. It does not itself authorize edits to settings, `CLAUDE.md`,
rules, memory, project files, or processes.

An explicit "ramp up" or "use the good brain" request authorizes reversible
model/effort changes for the current session when the active controls permit
them. It does not authorize a persistent settings or environment change. If a
higher-precedence environment or managed policy prevents the target, report the
required new-session or configuration boundary instead of claiming success.

Persistent changes require an explicit request. Apply the smallest change at the
correct scope and never weaken managed policy.

## 1. Resolve the current good-brain policy

The durable user intent is:

- use the strongest Claude Code model actually available for serious,
  high-value work;
- prefer a dynamic current-model alias when staying current matters, and a full
  version only when reproducibility or provider routing requires a pin;
- use `xhigh` as the quality-first durable effort when the model supports it;
- reserve `max` for an explicitly demanding session because it is session-only,
  unconstrained, can have diminishing returns, and can overthink;
- use `ultracode`, agent teams, or other orchestration only when delegation is
  explicitly requested or applicable instructions authorize meaningful parallel
  work;
- downshift for latency/cost only when the user asks or the task explicitly
  values it more than depth.

Current Claude Code uses `best` for Fable 5 where available and otherwise the
latest Opus. Fable 5 is the current most capable model for hardest and
long-running work. On the verified 2026-07-10 machine, user settings already pin
`claude-fable-5[1m]`; do not replace it merely to normalize spelling.

Modern Fable, Sonnet 5, and Opus 4.7+ always use adaptive reasoning. "No adaptive
thinking" cannot be satisfied on those models by a hidden toggle. Interpret the
user's normal intent as deeper/more frequent reasoning through effort. If they
literally require fixed-budget thinking, explain that it requires an older
supported model and an explicit quality-versus-control choice; never pretend the
strongest current model became fixed.

## 2. Audit effective model and effort

Do not infer active state from one settings file.

### Model evidence

Resolve model selection from the active session, managed restrictions, `/model`
or startup flag, `ANTHROPIC_MODEL`, and scoped settings. Aliases vary by provider
and update over time. Fable may automatically fall back to Opus for classified
security or biology work; report the visible fallback rather than calling it an
account defect or silently claiming Fable remained active.

### Effort evidence

For effort, `CLAUDE_CODE_EFFORT_LEVEL` overrides interactive selection,
configured `effortLevel`, and skill/subagent frontmatter. A session launched with
that variable set to `high` cannot be raised to effective `xhigh` merely by
running `/effort xhigh`.

`low`, `medium`, `high`, and `xhigh` can persist. `max` is session-only unless
forced by the environment. `ultracode` is a session-only orchestration setting
that sends `xhigh`; it is not a higher model effort level.

Use the current UI/status, `/model`, `/effort`, `/config`, and focused environment
and settings inspection. If model availability matters, check the live picker or
current official model configuration. Do not launch a paid/non-interactive model
call merely to audit a file setting.

On this machine, persisted `effortLevel` is `xhigh` but
`env.CLAUDE_CODE_EFFORT_LEVEL` and the current process environment are `high`.
Therefore effective effort is `high`. Treat that as a real precedence conflict,
not as an `xhigh` session. The minimal durable correction, if explicitly
requested, is normally to remove the duplicate environment override and let
`effortLevel: "xhigh"` apply; preserve it if the user confirms the `high` cap is
intentional.

## 3. Apply settings scope correctly

General settings precedence is:

1. managed policy, which cannot be weakened;
2. command-line/session override;
3. local `.claude/settings.local.json`;
4. project `.claude/settings.json`;
5. user `~/.claude/settings.json`.

Some keys merge and some replace; permissions have special merge behavior.
Product-specific environment variables can override their corresponding setting.
Inspect the documented behavior for the exact key before editing.

Use user scope for durable personal preferences, project scope for shared team
configuration, local scope for gitignored machine/project overrides, and managed
scope only through authorized administration. `--bare` disables normal
`CLAUDE.md` discovery and many customizations; `--safe-mode` disables
customizations for diagnosis. If either is active, report that the normal baseline
is intentionally not loaded.

## 4. Use Claude's actual instruction chain

Claude Code reads `CLAUDE.md`, not `AGENTS.md`, by default.

- managed instructions load first;
- user `~/.claude/CLAUDE.md` follows;
- `CLAUDE.md` and `CLAUDE.local.md` from filesystem ancestors through the launch
  directory load broad-to-specific, with local appended after shared at a level;
- `.claude/rules/` may be global, project-wide, or path-scoped;
- instructions below the launch directory load lazily when Claude reads files in
  that subtree.

All instruction text is context, not an enforcement boundary. More specific text
appears later, but contradictory guidance should be resolved against explicit
user/developer authority and managed enforcement rather than trusting arbitrary
last-text behavior.

Do not recursively scan or read every `CLAUDE.md`/`AGENTS.md`. Confirm the loaded
chain with `/memory` or the instruction-loading diagnostic when needed. Ignore
siblings and untouched subtrees. If the task enters a deeper subtree, let its
instructions load and inspect them before editing.

An `AGENTS.md` matters only when an applicable `CLAUDE.md` imports it with
`@AGENTS.md`, a configured fallback/explicit instruction includes it, or the user
asks to consult it. Do not manually elevate an unrelated sibling `AGENTS.md` into
Claude's native instruction chain. On Windows, prefer an import over requiring a
symlink.

Keep persistent instruction files concise, concrete, and non-conflicting. Put
always-needed project facts in root `CLAUDE.md`, multi-step procedures in skills,
and subtree/file-specific rules in path-scoped rules.

## 5. Apply the operating baseline

For substantive work:

1. verify the premise or live state before editing;
2. define observable success and proportionate evidence;
3. make the smallest complete change without speculative features, unrelated
   cleanup, broad formatting, or premature abstraction;
4. preserve user changes, public contracts, data, process ownership, and local
   conventions;
5. run focused behavioral proof, then wider checks in proportion to risk;
6. report outcome, evidence, limitations, and unresolved state concisely.

Think deeply without narrating hidden reasoning or adding ceremonial plans to
trivial tasks. Ask only when the missing choice materially changes behavior,
authority, safety, or public outcome.

### Writing baseline

- Lead with the outcome or decision.
- Use concise, grammatical English and exact names, commands, and negations.
- Preserve the user's voice for outward-facing artifacts without copying typos.
- Separate confirmed fact, inference, and unresolved risk.
- Avoid canned praise, repetitive framing, bloated headings, and file-by-file
  final changelogs.
- Proofread public artifacts; use `yo-gh-write` for GitHub prose.

## 6. Manage context by usage, not headline capacity

Fable 5 and current Anthropic API models may use a 1M context window. A large
capacity is not a command to read the whole repository and does not mean the
window is full. Use `/context` to inspect actual consumption.

- keep the thread when causal decisions and tool state remain useful;
- use focused `/compact <instructions>` when the task is continuous but context
  needs compression;
- use `/clear` or a fresh session between unrelated tasks;
- fork when exploring an alternative from a trustworthy checkpoint;
- delegate large independent reads only when explicit delegation is permitted.

After compaction, project-root `CLAUDE.md`, unscoped rules, and auto memory are
re-injected. Nested `CLAUDE.md` and path-scoped rules are not; they reload when a
matching file is read. Invoked skill bodies are re-injected under size/count
limits and may be truncated or dropped. Re-establish any load-bearing nested
instruction before the next edit.

Never clear, compact away, or abandon an incident, migration, release, running
agent, or command whose outcome is unknown. First freeze mutation, reconcile
authoritative external state where possible, and create a checked handoff with
objective, source/workspace, decisions, protected state, exact completed and
remaining actions, verification, unknowns, and prohibited repeats.

## 7. Use auto memory proportionally

Claude Code loads the memory index automatically and reads topic files on demand.
Do not manually load every memory file as a ramp-up ritual. Use `/memory` when
prior project knowledge is relevant or to inspect what actually loaded.

Store durable, reusable project learnings in memory; put team instructions in
`CLAUDE.md` and reusable procedures in skills. Do not persist secrets, transient
incident facts, unverified hypotheses, or a one-off task state as durable memory.

## 8. Own local processes safely

Before starting a server, watcher, browser driver, or other long-running process:

1. inspect the intended port, process, working directory, and start command;
2. identify the owner as user, agent, shared, or unknown;
3. reuse a suitable service or choose an isolated port when possible;
4. record PID, command, port, and `cwd` for anything this agent starts;
5. stop only a confirmed agent-owned process when cleanup is required.

Never kill a listener merely because it is old or conflicting. Do not force-stop
a user-owned or unknown process without explicit authority. If the exact port is
required and ownership cannot be resolved, report the conflict and ask for the
smallest decision.

## 9. Change settings safely

When explicitly asked to persist a change:

1. inspect active CLI version, managed constraints, relevant environment, and
   all scopes that define the key;
2. choose the correct user/project/local layer;
3. preserve comments where possible, unrelated keys, hooks, MCP configuration,
   permissions, and secrets;
4. apply only the requested delta;
5. validate JSON/schema and confirm effective state in a fresh session or the
   supported settings/status UI;
6. report the exact layer/key, restart boundary, effective value, and anything
   a higher-precedence source still overrides.

Non-interactive Claude may silently ignore invalid settings. JSON parsing alone
is necessary but not sufficient; verify the active result. Do not use
`claude doctor` casually in an untrusted directory because it may start configured
MCP servers.

## Completion

For ramp-up, report meaningful drift or confirm the effective model/effort and
instruction posture concisely. For a persistent edit, report exact changed keys,
validation, restart/new-session needs, and the effective—not merely stored—state.

## Anti-patterns

- Pinning "Opus" as strongest when `best`/Fable is available.
- Claiming current adaptive models can use fixed thinking budgets.
- Treating `/effort xhigh` as effective while an environment variable says high.
- Selecting `max` or `ultracode` as an automatic permanent default.
- Treating 1M capacity as a reason to load everything or as proof of degradation.
- Scanning sibling and vendor instruction files before their scope is touched.
- Assuming nested instructions survive compaction without reloading.
- Reading all memory every session.
- Killing a process before proving ownership.
- Editing persistent settings during a read-only ramp-up.

## Research basis

Official sources and dated local evidence are in `references/sources.md`.
