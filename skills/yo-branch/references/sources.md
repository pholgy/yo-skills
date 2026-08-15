# Sources for yo-branch

These sources calibrate collaboration mechanics. The target repository's live
policy remains authoritative.

## Short-lived, reviewable integration

GitHub Flow describes descriptive branches, iterative commits and review,
protected-branch gates, merge, and post-merge branch deletion. DORA associates
trunk-based development with small batches and very short-lived branches. Neither
source establishes a universal branch name or base.

- GitHub Docs, "GitHub flow"
  https://docs.github.com/en/get-started/using-github/github-flow
- DORA, "Trunk-based development"
  https://dora.dev/capabilities/trunk-based-development/

Derived rule: prefer short feedback cycles and repository-native flow, but never
hardcode `main`, `develop`, or one branching model for every repository.

## Review units are conceptual

Google defines a small change as one self-contained change, says there are no
hard size rules, keeps related tests with behavior, and documents both stacked
and independently split changes.

- Google Engineering Practices, "Small CLs"
  https://google.github.io/eng-practices/review/developer/small-cls.html

Derived rule: make PRs coherent and reviewable without line quotas or mandatory
one-finding-one-commit mapping.

## Issue and PR relationships are many-to-many

GitHub supports sub-issues, issue dependencies, multiple linked branches, and
multiple closing references in a PR. Closing keywords apply only under the
documented target-branch conditions.

- GitHub Docs, "About issues"
  https://docs.github.com/en/issues/tracking-your-work-with-issues/learning-about-issues/about-issues
- GitHub Docs, "Creating a branch to work on an issue"
  https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-a-branch-for-an-issue
- GitHub Docs, "Linking a pull request to an issue"
  https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue

Derived rule: preserve traceability without forcing one issue, branch, and PR;
avoid closing parent or partially addressed issues.

## Compare from the real merge base

Git defines the merge base as the best common ancestor used for three-way
comparison.

- Git documentation, `git merge-base`
  https://git-scm.com/docs/git-merge-base

Derived rule: inspect the actual base/head merge relationship rather than a
guessed branch range.

## Protection, current-base proof, and merge queues

GitHub protection and rulesets can require reviews, conversation resolution,
status checks, deployments, signed commits, linear history, and merge queues.
Strict and loose checks have different base-current requirements. Merge queues
test the proposed change against the latest queued target state.

- GitHub Docs, "About protected branches"
  https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches
- GitHub Docs, "About rulesets"
  https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets
- GitHub Docs, "Merging a pull request with a merge queue"
  https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request-with-a-merge-queue

Derived rule: inspect live requirements, distinguish pending from failed, and do
not demand manual rebases when the repository's merge queue owns latest-base proof.

Derived scope rule: query live remote, protection, review, and CI state only for
an endpoint whose decision depends on it. A local commit does not inherit PR or
merge ceremony. A required check may limit the delivery verdict, but an
unrelated failure does not authorize investigation, tracking, or remediation.

## Updating and retargeting can invalidate review state

GitHub documents merge- and rebase-based branch updates, and warns that changing
a PR base can remove commits from the timeline and make comments outdated.

- GitHub Docs, "Keeping your pull request in sync with the base branch"
  https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/keeping-your-pull-request-in-sync-with-the-base-branch
- GitHub Docs, "Changing the base branch of a pull request"
  https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/changing-the-base-branch-of-a-pull-request

Derived rule: choose sync method from repository policy and collaboration state;
treat retargeting as review-affecting.

## Published history rewrites require an exact lease

Git documents that plain force can lose remote work. `--force-with-lease` refuses
the update when the remote ref no longer has the expected value, while noting
limitations of implicit leases without an explicit expected ref.

- Git documentation, `git push`
  https://git-scm.com/docs/git-push

Derived rule: never infer a published rewrite, never use unconditional force,
and bind an authorized lease to a freshly observed remote value.

## Worktrees provide safe isolation

Git worktrees allow multiple working trees attached to one repository and prevent
normal checkout of the same branch in more than one linked worktree.

- Git documentation, `git worktree`
  https://git-scm.com/docs/git-worktree.html

Derived rule: use a separate worktree when it safely preserves dirty/shared state,
and never force a branch already owned by another worktree into the current one.
