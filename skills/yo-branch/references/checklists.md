# Branch workflow checklists

Use only the sections relevant to the requested endpoint.

## State snapshot

Start with the local fields. Add an extension only when the requested endpoint
uses it; omitted inapplicable fields are not blockers.

```markdown
Repository:
Current worktree and branch or detached HEAD:
HEAD SHA:
Staged / unstaged / untracked / conflicts:
Other worktrees using relevant branches:
Applicable local commit policy:
```

### Branch, synchronization, or push extension

```markdown
Authenticated remote and intended refspec:
Intended base ref and fetched SHA:
Head ref and local/remote SHA:
Ahead / behind:
Name / worktree collisions:
```

### PR or merge extension

```markdown
Merge base:
Existing PR and draft state:
Repository instructions:
Naming / signing / history policy:
Protection / rulesets / required checks:
Allowed merge methods / queue:
Issue links / stack dependencies:
```

Record unknown instead of filling gaps from habit.

## Branch creation gate

- branch creation and checkout are explicitly requested or necessary to an
  explicitly requested PR workflow;
- exact fresh base and its authority are known;
- name follows repository policy and does not collide;
- working tree can switch safely, or an isolated worktree is chosen;
- detached or uncommitted work is preserved;
- no remote push is performed unless separately authorized.

## Commit gate

- only intended paths are staged;
- staged diff and generated changes were reviewed;
- no secrets, credentials, accidental binaries, or unrelated formatting;
- behavior and its proof stay coherent;
- message, signature, DCO, and trailer policy pass;
- no published history is rewritten implicitly.

## PR readiness record

```markdown
Purpose and issue relationship:
Base...head comparison and merge base:
Commits and diff scope:
Focused verification:
Repository gates:
Risk / rollback / audit:
Stack order and dependent PRs:
Template / CODEOWNERS / reviewers:
Draft or ready, with reason:
Known gaps:
```

For Direct/Scoped work, `Risk / rollback / audit` may be a focused self-review
with no residual material risk. Require a specialist review only when repository
policy, an explicit request, an inherited consequential tier, or a named
uncertainty triggers it.

Use `Refs #N`, `Part of #N`, or plain links when a PR contributes to but does not
complete an issue. Use a closing keyword only when the PR truly owns completion
and the platform applies it to the selected base.

## Published rewrite gate

- repository permits the rewrite;
- user explicitly authorized rewriting this published branch;
- branch is not shared or all collaborators are coordinated;
- remote head was freshly fetched and recorded;
- rewritten diff and commits still express the intended change;
- force-with-lease is bound to the expected remote ref value;
- a lease failure stops the operation;
- checks and reviews invalidated by the rewrite will be rerun.

## Merge gate

- merge is explicitly requested;
- PR head/base are still the reviewed SHAs or changes are re-reviewed;
- required approvals, checks, conversations, and deployments pass;
- merge queue is used when required;
- allowed merge method is selected;
- no policy or admin bypass is inferred;
- post-merge proof identifies the target and resulting commit;
- cleanup does not break a stack and is authorized.

## Stacked PR map

```markdown
PR / branch | Base | Depends on | Can merge now? | Retarget after | Downstream users
```

Each PR should explain its dependency and review order. When a predecessor merges,
refresh downstream comparisons before rebasing, retargeting, or deleting the
predecessor branch. Changing a base can invalidate review comments.

## Endpoint handoffs

### Local branch only

Name, base SHA, worktree, preserved user changes, and whether a remote branch or
PR exists.

### PR opened

URL, base/head SHAs, draft/ready state, issue semantics, checks, reviewers, stack,
and gaps. "Opened" is not "ready" or "mergeable."

### Merged

PR, target, merge method, resulting commit, required gates observed, containment
proof, branch cleanup state, and any deployment/release work that remains.
