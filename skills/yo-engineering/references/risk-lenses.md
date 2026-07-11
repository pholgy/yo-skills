# Engineering risk lenses

Apply only the lenses triggered by the touched surface. For each selected lens,
record the key invariant, likely failure, and evidence that closes the risk.

| Lens | Trigger | Questions to answer | Strong evidence |
|---|---|---|---|
| Contract and compatibility | HTTP/RPC/GraphQL APIs, SDKs, CLI flags, events, webhooks, file formats | Who consumes it? What changes in source, wire, semantic, error, ordering, or default behavior? Can old and new versions coexist? | Consumer/contract tests, schema diff, compatibility matrix, version or deprecation plan |
| Data and migration | Schema, backfill, index, retention, cache format, destructive rewrite | What invariant protects each row/object? Is the operation online, bounded, restartable, idempotent, observable, and reversible? How are old shapes handled? | Production-scale rehearsal, lock/latency measurements, reconciliation query, checkpoints, rollback runbook |
| Security and privacy | Authn/authz, tenant boundaries, secrets, untrusted input, sensitive data, policy | What is the trust boundary and attacker capability? Is authorization checked at the resource? What data can leak, persist, or enter logs? | Negative authorization tests, threat cases, secret/log scan, audit trail, security control verification |
| Concurrency and distributed state | Async work, streams, queues, retries, cancellation, shared state, transactions | Who owns state? What ordering is required? Are retries idempotent? What happens on duplication, partial failure, cancellation, or stale work? | Deterministic interleaving tests, invariant assertions, idempotency test, failure injection, race-aware trace |
| Reliability and operability | Production boundary, background job, integration, deployment, fallback | How does it fail? Which user signal detects it? Can rollout pause and roll back? Are logs, metrics, traces, and alerts actionable? | Canary or smoke result, dashboard/trace, alert exercise, rollback test, user-visible verification |
| User experience and accessibility | UI, workflow, error state, interaction, metadata | Does the user understand state, progress, failure, and recovery? Is keyboard, focus, contrast, semantics, and responsive behavior preserved? | Browser flow, accessibility check, screenshots where visual state matters, error/recovery exercise |
| Maintainability and domain model | New abstraction, type/schema, ownership boundary, complex logic | Does the design match the codebase? Which invalid states remain representable? Is responsibility clear? Is complexity justified by a current need? | Focused design review, type/schema examples, tests of invariants, simpler alternative comparison |
| Performance and capacity | Latency, memory, throughput, bundle size, query/load optimization | What measured bottleneck matters to users or capacity? Is the comparison workload identical? What tradeoff moved elsewhere? | Reproducible before/after benchmark, profile, load test, resource and tail-latency comparison |
| Dependency and supply chain | New or upgraded package, runtime, service, toolchain | Is it necessary, maintained, licensed appropriately, secure, and affordable to operate? What transitive surface and upgrade path arrive with it? | Route to `yo-deps`; record provenance, dependency graph, advisory status, compatibility tests |

## Lens selection rules

- Select by affected behavior, not by file extension.
- Combine lenses when one change crosses boundaries; a webhook migration can
  require contract, data, security, concurrency, and operability analysis.
- Do not claim a lens is closed because a generic test suite is green. Match the
  evidence to the failure named by that lens.
- If the needed evidence cannot be produced before release, state the residual
  risk and require an explicit decision at the correct tier.
