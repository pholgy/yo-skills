---
name: yo-audit
description: Independently and read-only verify a commit, pull request, working-tree change, or claimed fix against its intent and acceptance criteria. Use for "audit this change," "review this PR," "did this fix work," "is this safe to merge or ship," and post-implementation verification where evidence must be bound to an exact revision.
---

# Yo Audit

Perform a neutral, evidence-first review of an exact change. Do not modify source, fix findings, commit, post comments, approve, request changes, merge, or update issues unless the user separately authorizes that action.

Tests and builds may create ordinary local artifacts. Use an isolated worktree or equivalent when the shared checkout, generated files, or audit independence could be contaminated. Never exercise production or other external state merely to complete an audit.

## Independence

Approach the change as a reviewer, not as an advocate for the implementation. The author's explanation establishes intent and known tradeoffs; it is a claim to verify, not evidence to ignore or accept blindly.

Prefer a fresh context when the same agent implemented the change. If a genuinely independent pass is unavailable, disclose that limitation and call the result a self-review rather than overstating independence.

## Audit workflow

### 1. Bind the audit object

Record the repository, comparison, and immutable identity before reading conclusions:

- **single commit:** parent tree to commit SHA;
- **pull request:** intended base/merge base to current head SHA, including all commits in the PR diff;
- **branch:** explicit base SHA to tip SHA;
- **working tree:** HEAD plus staged, unstaged, and relevant untracked changes.

Check repository status and avoid mixing unrelated local changes into the evidence. For a PR, confirm the head again before reporting. If it moved, the earlier evidence remains valid only for the old SHA; re-audit the delta and rerun affected checks before judging the new head.

When only a container identity changes—for example, a new commit points to the
same relevant tree or an audited diff is replayed unchanged—and commit metadata
is not itself part of acceptance or policy, do not silently copy the verdict.
Prove the content equivalence, carry the earlier content-bound review forward,
and refresh only state-dependent evidence such as CI, remote policy, deployment,
or environment state. Re-audit changed content, changed acceptance, materially
changed conditions, or an explicitly requested new independent review.

Use [references/review-method.md](references/review-method.md) for comparison and verdict rules.

### 2. Establish intent and acceptance

Read the user request, issue/spec, PR description, linked design or decision, and relevant comments when available. Extract observable acceptance criteria and deliberate constraints. Separate:

- required behavior;
- explicitly excluded scope;
- claimed verification;
- surprising but intentional tradeoffs;
- unresolved product or design choices.

If a material requirement is missing, do not invent it. Verify what is knowable and return `INCONCLUSIVE` for the decision that depends on the ambiguity.

Freeze the active audit surface from the current request and accepted
clarifications. Track scope separately from attribution: a pre-existing defect
inside that surface remains reviewable, while an issue outside it does not
become a finding because surrounding inspection or a broad command exposed it.

### 3. Inspect scope and context

Review every human-authored changed line in scope, then read enough surrounding code, callers, tests, configuration, and history to understand its effect. Classify generated, vendored, lockfile, migration, and documentation changes rather than scanning them as equivalent source.

Check that the diff is cohesive and necessary for the stated intent. Name
unrelated edits, accidental generated output, missing companion changes, and
rollback-hostile coupling. Inspect every new abstraction, dependency, layer,
configuration value, state, compatibility mechanism, flag, and helper: it must
serve current acceptance, a supported contract, a demonstrated risk, an
existing repository boundary, or faithful verification. Do not fail a change
solely for a reasonable preference, raw line count, or an out-of-scope
pre-existing issue.

Read outside the changed lines only to understand the in-scope behavior. Do not
turn neighboring defects, old issues, or unrelated debt into audit findings,
baselines, tracker entries, or follow-up recommendations.

### 4. Trace behavior against acceptance

For each acceptance criterion, map:

```markdown
Criterion -> implementation path -> observable outcome -> verification evidence
```

Ask whether the change closes the diagnosed mechanism or only masks its symptom. Trace plausible sibling and fallback paths, cleanup on failures, boundary validation, and mixed old/new behavior when relevant.

Apply only the relevant `yo-engineering` lenses: contracts, data/migrations, authorization/security, concurrency, failure/fallback, performance, observability, operability, accessibility, and user experience. If qualified domain review is still needed, state that residual requirement without pretending this audit supplied it.

Use an existing `yo-impact` brief as a map, but independently verify the material consumers touched by the diff.

### 5. Inspect and run verification

Read changed tests and confirm their oracle exercises the intended behavior.
When a PR claims a regression test protects a high-risk bug, or explicitly
claims sensitivity to the old mechanism, verify the pre-fix sensitivity evidence
or its honest limitation per `yo-test-coverage`. Do not require observed RED
proof for every ordinary change.

Run proportionate checks against the exact audited revision:

1. focused tests or reproduction for the changed mechanism;
2. relevant surrounding or contract/integration tests;
3. repository verification gate when risk and environment justify it;
4. current CI/check status for a PR, bound to the same head SHA.

Reuse still-valid content-bound evidence and rerun only the affected proof. A
new SHA alone does not require a full test matrix when proven-equivalent content
is running under equivalent conditions; moving CI, policy, or runtime state
still requires a fresh read.

Independence means independently judging the implementation, oracles, evidence
provenance, coverage, and residual risk—not automatically rerunning every valid
test, interleaving matrix, reconciliation, migration rehearsal, compatibility
suite, or rollback exercise. Start from one exact-release evidence bundle.
Reproduce only a decision-critical sample or evidence that is stale, challenged,
untrusted, state-dependent, or needed to distinguish PASS from INCONCLUSIVE.

