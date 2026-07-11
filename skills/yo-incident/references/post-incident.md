# Post-incident review

Use the organization's template and storage when available. Do not automatically
create or publish this artifact.

## Suggested structure

```markdown
# <factual incident title>

Status / owner / reviewers:
Incident ID / severity scheme:
Impact window and detection window:

## Executive summary
What users experienced, duration, scope, and mitigation/recovery.

## Impact
User, business, data, security, privacy, financial, and safety effects.
State known estimates and confidence; avoid unsupported precision.

## Detection and response
How detected, declaration delay, role setup, communication, mitigations,
recovery criteria, and time to contain/recover.

## Timeline
Cleaned factual timeline linked to the source record and evidence.

## Trigger and causal analysis
Trigger, contributing technical/organizational conditions, propagation,
detection gaps, mitigation gaps, and why safeguards did not prevent impact.

## What helped / hindered / where we were fortunate
System and process facts, not judgments about people.

## Recovery and residual risk
Permanent fix status, temporary deviations, data reconciliation, security
eradication, monitoring, and rollback/removal work.

## Action items
Acceptance condition | type | priority | owner | tracker | due/review date
```

## Quality gate

- impact and timelines distinguish confirmed facts, estimates, and unknowns;
- customer or personal data is redacted and access is appropriate;
- causal analysis goes beyond the triggering change and avoids "human error";
- response analysis covers detection, coordination, mitigation, communication,
  recovery, and handoff—not only the product bug;
- action items are concrete, testable, proportionate, owned, prioritized under the
  organization's scheme, and tracked;
- temporary flags, freezes, overrides, credentials, capacity, or monitoring have
  explicit restoration/removal work;
- the permanent fix and regression proof are not confused with the mitigation;
- reviewers include the relevant service and specialist owners;
- publication audience and external wording are approved.

## Action-item types

- **prevent** - remove or reduce the initiating failure mode;
- **detect** - shorten detection or improve impact classification;
- **mitigate** - reduce blast radius or time to containment;
- **recover** - improve restoration, reconciliation, or rollback safety;
- **coordinate/communicate** - improve command, handoff, or stakeholder flow;
- **investigate** - time-bounded work needed before a durable decision.

Avoid vague items such as "improve monitoring" or "be more careful." Every item
needs a verifiable end state. If the correct owner is unknown, assign an owner to
resolve ownership by a date instead of leaving it orphaned.

## Follow-through

Use `yo-fix-loop` to reconcile action items and `yo-test-coverage` for regression
proof. Review overdue items and repeated incidents. Closing the post-incident
document is not the same as completing its corrective work.
