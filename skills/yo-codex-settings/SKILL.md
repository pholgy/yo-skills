---
name: yo-codex-settings
description: >-
  Apply or audit the user's Codex session baseline: current frontier model,
  deep single-agent reasoning, pragmatic communication, scoped AGENTS.md
  instructions, focused changes, relevant memory, context hygiene, and safe
  ownership of local processes. Use when the user says "my settings", "ramp
  up", "use the good brain", or reports model/effort drift; when entering or
  changing a project scope; or before changing Codex configuration for this user.
---

# Yo Codex Settings

## Outcome

Start work with the effective Codex configuration, instruction chain, and project
scope understood. Preserve the user's preference for maximum-quality reasoning
without freezing a model name that will age out, and apply a focused engineering
baseline without unsafe cleanup or unnecessary ceremony.

Use `references/current-baseline.md` for the dated local snapshot and live audit
commands. Use `references/operating-baseline.md` for the compact behavior and
handoff checklists.

## Authority

Invoking this skill authorizes read-only inspection of effective settings,
applicable instructions, current working state, and relevant memory. It does not
by itself authorize editing `config.toml`, rules, `AGENTS.md`, memories, project
files, or processes.

An explicit "ramp up" or "use the good brain" request authorizes a reversible
model/effort selection for the current thread when the surface supports it. It
does not authorize a persistent configuration edit. If the active thread cannot
change to the baseline, report the required new-thread boundary instead of
claiming it changed.

If the user asks to change settings, make the smallest validated configuration
edit at the correct layer. Do not rewrite unrelated configuration, expose secrets,
or weaken managed policy. If the user asks only to "ramp up", apply the effective
baseline and report drift; do not persist a change unless correction was also
requested.

## 1. Resolve live configuration, not a historical pin

The durable user intent is:

- use the current frontier Codex model for difficult, high-value work;
- default to the deepest supported **single-agent** reasoning tier;
- do not silently downshift model or effort to save time or usage;
- use a faster/lighter mode only when the user asks or the task explicitly values
  latency/cost over depth;
- use multi-agent/automatic-delegation tiers only when delegation is requested or
  applicable instructions allow it and the work is meaningfully separable.

On the verified 2026-07-10 local snapshot, that intent resolves to
`gpt-5.6-sol` with `max`, not the archived `gpt-5.5`/`xhigh` pair. Treat the
dated values as evidence, not permanent policy. Recheck after CLI upgrades,
deprecations, authentication/provider changes, or a reported quality regression.

`Ultra` is not just "more thinking": current Codex uses it for automatic task
delegation. Do not select it merely because it sorts above `max`. For this user,
`max` is the default deep single-agent posture; route intentional delegation
through `yo-codex`.

### Effective-state precedence

Prefer evidence in this order:

1. explicit instruction or selection for the current turn/thread;
2. active session status and runtime overrides;
3. trusted project `.codex/config.toml` layers from root to `cwd`, nearest wins;
4. selected profile;
5. user `~/.codex/config.toml`;
6. system/managed requirements and built-in defaults.

Managed requirements constrain what lower layers may select. A user config value
is a default, not proof of the active session. Use `/status`, `/model`, and
`/debug-config` when that surface exposes them; otherwise inspect only relevant
keys in the active config layers and probe the installed model catalog/help.

Do not call a newer supported frontier model "drift" because an old skill names
its predecessor. Do not silently substitute another model when the user required
an exact one; report availability and the closest current options.

## 2. Use the applicable instruction chain

Codex loads instructions once per run using scoped precedence:

1. global `AGENTS.override.md` if non-empty, otherwise global `AGENTS.md`;
2. one instruction file per directory from project root toward `cwd`;
3. at each directory, `AGENTS.override.md` wins over `AGENTS.md` and configured
   fallback names;
4. nearer files appear later and override conflicting ancestor guidance while
   preserving non-conflicting rules.

Before substantive work, confirm that the active `cwd` is correct and that the
loaded chain covers the target files. If the task moves into a deeper subtree or
another project, resolve that target's chain before editing.

Do not run a fixed-depth scan for every `AGENTS.md` in the repository. Sibling,
vendor, generated, and unrelated subtree instructions do not govern the current
target. `CLAUDE.md` is not a Codex instruction file by default; read it only when
an applicable instruction points to it, the repository explicitly shares it
across agents, or the task needs its content.

Explicit user/developer instructions outrank this personal baseline. Project
instructions win over generic engineering taste where they do not conflict with
higher authority.

## 3. Apply the operating baseline

For every substantive change:

1. **Establish truth before editing.** Read the cited code/state, distinguish
   fact from assumption, and resolve ambiguity that materially changes outcome.