For a batched external-state rollout, run the single release-candidate audit
after the authorized representative canary when the verdict is meant to bind
canary evidence. Bind it to the immutable artifact, transition contract,
recovery rehearsal, and that canary. Each later authorized batch owns fresh
just-in-time operational proof against its current identity. Do not delay or
repeat the artifact audit until every batch finishes, and do not invalidate
earlier completed batches merely because later external state changed. Re-audit
the smallest changed artifact or invariant. A pre-canary readiness review may
judge only the evidence that exists; it must not claim canary coverage or
silently require the same full review again.

Record exact commands, revision/environment, exit status, counts, and the relevant failure signature. Preserve raw output locally when useful, but report concise sanitized evidence; do not paste secrets or indiscriminate logs.

If a command reveals an unrelated failure, do not investigate, baseline, or
route it. Mention it only when it prevents a required check from supporting the
verdict; then narrow the claim or return `INCONCLUSIVE` and ask before any
separate work.

If a required check cannot run, distinguish an evidence gap from a code defect. Use `INCONCLUSIVE` when the missing evidence is material to the merge/ship decision.

### 6. Write only defensible findings

A blocking finding needs all of:

- a concrete input, state, path, or sequence;
- the changed file and precise location;
- the violated requirement, invariant, or safety property;
- the observable consequence;
- evidence that the change introduces or fails to resolve it.

Avoidable complexity is a finding only when a concrete simpler path satisfies
the same acceptance and the extra moving parts create a realistic correctness,
maintenance, operability, or verification cost. Identify the removable concept
and the consequence; do not disguise taste as engineering evidence.

Calibrate the consequence. One bounded unnecessary helper may be Minor. A
material stack of unjustified abstractions, configuration, flags, states, or
layers is Major when it violates the stated Golden Engineering Standard and
meaningfully increases change cost, defect surface, or verification burden.
Name the simpler complete shape; do not block on "too complex" without it.

Classify findings:

- **Blocker:** credible security, privacy, data-loss, outage, irreversible rollout, or fundamental acceptance failure; must resolve before ship.
- **Major:** realistic correctness or compatibility failure within scope, or a
  material evidence-backed quality failure that leaves the solution
  unnecessarily difficult or risky to change and verify; must resolve before
  approval.
- **Minor:** bounded robustness, maintainability, test, or operability issue that does not invalidate the primary behavior.
- **Note:** optional in-scope improvement, question, or necessary scope/evidence
  limitation. Pre-existing describes attribution, not scope or severity.

Explain why. Keep suggestions separate from requirements and avoid comments about the author.

### 7. Decide the verdict

- **PASS:** required evidence supports the acceptance criteria and no Blocker or Major finding remains within the audited scope.
- **FAIL:** at least one concrete Blocker/Major finding exists, an acceptance criterion demonstrably fails, or required verification reports the target failure.
- **INCONCLUSIVE:** the target moved, material acceptance is ambiguous, or required evidence/environment is unavailable; no unsupported PASS or defect claim.

Minor findings and notes can accompany PASS. State residual risk and scope limits. PASS means no blocking defect was found in this exact audit, not proof that the system contains no bugs.

A PASS with only Minor or Note findings is terminal for this audit and does not
require implementation or another audit cycle. Report optional improvements
without promoting them into required work. Reopen verification only when the
audited object changes materially, required evidence fails, or new evidence can
change the verdict; do not run another audit merely for more confidence.

## Report

```markdown
Verdict: PASS | FAIL | INCONCLUSIVE
Audited: <repo, base..head or working-tree identity>

Acceptance:
- <criterion>: <supported | failed | unverified> - <evidence>

Findings:
- [Major] <file:line> <scenario, consequence, and reason>
- None.

Verification:
- `<command>` - <result> at <SHA/environment>

Residual risks / limits:
- <unreviewed domain, unavailable evidence, moving dependency, or none>
```

Lead with findings when any exist. Be concise enough to act on, but do not impose a word cap that hides evidence.

## Publication boundary

Return the report to the user in chat by default. Auditing a PR does not authorize a GitHub comment, approval, request-changes review, merge, or issue update.

If the user explicitly asks for a GitHub artifact, use `yo-gh-write` to format it, confirm the audited head is still current, and perform only the authorized action. Bind any posted verdict to the audited SHA.

## Guardrails

- Remain read-only even after finding a clear fix.
- Do not turn absent test infrastructure into a fabricated FAIL or PASS.
- Do not report speculative edge cases as defects without a reachable scenario and consequence.
- Do not let green CI replace code/behavior review, or let static review replace needed execution evidence.
- Do not fail a change for style preference, unrelated debt, or a requirement invented during review.
- Do not record or recommend work outside the active audit surface merely
  because review exposed it.
- Do not approve speculative architecture merely because it is cleanly coded;
  require a current need for every added moving part.
- Do not turn a PASS with only Minor or Note findings into an implementation and
  re-audit loop.
- Do not reuse a verdict after relevant content, acceptance, or material
  conditions change. For a container-identity-only change, prove equivalence and
  refresh state-dependent evidence as defined above.
- Do not claim merge or production safety beyond the declared scope, environment, and evidence.

## Handoff

- `yo-fix-loop` can triage and resolve accepted findings when the user authorizes changes.
- `yo-debug` investigates a newly confirmed but unexplained failure.
- `yo-test-coverage` strengthens missing or insensitive regression proof.
- `yo-gh-write` drafts or publishes the report only when requested.

## References

- [Review method](references/review-method.md)
- [Research and decisions](references/sources.md)
