---
name: yo-branch
description: >-
  Determine and execute repository-correct branch, commit, pull-request, sync,
  merge, and cleanup workflows. Use when creating or choosing a branch, preparing
  commits, checking PR readiness, pushing or opening a PR, updating published
  history, planning stacked changes, merging, or diagnosing branch-policy state.
---

# Yo Branch

## Outcome

Deliver the intended change through the repository's actual collaboration model
without losing work, targeting the wrong base, bypassing protection, rewriting
shared history unexpectedly, or confusing issue, review, and commit units.

Repository truth comes first. `main`, `develop`, naming prefixes, merge methods,
signing rules, and experiment semantics are not universal.

The default for advice and readiness review is read-only. Mutate only the layer
the user requested:

- create a branch -> local branch and checkout, not push;
- commit -> scoped local commit, not push;
- open a PR -> the required scoped commit/push and PR are part of that workflow,
  but merge is not;
- merge -> merge only after current gates pass; cleanup is separate unless the
  repository automates it or the user requested it.

Use `references/checklists.md` for compact snapshots and handoffs. Conditional
personal preferences retained from the old skill are isolated in
`references/user-preferences.md`; they never override live repository policy.

## Resolve authority before mechanics

Build the effective policy from strongest applicable evidence:

1. explicit user instruction for this action;
2. repository instructions such as `AGENTS.md`, `CONTRIBUTING`, maintainer docs,
   PR templates, `CODEOWNERS`, and workflow configuration;
3. the existing issue, PR, release, or stack topology being continued;
4. live remote default branch, rulesets, branch protection, merge methods,
   merge queue, and required checks;
5. consistent current branch and PR patterns in the repository;
6. conditional user defaults in `references/user-preferences.md`.

Repository hard requirements constrain an explicit request. If a requested name,
base, merge method, or rewrite conflicts with them, surface the exact conflict
instead of silently substituting another policy. Never infer permission to bypass
protection.

When evidence is unavailable, state the assumption. Do not hardcode a fallback
branch name merely because it is common elsewhere.

## 1. Snapshot current state

Use only the `references/checklists.md` snapshot fields that can change the
requested endpoint:

- local inspection or commit -> repository/worktree state, current branch or
  detached `HEAD`, scoped diff, and applicable local commit policy;
- branch creation, synchronization, or push -> add the intended base, relevant
  local/remote refs, ahead/behind state, worktree/name collisions, and refspec;
- PR creation or readiness -> add exact base/head/merge base, existing PR,
  rulesets, merge methods, issue/stack links, and current CI/review state;
- merge -> refresh every live protection, approval, check, deployment, conflict,
  queue, and merge-method field required by repository policy.

Do not fetch remotes or query PR, ruleset, CI, reviewer, or merge state for a
local endpoint when those facts cannot change the action. Unknown inapplicable
fields need no `N/A` record.

Read-only network refresh is permitted unless the user says offline. It updates
local knowledge, not remote branches. Keep the reviewed SHAs in the handoff when
the state can move underneath the decision.

Treat every pre-existing working-tree change as user-owned. Do not stash, reset,
clean, stage, switch across, or absorb it automatically. If the current checkout
is dirty or shared, use a separate worktree when that is the safest authorized
way to isolate the requested branch; never move or delete another worktree.

## 2. Choose base, topology, and name

### Base selection

Choose the base that owns the intended integration:

- an existing PR keeps its current base unless retargeting is requested;
- a stacked change bases on its required predecessor;
- a release or backport follows the documented release line;
- otherwise follow repository policy and the live default/integration branch.

Branch from the fresh remote-tracking base, not a stale local approximation.
Do not assume `develop` exists or that the default branch is `main`.

Changing the base of an open PR can remove commits from the comparison and make
review comments outdated. Treat retargeting as a review-affecting mutation and
explain it before acting when it was not the user's explicit request.

### Branch topology

