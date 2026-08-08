# Sources for yo-codex-settings

Codex models and configuration change quickly. Official documentation and live
runtime evidence are the primary sources; the user's durable quality preference
determines the baseline when several supported choices exist.

## Models and reasoning modes

OpenAI's current model guide identifies 5.6 Sol as the flagship for complex
coding, research, computer use, and cybersecurity. It distinguishes Max, which
gives one task more reasoning time, from Ultra, which uses subagents for parallel
work. It also marks 5.5 as previous-generation.

- OpenAI, "Models"
  https://developers.openai.com/codex/models

Derived rules: use the live current frontier model, keep `max` for this user's
deep single-agent default, and do not treat `ultra` as a simple effort increase.

The local 2026-07-10 catalog and config evidence is recorded in
`current-baseline.md`. The runtime supports values newer than those listed in one
static configuration-reference table, demonstrating why live capability probes
must resolve availability.

## Configuration layers and diagnostics

OpenAI documents the effective precedence of CLI/runtime overrides, trusted
project config from root to `cwd`, selected profiles, user config, system config,
and built-in defaults. It also documents `/status`, `/model`, `/debug-config`,
the model catalog diagnostic, personality, sandbox, approvals, and feature flags.

- OpenAI, "Config basics"
  https://developers.openai.com/codex/config-basic
- OpenAI, "Configuration reference"
  https://developers.openai.com/codex/config-reference
- OpenAI, "Developer commands"
  https://developers.openai.com/codex/cli/reference

Derived rules: user config is not necessarily effective state, inspect the
highest-precedence active layer, and validate persistent changes in a new thread
or supported diagnostic surface.

## Project instructions

OpenAI documents global instruction discovery followed by one instruction file
per directory from project root to `cwd`; `AGENTS.override.md` has priority at a
directory and nearer project guidance overrides ancestor conflicts.

- OpenAI, "Custom instructions with AGENTS.md"
  https://developers.openai.com/codex/guides/agents-md

Derived rules: resolve the chain for the target path, do not scan unrelated
subtrees, and do not assume `CLAUDE.md` is loaded without an explicit fallback or
repository instruction.

## Prompt and verification quality

OpenAI recommends prompts that name desired behavior, relevant code or
reproduction, important constraints, and how to verify the change. Its examples
favor minimal fixes, focused relevant tests, and reporting commands/results.

- OpenAI, "Prompting"
  https://developers.openai.com/codex/prompting

Derived rules: establish goal/context/boundaries, make focused changes, and bind
completion to observable verification rather than narration.

## Permissions, delegation, and process safety

OpenAI separates sandbox reach, approval policy, network controls, and user
authority. Its subagent guide explains that Ultra/subagents add parallel workers
and warns that write-heavy parallelism increases coordination cost.

- OpenAI, "Agent approvals and security"
  https://developers.openai.com/codex/agent-approvals-security
- OpenAI, "Subagents"
  https://developers.openai.com/codex/subagents

Derived rules: settings never expand authority, automatic delegation is a
behavioral change, and process/filesystem mutation requires ownership rather than
assumption.

## Memory and context

OpenAI describes memories as an optional capability and exposes active session
status/context diagnostics. The platform-specific memory policy supplied to the
agent determines when prior context should be consulted.

- OpenAI, "Memories"
  https://developers.openai.com/codex/memories

Derived rule: consult memory when relevant; do not load all memory as a universal
session ritual. Preserve a durable handoff before changing sessions when causal
state still matters.

## Golden engineering behavior

OpenAI's engineering material describes the smallest tested fix and scoped,
validated tasks. Google, Microsoft, and Anthropic provide the broader simplicity
and value basis. The source-to-rule map is in
[the bundle quality standard](../../yo-engineering/references/quality-standard.md).

Derived rule: the durable Codex baseline optimizes for maximum correctness with
the fewest necessary concepts, requires root-cause regression closure for
defects, and ends substantive work with a simplification pass.
