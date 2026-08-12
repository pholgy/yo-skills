---
name: yo-fix-loop
description: >-
  Drive multiple bugs, review comments, audit findings, or action items from
  intake through evidence-backed disposition. Use when the user asks to fix,
  clear, address, triage, or close a wave of findings, including PR feedback,
  bug-bash output, audit results, and remediation backlogs. Remove root causes
  with the smallest complete corrections, cover realistic same-cause paths,
  and carry regression proof to every affected item.
---

# Yo Fix Loop

## Outcome

Reconcile every source finding exactly once. Confirm what is real, preserve the
source's intent, cluster findings that share a cause, and remove each causal
mechanism with the smallest complete correction. Cover realistic in-scope paths
that share the cause, prove the regression, and carry verification evidence
back to every affected item without broadening into unrelated cleanup.

The default endpoint is a verified local working tree plus an honest status
summary. A request to fix code does not authorize branches, commits, pushes,
GitHub updates, deployments, or releases.

Use `references/ledger.md` for the finding states and the compact ledger shape.

## Route before starting

- Active production impact belongs to `yo-incident`; mitigation outranks this
  orderly remediation loop.
- A single straightforward fix can use the same verification discipline without
  creating a full wave ledger.
- A finding that is actually a new or multi-slice capability belongs to
  `yo-feature`.
- A read-only request to judge existing changes belongs to `yo-audit`.
- A confirmed failure with an unknown cause belongs to `yo-debug` before edits.
- A broad investigation that needs an explicit review program belongs to
  `yo-workflow`; feed its resulting findings into this loop.

Do not force work through this skill merely to preserve the original labels.

Keep one domain owner for each cluster. When `yo-deps` owns an update or
advisory cluster, use this skill's ledger and disposition mechanics without
handing unchanged work back and forth. A bounded specialist handoff returns its
decision and evidence to the current owner; it does not restart the source
workflow.

## Preserve authority and workspace state

- Obey the user's delivery boundary. "Local only" means no public or version-
  control side effects.
- Treat existing uncommitted changes as user-owned. Do not discard, overwrite,
  stage, or reformat unrelated work.
- Pause for a consequential product choice, destructive operation, live-system
  mutation, or material scope expansion that the user did not authorize.
- Keep the ledger in the session or reuse the repository's existing tracker.
  Do not invent a scratch file merely to run the loop.
- Use only the findings placed in scope. Newly discovered defects go into the
  ledger, but do not silently expand the implementation wave.

## 1. Freeze the intake snapshot

Before editing, collect the complete source set that the request refers to:

- issue or audit body and later amendments;
- all relevant review threads, including unresolved, outdated, and already
  answered threads;
- the current diff or code revision to which each finding applies;
- repository instructions, working-tree state, and applicable verification
  commands.

Give each source finding a stable ID and retain its original wording and link or
location. Record the reviewed revision when the source can move underneath you.
If new feedback arrives later, add it as an intake delta; do not rewrite history.

## 2. Interpret source intent

Intent and correctness are different dimensions. Classify each item before
deciding whether code must change:

| Source intent | Required disposition |
| --- | --- |
| Required or blocking | Fix and verify, or challenge with concrete contrary evidence |
| Question | Answer with evidence; change code only if the answer exposes a defect |
| Suggestion, optional, or nit | Evaluate on merit; do not silently promote it to a blocker |
| FYI or informational | Acknowledge or record; no code change is implied |
| Unclear | Infer from project conventions; ask only if the ambiguity changes the outcome materially |

Preserve explicit reviewer labels. A technically severe issue may have been
phrased as a question, and a mandatory-sounding comment may be factually wrong;
both still need premise verification.

## 3. Confirm, normalize, and cluster

For every candidate, state the claim in testable form:

1. observed behavior or condition;
2. expected invariant or outcome;
3. evidence that would confirm or refute it.

Read the cited code and trace the real behavior. Apply `yo-verify-premise`
explicitly when the report is uncertain, stale, expensive, or consequential.
Then assign a ledger state:

- confirmed and ready to plan;
- refuted with evidence;
- duplicate of another source finding;
- accepted with no code change;
- deferred, blocked, or unresolved with the exact reason.

Cluster confirmed findings by root cause or one coherent remediation. Multiple
reports of the same null dereference remain separate source rows, but one fix
cluster can satisfy them. Do not merge superficially similar findings when their
invariants, affected users, or acceptance checks differ.

If findings conflict, preserve both and surface the decision instead of choosing
whichever is easiest. If one cluster grows into architectural or multi-slice
work, route that cluster through `yo-design` or `yo-feature` and keep its source
rows traceable.

## 4. Prioritize and plan the wave

Use the project's established priority and severity scheme when one exists.
Otherwise order work from concrete factors rather than fixed P0-P4 folklore:

- active harm, security or data exposure, and user impact;
- time sensitivity and whether another item is blocked;
- dependency order between clusters;
- confidence in the diagnosis;
- remediation and rollback risk;
- cost and strength of available verification.

Severity describes impact; priority describes what to do next. Do not equate the
two automatically. A lower-severity prerequisite may need to precede a critical
fix, and a high technical score may have low local exposure.

Create one session-plan item per remediation cluster, not per duplicate report.
Each item carries:

- source IDs and root-cause statement;
- scope and affected invariant;
- acceptance proof and relevant negative cases;
- dependencies and delivery boundary.

Keep one mutating cluster in progress at a time unless the work is genuinely
independent and isolated. Read-only investigation may overlap safely. Keep each
change self-contained and reviewable, but do not impose line counts or assume
one finding, one plan item, or one commit are equivalent. `yo-branch` owns commit
and branch shape when version-control delivery is requested.