Use one branch when one reviewable change can land coherently. Use separate or
stacked branches when changes have different owners, risk, rollout, bases, or
independent merge order. Keep each intermediate state buildable and compatible.

Do not force one issue, one branch, and one PR into an equation:

- a parent tracker may have several independently mergeable PRs;
- one coherent PR may close several tightly coupled issues;
- a large issue may need slices or sub-issues;
- a PR may intentionally reference, but not close, a parent issue.

The PR is the unit of review. The issue is a unit of intent or tracking. A commit
is a history checkpoint. Keep traceability between them without pretending they
must be one-to-one.

### Branch name

Follow the repository's current required pattern. Use a short, descriptive topic
and include issue, user, type, or scope segments only when policy requires them.
Do not invent a handle, owner, or personal suffix. Check for local, remote, and
worktree collisions; never repoint an existing name to new history silently.

If the current branch is already the explicitly intended place for the work, do
not create another branch for ceremony.

## 3. Create or adopt safely

At branch creation time, record the exact base ref and SHA. Confirm that changing
checkout cannot overwrite or hide user work. If the requested branch already
exists, determine whether to adopt it, update it, or choose a new name; do not
reset it to the desired base.

Detached work must be preserved before switching away. A branch checked out in
another worktree must be used there or handled through a new branch, not forced
into the current worktree.

Creating a local branch does not authorize a remote branch. Report the local name,
base SHA, and working-tree state when that is the requested endpoint.

## 4. Shape commits for the repository

Commit only explicitly scoped paths after reviewing the staged diff. Keep tests
and required migrations or generated outputs with the behavior they prove.

Prefer coherent checkpoints that explain one purpose and can be reviewed or
reverted sensibly. Avoid arbitrary line limits and one-finding-one-commit rules.
A generated change, mechanical refactor, or compatibility preparation may be
large yet conceptually simple; unrelated behavior remains separate.

Follow repository rules for message format, signatures, linear history, DCO,
trailers, and squash policy. Local fixup commits may be reasonable during work;
rewrite them before review only when policy or the user requires it. Never rewrite
published or shared history merely to make a prettier log.

Scan for secrets, credentials, accidental binaries, unrelated generated files,
and forbidden project/user markers before committing. Apply the conditional
no-coauthor and no-assistant-mention preference in
`references/user-preferences.md` when no repository rule conflicts.

## 5. Synchronize deliberately

Being behind the base is not automatically a defect. Update when protection
requires it, conflicts exist, the base changed relevant behavior, or fresh
integration proof is needed. A merge queue may provide stronger latest-base proof
without repeatedly rebuilding every branch.

Choose synchronization from repository policy and collaboration state:

- unpublished, unshared branch -> rebase can be a safe local cleanup;
- published personal branch -> rebase rewrites remote history and requires
  explicit authorization;
- shared branch -> prefer a non-rewriting method or coordinated replacement;
- linear-history repository -> follow its supported rebase/update path;
- merge-commit repository -> merging the base may be the expected audit trail;
- stacked branch -> preserve the predecessor relation and retarget only when its
  merge state is known.

If an authorized published rewrite is necessary, refresh the remote tip and use
an explicit lease tied to the expected ref. Never use an unconditional force push.
If the lease fails, stop and inspect the new remote work rather than overriding it.

After any synchronization or conflict resolution, review the resulting diff and
rerun affected verification. Resolution can change behavior even when commits
look familiar.

## 6. Gate PR readiness

Evaluate the actual comparison from the base/head merge base, not a guessed range.

Run the PR readiness record in `references/checklists.md`. Its four gates are:

1. **Identity and scope** - correct repository/base/head/stack; every committed
   and uncommitted change accounted for; one reviewable purpose; no secrets or
   accidental generated output.
2. **History and policy** - naming, signatures, DCO, linear history, rulesets,
   push destination, and issue-closing semantics pass.
