# Review method

## Identify the exact comparison

| Target | Comparison | Identity to report |
|---|---|---|
| Commit | Parent tree to commit | Full commit SHA and parent(s) |
| Pull request | Intended base/merge base to current head | Base SHA, head SHA, PR number |
| Branch | Explicit base to branch tip | Both resolved SHAs |
| Staged change | HEAD tree to index | HEAD SHA plus index diff identity/time |
| Working tree | HEAD/index plus unstaged and relevant untracked files | HEAD SHA and enumerated local surfaces |

For merge commits, understand whether the requested object is the merge result, first-parent change, or full combined history. Do not substitute one diff interpretation silently.

For remote reviews, refresh the referenced state when live access is authorized and cheap. A branch name or PR number is mutable; evidence attaches to resolved SHAs.

## Acceptance matrix

Create a compact matrix before deciding the verdict:

| Criterion | Code path | Test/runtime evidence | Status |
|---|---|---|---|
| Observable behavior | Definition through consumer | Focused assertion/reproduction | Supported/failed/unverified |
| Compatibility/data | Old/new reader-writer or rollout path | Contract/migration/rollback evidence | Supported/failed/unverified |
| Failure behavior | Error, cleanup, retry, fallback | Negative-path evidence | Supported/failed/unverified |
| Operational behavior | Logs, metrics, alerts, recovery | Config/runtime inspection | Supported/failed/unverified |

Use only rows relevant to the change. Missing evidence is not automatically a defect; decide whether it is material to the requested confidence.

## Review sequence

1. Read intent and acceptance without adopting the implementation conclusion.
2. Inspect summary, commits, file list, renames, binary/generated changes, and dependency/lock changes.
3. Read the diff and full context; trace calls and data across changed boundaries.
4. Inspect tests before relying on their names or counts.
5. Run the smallest discriminating check, then broaden according to risk.
6. Reconfirm the audited identity and current CI state before reporting.

## Finding test

Before reporting a defect, answer:

1. What exact input/state/sequence reaches it?
2. Which changed line or omitted companion change causes it?
3. What requirement or invariant is violated?
4. What can a user, caller, operator, or stored system observe?
5. Is it introduced or left unresolved by this change rather than pre-existing debt?
6. What evidence would disprove the finding?

If these answers are missing, investigate further or label the point as a question/note rather than a blocking defect.

## Verification evidence

- Bind each command to the SHA, environment, configuration, and relevant dependency/service state.
- Confirm that a test was discovered and reached the intended oracle; a nonzero exit alone is ambiguous.
- Distinguish local evidence, CI evidence, staging evidence, and production evidence.
- A pre-existing failure does not become the change's regression without attribution.
- A check against an earlier PR head does not approve the current head.
- Sanitize logs and quote only the portion needed to support the conclusion.

## Verdict table

| State | Verdict |
|---|---|
| Acceptance supported; no Blocker/Major | PASS |
| Concrete Blocker/Major or demonstrated acceptance failure | FAIL |
| Material criterion/evidence unavailable or audited object changed | INCONCLUSIVE |
| Only Minor/Note findings | PASS with findings |

When a domain requires a qualified human or owner review, list that as a residual requirement. Do not present the audit as a substitute for missing expertise.
