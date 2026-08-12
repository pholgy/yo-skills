# Research and decisions

Authority labels:

- **K:** official tool/platform contract
- **I:** official engineering or security guidance
- **M:** empirical research

## Evidence map

### Independent review needs context and technical evidence

- **I - Google Engineering Practices, Introduction:** defines code review as examination by someone other than the author and lists design, functionality, tests, documentation, and related concerns. It also emphasizes choosing qualified reviewers.
  <https://google.github.io/eng-practices/review/>
- **I - Google Engineering Practices, Review standard:** says technical facts and data overrule preferences and non-critical polish should not block a change. This supports neutral evidence and separating blocking findings from notes.
  <https://google.github.io/eng-practices/review/reviewer/standard.html>
- **M - Bacchelli and Bird, Expectations, Outcomes, and Challenges of Modern Code Review:** observed and surveyed Microsoft teams; change understanding was a key review challenge, while review also supported defect finding, knowledge transfer, awareness, and alternative solutions. This supports reading system context rather than diff-only pattern matching.
  <https://www.microsoft.com/en-us/research/publication/expectations-outcomes-and-challenges-of-modern-code-review/>

### Review scope and comments should be explicit

- **I - Google Engineering Practices, What to look for:** recommends reviewing every assigned human-authored line, reading broader context, checking appropriate tests and documentation, and involving qualified reviewers for domains such as security and concurrency.
  <https://google.github.io/eng-practices/review/reviewer/looking-for.html>
- **I - Google Engineering Practices, Review comments:** recommends explaining why and labeling required, optional, and informational feedback distinctly. This supports concrete findings and severity labels.
  <https://google.github.io/eng-practices/review/reviewer/comments.html>
- **I - OWASP Secure Code Review:** treats manual review as complementary to automated tools and recommends tracing inputs, trust boundaries, authorization, data, errors, and configuration for security-relevant changes.
  <https://cheatsheetseries.owasp.org/cheatsheets/Secure_Code_Review_Cheat_Sheet.html>

### Evidence belongs to exact revisions

- **K - Git, `git diff`:** defines comparisons between explicit endpoints, merge bases, index, and working tree. This supports naming the actual audit object rather than assuming every target is one commit.
  <https://git-scm.com/docs/git-diff>
- **K - Git, Git objects:** tree objects identify tracked directory content
  independently from commit metadata. This supports proving content equivalence
  before reusing content-bound inspection while still refreshing external or
  state-dependent evidence.
  <https://git-scm.com/book/en/v2/Git-Internals-Git-Objects>
- **K - GitHub pull-request review API:** binds a review to a commit ID and warns that comments can become outdated after new commits. GitHub also supports distinct comment, approve, and request-changes actions. This supports SHA-bound evidence and explicit publication authority.
  <https://docs.github.com/en/rest/pulls/reviews>

## Bundle decisions

### Kept

- Read-only separation between auditor and fixer.
- Independent inspection of intent, scope, behavior, tests, root cause, hidden coupling, and regressions.
- Exact commands and concrete file/line evidence for findings.

### Improved

- Replaced adversarial disbelief with neutral evidence-first review.
- Added exact base/head/working-tree identity, moving-head invalidation, acceptance mapping, and risk-proportional verification.
- Added `INCONCLUSIVE` for material ambiguity or unavailable evidence instead of mislabeling the code FAIL.
- Defined actionable finding criteria and severities; separated pre-existing debt and preferences.
- Clarified that test/build execution can use an isolated workspace without authorizing source edits or external effects.
- Made chat the default report destination and all GitHub actions explicit-authority operations.
- Made independent review validate one exact-release evidence bundle and
  selectively reproduce challenged, stale, or decision-critical proof instead
  of rerunning a valid matrix wholesale.
- Separated immutable-artifact audit from per-batch external-state proof so a
  long rollout does not create one stale fleet-wide terminal gate.
- Ordered the single release-candidate audit after an authorized representative
  canary when its verdict includes canary evidence; a pre-canary readiness
  review remains narrower and cannot imply a mandatory duplicate pass.

### Removed

- Unsupported claims about author-framing bias.
- A universal 200-word cap and mandatory raw-log dump.
- Single-commit-only audit assumptions.
- Automatic PR/issue posting and PASS-as-universal-safety language.
- Non-bundle specialist-skill routing.

## 2026 Golden Engineering Standard update

Google's review guidance explicitly asks whether code is more complex than
necessary, while its review standard separates technical quality from personal
preference. Google SRE describes accidental complexity as a reliability and
maintenance cost. See [the bundle quality standard](../../yo-engineering/references/quality-standard.md)
for primary links and the exact complexity budget.

Derived rule: flag avoidable complexity only when a concrete simpler solution
meets the same acceptance and the extra moving parts create a realistic cost;
never turn taste or line count into a defect. A bounded unnecessary helper may
remain Minor, while a material cluster that violates the explicit quality
standard and substantially raises change or verification cost can be Major.
