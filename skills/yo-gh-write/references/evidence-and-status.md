# Evidence and status templates — yo-gh-write

Put the verdict before the logs. Bind each claim to the commit, command, and observed result. Curate evidence for decision-making; do not paste an entire terminal session.

## Contents

- [Verification rules](#verification-rules)
- [PASS](#pass)
- [FAIL](#fail)
- [Mixed or blocked result](#mixed-or-blocked-result)
- [Progress update](#progress-update)
- [Fix-wave wrap-up](#fix-wave-wrap-up)
- [Premise or reproduction report](#premise-or-reproduction-report)
- [Evidence quality checks](#evidence-quality-checks)

## Verification rules

- Name the exact commit or deployed version checked.
- Distinguish focused tests, full gates, staging checks, and production checks.
- Include pass counts when the tool reports them.
- State skipped, flaky, unavailable, or unrun checks honestly.
- Keep raw output only when it helps reproduce or diagnose the result.
- Put long output in `<details>` and keep the verdict visible above it.

## PASS

````markdown
## Verification

**PASS** against `<SHA>`.

- `<command>` — <result>
- `<command>` — <result>
- <user-facing or integration check> — <result>

<details>
<summary>Relevant console output</summary>

```text
<curated output>
```

</details>
````

Omit the `<details>` block when the result lines are sufficient.

## FAIL

````markdown
## Verification

**FAIL** against `<SHA>`.

`<file:line>`: <specific defect and triggering condition>.

Reproduced with `<command>`:

<details>
<summary>Failure output</summary>

```text
<curated output>
```

</details>
````

Name the defect, not just the failing test. If the failure may be environmental, label that uncertainty and give the evidence.

## Mixed or blocked result

```markdown
## Verification

**PARTIAL** against `<SHA>`.

Passed:

- `<command>` — <result>

Not verified:

- `<command or flow>` — blocked by <specific condition>

This proves <bounded claim>; it does not yet prove <missing claim>.
```

## Progress update

```markdown
## Status

<One-sentence current state>

Completed:

- <work>

Remaining:

- <work>

Blocked by:

- <blocker and owner, or `Nothing`>

Next:

- <next concrete action>
```

Do not repeat unchanged history. Report movement, current risk, and the next decision.

## Fix-wave wrap-up

```markdown
Closed <N> findings across <N> commits.

Verified:

- `<command>` — <result>
- `<command>` — <result>

Deferred:

- #<issue> — <reason and owner>

Surprises:

- <new fact worth carrying forward, or omit this section>

Each addressed review thread has an individual reply with its fixing SHA and
verification result.
```

## Premise or reproduction report

```markdown
## Reproduction

**<CONFIRMED / NOT REPRODUCIBLE / EXPECTED BEHAVIOR / INCONCLUSIVE>** against
`<SHA>`.

Claim checked: <precise claim>.

Method:

1. <step>
2. <step>

Observed: <actual result>.

Evidence: `<command, log, trace, or file:line>`.

Next: <fix path, missing input, or no action>.
```

## Evidence quality checks

- Does the SHA match the diff or deployment being discussed?
- Does each command support the nearby claim?
- Can a reader distinguish rerun evidence from quoted implementer evidence?
- Are environmental failures separated from product defects?
- Are omitted checks and residual risks visible?
- Is the raw output short enough to help rather than obscure?

Standards basis: the bundle's independent-audit and premise-verification contracts, GitHub Markdown guidance, and Google change-description guidance. See `sources.md`.