2. **Define done.** State or internally pin observable acceptance and the checks
   that will prove it.
3. **Make the smallest complete change.** Avoid speculative features,
   pre-emptive abstractions, unrelated cleanup, broad formatting, and policy
   changes hidden inside implementation.
4. **Preserve ownership and local conventions.** Existing user changes remain
   theirs. Match established APIs, patterns, and style unless the task changes
   them deliberately.
5. **Verify the result.** Run the smallest relevant behavioral proof, then wider
   gates in proportion to impact. Report commands and limitations honestly.

Think deeply without narrating hidden reasoning or adding a long preamble.
Communicate assumptions, decisions, tradeoffs, evidence, and blockers at the
level the user needs.

### Writing baseline

- Lead with the outcome or decision.
- Use concise, grammatical English and exact technical terms.
- Preserve the user's voice for outward-facing artifacts; do not imitate typos.
- Separate confirmed fact, inference, and unresolved risk.
- Avoid canned praise, repeated framing, changelog-style final answers, and
  headings that add no structure.
- Proofread names, commands, links, issue/PR references, and negations before
  publishing. Use `yo-gh-write` for GitHub prose.

## 4. Ramp up proportionally

At a new session, project, or materially changed `cwd`:

1. establish task intent, mode, authority, and absolute working directory;
2. confirm the applicable instruction chain;
3. inspect active model/effort only when this skill was requested, drift is
   plausible, or configuration affects the task;
4. inspect relevant repository/workspace state before edits;
5. consult memory only when prior context is likely relevant under the platform's
   memory policy;
6. define the first evidence-producing step and completion condition.

Do not perform a ritual full-machine audit before a trivial self-contained task.
Do not claim a fixed ramp-up time. The check is complete when material settings,
instructions, ownership, and proof obligations are known.

## 5. Manage context and session continuity

Keep the current thread while its decisions, tool state, and causal history are
still useful. A long thread is not automatically degraded.

Prefer a fresh or forked session when:

- the task changes identity and old context is mostly irrelevant;
- stale assumptions or repeated corrections dominate the thread;
- compaction removed a decision or state needed for safe continuation;
- the active model/config changed and a clean boundary matters;
- context pressure is measurably harming reliability.

Before switching, create a concise handoff with objective, current state,
decisions, protected work, exact remaining steps, verification, and unknowns.
Never abandon an active incident, migration, release, or timed-out worker in
unknown state merely to get a cleaner context.

## 6. Own local processes safely

Before starting a server, watcher, browser driver, or another long-running local
process:

1. inspect the intended port/process and repository start command;
2. identify whether an existing process is user-owned, agent-owned, or unknown;
3. reuse a suitable existing service or choose an isolated port when possible;
4. record the PID, command, port, and working directory of processes this agent
   starts;
5. stop only a confirmed agent-owned process when cleanup is needed.

Never kill an old-looking or conflicting process solely because it occupies the
desired port. Do not use `Stop-Process -Force` against a user-owned or unknown
PID without explicit authority. If the task requires the exact port and the owner
cannot be established, report the conflict and request the smallest decision.

## 7. Change configuration safely

When explicitly asked to update Codex settings:

1. inspect the effective layer and current supported schema;
2. choose user config for durable personal defaults, project config for trusted
   project-specific behavior, or a profile for an intentional alternate mode;
3. preserve comments, unrelated keys, MCP definitions, rules, and credentials;
4. apply only the requested delta;
5. validate syntax and confirm effective state in a fresh thread or supported
   diagnostic surface;
6. report whether a restart/new thread is required and what remains unchanged.

Do not edit global instructions to solve a one-project issue. Do not add a model
name merely because documentation mentions it; confirm the signed-in/provider
catalog supports it. If live catalog and static docs disagree, use live runtime
evidence for availability and note the documentation lag.

## Completion

For a ramp-up/audit, report only meaningful drift or confirm the effective
baseline concisely. For a settings change, report the exact layer and keys changed,
validation evidence, active result, and any restart boundary. Do not call a config
file corrected if the current session still runs an override with different
values.

## Anti-patterns

- Freezing a model/version pair in the main skill as permanent policy.
- Treating user config as the active session without checking overrides.
- Selecting `Ultra` as a synonym for maximum single-agent reasoning.
- Scanning or applying every instruction file in unrelated subtrees.
- Reading all memory on every session regardless of relevance.
- Starting fresh because a thread is merely long, without a durable handoff.
- Killing a listener before proving ownership.
- Editing persistent config in response to a read-only ramp-up request.
- Performing broad cleanup under the label of "surgical changes".

## Research basis

Primary sources and the dated local evidence are in `references/sources.md`.