## 5. Remediate one cluster at a time

### Re-establish current truth

Re-read the source findings and current code before the first edit. Reuse current
premise, cause, and impact evidence bound to the same cluster and content. For a
contained cluster, map `target -> direct consumers -> focused proof` inline.
Use `yo-impact` only for a material shared, public, dynamic, persisted,
authorization, external, mixed-version, or uncertain-consumer surface. If the
cause is not explainable, stop editing and use `yo-debug`.

### Choose the smallest complete correction

Name the root cause, the invariant being restored, compatibility constraints,
and rollback or containment path. Prefer a focused correction over unrelated
cleanup, but include every layer required to make the invariant true. Apply
`yo-engineering` for security, data, concurrency, migration, API, operational,
or otherwise high-risk clusters. If remediation changes a dependency, use
`yo-deps` for the graph decision, consume its result here, and do not re-enter
this loop for the unchanged cluster.

Fix at the narrowest seam that removes the cause for all realistic in-scope
paths. Do not patch one symptom while leaving a known sibling path exposed. Do
not turn "complete" into every imaginable edge case: include a sibling only
when it shares the mechanism and supported invariant. Record unrelated defects
separately rather than hiding them in the patch.

Use the minimum necessary complexity. New abstractions, compatibility layers,
flags, dependencies, configuration, retries, or generalized infrastructure need
a current requirement or demonstrated risk; the possibility of future reuse is
not sufficient.

### Implement with proof

Add or update the strongest practical regression proof alongside the correction.
Use `yo-test-coverage` for a confirmed regression that can be captured
deterministically. Test-first is optional; a test that would detect the broken
behavior is not.

Run focused checks while editing. Do not stage, commit, push, or post merely
because a cluster passes.

### Verify before changing state

Verification must cover the cluster's actual claims, not just compilation:

- reproduce the corrected behavior or run the regression test;
- exercise relevant boundary, negative, authorization, and failure cases;
- inspect sibling paths and public contracts identified by impact analysis;
- run the affected lint, type, build, integration, or runtime checks;
- review the final diff for unrelated edits and test validity;
- remove any new moving part that is not necessary to restore the invariant,
  preserve a current contract, or prove the correction, then rerun affected
  checks.

For broad or high-risk changes, use one read-only `yo-audit` pass. Reuse a pass
already bound to equivalent content; rerun only a changed delta or
state-dependent evidence. A cold self-review is useful but is not independent
verification.

Only move a cluster to verified when the evidence satisfies every mapped source
claim. If verification fails, keep it nonterminal, record the counterevidence,
and return to diagnosis. Do not patch repeatedly without updating the root-cause
hypothesis.

### Reconcile every source row

Attach the cluster evidence to each source finding it actually covers. A
duplicate inherits proof only when its exact claim falls within the verified
behavior. Questions need answers; optional items need an explicit applied or
accepted-no-change decision. Never resolve a row merely because nearby code
changed.

## 6. Verify the wave as a system

After all planned clusters pass individually:

1. run only interaction and regression checks that individual cluster proof
   could not establish across the combined working tree;
2. run the smallest affected repository-required gates;
3. inspect the complete diff and working-tree state;
4. reconcile the final source list against the ledger, including late intake;
5. confirm that no in-scope required item is blocked, unresolved, or merely
   fixed-but-unverified.

Per-cluster proof catches local failures. Wave-level proof catches fixes that
interfere with each other.

## 7. Stop and report honestly

Call the wave complete only when every source finding has an explicit,
evidence-backed disposition and every in-scope required cluster is verified,
refuted, a proven duplicate, or an authorized no-change decision.

Once that condition holds and no Blocker or Major remains, report and stop.
Suggestions, optional items, nits, and PASS-level Minor or Note findings with an
explicit accepted-no-change disposition do not create another remediation
cluster or audit cycle. Reopen only when late intake is explicitly placed in
scope or new material evidence invalidates a completed disposition.

If time, context, tools, or authority run out, stop at a truthful partial result.
List what is verified, what remains, why it remains, and the next executable
step. Deferred work needs a reason and decision owner; blocked work needs the
missing prerequisite; unresolved work needs the conflicting or absent evidence.

The local handoff includes:

- verified clusters and the source IDs each closes;
- exact verification commands or observations and their outcomes;
- no-change, refuted, duplicate, deferred, blocked, and unresolved items;
- working-tree and delivery state;
- residual risks and unverified surfaces.

If the user authorized GitHub delivery, hand the wording to `yo-gh-write` and
resolve a review conversation only after its claim is actually addressed. If
commits, branches, or a PR are requested, route their shape through `yo-branch`.
Do not create follow-up issues or publish comments without that authorization.

## Anti-patterns

- Starting edits before capturing the full source set.
- Treating reviewer wording, severity, and execution priority as the same thing.
- Losing duplicate reports after clustering them.
- Closing a question because code happened to change.
- Marking fixed-but-unverified work complete.
- Calling self-review independent.
- Retrying patches without revising a failed diagnosis.
- Masking the observed symptom while leaving the causal mechanism intact.
- Fixing one known path while leaving a realistic same-cause sibling broken.
- Adding a framework, compatibility layer, or future-proofing that the defect
  does not require.
- Bundling unrelated cleanup into a remediation cluster.
- Forcing arbitrary line, finding, commit, or retry counts.
- Hiding blocked or unresolved items in an optimistic wrap-up.
- Reopening a verified wave for optional or PASS-level feedback that was not
  placed in scope.
- Assuming local fixes authorize external delivery.

## Research basis

The primary sources and the specific rules derived from them are in
`references/sources.md`.
