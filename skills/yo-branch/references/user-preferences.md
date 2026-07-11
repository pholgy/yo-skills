# Conditional user branch preferences

These preferences are retained from the previous personal skill. They are not
universal repository facts. Apply them only when the target repository uses the
same model and no current user instruction, repository document, ruleset, or live
workflow conflicts.

| Preference | Apply only when |
| --- | --- |
| Personal feature branches use `feat/<topic>-yo` | The repository accepts this pattern and the work is the user's personal feature branch |
| Bug-fix branches use `fix/<topic>` | The repository has no stronger naming rule |
| Feature and fix work integrates into `develop` | A live `develop` branch is the documented integration target |
| `main` is a release line | The repository actually documents or demonstrates that model |
| `experimental/*` is reference-only and never merges | The target repository defines those branches that way |
| `experiment/automated-test-docs` is a long-running QA consolidation branch | That exact project workflow is being continued and the branch still exists |
| Do not add `Co-Authored-By` or assistant/vendor mentions to commits | No repository-required trailer conflicts; this remains the user's preferred authorship policy |

Do not use these preferences as evidence that a missing branch, user handle, or
repository policy exists. If the current repository requires
`users/<handle>/<topic>`, mergeable `experimental/*`, signed commits, `trunk`, or
another model, that live policy wins.

The original hardcoded behavior remains preserved in the dated archive for
historical compatibility.
