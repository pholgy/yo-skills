# Yo skills bundle

This is a self-contained pack of 19 software-engineering skills for Claude Code
and Codex. The bundle favors live evidence, narrow ownership, reversible
changes, explicit risk, and honest handoffs over ceremony or assumed success.

The bundle was rebuilt from primary engineering and platform sources on
2026-07-10, then refined on 2026-07-14 with a risk-based direct lane, a compact
single-bug regression path, target-scoped pre-edit gates, and an opt-in verified
hook lifecycle. On 2026-08-08 it gained a bundle-wide Golden Engineering
Standard: maximum correctness and clarity with minimum necessary complexity,
root-cause defect closure, focused regression proof, and a final simplification
pass. The previous version of every skill is preserved under
`archive/yo-<name>-2026-07-10/`.

## Golden Engineering Standard

Every implementation, fix, design, test, delegation, and audit follows one
quality contract:

> Produce the smallest complete, production-quality solution.

Prefer direct local patterns and the fewest new concepts that meet current
acceptance and demonstrated risk. Do not add speculative abstractions,
dependencies, layers, configuration, compatibility machinery, or operational
systems. Do add the structure genuinely required for correctness, security,
data integrity, supported compatibility, reliability, repository boundaries,
and faithful proof.

For defects, remove the causal mechanism, cover realistic in-scope paths that
share it, add focused regression evidence, and verify relevant surrounding
behavior. Finish substantive work by deleting any moving part that does not
protect a requirement, invariant, contract, or testable risk.

Treat a proven definition of done as terminal. Once acceptance and the requested
delivery boundary are met, relevant fresh evidence passes, and no Blocker or
Major remains, stop. Keep optional polish, Minor or Note findings, speculative
reuse, unrelated cleanup, and extra confidence audits outside the implementation
loop; reopen only the smallest scope invalidated by new material evidence.

The exact complexity budget and its primary Google, Microsoft, Anthropic,
OpenAI, and Meta sources are recorded in
`skills/yo-engineering/references/quality-standard.md`.

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
that every task must pass through. Clear low-risk work with focused observable
proof bypasses Yo routing entirely; small consequential changes still escalate
by risk rather than line count.

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
  clear + contained + known cause -> direct compact regression path
  uncertain premise -> yo-verify-premise -> yo-debug if cause is unknown
  consequential edit -> yo-impact; yo-audit when independent proof is useful

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

A regression test protects behavior from returning; observed RED proof is the
stronger claim that the same test fails against the pre-fix mechanism. Daily
known-cause bugs use the focused repository runner (focused Bun test in Bun
projects), keep test and fix together, and run the repository completion gate.
RED proof is reserved for risk that justifies sensitivity evidence, not a
mandatory phase for every fix.

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
- Code quality is judged by complete outcomes, explainability, and the fewest
  justified moving parts—not architectural volume or raw line count.

See `INSTALL.md` for safe, backup-first installation.
