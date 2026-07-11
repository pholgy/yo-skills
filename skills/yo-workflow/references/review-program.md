# Review program and schemas

## System map

Capture only what the review needs:

```markdown
Actors/roles:
Entry points:
Trust/privilege boundaries:
State stores and durable messages:
External dependencies:
Critical assets/invariants:
Flows:
  - <name>: <source -> transformations -> sinks>
Deployment/config assumptions:
```

For each flow, include negative and temporal paths: denied, invalid, partial, retry, duplicate, delayed, concurrent, timeout, cancellation, rollback, recovery, and mixed-version behavior where relevant.

## Coverage matrix

Use a table, not an unbounded checklist:

| Flow/boundary | Risk question | Owner/pass | Status | Evidence/limit |
|---|---|---|---|---|
| Capture request -> ledger | Idempotency under retry | payments-state | covered | paths + focused test |
| Admin endpoint -> account data | Authorization | authz | blocked | production flag unavailable |

Statuses:

- **planned:** assigned but not reviewed;
- **covered:** traced with evidence adequate for the question;
- **partial:** some paths or environments remain;
- **blocked:** required evidence/tool/environment unavailable;
- **out of scope:** explicitly excluded with reason.

Coverage is a claim about the declared question, not every possible defect in the files.

## Candidate ledger

```yaml
id: flow-risk-sequence
claim: concise possible defect
scenario: concrete input, state, order, and environment
path:
  - file:line and relevant transition
invariant: property allegedly violated
consequence: observable impact and affected actor
evidence:
  - source/test/config/trace with snapshot
unknowns:
  - fact that could change the result
origin: discovery pass identifier
```

Candidates omit a final severity and proposed fix until challenge. This reduces solution anchoring and keeps discovery focused on evidence.

## Challenge record

```yaml
candidate: stable ID
reachability: supported | defeated | unknown
invariant_test: supported | defeated | unknown
counterevidence:
  - guard, configuration, contract, test, or runtime fact
independent_evidence:
  - reproduction, alternate trace, or second source
disposition: confirmed | refuted | unresolved | out-of-scope | duplicate
attribution: introduced | pre-existing | unknown | not-applicable
confidence: high | medium | low
remaining_gap: next discriminating observation
```

Confidence never substitutes for disposition evidence. A high-severity hypothesis with missing reachability remains unresolved.

Use `attribution` only when the review target provides a meaningful comparison,
such as a base/head change or migration interval. Attribution never controls
admission: a pre-existing defect that is inside the declared snapshot and scope
is still `confirmed`. Use `out-of-scope` only for a boundary declared in the
review contract, not as a synonym for old code.

## Cross-partition synthesis questions

- Which component or invariant appeared in several partitions?
- Did two workers assume different configuration, versions, or ownership?
- Does a local guard preserve the end-to-end property after retries and partial failure?
- Are authn/authz decisions consistent across sync, async, admin, and recovery paths?
- Can old data/messages/clients reach new code during rollout or rollback?
- Are cleanup, audit, metrics, and alerts present on failure paths?
- Did any discovered boundary receive no owner?
- Is a finding actually one root cause with several symptoms?

## Completeness pass

The completeness reviewer receives the original scope, system map, coverage matrix, confirmed/unresolved list, and exclusions. It asks which important flow, risk, role, data state, or lifecycle phase lacks evidence. It does not infer that an unchecked cell is safe and does not invent findings without tracing them.

## Final finding

This is a snapshot-review contract, independent of change attribution. Admit a
finding only when the evidence supports all of:

1. a concrete reachable input, state, order, actor, and environment;
2. a precise location or path through the affected flow;
3. a violated requirement, invariant, trust boundary, or safety property;
4. an observable consequence and affected actor or system;
5. evidence that the defect exists at the reviewed snapshot; and
6. relevance to the declared review scope.

Do not require evidence that a particular change introduced the defect. When a
comparison exists, report attribution as separate metadata and use `unknown`
rather than guessing.

Severity describes demonstrated impact and reachability, not remediation order:

- **Critical:** reachable compromise, serious privacy/safety breach, material
  data loss/corruption, systemic outage, or comparable catastrophic invariant
  failure requiring urgent ownership;
- **High:** realistic severe correctness, authorization, integrity, availability,
  or compatibility failure across an important flow;
- **Medium:** bounded but meaningful behavior, reliability, operability, or
  defense-in-depth failure;
- **Low:** localized hardening, maintainability, diagnostics, or test weakness
  with limited direct impact.

Priority, owner, and deadline are separate operational decisions. Do not inflate
severity to force scheduling.

```markdown
[Severity] Title
Location/path: <file:line through affected flow>
Scenario: <reachable input/state/sequence>
Invariant: <violated requirement or property>
Consequence: <observable impact>
Evidence: <code/test/config/runtime proof at snapshot>
Scope: <affected flows and exclusions>
Attribution: <introduced | pre-existing | unknown | not-applicable>
```

Keep unresolved risks separate so implementers do not treat hypotheses as accepted work items.
