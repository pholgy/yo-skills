# Yo skills bundle

This is a self-contained pack of 19 software-engineering skills for Claude Code
and Codex. The bundle favors live evidence, narrow ownership, reversible
changes, explicit risk, and honest handoffs over ceremony or assumed success.

The 2026-07-10 revision was rebuilt from primary engineering and platform
sources, then exercised with fresh-context scenario tests. The previous version
of every skill is preserved under `archive/yo-<name>-2026-07-10/`.

## Start here

| Situation | Entry point |
|---|---|
| Claude Code session or settings baseline | `yo-claude-settings` |
| Codex session or settings baseline | `yo-codex-settings` |
| Unsure which workflow owns the request | `yo-flow` |
| Broad, consequential engineering decision | `yo-engineering` |
| Broad, read-only, cross-cutting review | `yo-workflow` |
| Active production impact | `yo-incident` |

Clear requests route directly. `yo-flow` is for genuine ambiguity, not a menu
that every task must pass through.

## Skills

| Skill | Owns |
|---|---|
| `yo-audit` | Independent, read-only verification of an exact diff, commit, PR, or claimed fix |
| `yo-branch` | Repository-correct branch, commit, sync, PR-readiness, merge, and cleanup decisions |
| `yo-claude-settings` | Live Claude Code model, effort, instruction, context, memory, and process-ownership baseline |
| `yo-codex` | Authority-preserving delegation to Codex through native agents, callable MCP, or CLI |
| `yo-codex-settings` | Live Codex model, effort, instruction, context, memory, and process-ownership baseline |
| `yo-debug` | Root-cause analysis for a confirmed failure whose mechanism is still unknown |
| `yo-deps` | Dependency selection and changes with supply-chain, compatibility, and reproducibility checks |
| `yo-design` | Design docs, alternatives, contracts, migrations, and ADR-worthy decisions before costly implementation |
| `yo-engineering` | Senior risk and decision gate for broad or consequential work |
| `yo-feature` | New capability from intent and acceptance criteria through verified implementation and rollout handoff |
| `yo-fix-loop` | Evidence-backed disposition of multiple bugs, review comments, or findings |
| `yo-flow` | Narrow routing among bundled Yo workflows |
| `yo-gh-write` | Issues, PRs, reviews, replies, status evidence, releases, and incident updates in concise GitHub Markdown |
| `yo-impact` | Pre-edit consumers, contracts, persisted state, sibling paths, and blast-radius analysis |
| `yo-incident` | Active incident declaration, mitigation, recovery, handoff, and follow-up |
| `yo-release` | Versioning, publication, promotion, rollout, verification, and recovery |
| `yo-test-coverage` | Behavior-protecting regression, characterization, contract, and risk-based tests |
| `yo-verify-premise` | Revision- and environment-bound verification of a claim before acting |
| `yo-workflow` | Risk-based deep-review program: map, partition, discover, independently challenge, and synthesize |

## Operating model

The common routes are deliberately short:

```text
Alleged bug
  yo-verify-premise -> yo-debug if cause is unknown
  -> yo-impact before an edit -> yo-test-coverage when useful
  -> yo-audit for an independent final check

New consequential capability
  yo-engineering -> yo-design when a decision needs approval -> yo-feature

Multiple findings
  yo-fix-loop -> per-item premise, impact, test, and verification disciplines

PR or GitHub handoff
  yo-branch -> yo-gh-write

Active production impact
  yo-incident first -> yo-debug after recovery -> yo-fix-loop for follow-up
```

Optional steps stay optional. The user's requested outcome and stopping point
control the route.

## What makes `yo-workflow` a deep-review workflow

`yo-workflow` is not a generic request to run many agents. It binds the review
to a snapshot, maps actors, state, trust boundaries, and end-to-end flows, then
partitions work by invariant or risk question. Discovery produces candidates,
an independent challenge pass tries to refute them, and synthesis separates
confirmed findings from unresolved risks and coverage limits. Parallelism is
used only when scopes are independent, with one writer per tree and a final
cross-partition completeness pass.

## Bundle guarantees

- Every live skill has a `SKILL.md`, supporting references, and Codex UI metadata.
- Every skill records the primary sources that informed its behavior.
- No Yo workflow requires a non-Yo skill to function.
- Platform state is inspected live; archived model, tool, or sandbox assumptions
  are not treated as current truth.
- Read-only review does not silently mutate code, GitHub, deployments, or user
  processes.
- Destructive, external, and difficult-to-reverse actions preserve their own
  approval boundary.

See `INSTALL.md` for safe, backup-first installation.