3. **Evidence** - focused proof, the smallest affected required project gates,
   and proportionate self-review. Require `yo-engineering` or `yo-audit` only
   when an inherited S2/S3 risk, repository policy, explicit request, or named
   material uncertainty calls for that specialist gate.
4. **Review contract** - the actual template, `CODEOWNERS`, dependencies,
   rollout/migration context, and reviewer verification path are clear.

A draft PR may be appropriate before every gate is green when the user requests
early collaboration. Label missing proof and blockers explicitly. Do not call a
draft ready for review. A ready PR must satisfy all applicable local prerequisites.

## 7. Push and open the PR

Immediately before pushing, refresh the remote head and confirm the refspec sends
only the intended local branch to the intended repository. A request to open a PR
authorizes that necessary scoped push unless the user says not to push.

Hand title and body composition to `yo-gh-write`. It should receive the verified
base/head SHAs, issue-link semantics, diff summary, evidence, risks, and stack
dependencies. Do not use a closing keyword for work that does not complete the
issue, or for a non-default base where the platform will ignore it.

After creation, verify the PR's actual URL, head, base, draft state, commits, and
reported checks. Do not assume CLI success means the intended comparison exists.

## 8. Follow CI and review state

Observe required checks, reviews, conversations, deployments, and mergeability on
the current head. Pending is neither failed nor complete; neutral or skipped is
acceptable only when repository policy accepts it. For a failure, bind it to the
revision, inspect the first cause, and distinguish branch regression, proven base
failure, flake, and infrastructure. Use `yo-debug` only for an in-scope
unexplained failure. Do not investigate further, retry, baseline, link, create a
follow-up, or patch an unrelated base failure. If a required check blocks the
requested endpoint, report that limitation and ask before separate remediation.

Review updates return to `yo-fix-loop`; review replies use `yo-gh-write`. Pushing
new commits may dismiss approvals or invalidate checks, so reassess live state.
Reuse content-bound implementation and audit evidence; refresh the PR's
state-dependent checks and rerun only proof affected by new commits.

## 9. Merge and prove landing

Merge only when the user requested it and the merge checklist in
`references/checklists.md` passes on freshly read base/head SHAs, approvals,
conversations, checks, deployments, conflicts, queue state, and allowed method.

Use the repository's merge, squash, rebase, or queue policy. Never use admin or
ruleset bypass merely because credentials allow it. If the user explicitly asks
for a bypass, surface the unmet protections and blast radius before any action.

After merge, verify the platform-reported merged state, target branch, merge or
squash commit, and target-branch containment. A squash merge will not make the
original head an ancestor, so verify according to the actual merge method.

Delete local or remote branches only after confirming they are merged, are not a
base for active stacked work, and cleanup is authorized or automated by policy.

## Stop and report

At every endpoint, report repository/worktree, base/head refs and SHAs, issue/PR
and stack mapping, local and remote state, verification and unresolved gates,
history rewrites or policy exceptions, and the next authorized action.

Limit unresolved gates and next actions to the requested delivery surface. An
ambient failure is not a new branch, issue, or remediation task.

Never say "ready," "up to date," "green," "merged," or "clean" without naming
the evidence and state that was checked. If remote state may have changed since
the snapshot, say so and refresh before acting.

## Anti-patterns

- Hardcoding branch names, bases, or issue-to-PR counts.
- Letting personal convention override repository policy.
- Switching, stashing, resetting, or staging across user-owned dirty state.
- Using a stale base, wrong merge comparison, or accidental push destination.
- Rewriting published/shared history or force-pushing without explicit safeguards.
- Bypassing protection or duplicating proof owned by a merge queue.
- Calling a draft, pending CI, or partial parent issue complete.
- Turning an unrelated check failure into tracked or remediated work.
- Deleting a branch that still anchors stacked work.

## Research basis

Primary sources and derived rules are in `references/sources.md`.
