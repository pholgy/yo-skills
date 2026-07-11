# Mitigation decision guide

Choose from the incident's invariant and hazards. This is not a fixed ladder.

## Decision record

```markdown
Current harm / invariant:
Candidate action:
Hypothesis:
Scope / blast radius:
Expected user and system signal:
Propagation / observation delay:
Compatibility and data hazards:
Security / forensic hazards:
Reversibility and abort path:
Operator / peer check / authority:
Result and next decision:
```

## Common candidates and gates

| Candidate | Useful when | Gate before acting |
| --- | --- | --- |
| Feature flag or kill switch | Fault is isolated behind a tested control | Flag scope, dependencies, default, propagation, and data side effects are known |
| Credential revoke / session invalidation | Authority is compromised or abused | Replacement and derivative credentials considered; security evidence preserved as safely possible |
| Read-only or write quiescence | Writes may corrupt, duplicate, charge, or destroy data | Read behavior is safe; queued/in-flight writes and replay plan are known |
| Queue pause / consumer disable | Processing is harmful but durable retention exists | Retention, backlog growth, producer behavior, ordering, idempotency, and replay capacity are known |
| Rate limit / load shed | Overload threatens core service | Priority traffic and rejection semantics are defined; it will not amplify retries |
| Scale capacity | Saturation, not a logic fault, is causal | Quotas, warm-up, downstream capacity, cost, and thundering herd are bounded |
| Traffic shift / failover | Healthy isolated capacity exists | Data consistency, capacity, DNS/cache delay, residency, and failback are understood |
| Config revert | A config change correlates and old config remains valid | Schema/protocol compatibility and propagation are verified |
| Deploy rollback | Previous artifact remains compatible with current state | Migration, writes, queues, protocols, external side effects, and mixed versions pass |
| Narrow roll-forward | Rollback is unsafe and cause/fix is high confidence | Change is small, reviewed, testable, observable, and has containment/abort path |
| Disable integration / circuit break | A dependency is failing or harmful | Fallback semantics, data loss/retention, recovery, and customer impact are known |

## Stateful rollback questions

- Did the deployment change schema, serialized data, API/event contracts, feature
  ownership, queue payloads, indexes, or external side effects?
- Have new writes occurred that the previous version cannot read or preserve?
- Can old and new versions coexist during propagation?
- Does rollback lose data, duplicate payments/messages, orphan jobs, or violate
  ordering/idempotency?
- Is the old artifact and configuration still available, authentic, and runnable?
- What is the recovery point and reconciliation plan if rollback crosses state?

Any unsafe answer blocks a normal binary rollback. Contain writes or traffic and
choose a compatible forward or data-recovery plan.

## Security containment

For active compromise or exfiltration:

1. invoke the organization's security response and restricted channel;
2. stop compromised authority: revoke credentials, invalidate sessions/tokens,
   isolate principals/workloads, or block egress/indicators as authorized;
3. preserve volatile and durable evidence when it does not delay stopping harm;
4. rotate or replace through approved secret channels, never the incident chat;
5. scope identities, systems, persistence, lateral movement, actions, and data;
6. coordinate legal/privacy/compliance and notification duties through owners;
7. verify the old authority is rejected everywhere and malicious activity stops;
8. eradicate persistence and recover before resolving.

Restarting, redeploying, terminating, or rolling back can destroy volatile
evidence without revoking the compromised identity. Sequence containment with
security/forensics. If the attacker may monitor normal communications, use the
out-of-band plan.

## Data-integrity containment

- stop or isolate corrupting writes and automation;
- preserve database, object, stream, and queue state;
- verify backup/PITR availability before relying on it;
- identify earliest/latest affected records and downstream copies;
- prevent retries or consumers from multiplying corruption;
- design reconciliation, replay, deduplication, and customer correction;
- verify counts, invariants, samples, and downstream convergence before reopening.

Do not restore availability by serving known-corrupt data unless the authorized
business/safety decision explicitly prefers it and impact is communicated.

## Third-party dependency incident

- prove the dependency and affected path;
- use circuit breaking, cached/stale-safe data, alternate provider, or degraded
  mode only when semantics are understood;
- avoid retry storms and synchronized failover overload;
- record vendor incident state separately from your user impact;
- verify your service after the provider reports recovery;
- retain ownership of customer communication and recovery proof.
