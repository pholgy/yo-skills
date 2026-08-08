# Golden Engineering Standard

Use this standard whenever the bundle plans, implements, fixes, tests, or
reviews software.

## The standard

Produce the **smallest complete, production-quality solution**.

The result must be correct, clear, direct, explainable, testable, and
maintainable. Every new abstraction, dependency, layer, configuration value,
state, branch, file, and line must serve a current requirement, preserve a
current contract, prevent a demonstrated in-scope failure, follow an existing
repository boundary, or provide faithful verification.

"Smallest" means the fewest new concepts and moving parts that fully solve the
problem. It does not mean blindly minimizing lines, skipping necessary tests,
or weakening correctness, security, privacy, data integrity, compatibility,
reliability, accessibility, or operability.

Spend engineering effort where it changes the outcome: establish truth, choose
the narrowest correct design, implement it clearly, and prove it. Activity,
ceremony, document volume, and architectural volume are not quality signals.

## Complexity budget

Add complexity only when at least one of these is true:

1. current acceptance criteria or a supported contract requires it;
2. it prevents a demonstrated, in-scope failure or material risk;
3. it follows an existing repository boundary and bypassing that boundary
   would create more complexity;
4. faithful verification cannot be achieved without it; or
5. it reduces total complexity now, with a concrete removal or simplification.

If none applies, do not add it. In particular, do not introduce:

- an interface, factory, registry, or strategy for one hypothetical future
  implementation;
- a generic framework for one concrete use;
- a feature flag without an actual rollout, compatibility, or kill-switch need;
- an adapter only because a dependency might someday change;
- configuration for a value that has no present reason to vary;
- dual reads, dual writes, versioning, or migration machinery without a real
  mixed-version or persisted-data requirement;
- caching, queues, retries, concurrency, or observability without a supported
  requirement or demonstrated operational risk;
- an adjacent refactor that is not required to make the change correct and
  reviewable; or
- test infrastructure that is larger or less clear than the behavior it proves.

These are examples, not bans. Use them when current evidence earns their cost.

## Defect standard

A defect is complete only when the change:

1. explains and removes the causal mechanism rather than masking a symptom;
2. restores the violated invariant at the narrowest correct seam;
3. covers every realistic in-scope path that shares that cause;
4. includes focused regression evidence that would catch the failure; and
5. verifies the corrected path and relevant surrounding behavior without
   introducing a related regression.

Do not expand into unrelated cleanup or every imaginable edge case. Do not
leave a known same-cause path broken merely to keep the diff superficially
small.

## Final simplification pass

Before completion, inspect the final solution and ask:

- Can any new file, type, interface, dependency, configuration value, state,
  branch, helper, or compatibility mechanism be removed?
- Can an existing local pattern be used directly?
- Is any code supporting an unrequested future instead of today's acceptance?
- Does indirection hide logic that would be clearer inline or locally scoped?
- Does every remaining moving part protect a requirement, invariant, contract,
  or testable risk?

Simplify when the answer exposes accidental complexity, then rerun affected
evidence. Do not perform aesthetic churn after the solution is already the
simplest complete fit.

## Primary-source basis

This bundle derives the standard from these engineering practices:

- Google Engineering Practices asks reviewers whether code is more complex
  than necessary, promotes small self-contained changes, and treats tests and
  readability as maintained code quality:
  [review guidance](https://google.github.io/eng-practices/review/reviewer/looking-for.html),
  [small CLs](https://google.github.io/eng-practices/review/developer/small-cls.html),
  and [review standard](https://google.github.io/eng-practices/review/reviewer/standard.html).
- Google SRE distinguishes essential from accidental complexity and treats
  simplicity as a prerequisite for reliable, operable systems:
  [Simplicity](https://sre.google/sre-book/simplicity/) and
  [Simplicity workbook](https://sre.google/workbook/simplicity/).
- Microsoft Engineering Fundamentals prioritizes precise, high-quality,
  incremental outcomes and minimizing work that does not contribute to the
  definition of done:
  [Code With Engineering Playbook](https://microsoft.github.io/code-with-engineering-playbook/)
  and [Developer Experience](https://microsoft.github.io/code-with-engineering-playbook/developer-experience/).
- Anthropic recommends simple, composable patterns, starting with the simplest
  solution and adding complexity only when it demonstrably improves outcomes:
  [Building effective agents](https://www.anthropic.com/engineering/building-effective-agents).
- OpenAI describes preparing the smallest tested fix and using scoped tasks,
  existing module patterns, and validation to preserve speed and control:
  [Engineering solutions](https://openai.com/business/solutions/engineering/)
  and [How OpenAI uses Codex](https://cdn.openai.com/pdf/6a2631dc-783e-479b-b1a4-af0cfbd38630/how-openai-uses-codex.pdf).
- Meta describes root-cause analysis as necessary to fix the cause rather than
  repeatedly treating symptoms:
  [Minesweeper root cause analysis](https://engineering.fb.com/2021/02/09/developer-tools/minesweeper/).

The source-backed principles are simplicity, small coherent changes, maintained
quality, focused verification, and root-cause correction. The exact complexity
budget and checklist above are Yo bundle policy derived from those principles.
