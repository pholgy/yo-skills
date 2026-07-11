# Artifact selection and lifecycle

## Artifact decision tree

1. Is the user asking only for analysis or comparison? Keep it in chat unless they ask for a file.
2. Does a proposed change need multi-stakeholder or approach-level review? Use the repository's design doc/RFC/proposal process.
3. Has one architecturally significant decision been made whose rationale should outlive the implementation? Record an ADR.
4. Are both true? Keep the proposal and each significant decision separate but cross-linked.
5. Is the content mostly tasks, milestones, or status? Put it in the implementation plan/tracker instead.

## Significance test for an ADR

Record a decision when several of these hold:

- it affects multiple components, teams, or future changes;
- reversal is expensive, coordinated, lossy, or contract-breaking;
- quality attributes trade off materially;
- multiple viable options prompted real deliberation;
- the choice establishes a policy, platform, protocol, data, or trust model;
- future incidents or migrations will need the rationale;
- the decision deviates from an established standard.

Do not record every local library call, naming choice, configuration default, or implementation detail.

## Compact alternative matrix

```markdown
| Driver | Option A | Option B | Status quo | Evidence / uncertainty |
|---|---|---|---|---|
| Compatibility | | | | |
| Failure/recovery | | | | |
| Security/privacy | | | | |
| Performance/cost | | | | |
| Operability | | | | |
| Change/maintenance cost | | | | |
```

Use only relevant drivers. Qualitative judgments should name the evidence and tradeoff; a numeric total is not objective merely because it contains numbers.

## Quality scenario shape

```markdown
Given <source and operating state>,
when <stimulus/failure/attack/change> occurs,
the system <response>,
measured by <observable threshold or invariant>.
```

Examples:

- During a rolling deploy with old and new workers, every accepted event is processed exactly once from the user's perspective, and rollback does not make new messages unreadable.
- If the primary provider times out, the request fails within the agreed latency budget, emits a retryable domain error, and records a correlated operational signal without exposing secrets.

## ADR status and change rules

Common statuses include Proposed, Accepted, Rejected, Deprecated, and Superseded. Follow local vocabulary.

- **Before acceptance:** edit freely as review changes the proposal.
- **After acceptance:** preserve the decision and rationale. Update status/supersession links visibly.
- **Decision reversal:** create a new record, link both directions, and explain what changed.
- **Factual correction:** correct transparently without pretending a new architectural decision occurred.
- **Retrospective capture:** label it retrospective and distinguish documentary evidence from memory/inference.

Version control already preserves text history; the rule exists to prevent silent historical revision, not to force a new ADR for punctuation or a repaired URL.

## Design review questions

- Do requirements and constraints come from verified current behavior?
- Which option best satisfies the highest-priority scenarios, and what does it sacrifice?
- Which decision is a sensitivity point where a small change has a large quality effect?
- What fails during partial rollout, rollback, dependency outage, overload, or malicious input?
- What persistent/in-flight state crosses versions?
- What operator/user evidence distinguishes success, degradation, and failure?
- What assumption would invalidate the choice, and when should it be revisited?
