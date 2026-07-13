# Yo routing map

Read this file before selecting or chaining a destination. Choose the narrowest
primary skill that owns the user's immediate outcome. Let that skill own later
handoffs unless the user explicitly asks for an end-to-end route.

## Direct lane: no Yo route

Bypass routing and continue through the normal task workflow when the outcome
and target are clear, the change is confined to one file or a few directly
related files for the same local outcome, the work is local and readily
reversible, one focused read or existing check can establish and prove it, and
no material security/auth, public-contract, persisted-data/migration,
concurrency, incident, destructive, deployment, or external-state surface is
involved. The bounded file scope is a containment guard; risk and observability
still decide eligibility, and changed-line count alone never does.

The direct lane still discovers the applicable repository instructions and
verification commands, preserves user work, and runs focused plus proportionate
existing gates. Exit it when inspection exposes a disputed premise, unknown
cause, wider consumer/contract surface, unexplained baseline failure, unfaithful
test seam, or consequential/irreversible effect; route that discovered need
normally.

## Immediate routes

| User's immediate outcome | Primary route | Notes |
|---|---|---|
| Restore service during active user impact | `yo-incident` | Preempt every normal route. |
| Confirm whether a claimed bug or behavior is real | `yo-verify-premise` | Stop at a verdict when the user asked only for verification. |
| Explain a confirmed but unexplained failure | `yo-debug` | Root-cause before fixing. |
| Map callers, compatibility, or blast radius before an edit | `yo-impact` | Also applies to broad refactors of existing behavior. |
| Clear multiple findings, comments, or bugs | `yo-fix-loop` | Use for a wave, not a single item. |
| Apply senior risk, maintainability, or "best engineer" judgment | `yo-engineering` | Direct route; do not ask what kind of quality pass. |
| Decide architecture, compare approaches, write a design, or record an ADR | `yo-design` | Use when planning is the requested deliverable, including "do not implement." |
| Build a new feature or capability end to end | `yo-feature` | Add design/risk gates only when warranted. |
| Independently review a PR, commit, diff, or claimed fix | `yo-audit` | Read-only verification. |
| Add a regression, characterization, or coverage test | `yo-test-coverage` | Pair with a fix when the test protects a bug. |
| Search a broad code surface for findings, then refute and synthesize | `yo-workflow` | Deep review, not implementation. |
| Add, upgrade, remove, or assess a dependency or advisory | `yo-deps` | Includes dependency-selection decisions. |
| Create a branch, choose a base, check PR readiness, push, or merge | `yo-branch` | Use `yo-gh-write` for the prose itself. |
| Draft or post GitHub issues, PRs, reviews, replies, evidence, release notes, or incident updates | `yo-gh-write` | Let it classify the artifact and safety rules. |
| Version, tag, publish, or verify a release | `yo-release` | It hands release prose to `yo-gh-write`. |
| Delegate from Claude to Codex | `yo-codex` | Direct platform workflow. |
| Apply or inspect the user's Codex session baseline | `yo-codex-settings` | Direct settings request. |
| Apply or inspect the user's Claude Code session baseline | `yo-claude-settings` | Direct settings request. |
| Choose among Yo workflows | `yo-flow` | Routing only. |

## Risk overlay

Add `yo-engineering` before the primary route only when the work is broad,
cross-cutting, consequential, or explicitly requests senior engineering
judgment. Do not add it to simple GitHub writing, a small reversible edit, or a
direct settings request.

Preserve explicit approval for destructive, external, security-policy, or
difficult-to-reverse actions. Ask about the action itself, not which workflow
the user wants.

## Common end-to-end chains

Use these only when the user asks for the full path:

- Single alleged bug that needs a specialized route: `yo-verify-premise` ->
  `yo-debug` if the cause remains unknown -> `yo-impact` before editing existing
  behavior -> `yo-test-coverage` when regression protection is appropriate ->
  `yo-audit` for an independent final check. A clear, contained, known-cause bug
  may instead use the direct lane with the compact regression contract.
- Broad or high-risk feature: `yo-engineering` -> `yo-design` when the approach
  needs approval -> `yo-feature`.
- Multiple findings: `yo-fix-loop`; let it invoke premise, impact, test, and
  audit disciplines per item.
- Ready to open a PR: `yo-branch` -> `yo-gh-write`.
- Active incident: `yo-incident`; after recovery, use `yo-debug` for root cause
  and `yo-fix-loop` for action items.

Do not force every optional step. The evidence and requested stopping point
determine where a chain begins and ends.

## No specialized Yo route

General explanation, ordinary research, non-GitHub documentation, and simple
direct implementation may have no specialized Yo owner. Continue through the
normal task workflow instead of inventing or requiring a non-Yo skill.

For edge cases:

- General repository documentation -> normal document/code workflow.
- GitHub-facing documentation or discussion -> `yo-gh-write`.
- Architecture rationale or an ADR -> `yo-design`.
- A broad refactor -> `yo-impact`, plus `yo-engineering` only when risk warrants.
